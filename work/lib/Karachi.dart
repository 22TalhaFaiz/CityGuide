import 'package:flutter/material.dart';

class KarachiPage extends StatelessWidget {
  const KarachiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Karachi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Optionally, add a header or title
            const Text(
              'Explore Karachi Attractions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),  // Space between header and grid

            // The grid view that contains all cards
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,  // 2 columns
                  crossAxisSpacing: 10, // Horizontal space between items
                  mainAxisSpacing: 10, // Vertical space between items
                  childAspectRatio: 1.0, // Aspect ratio for each item
                ),
                itemCount: 6, // Number of items to show in the grid
                itemBuilder: (context, index) {
                  List<Map<String, String>> karachiAttractions = [
                    {
                      'image': 'assets/images/Sea1.webp',
                      'title': 'Karachi Beach',
                      'description': 'A beautiful beach with stunning views.',
                    },
                    {
                      'image': 'assets/images/Mall1.jpg',
                      'title': 'Mall',
                      'description': 'A famous area with shopping centers and restaurants.',
                    },
                    {
                      'image': 'assets/images/karachitower.jpg',
                      'title': 'Karachi Tower',
                      'description': 'An iconic tower offering panoramic city views.',
                    },
                    {
                      'image': 'assets/images/karachiZoo.jfif',
                      'title': 'Karachi Zoo',
                      'description': 'A large zoo featuring a variety of animals.',
                    },
                    {
                      'image': 'assets/images/paf museum Karachi.jpg',
                      'title': 'Karachi Museum',
                      'description': 'A museum displaying the rich history of the city.',
                    },
                    {
                      'image': 'assets/images/Tomb.JPG',
                      'title': 'Tomb',
                      'description': 'A modern shopping mall with international brands.',
                    },
                  ];

                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: InkWell(
                      onTap: () {
                        // Handle "See Location" button click, navigate to a new page showing the location
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                            child: Image.asset(
                              karachiAttractions[index]['image']!,
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 8),  // Space between image and text

                          // Title of the attraction
                          Text(
                            karachiAttractions[index]['title']!,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),  // Space between title and description

                          // Description of the attraction
                          Text(
                            karachiAttractions[index]['description']!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8),  // Space before button
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
