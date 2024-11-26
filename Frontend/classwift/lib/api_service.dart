// import 'dart:convert';
// import 'package:classwift/models/Report.dart';
// import 'package:http/http.dart' as http;
// import 'models/building.dart';

// class ApiService {
//   static const String baseUrl = "http://127.0.0.1:8000";

//   Future<Building> fetchBuildingData() async {
//     final response = await http.get(Uri.parse('$baseUrl/building'));

//     if (response.statusCode == 200) {
//       return Building.fromJson(json.decode(response.body));
//     } else {
//       throw Exception('Failed to load building data');
//     }
//   }

//   Future<void> updateClassroomAvailability(
//       int classroomNo, bool isAvailable) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/classroom/update'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, dynamic>{
//         'classroomNo': classroomNo,
//         'isAvailable': isAvailable,
//       }),
//     );

//     if (response.statusCode != 200) {
//       throw Exception('Failed to update classroom availability.');
//     }
//   }

//   Future<List<Report>> fetchReports() async {
//     final response = await http.get(Uri.parse('$baseUrl/reports'));

//     if (response.statusCode == 200) {
//       List<dynamic> data = json.decode(response.body);
//       // Convert the response into a list of Report objects
//       return data.map((report) => Report.fromJson(report)).toList();
//     } else {
//       throw Exception('Failed to load reports');
//     }
//   }
// }
import 'dart:convert';
import 'dart:async'; // For timeout
import 'package:classwift/models/Report.dart';
import 'package:classwift/models/Student.dart';
import 'package:http/http.dart' as http;
import 'models/building.dart';
import 'models/maintenace_staff.dart';

class ApiService {
  static const String baseUrl = "http://127.0.0.1:8000";

  Future<Building> fetchBuildingData() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/building'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return Building.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load building data: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching building data: $e');
    }
  }

  Future<void> updateClassroomAvailability(
      int classroomNo, bool isAvailable) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/classroom/update'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{
              'classroomNo': classroomNo,
              'isAvailable': isAvailable,
            }),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode != 200) {
        throw Exception(
            'Failed to update classroom availability: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error updating classroom availability: $e');
    }
  }

  Future<List<Report>> fetchReports() async {
    final response = await http.get(Uri.parse('$baseUrl/reports'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      // Convert the response into a list of Report objects
      return data.map((report) => Report.fromJson(report)).toList();
    } else {
      throw Exception('Failed to load reports');
    }
  }

  Future<List<Student>> fetchStudents() async {
    final response = await http.get(Uri.parse('$baseUrl/students'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => Student.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load students: ${response.body}');
    }
  }

  Future<Student> fetchStudentById(int studentId) async {
  final response = await http.get(Uri.parse('$baseUrl/students/$studentId'));
  
  if (response.statusCode == 200) {
    return Student.fromJson(json.decode(response.body));
  } else {
    throw Exception('Student not found.');
  }
}

 // New method to fetch maintenance staff data
  Future<List<MaintenanceStaff>> fetchMaintenanceStaff() async {
    final response = await http.get(Uri.parse('$baseUrl/maintenance-staff'));

    if (response.statusCode == 200) {
      // Parse the response body and return a list of MaintenanceStaff objects
      List<dynamic> data = json.decode(response.body);
      return data.map((staff) => MaintenanceStaff.fromJson(staff)).toList();
    } else {
      throw Exception('Failed to load maintenance staff data');
    }
  }
}
