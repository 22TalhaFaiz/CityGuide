import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/Islamabad.dart';
import 'package:myapp/abbottabad.dart';
import 'package:myapp/category.dart';
import 'package:myapp/firebase_options.dart';
import 'package:myapp/hotels.dart';
import 'package:myapp/karachi.dart';
import 'package:myapp/lahore.dart';
import 'package:myapp/multan.dart';
import 'package:myapp/product.dart';
import 'package:myapp/read_data.dart';
import 'package:myapp/restaurants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.white),
        ),
        appBarTheme: AppBarTheme(
          color: Colors.red,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      home: AdminScreen(),
    );
  }
}

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int userCount = 0;
  int bookCount = 0;
  int categoryCount = 0;
  Map<String, int> categoryBookCount =
      {}; // To store the count of books per category

  @override
  void initState() {
    super.initState();
    fetchCounts();
  }

  // Fetch the count of users, books, categories, and books in each category
  void fetchCounts() async {
    // Fetch the number of users
    final userSnapshot =
        await FirebaseFirestore.instance.collection('users').get();
    setState(() {
      userCount = userSnapshot.docs.length;
    });

    // Fetch the number of books
    final bookSnapshot =
        await FirebaseFirestore.instance.collection('Attractions').get();
    setState(() {
      bookCount = bookSnapshot.docs.length;
    });

    // Fetch the number of categories
    final categorySnapshot =
        await FirebaseFirestore.instance.collection('categories').get();
    setState(() {
      categoryCount = categorySnapshot.docs.length;
    });

    // Fetch the number of books in each category
    fetchCategoryCounts();
  }

  // Fetch books per category and count them
  void fetchCategoryCounts() async {
    final bookSnapshot =
        await FirebaseFirestore.instance.collection('Attractions').get();
    Map<String, int> categoryCounts = {};

    for (var doc in bookSnapshot.docs) {
      final categoryId =
          doc['cat_id']; // Assuming 'cat_id' links to the category of the book

      if (categoryCounts.containsKey(categoryId)) {
        categoryCounts[categoryId] = categoryCounts[categoryId]! + 1;
      } else {
        categoryCounts[categoryId] = 1;
      }
    }

    setState(() {
      categoryBookCount = categoryCounts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        backgroundColor: Colors.red,
      ),
      drawer: DashboardDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Broad Welcome Banner with Image at Bottom
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red, Colors.black],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    'Welcome to the Admin Dashboard!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                            color: Colors.black.withOpacity(0.7),
                            offset: Offset(3, 3),
                            blurRadius: 5),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  // Add an Image below the welcome text (Replace URL with your image)
                  Image.network(
                      'https://www.istockphoto.com/vector/bookshelves-gm854608904-140850519',
                      height: 100,
                      width: 100),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Data Cards in Grid Layout
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // Two cards in one row
                crossAxisSpacing: 12,
                mainAxisSpacing: 24,
                childAspectRatio:
                    0.99, // Adjust the size of the cards (make them smaller)
                children: [
                  // Total Users Card
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black,
                            Colors.grey
                          ], // Gradient colors for the Users card
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: ListTile(
                          leading:
                              Icon(Icons.person, color: Colors.white, size: 40),
                          title: Text('Users',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                          subtitle: Text(userCount.toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 36)),
                        ),
                      ),
                    ),
                  ),

                  // Total Books Card with Gradient
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color.fromARGB(255, 255, 255, 255),
                            Colors.grey
                          ], // Gradient colors for the Books card
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: ListTile(
                          leading:
                              Icon(Icons.book, color: Colors.white, size: 40),
                          title: Text('Books',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                          subtitle: Text(bookCount.toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 36)),
                        ),
                      ),
                    ),
                  ),

                  // Total Categories Card with Gradient
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black,
                            Colors.grey
                          ], // Gradient colors for the Categories card
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: ListTile(
                          leading: Icon(Icons.category,
                              color: Colors.white, size: 40),
                          title: Text('Categories',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                          subtitle: Text(categoryCount.toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 36)),
                        ),
                      ),
                    ),
                  ),

                  // Displaying the count of books per category dynamically
                  ...categoryBookCount.entries.map((entry) {
                    return Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black,
                              Colors.grey
                            ], // Gradient colors for the Categories card
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: ListTile(
                            leading: Icon(Icons.category,
                                color: Colors.white, size: 40),
                            title: Text('Category: ${entry.key}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                            subtitle: Text('Books: ${entry.value}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 36)),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.7),
              spreadRadius: 5,
              blurRadius: 15,
              offset: Offset(4, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              accountName:
                  Text('Niha Siddiqui', style: TextStyle(color: Colors.white)),
              accountEmail: Text('nihasiddiqui@gmail.com',
                  style: TextStyle(color: Colors.white)),
              currentAccountPicture: CircleAvatar(
                backgroundImage:
                    NetworkImage('https://example.com/your-image.jpg'),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.person, color: Colors.white),
                    title: Text('User Management',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => FetchData()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.book, color: Colors.white),
                    title: Text('Attractions',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Product()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.category, color: Colors.white),
                    title:
                        Text('Cities', style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (buildr) => Categorydata()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.category, color: Colors.white),
                    title: Text('Restaurants',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (buildr) => Restaurants()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.category, color: Colors.white),
                    title:
                        Text('Hotels', style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (buildr) => hotels()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.category, color: Colors.white),
                    title: Text('Lahore Attractions',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (buildr) => Lahore()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.category, color: Colors.white),
                    title: Text('Karachi Attractions',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (buildr) => karachi()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.category, color: Colors.white),
                    title: Text('Islamabad Attractions',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (buildr) => Islamabad()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.category, color: Colors.white),
                    title: Text('Multan Attractions',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (buildr) => multan()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.category, color: Colors.white),
                    title: Text('Abbottabad Attractions',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (buildr) => Abbottabad()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.white),
                    title:
                        Text('Logout', style: TextStyle(color: Colors.white)),
                    onTap: () {
                      // Logout functionality can go here
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
