# MS_policing_bw.csv

**Mississippi Traffic Stops by Police 2013-2016**

Data from https://openpolicing.stanford.edu

For the purpose of this tutorial I made the following changes:

- Selected Black, White, and unknown (empty string: "") "driver_race" only.
- Kept only the following columns "id", "state", "stop_date", "county_name", "county_fips", "police_department", "driver_gender", "driver_age_raw", "driver_race",  "violation_raw", "officer_id"
- renamed "driver_age_raw" to "driver_birthdate"
