import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work/database_service.dart';
import 'package:work/login.dart';
import 'package:flutter/services.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _dbService = DatabaseService();

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _phone = TextEditingController();
  
  final _formKey = GlobalKey<FormState>(); // Form key for validation

  @override
  void dispose() {
    super.dispose();

    _name.dispose();
    _email.dispose();
    _password.dispose();
    _phone.dispose();
  }

  // Function to handle user sign up
  Future<void> handleSignUp() async {
    if (_formKey.currentState!.validate()) { // Only proceed if form is valid
      String name = _name.text.trim();
      String email = _email.text.trim();
      String phone = _phone.text.trim();
      String password = _password.text.trim();

      String? result = await _dbService.createUser(name, email, phone, password);

      if (result == "User registered successfully!") {
        // Save user details for session
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('userName', name);
        prefs.setString('userEmail', email);

        // Show success dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Signup Successful!', style: TextStyle(color: Colors.green),),
              content: Text('You have successfully signed up.', style: TextStyle(color: Colors.green),),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => login()),
                    );
                  },
                  child: Text('OK', style: TextStyle(color: Colors.green),),
                ),
              ],
            );
          },
        );
      } else {
        // Show error dialog if result is not successful
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Signup Failed!', style: TextStyle(color: Colors.red),),
              content: Text(result ?? 'An error occurred, please try again.', style: TextStyle(color: Colors.red),),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('OK', style: TextStyle(color: Colors.red),),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(color: Colors.deepPurple),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 57),
                  const Text(
                    "Create Account",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w900),
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
                    child: Form(
                      key: _formKey, // Form key for validation
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 30),

                          // Username input
                          SizedBox(
                            width: 250,
                            child: TextFormField(
                              controller: _name,
                              decoration: InputDecoration(
                                hintText: "Username",
                                prefixIcon: Icon(
                                  Icons.person,
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
                                  return "Please enter your username";
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 20),

                          // Email input with validation
                          SizedBox(
                            width: 250,
                            child: TextFormField(
                              controller: _email,
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

                          // Phone input with validation
                       

SizedBox(
  width: 250,
  child: TextFormField(
    controller: _phone,
    keyboardType: TextInputType.phone, // Make sure the keyboard is optimized for phone input
    inputFormatters: [
      FilteringTextInputFormatter.digitsOnly, // Allow only digits
    ],
    decoration: InputDecoration(
      hintText: "Phone",
      prefixIcon: Icon(
        Icons.phone,
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
        return "Please enter your phone number";
      }
      if (value.length < 10) {
        return "Phone number must be at least 10 digits";
      }
      return null;
    },
  ),
),

                          SizedBox(height: 20),

                          // Password input with validation
                          SizedBox(
                            width: 250,
                            child: TextFormField(
                              controller: _password,
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
                          SizedBox(height: 30),

                          // Sign-up button
                          SizedBox(
                            width: 250,
                            child: ElevatedButton(
                              onPressed: handleSignUp,
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

                          // Social Media Login options
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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

                          const SizedBox(height: 20),

                          // Navigation to login page if already have account
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                "Already have an Account?",
                                style: TextStyle(color: Colors.black),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) => login(),
                                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                        return FadeTransition(
                                          opacity: animation,
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
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
