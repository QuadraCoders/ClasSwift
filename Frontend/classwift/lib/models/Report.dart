class Report {
  final String reportId;
  final String building;
  final String floor;
  final String classroomNo;
  final String date;
  final String issueType;
  final String problemDesc;
  final String status;
  final int userId;

  Report({
    required this.reportId,
    required this.building,
    required this.floor,
    required this.classroomNo,
    required this.date,
    required this.issueType,
    required this.problemDesc,
    required this.status,
    required this.userId,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      reportId: json['reportId'],
      building: json['building'],
      floor: json['floor'],
      classroomNo: json['classroomNo'],
      date: json['date'],
      issueType: json['issueType'],
      problemDesc: json['problemDesc'],
      status: json['status'],
      userId: json['user_id'],
    );
  }
}
