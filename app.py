from flask import Flask,request
import json

app = Flask(_name_)
@app.route('/', methods=['POST'])
def process_json():
    content_type = request.headers.get('Content-Type')
    data = request.json
    with open('test.json','a') as f:
        f.write(json.dumps(data))
        
    return data     
if _name_ == '_main_':
    app.debug = True
    app.run(host="0.0.0.0",port=5001)


