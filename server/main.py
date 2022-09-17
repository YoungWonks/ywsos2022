from fastapi import FastAPI
from routers import posts
<<<<<<< HEAD
from config import settings

import uvicorn

app = FastAPI()
app.include_router(posts.router, tags=['Posts'], prefix='/api/posts')

@app.get('/')
def index():
  return {'message': f'Welcome to YoungWonks {settings.ENV_VARIABLE}'}

if __name__ == '__main__':
  uvicorn.run("main:app", host="127.0.0.1", port=8000, log_level="info", reload=True)
=======

import uvicorn

from config import settings


app = FastAPI()
app.include_router(posts.router, tags=["Posts"], prefix="/api/posts")

@app.get('/')
def index():
    return {'message': f'welcome to youngwonks'}

if __name__ == '__main__':
    uvicorn.run("main:app", host="127.0.0.1", port=8000, log_level="info", reload=True)
>>>>>>> 633608a9e2388479ec60c8b89b84f2c967f73e2f
