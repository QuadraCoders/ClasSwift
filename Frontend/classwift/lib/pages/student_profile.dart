import 'package:flutter/material.dart';
import 'package:classwift/models/Student.dart';
import 'package:classwift/api_service.dart'; // Update if necessary
import 'change_password_page.dart';
import 'view_profile_page.dart';
import 'report_issue_page.dart';
import 'student_view.dart'; // Adjust this according to your file structure

class ProfilePage extends StatefulWidget {
  final int? userId; // User ID passed during initialization

  const ProfilePage({Key? key, this.userId}) : super(key: key); 

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String studentName = "";
  String studentMajor = "";
  int studentId = 0; 
  String college = ""; 
  String email = ""; 
  String phoneNumber = ""; 
  bool isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    if (widget.userId != null) {
      fetchStudentData(); // Fetch data when the page initializes
    }
  }

  Future<void> fetchStudentData() async {
    try {
      Student student = await ApiService().fetchStudentById(widget.userId!);
      setState(() {
        // Update state with retrieved data
        studentName = student.name;
        studentMajor = student.major;
        studentId = student.student_id; 
        college = student.college; 
        email = student.email; 
        phoneNumber = student.phoneNo; 
        isLoading = false; // Set loading to false after fetching data
      });
    } catch (e) {
      print('Error fetching student data: $e');
      setState(() {
        isLoading = false; // Handle loading error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: Stack(
        children: [
          // Background image
          Container(
            width: screenSize.width,
            height: screenSize.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/wallpaper.png'), // Background image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: Image.asset(
              'lib/assets/logo.png',
              width: 100,
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  _buildProfilePicture(), // Profile Picture Section
                  const SizedBox(height: 20.0),
                  Text(
                    isLoading ? 'Loading...' : studentName.isNotEmpty ? studentName : "No Name",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 93, 93, 93)),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    isLoading ? 'Loading...' : studentMajor.isNotEmpty ? studentMajor : "No Major",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16.0, color: Color.fromARGB(255, 128, 128, 128)),
                  ),
                  const SizedBox(height: 40.0),
                  _buildIdCard(), // ID Card Section
                  const SizedBox(height: 40.0),
                  _buildProfileSettings(context), // Profile Settings Section
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      selectedItemColor: const Color.fromARGB(255, 83, 143, 208),
      unselectedItemColor: const Color.fromARGB(255, 181, 205, 218),
      onTap: (value) {
        Navigator.pop(context);
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: '')
      ],
    );
  }

  Widget _buildProfilePicture() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10.0),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 4.0, color: Color.fromARGB(200, 142, 187, 227)),
            ),
            child: const CircleAvatar(
              radius: 62.0,
              backgroundColor: Color.fromARGB(200, 142, 187, 227),
              child: CircleAvatar(
                radius: 60.0,
                backgroundImage: AssetImage('lib/assets/person.png'), // Default profile image
                backgroundColor: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIdCard() {
    return Card(
      elevation: 8.0,
      shadowColor: Colors.black54,
      color: const Color.fromARGB(200, 142, 187, 227),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                'lib/assets/uniCard.png', 
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSettings(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            const SizedBox(height: 30),
            const Text(
              'Profile Settings',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Color(0xFF224B65)),
            ),
            const SizedBox(height: 26.0),
            Card(
              color: Colors.grey[200],
              child: _buildListTile(
                context,
                Icons.person,
                'View Profile',
                ViewProfilePage(
                  userName: studentName,
                  major: studentMajor,
                  studentId: studentId,
                  college: college,
                  email: email,
                  phoneNumber: phoneNumber,
                ),
              ),
            ),
            Card(
              color: Colors.grey[200],
              child: _buildListTile(context, Icons.lock, 'Change Password', ChangePasswordPage()),
            ),
            Card(
              color: Colors.grey[200],
              child: _buildListTile(context, Icons.report_problem, 'Report Issue', ReportIssuePage()),
            ),
          ],
        ),
      ),
    );
  }

  ListTile _buildListTile(BuildContext context, IconData icon, String title, Widget page) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF224B65)),
      title: Text(
        title,
        style: const TextStyle(color: Color(0xFF224B65), fontWeight: FontWeight.w500),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page)); // Navigate to specified page
      },
    );
  }
}