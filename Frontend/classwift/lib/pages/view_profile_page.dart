import 'package:flutter/material.dart';

class ViewProfilePage extends StatelessWidget {
  final String userName;
  final String major;
  final int studentId;
  final String email;
  final String college;
  final String phoneNumber;

  const ViewProfilePage({
    Key? key,
    required this.userName,
    required this.major,
    required this.studentId,
    required this.email,
    required this.college,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('View Profile'),
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            width: screenSize.width,
            height: screenSize.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/wallpapers (4).png'), // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Profile Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  // Profile Picture Section
                  _buildProfilePicture(),
                  const SizedBox(height: 20.0),
                  // User name
                  Text(
                    userName.isNotEmpty ? userName : "No Name",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 93, 93, 93),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  // Major
                  Text(
                    major.isNotEmpty ? major : "No Major",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Color.fromARGB(255, 128, 128, 128),
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  // Profile Settings Section
                  _buildProfileDetails(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          color: Colors.white.withOpacity(0.8), // Set withOpacity for transparency
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              const SizedBox(height: 10),
              const Text(
                'Profile Information',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF224B65),
                ),
              ),
              const SizedBox(height: 16.0),
              _buildTextField('Name', userName),
              _buildTextField('ID', studentId.toString()),
              _buildTextField('Major', major),
              _buildTextField('College', college),
              _buildTextField('Email', email),
              _buildTextField('Phone Number', phoneNumber),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePicture() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 4.0,
            color: Color.fromARGB(200, 142, 187, 227),
          ),
        ),
        child: const CircleAvatar(
          radius: 62.0,
          backgroundColor: Color.fromARGB(200, 142, 187, 227),
          child: CircleAvatar(
            radius: 60.0,
            backgroundImage: AssetImage('lib/assets/person.png'), // Replace with your image path
            backgroundColor: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            color: Colors.white.withOpacity(0.8), // Set withOpacity for transparency
            child: TextField(
              controller: TextEditingController(text: value),
              readOnly: true, // Make the text field uneditable
              decoration: InputDecoration(
                hintText: 'Enter $label',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}