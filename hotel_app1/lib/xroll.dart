import 'package:flutter/material.dart';

class HotelDetails extends StatelessWidget {
  final String hotelName;
  final List<String> photos;
  final String description;
  final List<Map<String, String>> reviews; // Each review contains customer name and comment

  HotelDetails({
    required this.hotelName,
    required this.photos,
    required this.description,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emaar Al Manarr'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Photo Carousel
            Container(
              height: 200,
              child: PageView.builder(
                itemCount: photos.length,
                itemBuilder: (context, index) {
                  return Image.asset(
                    photos[index],
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),

            // Description Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                description,
                style: TextStyle(fontSize: 16),
              ),
            ),

            // Reviews Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Customer Reviews",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ...reviews.map((review) => ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.person),
              ),
              title: Text(review['name']!),
              subtitle: Text(review['comment']!),
            )),
          ],
        ),
      ),
    );
  }
}
