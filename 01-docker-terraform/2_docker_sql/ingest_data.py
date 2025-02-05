#!/usr/bin/env python
# coding: utf-8

import pandas as pd
from sqlalchemy import create_engine
from time import time
import argparse
import os


def main(params):

    user = params.user
    password = params.password
    host = params.host
    port = params.port
    db = params.db
    table_name = params.table_name
    url = params.url

    print('user:', user)
    print('password:', password)
    print('host:', host)
    print('port:', port)
    print('db:', db)
    print('table_name:', table_name)
    print('url:', url)


    # Set the csv file name based on the extension in the URL
    if url.endswith('.csv.gz'):
        csv_name = 'output.csv.gz'
    else:
        csv_name = 'output.csv'
    

    # Download the CSV
    os.system(f'wget {url} -O {csv_name}')


    # Create connection to Postgres
    engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')


    # Load zone data
    # df_zones = pd.read_csv('downloads/taxi_zone_lookup.csv')
    # df_zones.to_sql(name='zones', con=engine, if_exists='replace')


    # Load Green Taxi Data
    df = pd.read_csv(csv_name, nrows=100)


    # Convert datetime columns to timestamp
    df.lpep_pickup_datetime = pd.to_datetime(df.lpep_pickup_datetime)
    df.lpep_dropoff_datetime = pd.to_datetime(df.lpep_dropoff_datetime)


    # Create table with no data
    df.head(n=0).to_sql(name=table_name, con=engine, if_exists='replace')


    # Iterate and load table
    for df in pd.read_csv(csv_name, chunksize=100000):

        t_start = time()

        df.lpep_pickup_datetime = pd.to_datetime(df.lpep_pickup_datetime)
        df.lpep_dropoff_datetime = pd.to_datetime(df.lpep_dropoff_datetime)

        df.to_sql(name=table_name, con=engine, if_exists='append')

        t_end = time()

        print(f'inserted another chunk..., took {(t_end - t_start):.3f} second')



if __name__ == '__main__':

    parser = argparse.ArgumentParser(description='Ingest CSV data to Postgres')

    parser.add_argument('--user', help='user name for postgres')
    parser.add_argument('--password', help='password for postgres')
    parser.add_argument('--host', help='host for postgres')
    parser.add_argument('--port', help='port for postgres')
    parser.add_argument('--db', help='database name for postgres')
    parser.add_argument('--table_name', help='table name where we will write the results to')
    parser.add_argument('--url', help='url of the csv file')

    args = parser.parse_args()
        
    main(args)