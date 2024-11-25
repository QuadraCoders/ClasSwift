import 'dart:convert';
import 'package:classwift/models/Report.dart';
import 'package:http/http.dart' as http;
import 'models/building.dart';
import 'models/maintenace_staff.dart';

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
