
/**
  This class represents abstract time zone and provides 
  basic interface for MYSQL_TIME <-> my_time_t conversion.
  Actual time zones which are specified by DB, or via offset 
  or use system functions are its descendants.
*/
class Time_zone: public Sql_alloc 
{
public:
  Time_zone() {}                              /* Remove gcc warning */
  /**
    Converts local time in broken down MYSQL_TIME representation to 
    my_time_t (UTC seconds since Epoch) represenation.
    Returns 0 in case of error. Sets in_dst_time_gap to true if date provided
    falls into spring time-gap (or lefts it untouched otherwise).
  */
  virtual my_time_t TIME_to_gmt_sec(const MYSQL_TIME *t, 
                                    my_bool *in_dst_time_gap) const = 0;
  /**
    Converts time in my_time_t representation to local time in
    broken down MYSQL_TIME representation.
  */
  virtual void   gmt_sec_to_TIME(MYSQL_TIME *tmp, my_time_t t) const = 0;
  /**
    Comverts "struct timeval" to local time in
    broken down MYSQL_TIME represendation.
  */
  void gmt_sec_to_TIME(MYSQL_TIME *tmp, struct timeval tv)
  {
    gmt_sec_to_TIME(tmp, (my_time_t) tv.tv_sec);
    tmp->second_part= tv.tv_usec;
  }
  /**
    Because of constness of String returned by get_name() time zone name 
    have to be already zeroended to be able to use String::ptr() instead
    of c_ptr().
  */
  virtual const String * get_name() const = 0;

  /** 
    We need this only for surpressing warnings, objects of this type are
    allocated on MEM_ROOT and should not require destruction.
  */
  virtual ~Time_zone() {};

protected:
  static inline void adjust_leap_second(MYSQL_TIME *t);
};






/*
  Converts time in my_time_t representation (seconds in UTC since Epoch) to
  broken down MYSQL_TIME representation in local time zone.

  SYNOPSIS
    gmt_sec_to_TIME()
      tmp          - pointer to structure for broken down represenatation
      sec_in_utc   - my_time_t value to be converted
      sp           - pointer to struct with time zone description

  TODO
    We can improve this function by creating joined array of transitions and
    leap corrections. This will require adding extra field to TRAN_TYPE_INFO
    for storing number of "extra" seconds to minute occured due to correction
    (60th and 61st second, look how we calculate them as "hit" in this
    function).
    Under realistic assumptions about frequency of transitions the same array
    can be used fot MYSQL_TIME -> my_time_t conversion. For this we need to
    implement tweaked binary search which will take into account that some
    MYSQL_TIME has two matching my_time_t ranges and some of them have none.
*/
static void
gmt_sec_to_TIME(MYSQL_TIME *tmp, my_time_t sec_in_utc, const TIME_ZONE_INFO *sp)
{
  const TRAN_TYPE_INFO *ttisp;
  const LS_INFO *lp;
  long  corr= 0;
  int   hit= 0;
  int   i;

  /*
    Find proper transition (and its local time type) for our sec_in_utc value.
    Funny but again by separating this step in function we receive code
    which very close to glibc's code. No wonder since they obviously use
    the same base and all steps are sensible.
  */
  ttisp= find_transition_type(sec_in_utc, sp);

  /*
    Let us find leap correction for our sec_in_utc value and number of extra
    secs to add to this minute.
    This loop is rarely used because most users will use time zones without
    leap seconds, and even in case when we have such time zone there won't
    be many iterations (we have about 22 corrections at this moment (2004)).
  */
  for ( i= sp->leapcnt; i-- > 0; )
  {
    lp= &sp->lsis[i];
    if (sec_in_utc >= lp->ls_trans)
    {
      if (sec_in_utc == lp->ls_trans)
      {
        hit= ((i == 0 && lp->ls_corr > 0) ||
              lp->ls_corr > sp->lsis[i - 1].ls_corr);
        if (hit)
        {
          while (i > 0 &&
                 sp->lsis[i].ls_trans == sp->lsis[i - 1].ls_trans + 1 &&
                 sp->lsis[i].ls_corr == sp->lsis[i - 1].ls_corr + 1)
          {
            hit++;
            i--;
          }
        }
      }
      corr= lp->ls_corr;
      break;
    }
  }

  sec_to_TIME(tmp, sec_in_utc, ttisp->tt_gmtoff - corr);

  tmp->second+= hit;
}



