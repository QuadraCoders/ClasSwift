//  // ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';
import 'package:classwift/models/Report.dart';
import 'package:classwift/api_service.dart';
import 'package:classwift/card/event_card.dart';
import 'package:classwift/card/report_history_card.dart';
import 'package:classwift/card/services_card.dart';
import 'package:classwift/models/Report.dart';
import 'package:classwift/models/Student.dart';
import 'package:classwift/pages/About_us.dart';
import 'package:classwift/pages/Settings.dart';
import 'package:classwift/pages/contact_page.dart';
import 'package:classwift/pages/history_page.dart';
import 'package:classwift/pages/student_profile.dart';
import 'package:classwift/pages/report_page.dart';
import 'package:classwift/pages/Availability_Page.dart';
import 'package:classwift/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:classwift/models/Report.dart';
import 'package:classwift/models/building.dart';

class StudentView extends StatefulWidget {
  final int? userId;
  const StudentView({Key? key, this.userId}) : super(key: key);

  @override
  State<StudentView> createState() => _HomePageState();
}

class _HomePageState extends State<StudentView> {
  List<Report> reports = [];
  String studentName = "";
  String studentMajor = "";
  bool isLoading = true;
  final ApiService _apiService = ApiService(); // Initialize ApiService

  //stroing fetched data
  String? storedStudentName;
  String? storedStudentMajor;

  List<Widget> screens = [
    StudentView(userId: 1),
    ProfilePage()
  ]; // Example usage
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchReports();
    if (widget.userId != null) {
        fetchStudentData(); // Fetch from the API on initialization
    }
  }

  Future<void> fetchReports() async {
    try {
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


  Future<void> fetchStudentData() async {
    if (storedStudentName != null && storedStudentMajor != null) {
      // Use stored data if available
      setState(() {
        studentName = storedStudentName!;
        studentMajor = storedStudentMajor!;
        isLoading = false; // Stop loading
      });
    } else if (widget.userId != null) {
      // Fetch data from the API if not stored
      try {
        Student student = await _apiService.fetchStudentById(widget.userId!);
        setState(() {
          storedStudentName = student.name; // Store once fetched
          storedStudentMajor = student.major; // Store once fetched
          studentName = student.name;
          studentMajor = student.major;
          isLoading = false;
        });
      } catch (e) {
        print('Error fetching student data: $e');
        setState(() {
          isLoading = false;
        });
      }
    }
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage(userId: widget.userId)), // Pass userId here
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
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'lib/assets/wallpaper.png', // Replace with your image path
              fit: BoxFit.cover, // Ensures the image covers the entire screen
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
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
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello,',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            isLoading ? 'Loading...' : studentName,
                            style: TextStyle( fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                        ],
                      ),
                   
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 210, 224, 251),
                            borderRadius: BorderRadius.circular(20)),
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
                                )
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Services list',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text('', style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
                    child: SizedBox(
                      height: 80,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          ServicesCard(
                            serviceName: 'View availability',
                            iconImagePath: 'lib/assets/users-class.png',
                            pageTitle: 'View Availability',
                            pageName: AvailabilityPage(
                                title: 'View Classes Availability'),
                          ),
                          ServicesCard(
                            serviceName: 'Report an issue',
                            iconImagePath: 'lib/assets/file-edit.png',
                            pageTitle: 'Reports',
                            pageName: ReportPage(userId: widget.userId ?? 0),
                          ),
                          ServicesCard(
                            serviceName: 'History',
                            iconImagePath: 'lib/assets/time-past.png',
                            pageTitle: 'History',
                            pageName: history_page(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Events',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text('', style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: SizedBox(
                      height: 250,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          EventCard(
                              eventImagePath: 'lib/assets/event3.jpg',
                              eventOrganizer: 'GDGUJ',
                              eventDesc: 'a workshop'),
                          EventCard(
                              eventImagePath: 'lib/assets/some-event.png',
                              eventOrganizer: 'GDGUJ',
                              eventDesc: 'a workshop'),
                          EventCard(
                              eventImagePath: 'lib/assets/game-event.png',
                              eventOrganizer: 'GDGUJ',
                              eventDesc: 'a workshop'),
                          EventCard(
                              eventImagePath: 'lib/assets/event2.jpg',
                              eventOrganizer: 'Drone Club',
                              eventDesc: 'a workshop'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 25),

//                   // Recents List Title
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recent reports',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const history_page(); // MAKE A POP UP PAGE PLEASE
                            }));
                          },
                          child: Text(
                            'see all',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(
                        child: isLoading
                            ? CircularProgressIndicator() // Show loading indicator
                            : reports.isEmpty
                                ? Text(
                                    'No reports available') // Show message if no reports
                                : SizedBox(
                                    height: 250,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: reports.length,
                                      itemBuilder: (context, index) {
                                        Report report =
                                            reports[index]; // Get each report
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
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}