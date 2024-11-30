class Student {
    final String name;
    final int student_id; // JSON key should match this name
    final String major;
    final String college;
    final String email;
    final String phoneNo;
    final String password;

    Student({
        required this.name,
        required this.student_id,
        required this.major,
        required this.college,
        required this.email,
        required this.phoneNo,
        required this.password,
    });

    factory Student.fromJson(Map<String, dynamic> json) {
        return Student(
            name: json['name'],
            student_id: json['student_id'], // Ensure it matches the key in JSON
            major: json['major'],
            college: json['college'],
            email: json['email'],
            phoneNo: json['phoneNo'],
            password: json['password'],
        );
    }

  get profilePictureUrl => null;
}