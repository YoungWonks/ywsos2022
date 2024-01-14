from fastapi import APIRouter, Header, status, Body, HTTPException, Depends, Request, Response, Security
from fastapi.encoders import jsonable_encoder
from fastapi.responses import JSONResponse, RedirectResponse
from config import *
from passlib.hash import pbkdf2_sha256
from db import *
from models.post import PostModel
from typing import List, Union
from fastapi_jwt import (
    JwtAccessBearerCookie,
    JwtAuthorizationCredentials,
    JwtRefreshBearer,
)
from models.user import UserModel, UserForgotPassModel
from datetime import datetime
from pydantic_settings import BaseSettings
from random import *
from .helpers import hexCode, passwordCheck
from datetime import timedelta


# class Settings(BaseSettings):

    # authjwt_secret_key: str = "secret"
    # # Configure application to store and get JWT from cookies
    # authjwt_token_location: set = {"headers"}

    # # Only allow JWT cookies to be sent over https
    # authjwt_cookie_secure: bool = False

    # # Enable csrf double submit protection. default is True
    # authjwt_cookie_csrf_protect: bool = True

    # #Creates denylist, adds tokens upon logout
    # authjwt_denylist_enabled: bool = True
    # authjwt_denylist_token_checks: set = {"access","refresh"}
    
router = APIRouter()

# @AuthJWT.load_config
# def get_config():
#     return Settings()

# @AuthJWT.token_in_denylist_loader
# async def check_if_token_in_denylist(decrypted_token):
#     jti = decrypted_token['jti']
#     check = await db.denylist.find_one({jti: decrypted_token['jti']})
#     return check

access_security = JwtAccessBearerCookie(
    secret_key="secret_key",
    # algorithm=[hs256],
    auto_error=False,
    access_expires_delta=timedelta(hours=1)  # change access token validation timedelta
)
# Read refresh token from bearer header only
refresh_security = JwtRefreshBearer(
    secret_key="secret_key", 
    auto_error=True  # automatically raise HTTPException: HTTP_401_UNAUTHORIZED 
)

@router.post("/login")
async def login(response: Response, user: UserModel):
    userLoggingIn = await db.users.find_one({"username":user.username})
    print(pbkdf2_sha256.verify(user.password, userLoggingIn['password']))
    if userLoggingIn != None:
        print(user.password)
        print(userLoggingIn['password'])
        if pbkdf2_sha256.verify(user.password, userLoggingIn['password']):
            print(user)
            access_token = access_security.create_access_token(subject={"username": user.username})
            refresh_token = refresh_security.create_refresh_token(subject={"username": user.username})
            return {"status_code":status.HTTP_200_OK, "content":"success", "access_token": access_token, "refresh_token": refresh_token, "username":user.username}
            #redirect to the stats pg isn't working
        else:
            return {"status_code":status.HTTP_401_UNAUTHORIZED, "status":"failure", "content":"Password incorrect"}
    else:
       return {"status_code":status.HTTP_401_UNAUTHORIZED, "status":"failure", "content":"Userame not found."}

    # Create the tokens and passing to set_access_cookies or set_refresh_cookies 

@router.get('/access-token')
def access_token(credentials: JwtAuthorizationCredentials = Security(access_security)):  
    # auto_error=False, fo we should check manually
    if not credentials:
        raise HTTPException(status_code=401, detail='my-custom-details')
    # now we can access Credentials object
    return {"username": credentials["username"]}
# , "role": credentials["role"] if needed

@router.get('/refresh-token')
# def refresh_token(Authorize: AuthJWT = Depends(), user_agent: Union[str, None] = Header(default=None)):
def refresh_token(credentials: JwtAuthorizationCredentials = Security(refresh_security)):
    # Update access/refresh tokens pair
    # We can customize expires_delta when creating
    access_token = access_security.create_access_token(subject=credentials.subject)
    refresh_token = refresh_security.create_refresh_token(subject=credentials.subject, expires_delta=timedelta(days=2))

    return {"access_token": access_token, "refresh_token": refresh_token}

@router.post("/register")
async def register(response: Response, user: UserModel):
    special_characters = "!@#$%^&*()-+?_=,<>/"
    user_check = await db.users.find_one({"username":user.username})
    if user_check == None:
        if len(user.username) > 3:
            if any(c in special_characters for c in user.password):
                secret_key = hexCode()
                db.users.insert_one({
                    "username": user.username,
                    "password": pbkdf2_sha256.hash(user.password),
                    "created_at": datetime.utcnow(),
                    "key": secret_key
                })
                return {"status_code":status.HTTP_200_OK, "content":"success", "key":secret_key}
            else:
                return {"status_code":status.HTTP_422_UNPROCESSABLE_ENTITY, "status":"failure", "content":"Give your password a special character!"}
        else:
            return {"status_code":status.HTTP_411_LENGTH_REQUIRED, "status":"failure", "content":"Make your username more than three digits!"}
    else:
        return {"status_code":status.HTTP_422_UNPROCESSABLE_ENTITY, "status":"failure", "content":"Username already taken"}

@router.post("/forgotpass")
async def forgotpass(response: Response, user: UserForgotPassModel):
    user_forgot = await db.users.find_one({"username":user.username})
    if user_forgot != None:
        if user.key == user_forgot['key']:
            if passwordCheck(user.new_password) == True:
                access_token = access_security.create_access_token(subject={"username": user.username})
                refresh_token = refresh_security.create_refresh_token(subject={"username": user.username})
                update_result = await db.users.update_one({"username": user.username}, {"$set": {"password": pbkdf2_sha256.hash(user.new_password)}})
                if update_result.matched_count == 0:
                    return JSONResponse(status_code=status.HTTP_404_NOT_FOUND,content="User not found")
                return JSONResponse(status_code=status.HTTP_200_OK,content="User succesfully updated")
            else:
                return {"status_code":status.HTTP_401_UNAUTHORIZED, "status":"failure", "content":"Make sure your password has special characters and is mroe than 3 characters!"}
        else:
            return {"status_code":status.HTTP_401_UNAUTHORIZED, "status":"failure", "content":"Key incorrect"}
    else:
       return {"status_code":status.HTTP_401_UNAUTHORIZED, "status":"failure", "content":"Userame not found."}
       
# @router.delete('/logout')
# def logout(access_token: Union[str, None] = Header(default=None)):
#     Authorize.jwt_refresh_token_required()
#     Authorize.jwt_required()
#     """
#     Because the JWT are stored in an httponly cookie now, we cannot
#     log the user out by simply deleting the cookies in the frontend.
#     We need the backend to send us a response to delete the cookies.
#     """
#     return RedirectResponse(url="/access-revoke", content="success", status_code=status.HTTP_200_OK) 

# @router.delete('/access-revoke')
# def access_revoke(Authorize: AuthJWT = Depends()):
#     Authorize.jwt_required()
#     jti = Authorize.get_raw_jwt()['jti']
#     db.denylist.insert_one({'jti': jti})
#     return RedirectResponse(url="/refresh-revoke", detail="Access token has been revoked", status_code=status.HTTP_200_OK)  

# # Endpoint for revoking the current users refresh token
# @router.delete('/refresh-revoke')
# def refresh_revoke(Authorize: AuthJWT = Depends()):
#     Authorize.jwt_refresh_token_required()
#     jti = Authorize.get_raw_jwt()['jti']
#     db.denylist.insert_one({'jti': jti})
#     return {"detail":"Refresh token has been revoke"}