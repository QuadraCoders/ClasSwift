import 'package:flutter/material.dart';
import 'package:classwift/api_service.dart';
import 'package:classwift/models/faculty_member.dart';
import 'package:classwift/pages/faculty_view.dart'; // Make sure this path is correct

class LogFaculty extends StatefulWidget {
  const LogFaculty({Key? key}) : super(key: key);

  @override
  _LogFacultyState createState() => _LogFacultyState();
}

class _LogFacultyState extends State<LogFaculty> {
  final TextEditingController facultyIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ApiService apiService = ApiService();

  bool facultyIdFieldError = false;
  bool passwordFieldError = false;
  bool _obscurePassword = true;

  void _checkFields() {
    String facultyId = facultyIdController.text.trim();
    setState(() {
      facultyIdFieldError = facultyId.isEmpty || !RegExp(r'^\d{4}$').hasMatch(facultyId);
      passwordFieldError = passwordController.text.trim().isEmpty;
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    'Welcome back Faculty Member!',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF224B65),
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: facultyIdController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Faculty ID',
                      labelStyle: const TextStyle(color: Color.fromARGB(255, 72, 134, 189)),
                      border: const OutlineInputBorder(),
                      errorText: facultyIdFieldError 
                          ? (facultyIdController.text.trim().isEmpty 
                              ? 'Faculty ID cannot be empty' 
                              : 'Invalid input, must be a 4-digit ID') 
                          : null,
                    ),
                    onChanged: (value) {
                      setState(() {
                        facultyIdFieldError = false; // Reset error state if valid
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Color.fromARGB(255, 72, 134, 189)),
                      border: const OutlineInputBorder(),
                      errorText: passwordFieldError ? 'Password cannot be empty' : null,
                      suffixIcon: GestureDetector(
                        onTap: _togglePasswordVisibility,
                        child: Icon(
                          _obscurePassword ? Icons.visibility : Icons.visibility_off,
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

                      if (facultyIdFieldError || passwordFieldError) {
                        _showSnackBar("Please fill in all fields correctly.");
                        return;
                      }

                      int enteredId = int.parse(facultyIdController.text.trim());
                      String enteredPassword = passwordController.text.trim();

                      try {
                        FacultyMember faculty = await apiService.facultyLogin(enteredId, enteredPassword);
                        
                        // Log the faculty details to confirm successful login
                        print('Faculty login success: ${faculty.name}, ID: ${faculty.id}');
                        
                        // Navigate to FacultyView
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                          return const FacultyView(); // Ensure this widget exists
                        }));
                      } catch (e) {
                        // Show an error if login fails
                        _showSnackBar("Login failed: ${e.toString()}");
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