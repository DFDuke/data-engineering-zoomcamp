## Question 1. Understanding docker first run 
```bash
docker run -it --entrypoint=bash python:3.9
pip --version
```

## Question 2. Understanding Docker networking and docker-compose
Create docker-compose.yml in 1-docker-sql
```bash
cd 1-docker-terraform/question2/
docker compose up
```
Open http://localhost:8080/login?next=/
    Enter credentials...
        Email: pgadmin@pgadmin.com
        Password: pgadmin

Create connections to postgres using hostname and ports given.


##  Prepare Postgres
Download csv files and unzip
```bash
wget https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2019-10.csv.gz
gzip -d green_tripdata_2019-10.csv.gz
mv green_tripdata_2019-10.csv downloads/green_tripdata_2019-10.csv

wget https://github.com/DataTalksClub/nyc-tlc-data/releases/download/misc/taxi_zone_lookup.csv
mv taxi_zone_lookup.csv downloads/taxi_zone_lookup.csv
```
docker network create pg-network

docker run -it \
  -e POSTGRES_USER="root" \
  -e POSTGRES_PASSWORD="root" \
  -e POSTGRES_DB="ny_taxi" \
  -v $(pwd)/01-docker-terraform/2_docker_sql/ny_taxi_postgres_data:/var/lib/postgresql/data \
  -p 5432:5432 \
  --network=pg-network \
  --name pg-database \
  postgres:13

  docker run -it \
  -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" \
  -e PGADMIN_DEFAULT_PASSWORD="root" \
  -p 8080:80 \
  --network=pg-network \
  --name pgadmin-2 \
  dpage/pgadmin4

  docker run -it   \
  --network pg-network \
    taxi_ingest:v001 \
        --user=root \
        --password=root \
        --host=pgdatabase-1 \
        --port=5432 \
        --db=ny_taxi \
        --table_name=green_taxi_data \
        --url=${URL}

## Question 3. Trip Segmentation Count


## Question 4. Longest trip for each day


## Question 5. Three biggest pickup zones


## Question 6. Largest tip


## Terraform


## Question 7. Terraform Workflow

