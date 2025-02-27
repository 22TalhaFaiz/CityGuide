import 'package:flutter/material.dart';
import 'package:work/Home.dart';
import 'package:work/profile.dart';
import 'package:work/search.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class explore extends StatefulWidget {
  const explore({super.key});

  @override
  State<explore> createState() => _exploreState();
}

class _exploreState extends State<explore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(

      ),
           bottomNavigationBar: ConvexAppBar(
  style: TabStyle.react,
  height: 60,
  items: [
    TabItem(icon: Icons.home, title: 'Home'),
    TabItem(icon: Icons.explore, title: 'Explore'),
    TabItem(icon: Icons.search, title: 'Search'),
    TabItem(icon: Icons.person, title: 'Profile'),  // ✅ Direct Icon use karein
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
    } 
    else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => explore() ),  
      );
    }
    
    else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Search() ),  
      );
    }
    
    else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Profile()),  
      );
    }
    
  },
)
,
    );
  }
}




