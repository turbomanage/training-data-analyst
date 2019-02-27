# This query does the same preprocessing as the Dataflow job
# in the feateng notebook. Run it then export the results
# to a CSV file. Change the divisor and remainder in the MOD
# function to get training (0) or validation (1) data for 
# EVERY_N rows.

CREATE OR REPLACE TABLE `cpb100-151023.taxifare.valid_200k` AS
SELECT
  (tolls_amount + fare_amount) AS fare_amount,
  FORMAT_DATE ("%a", DATE (pickup_datetime)) AS dayofweek,
  EXTRACT(HOUR FROM pickup_datetime) AS hourofday,
  pickup_longitude AS pickuplon,
  pickup_latitude AS pickuplat,
  dropoff_longitude AS dropofflon,
  dropoff_latitude AS dropofflat,
  CONCAT(CAST(passenger_count AS STRING), ".0") AS passengers,
  "key" as key
FROM
  `nyc-tlc.yellow.trips` 
WHERE
  trip_distance > 0
  AND fare_amount >= 2.5
  AND pickup_longitude > -78
  AND pickup_longitude < -70
  AND dropoff_longitude > -78
  AND dropoff_longitude < -70
  AND pickup_latitude > 37
  AND pickup_latitude < 45
  AND dropoff_latitude > 37
  AND dropoff_latitude < 45
  AND passenger_count > 0
  AND MOD(ABS(FARM_FINGERPRINT(STRING(pickup_datetime))), 5000) = 0
