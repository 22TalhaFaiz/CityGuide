import 'dart:async';
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
    _loadDataAndNavigate();
  }

  Future<void> _loadDataAndNavigate() async {
    // Simulating a network request or data fetching
    await Future.delayed(Duration(seconds: 4)); // Replace this with actual data fetching
    
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Lp()), // Ensure Lp has required data
      );
    }
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
                const SizedBox(height: 20),
                CircularProgressIndicator(
                  strokeWidth: 6,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
