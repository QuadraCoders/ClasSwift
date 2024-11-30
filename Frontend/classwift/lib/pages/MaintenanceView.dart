import 'package:classwift/models/Report.dart';
import 'package:classwift/pages/About_us.dart';
import 'package:classwift/pages/Settings.dart';
import 'package:classwift/pages/maintenance_staff_profile.dart';
import 'package:classwift/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:classwift/pages/login_page.dart';
import 'package:classwift/pages/contact_page.dart';
import 'package:classwift/api_service.dart';
import 'package:classwift/models/report.dart'; // Import the Report model

class Maintenanceview extends StatefulWidget {
  const Maintenanceview({super.key});

  @override
  State<Maintenanceview> createState() => _Maintenanceview();
}

class _Maintenanceview extends State<Maintenanceview> {
  List<String> reportIDs = [];
  int currentIndex = 0;
  Map<String, String> reportDetails = {};
  List<String> archivedReports = []; // Store archived reports
  String? expandedReportID;

  // To keep track of the progress status for each report
  Map<String, bool> reportInProgress = {}; // Track progress
  bool isLoading = true; // Loading state

  @override
  void initState() {
    super.initState();
    _loadReports();
  }

  // Load reports from the API
  Future<void> _loadReports() async {
    try {
      setState(() {
        isLoading = true;
      });

      // Fetch reports using ApiService
      ApiService apiService = ApiService();
      var reports = await apiService.fetchReports();

      // Map the fetched reports into the required format
      setState(() {
        reportIDs = reports.map((report) => report.reportId).toList();
        reportDetails = {
          for (var report in reports) report.reportId: report.problemDesc,
        };
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch reports: $e')),
      );
    }
  }

  void _archiveReport(String reportID) {
    setState(() {
      archivedReports.add(reportID);
      reportIDs.remove(reportID);
      reportInProgress[reportID] =
          false; // Initially, it will not be in progress
    });
  }

  void _setInProgress(String reportID) {
    setState(() {
      reportInProgress[reportID] = true; // Set report as in progress
    });
  }

  Widget _buildReportCard(String reportID) {
    bool isExpanded = reportID == expandedReportID;

    // Determine the background color based on in-progress status
    Color backgroundColor = reportInProgress[reportID] == true
        ? Colors.yellow.withOpacity(0.5) // Pastel yellow if in progress
        : Colors.white.withOpacity(0.8); // Default color

    return GestureDetector(
      onTap: () {
        setState(() {
          expandedReportID =
              isExpanded ? null : reportID; // Collapse if already expanded
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: backgroundColor, // Use determined background color
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'New Report #$reportID',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            if (isExpanded) ...[
              SizedBox(height: 5),
              Text(
                'Details: ${reportDetails[reportID] ?? 'No details available.'}',
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
                    onPressed: () => _archiveReport(reportID),
                    child: Text('Fixed'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Color(0xFFFFC6C6), // Pastel red for "In Progress"
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () {
                      _setInProgress(
                          reportID); // Set in progress when button pressed
                    },
                    child: Text('In Progress'),
                  ),
                ],
              ),
              if (reportInProgress[reportID] == true) ...[
                SizedBox(height: 10),
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.yellow[300], // Pastel yellow background
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Under Construction',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildArchivedReportCard(String reportID) {
    bool isExpanded = expandedReportID == reportID;

    return GestureDetector(
      onTap: () {
        setState(() {
          expandedReportID = isExpanded ? null : reportID; // Toggle details
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6), // Dark shade for archived
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Archived Report #$reportID',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            if (isExpanded) ...[
              SizedBox(height: 5),
              Text(
                'Details: ${reportDetails[reportID] ?? 'No details available.'}',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
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
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color.fromARGB(255, 83, 143, 208),
        unselectedItemColor: const Color.fromARGB(255, 181, 205, 218),
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
          if (currentIndex == 1) {
            // Navigate to ProfilePage when profile icon is tapped
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => maintenace_profile()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: '')
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(height: 30),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.menu_rounded,
                      color: Color.fromARGB(255, 121, 89, 178)),
                  SizedBox(height: 10),
                  Text(
                    'More',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 121, 89, 178),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.settings,
                  color: Color.fromARGB(255, 121, 89, 178)),
              title: Text('Settings'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SettingsPage();
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.info_outline_rounded,
                  color: Color.fromARGB(255, 121, 89, 178)),
              title: Text('About us'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return about_us();
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.support_agent,
                  color: Color.fromARGB(255, 121, 89, 178)),
              title: Text('Contact Us'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ContactUsPage();
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app,
                  color: Color.fromARGB(255, 121, 89, 178)),
              title: Text('Exit'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return WelcomePage();
                }));
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'lib/assets/wallpaper.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator()) // Show loading spinner
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Builder(
                                builder: (context) => IconButton(
                                  icon: Icon(Icons.menu,
                                      color: Color.fromARGB(255, 56, 120, 176)),
                                  onPressed: () {
                                    Scaffold.of(context).openDrawer();
                                  },
                                ),
                              ),
                              Image.asset(
                                'lib/assets/logo.png',
                                height: 45,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 30),
                          child: Container(
                            alignment: Alignment.bottomLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hello,',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Text(
                                  'Jamila Saud',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Card(
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 210, 224, 251),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'From classes to repairs, \nClasSwift cares',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 22,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 15),
                                  Image.asset(
                                    'lib/assets/college class-amico.png',
                                    height: 120,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 25),

                        // New Reports Section
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'New Reports',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color(0xFF81B2DD), // Set color for title
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 15),
                        // List the report cards
                        Column(
                          children: reportIDs.map((reportID) {
                            return _buildReportCard(reportID);
                          }).toList(),
                        ),

                        // Archived Reports Section
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25.0, vertical: 15),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Archived Reports',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color(0xFF81B2DD), // Set color for title
                              ),
                            ),
                          ),
                        ),
                        // Display archived reports if any
                        if (archivedReports.isNotEmpty)
                          Column(
                            children: archivedReports.map((reportID) {
                              return _buildArchivedReportCard(reportID);
                            }).toList(),
                          ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
