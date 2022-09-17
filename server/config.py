from pydantic import BaseSettings

class Settings(BaseSettings):
  ENV_VARIABLE: str

  class Config:
    env_file = './.env'

settings = Settings()