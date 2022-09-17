
from fastapi import APIRouter, status, Body
from fastapi.encoders import jsonable_encoder
from fastapi.responses import JSONResponse 
from config import settings
from db import db
from models.post import PostModel
from typing import List

router = APIRouter()

@router.get('/',response_model=List[PostModel])
async def get_posts():
    all_posts = await db.posts.find({}).to_list(1000)
    print(type(all_posts))
    
    return JSONResponse(status_code=status.HTTP_200_OK,content=all_posts)
@router.get('/{id}',response_model=PostModel)
async def get_post(id:str):
    post = await db.posts.find_one({"_id":id})
    if post is None:
        return JSONResponse(status_code=status.HTTP_404_NOT_FOUND,content="Post not Found")
    return JSONResponse(status_code=status.HTTP_200_OK,content=post) 
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
