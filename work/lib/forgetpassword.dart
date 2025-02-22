import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:work/login.dart';
import 'package:work/utils.dart'; // Ensure Utils is imported

class Forget extends StatefulWidget {
  const Forget({super.key});

  @override
  State<Forget> createState() => _ForgetState();
}

class _ForgetState extends State<Forget> {
  final TextEditingController emailController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>(); // Form Key for Validation

  void resetPassword() {
  if (_formKey.currentState!.validate()) { // Check validation
    auth.sendPasswordResetEmail(email: emailController.text.trim()).then((value) {
      showMessageDialog("Success", "Password reset email sent successfully!");
    }).catchError((error) {
      showMessageDialog("Error", error.toString()); // Show error in dialog
    });
  }
}

/// Function to Show Dialog Box
void showMessageDialog(String title, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title, style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold)),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("OK", style: TextStyle(color: Colors.deepPurple)),
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey, // Wrap in Form Widget
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20),

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
                  "assets/images/360_F_420325313_0tgC68egfuhtzKf1OhVlZRHG6Dvv36Xt.jpg",
                  width: 300,
                  height: 300,
                ),
                Text(
                  "Reset Your Password",
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

                /// Email Input Field with Validation
                SizedBox(
                  width: 250,
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Enter Your Email",
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

                /// Reset Password Button
                ElevatedButton(
                  onPressed: resetPassword,
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
      ),
    );
  }
}
