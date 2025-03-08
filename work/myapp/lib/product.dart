import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Attractions extends StatefulWidget {
  const Attractions({super.key});

  @override
  State<Attractions> createState() => _AttractionsState();
}

class _AttractionsState extends State<Attractions> {
  List<Map<String, dynamic>> _products = [];
  List<Map<String, dynamic>> _filteredProducts = [];
  TextEditingController searchController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // Fetch data from Firestore
  void fetchData() async {
    final userdata =
        await FirebaseFirestore.instance.collection('Attractions').get();
    final rawdata = userdata.docs
        .map((doc) => doc.data()..['id'] = doc.id)
        .toList(); // Add 'id' for each document
    setState(() {
      _products = rawdata;
      _filteredProducts = List.from(rawdata)
        ..sort((a, b) {
          double ratingA = double.tryParse(a["rating"].toString()) ?? 0.0;
          double ratingB = double.tryParse(b["rating"].toString()) ?? 0.0;
          return ratingB.compareTo(ratingA); // Sort descending
        });
      isLoading = false;
    });
  }

  // Update data in Firestore
  void updateData(String docId, Map<String, dynamic> newData) async {
    try {
      final db = FirebaseFirestore.instance.collection('Attractions');
      await db.doc(docId).update(newData); // Use document ID to update
      print("Attractions updated successfully!");
    } catch (e) {
      print("Error updating data: $e");
    }
  }

  // Delete data from Firestore
  void deleteData(String docId) async {
    try {
      final db = FirebaseFirestore.instance.collection('Attractions');
      await db.doc(docId).delete(); // Use document ID to delete
      print("Attractions deleted successfully!");
    } catch (e) {
      print("Error deleting data: $e");
    }
  }

