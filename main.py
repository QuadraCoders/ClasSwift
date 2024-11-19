
import json
import random
import string

class User:
    def __init__(self, name, phoneNumber, email, department):
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
        self.department = department

    def get_name(self):
        return self.name

    def get_phoneNumber(self):
        return self.phoneNumber

    def get_email(self):
        return self.email

    def get_department(self):
        return self.department

    def __str__(self):
        return f"name: {self.name}\nphone number: {self.phoneNumber}\nemail: {self.email}\ndepartment: {self.department}" 

class FacultyMember(User):
    def __init__(self,name, phoneNumber, email, department, facultyID):
        super().__init__(name, phoneNumber, email, department)
        self.facultyID = facultyID
      
    def get_facultyID(self):
        return self.facultyID
              
    def __str__(self):
        return f"name: {self.name}\nphone number: {self.phoneNumber}\nemail: {self.email}\nfaculty ID: {self.facultyID}\ndepartment: {self.department}\n\n"      


class Maintenance(User):
    def __init__(self, name, phoneNumber, email, department, maintenanceId):
        super().__init__(name, phoneNumber, email, department)
        self.maintenanceId = maintenanceId
    
    def get_maintenanceId(self):
        return self.maintenanceId

    def __str__(self):
        return f"name: {self.name}\nphone number: {self.phoneNumber}\nemail: {self.email}\ndepartment: {self.department}\nmaintenanceId: {self.maintenanceId}\n\n"

class Student(User):
    def __init__(self, name, phoneNumber, email, department, studentID, major):
        super().__init__(name, phoneNumber, email, department)
        self.studentID = studentID
        self.major = major
       
    def get_studentID(self):
        return self.studentID

    def get_major(self):
        return self.major
       
    def __str__(self):
        return f"name: {self.name}\nphone number: {self.phoneNumber}\nemail: {self.email}\ndepartment: {self.department}\nstudent ID: {self.studentID}\nmajor: {self.major}"
    
    
class Building:
    def __init__(self, buildingNo, location, numOfFloors, numOfClassrooms, capacity, accesible):
        self.buildingNo = buildingNo
        self.location = location 
        self.numOfFloors = numOfFloors
        self.numOfClassrooms = numOfClassrooms
        self.capacity = capacity
        self.accesible = accesible
        self.classrooms = []
        
    def add_classroom(self, Classroom):
        self.classrooms.append(Classroom)   
        
    def display_classrooms(self):
        print(f"classrooms in Building {self.buildingNo} are: \n")
        for classroom in self.classrooms:
            print(f"{classroom}\n")
            
    def find_alternative(self, facultyID):
        faculty_member = None
        for member in faculty_members:
            if member.facultyID == facultyID:
                faculty_member = member
                break
        
        if faculty_member is None:
            print("Unauthorized Access")
            return
        
        print(f"Hello {faculty_member.name}, the available classrooms are:")
        for classroom in self.classrooms:
            if classroom.isAvailable:
                print(classroom.display_classroom_num())
        
        chosen = input("Please type the number of the picked classroom: ")
        for classroom in self.classrooms:
            if classroom.isAvailable and str(classroom.classroomNo) in str(chosen):
                classroom.isAvailable = False
                print(f"Classroom number {classroom.classroomNo} is now booked. Thank you, {faculty_member.name}!")
                return
        
        print("The class you have chosen is not available.")
        
    def view_available(self, Student): # for student functionality 
        print(f"hello {Student.name} the available classrooms are:")
        for classroom in self.classrooms:
            if classroom.isAvailable == True:
                print(classroom.__str__())
                print("\n")
        
            
    def __str__(self):
        return f"building number: {self.buildingNo}\nlocation: {self.location}\nnumebr of floors: {self.numOfFloors}\nnumber of classrooms: {self.numOfClassrooms}\ncapacity: {self.capacity}\naccesible?: {self.accesible}"
    
class Classroom:
    
    def __init__(self, classroomNo, floor, capacity, isAvailable, isALab):
        self.classroomNo = classroomNo
        self.floor = floor
        self.capacity = capacity
        self.isAvailable = isAvailable
        self.isALab = isALab
        
    def __str__(self):
        return f"classroom number: {self.classroomNo}\nfloor: {self.floor}\ncapacity: {self.capacity}\nis available?: {self.isAvailable}\nis a lab?: {self.isALab}"
        
    def display_classroom_num(self):
        return f"classroom number: {self.classroomNo}"


