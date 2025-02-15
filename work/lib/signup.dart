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

backgroundColor: Colors.transparent, // Remove solid color
body: SingleChildScrollView(
  child: Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple, Colors.white], // Purple to White gradient
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
    child: Center(
      child: Column(
        children: <Widget>[
          SizedBox(height: 75),
          Text(
            "Create Account",
            style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Text(
            "Create an account to explore the best of the city!",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
                SizedBox(height: 20),
               

                Card(
                  
  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(80),
      topLeft: Radius.circular(80),
    ),
  ),
  elevation: 8,
  child: Padding(
    padding: const EdgeInsets.all(48),
    child: Column(
      children: <Widget>[
        SizedBox(height: 20),
       // Username input with icon
                    SizedBox(
                      width: 250,
                      child: TextField(
                        decoration: InputDecoration(
                          
                          hintText: "Username",
                          prefixIcon: Icon(Icons.person , color: Colors.deepPurple,), // Username icon
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
                    // Phone input with icon
                    SizedBox(
                      width: 250,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Phone",
                          prefixIcon: Icon(Icons.phone , color: Colors.deepPurple,), // Phone icon
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
      borderRadius: BorderRadius.circular(13), // Reduce this value for a smaller radius
    ),
                          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                          elevation: 10, // Shadow effect
                          shadowColor: Colors.deepPurple.withOpacity(0.9),
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                        ),
                        child: Text("Sign up"  , style: TextStyle(fontWeight: FontWeight.bold),),
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


                    SizedBox(height: 20),

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
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )],
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
