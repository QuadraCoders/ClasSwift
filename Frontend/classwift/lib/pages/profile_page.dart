 // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:classwift/api_service.dart';
import 'package:classwift/models/Student.dart';
import 'package:classwift/pages/Demo.dart';
import 'package:classwift/pages/student_view.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
    final int? userId;
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

  @override
  void initState() {
    super.initState();
    if (widget.userId != null) {
      fetchStudentData(); // Fetch student data as soon as the profile page initializes
    }
  }
  Future<void> fetchStudentData() async {
    try {
      Student student = await ApiService().fetchStudentById(widget.userId!);
      setState(() {
        studentName = student.name;
        studentMajor = student.major;
        studentId = student.student_id; // Assign the student ID
        college = student.college; // Assign the college
        email = student.email; // Assign the email
        phoneNumber = student.phoneNo; // Assign the phone number
      });
    } catch (e) {
      print('Error fetching student data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    List screens = [const StudentView(), ProfilePage()];
    int currentIndex = 1;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color.fromARGB(255, 83, 143, 208),
        unselectedItemColor: const Color.fromARGB(255, 181, 205, 218),
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
          if (currentIndex == 0) {
            // Navigate to ProfilePage when profile icon is tapped
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StudentView()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: '')
        ],
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            width: screenSize.width,
            height: screenSize.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'lib/assets/wallpaper.png'), // Set your wallpaper image here
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Logo at the top right
          Positioned(
            top: 20,
            right: 20,
            child: Image.asset(
              'lib/assets/logo.png', // Set your logo image here
              width: 100, // Set desired width
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center the Column
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Center contents horizontally
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  // Profile Picture Section
                  _buildProfilePicture(),

                  const SizedBox(
                      height: 20.0), // Space between picture and name
                  Text(
                    studentName.isNotEmpty ? studentName : "Loading...",
                    style: const TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 93, 93, 93),
                    ),
                  ),

                  const SizedBox(
                      height: 10.0), // Space between name and additional info
                   Text(
                    studentMajor.isNotEmpty ? studentMajor : "Loading...",
                    textAlign: TextAlign.center, // Center the text
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color.fromARGB(255, 128, 128, 128),
                    ),
                  ),

                  const SizedBox(height: 40.0), // Space between sections

                  // ID Card Section
                  _buildIdCard(),

                  const SizedBox(height: 40.0), // Space between sections

                  // Profile Settings Section
                  _buildProfileSettings(context),
                ],
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
                'lib/assets/uniCard.png', // Ensure the path is correct
                // width: double.infinity,
                // height: 265.0,
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
        child: Container(
          //color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(),
              SizedBox(
                height: 30,
              ),
              const Text(
                'Profile Settings',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF224B65),
                ),
              ),
              const SizedBox(height: 26.0),
              Card(
                color: Colors.grey[200],
                child: _buildListTile(
                  context, 
                  Icons.person, 
                  'View Profile', 
                  ViewProfilePage(
                    userName: studentName, // Pass the fetched student name
                    major: studentMajor, // Pass the fetched student major
                    studentId: studentId, // Pass the fetched student ID
                    college: college, // Pass the fetched college
                    email: email, // Pass the fetched email
                    phoneNumber: phoneNumber, // Pass the fetched phone number
                  ),
                ),
              ),
              Card(
                color: Colors.grey[200],
                child: _buildListTile(context, Icons.lock, 'Reset Password',
                    ChangePasswordPage()),
              ),
              Card(
                color: Colors.grey[200],
                child: _buildListTile(context, Icons.report_problem,
                    'Report Issue', ReportIssuePage()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListTile _buildListTile(BuildContext context, IconData icon, String title, Widget page) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF224B65)),
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF224B65),
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewProfilePage(
              userName: studentName,
              major: studentMajor,
              studentId: studentId, // Pass the student ID
              college: college, // Pass the college
              email: email, // Pass the email
              phoneNumber: phoneNumber, // Pass the phone number
              ),
          ),
        );
      },
    );
  }
}

class ViewProfilePage extends StatelessWidget {

  final String userName;
  final int studentId; // Keep studentId as int
  final String major;
  final String college; // Correct spelling to college
  final String email;
  final String phoneNumber;

