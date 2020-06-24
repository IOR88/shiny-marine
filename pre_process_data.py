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
    df = pd.read_csv('./ships_data/ships.csv', usecols=COLUMNS)
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


def get_ship_types(df):
    """
    Return data frame of unique ship types
    :param df:
    :return:
    """
    return df.groupby(['SHIPTYPE', 'ship_type'], as_index=False).size()


def get_ships_names(df):
    """
    Return data frame of unique ship names
    :param df:
    :return:
    """
    return df.groupby(['SHIP_ID', 'SHIPNAME'], as_index=False).size()


RECORD_COLUMNS = ['LAT', 'LON', 'DESTINATION', 'SHIPTYPE', 'SHIP_ID',  'DATETIME']


def get_records(df):
    """
    Select only relevant columns and sort by date.
    :param df:
    :return:
    """
    df = df[RECORD_COLUMNS]
    return df


def __get_distance(x, y):
    pass


def get_observations(df, ships):
    """
    Here we plan to loop over each ship id dataset and find observations between which
    timedelta is around 30 minutes. Next we need to select longest one and save it.
    :param df:
    :param ships: list
    :return:
    """
    compare_lower_bound = pd.Timedelta(29, unit='m')
    compare_higher_bound = pd.Timedelta(31, unit='m')

    for ship_id in ships:
        print('Getting observations for {0}.\n'.format(ship_id))
        __df = df[(df.SHIP_ID == ship_id)]
        for idx, row in __df.iterrows():
            row = row
            __time_delta_mask = (compare_lower_bound <= (__df.DATETIME - row[6])) & \
                                ((__df.DATETIME - row[6]) <= compare_higher_bound)
            __row_idenity_mask = (__df.index == idx)
            __resulting_df = __df[__time_delta_mask | __row_idenity_mask]
    return


if __name__ == "__main__":
    df = main()
    df_ship_types = get_ship_types(df)
    df_ship_names = get_ships_names(df)
    df_records = get_records(df)
    df_observations = get_observations(df, map(lambda x: x[0], df_ship_names.index.values))
    pass
