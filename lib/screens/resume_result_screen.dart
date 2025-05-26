import 'package:flutter/material.dart';

class ResumeResultScreen extends StatelessWidget {
  final String resume;
  const ResumeResultScreen({super.key, required this.resume});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Generated Resume")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(resume),
        ),
      ),
    );
  }
}