import 'package:flutter/material.dart';
import 'package:classwift/api_service.dart';
import 'package:classwift/models/maintenace_staff.dart';
import 'package:classwift/pages/MaintenanceView.dart';

class LogMaintenance extends StatefulWidget {
  const LogMaintenance({Key? key}) : super(key: key);

  @override
  _LogMaintenanceState createState() => _LogMaintenanceState();
}

class _LogMaintenanceState extends State<LogMaintenance> {
  final TextEditingController staffIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ApiService apiService = ApiService();

  bool staffIdFieldError = false;
  bool passwordFieldError = false;
  bool _obscurePassword = true;

  // Regular expression to validate staff ID format "XX000"
  final RegExp staffIdFormat = RegExp(r'^[A-Za-z]{2}\d{3}$');

  void _checkFields() {
    String staffId = staffIdController.text.trim();
    setState(() {
      staffIdFieldError = staffId.isEmpty || !staffIdFormat.hasMatch(staffId);
      passwordFieldError = passwordController.text.trim().isEmpty;
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'lib/assets/wallpapers (6).png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      'lib/assets/logo.png',
                      width: 150,
                      height: 150,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Welcome back Maintenance Staff!',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF224B65),
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: staffIdController,
                    decoration: InputDecoration(
                      labelText: 'Staff ID',
                      labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 72, 134, 189)),
                      border: const OutlineInputBorder(),
                      errorText: staffIdFieldError
                          ? (staffIdController.text.trim().isEmpty
                              ? 'Staff ID cannot be empty'
                              : 'Invalid input, must follow the format "XX000"')
                          : null,
                    ),
                    onChanged: (value) {
                      setState(() {
                        staffIdFieldError = false; // Reset error state if valid
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 72, 134, 189)),
                      border: const OutlineInputBorder(),
                      errorText: passwordFieldError
                          ? 'Password cannot be empty'
                          : null,
                      suffixIcon: GestureDetector(
                        onTap: _togglePasswordVisibility,
                        child: Icon(
                          _obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        passwordFieldError = false; // Reset error state
                      });
                    },
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () async {
                      _checkFields(); // Check if fields are empty

                      if (staffIdFieldError || passwordFieldError) {
                        _showSnackBar("Please fill in all fields correctly.");
                        return;
                      }

                      String enteredId = staffIdController.text.trim();
                      String enteredPassword = passwordController.text.trim();

                      try {
                        // Fetch the maintenance staff by ID and check password
                        MaintenanceStaff staff = await apiService
                            .fetchMaintenanceStaffById(enteredId);

                        if (staff.password == enteredPassword) {
                          // Navigate to the MaintenanceView if credentials are correct
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return const Maintenanceview();
                          }));
                        } else {
                          _showSnackBar("Invalid ID/Password");
                        }
                      } catch (e) {
                        // Error handling for login failure
                        _showSnackBar('Error: ${e.toString()}');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 119, 173, 220),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
