import 'package:flutter/material.dart';
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final PageController _pageController = PageController(viewportFraction: 0.8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Travel Deals'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Discover Amazing Deals',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Black Friday Deals Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Black Friday Deals',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 250, // Adjust height for content
              child: PageView.builder(
                controller: _pageController,
                itemCount: 3, // Adjust based on the number of deals
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Deal Image
                          ClipRRect(
                            borderRadius:
                            BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.asset(
                              'assets/deal${index + 1}.jpg', // Replace with your image paths
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          // Deal Details
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Location ${index + 1}', // Replace with actual location
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Icon(Icons.star,
                                        color: Colors.amber, size: 16),
                                    Icon(Icons.star,
                                        color: Colors.amber, size: 16),
                                    Icon(Icons.star,
                                        color: Colors.amber, size: 16),
                                    Icon(Icons.star,
                                        color: Colors.amber, size: 16),
                                    Icon(Icons.star_half,
                                        color: Colors.amber, size: 16),
                                    SizedBox(width: 5),
                                    Text(
                                      '4.5 (120 reviews)', // Replace with dynamic values
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Special offer: Save up to 50%!', // Replace with dynamic details
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),

            // Footer
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'More deals coming soon!',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}