import 'dart:convert';
import 'dart:io';
import 'package:classwift/api_service.dart';
import 'package:classwift/pages/NavigationBarScreen.dart';
import 'package:classwift/pages/student_view.dart';
import 'package:flutter/material.dart';

class ReportPage extends StatefulWidget {
  final int userId; // Add userId as a required parameter

  const ReportPage({super.key, required this.userId});

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  late int userId;
  String? selectedBuilding;
  String? selectedFloor;
  String? selectedClassNo;
  String? selectedIssueType;
  final TextEditingController _descriptionController = TextEditingController();

  final List<String> floors = [];
  List<String> classNumbers = [];
  List<Map<String, dynamic>> classrooms = [];

  @override
  void initState() {
    super.initState();
    userId = widget.userId;
    _loadBuildingData();
  }

  Future<void> _loadBuildingData() async {
    try {
      final building = await ApiService().fetchBuildingData();
      setState(() {
        classrooms = building.classrooms
            .map((classroom) => {
                  'floor': classroom.floor,
                  'classroomNo': classroom.classroomNo,
                  'capacity': classroom.capacity,
                })
            .toList();
        floors
            .addAll(classrooms.map((room) => room['floor'].toString()).toSet());
      });
    } catch (e) {
      print("Error loading building data: $e");
    }
  }

  void _updateClassNumbers(String floor) {
    setState(() {
      classNumbers = classrooms
          .where((room) => room['floor'].toString() == floor)
          .map((room) => 'Class ${room['classroomNo']}')
          .toList();
    });
  }

  Future<void> _saveReport() async {
    // Check for null or empty fields
    if (selectedBuilding == null ||
        selectedFloor == null ||
        selectedClassNo == null ||
        selectedIssueType == null ||
        _descriptionController.text.isEmpty) {
      // Show a dialog or snackbar with an error message
      _showFeedbackDialog(false, message: 'Please fill in all fields.');
      return;
    }

    final reportData = {
      "reportId": _generateReportId(),
      "building": selectedBuilding,
      "floor": selectedFloor,
      "classroomNo": selectedClassNo,
      "date": DateTime.now().toIso8601String().split('T').first,
      "issueType": selectedIssueType,
      "problemDesc": _descriptionController.text,
      "status": "Under maintenance",
      "user_id": userId
    };

    const filePath = 'reports.json';
    final file = File(filePath);

    try {
      List<dynamic> reports = [];
      if (await file.exists()) {
        final fileContents = await file.readAsString();
        final jsonData = json.decode(fileContents);
        reports = jsonData['reports'] ?? [];
      }

      reports.add(reportData);
      final updatedData = json.encode({"reports": reports});
      await file.writeAsString(updatedData, mode: FileMode.write);

      _showFeedbackDialog(true);
    } catch (e) {
      print("Error saving report: $e");
      _showFeedbackDialog(false,
          message:
              'There was an error submitting your report. Please try again.');
    }
  }

  void _showFeedbackDialog(bool isSuccess, {String? message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return FeedbackPopup(
          message: message ??
              (isSuccess
                  ? 'Your report has been submitted successfully!'
                  : 'There was an error submitting your report. Please try again.'),
          isSuccess: isSuccess,
          onClose: () {
            Navigator.of(context).pop(); // Closes the dialog
            if (isSuccess) {
              Navigator.of(context).pop(); // Returns to the previous page
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Report an Issue')),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'lib/assets/wallpapers (2).png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                const Center(
                  child: Text(
                    'Report Form',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 40),
                _buildDropdown(
                  label: 'Building',
                  value: selectedBuilding,
                  onChanged: (value) {
                    setState(() {
                      selectedBuilding = value;
                    });
                  },
                  items: ['Building 11'],
                ),
                const SizedBox(height: 16),
                _buildDropdown(
                  label: 'Floor',
                  value: selectedFloor,
                  onChanged: (value) {
                    setState(() {
                      selectedFloor = value;
                      _updateClassNumbers(value!);
                      selectedClassNo = null;
                    });
                  },
                  items: floors,
                ),
                const SizedBox(height: 16),
                _buildDropdown(
                  label: 'Class Number',
                  value: selectedClassNo,
                  onChanged: (value) {
                    setState(() {
                      selectedClassNo = value;
                    });
                  },
                  items: classNumbers,
                ),
                const SizedBox(height: 16),
                _buildDropdown(
                  label: 'Issue Type',
                  value: selectedIssueType,
                  onChanged: (value) {
                    setState(() {
                      selectedIssueType = value;
                    });
                  },
                  items: ['Electrical', 'Cleanliness', 'Technical', 'Other'],
                ),
                const SizedBox(height: 30),
                _buildDescriptionField(),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: _saveReport,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: const Color.fromARGB(255, 126, 194, 226),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required ValueChanged<String?> onChanged,
    required List<String> items,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 150,
          child: DropdownButtonFormField<String>(
            value: value,
            onChanged: onChanged,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
            ),
            items: items
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Problem Description',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(Icons.attachment),
          ],
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _descriptionController,
          maxLines: 5,
          decoration: InputDecoration(
            hintText: 'Write a brief description of the problem',
            hintStyle: const TextStyle(color: Colors.grey),
            border: const OutlineInputBorder(),
            filled: true,
            fillColor: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  String _generateReportId() {
    final random =
        (100 + (DateTime.now().millisecondsSinceEpoch % 900)).toString();
    return "REP$random";
  }
}

class FeedbackPopup extends StatelessWidget {
  final String message;
  final bool isSuccess;
  final VoidCallback onClose;

  const FeedbackPopup({
    required this.message,
    required this.isSuccess,
    required this.onClose,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSuccess ? Icons.check_circle : Icons.error,
              color: isSuccess ? Colors.green : Colors.red,
              size: 50,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 36),
            ElevatedButton(
              onPressed: onClose,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: Colors.grey[200],
              ),
              child: const Text(
                'Close',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
