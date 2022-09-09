from pydantic import Field, BaseModel, EmailStr
from models.PyObjectId import PyObjectId
from bson import ObjectId

class PostModel(BaseModel):
    id: PyObjectId = Field(default_factory=PyObjectId, alias="_id")
    name: str = Field(...)
    email: EmailStr = Field(...)
    title: str = Field(...)
    text: str = Field(...)

    class Config:
        allow_population_by_field_name = True
        arbitrary_types_allowed = True
        json_encoders = {ObjectId: str}
        schema_extra = {
            "example": {
                "name": "Jane Doe",
                "email": "jdoe@example.com",
                "title": "Experiments, Science, and Fashion in Nanophotonics",
                "text": "3.0",
            }
        }