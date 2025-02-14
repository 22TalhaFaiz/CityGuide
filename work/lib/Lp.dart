import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:work/Home.dart';
import 'package:work/login.dart';
import 'package:work/signup.dart';

class Lp extends StatefulWidget {
  const Lp({super.key});

  @override
  State<Lp> createState() => _LpState();
}

class _LpState extends State<Lp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // Ensures the stack covers the entire screen
        children: [
          // Background Image
          Image.asset(
            "assets/images/pakistan's-most-famous-historic-monument-minar-e-pakistan-illuminated-440nw-10963713h.jpg",
            fit: BoxFit.cover, // Ensures the image covers the entire screen
          ),
          // Apply a blur effect (using BackdropFilter)
          BackdropFilter(
            filter:
                ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Adjust blur intensity
            child: Container(
              color: Colors.black
                  .withOpacity(0.3), // Semi-transparent dark overlay
            ),
          ),
          // Scrollable Content
          SingleChildScrollView(
            child: Align(
              alignment: Alignment.center, // Align content to the center
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo Image
                  Image.asset(
                    'assets/images/logoLP.png',
                    width: 500,
                  ),
                  const SizedBox(height: 100),
                  const Text(
                    "Discover the hidden gems, rich culture, & dynamic spirit of Pakistan's most captivating cities!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 200, // Fixed width for the button
                    height: 50, // Fixed height for the button
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to the Login page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const login(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.white, // Button background color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10), // Spacing between buttons
                  // Register Button
                  SizedBox(
                    width: 200, // Fixed width for the button
                    height: 50, // Fixed height for the button
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to the Register page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const signup(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.deepPurple, // Button background color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person_add,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Signup",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      // Navigate to the Home page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Home()),
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero, // Remove default padding
                      tapTargetSize: MaterialTapTargetSize
                          .shrinkWrap, // Reduce tap target size
                    ),
                    child: const Text(
                      "Continue as a Guest?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold, // Make the text bold
                        decoration: TextDecoration.underline, // Add underline
                        decorationColor: Colors.white, // Underline color
                        decorationThickness: 1.5, // Underline thickness
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
