import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/env.dart';
import '../models/resume_request.dart';

class ResumeService {
  static Future<String> generateResume(ResumeRequest request) async {
    final url = Uri.parse('$baseUrl/resume/create');
    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(request.toJson()),
    );

    if (res.statusCode == 200) {
      return json.decode(res.body)['resume'];
    } else {
      throw Exception('Failed to generate resume');
    }
  }
}