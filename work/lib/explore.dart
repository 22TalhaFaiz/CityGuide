import 'package:flutter/material.dart';
import 'package:work/Home.dart';
import 'package:work/database_service.dart';
import 'package:work/profile.dart';
import 'package:work/search.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class explore extends StatefulWidget {
  const explore({super.key});

  @override
  State<explore> createState() => _exploreState();
}

class _exploreState extends State<explore> {
  final DatabaseService _dbservice  = DatabaseService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
     backgroundColor: Colors.white,
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _dbservice.getCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No categories available"));
          }

          List<Map<String, dynamic>> categories = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                ...categories.map((category) => categoryCard(category)).toList(),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.reactCircle,
        height: 50,
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.explore, title: 'Explore'),
          TabItem(icon: Icons.search, title: 'Search'),
          TabItem(icon: Icons.person, title: 'Profile'),
        ],
        initialActiveIndex: 1,
        backgroundColor: Colors.grey[50],
        color: Colors.deepPurple,
        activeColor: Colors.deepPurpleAccent,
        onTap: (int index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => explore()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Search()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Profile()),
            );
          }
        },
      ),
    );
  }

  Widget categoryCard(Map<String, dynamic> category) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 325,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
             colors: [
              Color(int.parse(category['color1'].replaceFirst('#', '0xff'))),
              Color(int.parse(category['color2'].replaceFirst('#', '0xff')))
            ], 
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                category['title'], // Using title from Firestore
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: Image.network(
                category['image_url'], // Loading image from URL
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.error, size: 60),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
