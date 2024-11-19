import 'package:classwift/pages/About_us.dart';
import 'package:classwift/pages/Availability_Page.dart';
import 'package:classwift/pages/MaintenanceMock.';
import 'package:classwift/pages/MaintenanceView';
import 'package:classwift/pages/NavigationBarScreen.dart';
import 'package:classwift/pages/Settings.dart';
import 'package:classwift/pages/Users_page.dart';
import 'package:classwift/pages/contact_page.dart';
import 'package:classwift/pages/history_page.dart';
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
        //home: HomePage(),
        //home: ServicesPage(title: 'Available Classes',),
        //home: history_page(),
        //home: NavigationBarScreen(), // we start from here
        //home: LoginPage(),
        //home: DemoPage(),
        //home: ProfilePage()
        //home: ReportPage()
        //home: WelcomePage()
        //home:ContactUsPage()
        //home:MaintenanceView()
        //home:MaintenanceMock()
        //home:SettingsPage()
        home: about_us()
        );
  }
}
