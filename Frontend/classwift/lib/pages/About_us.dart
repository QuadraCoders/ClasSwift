import 'package:flutter/material.dart';

class about_us extends StatefulWidget {
  const about_us({super.key});

  @override
  State<about_us> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<about_us> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('About Us'),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'lib/assets/wallpapers (3).png',
              fit: BoxFit.cover, 
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
                      Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 80,
                            ),
                            Text(
                              'About Us',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                            Text(
                              'Learn more about who we are and what we do.',
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
                      SizedBox(),
                      Text(
                        "About us",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "We help schools and universities manage classrooms and maintenance more easily. Our platform makes it simple to book classrooms, check availability, and report maintenance issues, saving time and reducing disruptions.",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 55),
                      Text(
                        "Our Mission",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Our mission is to provide an easy-to-use platform that helps schools manage classroom bookings and maintenance, making everything run more smoothly.",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 55),
                      Text(
                        "Our Vision",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Our vision is to be the top solution for classroom and maintenance management, helping schools run efficiently and focus on teaching.",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 90),
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
}
