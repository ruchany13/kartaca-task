from flask import Flask, jsonify
from pymongo import MongoClient
import random

app = Flask(__name__)
client = MongoClient('mongodb://mongo1:27017,mongo2:27017,mongo3:27017/?replicaSet=dbrs')
db = client["city_db"]



@app.route('/')
def index():
    return 'Merhaba Python!'

@app.route('/staj')
def getdata():

    _city = db.city_tb.find()
    city = [{"il": animal["il"]} for animal in _city]
    nufus = [{"nufüs": animal["nufüs"]} for animal in _city]
    choosen = random.choices(city)
    _nufus = db.city_tb.find({"il":choosen})
    nufus = ({"nufüs": _nufus["nufus"]}) 
    return jsonify({"nufüs":nufus})
    #"choosen":choosen,


app.run(host='0.0.0.0', port=5000)