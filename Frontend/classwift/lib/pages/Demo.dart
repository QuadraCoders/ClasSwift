import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  List<Map<String, dynamic>> reports =
      []; // List to hold reports fetched from the server
  String? expandedReportID; // Track expanded report ID
  bool isLoading = true; // Loading state

  @override
  void initState() {
    super.initState();
    _fetchReports();
  }

  // Function to fetch reports from the server
  Future<void> _fetchReports() async {
    try {
      final response =
          await http.get(Uri.parse('https://your-api-endpoint.com/reports'));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        print('Fetched reports: $data'); // Debugging output
        setState(() {
          reports = data
              .map((report) => {
                    'id': report['id'],
                    'details': report['details'],
                    'status': report['status'],
                  })
              .toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load reports');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching reports: $e');
    }
  }

  // Function to update the status of a report
  Future<void> _updateReportStatus(String reportID, String status) async {
    try {
      final response = await http.post(
        Uri.parse('https://your-api-endpoint.com/reports/$reportID'),
        body: jsonEncode({'status': status}),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        setState(() {
          reports = reports.map((report) {
            if (report['id'] == reportID) {
              report['status'] = status;
            }
            return report;
          }).toList();
        });
      } else {
        throw Exception('Failed to update report status');
      }
    } catch (e) {
      print('Error updating report status: $e');
    }
  }

  // Build report card
  Widget _buildReportCard(Map<String, dynamic> report) {
    final String reportID = report['id'];
    final bool isExpanded = reportID == expandedReportID;

    return GestureDetector(
      onTap: () {
        setState(() {
          expandedReportID =
              isExpanded ? null : reportID; // Toggle expanded view
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8), // Default color
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Soft shadow
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              'Report #$reportID',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            if (isExpanded) ...[
              SizedBox(height: 5),
              Text(
                'Details: ${report['details']}',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Color(0xFFB2E6B2), // Pastel green for "Fixed"
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () => _updateReportStatus(reportID, 'Fixed'),
                    child: Text('Fixed'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Color(0xFFFFC6C6), // Pastel red for "In Progress"
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () =>
                        _updateReportStatus(reportID, 'In Progress'),
                    child: Text('In Progress'),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'Status: ${report['status']}',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading spinner
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: reports
                      .map((report) => _buildReportCard(report))
                      .toList(),
                ),
              ),
            ),
    );
  }
}
