class MaintenanceStaff {
  final String name;
  final String staffId;
  final String department;
  final String phone;
  final String email;
  final String password;

  MaintenanceStaff({
    required this.name,
    required this.staffId,
    required this.department,
    required this.phone,
    required this.email,
    required this.password,
  });

  factory MaintenanceStaff.fromJson(Map<String, dynamic> json) {
    return MaintenanceStaff(
      name: json['name'],
      staffId: json['staff_id'],
      department: json['department'],
      phone: json['phone'],
      email: json['email'],
      password: json['password'],
    );
  }
}
