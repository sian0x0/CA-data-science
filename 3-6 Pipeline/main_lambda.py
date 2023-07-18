import urllib3
import json

def get_data_lambda(event, context):
    http = urllib3.PoolManager()
    url = "https://cloud.iexapis.com/stable/stock/twnk/previous?token=pk_db49a4c52b78487fa06729cb0647dc71"
    resp = http.request("GET", url)
    values = json.loads(resp.data)
    return values