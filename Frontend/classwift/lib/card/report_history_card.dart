import 'package:flutter/material.dart';

class ReportHistoryCard extends StatelessWidget {
  final String reportID;
  final String reportDate;
  final String reportBuilding;
  final String reportFloor;
  final String reportRoomNo;
  final String reportIssue;
  final String reportDescription;

  const ReportHistoryCard({
    super.key,
    required this.reportID,
    required this.reportDate,
    required this.reportBuilding,
    required this.reportFloor,
    required this.reportRoomNo,
    required this.reportIssue,
    required this.reportDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Card(
        elevation: 4,
        margin: EdgeInsets.all(8),
        color: const Color.fromARGB(
            255, 255, 233, 167), // Light background color like in the image
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Center(
                child: Text(
                  'Report ID: $reportID',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 10), // Horizontal line under Report ID
              Text('Date: $reportDate'),
              Text('Building: $reportBuilding'),
              Text('Floor: $reportFloor'),
              Text('Room: $reportRoomNo'),
              Text('Issue type: $reportIssue'),
              Text('Problem description: $reportDescription'),
            ],
          ),
        ),
      ),
    );
  }
}
