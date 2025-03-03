import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Register User and Store Data in Firestore
  Future<String?> createUser(
      String name, String email, String phone, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
        'phone': phone,
        'password': password, // Consider not storing the password in Firestore
      });

      return "User registered successfully!";
    } catch (e) {
      return "Error: ${e.toString()}";
    }
  }

  // Login User
  Future<String?> loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return "Login Successfully";
    } catch (e) {
      return "Login Failed: ${e.toString()}";
    }
  }

  // =================== CITY MANAGEMENT ===================

  // Fetch City from Firestore
  Future<List<Map<String, dynamic>>> getCity() async {
    QuerySnapshot snapshot = await _firestore.collection('cities').get();
    return snapshot.docs
        .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
        .toList();
  }

  // Add New City
  Future<void> addCity(String title, File imageFile) async {
    try {
      String imageUrl = await _uploadImage(imageFile, title);

      await _firestore.collection('cities').add({
        'title': title,
        'image_url': imageUrl,
      });
    } catch (e) {
      print("Error adding cities: $e");
    }
  }

   Future<List<Map<String, dynamic>>> getCategories() async {
    QuerySnapshot snapshot = await _firestore.collection('categories').get();
    return snapshot.docs
        .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
        .toList();
  }

  // Add New Categories
  Future<void> addCategories(String title, File imageFile, String color1, String color2) async {
    try {
      String imageUrl = await _uploadImage(imageFile, title);

      await _firestore.collection('categories').add({
        'title': title,
        'image_url': imageUrl,
        'color1': color1,
        'color2': color2,
        
      });
    } catch (e) {
      print("Error adding categories: $e");
    }
  }

  // Upload Image to Firebase Storage
  Future<String> _uploadImage(File imageFile, String title) async {
    Reference ref = _storage.ref().child('cities_images/$title.jpg');
    UploadTask uploadTask = ref.putFile(imageFile);
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  // Delete City
  Future<void> deleteCity(String cityId) async {
    await _firestore.collection('cities').doc(cityId).delete();
  }
}
