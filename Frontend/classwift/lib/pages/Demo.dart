import 'dart:convert';
import 'package:classwift/api_service.dart';
import 'package:classwift/card/report_history_card.dart';
import 'package:classwift/models/Report.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _HomePageState();
}

class _HomePageState extends State<DemoPage> {
  List<Report> reports = [];
  bool isLoading = true;
  final ApiService _apiService = ApiService(); // Initialize ApiService

  @override
  void initState() {
    super.initState();
    fetchReports();
  }

// alternative to apiservices
  // Future<void> fetchReports() async {
  //   try {
  //     final response =
  //         await http.get(Uri.parse('http://127.0.0.1:8000/reports'));
  //     print('Response status: ${response.statusCode}');
  //     print(
  //         'Response body: ${response.body}'); // This will log the raw response

  //     if (response.statusCode == 200) {
  //       final List<dynamic> data = json.decode(response.body);
  //       print('Decoded data: $data'); // Log the data to verify the structure
  //       setState(() {
  //         reports = data.map((item) => Report.fromJson(item)).toList();
  //         isLoading = false;
  //       });
  //     } else {
  //       throw Exception('Failed to load reports');
  //     }
  //   } catch (e) {
  //     print('Error fetching reports: $e');
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  Future<void> fetchReports() async {
    try {
      // Use the ApiService to fetch reports
      final fetchedReports = await _apiService.fetchReports();

      setState(() {
        reports = fetchedReports;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching reports: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Demo Reports")),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator() // Show loading indicator
            : reports.isEmpty
                ? Text('No reports available') // Show message if no reports
                : SizedBox(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: reports.length,
                      itemBuilder: (context, index) {
                        Report report = reports[index]; // Get each report
                        return ReportHistoryCard(
                          reportID: report.reportId,
                          reportDate: report.date,
                          reportBuilding: report.building,
                          reportFloor: report.floor,
                          reportRoomNo: report.classroomNo,
                          reportIssue: report.issueType,
                          reportDescription: report.problemDesc,
                        );
                      },
                    ),
                  ),
      ),
    );
  }
}
