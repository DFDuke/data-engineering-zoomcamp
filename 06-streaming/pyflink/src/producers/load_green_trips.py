import csv
import json
from kafka import KafkaProducer
from time import time


def main():
    # Create a Kafka producer
    producer = KafkaProducer(
        bootstrap_servers='localhost:9092',
        value_serializer=lambda v: json.dumps(v).encode('utf-8')
    )
    
    topic_name = "green-trips"
    csv_file = 'data/green_tripdata_2019-10.csv'  # change to your CSV file path if needed

    fields = [
        'lpep_pickup_datetime',
        'lpep_dropoff_datetime',
        'PULocationID',
        'DOLocationID',
        'passenger_count',
        'trip_distance',
        'tip_amount']

    t0 = time()

    with open(csv_file, 'r', newline='', encoding='utf-8') as file:
        # reader = csv.DictReader(file, fieldnames=fields)
        reader = csv.DictReader(file)

        for row in reader:
            # Each row will be a dictionary keyed by the CSV headers
            # Send data to Kafka topic "green-data"
            producer.send(topic_name, value={k: row[k] for k in fields})
            # producer.send(topic_name, value=row)

    # Make sure any remaining messages are delivered
    producer.flush()
    producer.close()


    t1 = time()
    
    took = t1 - t0

    print(f'took {took:.2f} seconds')

if __name__ == "__main__":
    main()