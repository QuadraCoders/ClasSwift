import 'package:classwift/pages/student_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_provider.dart'; // Import the UserProvider

class LoginPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: 'Enter User ID'),
          ),
          ElevatedButton(
            onPressed: () {
              // Get the entered user ID
              String userId = _controller.text;

              // Save user ID in the provider
              Provider.of<UserProvider>(context, listen: false)
                  .setUser(User(userId));

              // Navigate to the next page
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => StudentView()),
              );
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}
