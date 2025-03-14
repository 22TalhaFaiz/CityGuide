// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:work/Home.dart';
// import 'package:work/Karachi.dart';
// import 'package:work/lahore.dart';
// import 'package:work/login.dart';
// import 'package:work/signup.dart';

// class Lp extends StatefulWidget {
//   const Lp({super.key});

//   @override
//   State<Lp> createState() => _LpState();
// }

// class _LpState extends State<Lp> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         fit: StackFit.expand, // Ensures the stack covers the entire screen
//         children: [
//           // Background Image
//           Image.asset(
//             "assets/images/pakistan's-most-famous-historic-monument-minar-e-pakistan-illuminated-440nw-10963713h.jpg",
//             fit: BoxFit.cover, // Ensures the image covers the entire screen
//           ),
//           // Apply a blur effect (using BackdropFilter)
//           BackdropFilter(
//             filter:
//                 ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Adjust blur intensity
//             child: Container(
//               color: Colors.black
//                   .withOpacity(0.3), // Semi-transparent dark overlay
//             ),
//           ),
//           // Scrollable Content
//           SingleChildScrollView(
//             child: Align(
//               alignment: Alignment.center, // Align content to the center
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Logo Image
//                   Image.asset(
//                     'assets/images/logoLP.png',
//                     width: 500,
//                   ),
//                   const SizedBox(height: 100),
//                   const Text(
//                     "Discover the hidden gems, rich culture, & dynamic spirit of Pakistan's most captivating cities!",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 15,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   SizedBox(
//                     width: 200, // Fixed width for the button
//                     height: 50, // Fixed height for the button
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // Navigate to the Login page
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => login(),
//                           ),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor:
//                             Colors.white, // Button background color
//                         shape: RoundedRectangleBorder(
//                           borderRadius:
//                               BorderRadius.circular(10), // Rounded corners
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.person,
//                             color: Colors.black,
//                           ),
//                           SizedBox(width: 10),
//                           Text(
//                             "Login",
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 10), // Spacing between buttons
//                   // Register Button
//                   SizedBox(
//                     width: 200, // Fixed width for the button
//                     height: 50, // Fixed height for the button
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // Navigate to the Register page
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const Signup(),
//                           ),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor:
//                             Colors.deepPurple, // Button background color
//                         shape: RoundedRectangleBorder(
//                           borderRadius:
//                               BorderRadius.circular(10), // Rounded corners
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.person_add,
//                             color: Colors.white,
//                           ),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Text(
//                             "Signup",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   TextButton(
//                     onPressed: () {
//                       // Navigate to the Home page
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => const Home()),
//                       );
//                     },
//                     style: TextButton.styleFrom(
//                       padding: EdgeInsets.zero, // Remove default padding
//                       tapTargetSize: MaterialTapTargetSize
//                           .shrinkWrap, // Reduce tap target size
//                     ),
//                     child: const Text(
//                       "Continue as a Guest?",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 15,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold, // Make the text bold
//                         decoration: TextDecoration.underline, // Add underline
//                         decorationColor: Colors.white, // Underline color
//                         decorationThickness: 1.5, // Underline thickness
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
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
  bool isLiked = false; // State variable for the like button

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          height: screenHeight, // Set fixed height
          child: Stack(
            children: [
              // Background with gradient overlay
              Positioned(
                left: 0,
                right: 0,
                child: Container(
                  width: screenWidth,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          "assets/images/pngtree-lahore-skyline-with-color-landmarks-blue-sky-and-copy-space-png-image_15532952.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                     
                    ),
                  ),
                ),
              ),
              // Foreground Card
              Positioned(
                top: 270,
                child: Container(
                  width: screenWidth,
                  height: screenHeight - 270, // Adjust height dynamically
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.grey.shade200, // Solid white at the bottom
                        Colors.deepPurple.shade200, // Deep purple at the top
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(80),
                      topRight: Radius.circular(80),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 40), // Added spacing at the top
                      Text(
                        "Start Exploring the \n  City's best spots",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.w900,
                          fontSize: 30,
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.deepPurple.withOpacity(0.3),
                              offset: Offset(3, 3),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Discover top attractions, restaurants, events,\n          in City with our easy-to guide!",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ),
                      SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Signup Button
                            SizedBox(
                              width: 150,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) =>
                                        Signup(), // Corrected Class Name
                                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                        return FadeTransition(
                                          opacity: animation,
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  elevation: 10,
                                  shadowColor: Colors.deepPurple.withOpacity(0.9),
                                  backgroundColor: Colors.deepPurple,
                                  foregroundColor: Colors.white,
                                ),
                                child: Text(
                                  "Signup",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(width: 25),
                            // Login Button
                            SizedBox(
                              width: 150,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) =>
                                          login(), // Corrected Class Name
                                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                        return FadeTransition(
                                          opacity: animation,
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  elevation: 10,
                                  shadowColor: Colors.black.withOpacity(0.9),
                                  backgroundColor: Colors.grey[50],
                                  foregroundColor: Colors.black,
                                ),
                                child: Text(
                                  "Login",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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

