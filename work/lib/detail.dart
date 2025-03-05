import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Detail extends StatefulWidget {
  final Map<String, dynamic> listing; // Accept listing data

  const Detail({Key? key, required this.listing}) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  bool isLiked = false; // Initial state

  // Function to open Google Maps for directions
  Future<void> openDirections(double latitude, double longitude) async {
    final String googleMapsUrl =
        "https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude";

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not launch Google Maps';
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          height: screenHeight,
          child: Stack(
            children: [
              // Listing Image
              Positioned(
                left: 0,
                right: 0,
                child: Container(
                  width: screenWidth,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.listing['image_url'] ?? ""),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              // Details Section
              Positioned(
                top: 270,
                child: Container(
                  width: screenWidth,
                  height: screenHeight - 270,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),

                      // Name & Price
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.listing['name'] ?? "Unknown Place",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                      ),

                      // Location
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.location_on_rounded,
                                color: Colors.grey),
                            const SizedBox(width: 5),
                            Text(widget.listing['location'] ??
                                "Location not available"),
                          ],
                        ),
                      ),

                      // Rating
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.star, color: Colors.yellow),
                            Icon(Icons.star, color: Colors.yellow),
                            Icon(Icons.star, color: Colors.yellow),
                            Icon(Icons.star, color: Colors.yellow),
                            Icon(Icons.star_outline_outlined,
                                color: Colors.grey),
                            SizedBox(width: 10),
                            Text(
                              "[${double.tryParse(widget.listing['rating'].toString()) ?? 0.0}]",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Description
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text(
                          "Description",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          widget.listing['description'] ?? "No description available.",
                          style: const TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ),

                      const Spacer(),

                      // Like Button & Book Now
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  isLiked
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isLiked ? Colors.red : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isLiked = !isLiked;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  // Navigate to the map page
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LocationMapPage(
                                        latitude: widget.listing['latitude'],
                                        longitude: widget.listing['longitude'],
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  elevation: 10,
                                  shadowColor:
                                      Colors.deepPurple.withOpacity(0.9),
                                  backgroundColor: Colors.deepPurple,
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text("View Map"),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// LocationMapPage to show Google Map
class LocationMapPage extends StatelessWidget {
  final double latitude;
  final double longitude;

  const LocationMapPage({Key? key, required this.latitude, required this.longitude}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Location Map")),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 14.0,
        ),
        markers: {
          Marker(
            markerId: MarkerId('location'),
            position: LatLng(latitude, longitude),
            infoWindow: InfoWindow(title: 'Location'),
          ),
        },
      ),
    );
  }
}
