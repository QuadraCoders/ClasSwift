import 'package:classwift/pages/NavigationBarScreen.dart';
import 'package:flutter/material.dart';
import 'student_view.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        // Background Image
        Positioned.fill(
          child: Image.asset(
            'lib/assets/wallpapers (6).png', // Replace with your image path
            fit: BoxFit.cover, // Ensures the image covers the entire screen
          ),
        ),
        SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 30,
                ),
                // Logo on the top right
                Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    'lib/assets/logo.png',
                    width: 150,
                    height: 150,
                  ),
                ),
                const SizedBox(height: 20),
                // Title at the top left
                const Text(
                  'Welcome back!',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF224B65),
                  ),
                ),
                const Text(
                  'We’re happy to have you back',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF224B65),
                  ),
                ),

                const SizedBox(height: 30),
                // ID field
                TextField(
                  controller: idController,
                  decoration: const InputDecoration(
                    labelText: 'ID',
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 72, 134, 189)),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                // Password field
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 72, 134, 189)),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 5),
                // Forgot Password text
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot Password?',
                    //style: TextStyle(color: Color(0xFF81B2DD)),
                  ),
                ),

                const SizedBox(height: 30),
                // Login button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const NavigationBarScreen(); // Ensure this matches the constructor of your HomePage
                    }));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 119, 173, 220),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // Other login options text
                // const Text(
                //   'Other Login Options',
                //   style: TextStyle(
                //     fontSize: 16,
                //     fontWeight: FontWeight.bold,
                //     color: Color(0xFF224B65),
                //   ),
                //   textAlign: TextAlign.center,
                // ),
                // const SizedBox(height: 10),
                // // Centered Row for pressable boxes
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     GestureDetector(
                //       onTap: () {
                //         // Handle first image tap
                //       },
                //       child: Container(
                //         width: 60,
                //         height: 60,
                //         decoration: BoxDecoration(
                //           image: const DecorationImage(
                //             image:
                //                 NetworkImage('https://via.placeholder.com/60'),
                //             fit: BoxFit.cover,
                //           ),
                //           borderRadius: BorderRadius.circular(8),
                //           border: Border.all(color: Colors.blue, width: 1),
                //         ),
                //       ),
                //     ),
                //     const SizedBox(width: 20),
                //     GestureDetector(
                //       onTap: () {
                //         // Handle second image tap
                //       },
                //       child: Container(
                //         width: 60,
                //         height: 60,
                //         decoration: BoxDecoration(
                //           image: const DecorationImage(
                //             image:
                //                 NetworkImage('https://via.placeholder.com/60'),
                //             fit: BoxFit.cover,
                //           ),
                //           borderRadius: BorderRadius.circular(8),
                //           border: Border.all(color: Colors.blue, width: 1),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
