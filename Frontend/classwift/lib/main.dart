import 'package:classwift/pages/Availability_Page.dart';
import 'package:classwift/pages/Demo.dart';
import 'package:classwift/pages/MaintenanceMock.';
import 'package:classwift/pages/MaintenanceView';
import 'package:classwift/pages/NavigationBarScreen.dart';
import 'package:classwift/pages/Users_page.dart';
import 'package:classwift/pages/contact_page.dart';
import 'package:classwift/pages/home_page.dart';
import 'package:classwift/pages/profile_page.dart';
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
      home: DemoPage(),
      // home: WelcomePage()
    );
  }
}
