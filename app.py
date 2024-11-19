import json
from fastapi import FastAPI
from pydantic import BaseModel
from typing import List

app = FastAPI()

# schemas using FastAPI's BaseModel from the pydantic library.
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

class Report(BaseModel):
    reportId: str
    buildingNo: int
    floor: str
    classroomNo: str
    issueType: str
    problemDesc: str
    status: str
    userId: int

# Load building data from a JSON file
try:
    with open("building11.json", "r") as file:
        building_data = json.load(file)
except FileNotFoundError:
    print("Error: 'building11.json' file not found. Ensure the file is in the correct directory.")
    building_data = None
except json.JSONDecodeError:
    print("Error: Failed to parse 'building11.json'. Check the file's structure.")
    building_data = None

# Load reports data from a JSON file
# note to self: add this path Frontend/classwift/

try:
    with open("reports.json", "r") as file:
        reports_data = json.load(file)
except FileNotFoundError:
    print("Error: 'reports.json' file not found. Ensure the file is in the correct directory.")
    reports_data = None
except json.JSONDecodeError:
    print("Error: Failed to parse 'reports.json'. Check the file's structure.")
    reports_data = None


# Root endpoint
@app.get("/")
def read_root():
    return {"message": "Welcome to ClasSwift server!"}

# Endpoint to fetch building data
@app.get("/building", response_model=Building)
def get_building():
    if building_data:
        return building_data
    else:
        return {"error": "Building data not available. Please check the JSON file."}

# Endpoint to fetch classrooms data
@app.get("/classrooms", response_model=List[Classroom])
def get_classrooms():
    if building_data:
        return building_data["classrooms"]
    else:
        return {"error": "Classroom data not available. Please check the JSON file."}

# Endpoint to fetch reports data
@app.get("/reports", response_model=List[Report])
def get_reports():
    if reports_data:
        return reports_data
    else:
        return {"error": "Reports data not available. Please check the 'reports.json' file."}
