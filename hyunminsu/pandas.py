import pandas as pd
import urllib.request
import json
import ssl
from pandas.io.json import json_normalize

json_str=""
# 256000

key = 'f48b2f6ad8bb4380b591'
page = 1
url = "https://openapi.foodsafetykorea.go.kr/api/"+key+"/C005/json/"+str(page)+"/"+str(page+999)
response = urllib.request.urlopen(url)
temp = response.read().decode("utf-8")
json_str = json.loads(temp)
json_str
df=json_normalize(json_str['C005']['row'])

result = df.to_csv('result.csv', index=False)

while page<254000:
  url = "https://openapi.foodsafetykorea.go.kr/api/"+key+"/C005/json/"+str(page)+"/"+str(page+999)
  response = urllib.request.urlopen(url)
  page+=1000
  temp_str = response.read().decode("utf-8")
  json_str = json.loads(temp_str)
  df=json_normalize(json_str['C005']['row'])
  df.to_csv("result.csv", mode="a", header=False, index=False)

pd.read_csv('result.csv')
