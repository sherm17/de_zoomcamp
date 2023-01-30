-- Question 3. Count records
select count(*) from tripdata_2019_01
where lpep_pickup_datetime >= '2019-01-15' and lpep_dropoff_datetime < '2019-01-16'


-- Question 4. Largest trip for each day
select lpep_pickup_datetime::date from tripdata_2019_01
where trip_distance = (select max(trip_distance) from tripdata_2019_01)

-- Questiono 5. The number of passengers
select 
passenger_count as number_of_passengers,
count(*) as passenger_count
from tripdata_2019_01
where lpep_pickup_datetime::date = '2019-01-01' and passenger_count in (2,3)
group by passenger_count

-- Question 6. Largest tip
with astoria_pickups as (
	select *
	from tripdata_2019_01 t
	where t."PULocationID" in (7)
)

select 
	"DOLocationID",
	z."Zone"
from astoria_pickups a
inner join taxi_zone_lookup z
on a."DOLocationID" = z."LocationID"
where tip_amount in (
	select max(tip_amount) 
	from tripdata_2019_01
	where "PULocationID" = 7
)
