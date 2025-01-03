import 'package:flutter/material.dart';

class GrandRoyalHotelDetailsPage extends StatefulWidget {
  final String hotelName;
  final String price;
  final String description;
  final List<String> imagePaths;

  GrandRoyalHotelDetailsPage({
    required this.hotelName,
    required this.price,
    required this.description,
    required this.imagePaths,
  });

  @override
  _GrandRoyalHotelDetailsPageState createState() => _GrandRoyalHotelDetailsPageState();
}

class _GrandRoyalHotelDetailsPageState extends State<GrandRoyalHotelDetailsPage> {
  int _currentImageIndex = 0;
  late PageController _pageController;

  final List<String> facilities = [
    "Balcony",
    "Parking",
    "Air conditioning",
    "Free Wifi",
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.hotelName),  // This will show Grand Royal Hotel
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // Image Carousel
            Stack(
              children: [
                SizedBox(
                  height: 200,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: widget.imagePaths.length,
                    onPageChanged: (int index) {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          widget.imagePaths[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(widget.imagePaths.length, (index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        width: _currentImageIndex == index ? 12 : 8,
                        height: _currentImageIndex == index ? 12 : 8,
                        decoration: BoxDecoration(
                          color: _currentImageIndex == index
                              ? Colors.white
                              : Colors.white54,
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            // Address and Location
            Text(
              "Grand Royal Street, New York",  // Address for Grand Royal Hotel
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            SizedBox(height: 8),
            Text(
              "800 meters from subway station (Manhattan) • 4.3 miles from downtown/center",
              style: TextStyle(fontSize: 14, color: Colors.green),
            ),
            SizedBox(height: 16.0),

            // Facilities Section
            Text(
              "Great for your stay",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 10,
              runSpacing: 8,
              children: facilities.map((facility) {
                return Chip(
                  backgroundColor: Colors.blue.shade100,
                  label: Text(
                    facility,
                    style: TextStyle(fontSize: 14),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 16),

            // Discount Section
            Card(
              color: Colors.yellow.shade100,
              child: ListTile(
                leading: Icon(Icons.star, color: Colors.yellow.shade800),
                title: Text(
                  "You're at Genius Level 1",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("10% discount applied before taxes and fees."),
              ),
            ),
            SizedBox(height: 16),

            // Price and Description
            Text(
              "Price: \$${widget.price} per night",  // Price for Grand Royal Hotel
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
            SizedBox(height: 8),
            Text(
              widget.description,  // Description for Grand Royal Hotel
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            SizedBox(height: 16),

            // "See Availability" Button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                ),
                onPressed: () {
                  // Dummy action
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Checking availability...")),
                  );
                },
                child: Text(
                  "See availability",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
