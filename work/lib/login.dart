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
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  bool isLoading = false;

  // Function to show error dialog box
  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Login Failed",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                "Try Again",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  // Function to show success dialog box
  void showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Login Successful",
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          ),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                "OK",
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> handleLogin() async {
    if (_formKey.currentState!.validate()) { // Only proceed if the form is valid
      setState(() => isLoading = true);

      String _email = _emailController.text.trim();
      String _password = _passwordController.text.trim();

      String? result = await DatabaseService().loginUser(_email, _password);

      setState(() => isLoading = false);

      if (result == "Login Successfully") {
        // Show success dialog
        showSuccessDialog("Welcome back! You have logged in successfully.");

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
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        });
      } else {
        // Show error dialog if login fails
        showErrorDialog("Incorrect credentials. Please try again.");
      }
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
                      SizedBox(height: 40),

                      // Form for validation
                      Form(
                        key: _formKey, // Assign the form key
                        child: Column(
                          children: <Widget>[
                            // Email Input
                            SizedBox(
                              width: 250,
                              child: TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.deepPurple,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide.none,
                                  ),
                                  fillColor: Colors.orangeAccent[50],
                                  filled: true,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter your email";
                                  }
                                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                    return "Enter a valid email";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 20),

                            // Password Input
                            SizedBox(
                              width: 250,
                              child: TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.deepPurple,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide.none,
                                  ),
                                  fillColor: Colors.orangeAccent[50],
                                  filled: true,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter your password";
                                  }
                                  if (value.length < 6) {
                                    return "Password must be at least 6 characters";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 10),

                      // Reset password link
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => Forget(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        child: Text(
                          "Reset your Password",
                          style: TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      SizedBox(height: 10),

                      // Login Button
                      SizedBox(
                        width: 250,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : handleLogin,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                            elevation: 10,
                            shadowColor: Colors.deepPurple.withOpacity(0.9),
                            backgroundColor: Colors.deepPurple,
                            foregroundColor: Colors.white,
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

                      // Social Media Login (optional)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Icons for Facebook, Google, Apple
                          Container(
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.facebook,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Container(
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.g_mobiledata,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Container(
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.apple,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20),

                      // Navigation to signup
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
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) => Signup(),
                                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
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
