import os
from flask import Flask, render_template, url_for, json, jsonify

app = Flask(__name__)

table = []
with open('events.json', 'r') as f:
    table = json.loads(f.read())

tasks = table


@app.route('/api', methods = ['GET'])
def getevents():
   return jsonify(tasks)


if __name__ == '__main__':
   app.run(port=8080)