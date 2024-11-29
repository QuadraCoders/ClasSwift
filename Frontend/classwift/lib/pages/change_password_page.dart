import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _PasswordResetScreenState createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<ChangePasswordPage> {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: Stack(children: [
        // Background Image
        Positioned.fill(
          child: Image.asset(
            'lib/assets/wallpapers (4).png', // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Reset your password',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Enter the email address you used to register.',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w200),
                    ),
                    SizedBox(height: 20),
                    Container(
                      color: Colors.white,
                      child: TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Handle "Forgot email address" logic here
                        print('Forgot email address');
                      },
                      child: Text(
                        'Forgot or lost your email address?',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Center(
                  child: SizedBox(
                    width:
                        double.infinity, // Makes the button take the full width
                    child: ElevatedButton(
                      onPressed: () {
                        // Add your action here
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Message Sent!")),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: 16), // Matches text field height
                        backgroundColor: Colors.black, // Customize button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              8), // Matches text field corners
                        ),
                      ),
                      child: Text(
                        "Send Instructions",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}