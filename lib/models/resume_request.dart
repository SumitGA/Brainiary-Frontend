class ResumeRequest {
  final String name;
  final List<String> experience;
  final List<String> skills;
  final List<String> education;

  ResumeRequest({
    required this.name,
    required this.experience,
    required this.skills,
    required this.education,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'experience': experience,
        'skills': skills,
        'education': education,
      };
}