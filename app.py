import json
from fastapi import FastAPI
from pydantic import BaseModel
from typing import List
from typing import Optional


app = FastAPI()

# Schemas using FastAPI's BaseModel from the Pydantic library
class Classroom(BaseModel):
    classroomNo: int
    floor: int
    capacity: int
    isAvailable: bool
    isALab: bool
    duration: str

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
    building: Optional[str]  # Allow None
    floor: Optional[str]     # Allow None
    classroomNo: Optional[str]  # Allow None
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
            print("Classrooms Data:", building_data["classrooms"])  # Debug here
            return building_data["classrooms"]
    except Exception as e:
        print("Error:", e)
        return {"error": str(e)}

@app.put("/classrooms/{classroom_no}")
def update_classroom(classroom_no: int, updated_classroom: Classroom):
    """
    Updates the availability and other details of a specific classroom in the JSON file.
    """
    try:
        # Load the building data from the JSON file
        with open("building11.json", "r") as file:
            building_data = json.load(file)
        
        # Find the classroom with the matching number
        classrooms = building_data.get("classrooms", [])
        for idx, classroom in enumerate(classrooms):
            if classroom["classroomNo"] == classroom_no:
                # Update the classroom with the new data
                classrooms[idx] = updated_classroom.dict()
                break
        else:
            return {"error": f"Classroom with number {classroom_no} not found."}
        
        # Save the updated data back to the JSON file
        with open("building11.json", "w") as file:
            json.dump(building_data, file, indent=4)
        
        return {"message": f"Classroom {classroom_no} updated successfully!"}
    except FileNotFoundError:
        return {"error": "Building data file not found. Please check 'building11.json'."}
    except json.JSONDecodeError:
        return {"error": "Failed to parse 'building11.json'. Check the file structure."}
    except Exception as e:
        return {"error": f"An unexpected error occurred: {str(e)}"}


# Endpoint to fetch reports data
@app.get("/reports", response_model=List[Report])
def get_reports():
    try:
        with open("Frontend/classwift/reports.json", "r") as file:
            reports_file_data = json.load(file)
            reports_data = reports_file_data.get("reports", [])
            if not reports_data:
                return {"error": "No reports found in the file."}
        return reports_data
    except FileNotFoundError:
        return {"error": "Reports data file not found. Please check 'reports.json'."}
    except json.JSONDecodeError:
        return {"error": "Failed to parse 'reports.json'. Check the file structure."}
    except Exception as e:
        return {"error": f"An unexpected error occurred: {str(e)}"}


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
