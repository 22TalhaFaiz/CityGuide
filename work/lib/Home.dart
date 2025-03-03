import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work/Abbotabad.dart';
import 'package:work/Islamabad.dart';
import 'package:work/Karachi.dart';
import 'package:work/Lp.dart';
import 'package:work/database_service.dart';
import 'package:work/explore.dart';
import 'package:work/lahore.dart';
import 'package:work/login.dart';
import 'package:work/multan.dart';
import 'package:work/profile.dart';
import 'package:work/search.dart';
import 'package:work/signup.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart'; // Add this import

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String userName = "Guest";
  String userEmail = "guest@example.com";
  final DatabaseService _databaseService = DatabaseService();
  List<Map<String, dynamic>> cities = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _fetchCities();
  }

  _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? 'Guest';
      userEmail = prefs.getString('userEmail') ?? 'guest@example.com';
    });
  }

  // Fetch categories from Firestore
  void _fetchCities() async {
    List<Map<String, dynamic>> fetchedCity = await _databaseService.getCity();
    setState(() {
      cities = fetchedCity;
      isLoading = false;
    });
  }
 bool _notificationsEnabled = true;
 bool _notificationsdisable = false;
 

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('City Guide ',style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.w900),)),
        actions: [
          IconButton(onPressed: () {Navigator.push(context,
                            MaterialPageRoute(builder: (builder) => Search()));}, icon: const Icon(Icons.search),color: Colors.deepPurple,),
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
                    leading: const Icon(Icons.home,color: Colors.blue,),
                    title: const Text('Home'),
                    onTap: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                  ),

                    ListTile(
                    leading: const Icon(Icons.location_city,color: Colors.brown,),
                    title: const Text('Place to visit'),
                    onTap: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                  ),

                    ListTile(
                    leading: const Icon(Icons.restaurant_outlined,color: Colors.yellow,),
                    title: const Text(' Resturent'),
                    onTap: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                  ),

                      ListTile(
                    leading: const Icon(Icons.hotel ,color: Colors.grey,),
                    title: const Text(' stay & Hotels'),
                    onTap: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                  ),

                  
                      ListTile(
                    leading: const Icon(Icons.event_available ,color: Colors.orange,),
                    title: const Text(' Events & Festivals'),
                    onTap: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                    ListTile(
                    leading: const Icon(Icons.shopping_bag,color: Colors.purple,),
                    title: const Text(' Shopping & Markets'),
                    onTap: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                  ),
ListTile(
      leading: const Icon(Icons.settings),
      title: const Text('Settings'),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Settings'),
              content: SizedBox(
                width: 500, // Adjust width
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Notification Toggle Switch
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Enable Notifications"),
                        Switch(
                          value: _notificationsEnabled,
                    

                          onChanged: (bool value) {
                            setState(() {
                              _notificationsEnabled = value;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Cards Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Notifications Card
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop(); // Close first dialog
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Notifications'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (_notificationsEnabled) ...[
                                        ListTile(
                                          leading: const Icon(Icons.notifications, color: Colors.blue),
                                          title: const Text('New message received'),
                                        ),
                                        ListTile(
                                          leading: const Icon(Icons.notifications, color: Colors.blue),
                                          title: const Text('Your booking is confirmed'),
                                        ),
                                      ] else
                                        const Text("Notifications are disabled"),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      child: const Text('Close'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.notifications, size: 40, color: Colors.blue),
                                  const SizedBox(height: 8),
                                  const Text('Notifications', style: TextStyle(fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Favorites Card
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop(); // Close first dialog
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Favorites'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        leading: const Icon(Icons.favorite, color: Colors.red),
                                        title: const Text('Favorite Place: Eiffel Tower'),
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.favorite, color: Colors.red),
                                        title: const Text('Favorite Restaurant: ABC Cafe'),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      child: const Text('Close'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.favorite, size: 40, color: Colors.red),
                                  const SizedBox(height: 8),
                                  const Text('Favorites', style: TextStyle(fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close dialog
                  },
                  child: const Text('Close'),
                ),
              ],
            );
          },
        );
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
                                builder: (builder) => const Signup()));
                      },
                    ),
                  ] else ...[
                    ListTile(
                      leading: const Icon(Icons.account_circle,color: Colors.green,),
                      title: const Text('Profile'),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Profile()));
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout,color: Colors.red,),
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
            ),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Recommendation',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'See All',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: isLoading
                  ? const Center(
                      child:
                          CircularProgressIndicator()) // Show loading while fetching
                  : GridView.builder(
                      shrinkWrap: true, // Prevents infinite height issue
                      physics:
                          const NeverScrollableScrollPhysics(), // Disable GridView scrolling
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: cities.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 5,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            
                          ),
                          child: InkWell(
                            onTap: () {
                              switch (cities[index]['title']) {
                                case 'Karachi':
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => KarachiPage()));
                                  break;
                                case 'Lahore':
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => lahorepage()));
                                  break;
                                case 'Multan':
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Multan()));
                                  break;
                                case 'Islamabad':
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              IslamabadPage()));
                                  break;
                                case 'Abbottabad':
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Abbottabad()));
                                  break;
                                default:
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CategoryPage(
                                          category: cities[index]['title']),
                                    ),
                                  );
                                  break;
                              }
                            },
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                  child: Image.network(
                                    cities[index]['image_url'],
                                    height: 120,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  cities[index]['title'],
                                  style: const TextStyle(),
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
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.reactCircle,
        height: 50,
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.explore, title: 'Explore'),
          TabItem(icon: Icons.search, title: 'Search'),
          TabItem(
              icon: Icons.person, title: 'Profile'), // ✅ Direct Icon use karein
        ],
        initialActiveIndex: 0,
        backgroundColor: Colors.white,
        color: Colors.deepPurple,
        activeColor: Colors.deepPurple,
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
