from fastapi import APIRouter
from config import settings

router = APIRouter()


@router.get('/')
def get_posts():
    return {"message": f"This returns all posts {settings.ENV_VARIABLE}"}


@router.get('/{id}')
def get_post(id: str):
    return {"message": f"This post based on ID {id}", "success": True}


@router.post('/')
def add_post():
    return {"message": "this adds a post", "success": True}


@router.put('/{id}')
def update_post(id: str):
    return {"message": f"this updates a post {id}", "success": True}


@router.delete('/{id}')
def delete_post(id: str):
    return {"message": f"this deletes a post {id}", "success": True}
