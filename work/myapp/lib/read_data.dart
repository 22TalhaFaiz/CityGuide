import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FetchData extends StatefulWidget {
  const FetchData({super.key});

  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  List<Map<String, dynamic>> _users = [];
  TextEditingController searchController = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // Fetching data from Firestore
  void fetchData() async {
    setState(() {
      _isLoading = true;
    });

    final userdata = await FirebaseFirestore.instance.collection('users').get();
    final rawdata = userdata.docs.map((doc) {
      var data = doc.data();
      data['id'] = doc.id; // Save the Firestore document ID as 'id'
      return data;
    }).toList();

    setState(() {
      _users = rawdata;
      _isLoading = false;
    });
  }

  // Update data in Firestore
  void updateData(String docId, Map<String, dynamic> newData) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(docId) // Use the document ID to get the correct document
          .update(newData); // Update specific fields
      print("Data updated successfully!");
    } catch (e) {
      print("Error updating data: $e");
    }
  }

  // Delete data from Firestore
  void deleteData(String docId) async {
    await FirebaseFirestore.instance.collection('users').doc(docId).delete();
  }

  // Show confirmation dialog for deleting data
  void deleteDialog(String docId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Confirmation',
              style: TextStyle(color: Colors.black)),
          content: Text('Are you sure you want to delete this user?',
              style: TextStyle(color: Colors.black)),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: TextStyle(color: Colors.black)),
            ),
            ElevatedButton(
              onPressed: () {
                deleteData(docId);
                Navigator.of(context).pop();
              },
              child: Text('Delete', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  // Show dialog for editing user details
  void showEditDialog(Map<String, dynamic> user) {
    final TextEditingController nameController =
        TextEditingController(text: user["name"]);
    final TextEditingController emailController =
        TextEditingController(text: user["email"]);
    final TextEditingController passwordController =
        TextEditingController(text: user["password"]);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit User', style: TextStyle(color: Colors.black)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle:
                      TextStyle(color: Colors.black), // Text field label color
                ),
                style: TextStyle(color: Colors.black), // Text input color
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.black),
                ),
                style: TextStyle(color: Colors.black), // Text input color
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.black),
                ),
                style: TextStyle(color: Colors.black), // Text input color
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: TextStyle(color: Colors.black)),
            ),
            ElevatedButton(
              onPressed: () {
                final updatedData = {
                  "name": nameController.text,
                  "email": emailController.text,
                  "password": passwordController.text,
                };

                updateData(user["id"],
                    updatedData); // Use Firestore document ID to update
                Navigator.of(context).pop();
              },
              child: Text('Update', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  // Add user dialog implementation
  void showAddUserDialog() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New User', style: TextStyle(color: Colors.black)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.black),
                ),
                style: TextStyle(color: Colors.black),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.black),
                ),
                style: TextStyle(color: Colors.black),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.black),
                ),
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: TextStyle(color: Colors.black)),
            ),
            ElevatedButton(
              onPressed: () async {
                final newUser = {
                  "name": nameController.text,
                  "email": emailController.text,
                  "password": passwordController.text,
                  "images":
                      "", // You can add default image logic here if needed
                };

                try {
                  // Add new user to Firestore
                  await FirebaseFirestore.instance
                      .collection('users')
                      .add(newUser);
                  print("User added successfully!");
                  Navigator.of(context).pop();
                  fetchData(); // Refresh the user data after adding a new user
                } catch (e) {
                  print("Error adding user: $e");
                }
              },
              child: Text('Add User', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users Data',
            style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255))),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: showAddUserDialog, // Show Add User Dialog
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search Users',
                labelStyle: TextStyle(color: Colors.black),
                prefixIcon: Icon(Icons.search, color: Colors.black),
              ),
              style: TextStyle(color: Colors.black),
              onChanged: (value) {
                setState(() {
                  if (value.isEmpty) {
                    fetchData(); // Reset the list to all users when search query is empty
                  } else {
                    _users = _users
                        .where((user) =>
                            user["name"]
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            user["email"]
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                        .toList();
                  }
                });
              },
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _users.isEmpty
                    ? Center(child: Text("No users found."))
                    : ListView.builder(
                        itemCount: _users.length,
                        itemBuilder: (context, index) {
                          final user = _users[index];
                          return Card(
                            margin: EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Name: ${user["name"]}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                  Text("Email: ${user["email"]}",
                                      style: TextStyle(color: Colors.black)),
                                  Text("Password: ${user["password"]}",
                                      style: TextStyle(color: Colors.black)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () => showEditDialog(user),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () =>
                                            deleteDialog(user["id"]),
                                      ),
                                    ],
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
