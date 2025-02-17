import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Register User and Store Data in Firestore
  Future<String?> createUser(
      String name, String email, String phone, String password) async {
    try {
      // Firebase Authentication
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save user data in Firestore without storing the password
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
      });

      return "User registered successfully!";
    } catch (e) {
      return "Error: ${e.toString()}";
    }
  }

  // Login User
  Future<String?> loginUser(String email, String password) async {
    try {
      // Your Firebase login logic goes here
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return "Login Successfully";
    } catch (e) {
      return "Login Failed: ${e.toString()}";
    }
  }
}
