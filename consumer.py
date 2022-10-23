import pandas as pd
from time import sleep
import json 
from kafka import KafkaProducer
from json import loads
from kafka import KafkaConsumer
from flask import Flask
from kafka import KafkaProducer
from flask import Flask,request,jsonify
import numpy
import json
import pickle
consumer=KafkaConsumer('producer_1',bootstrap_servers=['localhost:9092'])
# app = Flask(__name__)
# @app.route('/', methods=['GET'])
# def nameRoute():

    #fetching the global response variable to manipulate inside the function
    # global response
# clf_knn=pickle.load(open("knn.pkl","rb"))
clf_nb=pickle.load(open("nb.pkl","rb"))
clf_svm=pickle.load(open("svm.pkl","rb"))
#checking the request type we get from the app
for message in consumer:
    message = message.value
    # df=pd.DataFrame(json.loads(message),dict[0])
    # clf_knn.predict(df)
    # clf_nb.predict(df)
    # clf_svm.predict(df)
    a=json.loads(message)
    lst=json.loads(a["accelerometer"])
    print(lst)
    # return
    
# if __name__ == '__main__':
#     app.debug = True
#     app.run(host="0.0.0.0")