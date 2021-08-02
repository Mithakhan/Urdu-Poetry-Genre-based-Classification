from flask import Flask, request, jsonify
import sys
import joblib
import traceback
import pandas as pd
import numpy as np
from urduhack.normalization import normalize
from urduhack.preprocessing import normalize_whitespace 
from urduhack.preprocessing import remove_accents

# Your API definition
app = Flask(__name__)
model = joblib.load("pipelined.joblib") # Loading model"
print(model)
with open("/home/manzur/Downloads/stopwords-ur.txt", 'r', encoding='utf8') as f:
    STOP_WORDS = f.read().replace("\n", " ")
def text_normalization(text: str):
    normalized_text = normalize(text)
    Normal_ws = normalize_whitespace(normalized_text)
    rm_accents = remove_accents(Normal_ws)
    rm_accents = rm_accents.replace('[', '')
    rm_accents = rm_accents.replace(']', '')
    rm_accents= rm_accents.replace("'", '')
    return rm_accents
    
def remove_stopwords(text: str):
    return " ".join(word for word in text.split() if word not in STOP_WORDS)

@app.route('/predict', methods=['POST'])
def predict():
  

    try:  

      data = request.get_json()[0]['Data']
      print("DATA IS: "+data)
      Data_input = text_normalization(data)
      sp_words = remove_stopwords(Data_input)
      prediction = model.predict([sp_words])
      print("pred: "+prediction)
      return jsonify ({"prediction": str(prediction)})
    except: 
        return jsonify({'trace': traceback.format_exc()})


if __name__ == '__main__':
    try:
        port = int(sys.argv[1]) # This is for a command-line input
    except:
        port = 12345 # If you don't provide any port the port will be set to 12345

    

    app.run(port=port, debug=True)