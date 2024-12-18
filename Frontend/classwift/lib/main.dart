import 'package:classwift/pages/About_us.dart';
import 'package:classwift/pages/Availability_Page.dart';
import 'package:classwift/pages/LogStudent%20.dart';
import 'package:classwift/pages/MaintenanceView.dart';
import 'package:classwift/pages/Settings.dart';
import 'package:classwift/pages/faculty_view.dart';
import 'package:classwift/pages/report_page.dart';
import 'package:classwift/pages/user_provider.dart';
import 'package:classwift/pages/welcome_page.dart';
import 'package:classwift/pages/alternative_page.dart';
import 'package:classwift/pages/contact_page.dart';
import 'package:classwift/pages/history_page.dart';
import 'package:classwift/pages/student_view.dart';
import 'package:classwift/pages/student_profile.dart';
import 'package:classwift/pages/maintenance_staff_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,

        home: WelcomePage()

        );
  }
}
