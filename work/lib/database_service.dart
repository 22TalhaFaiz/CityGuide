import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Register User and Store Data in Firestore
  Future<String?> createUser(String name, String email, String phone, String password) async {
    try {
      // Firebase Authentication
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save user data in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
        'phone': phone,
        'password':password,
      });

      return "User registered successfully!";
    } catch (e) {
      return e.toString();
    }
  }
}
