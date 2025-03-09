import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:work/LocationMap.dart';
import 'package:work/Reviewpopup.dart';

class Detail extends StatefulWidget {
  final Map<String, dynamic> listing; // Accept listing data

  const Detail({Key? key, required this.listing}) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  bool isLiked = false; // Initial state

  // Function to open the map as a popup
  void openMapPopup() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Makes it fullscreen
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => LocationMapPopup(
        latitude: widget.listing['latitude'],
        longitude: widget.listing['longitude'],
      ),
    );
  }

  void showReviewsPopup(BuildContext context) {
    String documentId =
        widget.listing['id'] ?? ""; // Ensure document ID is passed

    if (documentId.isEmpty) {
      print("❌ Error: Missing Document ID");
      return; // Prevent opening the popup if ID is missing
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => ReviewsPopup(
        collection: widget.listing['collection'] ?? "UnknownCollection",
        documentId: documentId, // ✅ Now included
        listingName: widget.listing['name'] ?? "Unknown Place",
      ),
    );
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
              Positioned(
                top: 40, // Adjust for safe area
                left: 10, // Distance from left side
                child: IconButton(
                  icon: const Icon(Icons.arrow_back,
                      color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pop(context);
                  },
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

                      // Name
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
                        child: GestureDetector(
                          onTap: () =>
                              showReviewsPopup(context), // Open reviews popup
                          child: Row(
                            children: [
                              Icon(Icons.star, color: Colors.yellow),
                              Text(
                                "[${widget.listing['rating'].toString()}]",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                              const SizedBox(width: 5),
                              Text("View Reviews",
                                  style: TextStyle(color: Colors.blue)),
                            ],
                          ),
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
                          widget.listing['description'] ??
                              "No description available.",
                          style:
                              const TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ),

                      const Spacer(),

                      // Like Button & View Map
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
                                onPressed: openMapPopup, // Open map popup
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
