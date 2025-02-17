import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work/Lp.dart';
import 'package:work/editprofile.dart';
import 'package:work/login.dart';
import 'package:work/signup.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String userName = "Guest";
  String userEmail = "guest@example.com";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? 'Guest';
      userEmail = prefs.getString('userEmail') ?? 'guest@example.com';
    });
  }

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
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.purpleAccent, Colors.deepPurple])),
              accountName: Text(userName),
              accountEmail: Text(userEmail),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://cdn-icons-png.flaticon.com/512/3135/3135715.png'),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Home'),
                    onTap: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                  if (userEmail == "guest@example.com") ...[
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Login'),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (builder) => login()));
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
                  ] else ...[
                    ListTile(
                      leading: const Icon(Icons.account_circle),
                      title: const Text('Profile'),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => profile()));
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text('Logout'),
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.remove('userName');
                        await prefs.remove('userEmail');

                        setState(() {
                          userName = "Guest";
                          userEmail = "guest@example.com";
                        });

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => login()),
                        );
                      },
                    ),
                  ],
                ],
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // CarouselSlider
            CarouselSlider(
              options: CarouselOptions(
                height: 200, // Set fixed height for the carousel
                viewportFraction:
                    0.9, // Adjusts how much of the next/prev image is visible
                autoPlay: true, // Optional: Enables auto-slide
                enlargeCenterPage:
                    true, // Optional: Makes the center image slightly bigger
              ),
              items: [
                'assets/images/Hospital1.jpg',
                'assets/images/Hotel.jpeg',
                'assets/images/Mall1.jpg',
                'assets/images/Sea1.webp',
                'assets/images/Park.jpeg',
              ].map((imagePath) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(10), // Rounded corners
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            10), // Ensures the images follow the container shape
                        child: SizedBox(
                          height: 200, // Set fixed height for all images
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit
                                .cover, // Ensures all images fill the box proportionally
                            width: double
                                .infinity, // Ensures images stretch across the width
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            // Recommendation
            SizedBox(
              height: 40,
            ),
            SizedBox(
              width: double.infinity, // Ensures full width
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // Aligns items to both ends
                children: [
                  Text(
                    'Recommendation',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontFamily: 'Roboto',
                      letterSpacing: 1.5,
                    ),
                  ),
                  Text(
                    'See All',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontFamily: 'Roboto',
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            // Categories Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                shrinkWrap:
                    true, // Important for allowing scrolling inside Column
                physics:
                    const NeverScrollableScrollPhysics(), // Prevent nested scrolling
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing: 10, // Horizontal space between cards
                  mainAxisSpacing: 10, // Vertical space between cards
                  childAspectRatio: 1.0, // Aspect ratio for each card
                ),
                itemCount: 6, // Number of categories
                itemBuilder: (context, index) {
                  // Define category data manually
                  List<Map<String, String>> categories = [
                    {'image': 'assets/images/Tomb.JPG', 'title': 'Karachi'},
                    {
                      'image': 'assets/images/Lahore Museum.jpg',
                      'title': 'Lahore'
                    },
                    {
                      'image': 'assets/images/Faisal Mosqueisla.jpg',
                      'title': 'Islamabad'
                    },
                    {
                      'image': 'assets/images/Hospital1.jpg',
                      'title': 'Abbottabad'
                    },
                    {'image': 'assets/images/Park.jpeg', 'title': 'Multan'},
                    {'image': 'assets/images/Hotel.jpeg', 'title': 'Hotels'},
                  ];

                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: InkWell(
                      onTap: () {
                        // Navigate to a new page for the selected category
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryPage(
                                category: categories[index]['title']!),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            categories[index]['image']!,
                            height: 140,
                            width: 220,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            categories[index]['title']!,
                            style: const TextStyle(
                              fontSize: 12,
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
      ),
    );
  }
}

class CategoryPage extends StatelessWidget {
  final String category;

  const CategoryPage({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category)),
      body: Center(child: Text('Welcome to $category page!')),
    );
  }
}