  // Delete confirmation dialog
  void deleteDialog(String docId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Confirmation',
              style: TextStyle(color: Colors.black)),
          content: Text('Are you sure you want to delete this product?',
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

  // Show edit dialog
  void showEditDialog(Map<String, dynamic> Attraction) {
    final TextEditingController description =
        TextEditingController(text: Attraction["description"]);
    final TextEditingController imageurl =
        TextEditingController(text: Attraction["image_url"]);
    final TextEditingController name =
        TextEditingController(text: Attraction["name"]);
    final TextEditingController subcategoryController =
        TextEditingController(text: Attraction["subCategory"]);
    final TextEditingController ratingController =
        TextEditingController(text: Attraction["rating"].toString());
    final TextEditingController longitudeController =
        TextEditingController(text: Attraction["longitude"].toString());
    final TextEditingController latitudeController =
        TextEditingController(text: Attraction["latitude"].toString());
    final TextEditingController location =
        TextEditingController(text: Attraction["location"]);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Product', style: TextStyle(color: Colors.black)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: description,
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(color: Colors.black),
                ),
                style: TextStyle(color: Colors.black),
              ),
              TextField(
                controller: imageurl,
                decoration: InputDecoration(
                  labelText: 'Image URL',
                  labelStyle: TextStyle(color: Colors.black),
                ),
                style: TextStyle(color: Colors.black),
              ),
              TextField(
                controller: name,
                decoration: InputDecoration(
                  labelText: 'Attractions Name',
                  labelStyle: TextStyle(color: Colors.black),
                ),
                style: TextStyle(color: Colors.black),
              ),
              TextField(
                controller: subcategoryController,
                decoration: InputDecoration(
                  labelText: 'SubCategory',
                  labelStyle: TextStyle(color: Colors.black),
                ),
                style: TextStyle(color: Colors.black),
              ),
              TextField(
                controller: ratingController,
                decoration: InputDecoration(
                  labelText: 'Rating',
                  labelStyle: TextStyle(color: Colors.black),
                ),
                style: TextStyle(color: Colors.black),
              ),
              TextField(
                controller: longitudeController,
                decoration: InputDecoration(
                  labelText: 'Longitude',
                  labelStyle: TextStyle(color: Colors.black),
                ),
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: latitudeController,
                decoration: InputDecoration(
                  labelText: 'Latitude',
                  labelStyle: TextStyle(color: Colors.black),
                ),
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: location,
                decoration: InputDecoration(
                  labelText: 'Location',
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
              onPressed: () {
                final updatedData = {
                  "description": description.text,
                  "image_url": imageurl.text,
                  "name": name.text,
                  "subCategory": subcategoryController.text,
                  "rating": double.tryParse(ratingController.text) ?? 0.0,
                  "longitude": double.tryParse(longitudeController.text) ?? 0.0,
                  "latitude": double.tryParse(latitudeController.text) ?? 0.0,
                  "location": location.text
                };
                updateData(
                    Attraction["id"], updatedData); // Use Firestore document ID
                Navigator.of(context).pop();
              },
              child: Text('Update', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  // Show add product dialog
  void showAddProductDialog() {
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController imageurlController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController subcategoryController = TextEditingController();
    final TextEditingController ratingController = TextEditingController();
    final TextEditingController longitudeController = TextEditingController();
    final TextEditingController latitudeController = TextEditingController();
    final TextEditingController locationController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Attractions',
              style: TextStyle(color: Colors.black)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(color: Colors.black),
                ),
                style: TextStyle(color: Colors.black),
              ),
              TextField(
                controller: imageurlController,
                decoration: InputDecoration(
                  labelText: 'Image URL',
                  labelStyle: TextStyle(color: Colors.black),
                ),
                style: TextStyle(color: Colors.black),
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Attraction Name',
                  labelStyle: TextStyle(color: Colors.black),
                ),
                style: TextStyle(color: Colors.black),
              ),
              TextField(
                controller: subcategoryController,
                decoration: InputDecoration(
                  labelText: 'SubCategory',
                  labelStyle: TextStyle(color: Colors.black),
                ),
                style: TextStyle(color: Colors.black),
              ),
              TextField(
                controller: ratingController,
                decoration: InputDecoration(
                  labelText: 'Rating',
                  labelStyle: TextStyle(color: Colors.black),
                ),
                style: TextStyle(color: Colors.black),
              ),
              TextField(
                controller: longitudeController,
                decoration: InputDecoration(
                  labelText: 'Longitude',
                  labelStyle: TextStyle(color: Colors.black),
                ),
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.number, // Allow only numbers
              ),
              TextField(
                controller: latitudeController,
                decoration: InputDecoration(
                  labelText: 'Latitude',
                  labelStyle: TextStyle(color: Colors.black),
                ),
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.number, // Allow only numbers
              ),
              TextField(
                controller: locationController,
                decoration: InputDecoration(
                  labelText: 'Location',
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
              onPressed: () {
                final newProduct = {
                  "description": descriptionController.text,
                  "image_url": imageurlController.text,
                  "name": nameController.text,
                  "subCategory": subcategoryController.text,
                  "rating": double.tryParse(ratingController.text) ??
                      0.0, // Convert to double
                  "longitude": double.tryParse(longitudeController.text) ??
                      0.0, // Convert to double
                  "latitude": double.tryParse(latitudeController.text) ??
                      0.0, // Convert to double
                  "location": locationController.text
                };
                FirebaseFirestore.instance
                    .collection('Attractions')
                    .add(newProduct);
                Navigator.of(context).pop();
                fetchData(); // Refresh the list after adding the new product
              },
              child: Text('Add Product', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  // Search products
  void searchProducts(String query) {
    final results = _products.where((product) {
      final name = product['name'].toLowerCase();
      return name.contains(query.toLowerCase());
    }).toList();

    setState(() {
      _filteredProducts = results;
    });
  }

  // Sort products by price or name
  void sortProducts(String criterion) {
    setState(() {
      if (criterion == 'Rating') {
        _filteredProducts.sort((a, b) {
          double ratingA = double.tryParse(a['rating'].toString()) ?? 0.0;
          double ratingB = double.tryParse(b['rating'].toString()) ?? 0.0;
          return ratingB.compareTo(ratingA); // Sort descending
        });
      } else if (criterion == 'Name') {
        _filteredProducts.sort((a, b) => a['name'].compareTo(b['name']));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attractions Data'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: showAddProductDialog, // Show the Add Product Dialog
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: 'Search Attractions',
                      labelStyle: TextStyle(color: Colors.black),
                      prefixIcon: Icon(Icons.search, color: Colors.black),
                    ),
                    style: TextStyle(color: Colors.black),
                    onChanged: (value) {
                      setState(() {
                        if (value.isEmpty) {
                          _filteredProducts =
                              _products; // Reset to all products when search query is empty
                        } else {
                          searchProducts(
                              value); // Filter the list based on the search query
                        }
                      });
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () => sortProducts('Rating'),
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                        foregroundColor:
                            Colors.white, // Set text color to white
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Sort by Rating'),
                    ),
                    SizedBox(width: 10), // Space between buttons
                    TextButton(
                      onPressed: () => sortProducts('Name'),
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                        foregroundColor:
                            Colors.white, // Set text color to white
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Sort by Name'),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = _filteredProducts[index];
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
                              Text(
                                "Name: ${product["name"]}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text("Description: ${product["description"]}",
                                  style: TextStyle(color: Colors.black)),
                              Text("SubCategory: ${product["subCategory"]}",
                                  style: TextStyle(color: Colors.black)),
                              Text("Rating: ${product["rating"]}",
                                  style: TextStyle(color: Colors.black)),
                              product["image_url"] != null
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: CircleAvatar(
                                        radius: 40,
                                        backgroundImage: NetworkImage(
                                            product["image_url"] ?? ""),
                                      ),
                                    )
                                  : SizedBox.shrink(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () => showEditDialog(product),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () =>
                                        deleteDialog(product["id"]),
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
