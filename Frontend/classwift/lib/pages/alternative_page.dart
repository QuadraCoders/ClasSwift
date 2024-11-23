import 'package:classwift/api_service.dart';
import 'package:classwift/models/Classroom.dart';
import 'package:classwift/models/building.dart';
import 'package:flutter/material.dart';

class AlternativePage extends StatefulWidget {
  final String title;

  const AlternativePage({Key? key, required this.title}) : super(key: key);

  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<AlternativePage> {
  late Future<Building> futureBuilding;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    // Use the ApiService to fetch classroom data
    futureBuilding = apiService.fetchBuildingData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Alternative Classes'),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/wallpapers (3).png'),
            fit: BoxFit.fill, // Cover the entire screen
          ),
        ),
        child: FutureBuilder<Building>(
          future: futureBuilding,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              Building building = snapshot.data!;
              final availableClassrooms = building.classrooms
                  .where((classroom) => classroom.isAvailable)
                  .toList();

              return Padding(
                padding: const EdgeInsets.all(
                    16.0), // Padding around the entire content
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        'Alternative Classrooms in building 11',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Divider(endIndent: 25, indent: 25),
                    const SizedBox(height: 30),
                    Expanded(
                      // This makes the GridView take the remaining space
                      child: GridView(
                        physics:
                            const BouncingScrollPhysics(), // Give it a nice bounce effect
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Adjust the number of columns
                          crossAxisSpacing: 12.0,
                          mainAxisSpacing: 12.0,
                        ),
                        // Convert classrooms into widgets using `.map()`
                        children: availableClassrooms.map((classroom) {
                          return buildClassBox(classroom);
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

//   Widget buildClassBox(Classroom classroom) {
//     Color color = classroom.isALab
//         ? const Color.fromARGB(255, 126, 181, 248)
//         : const Color(0xFFD0F0C0);

//     return Container(
//       width: 160, // Fixed width
//       height: 180, // Fixed height
//       child: Card(
//         elevation: 2,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12.0),
//         ),
//         color: color.withOpacity(0.8),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0), // Padding inside the card
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   color: classroom.isALab ? Colors.blue : Colors.green,
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//                 padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                 child: Text(
//                   classroom.isALab ? 'Lab' : 'Class',
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 12,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 12), // Space between label and title
//               Text(
//                 'Classroom No: ${classroom.classroomNo}',
//                 style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//               const SizedBox(height: 10), // Space between title and details

//               Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'Floor',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     Text(classroom.floor.toString()),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'Capacity',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     Text(classroom.capacity.toString()),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 20),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 15, vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     backgroundColor: Color.fromARGB(255, 255, 255, 250),
//                   ),
//                   child: const Text(
//                     'Select class',
//                     style: TextStyle(color: Colors.black, fontSize: 16),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//  }
  Widget buildClassBox(Classroom classroom) {
    Color color = classroom.isALab
        ? const Color.fromARGB(255, 126, 181, 248)
        : const Color(0xFFD0F0C0);

    return Container(
      width: 160, // Fixed width
      height: 180, // Fixed height
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        color: color.withOpacity(0.8),
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Padding inside the card
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: classroom.isALab ? Colors.blue : Colors.green,
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                child: Text(
                  classroom.isALab ? 'Lab' : 'Class',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 12), // Space between label and title
              Text(
                'Classroom No: ${classroom.classroomNo}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10), // Space between title and details

              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Floor',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(classroom.floor.toString()),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Capacity',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(classroom.capacity.toString()),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Show the popup when the button is clicked
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return FeedbackPopup(
                          message:
                              "You selected Classroom No: ${classroom.classroomNo}",
                          isSuccess: true,
                          onClose: () {
                            // Update the classroom state here
                            setState(() {
                              classroom.isAvailable = false;
                            });
                            Navigator.of(context).pop(); // Close the dialog
                          },
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    backgroundColor: const Color.fromARGB(255, 255, 255, 250),
                  ),
                  child: const Text(
                    'Select class',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeedbackPopup extends StatelessWidget {
  final String message;
  final bool isSuccess;
  final VoidCallback onClose;

  const FeedbackPopup({
    required this.message,
    required this.isSuccess,
    required this.onClose,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSuccess ? Icons.check_circle : Icons.error,
              color: isSuccess ? Colors.green : Colors.red,
              size: 50,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onClose,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: Colors.grey[200],
              ),
              child: const Text(
                'Confirm selection',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
