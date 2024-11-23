class Classroom {
  final int classroomNo;
  final int floor;
  final int capacity;
 bool isAvailable;
  final bool isALab;

  Classroom({
    required this.classroomNo,
    required this.floor,
    required this.capacity,
    required this.isAvailable,
    required this.isALab,
  });

  factory Classroom.fromJson(Map<String, dynamic> json) {
    return Classroom(
      classroomNo: json['classroomNo'],
      floor: json['floor'],
      capacity: json['capacity'],
      isAvailable: json['isAvailable'],
      isALab: json['isALab'],
    );
  }
}
