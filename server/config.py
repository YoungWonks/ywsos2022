from pydantic import BaseSettings
<<<<<<< HEAD

class Settings(BaseSettings):
  ENV_VARIABLE: str

  class Config:
    env_file = './.env'
=======
class Settings (BaseSettings):
    MONGODB_URI: str
    class Config:
        env_file = './.env'
>>>>>>> 633608a9e2388479ec60c8b89b84f2c967f73e2f

settings = Settings()