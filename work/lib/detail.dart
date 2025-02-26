import 'package:flutter/material.dart';

class detail extends StatefulWidget {
  const detail({super.key});

  @override
  State<detail> createState() => _detailState();
}

class _detailState extends State<detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,

          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                child: Container(
                  width: double.maxFinite,
                  height: 300,
                  decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/Lahore Museum.jpg"),
                    fit: BoxFit.cover,
                    ),
                    
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}