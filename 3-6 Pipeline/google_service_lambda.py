import gspread

def save_data(event, context):
    gc = gspread.service_account(filename="3-6 Pipeline/data/service_account.json")
    wks = gc.open("pipeline-data").sheet1
    wks.append_row([event["responsePayload"]["date"],
                    event["responsePayload"]["close"]])