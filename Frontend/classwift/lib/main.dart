import 'package:classwift/pages/About_us.dart';
import 'package:classwift/pages/Availability_Page.dart';
import 'package:classwift/pages/Demo.dart';
import 'package:classwift/pages/LogStudent%20.dart';
import 'package:classwift/pages/MaintenanceView.dart';
import 'package:classwift/pages/NavigationBarScreen.dart';
import 'package:classwift/pages/Settings.dart';
import 'package:classwift/pages/report_page.dart';
import 'package:classwift/pages/welcome_page.dart';
import 'package:classwift/pages/alternative_page.dart';
import 'package:classwift/pages/contact_page.dart';
import 'package:classwift/pages/history_page.dart';
import 'package:classwift/pages/student_view.dart';
import 'package:classwift/pages/profile_page.dart';
import 'package:classwift/pages/maintenance_staff_profile.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        //home: NavigationBarScreen(), // we start from here
        //home: LoginPage(),
        home: WelcomePage()
        //home: MaintenanceMock(),
        //home: DemoPage(),
        //home: AlternativePage(title: ''),
        //home: Maintenanceview()
        );
  }
}
