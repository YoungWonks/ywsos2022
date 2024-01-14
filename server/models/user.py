from pydantic import Field, EmailStr, root_validator
from pydantic import BaseModel
from pydantic.functional_validators import BeforeValidator
from bson import ObjectId
from datetime import datetime
from typing import Optional, Union
from typing_extensions import Annotated

PyObjectId = Annotated[str, BeforeValidator(str)]

class UserModel(BaseModel):
    id: Optional[PyObjectId] = Field(default=None, alias="_id")
    username: str = Field(...)
    password: str = Field(...)

    class Config:
        populate_by_name = True
        arbitrary_types_allowed = True
        json_encoders = {ObjectId: str}
        json_schema_extra = {
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
        populate_by_name = True
        arbitrary_types_allowed = True
        json_encoders = {ObjectId: str}
        json_schema_extra = {
            "example": {
                "username":"test",
                "key":"test",
                "new_password":"test"
            }
        }