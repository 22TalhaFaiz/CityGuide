import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:work/login.dart';
import 'package:work/utils.dart'; // Ensure Utils is imported

class forget extends StatefulWidget {
  const forget({super.key});

  @override
  State<forget> createState() => _forgetState();
}

class _forgetState extends State<forget> {
  final email = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 40),

              /// Back Button
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.deepPurple, size: 30),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              Image.asset(
                "assets/images/Black White Minimalist Monogram Initial Logo (1) - Copy.jpg",
                width: 200,
                height: 200,
              ),
              Text(
                "Forget Your Password",
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 30,
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 30),
              Text("Enter your email and we'll",
                  style: TextStyle(fontSize: 20, color: Colors.grey)),
              Text("help you reset your password",
                  style: TextStyle(fontSize: 20, color: Colors.grey)),
              SizedBox(height: 40),
              SizedBox(
                width: 250,
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                    hintText: "Enter Your Email ",
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
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  auth.sendPasswordResetEmail(email: email.text.toString()).then((value) {
                    Utils.toastMessage("Password reset email sent successfully");
                  }).catchError((error) {
                    Utils.toastMessage("Error: ${error.toString()}");
                  });
                },
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
                child: Text(
                  "Reset password",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10,),

              // Login navigation
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Remembered your password?",
                    style: TextStyle(color: Colors.black),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => login()));
                    },
                    child: Text(
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
    );
  }
}
