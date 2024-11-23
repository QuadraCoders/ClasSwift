// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Contact Us'),
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'lib/assets/wallpapers (5).png', // Replace with your image path
              fit: BoxFit.cover, // Ensures the image covers the entire screen
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 80,
                            ),
                            Text(
                              'Contact our team',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                            Text(
                              'We’re here to help! Feel free to reach out for \nquestions, feedback, or support.',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 22,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 100),
                          ],
                        ),
                      ),

                      // First Name
                      _buildTextField("First Name", "First name"),
                      SizedBox(height: 20),

                      // Last Name
                      _buildTextField("Last Name", "Last name"),
                      SizedBox(height: 20),

                      // Email
                      _buildTextField("Email", "Email"),
                      SizedBox(height: 20),

                      // Phone Number
                      _buildTextField("Phone Number", "Phone number"),
                      SizedBox(height: 20),

                      // Message
                      Text(
                        "Message",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        color: Colors.white,
                        child: TextField(
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: "Type your message here...",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),

                      // Send Message Button

                      Center(
                        child: SizedBox(
                          width: double
                              .infinity, // Makes the button take the full width
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
                              backgroundColor:
                                  Colors.black, // Customize button color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    8), // Matches text field corners
                              ),
                            ),
                            child: Text(
                              "Send Message",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ),

                      //call us
                      SizedBox(
                        height: 100,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(
                            16.0), // Adjust padding for spacing
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Call us',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Call our team Sun-Thu from 9am to 5pm.',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[
                                    600], // Light color for secondary text
                              ),
                            ),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  size: 20,
                                  color: Colors.black87,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  '+966 555 666 9999',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(
                            16.0), // Adjust padding for spacing
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email us',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.email,
                                  size: 20,
                                  color: Colors.black87,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'ClasSwift@uj.edu.sa',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method for text fields
  Widget _buildTextField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Container(
          color: Colors.white,
          child: TextField(
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
