
from fastapi import FastAPI, APIRouter, Response, status
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
from fastapi import HTTPException

import logging

# database
from .libs.database import DataBase
from .libs.schemas import SchemaUserCreate, SchemaUserLogin

from .libs.auth import Auth

from datetime import datetime, timezone
from zoneinfo import ZoneInfo

import os
from pathlib import Path
from dotenv import load_dotenv

env_path = Path('.') / '.env'
load_dotenv(dotenv_path=env_path)


# logging (do not use in production)
logger = logging.getLogger('uvicorn.error')
logger.setLevel(logging.DEBUG)

# FastAPI, DataBase, authentification instances
app = FastAPI(
    title=os.getenv("API_TITLE",""),
    description=os.getenv("API_DESCRIPTION","")
)
db = DataBase()
auth = Auth()


origins = ["*"]
#origins = [
#    "http://localhost:3000",
#    "http://127.0.0.1:3000",
#    "https://localhost:3000",
#    "https://127.0.0.1:3000",
#    os.getenv("API_HOST")+":3000",
#    "https://"+os.getenv("API_HOST")+":3000",
#]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"]
)


@app.get('/')
async def read_root():
    #logger.debug(DataBase.CONFIG.DATABASE_URL)
    #logger.debug(raw_sql_query("SELECT * FROM posts;"))
    return Response("Server is running.")


@app.get('/blog/api')
async def blog_api():
    return Response("Blog API Server is running.")

@app.get('/blog/api/posts')
async def get_blog_api_posts():
    query = """
    SELECT posts.id, title, cover, category, summary, published_at, username
    FROM posts
    LEFT JOIN users ON (users.id = posts.user_id)
    WHERE is_published = true
    ORDER BY published_at DESC
    """
    try:
        result = db.get(query)
    except:
        raise HTTPException(status_code=500, detail={"500":"Internal Server Error"})
    return result

@app.get('/blog/api/posts/{id}')
async def get_blog_api_posts_id(id:str):
    query = """
    SELECT posts.id, title, cover, category, summary, content, published_at, updated_at, username
    FROM posts
    LEFT JOIN users ON (users.id = posts.user_id)
    WHERE posts.id = %s
    ORDER BY published_at DESC
    """
    try:
        result = db.getone(query, id)
    except:
        raise HTTPException(status_code=500, detail={"500":"Internal Server Error"})
    return result








def get_user_in_db(auth, username, password):
    errors = {}
    try:
        user = db.getone("SELECT * FROM users WHERE LOWER(username)=LOWER(%s)", username)
    except Exception as e:
        errors["500"] = "Internal Server Error"
        raise HTTPException(status_code=500, detail=errors)

    # is user exist ?
    if not user:
        errors["username"] = "Username does not exist"
        raise HTTPException(status_code=400, detail=errors)
    # is password valid ?
    if not auth.verify_password(password, user['hashed_password']):
        errors["password"] = "Password is wrong"
        raise HTTPException(status_code=400, detail=errors)

    return user




@app.post('/login')
async def post_login(schema: SchemaUserLogin, response: Response):
    errors = {}

    if not schema.is_valid_username():
        errors["username"] = schema.error
    if not schema.is_valid_password():
        errors["password"] = schema.error
    if len(errors) > 0:
        raise HTTPException(status_code=400, detail=errors)

    # is user exist ?
    user = get_user_in_db(auth, schema.username, schema.password)

    # token creation
    # https://www.iana.org/assignments/jwt/jwt.xhtml
    payload  = {
        "iss" : "",        # créateur (issuer) du jeton
        "sub": user['id'], # sujet (subject) du jeton
        "aud": "",         # audience du jeton
        #"exp": "",        # date d'expiration du jeton (peuplé dans la fonction plus bas)
        "nbf": "",         # date avant laquelle le jeton ne doit pas être considéré comme valide (not before)
        "iat": "",         # date à laquelle a été créé le jeton (issued at)
        "jti": "",         # identifiant unique du jeton (JWT ID)
        "username": user['username'],
        "role": user['role'],
    }
    access_token = auth.create_access_token(payload)
    refresh_token = auth.create_refresh_token(payload)

    # https://stackoverflow.com/questions/64139023/how-to-set-cookies-with-fastapi-for-cross-origin-requests
    response.set_cookie(key='refresh_token', value=refresh_token, httponly=True)
    return {
        "access_token": access_token,
        #"refresh_token": refresh_token,
    }


@app.post('/signup')
async def post_signup(schema: SchemaUserCreate):
    errors = {}
    if not schema.is_valid_username():
        errors["username"] = schema.error
    if not schema.is_valid_email():
        errors["email"] = schema.error
    if not schema.is_valid_password():
        errors["password"] = schema.error
    if len(errors) > 0:
        raise HTTPException(status_code=400, detail=errors)

    # is user exist ?
    if db.fetchone("SELECT 1 FROM users WHERE LOWER(username)=LOWER(%s)", schema.username):
        errors["username"] = "Username already exist!"
        raise HTTPException(status_code=400, detail=errors)

    # insert the new user into the table
    db.set("""INSERT INTO users (id, role, username, email,
                                 registered_at, last_login_at,
                                 hashed_password, activation_key)
                VALUES (DEFAULT, DEFAULT, %s, %s, %s, %s, %s, %s);""",
            schema.username,
            schema.email,
            datetime.now(ZoneInfo(db.CONFIG.DATABASE_TIMEZONE)),
            datetime.now(ZoneInfo(db.CONFIG.DATABASE_TIMEZONE)),
            auth.get_password_hash(schema.password),
            auth.create_activation_key())
    return schema


@app.get('/blog/posts', status_code = status.HTTP_200_OK)
async def get_posts():
    query = """
    SELECT posts.id, title, cover, category, summary, published_at, username
    FROM posts
    LEFT JOIN users ON (users.id = posts.user_id)
    WHERE is_published = true
    ORDER BY published_at DESC
    """
    try:
        result = db.get(query)
    except:
        raise HTTPException(status_code=500, detail={"500":"Internal Server Error"})
    return result



@app.get('/blog/posts/{id}')
async def get_posts_id(id:str):
    query = """
    SELECT posts.id, title, cover, category, summary, content, published_at, updated_at, username
    FROM posts
    LEFT JOIN users ON (users.id = posts.user_id)
    WHERE posts.id = %s
    ORDER BY published_at DESC
    """
    try:
        result = db.getone(query, id)
    except:
        raise HTTPException(status_code=500, detail={"500":"Internal Server Error"})

    return result


@app.get('/blog/categories/{user_id}')
async def get_categories_id(user_id:str):
    query = """
    SELECT ARRAY(
	    SELECT title FROM post_category
	    LEFT JOIN category ON (category.id = post_category.category_id)
	    WHERE post_id = %s
    )
    """
    try:
        result = db.fetchone(query, user_id)[0]
    except:
        raise HTTPException(status_code=500, detail={"500":"Internal Server Error"})
    return result
