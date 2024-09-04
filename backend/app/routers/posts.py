
from fastapi import APIRouter, Response, status
from ..main import db, post_router


#router = routers['post']

'''@post_router.get('/')
async def get_post():
    query = """
    SELECT posts.id, title, cover, summary, published_at, username
    FROM posts
    LEFT JOIN users ON (users.id = posts.id_user)
    WHERE is_published = true
    ORDER BY published_at DESC
    """
    return db.get(query)

@post_router.get('/{id}')
async def get_post_id(id:str):
    query = """
    SELECT posts.id, title, cover, summary, content, published_at, updated_at, username
    FROM posts
    LEFT JOIN users ON (users.id = posts.id_user)
    WHERE posts.id = %s
    ORDER BY published_at DESC
    """
    return db.getone(query, id)
'''
