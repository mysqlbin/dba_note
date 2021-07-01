

E:\github\mysql-5.7.26\include\my_base.h

/* The following is parameter to ha_rkey() how to use key */

/*
  We define a complete-field prefix of a key value as a prefix where
  the last included field in the prefix contains the full field, not
  just some bytes from the start of the field. A partial-field prefix
  is allowed to contain only a few first bytes from the last included
  field.

  Below HA_READ_KEY_EXACT, ..., HA_READ_BEFORE_KEY can take a
  complete-field prefix of a key value as the search
  key. HA_READ_PREFIX and HA_READ_PREFIX_LAST could also take a
  partial-field prefix, but currently (4.0.10) they are only used with
  complete-field prefixes. MySQL uses a padding trick to implement
  LIKE 'abc%' queries.

  NOTE that in InnoDB HA_READ_PREFIX_LAST will NOT work with a
  partial-field prefix because InnoDB currently strips spaces from the
  end of varchar fields!
*/

enum ha_rkey_function {
  HA_READ_KEY_EXACT,              /* Find first record else error */
  HA_READ_KEY_OR_NEXT,            /* Record or next record */
  HA_READ_KEY_OR_PREV,            /* Record or previous */
  HA_READ_AFTER_KEY,              /* Find next rec. after key-record */
  HA_READ_BEFORE_KEY,             /* Find next rec. before key-record */
  HA_READ_PREFIX,                 /* Key which as same prefix */
  HA_READ_PREFIX_LAST,            /* Last key with the same prefix */
  HA_READ_PREFIX_LAST_OR_PREV,    /* Last or prev key with the same prefix */
  HA_READ_MBR_CONTAIN,            /* Minimum Bounding Rectangle contains */
  HA_READ_MBR_INTERSECT,          /* Minimum Bounding Rectangle intersect */
  HA_READ_MBR_WITHIN,             /* Minimum Bounding Rectangle within */
  HA_READ_MBR_DISJOINT,           /* Minimum Bounding Rectangle disjoint */
  HA_READ_MBR_EQUAL,              /* Minimum Bounding Rectangle equal */
  HA_READ_INVALID= -1             /* Invalid enumeration value, always last. */
};
