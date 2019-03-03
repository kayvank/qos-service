import requests
import json

with open('../src/test/resources/qos-telemetry.json') as json_file:
    json_data = json.load(json_file)

#url = 'http://dev-event-collector.us-east-1.elasticbeanstalk.com/event/endo'
##url = 'https://s.vevo.com/event/endo'
url = 'http://localhost:9000/event/endo'
headers = {'Accept' : 'application/json', 'Content-Type' : 'application/json'}
r = requests.post(url, data=json.dumps(json_data), headers=headers, verify=False)
print r.status_code
print r.text
