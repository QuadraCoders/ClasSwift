import json
from pydantic import BaseModel
from typing import List
from typing import Optional
from fastapi import FastAPI, HTTPException  # Don't forget to import HTTPException

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
    building: Optional[str]  # Allow None
    floor: Optional[str]     # Allow None
    classroomNo: Optional[str]  # Allow None
    date: str
    issueType: str
    problemDesc: str
    status: str
    user_id: int

class Student(BaseModel):
    name: str
    student_id: int  # should be spelled as 'student_id' to match the JSON key
    major: str
    college: str
    email: str  # should match the JSON key
    phoneNo: str
    password: str  # ensure this matches the JSON key

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
# @app.get("/reports", response_model=List[Report])
# def get_reports():
#     try:
#         with open("Frontend/classwift/reports.json", "r") as file:
#             reports_file_data = json.load(file)
#             reports_data = reports_file_data.get("reports", [])
#         return reports_data
#     except FileNotFoundError:
#         return {"error": "Reports data file not found. Please check 'reports.json'."}
#     except json.JSONDecodeError:
#         return {"error": "Failed to parse 'reports.json'. Check the file structure."}
#     except KeyError:
#         return {"error": "Reports data not available in the JSON file."}

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


# Endpoint to fetch students data
from fastapi import HTTPException

@app.get("/students", response_model=List[Student])
def get_students():
    try:
        with open("Frontend/classwift/students.json", "r") as file:
            student_data = json.load(file)
            students = [Student(**student) for student in student_data["students"]]  # Convert each dict to Student object
            return students
    except FileNotFoundError:
        raise HTTPException(status_code=404, detail="Students data file not found.")
    except json.JSONDecodeError:
        raise HTTPException(status_code=400, detail="Failed to parse students.json.")
    except KeyError:
        raise HTTPException(status_code=404, detail="Students data not available.")


@app.get("/students/{student_id}", response_model=Student)
def get_student(student_id: int):
    students = get_students()  # Fetch all students
    for student in students:
        if student.student_id == student_id:  # Now student is an instance of Student
            return student
    raise HTTPException(status_code=404, detail="Student not found.")