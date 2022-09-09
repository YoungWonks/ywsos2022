
from fastapi import APIRouter, status, Body
from fastapi.encoders import jsonable_encoder
from fastapi.responses import JSONResponse 
from config import settings
from db import db
from models.post import PostModel

router = APIRouter()

@router.get('/')
def get_posts():
    return {"message": f"This returns all posts"}
@router.get('/{id}')
def get_post():
    return {"message": "This post based on ID", "success": True}
@router.post('/',response_model=PostModel)
async def add_post(post:PostModel=Body(...)):
    post = jsonable_encoder(post)    
    new_post = await db.posts.insert_one(post)
    created_post = await db.posts.find_one({"_id":new_post.inserted_id})
    return JSONResponse(status_code=status.HTTP_201_CREATED,content=created_post)
@router.put('/{id}')
def update_post():
    return {"message": "this updates a post", "success": True}
@router.delete('/{id}')
def delete_post():
    return {"message": "this deletes a post", "success": True}

