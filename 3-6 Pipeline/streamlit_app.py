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
#print(graph_data)

st.video("https://d1io3yog0oux5.cloudfront.net/_2199c089e968c5816a59e11eeedd0b5e/hostessbrands/db/871/8254/video_mp4/hostess-home.mp4")

st.title("Twinkies are Forever")
st.text("Hostess Brands Inc (TWNK) daily closing stock price (US $)")
st.line_chart(graph_data.rename(columns={'Date':'index'}).set_index('index'))

st.button('Invest!')