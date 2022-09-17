from pydantic import BaseSettings
class Settings (BaseSettings):
<<<<<<< HEAD
    MONGO_URI: str
    class Config:
        env_file = './.env'

settings = Settings()
=======
    MONGODB_URI: str
    class Config:
        env_file = './.env'

settings = Settings()
>>>>>>> 633608a9e2388479ec60c8b89b84f2c967f73e2f
