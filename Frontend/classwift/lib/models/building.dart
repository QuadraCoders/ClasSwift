import 'Classroom.dart';

class Building {
  final int buildingNo;
  final String location;
  final int numOfFloors;
  final int numOfClassrooms;
  final int capacity;
  final bool accessible;
  final List<Classroom> classrooms;

  Building({
    required this.buildingNo,
    required this.location,
    required this.numOfFloors,
    required this.numOfClassrooms,
    required this.capacity,
    required this.accessible,
    required this.classrooms,
  });

  factory Building.fromJson(Map<String, dynamic> json) {
    var classroomsFromJson = json['classrooms'] as List;
    List<Classroom> classroomsList =
        classroomsFromJson.map((e) => Classroom.fromJson(e)).toList();

    return Building(
      buildingNo: json['buildingNo'],
      location: json['location'],
      numOfFloors: json['numOfFloors'],
      numOfClassrooms: json['numOfClassrooms'],
      capacity: json['capacity'],
      accessible: json['accessible'],
      classrooms: classroomsList,
    );
  }
}
