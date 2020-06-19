import pandas as pd
import sqlalchemy
from collections import Counter

def create_database():
  pass
  
def create_schema_and_models():
  pass
  
def insert_data():
  pass

ALL_COLUMNS = ['LAT', 'LON', 'SPEED', 'COURSE', 'HEADING', 'ELAPSED', 'DESTINATION',
               'FLAG', 'LENGTH', 'ROT', 'SHIPNAME', 'SHIPTYPE', 'SHIP_ID', 'WIDTH',
               'L_FORE', 'W_LEFT', 'DWT', 'GT_SHIPTYPE', 'LEGEND', 'DATETIME', 'PORT',
               'date', 'week_nb', 'ship_type', 'port', 'is_parked']

COLUMNS = ['LAT', 'LON', 'DESTINATION', 'SHIPNAME', 'SHIPTYPE', 'SHIP_ID', 
           'DATETIME', 'date', 'ship_type']
def main():
  df = pd.read_csv('./ships_data/ships.csv', usecols=ALL_COLUMNS)
  df_g_by_sid_and_sname = df.groupby(["SHIP_ID", "SHIPNAME"]).agg({'SHIP_ID': ['count']})
  n_of_idx_per_ship_id = Counter([idx[0] for idx in df_g_by_sid_and_sname.index.values]).most_common()

  list_of_ship_id_to_exclude = []
  for x in n_of_idx_per_ship_id:
      
      if x[1] > 1:
          counter += 1
          list_of_ship_id_to_exclude.append(x[0])
  # we exclude ship ids which are related with more than 1 ship names as we think
  # that this is breaks relationship in data
  df = df[~df["SHIP_ID"].isin(list_of_ship_id_to_exclude)]
  # the correctness of this approach was already proved in jupyternotebook
  return df
  

def get_ship_types(df):
  pass
  
def get_ships_names(df):
  pass
  
def get_records(df):
  pass

if __name__ == "__main__":
  df = main()
