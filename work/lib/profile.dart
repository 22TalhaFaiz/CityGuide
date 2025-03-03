import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:work/Home.dart';
import 'package:work/explore.dart';
import 'package:work/search.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  
  String _profileImageUrl = ''; // Profile image URL

  // Edit mode for each field
  bool _isNameEditable = false;
  bool _isEmailEditable = false;
  bool _isPhoneEditable = false;
  bool _isCityEditable = false;

  @override
  void initState() {
    super.initState();
    fetchUserData(); // Fetch user data when screen loads
  }

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
              'https://cdn-icons-png.flaticon.com/512/3135/3135715.png'; // Default profile image
        });
      }
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
                  icon: const Icon(Icons.arrow_back, color: Colors.deepPurple, size: 30),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Edit Profile",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900, color: Colors.deepPurple),
              ),
              const Text("Edit Your Profile to Get Started!", 
                  style: TextStyle(fontSize: 20, color: Colors.grey)),
              const SizedBox(height: 15),

              // Profile Image
              GestureDetector(
                
                child: CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  radius: 50,
                  backgroundImage: NetworkImage(_profileImageUrl), // Load profile image
                  child: _profileImageUrl.isEmpty
                      ? const Icon(Icons.camera_alt, size: 40, color: Colors.deepPurple)
                      : null,
                ),
              ),

              const SizedBox(height: 20),

              _buildEditableTextField(
                controller: _nameController, 
                hint: "Username", 
                icon: Icons.person, 
                isEditable: _isNameEditable,
                onEdit: () => setState(() => _isNameEditable = !_isNameEditable),
              ),
              _buildEditableTextField(
                controller: _emailController, 
                hint: "Email", 
                icon: Icons.email, 
                isEditable: _isEmailEditable,
                onEdit: () => setState(() => _isEmailEditable = !_isEmailEditable),
              ),
              _buildEditableTextField(
                controller: _phoneController, 
                hint: "Phone", 
                icon: Icons.phone, 
                isEditable: _isPhoneEditable,
                onEdit: () => setState(() => _isPhoneEditable = !_isPhoneEditable),
              ),
              _buildEditableTextField(
                controller: _cityController, 
                hint: "City", 
                icon: Icons.location_city_sharp, 
                isEditable: _isCityEditable,
                onEdit: () => setState(() => _isCityEditable = !_isCityEditable),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: 250,
                child: ElevatedButton(
                  onPressed: () {
                    // Save updated data to Firestore
                    saveProfileData();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                    elevation: 10,
                    shadowColor: Colors.deepPurple.withOpacity(0.9),
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
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.reactCircle,
        height: 50,
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.explore, title: 'Explore'),
          TabItem(icon: Icons.search, title: 'Search'),
          TabItem(icon: Icons.person, title: 'Profile'),
        ],
        initialActiveIndex: 3,
        backgroundColor: Colors.grey[50],
        color: Colors.deepPurple,
        activeColor: Colors.deepPurpleAccent,
        onTap: (int index) {
          if (index == 0) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
          } else if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => explore()));
          } else if (index == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Search()));
          } else if (index == 3) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
          }
        },
      ),
    );
  }

  Widget _buildEditableTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required bool isEditable,
    required VoidCallback onEdit,
  }) {
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
                prefixIcon: Icon(icon, color: Colors.deepPurple),
                // border: const OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit, color: Colors.deepPurple),
            onPressed: onEdit,
          ),
        ],
      ),
    );
  }

  void saveProfileData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'city': _cityController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile updated successfully!")),
      );
    }
  }
}
