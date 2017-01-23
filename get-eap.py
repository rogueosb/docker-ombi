#!/usr/bin/python2.7
import sys
import urllib
import urllib2
import json

apiurl = "https://ci.appveyor.com/api/projects/tidusjar/requestplex"
headers = {"Content-Type":"application/json"}

request = urllib2.Request(apiurl + "/history?recordsNumber=10&branch=eap")

for key,value in headers.items():
  request.add_header(key,value)

response = urllib2.urlopen(request)

json1 = json.loads(response.read())

for build in json1["builds"]:
  if build["status"] == "success":
    request = urllib2.Request(apiurl + "/build/" + str(build["version"]))
    json2 = json.loads(urllib2.urlopen(request).read())
    with open('/tmp/Ombi.zip','wb') as f:
      f.write(urllib2.urlopen("https://ci.appveyor.com/api/buildjobs/" + json2["build"]["jobs"][0]["jobId"] + "/artifacts/Ombi.zip").read())
      f.close()
    break
