db = db.getSiblingDB("city_db");
db.city_tb.drop();

db.city_tb.insertMany([
    {
        "name": "Ankara",
    },
    {
        "name": "İstanbul",
    },
    {
        "name": "Yalova",
    },
]);