import json
from fastapi import FastAPI
from pydantic import BaseModel
from typing import List

app = FastAPI()

# Schemas using FastAPI's BaseModel from the Pydantic library
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
    building: str
    floor: str
    classroomNo: str
    date: str
    issueType: str
    problemDesc: str
    status: str
    user_id: int

# Root endpoint
@app.get("/")
def read_root():
    return {"message": "Welcome to ClasSwift server!"}

# Endpoint to fetch building data
@app.get("/building", response_model=Building)
def get_building():
    try:
        with open("building11.json", "r") as file:
            building_data = json.load(file)
        return building_data
    except FileNotFoundError:
        return {"error": "Building data file not found. Please check 'building11.json'."}
    except json.JSONDecodeError:
        return {"error": "Failed to parse 'building11.json'. Check the file structure."}

# Endpoint to fetch classrooms data
@app.get("/classrooms", response_model=List[Classroom])
def get_classrooms():
    try:
        with open("building11.json", "r") as file:
            building_data = json.load(file)
        return building_data["classrooms"]
    except FileNotFoundError:
        return {"error": "Classroom data file not found. Please check 'building11.json'."}
    except json.JSONDecodeError:
        return {"error": "Failed to parse 'building11.json'. Check the file structure."}
    except KeyError:
        return {"error": "Classroom data not available in the JSON file."}

# Endpoint to fetch reports data
@app.get("/reports", response_model=List[Report])
def get_reports():
    try:
        with open("Frontend/classwift/reports.json", "r") as file:
            reports_file_data = json.load(file)
            reports_data = reports_file_data.get("reports", [])
        return reports_data
    except FileNotFoundError:
        return {"error": "Reports data file not found. Please check 'reports.json'."}
    except json.JSONDecodeError:
        return {"error": "Failed to parse 'reports.json'. Check the file structure."}
    except KeyError:
        return {"error": "Reports data not available in the JSON file."}

@app.post("/reports")
def add_report(report: Report):
    try:
        with open("Frontend/classwift/reports.json", "r") as file:
            reports_file_data = json.load(file)
        reports = reports_file_data.get("reports", [])
        reports.append(report.dict())
        with open("Frontend/classwift/reports.json", "w") as file:
            json.dump({"reports": reports}, file, indent=4)
        return {"message": "Report added successfully!"}
    except FileNotFoundError:
        return {"error": "Reports data file not found. Please check 'reports.json'."}
    except json.JSONDecodeError:
        return {"error": "Failed to parse 'reports.json'. Check the file structure."}
