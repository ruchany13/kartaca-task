from flask import Flask, jsonify
from pymongo import MongoClient

app = Flask(__name__)
client = MongoClient('mongodb://mongo1:27017,mongo2:27017,mongo3:27017/?replicaSet=dbrs')
db = client["city_db"]



@app.route('/')
def index():
    return 'Merhaba Python!'

@app.route('/staj')
def getdata():

    _city = db.city_tb.find()
    city = [{"name": animal["name"]} for animal in _city]
    return jsonify({"city": city})
    


app.run(host='0.0.0.0', port=5000)