# this is the updated version of the python code
# to start the server 
# 1- download the pip, look for instilation of FastAPI please
# 2- ensure that youre using the right path 
# 3- type the following in terminal
# uvicorn app:app --reload 

from fastapi import FastAPI
from pydantic import BaseModel
from typing import List

app = FastAPI()

# Pydantic models to structure the response data
class Classroom(BaseModel):
    classroomNo: int
    floor: int
    capacity: int
    isAvailable: bool
    isALab: bool

class Building(BaseModel):
    buildingNo: int
    location: str
    numOfFloors: int
    numOfClassrooms: int
    capacity: int
    accessible: bool
    classrooms: List[Classroom]

# Your data (building and classrooms)
building_data = {
    "buildingNo": 11,
    "location": "Fasaliyah",
    "numOfFloors": 5,
    "numOfClassrooms": 10,
    "capacity": 150,
    "accessible": True,
    "classrooms": [
        {"classroomNo": 100, "floor": 1, "capacity": 25, "isAvailable": True, "isALab": False},
        {"classroomNo": 101, "floor": 1, "capacity": 40, "isAvailable": False, "isALab": True},
        {"classroomNo": 201, "floor": 2, "capacity": 20, "isAvailable": True, "isALab": False},
        {"classroomNo": 202, "floor": 2, "capacity": 35, "isAvailable": True, "isALab": True},
        {"classroomNo": 301, "floor": 3, "capacity": 28, "isAvailable": True, "isALab": False},
        {"classroomNo": 302, "floor": 3, "capacity": 32, "isAvailable": True, "isALab": True},
        {"classroomNo": 401, "floor": 4, "capacity": 30, "isAvailable": True, "isALab": False},
        {"classroomNo": 402, "floor": 4, "capacity": 40, "isAvailable": True, "isALab": True},
        {"classroomNo": 501, "floor": 5, "capacity": 27, "isAvailable": True, "isALab": False},
        {"classroomNo": 502, "floor": 5, "capacity": 38, "isAvailable": True, "isALab": True}
    ]
}

# reading static data from json file (DOESNT WORK)
# try:
#     with open("building11.json", "r") as file:
#         building_data = json.load(file)

#     building11 = Building(building_data["buildingNo"], building_data["location"], building_data["numOfFloors"], building_data["numOfClassrooms"], building_data["capacity"], building_data["accessible"])

# except KeyError as e:
#     print(f"Error: Missing key in building data - {e}")
# except Exception as e:
#     print(f"Error: An exception occurred - {e}")

# Display classrooms in Building 11
# building11.display_classrooms()  


# Root endpoint
@app.get("/")
def read_root():
    return {"message": "Welcome to the FastAPI server!"}

# Endpoint to fetch building data AKA schema
@app.get("/building", response_model=Building)
def get_building():
    return building_data

# Endpoint to fetch classrooms data AKA schema
@app.get("/classrooms", response_model=List[Classroom])
def get_classrooms():
    return building_data["classrooms"]


