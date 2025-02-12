import 'package:flutter/material.dart';
import 'package:work/Home.dart';
import 'package:work/signup.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange, // Deep orange background
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 120),

                Text(
                  "Login Account ",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                      
                Text("Welcome Back", style: TextStyle(color: Colors.white),),
                SizedBox(height: 20),

                // Card with form fields
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(80), topLeft: Radius.circular(80))),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(45.0),
                    child: Column(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(200),
                          child: Image.asset(
                            "assets/images/pngtree-orange-cutout-building-bustling-new-york-city-silhouette-png-image_5978751.png",
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 20),

                        // Email input
                        SizedBox(
                          width: 250,
                          child: TextField(
                            // controller: _email,
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

                        // Password input
                        SizedBox(
                          width: 250,
                          child: TextField(
                            // controller: _password,
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

                        SizedBox(
                          width: 250,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.deepOrange, // Button color
                              foregroundColor: Colors.white, // Text color
                            ),
                            child: Text("Login"),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

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

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text(
                              "Create Your Account?",
                              style: TextStyle(color: Colors.grey),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()));
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
