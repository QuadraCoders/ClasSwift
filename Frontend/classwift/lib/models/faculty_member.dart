// lib/models/faculty_member.dart
class FacultyMember {
  final String name;
  final String phone;
  final String email;
  final String department;
  final int id;
  final String password;

  FacultyMember({
    required this.name,
    required this.phone,
    required this.email,
    required this.department,
    required this.id,
    required this.password,
  });

  factory FacultyMember.fromJson(Map<String, dynamic> json) {
    return FacultyMember(
      name: json['name'] ?? '',  // Default to empty string if null
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      department: json['department'] ?? '',
      id: json['id'],  // Typically, this shouldn't be null; ensure valid input
      password: json['password'] ?? '',  // Handle with care, avoid sending it around
    );
  }
}