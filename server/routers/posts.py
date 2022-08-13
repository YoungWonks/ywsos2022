from fastapi import APIRouter
from config import settings
router = APIRouter()
@router.get('/')
def get_posts():
    return {"message": f"This returns all posts {settings.ENV_VARIABLE}"}
@router.get('/{id}')
def get_post():
    return {"message": "This post based on ID", "success": True}
@router.post('/')
def add_post():
    return {"message": "this adds a post", "success": True}
@router.put('/{id}')
def update_post():
    return {"message": "this updates a post", "success": True}
@router.delete('/{id}')
def delete_post():
    return {"message": "this deletes a post", "success": True}
