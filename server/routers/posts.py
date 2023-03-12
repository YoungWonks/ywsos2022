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
    return JSONResponse(status_code=status.HTTP_200_OK,content=all_posts)

@router.get('/{id}',response_model=PostModel)

async def get_post(id:str):

    post = await db.posts.find_one({"_id":id})
    if post is None:
        return JSONResponse(status_code=status.HTTP_404_NOT_FOUND,content="Post not Found")
    return JSONResponse(status_code=status.HTTP_200_OK,content=post) 

@router.get('/users/{user_id}',response_model=PostModel)

async def get_user_posts(user_id:str):

    posts = await db.posts.find({"user_id":user_id}).to_list(1000)
    print(posts)
    if posts is None:
        return JSONResponse(status_code=status.HTTP_404_NOT_FOUND,content="Post not Found")
    return JSONResponse(status_code=status.HTTP_200_OK,content=posts) 


@router.post('/',response_model=PostModel)

async def add_post(post:PostModel=Body(...)):
    
    post = jsonable_encoder(post)    
    new_post = await db.posts.insert_one(post)
    created_post = await db.posts.find_one({"_id":new_post.inserted_id})
    return JSONResponse(status_code=status.HTTP_201_CREATED,content=created_post)
    
@router.put('/{id}',response_model=PostModel)

async def update_post(id:str,post:PostModel=Body(...)):
  
    post = jsonable_encoder(post)    
    print(post)
    update_result = await db.posts.update_one(jsonable_encoder({"_id":id}),{"$set":{"coords":post["coords"], "text":post["text"], "title":post["title"]}})
    if update_result.matched_count == 0:
        return JSONResponse(status_code=status.HTTP_404_NOT_FOUND,content="Post not Found")
    return JSONResponse(status_code=status.HTTP_200_OK,content="Post Succesfully updated")

@router.delete('/{id}')
async def delete_post(id):

    post = await db.posts.find_one({"_id":id})
    
    await db.posts.delete_one({"_id":id})
    return JSONResponse(status_code=status.HTTP_200_OK,content=post)

