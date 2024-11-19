import 'dart:convert';
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
}
