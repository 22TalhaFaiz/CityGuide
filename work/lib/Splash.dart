import 'dart:async'; // Correct import for Timer
import 'package:flutter/material.dart';
import 'package:work/Lp.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    // Set a timer to navigate after 4 seconds
    Timer(Duration(seconds: 4), () {
      // Ensure the context is still valid for navigation
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Lp()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                Image.asset(
                  "assets/images/Black White Minimalist Monogram Initial Logo (1) - Copy.jpg",
                  width: 500,
                  height: 500,
                ),
                
                 CircularProgressIndicator(
                    strokeWidth: 6,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple,
                  ),
                 ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}