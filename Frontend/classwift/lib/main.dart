import 'package:classwift/pages/Demo.dart';
import 'package:classwift/pages/MaintenanceView.dart';
import 'package:classwift/pages/NavigationBarScreen.dart';
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
      // home: WelcomePage(),
      //home: MaintenanceView(),
    );
  }
}
