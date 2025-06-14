import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/resume_result_screen.dart';
import 'screens/landing_page.dart';

class ResumeApp extends StatelessWidget {
  const ResumeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resume Generator',
      theme: ThemeData(
        primaryColor: Color(0xFF263238),
        scaffoldBackgroundColor: Color(0xFFF5F7FA),
        hoverColor: Color.fromARGB(0, 92, 182, 255),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF263238),
          brightness: Brightness.light,
        ),
      ),
      home: LandingPage(),
      routes: {
        '/home': (context) => HomeScreen(),
        // '/resume-result': (context) => ResumeResultScreen(),
      },
    );
  }
}
