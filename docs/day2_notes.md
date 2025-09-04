# Query Results

## T1: Silver Businesses:
        - row count = 24
        - No Duplicates
        - 1% house_number parsed
## T2: Silver Opening hours
        - row count = 168
        - No empty values
        - businesses with <> 7 rows = none
- Sample normalized hours rows that show multiple ranges merged:

          business_id   weekday    hours_std
          2	          Mon        [07:00 - 18:00]
          2	          Tue        [09:00 - 18:00]
          2	          Wed        [08:00 - 19:00]
          2	          Thu        [08:00 - 20:00 | 11:00 - 14:00]
          2	          Fri        [07:00 - 20:00]
          2	          Sat        [07:00 - 17:00]
          2	          Sun        [09:00 - 20:00 | 11:00 - 16:00]

