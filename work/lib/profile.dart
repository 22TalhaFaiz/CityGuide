import 'dart:io';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work/explore.dart';
import 'home.dart';
import 'dart:convert';
import 'package:http/http.dart'
    as http; // Make sure this imports your home screen

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  String _profileImageUrl =
      'https://cdn-icons-png.flaticon.com/512/3135/3135715.png'; // Default profile image
  File? _imageFile;

  bool _isNameEditable = false;
  bool _isEmailEditable = false;
  bool _isPhoneEditable = false;
  bool _isCityEditable = false;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  // Fetch user data from Firestore
  void fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        setState(() {
          _nameController.text = data['name'] ?? '';
          _emailController.text = data['email'] ?? '';
          _phoneController.text = data['phone'] ?? '';
          _cityController.text = data['city'] ?? '';
          _profileImageUrl = data['profileImage'] ??
              'https://cdn-icons-png.flaticon.com/512/3135/3135715.png';
        });

        // Save to SharedPreferences for updating Drawer
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userName', data['name'] ?? '');
        await prefs.setString('userEmail', data['email'] ?? '');
        await prefs.setString('profileImage', _profileImageUrl);
      }
    }
    
  }
  

  // Upload Profile Image
  Future<void> _uploadProfileImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    File imageFile = File(pickedFile.path);

    setState(() {
      _imageFile = imageFile;
    });

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://api.imgbb.com/1/upload?key=7af63ec0709ee125fb9a7ad71b5bcc97'),
      );
      request.files
          .add(await http.MultipartFile.fromPath('image', imageFile.path));

      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseData);

      if (jsonResponse['status'] == 200) {
        String imageUrl = jsonResponse['data']['url'];

        setState(() {
          _profileImageUrl = imageUrl;
        });

        // Save to SharedPreferences for Drawer
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('profileImage', imageUrl);

        // Update Firestore if needed
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .update({
            'profileImage': imageUrl,
          });
        }

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Profile image updated!")));
      } else {
        throw Exception("Failed to upload image");
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  // Save updated profile data
  void saveProfileData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'city': _cityController.text,
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userName', _nameController.text);
      await prefs.setString('userEmail', _emailController.text);

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Profile updated!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back,
                      color: Colors.deepPurple, size: 30),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              const Text("Edit Profile",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Colors.deepPurple)),
              const Text("Edit Your Profile to Get Started!",
                  style: TextStyle(fontSize: 20, color: Colors.grey)),
              const SizedBox(height: 15),

              // Profile Image
              GestureDetector(
                onTap: _uploadProfileImage,
                child: CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  radius: 50,
                  backgroundImage: NetworkImage(_profileImageUrl),
                  child: _imageFile == null
                      ? const Icon(Icons.camera_alt,
                          size: 40, color: Colors.deepPurple)
                      : null,
                ),
              ),

              const SizedBox(height: 20),
              _buildEditableTextField(
                  controller: _nameController,
                  hint: "Username",
                  icon: Icons.person,
                  isEditable: _isNameEditable,
                  onEdit: () =>
                      setState(() => _isNameEditable = !_isNameEditable)),
              _buildEditableTextField(
                  controller: _emailController,
                  hint: "Email",
                  icon: Icons.email,
                  isEditable: _isEmailEditable,
                  onEdit: () =>
                      setState(() => _isEmailEditable = !_isEmailEditable)),
              _buildEditableTextField(
                  controller: _phoneController,
                  hint: "Phone",
                  icon: Icons.phone,
                  isEditable: _isPhoneEditable,
                  onEdit: () =>
                      setState(() => _isPhoneEditable = !_isPhoneEditable)),
              _buildEditableTextField(
                  controller: _cityController,
                  hint: "City",
                  icon: Icons.location_city_sharp,
                  isEditable: _isCityEditable,
                  onEdit: () =>
                      setState(() => _isCityEditable = !_isCityEditable)),

              const SizedBox(height: 20),

              SizedBox(
                width: 250,
                child: ElevatedButton(
                  onPressed: saveProfileData,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 50),
                    elevation: 10,
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Update"),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Builder(
        builder: (context) {
          return ConvexAppBar(
            style: TabStyle.reactCircle,
            height: 50,
            items: [
              TabItem(icon: Icons.home, title: 'Home'),
              TabItem(icon: Icons.explore, title: 'Explore'),
              TabItem(icon: Icons.person, title: 'Profile'),
            ],
            initialActiveIndex: 2,
            backgroundColor: Colors.grey[50],
            color: Colors.deepPurple,
            activeColor: Colors.deepPurpleAccent,
            onTap: (int index) {
              if (index == 0) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Home()));
              } else if (index == 1) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const explore()));
              } else if (index == 2) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Profile()));
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildEditableTextField(
      {required TextEditingController controller,
      required String hint,
      required IconData icon,
      required bool isEditable,
      required VoidCallback onEdit}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              readOnly: !isEditable,
              decoration: InputDecoration(
                  hintText: hint,
                  prefixIcon: Icon(icon, color: Colors.deepPurple)),
            ),
          ),
          IconButton(
              icon: Icon(Icons.edit, color: Colors.deepPurple),
              onPressed: onEdit),
        ],
      ),
    );
  }
}
