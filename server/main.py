from fastapi import FastAPI, Request
from routers import posts
from routers import auth
import uvicorn
from fastapi_jwt_auth import AuthJWT
from fastapi_jwt_auth.exceptions import AuthJWTException
from fastapi.responses import JSONResponse 

from config import settings

app = FastAPI()
app.include_router(posts.router, tags=["Posts"], prefix="/api/posts")
app.include_router(auth.router, tags=["Authentication"], prefix="/api/auth")
@app.get('/')
def index():
    return {'message': f'welcome to youngwonks'}

@app.exception_handler(AuthJWTException)
def authjwt_exception_handler(request: Request, exc: AuthJWTException):
    return JSONResponse(
        status_code=exc.status_code,
        content={"detail": exc.message}
    )

if __name__ == '__main__':
    uvicorn.run("main:app", host="127.0.0.1", port=8000, log_level="info", reload=True)