  const ViewProfilePage({Key? key, required this.userName, required this.major, required this.studentId, required this.college, required this.email, required this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View profile'),
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'lib/assets/wallpapers (4).png', // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              // Wrap the entire content in a SingleChildScrollView
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildProfilePicture(),

                      const SizedBox(
                          width: 20.0), // Space between picture and name
                      Column(
                        children: [
                           Text(
                            userName,
                            // Use the passed username
                            textAlign: TextAlign.center, // Center the text
                            style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 93, 93, 93),
                            ),
                          ),
                           Text(
                              major,
                            textAlign: TextAlign.center, // Center the text
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Color.fromARGB(255, 128, 128, 128),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  _buildTextField('Name', 'Enter your name', userName),
                  SizedBox(height: 16),
                  _buildTextField('ID', 'Enter your email', studentId.toString()),
                  SizedBox(height: 16),
                  _buildTextField('Major', 'Enter your phone number', major),
                  SizedBox(height: 16),
                  _buildTextField('Department', 'Enter your collage', college),
                  SizedBox(height: 16),
                  _buildTextField('Email', 'Enter your email', email),
                  SizedBox(height: 16),
                  _buildTextField(
                      'Phone Number', 'Enter your phone number', phoneNumber),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// widgets for view profile
Widget _buildTextField(String label, String hint, String retrievedData) {
  // Create a TextEditingController to manage the text field
  TextEditingController controller = TextEditingController(text: retrievedData);

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
      const SizedBox(height: 8),
      Container(
        color: Colors.white,
        child: TextField(
          controller: controller, // Use the controller to set the text
          readOnly: true, // Make the text field uneditable
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

class ReportIssuePage extends StatefulWidget {
  const ReportIssuePage({super.key});

  @override
  State<ReportIssuePage> createState() => _ReportIssuePageState();
}

class _ReportIssuePageState extends State<ReportIssuePage> {
  // Issue choices and their states
  final Map<String, bool> issueChoices = {
    'Loading events': false,
    'Showing available classes': false,
    'Filling up a report': false,
    'Submitting your report': false,
    'Other': false,
  };

  // Selected contact preference
  String? selectedContact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Issue'),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'lib/assets/wallpapers (4).png', // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'Report an issue with ClasSwift',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'We are sorry you are facing trouble. Please provide the details below so we can assist you as quickly as possible.',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w200),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Divider(endIndent: 30, indent: 30),
                  SizedBox(
                    height: 50,
                  ),
                  // Issue Type Section
                  const Text(
                    'Which of the following options best describes the type of issue you are experiencing?',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  // Checkboxes for issue types
                  ...issueChoices.keys.map((key) {
                    return CheckboxListTile(
                      title: Text(key),
                      value: issueChoices[key],
                      onChanged: (value) {
                        setState(() {
                          issueChoices[key] = value!;
                        });
                      },
                    );
                  }).toList(),
                  const SizedBox(height: 30),
                  // Description Field
                  const Text(
                    'Please describe the problem you are experiencing in the space below. Be as descriptive as possible so we can be sure to help you as best as we can.',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    color: Colors.white,
                    child: TextField(
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText:
                            'Ex. Every time I click reports history, it disappears instead of taking me to the detailed history page.',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Contact Preference Section
                  const Text(
                    'How would you like us to contact you? Please select an option from the list below.',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  RadioListTile(
                    title: const Text('Phone call'),
                    value: 'phone',
                    groupValue: selectedContact,
                    onChanged: (value) {
                      setState(() {
                        selectedContact = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text('Text message'),
                    value: 'text',
                    groupValue: selectedContact,
                    onChanged: (value) {
                      setState(() {
                        selectedContact = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text('Email'),
                    value: 'email',
                    groupValue: selectedContact,
                    onChanged: (value) {
                      setState(() {
                        selectedContact = value.toString();
                      });
                    },
                  ),
                  const SizedBox(height: 30),
                  // Submit Button
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Message Sent!")),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16), // Button height
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Send Message",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildProfilePicture() {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10.0), // Space before the avatar
        // Border around profile picture
        Container(
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
              backgroundImage: AssetImage(
                  'lib/assets/person.png'), // Use the correct asset path
              backgroundColor:
                  Colors.grey, // Fallback color if image fails to load
            ),
          ),
        ),
      ],
    ),
  );
}