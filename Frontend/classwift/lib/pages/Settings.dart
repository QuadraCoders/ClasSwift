import 'package:flutter/material.dart';
import 'student_view.dart'; // Ensure to import the HomePage

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String selectedLanguage = 'English'; // Default selected language
  bool showPersonalPic = false;
  bool showID = false;
  bool isDarkMode = false;
  bool reportsStatus = false;
  bool eventsAnnouncements = false;
  bool isDataUsageExpanded = false; // State for Data Usage expansion
  bool isDataPrivacyExpanded = false; // State for Data Privacy expansion

  // Define pastel colors
  final Color pastelYellow = Color(0xFFFFEBA0); // Pastel yellow color
  final Color pastelDarkBlue =
      Color.fromARGB(255, 87, 123, 232); // Pastel dark blue for moon
  final Color darkSunColor =
      Color.fromARGB(255, 255, 214, 32); // Darker pastel yellow for sun
  final Color policyIconColor =
      Color.fromARGB(255, 88, 200, 163); // Policy icon color

  // Define dark grey color for inactive switch
  final Color darkGrey = Color.fromARGB(255, 122, 120, 120);

  // Language options
  final Map<String, String> languages = {
    'ع': 'Arabic', // Arabic
    'E': 'English', // English
    '中': 'Chinese', // Chinese
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/wallpapers (4).png'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          children: [
            // General Section: Language & Theme
            _buildGroupLabel('General'),
            _buildLanguageDropdown(),
            _buildDarkModeSwitch(),

            // Display Section: ID & Picture
            _buildGroupLabel('Display'),
            _buildSwitchListTile(
              title: 'Show Personal Picture',
              value: showPersonalPic,
              onChanged: (value) {
                setState(() {
                  showPersonalPic = value;
                });
              },
            ),
            _buildSwitchListTile(
              title: 'Show ID',
              value: showID,
              onChanged: (value) {
                setState(() {
                  showID = value;
                });
              },
            ),

            // Manage Notifications Section
            _buildGroupLabel('Manage Notifications'),
            _buildSwitchListTile(
              title: 'Reports Status',
              value: reportsStatus,
              onChanged: (value) {
                setState(() {
                  reportsStatus = value;
                });
              },
            ),
            _buildSwitchListTile(
              title: 'Events Announcements',
              value: eventsAnnouncements,
              onChanged: (value) {
                setState(() {
                  eventsAnnouncements = value;
                });
              },
            ),

            // Policies Section
            _buildGroupLabel('Policies'),
            _buildExpandablePolicyTile(
              title: 'Data Usage',
              isExpanded: isDataUsageExpanded,
              onTap: () {
                setState(() {
                  isDataUsageExpanded = !isDataUsageExpanded;
                });
              },
              content: 'عندك ملفات جميلة',
              icon: Icons.storage, // Example icon
            ),
            _buildExpandablePolicyTile(
              title: 'Data Privacy',
              isExpanded: isDataPrivacyExpanded,
              onTap: () {
                setState(() {
                  isDataPrivacyExpanded = !isDataPrivacyExpanded;
                });
              },
              content: 'لا خوف عليكم كلاسويفت لديكم',
              icon: Icons.privacy_tip, // Example icon
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupLabel(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Text(
        label,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildLanguageDropdown() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: _boxDecoration(),
      child: ListTile(
        title: Text('Language', style: TextStyle(fontSize: 18)),
        trailing: DropdownButton<String>(
          value: languages.entries
              .firstWhere((entry) => entry.value == selectedLanguage)
              .key,
          icon: Icon(Icons.arrow_drop_down),
          onChanged: (String? newValue) {
            setState(() {
              selectedLanguage = languages[newValue!]!;
            });
          },
          items: languages.entries.map((entry) {
            return DropdownMenuItem<String>(
              value: entry.key,
              child: Text(entry.key, style: TextStyle(fontSize: 18)),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildSwitchListTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: _boxDecoration(),
      child: ListTile(
        title: Text(title, style: TextStyle(fontSize: 18)),
        trailing: Switch(
          value: value,
          onChanged: onChanged, // Directly pass the onChanged function
          activeTrackColor: Color(0xFF81B2DD),
          activeColor: Colors.white,
          inactiveThumbColor: darkGrey,
          inactiveTrackColor: const Color.fromARGB(255, 238, 236, 236),
        ),
      ),
    );
  }

  Widget _buildDarkModeSwitch() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: _boxDecoration(),
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Theme', style: TextStyle(fontSize: 18)),
            Icon(
              isDarkMode ? Icons.nights_stay : Icons.wb_sunny,
              color: isDarkMode ? pastelDarkBlue : darkSunColor,
            ),
          ],
        ),
        trailing: Switch(
          value: isDarkMode,
          onChanged: (value) {
            setState(() {
              isDarkMode = value;
            });
          },
          activeTrackColor: Color(0xFF224B65),
          activeColor: Colors.white,
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: pastelYellow,
        ),
      ),
    );
  }

  Widget _buildExpandablePolicyTile({
    required String title,
    required bool isExpanded,
    required VoidCallback onTap,
    required String content,
    required IconData icon,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(icon, color: policyIconColor),
                      SizedBox(width: 10),
                      Text(title,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Icon(
                      isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
          if (isExpanded) ...[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Text(
                content,
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),
          ],
        ],
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white.withOpacity(0.8),
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    );
  }
}
