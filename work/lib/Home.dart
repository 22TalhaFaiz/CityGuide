import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:work/Lp.dart';
import 'package:work/login.dart';
import 'package:work/signup.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
      drawer: Drawer(
        child: Column(children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
                gradient:
                    LinearGradient(colors: [Colors.orange, Colors.deepOrange])),
            accountName: const Text('Ibrahim'),
            accountEmail: const Text('ibo@gmail.com'),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://www.google.com/url?sa=i&url=https%3A%2F%2Fpngtree.com%2Ffreepng%2Fuser-profile-avatar_13369988.html&psig=AOvVaw1AIfT0EuW5eHQJygOuFA13&ust=1738389005155000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCJC2uuuhn4sDFQAAAAAdAAAAABAE'),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => const Home()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Login'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => const login()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.account_circle),
                  title: const Text('Signup'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => const signup()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.login),
                  title: const Text('Logout'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => const Lp()));
                  },
                ),
              ],
            ),
          )
        ]),
      ),
      body: Column(
        children: [
          // CarouselSlider
          CarouselSlider(
            options: CarouselOptions(height: 200),
            items: [1, 2, 3, 4, 5].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: const BoxDecoration(
                        // color: Colors.blueAccent, // Change the color here
                        ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/islbg.jpg', // Replace with your images from assets
                        fit: BoxFit.cover, // Adjust image scaling
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
//Add Categories like Mountain and Sea and Malls nad Hospitals
          // Categories Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              shrinkWrap: true, // Important for allowing scrolling in Column
              physics:
                  NeverScrollableScrollPhysics(), // Prevent nested scrolling
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 10, // Horizontal space between cards
                mainAxisSpacing: 10, // Vertical space between cards
                childAspectRatio: 1.0, // Aspect ratio for each card
              ),
              itemCount: 4, // Number of categories
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: InkWell(
                    onTap: () {
                      // Handle category click (e.g., navigate to category page)
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Category Image
                        Image.asset(
                          'assets/images/logoLP.png', // Replace with your category images
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 10),
                        // Category Name
                        Text(
                          'Category ${index + 1}', // Replace with category names
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
