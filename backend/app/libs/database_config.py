
import os
import psycopg
from pathlib import Path
from dotenv import load_dotenv

env_path = Path('.') / '.env'
load_dotenv(dotenv_path=env_path)


class DataBaseConfig:
    PROJECT_NAME = "test"
    PROJECT_VERSION = "1.0.0"
    POSTGRES_USER = os.getenv("POSTGRES_USER")
    POSTGRES_PASSWORD = os.getenv("POSTGRES_PASSWORD")
    POSTGRES_SERVER = os.getenv("POSTGRES_SERVER","localhost") # hostname
    POSTGRES_PORT = os.getenv("POSTGRES_PORT",5432)
    POSTGRES_DB = os.getenv("POSTGRES_DB",POSTGRES_USER)

    DATABASE_TIMEZONE = os.getenv("TZ")
    DATABASE_ADAPTER = psycopg # postgres adapter

    # postgresql://[user[:password]@][netloc][:port][/dbname][?param1=value1&...]
    DATABASE_URL = f"postgresql://{POSTGRES_USER}:{POSTGRES_PASSWORD}@{POSTGRES_SERVER}:{POSTGRES_PORT}/{POSTGRES_DB}"
