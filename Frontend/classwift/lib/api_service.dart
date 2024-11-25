import 'dart:convert';
import 'package:classwift/models/Report.dart';
import 'package:classwift/models/Student.dart';
import 'package:http/http.dart' as http;
import 'models/building.dart';

class ApiService {
  static const String baseUrl = "http://127.0.0.1:8000";

  Future<Building> fetchBuildingData() async {
    final response = await http.get(Uri.parse('$baseUrl/building'));

    if (response.statusCode == 200) {
      return Building.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load building data');
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

}
