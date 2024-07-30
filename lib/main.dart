import 'package:flutter/material.dart';
import 'dashboard_screen.dart'; // Import the DashboardScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recycle Bazaar',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DashboardScreen(), // Set DashboardScreen as the home screen
    );
  }
}
