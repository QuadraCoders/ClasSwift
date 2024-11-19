import 'dart:convert';
import 'package:classwift/models/Classroom.dart';
import 'package:classwift/models/building.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ServicesPage extends StatefulWidget {
  final String title;

  const ServicesPage({Key? key, required this.title}) : super(key: key);

  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  late Future<Building> futureBuilding;

  Future<Building> loadBuildingData() async {
    final String response =
        await rootBundle.loadString('lib/assets/building11.json');
    final data = await json.decode(response);
    return Building.fromJson(data);
  }

  @override
  void initState() {
    super.initState();
    futureBuilding = loadBuildingData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/wallpapers (3).png'),
            fit: BoxFit.cover, // Cover the entire screen
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
                    Center(
                      child: Text(
                        'Building 11',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          shadows: [
                            Shadow(
                              offset: const Offset(
                                  2.0, 2.0), // Shadow offset for a better look
                              blurRadius: 5.0,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Available Classrooms',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      // This makes the GridView take the remaining space
                      child: GridView.builder(
                        physics:
                            const BouncingScrollPhysics(), // Give it a nice bounce effect
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              2, // Adjust the number of columns based on available space
                          crossAxisSpacing: 12.0,
                          mainAxisSpacing: 12.0,
                        ),
                        itemCount: availableClassrooms.length,
                        itemBuilder: (context, index) {
                          Classroom classroom = availableClassrooms[index];
                          return buildClassBox(classroom);
                        },
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
      constraints: const BoxConstraints(
          minHeight: 120), // Ensure each class box has a minimum height
      child: Stack(
        children: [
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            color: color.withOpacity(0.8),
            child: ExpansionTile(
              title: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 8,
                      width: 30,
                      decoration: BoxDecoration(
                        color: classroom.isALab ? Colors.blue : Colors.green,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Classroom No: ${classroom.classroomNo}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white
                        .withOpacity(0.5), // Set a transparent background
                    borderRadius: const BorderRadius.vertical(
                        bottom:
                            Radius.circular(12.0)), // Match the card's radius
                  ),
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildDetailRow('Floor:', classroom.floor.toString()),
                        buildDetailRow(
                            'Capacity:', classroom.capacity.toString()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 10, // Position the label
            left: 10,
            child: Container(
              decoration: BoxDecoration(
                color: classroom.isALab
                    ? Colors.blue.withOpacity(0.5)
                    : Colors.green.withOpacity(0.5),
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              child: Text(
                classroom.isALab ? 'Lab' : 'Class',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}
