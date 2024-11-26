import 'dart:convert';
import 'package:classwift/api_service.dart';
import 'package:classwift/card/report_history_card.dart';
import 'package:classwift/models/Report.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class history_page extends StatefulWidget {
  const history_page({super.key});

  @override
  State<history_page> createState() => _HomePageState();
}

class _HomePageState extends State<history_page> {
  List<Report> reports = [];
  bool isLoading = true;
  final ApiService _apiService = ApiService(); // Initialize ApiService

  @override
  void initState() {
    super.initState();
    fetchReports();
  }

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
      appBar: AppBar(title: Text("Reports History")),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator() // Show loading indicator
            : reports.isEmpty
                ? Text('No reports available') // Show message if no reports
                : RefreshIndicator(
                    onRefresh:
                        fetchReports, // Call fetchReports() when user pulls down
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                      ),
                      itemCount: reports.length, // Number of items in the grid
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
