import 'package:flutter/material.dart';
import '../services/resume_service.dart';
import '../models/resume_request.dart';
import 'resume_result_screen.dart';
import 'auth_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final nameController = TextEditingController();
  final experienceController = TextEditingController();
  final skillsController = TextEditingController();
  final educationController = TextEditingController();
  bool isLoading = false;

  void submit() async {
    setState(() => isLoading = true);

    final request = ResumeRequest(
      name: nameController.text,
      experience: experienceController.text.split(';'),
      skills: skillsController.text.split(','),
      education: educationController.text.split(';'),
    );

    try {
      final result = await ResumeService.generateResume(request);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ResumeResultScreen(resume: result)),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Resume Generator")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: experienceController,
              decoration: const InputDecoration(
                labelText: "Experience (semicolon separated)",
              ),
            ),
            TextField(
              controller: skillsController,
              decoration: const InputDecoration(
                labelText: "Skills (comma separated)",
              ),
            ),
            TextField(
              controller: educationController,
              decoration: const InputDecoration(
                labelText: "Education (semicolon separated)",
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: isLoading ? null : submit,
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text("Generate"),
            ),
          ],
        ),
      ),
    );
  }
}