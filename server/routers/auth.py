from fastapi import APIRouter, Header, status, Body, HTTPException, Depends, Request, Response
from fastapi.encoders import jsonable_encoder
from fastapi.responses import JSONResponse 
from config import settings
from passlib.hash import pbkdf2_sha256
from db import db
from models.post import PostModel
from typing import List, Union
from fastapi_jwt_auth import AuthJWT
from fastapi_jwt_auth.exceptions import AuthJWTException
from models.user import UserModel
from datetime import datetime
from pydantic import BaseSettings


class Settings(BaseSettings):

    authjwt_secret_key: str = "secret"
    # Configure application to store and get JWT from cookies
    authjwt_token_location: set = {"headers"}
    # Only allow JWT cookies to be sent over https
    authjwt_cookie_secure: bool = False
    # Enable csrf double submit protection. default is True
    authjwt_cookie_csrf_protect: bool = True
    
    

router = APIRouter()

@AuthJWT.load_config
def get_config():
    return Settings()

@router.post("/login")

def login(response: Response, user: UserModel, Authorize: AuthJWT = Depends()):
    if user.username != "test" or user.password != "test":
        raise HTTPException(status_code=401,detail="Bad username or password")

    # Create the tokens and passing to set_access_cookies or set_refresh_cookies
    access_token = Authorize.create_access_token(subject=user.username)
    refresh_token = Authorize.create_refresh_token(subject=user.username)
    return {"status_code":status.HTTP_200_OK, "content":"success", "access_token": access_token, "refresh_token": refresh_token}


@router.delete('/logout')

def logout(X_CSRF_TOKEN: Union[str, None] = Header(default=None), Authorize: AuthJWT = Depends()):
    """
    Because the JWT are stored in an httponly cookie now, we cannot
    log the user out by simply deleting the cookies in the frontend.
    We need the backend to send us a response to delete the cookies.
    """
    Authorize.jwt_required()

    Authorize.unset_jwt_cookies()
    response = JSONResponse(status_code=status.HTTP_200_OK, content="success")
    response.delete_cookie("access_token_cookie")
    response.delete_cookie("csrf_access_token")
    response.delete_cookie("csrf_refresh_token")
    response.delete_cookie("refresh_token_cookie")
    return response

@router.get('/access-token')
def access_token(Authorize: AuthJWT = Depends(), user_agent: Union[str, None] = Header(default=None)):
    print(user_agent)
    Authorize.jwt_required()

    return {"status_code": status.HTTP_200_OK, "content":"success"}
@router.post("/register")

async def register(response: Response, user: UserModel, Authorize: AuthJWT = Depends()):
    special_characters = "!@#$%^&*()-+?_=,<>/"
    user_check = await db.users.find_one({"username":user.username})
    if user_check == None:
        if len(user.username) > 3:
            if any(c in special_characters for c in user.password):
                db.users.insert_one({
                    "username": user.username,
                    "password": pbkdf2_sha256.hash(user.password),
                    "created_at": datetime.utcnow(),
                })
                return {"status_code":status.HTTP_200_OK, "content":"success"}
            else:
                print("Give your password a special character!")
                return {"status_code":status.HTTP_200_OK, "content":"failure"}
        else:
            print("Make your username more than three digits!")
            return {"status_code":status.HTTP_200_OK, "content":"failure"}
    else:
        print("Username already taken")
        return {"status_code":status.HTTP_200_OK, "content":"failure"}
        
       
     
