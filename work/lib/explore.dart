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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60),
           
            Row(
              
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                cityCard('Karachi', 'assets/images/detailed-vector-illustration-mazar-e-quaid-situated-karachi-pakistan-136445372.webp', [Colors.purple, Colors.white]),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                cityCard('Lahore', 'assets/images/images.jpeg', [Colors.blue, Colors.white]),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                cityCard('Islamabad', 'assets/images/trendy-faisal-mosque-vector.jpg', [Colors.red, Colors.white]),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                cityCard('Multan', 'assets/images/images.png', [Colors.green, Colors.white]),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                cityCard('Abbottabad', 'assets/images/pngtree-cartoon-hillside-landscape-sticker-vector-png-image_11088666.png', [Colors.deepOrange, Colors.white]),
              ],
            ),
          ],
        ),
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

  Widget cityCard(String name, String imagePath, List<Color> gradientColors) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 325,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          gradient: LinearGradient(
            colors: gradientColors,
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
                name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: Image.asset(
                imagePath,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
