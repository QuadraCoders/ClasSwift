import 'package:flutter/material.dart';

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
