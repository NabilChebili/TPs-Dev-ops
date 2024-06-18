import os
from flask import Flask
from flask_cors import CORS
from datetime import datetime

# Create logs folder
os.mkdir('./logs')

app = Flask(__name__)
CORS(app)

@app.route('/')
def default():
    return {
        "time": str(datetime.now()),
        "environment": os.environ['ENVIRONMENT'],
        "hostname": os.uname()[1],
        "result": "root"
    }    

@app.route("/get/<name>")
def get(name):
    return {
        "time": str(datetime.now()),
        "environment": os.environ['ENVIRONMENT'],
        "hostname": os.uname()[1],
        "result": name
    }

@app.route("/write/<something>")
def write(something):
    print(something)
    with open('logs/my-messages.log', 'a') as the_file:
        the_file.write(f"{something}\n")
    return {
        "status": "ok"
    }