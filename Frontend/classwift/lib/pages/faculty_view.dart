// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:classwift/models/Report.dart';
import 'package:classwift/api_service.dart';
import 'package:classwift/card/event_card.dart';
import 'package:classwift/card/report_history_card.dart';
import 'package:classwift/card/services_card.dart';
import 'package:classwift/models/Report.dart';
import 'package:classwift/pages/About_us.dart';
import 'package:classwift/pages/Settings.dart';
import 'package:classwift/pages/alternative_page.dart';
import 'package:classwift/pages/contact_page.dart';
import 'package:classwift/pages/faculty_profile.dart';
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

class FacultyView extends StatefulWidget {
  final int? userId;
  const FacultyView({Key? key, this.userId}) : super(key: key);

  @override
  State<FacultyView> createState() => _HomePageState();
}

class _HomePageState extends State<FacultyView> {
  List<Report> reports = [];
  bool isLoading = true;
  final ApiService _apiService = ApiService(); // Initialize ApiService
  List<Widget> screens = [
    FacultyView(userId: 1),
    ProfilePage()
  ]; // Example usage
  int currentIndex = 0;

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
              MaterialPageRoute(builder: (context) => FacultyProfile()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: '')
        ],
      ),
      drawer: Drawer(
        //backgroundColor: Colors.white60,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(height: 30),
            Container(
              alignment: Alignment.centerLeft, // Align to the left
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Align children to the left
                children: [
                  Icon(Icons.menu_rounded,
                      color: Color.fromARGB(255, 121, 89, 178)),
                  SizedBox(
                    height: 10,
                  ),
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

          // Content
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 15),

                  // App bar
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
                              Scaffold.of(context)
                                  .openDrawer(); // Opens the sidebar
                            },
                          ),
                        ),
                        // Logo
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
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            'Salma Aldawsary',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          )
                        ],
                      ),
                    ),
                  ),
                  // Card --> Catchphrase
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
                            // The Phrase
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
                            SizedBox(
                              width: 15,
                            ),
                            // Picture
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

                  // Services List Title
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Services list',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          '',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 25),

                  // Horizontal ListView --> Services
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
                    child: SizedBox(
                      height: 80,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          ServicesCard(
                            serviceName: 'Find alternative classes',
                            iconImagePath: 'lib/assets/users-class.png',
                            pageTitle: 'Find alternatives',
                            pageName: AlternativePage(
                                title: 'View alternative classes'),
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

                  // Events List Title
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text(
                  //         'Current Selected Class',
                  //         style: TextStyle(
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 20,
                  //         ),
                  //       ),
                  //       Text(
                  //         '',
                  //         style: TextStyle(
                  //           fontSize: 14,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  // Horizontal ListView for Events
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Card(
                        //here display class info
                        ),
                  ),

                  SizedBox(height: 25),

                  // Recents List Title
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
                    padding: const EdgeInsets.all(8.0),
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
                    ),
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
