import motor.motor_asyncio
from config import settings

<<<<<<< HEAD
client = motor.motor_asyncio.AsyncIOMotorClient(settings.MONGO_URI)
db = client.ywsos22
=======
client = motor.motor_asyncio.AsyncIOMotorClient(settings.MONGODB_URI)
db = client.ywsos2022
>>>>>>> 633608a9e2388479ec60c8b89b84f2c967f73e2f