class Report:
    def __init__(self, classroomNo, date, issueType, problemDesc, user_id, status='In Progress'):
        self.reportId = ''.join(random.choices(string.ascii_uppercase + string.digits, k=8))
        self.classroomNo = classroomNo
        self.date = date
        self.issueType = issueType
        self.problemDesc = problemDesc
        self.status = status
        self.user_id = user_id
     #  self.imgpath = imgpath
    
    def updateStatus(self, reportId, new_status):
        if new_status.lower() == "issue solved":
            self.status = "Issue Solved"
        elif new_status.lower() == "in progress":
            self.status = "In Progress"
        else:
            print("Invalid status provided. Status remains unchanged.")

    def set_classroomNo(self, classroomNo):
        self.classroomNo = classroomNo

    def set_date(self, date):
        self.date = date

    def set_issueType(self, issueType):
        self.issueType = issueType

    def set_problemDesc(self, problemDesc):
        self.problemDesc = problemDesc

    def set_status(self, status):
        self.status = status

    def set_user_id(self, user_id):
        self.user_id = user_id

    def to_dict(self):
        return {
            "reportId": self.reportId,
            "classroomNo": self.classroomNo,
            "date": self.date,
            "issueType": self.issueType,
            "problemDesc": self.problemDesc,
            "status": self.status,
            "user_id": self.user_id
        }
    
#----------------------JSON database(building 11 + classrooms)---------------------------------------
try:
    with open("building11.json", "r") as file:
        building_data = json.load(file)

    building11 = Building(building_data["buildingNo"], building_data["location"], building_data["numOfFloors"], building_data["numOfClassrooms"], building_data["capacity"], building_data["accessible"])

except KeyError as e:
    print(f"Error: Missing key in building data - {e}")
except Exception as e:
    print(f"Error: An exception occurred - {e}")

# Add classrooms to the Building object + create a classroom object
for classroom_data in building_data["classrooms"]:
    classroom = Classroom(classroom_data["classroomNo"], classroom_data["floor"], classroom_data["capacity"], classroom_data["isAvailable"], classroom_data["isALab"])

    building11.add_classroom(classroom) 
    #so now building11 is an object that has the information of building 11 and is filled with classroom objects

# Display classrooms in Building 11
building11.display_classrooms()    

#----------------------JSON databse(faculty members)--------------------------
try:
    with open("faculty_members.json", "r") as file:
        faculty_data = json.load(file)

    faculty_members = []
    for faculty_member_info in faculty_data["faculty_members"]:
        faculty_member = FacultyMember(faculty_member_info["name"], faculty_member_info["phone"],
        faculty_member_info["email"], faculty_member_info["department"],
        faculty_member_info["id"])

        faculty_members.append(faculty_member)

    # Testing to show that info for faculty members linked correclty
    for faculty_member in faculty_members:
        print(faculty_member.__str__())

except KeyError as e:
    print(f"Error: Missing key in faculty members data - {e}")
except Exception as e:
    print(f"Error: An exception occurred - {e}")

# Testing to show that find alternative can be used  correclty with faculty id 
building11.find_alternative(1001)
building11.find_alternative(0000) #to show that it wont allow a student ID
#----------------------JSON databse(Students)--------------------------
try:
    with open("students.json", "r") as file:
        data = json.load(file)

    student_data = data.get("students", [])

    students = []
    for student_info in student_data:
        student = Student(student_info.get("name", "N/A"), student_info.get("student_id", "N/A"),
                          student_info.get("major", "N/A"), student_info.get("grade", "N/A"))
        students.append(student)

    # Testing to show student information
    for student in students:
        print(student)

except KeyError as e:
    print(f"Error: Missing key in student data - {e}")
except Exception as e:
    print(f"Error: An exception occurred - {e}")

#----------------------JSON databse(Maintenance staff)--------------------------
try:
    with open("maintenance_staff.json", "r") as file:
        data = json.load(file)

    staff_data = data.get("maintenance_staff", [])

    maintenance_staff = []
    for staff_info in staff_data:
        staff = Maintenance(staff_info.get("name", "N/A"), staff_info.get("staff_id", "N/A"),
                                 staff_info.get("department", "N/A"), staff_info.get("phone", "N/A"),
                                 staff_info.get("email", "N/A"))
        maintenance_staff.append(staff)

    # Display information for maintenance staff members
    for staff in maintenance_staff:
        print(staff)

except KeyError as e:
    print(f"Error: Missing key in maintenance staff data - {e}")
except Exception as e:
    print(f"An error occurred: {e}")

#----------------------JSON databse(Reports)--------------------------
# Create a list of reports (example data) because the reports will be written by users and then stored into a JSON file

# Load faculty data from JSON file
with open("faculty_members.json", "r") as f:
    faculty_data = json.load(f)

# Get a random faculty ID from json file
random_faculty_id = random.choice(faculty_data["faculty_members"])["id"]

# Generate random data for reports --> which the user will input
reports = [
    Report("101", "2024-11-04", "Electrical", "Lights not working", random_faculty_id),
    Report("102", "2024-11-05", "Plumbing", "Leak in sink", random_faculty_id),
    Report("103", "2024-11-06", "HVAC", "Air conditioning not working", random_faculty_id)
]

# Prepare report data as dictionaries --> so that they can be stored nicely in json file
report_data = {'reports': [report.to_dict() for report in reports]}

# Write the reports to a JSON file
with open("reports.json", "w") as file:
    json.dump(report_data, file, indent=4)  
