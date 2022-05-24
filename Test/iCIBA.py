#!/usr/bin/python3
#coding=utf-8
import json
import requests
def get_iciba_everyday():
	url = 'http://open.iciba.com/dsapi/'
	r = requests.get(url)
	return json.loads(r.text)
print(get_iciba_everyday())