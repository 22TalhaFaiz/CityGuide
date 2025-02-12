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
      backgroundColor: Colors.deepOrange, // Deep orange background
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 50),

               
                Text(
                  "Create Account",
                  style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text("Create an account to explore the best of the city!", style: TextStyle(color: Colors.white),),

                SizedBox(height: 20),
               

                Card(
  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(80),
      topLeft: Radius.circular(80),
    ),
  ),
  elevation: 10,
  child: Padding(
    padding: const EdgeInsets.all(48),
    child: Column(
      children: <Widget>[
        SizedBox(height: 20),
        // Username input
        SizedBox(
          width: 250,
          child: TextField(
            decoration: InputDecoration(
              hintText: "Username",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.deepOrangeAccent[50],
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
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.deepOrangeAccent[50],
              filled: true,
            ),
          ),
        ),
        SizedBox(height: 20),

        // Phone input
        SizedBox(
          width: 250,
          child: TextField(
            decoration: InputDecoration(
              hintText: "Phone",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.deepOrangeAccent[50],
              filled: true,
            ),
          ),
        ),
        SizedBox(height: 20),

        // Password input
        SizedBox(
          width: 250,
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.deepOrangeAccent[50],
              filled: true,
            ),
          ),
        ),
        SizedBox(height: 20),

        // Forget Password button
        TextButton(
          onPressed: () {
            // Navigate to the forgot password screen
          },
          child: Text(
            "Forget Your Password?",
            style: TextStyle(color: Colors.orange),
          ),
        ),
        SizedBox(height: 10),

        // Sign-up button
        SizedBox(
          width: 250,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange, // Button color
              foregroundColor: Colors.white, // Text color
            ),
            child: Text("Sign up"),
          ),
        ),
        SizedBox(height: 20),

        // Facebook button
        SizedBox(
          width: 250,
          child: ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Button color
              foregroundColor: Colors.white, // Text color
            ),
            icon: Icon(
              Icons.facebook, // Facebook icon
              color: Colors.white,
            ),
            label: Text("Facebook"),
          ),
        ),

        SizedBox(height: 20),

        // Login navigation
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Already have an Account?",
              style: TextStyle(color: Colors.grey),
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
                style: TextStyle(color: Colors.orange),
              ),
            ),
          ],
        ),
      ],
    ),
  ),
)

              ],
            ),
          ),
        ),
      ),
    );
  }
}
