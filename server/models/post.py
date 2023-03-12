from pydantic import Field, BaseModel, EmailStr, root_validator
from bson import ObjectId
from models.PyObjectId import PyObjectId
from datetime import datetime
from typing import Optional


class PostModel(BaseModel):
    type: str = Field(...) #giving, getting, listing
    id: PyObjectId = Field(default_factory=PyObjectId, alias="_id")
    user_id: PyObjectId = Field(default_factory=PyObjectId, alias="user_id")
    title: str = Field(...)
    text: str = Field(...)
    coords: list = []
    created_at: datetime = datetime.utcnow()
    updated_at: Optional[datetime] = None

    class Config:
        allow_population_by_field_name = True
        arbitrary_types_allowed = True
        validate_assignment = True
        json_encoders = {ObjectId: str}
        schema_extra = {
            "example": {
                "user_id": "63c433db00b312ac865da8dd",
                "coords": [38.488835, -122.699864],
                "title": "Experiments, Science, and Fashion in Nanophotonics",
                "text": "3.0",  
            }
        }
    @root_validator
    def date_validator(cls, value):
        if value["updated_at"]:
            value["updated_at"] = datetime.utcnow()
        else:
            value["updated_at"] = value["created_at"]

        return value