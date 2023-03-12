from pydantic import Field, BaseModel, EmailStr 
from bson import ObjectId
from models.PyObjectId import PyObjectId
from datetime import datetime

class UserModel(BaseModel):
    username: str = Field(...)
    password: str = Field(...)
    id: PyObjectId = Field(default_factory=PyObjectId, alias="_id")

    class Config:
        allow_population_by_field_name = True
        arbitrary_types_allowed = True
        json_encoders = {ObjectId: str}
        schema_extra = {
            "example": {
                "username":"test",
                "password":"test"
            }
        }

class UserForgotPassModel(BaseModel):
    username: str = Field(...)
    key: str = Field(...)
    new_password: str = Field(...)
    id: PyObjectId = Field(default_factory=PyObjectId, alias="_id")

    class Config:
        allow_population_by_field_name = True
        arbitrary_types_allowed = True
        json_encoders = {ObjectId: str}
        schema_extra = {
            "example": {
                "username":"test",
                "key":"test",
                "new_password":"test"
            }
        }