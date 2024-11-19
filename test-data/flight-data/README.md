# Airline On-Time Performance Data 2008

The data has been downloaded from here <http://stat-computing.org/dataexpo/2009/> and split into much smaller files to be usable for the tests.

Additionally files for the meta data in JSON format have been created.

## Flights (csv)

1. 	Year -	1987-2008
2. 	Month -	1-12
3. 	DayofMonth -	1-31
4. 	DayOfWeek -	1 (Monday) - 7 (Sunday)
5. 	DepTime -	actual departure time (local, hhmm)
6. 	CRSDepTime -	scheduled departure time (local, hhmm)
7. 	ArrTime -	actual arrival time (local, hhmm)
8. 	CRSArrTime -	scheduled arrival time (local, hhmm)
9. 	UniqueCarrier -	unique carrier code
10. 	FlightNum - flight number
11. 	TailNum - plane tail number
12. 	ActualElapsedTime - in minutes
13. 	CRSElapsedTime -	in minutes
14. 	AirTime - in minutes
15. 	ArrDelay - arrival delay, in minutes
16. 	DepDelay - departure delay, in minutes
17. 	Origin - origin IATA airport code
18. 	Dest -	destination IATA airport code
19. 	Distance - in miles
20. 	TaxiIn - taxi in time, in minutes
21. 	TaxiOut - taxi out time in minutes
22. 	Cancelled - was the flight cancelled?
23. 	CancellationCode - reason for cancellation (A = carrier, B = weather, C = NAS, D = security)
24. 	Diverted - 1 = yes, 0 = no
25. 	CarrierDelay - in minutes
26. 	WeatherDelay - in minutes
27. 	NASDelay - in minutes
28. 	SecurityDelay - in minutes
29. 	LateAircraftDelay - in minutes

## Carriers (csv, json)

1. code - the carrier code
2. description - the carrier name / description

## Plane Data (csv, json)

1. tailnum - 
2. type -
3. manufacturer - 
4. issue_date -
5. model -
6. status - 
7. aircraft_type - 
8. engine_type -
9. year - 
