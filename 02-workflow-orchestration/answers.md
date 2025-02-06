### Question 1 

Download and unzip given file. Review uncompressed file size.

``` bash
wget -qO- https://github.com/DataTalksClub/nyc-tlc-data/releases/download/yellow/yellow_tripdata_2020-12.csv.gz | gunzip > yellow_tripdata_2020-12.csv
ls -l yellow_tripdata_2020_12.csv
```

-rw-r--r-- 1 dduke dduke 134481400 Feb  5 01:48 yellow_tripdata_2020-12.csv


### Question 2

Map given values into definition of file. 

file: "{{inputs.taxi}}_tripdata_{{inputs.year}}-{{inputs.month}}.csv"
taxi = green
year = 2020
month = 04
file: "green_tripdata_2020-04.csv"


### Question 3
Trigger yellow backfill for 2020-01-01 through 2020-12-31.
Execute the following query to get count.

``` sql
SELECT  COUNT(*)
FROM    yellow_tripdata
WHERE   1=1
        AND filename IN 
		(
			'yellow_tripdata_2020-01.csv',
			'yellow_tripdata_2020-02.csv',
			'yellow_tripdata_2020-03.csv',
			'yellow_tripdata_2020-04.csv',
			'yellow_tripdata_2020-05.csv',
			'yellow_tripdata_2020-06.csv',
			'yellow_tripdata_2020-07.csv',
			'yellow_tripdata_2020-08.csv',
			'yellow_tripdata_2020-09.csv',
			'yellow_tripdata_2020-10.csv',
			'yellow_tripdata_2020-11.csv',
			'yellow_tripdata_2020-12.csv'
		);
```


### Question 4
Trigger green backfill for 2020-01-01 through 2020-12-31.
Execute the following query to get count.

``` sql
SELECT 	COUNT(*) 
FROM 	green_tripdata
WHERE 	1=1
	AND filename IN 
		(
			'green_tripdata_2020-01.csv',
			'green_tripdata_2020-02.csv',
			'green_tripdata_2020-03.csv',
			'green_tripdata_2020-04.csv',
			'green_tripdata_2020-05.csv',
			'green_tripdata_2020-06.csv',
			'green_tripdata_2020-07.csv',
			'green_tripdata_2020-08.csv',
			'green_tripdata_2020-09.csv',
			'green_tripdata_2020-10.csv',
			'green_tripdata_2020-11.csv',
			'green_tripdata_2020-12.csv'
		);
```


### Question 5

Trigger yellow backfill for 2021-03-01 through 2021-03-31.
Execute the following query to get count.

``` sql
SELECT  COUNT(*) 
FROM	yellow_tripdata
WHERE	1=1
	AND filename = 'yellow_tripdata_2021-03.csv';
```

### Question 6
Follow the example in the documentation. "A schedule that runs daily at midnight US Eastern time."
https://kestra.io/docs/workflow-components/triggers/schedule-trigger
