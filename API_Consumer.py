from time import sleep
import json 
from kafka import KafkaProducer
from json import loads
from kafka import KafkaConsumer
from flask import Flask
from kafka import KafkaProducer
from flask import Flask,request,jsonify
import json
producer = KafkaProducer(bootstrap_servers=['localhost:9092'])#,value_serializer=lambda x: json.dumps(x).encode('utf-8'))
app = Flask(__name__)
@app.route('/', methods=['POST'])
def nameRoute():

    #fetching the global response variable to manipulate inside the function
    global response

    #checking the request type we get from the app
    request_data = request.headers.get('Content-Type') #getting the response data
    request_data_1=request.json #converting it from json to key value pair
    producer.send("producer_1",json.dumps(request_data_1).encode("utf-8")) #sending the data to the kafka topic

    return request_data_1
    
if __name__ == '__main__':
    app.debug = True
    app.run(host="0.0.0.0")