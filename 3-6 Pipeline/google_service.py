from main import get_data
import gspread

def save_data():
    data = get_data()
    gc = gspread.service_account(filename="3-6 Pipeline/data/service_account.json")
    wks = gc.open("pipeline-data").sheet1
    wks.append_row([data["date"],
                    data["close"]])
save_data()