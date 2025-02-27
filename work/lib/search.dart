import 'package:flutter/material.dart';
import 'package:work/Home.dart';
import 'package:work/explore.dart';
import 'package:work/profile.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';


class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
return Scaffold(
  backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
          
            children: <Widget>[
              SizedBox(height: 80,),
               Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.deepPurple, size: 30),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              // Expands to take available space without overflow
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search...",
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.deepPurple,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200], // Light background
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10), // Space between elements
              ElevatedButton(
                onPressed: () {},
                child: Text("Search"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ],
          ),
        ),
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
  initialActiveIndex: 2,
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
),
    );

  }
}