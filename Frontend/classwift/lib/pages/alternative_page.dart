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
    // Fetch building data on initial load
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
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Adjust the number of columns
                          crossAxisSpacing: 6.0,
                          mainAxisSpacing: 6.0,
                        ),
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

  Widget buildClassBox(Classroom classroom) {
    Color color = classroom.isALab
        ? const Color.fromARGB(255, 126, 181, 248)
        : const Color(0xFFD0F0C0);

    return Container(
      width: 160, // Fixed width
      height: 200, // Fixed height
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        color: color.withOpacity(0.8),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
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
              const SizedBox(height: 12),
              Text(
                'Classroom No: ${classroom.classroomNo}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Duration',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(classroom.duration.toString()),
                  ],
                ),
              ),
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
              const SizedBox(height: 5),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    // Show confirmation dialog
                    bool? confirmed = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Confirm Selection"),
                          content: Text(
                              "Are you sure you want to select Classroom No: ${classroom.classroomNo}?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: Text("Confirm"),
                            ),
                          ],
                        );
                      },
                    );

                    if (confirmed == true) {
                      try {
                        await apiService.updateClassroomAvailability(
                            classroom.classroomNo, false);
                        setState(() {
                          classroom.isAvailable = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  "Classroom ${classroom.classroomNo} is now reserved.")),
                        );
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  "Failed to update classroom availability")),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
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
