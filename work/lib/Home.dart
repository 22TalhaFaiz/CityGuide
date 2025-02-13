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
      ),
      drawer: Drawer(
        child: Column(children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: [Colors.orange, Colors.deepOrange])),
            accountName: Text('Ibrahim'),
            accountEmail: Text('ibo@gmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://www.google.com/url?sa=i&url=https%3A%2F%2Fpngtree.com%2Ffreepng%2Fuser-profile-avatar_13369988.html&psig=AOvVaw1AIfT0EuW5eHQJygOuFA13&ust=1738389005155000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCJC2uuuhn4sDFQAAAAAdAAAAABAE'),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => Home()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Login'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => login()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text('Signup'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => signup()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.login),
                  title: Text('Logout'),
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (builder) => Lp()));
                  },
                ),
              ],
            ),
          )
        ]),
      ),
      // appBar:
      //     AppBar(title: Text('Carousel Example')), // Add AppBar for better UI
      body: CarouselSlider(
        options: CarouselOptions(height: 400.0),
        items: [1, 2, 3, 4, 5].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Colors.amber,
                ),
                child: Center(
                  child: Text(
                    'text $i',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
