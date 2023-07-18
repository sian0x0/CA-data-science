import gspread
import pandas as pd
import numpy as np
import streamlit as st

def get_data():
    gc = gspread.service_account(filename="/home/sian/Documents/Code Academy/Code/3-6 Pipeline/data/service_account.json")
    wks = gc.open("pipeline-data").sheet1
    dataframe = pd.DataFrame(wks.get_all_records())
    return dataframe
graph_data = get_data()

print(graph_data)

st.line_chart(graph_data.rename(columns={'Date':'index'}).set_index('index'))
st.line_chart(graph_data)