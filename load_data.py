import pandas as pd
from sqlalchemy import create_engine
from collections import Counter
import psycopg2
import io


def main():
    df = pd.read_csv('./ships_data/ships.csv')
    df_g_by_sid_and_sname = df.groupby(["SHIP_ID", "SHIPNAME"]).agg({'SHIP_ID': ['count']})
    n_of_idx_per_ship_id = Counter([idx[0] for idx in df_g_by_sid_and_sname.index.values]).most_common()

    list_of_ship_id_to_exclude = []
    for x in n_of_idx_per_ship_id:

        if x[1] > 1:
            list_of_ship_id_to_exclude.append(x[0])
    # we exclude ship ids which are related with more than 1 ship names as we think
    # that this is breaks relationship in data
    df = df[~df["SHIP_ID"].isin(list_of_ship_id_to_exclude)]
    # the correctness of this approach was already proved in jupyternotebook

    # convert DATETIME
    df = df.astype({'DATETIME': 'datetime64'})
    return df


def write(df):
    engine = create_engine('postgresql+psycopg2://marine:1234@127.0.0.1/marine')
    engine.connect()
    df.to_sql('observations', con=engine, if_exists='replace', chunksize=1000, method='multi')


def test():
    engine = create_engine('postgresql+psycopg2://marine:1234@127.0.0.1/marine')
    session = engine.connect()
    cursor = session.execute('SELECT COUNT(*) from "observations";')
    print(cursor.fetchall())
    session.close()


def to_sql(engine, df, table, if_exists='fail', sep='\t', encoding='utf8'):
    """
    Speeding up native pandas to sql
    :param engine:
    :param df:
    :param table:
    :param if_exists:
    :param sep:
    :param encoding:
    :return:
    """
    # Create Table
    df[:0].to_sql(table, engine, if_exists=if_exists)

    # Prepare data
    output = io.StringIO()
    df.to_csv(output, sep=sep, header=False, encoding=encoding)
    output.seek(0)

    # Insert data
    connection = engine.raw_connection()
    cursor = connection.cursor()
    cursor.copy_from(output, table, sep=sep, null='')
    connection.commit()
    cursor.close()


if __name__ == "__main__":
    # test()
    print('Reading dataset.\n')
    df = main()
    print('Writing dataset.\n')
    # write(df)
    engine = create_engine('postgresql+psycopg2://marine:1234@127.0.0.1/marine')
    to_sql(engine, df, 'observations', if_exists='replace')
    test()
