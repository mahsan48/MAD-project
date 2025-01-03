import 'package:flutter/material.dart';
import 'hotel_picaso.dart';
class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<Map<String, dynamic>> hotels = [
    {'name': 'Picaso Hotel', 'image': 'assets/bar1.jpg', 'rating': 4.5},
    {'name': 'Grand Royal Hotel', 'image': 'assets/bar2.jpg', 'rating': 4.7},
    {'name': 'Luxe Stay Suites', 'image': 'assets/bar3.jpg', 'rating': 4.8},
  ];

  List<Map<String, dynamic>> filteredHotels = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredHotels = hotels;
  }

  // Filter the hotels based on the search query
  void _filterHotels(String query) {
    setState(() {
      searchQuery = query;
      filteredHotels = hotels
          .where((hotel) =>
          hotel['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Hotels'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              onChanged: _filterHotels,
              decoration: InputDecoration(
                hintText: 'Search for a hotel...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            // Display search results
            Expanded(
              child: ListView.builder(
                itemCount: filteredHotels.length,
                itemBuilder: (context, index) {
                  final hotel = filteredHotels[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigate to the selected hotel's details page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HotelDetailsPage(
                            hotelName: hotel['name'],
                            price: '150', // Placeholder price
                            description:
                            'Enjoy a luxurious stay at ${hotel['name']} with top amenities.',
                            imagePaths: [
                              hotel['image'],
                              'assets/bar2.jpg', // Placeholder images
                              'assets/bar3.jpg',
                            ],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: Image.asset(hotel['image'], width: 50, height: 50),
                        title: Text(hotel['name']),
                        subtitle: Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            Text('${hotel['rating']}'),
                          ],
                        ),
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
