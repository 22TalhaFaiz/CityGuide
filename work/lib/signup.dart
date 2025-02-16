import 'package:flutter/material.dart';
import 'package:work/login.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: 
         SingleChildScrollView(  // Added ScrollView
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
               color: Colors.deepPurple
                ),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 57),
                    const Text(
                      "Create Account",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Create an account to explore the best of the city!",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),

                    // Card Container
                   
                    Container(
                      
                      width: double.infinity,
                      decoration: const BoxDecoration(
                         color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(80),
                          topLeft: Radius.circular(80),
                        ),
                      ),
                      padding: const EdgeInsets.all(42),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                    SizedBox(height: 30),

                           SizedBox(
                      width: 250,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Username",
                          prefixIcon: Icon(Icons.person, color: Colors.deepPurple,), // Email icon
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Colors.orangeAccent[50],
                          filled: true,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                          // Email input
                          SizedBox(
                      width: 250,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Email",
                          prefixIcon: Icon(Icons.email, color: Colors.deepPurple,), // Email icon
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Colors.orangeAccent[50],
                          filled: true,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Password input with icon
                    SizedBox(
                      width: 250,
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Phone",
                          prefixIcon: Icon(Icons.phone, color: Colors.deepPurple,), // Lock icon for password
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Colors.orangeAccent[50],
                          filled: true,
                        ),
                      ),
                    ),
                   
                          SizedBox(height: 20),
                    // Password input with icon
                    SizedBox(
                      width: 250,
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                        
                          hintText: "Password",
                          prefixIcon: Icon(Icons.lock, color: Colors.deepPurple,), // Lock icon for password
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                            
                          ),
                          fillColor: Colors.orangeAccent[50],
                          filled: true,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                  
                          // Sign-up button
                          SizedBox(
                            width: 250,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 50),
                                elevation: 10,
                                shadowColor: Colors.deepPurple.withOpacity(0.9),
                                backgroundColor: Colors.deepPurple,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text(
                                "Sign up",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Container(
      width: 50,
       
      decoration: BoxDecoration(
        color: Colors.grey[200], // Light background
        borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
      child: IconButton(
        onPressed: () {}, 
        icon: Icon(Icons.facebook, color: Colors.blue,), // Facebook Icon
      ),
    ),
SizedBox(width: 20,),
    Container(
      width: 50,
       
      decoration: BoxDecoration(
        color: Colors.grey[200], // Light background
        borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
      child: IconButton(
        onPressed: () {}, 
        icon: Icon(Icons.g_mobiledata , color: Colors.red,), // Facebook Icon
      ),
    ),

    SizedBox(width: 20,),
    Container(
      width: 50,
       
      decoration: BoxDecoration(
        color: Colors.grey[200], // Light background
        borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
      child: IconButton(
        onPressed: () {}, 
        icon: Icon(Icons.apple, color: Colors.black,), // Facebook Icon
      ),
    ),

  ],
),

                          const SizedBox(height: 20),

                          // Login navigation
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                "Already have an Account?",
                                style: TextStyle(color: Colors.black),
                              ),
                              TextButton(
                                onPressed: () {
                                Navigator.push(
                                 context, MaterialPageRoute(builder: (context) => login()));
                                },
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      
    );
  }

  
  }

  // Function for social media button styling
 
    
  

