// ignore: unused_import
import 'package:classwift/pages/Availability_Page.dart';
import 'package:flutter/material.dart';

class ServicesCard extends StatelessWidget {
  final iconImagePath;
  final String serviceName;
  final pageName;
  final String pageTitle;

// constructor to change icon and service in every card
  const ServicesCard({super.key, 
    required this.iconImagePath,
    required this.serviceName,
    required this.pageName,
    required this.pageTitle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return pageName;
        }));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 5), // space between each card

        child: Card(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            child: Row(
              children: [
                Image.asset(
                  iconImagePath,
                  height: 40,
                ),
                const SizedBox(width: 10),
                Text(
                  serviceName,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
