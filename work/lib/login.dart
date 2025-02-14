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
      backgroundColor: Colors.deepPurple, // Deep orange background
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 115),

                Text(
                  "Login Account ",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                      
                Text("Welcome Back", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                SizedBox(height: 20),

                // Card with form fields
                Card(
                  color: Colors.grey[100],
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(80), topLeft: Radius.circular(80))),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(54),
                    child: Column(
                      children: <Widget>[
                        // ClipRRect(
                        //   borderRadius: BorderRadius.circular(200),
                        //   child: Image.asset(
                        //     "assets/images/images.jpeg",
                        //     height: 150,
                        //     width: 150,
                        //     fit: BoxFit.cover,
                        //   ),
                        // ),
                        // Email input with icon
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
                    SizedBox(height: 10,),
                  
                  
                     TextButton(
                          onPressed: () {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => signup()));
                          },
                          child: Text(
                            "Forgot your Password",
                            style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold),
                          ),
                        ),
                        
                      
                    SizedBox(height: 10),

                    // Sign-up button
                    SizedBox(
                      width: 250,
                      child: ElevatedButton(
                        onPressed: () {},
                        
                        style: ElevatedButton.styleFrom(
                           shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(13), // Reduce this value for a smaller radius
    ),
                          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                          elevation: 10, // Shadow effect
                          shadowColor: Colors.deepPurple.withOpacity(0.9),
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          
                        ),
                        child: Text("Login"  , style: TextStyle(fontWeight: FontWeight.bold),),
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
        borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
      child: IconButton(
        onPressed: () {}, 
        icon: Icon(Icons.facebook,color: Colors.blue,), // Facebook Icon
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
        icon: Icon(Icons.g_mobiledata,color: Colors.red,), // Facebook Icon
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
        icon: Icon(Icons.apple,color: Colors.black,), // Facebook Icon
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
                                context, MaterialPageRoute(builder: (context) => signup()));
                          },
                          child: Text(
                            "Signup",
                            style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
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