/*
  Instance of this class represents local time zone used on this system
  (specified by TZ environment variable or via any other system mechanism).
  It uses system functions (localtime_r, my_system_gmt_sec) for conversion
  and is always available. Because of this it is used by default - if there
  were no explicit time zone specified. On the other hand because of this
  conversion methods provided by this class is significantly slower and
  possibly less multi-threaded-friendly than corresponding Time_zone_db
  methods so the latter should be preffered there it is possible.
*/
class Time_zone_system : public Time_zone
{
public:
  Time_zone_system() {}                       /* Remove gcc warning */
  virtual my_time_t TIME_to_gmt_sec(const MYSQL_TIME *t,
                                    my_bool *in_dst_time_gap) const;
  virtual void gmt_sec_to_TIME(MYSQL_TIME *tmp, my_time_t t) const;
  virtual const String * get_name() const;
};




/*
  Instance of this class represents time zone which
  was specified as offset from UTC.
*/
class Time_zone_offset : public Time_zone
{
public:
  Time_zone_offset(long tz_offset_arg);
  virtual my_time_t TIME_to_gmt_sec(const MYSQL_TIME *t,
                                    my_bool *in_dst_time_gap) const;
  virtual void   gmt_sec_to_TIME(MYSQL_TIME *tmp, my_time_t t) const;
  virtual const String * get_name() const;
  /*
    This have to be public because we want to be able to access it from
    my_offset_tzs_get_key() function
  */
  long offset;
private:
  /* Extra reserve because of snprintf */
  char name_buff[7+16];
  String name;
};


/*
  Initializes object representing time zone described by its offset from UTC.

  SYNOPSIS
    Time_zone_offset()
      tz_offset_arg - offset from UTC in seconds.
                      Positive for direction to east.
*/
Time_zone_offset::Time_zone_offset(long tz_offset_arg):
  offset(tz_offset_arg)
{
  uint hours= abs((int)(offset / SECS_PER_HOUR));
  uint minutes= abs((int)(offset % SECS_PER_HOUR / SECS_PER_MIN));
  size_t length= my_snprintf(name_buff, sizeof(name_buff), "%s%02d:%02d",
                             (offset>=0) ? "+" : "-", hours, minutes);
  name.set(name_buff, length, &my_charset_latin1);
}


/* Return the `struct tm' representation of *TIMER in the local timezone.
   Use local time if USE_LOCALTIME is nonzero, UTC otherwise.  */
struct tm *
__tz_convert (const time_t *timer, int use_localtime, struct tm *tp)
{
  long int leap_correction;
  int leap_extra_secs;
  if (timer == NULL)
    {
      __set_errno (EINVAL);
      return NULL;
    }
  __libc_lock_lock (tzset_lock);
  /* Update internal database according to current TZ setting.
     POSIX.1 8.3.7.2 says that localtime_r is not required to set tzname.
     This is a good idea since this allows at least a bit more parallelism.  */
  tzset_internal (tp == &_tmbuf && use_localtime, 1);
  if (__use_tzfile)
    __tzfile_compute (*timer, use_localtime, &leap_correction,
              &leap_extra_secs, tp);
  else
    {
      if (! __offtime (timer, 0, tp))
    tp = NULL;
      else
    __tz_compute (*timer, tp, use_localtime);
      leap_correction = 0L;
      leap_extra_secs = 0;
    }
  if (tp)
    {
      if (! use_localtime)
    {
      tp->tm_isdst = 0;
      tp->tm_zone = "GMT";
      tp->tm_gmtoff = 0L;
    }
      if (__offtime (timer, tp->tm_gmtoff - leap_correction, tp))
        tp->tm_sec += leap_extra_secs;
      else
    tp = NULL;
    }
  __libc_lock_unlock (tzset_lock);
  return tp;
}
