// ignore_for_file: use_build_context_synchronously

import 'package:classwift/api_service.dart';
import 'package:classwift/models/Student.dart';
import 'package:flutter/material.dart';
import 'student_view.dart';

class LogStudent extends StatefulWidget {
  const LogStudent({Key? key}) : super(key: key);

  @override
  _LogStudentState createState() => _LogStudentState();
}

class _LogStudentState extends State<LogStudent> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ApiService apiService = ApiService();

  bool idFieldError = false;
  bool passwordFieldError = false;
  bool _obscurePassword = true;

  void _checkFields() {
    setState(() {
      idFieldError = !_isValidId(idController.text.trim());
      passwordFieldError = passwordController.text.trim().isEmpty;
    });
  }

  bool _isValidId(String id) {
    // Check if the ID is exactly 7 digits and numeric
    return RegExp(r'^\d{7}$').hasMatch(id);
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
                    'Welcome back Student!',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF224B65),
                    ),
                  ),
                  const Text(
                    'We’re happy to have you back',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFF224B65),
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: idController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'ID',
                      labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 72, 134, 189)),
                      border: const OutlineInputBorder(),
                      errorText: idFieldError
                          ? 'Invalid type. ID must be exactly 7 digits and numeric.'
                          : null,
                    ),
                    onChanged: (value) {
                      setState(() {
                        idFieldError = false; // Reset error state if valid
                      });
                    },
                    style: TextStyle(color: idFieldError ? Colors.red : null),
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
                          ? 'This field should not be empty'
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
                    style: TextStyle(
                        color: passwordFieldError ? Colors.red : null),
                  ),
                  const SizedBox(height: 5),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text('Forgot Password?'),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () async {
                      _checkFields(); // Check if fields are empty

                      if (idFieldError || passwordFieldError) {
                        _showSnackBar("Please fill in all fields correctly.");
                        return;
                      }

                      int enteredId = int.parse(idController.text.trim());
                      String enteredPassword = passwordController.text.trim();

                      try {
                        // Check if the student exists with this ID
                        Student student =
                            await apiService.fetchStudentById(enteredId);

                        if (student.password == enteredPassword) {
                          // Navigate to the StudentView if credentials are correct
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const StudentView();
                          }));
                        } else {
                          // Password is incorrect
                          _showSnackBar("Invalid ID/Password");
                        }
                      } catch (e) {
                        print(e); // Log the full exception for better debugging
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
