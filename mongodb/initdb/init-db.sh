#!/bin/bash

mongo <<< EOF
db = db.getSiblingDB("city_db");
db.city_tb.drop();

db.city_tb.insertMany([
    {
        "il": "Ankara",
        "nufüs" : "5.000.000"
    },
    {
        "il": "İstanbul",
        "nüfus": "15.460.000"
    },
    {
        "il": "Yalova",
        "nüfus": "121.479"
    },
]);

EOF