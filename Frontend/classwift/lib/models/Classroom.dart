class Classroom {
  final int classroomNo;
  final int floor;
  final int capacity;
  bool isAvailable;
  final bool isALab;
  final String duration;

  Classroom({
    required this.classroomNo,
    required this.floor,
    required this.capacity,
    required this.isAvailable,
    required this.isALab,
    required this.duration,
  });

  factory Classroom.fromJson(Map<String, dynamic> json) {
    return Classroom(
      classroomNo: json['classroomNo'],
      floor: json['floor'],
      capacity: json['capacity'],
      isAvailable: json['isAvailable'],
      isALab: json['isALab'],
      duration: json['duration'],
    );
  }

   Map<String, dynamic> toJson() {
    return {
      'classroomNo': classroomNo,
      'floor': floor,
      'capacity': capacity,
      'isAvailable': isAvailable,
      'isALab': isALab,
      'duration': duration,
    };
  }
}
