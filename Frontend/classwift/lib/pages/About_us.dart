import 'package:flutter/material.dart';

class about_us extends StatelessWidget {
  const about_us({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // App Logo or Image
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/app_logo.png'), // Update the image path as needed
              ),
            ),
            const SizedBox(height: 20),

            // Title
            const Text(
              'Welcome to MyApp!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),

            // Description
            const Text(
              'MyApp is your go-to solution for managing tasks efficiently and boosting productivity. '
              'Our mission is to provide a seamless user experience and help you achieve your goals.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Features List
            const Text(
              'Key Features:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(' Easy Task Management'),
                Text('✔ Real-Time Collaboration'),
                Text('✔ Intuitive Design'),
                Text('✔ Secure Data Handling'),
              ],
            ),
            const Spacer(),

            // Contact Information
            Column(
              children: const [
                Text(
                  'Contact Us',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text('Email: support@myapp.com'),
                Text('Website: www.myapp.com'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
