import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work/database_service.dart';
import 'package:work/login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _dbService = DatabaseService();
  final _formKey = GlobalKey<FormState>(); // Form Key for Validation

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _phone = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _phone.dispose();
    super.dispose();
  }

  /// Signup Function
  Future<void> signUp() async {
    if (_formKey.currentState!.validate()) { // Only proceed if form is valid
      String name = _name.text.trim();
      String email = _email.text.trim();
      String phone = _phone.text.trim();
      String password = _password.text.trim();

      String? result = await _dbService.createUser(name, email, phone, password);

      if (result == "User registered successfully!") {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('userName', name);
        prefs.setString('userEmail', email);

        showMessageDialog("Success", "Signup Successful!");
        Navigator.push(context, MaterialPageRoute(builder: (context) => login()));
      } else {
        showMessageDialog("Error", result!);
      }
    }
  }

  /// Function to Show a Dialog Box
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
                    style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w900),
                  ),
                  const Text(
                    "Create an account to explore the best of the city!",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  /// Form Container
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(80), topLeft: Radius.circular(80)),
                    ),
                    padding: const EdgeInsets.all(42),
                    child: Form(
                      key: _formKey, // Wrap inside Form Widget
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 30),

                          /// Username Input Field
                          _buildTextField(_name, "Username", Icons.person, (value) {
                            if (value == null || value.isEmpty) return "Username is required";
                            return null;
                          }),

                          const SizedBox(height: 20),

                          /// Email Input Field
                          _buildTextField(_email, "Email", Icons.email, (value) {
                            if (value == null || value.isEmpty) return "Email is required";
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return "Enter a valid email";
                            return null;
                          }),

                          const SizedBox(height: 20),

                          /// Phone Input Field
                          _buildTextField(_phone, "Phone", Icons.phone, (value) {
                            if (value == null || value.isEmpty) return "Phone number is required";
                            if (!RegExp(r'^\d{10,15}$').hasMatch(value)) return "Enter a valid phone number";
                            return null;
                          }),

                          const SizedBox(height: 20),

                          /// Password Input Field
                          _buildTextField(_password, "Password", Icons.lock, (value) {
                            if (value == null || value.isEmpty) return "Password is required";
                            if (value.length < 6) return "Password must be at least 6 characters";
                            return null;
                          }, obscureText: true),

                          const SizedBox(height: 30),

                          /// Sign-up Button
                          ElevatedButton(
                            onPressed: signUp,
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
                              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                              elevation: 10,
                              shadowColor: Colors.deepPurple.withOpacity(0.9),
                              backgroundColor: Colors.deepPurple,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text("Sign up", style: TextStyle(fontWeight: FontWeight.bold)),
                          ),

                          const SizedBox(height: 30),

                          /// Social Media Buttons
                          _buildSocialMediaButtons(),

                          const SizedBox(height: 20),

                          /// Login Navigation
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text("Already have an Account?", style: TextStyle(color: Colors.black)),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => login()));
                                },
                                child: const Text("Login", style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold)),
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

  /// Reusable TextFormField Widget
  Widget _buildTextField(TextEditingController controller, String hint, IconData icon, String? Function(String?) validator, {bool obscureText = false}) {
    return SizedBox(
      width: 250,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: Colors.deepPurple),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
          fillColor: Colors.orangeAccent[50],
          filled: true,
        ),
        validator: validator,
      ),
    );
  }

  /// Social Media Buttons Widget
  Widget _buildSocialMediaButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _socialButton(Icons.facebook, Colors.blue),
        const SizedBox(width: 20),
        _socialButton(Icons.g_mobiledata, Colors.red),
        const SizedBox(width: 20),
        _socialButton(Icons.apple, Colors.black),
      ],
    );
  }

  Widget _socialButton(IconData icon, Color color) {
    return Container(
      width: 50,
      decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
      child: IconButton(onPressed: () {}, icon: Icon(icon, color: color)),
    );
  }
}
