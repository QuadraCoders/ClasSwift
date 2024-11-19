import 'Building.dart'; // Import the Building model (you may also import Classroom if necessary)

class Report {
  final String reportId;
  final Building?
      building; // You can link it to the Building model, it can be null if not available
  final String? floor;
  final String? classroomNo;
  final String? issueType;
  final String problemDesc;
  final String status;
  final int userId;

  Report({
    required this.reportId,
    this.building,
    this.floor,
    this.classroomNo,
    this.issueType,
    required this.problemDesc,
    required this.status,
    required this.userId,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    // Handle the building reference (it could be null, so make it nullable)
    var buildingJson = json['building'];
    Building? building;
    if (buildingJson != null) {
      building = Building.fromJson(buildingJson);
    }

    return Report(
      reportId: json['reportId'],
      building: building,
      floor: json['floor'],
      classroomNo: json['classroomNo'],
      issueType: json['issueType'],
      problemDesc: json['problemDesc'],
      status: json['status'],
      userId: json['user_id'],
    );
  }
}
