import 'dart:convert';
import 'dart:async'; // For timeout
import 'package:classwift/models/Report.dart';
import 'package:http/http.dart' as http;
import 'models/building.dart';

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
          .put(
            Uri.parse('$baseUrl/classrooms/$classroomNo'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{
              'classroomNo': classroomNo,
              'isAvailable': isAvailable,
              'floor': 1, // Example value, adjust as needed
              'capacity': 30, // Example value, adjust as needed
              'isALab': false, // Example value, adjust as needed
              'duration': '1hr', // Example value, adjust as needed
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
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/reports'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        // Convert the response into a list of Report objects
        return data.map((report) => Report.fromJson(report)).toList();
      } else {
        throw Exception('Failed to load reports: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching reports: $e');
    }
  }
}
