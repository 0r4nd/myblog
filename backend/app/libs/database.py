


from .database_config import DataBaseConfig
"""
links:
    https://www.psycopg.org/psycopg3/docs/
    https://www.timescale.com/learn/building-python-apps-with-postgresql-and-psycopg3

"""
class DataBase:
    CONFIG = DataBaseConfig
    def __init__(self,
                 adapter = DataBaseConfig.DATABASE_ADAPTER,
                 url = DataBaseConfig.DATABASE_URL):
        self.adapter = adapter
        self.url = url

    def get(self, query, *format):
        with self.adapter.connect(self.url) as conn:
            with conn.cursor() as cur:
                cur.execute(query, format)
                values_list = cur.fetchall()
                if not values_list:
                    return
                keys = [key[0] for key in cur.description]
                return [dict(zip(keys,values)) for values in values_list]
    def fetch(self, query, *format):
        with self.adapter.connect(self.url) as conn:
            with conn.cursor() as cur:
                cur.execute(query, format)
                return cur.fetchall()

    def getone(self, query, *format):
        with self.adapter.connect(self.url) as conn:
            with conn.cursor() as cur:
                cur.execute(query, format)
                values = cur.fetchone()
                if not values:
                    return
                keys = [key[0] for key in cur.description]
                return dict(zip(keys,values))
    def fetchone(self, query, *format):
        with self.adapter.connect(self.url) as conn:
            with conn.cursor() as cur:
                cur.execute(query, format)
                return cur.fetchone()

    def set(self, query, *format):
        with self.adapter.connect(self.url) as conn:
            with conn.cursor() as cur:
                cur.execute(query, format)
                conn.commit()
