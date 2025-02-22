import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work/Home.dart';
import 'package:work/database_service.dart';

import 'package:work/forgetpassword.dart';
import 'package:work/signup.dart';
import 'profile.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> handleLogin() async {
    setState(() => isLoading = true);

    String _email = _emailController.text.trim();
    String _password = _passwordController.text.trim();

    String? result = await DatabaseService().loginUser(_email, _password);

    setState(() => isLoading = false);

    if (result == "Login Successfully") {
      // Fetch User Details from Firestore
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Save user session details to SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('userName', user.displayName ?? 'Unknown');
        prefs.setString('userEmail', user.email ?? 'Unknown');
      } else {
        // For Guest
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('userName', 'Guest');
        prefs.setString('userEmail', 'guest@example.com');
      }

      // Redirect to Home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } else {
      ScaffoldMessenger.of(context)

          .showSnackBar(SnackBar(content: Text(result!)));

         

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Remove solid color
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: Colors.deepPurple),
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 100),
                Text(
                  "Login Account ",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w900),
                ),
                Text(
                  "Welcome Back",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(80),
                      topLeft: Radius.circular(80),
                    ),
                  ),
                  padding: const EdgeInsets.all(65),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                      ),

                      SizedBox(
                        width: 250,
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: "Email",
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.deepPurple,
                            ), // Email icon
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
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Password",
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.deepPurple,
                            ), // Lock icon for password
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: Colors.orangeAccent[50],
                            filled: true,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      TextButton(
                        onPressed: () {
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Forget()));
                        },
                        child: Text(
                          "Reset your Password",
                          style: TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      
                     

                      SizedBox(height: 10),

                      // Sign-up button
                      SizedBox(
                        width: 250,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : handleLogin,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  13), // Reduce this value for a smaller radius
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 50),
                            elevation: 10, // Shadow effect
                            shadowColor: Colors.deepPurple.withOpacity(0.9),
                            backgroundColor: Colors
                                .deepPurple, // Correct way to set background color
                            foregroundColor: Colors.white, // Color of the text
                          ),
                          child: isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                                  "Login",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                        ),
                      ),
                      SizedBox(height: 30),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey[200], // Light background
                              borderRadius:
                                  BorderRadius.circular(10), // Rounded corners
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.facebook,
                                color: Colors.blue,
                              ), // Facebook Icon
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey[200], // Light background
                              borderRadius:
                                  BorderRadius.circular(10), // Rounded corners
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.g_mobiledata,
                                color: Colors.red,
                              ), // Facebook Icon
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey[200], // Light background
                              borderRadius:
                                  BorderRadius.circular(10), // Rounded corners
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.apple,
                                color: Colors.black,
                              ), // Facebook Icon
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      // Login navigation
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            "Create new Account?",
                            style: TextStyle(color: Colors.black),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Signup()));
                            },
                            child: Text(
                              "Signup",
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
        ),
      ),
    );
  }
}
