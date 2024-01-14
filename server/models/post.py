from pydantic import Field, EmailStr, root_validator
from pydantic import BaseModel
from pydantic.functional_validators import BeforeValidator
from bson import ObjectId
from datetime import datetime
from typing import Optional, Union
from typing_extensions import Annotated

PyObjectId = Annotated[str, BeforeValidator(str)]

class PostModel(BaseModel):
    id: Optional[PyObjectId] = Field(default=None, alias="_id")
    # user_id: PyObjectId = Field(default_factory=PyObjectId, alias="user_id")
    username: str = Field(...)
    title: str = Field(...)
    text: str = Field(...)
    coords: list = []
    created_at: datetime = datetime.utcnow()
    updated_at: Optional[datetime] = None

    class Config:
        populate_by_name = True
        arbitrary_types_allowed = True
        validate_assignment = True
        json_encoders = {ObjectId: str}
        json_schema_extra = {
            "example": {
                "user_id": "63c433db00b312ac865da8dd",
                "coords": [38.488835, -122.699864],
                "title": "Post somewhere.",
                "text": "3.0",  
            }
        }
    @root_validator(skip_on_failure = True)
    def date_validator(cls, value):
        if value["updated_at"]:
            value["updated_at"] = datetime.utcnow()
        else:
            value["updated_at"] = value["created_at"]

        return value