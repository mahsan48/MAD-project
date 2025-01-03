import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'hotel_picaso.dart';
import 'grh.dart';
class BookNow extends StatefulWidget {
  @override
  _BookNowState createState() => _BookNowState();
}

class _BookNowState extends State<BookNow> {
  // Define hotel deals within book_now.dart
  final List<Map<String, dynamic>> hotelDeals = [
    {
      'name': 'Picaso Hotel',
      'image': 'assets/bar1.jpg',
      'rating': 4.5,
      'reviews': 120,
      'offer': 'Save up to 50%!',
    },
    {
      'name': 'Grand Royal Hotel',
      'image': 'assets/bar2.jpg',
      'rating': 4.7,
      'reviews': 85,
      'offer': 'Early bird discounts!',
    },
    {
      'name': 'Luxe Stay Suites',
      'image': 'assets/bar3.jpg',
      'rating': 4.8,
      'reviews': 200,
      'offer': 'Special weekend prices!',
    },
  ];

  // Controllers for PageViews
  final PageController _pageControllerTopRated = PageController(viewportFraction: 0.8);
  final PageController _pageControllerDeals = PageController(viewportFraction: 0.8);

  // Current page trackers
  int _currentPageTopRated = 0;
  int _currentPageDeals = 0;

  // Timers for auto-swiping
  Timer? _timerTopRated;
  Timer? _timerDeals;

  // Variables to hold selections from the modal
  int selectedRooms = 1;
  int selectedAdults = 2;
  int selectedChildren = 0;
  bool travelingWithPets = false;

  // Bottom Navigation Bar index
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    // Timer for Top Rated PageView
    _timerTopRated = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPageTopRated < hotelDeals.length - 1) {
        _currentPageTopRated++;
      } else {
        _currentPageTopRated = 0;
      }
      _pageControllerTopRated.animateToPage(
        _currentPageTopRated,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
    _timerDeals = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPageDeals < hotelDeals.length - 1) {
        _currentPageDeals++;
      } else {
        _currentPageDeals = 0;
      }
      _pageControllerDeals.animateToPage(
        _currentPageDeals,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timerTopRated?.cancel();
    _timerDeals?.cancel();
    _pageControllerTopRated.dispose();
    _pageControllerDeals.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }


  void _showRoomSelectionSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Makes the modal full screen on small devices
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            // Temporary variables to hold selections
            int rooms = selectedRooms;
            int adults = selectedAdults;
            int children = selectedChildren;
            bool pets = travelingWithPets;

            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                top: 16,
                left: 16,
                right: 16,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Rooms and Guests',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    _buildCounterRow(
                      title: 'Rooms',
                      value: rooms,
                      onAdd: () {
                        setModalState(() {
                          rooms++;
                        });
                      },
                      onRemove: () {
                        setModalState(() {
                          if (rooms > 1) rooms--;
                        });
                      },
                    ),
                    _buildCounterRow(
                      title: 'Adults',
                      value: adults,
                      onAdd: () {
                        setModalState(() {
                          adults++;
                        });
                      },
                      onRemove: () {
                        setModalState(() {
                          if (adults > 1) adults--;
                        });
                      },
                    ),
                    _buildCounterRow(
                      title: 'Children',
                      value: children,
                      onAdd: () {
                        setModalState(() {
                          children++;
                        });
                      },
                      onRemove: () {
                        setModalState(() {
                          if (children > 0) children--;
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Traveling with pets?', style: TextStyle(fontSize: 16)),
                        Switch(
                          value: pets,
                          onChanged: (value) {
                            setModalState(() {
                              pets = value;
                            });
                          },
                          activeColor: Colors.green,
                          inactiveThumbColor: Colors.grey,
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: Size(double.infinity, 48),
                        ),
                        onPressed: () {
                          // Update the main state with selections
                          setState(() {
                            selectedRooms = rooms;
                            selectedAdults = adults;
                            selectedChildren = children;
                            travelingWithPets = pets;
                          });
                          Navigator.pop(context);
                        },
                        child: Text('Apply'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }


  Widget _buildCounterRow({
    required String title,
    required int value,
    required VoidCallback onAdd,
    required VoidCallback onRemove,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16)),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove_circle_outline),
                onPressed: onRemove,
              ),
              Text(value.toString(), style: TextStyle(fontSize: 16)),
              TextButton(onPressed: (){}, child: Image.asset('assets/bell.png'))
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height + 400,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/f1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(color: Colors.black.withOpacity(0.1)),
              ),
            ),
            Container(color: Colors.black.withOpacity(0.3)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppBar().preferredSize.height + 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Hi Muhammad Ahsan', style: TextStyle(color: Colors.white70, fontSize: 20)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Find Your Hotel To Stay', style: TextStyle(color: Colors.white70, fontSize: 20)),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: buildTextField(Icons.search, 'Search hotels...'),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: buildTextField(Icons.calendar_today, 'Select Date (e.g., Mon, Nov 25)'),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: buildTextField(Icons.hotel, 'Rooms, Adults, Children'),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Top Rated', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 10),
                Container(
                  height: 200,
                  child: PageView.builder(
                    controller: _pageControllerTopRated,
                    itemCount: hotelDeals.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(image: AssetImage('assets/han$index.jpg'), fit: BoxFit.cover),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Black Friday Deals', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 10),
                Container(
                  height: 250,
                  child: PageView.builder(
                    controller: _pageControllerDeals,
                    itemCount: hotelDeals.length,
                    itemBuilder: (context, index) {
                      final deal = hotelDeals[index];
                      return GestureDetector(
                        onTap: () {
                          if (deal['name'] == 'Picaso Hotel') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HotelDetailsPage(
                                  hotelName: deal['name'],
                                  price: '150',
                                  description: 'Enjoy a luxurious stay at Picaso Hotel with top amenities.',
                                  imagePaths: ['assets/picaso1.jpg', 'assets/picaso2.jpg', 'assets/picaso3.jpg'],
                                ),
                              ),
                            );
                          } else if (deal['name'] == 'Grand Royal Hotel') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GrandRoyalHotelDetailsPage(
                                  hotelName: deal['name'],
                                  price: '270',
                                  description: 'Best hotel for your luxurious stay.',
                                  imagePaths: ['assets/bar1.jpg', 'assets/bar2.jpg'],
                                ),
                              ),
                            );
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black,
                            ),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                                  child: Image.asset(deal['image'], height: 150, width: double.infinity, fit: BoxFit.cover),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(deal['name'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                                      Row(
                                        children: [
                                          Icon(Icons.star, color: Colors.amber, size: 16),
                                          Icon(Icons.star, color: Colors.amber, size: 16),
                                          Icon(Icons.star, color: Colors.amber, size: 16),
                                          Icon(Icons.star, color: Colors.amber, size: 16),
                                          Icon(Icons.star_half, color: Colors.amber, size: 16),
                                          SizedBox(width: 5),
                                          Text("${deal['rating']} ★ (${deal['reviews']} reviews)", style: TextStyle(color: Colors.white70, fontSize: 14)),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Text(deal['offer'], style: TextStyle(color: Colors.white70, fontSize: 14)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black.withOpacity(0.7),
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, color: Colors.white),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: Colors.white),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget buildTextField(IconData icon, String hint) {
    return GestureDetector(
      onTap: () {
        if (hint == 'Rooms, Adults, Children') {
          _showRoomSelectionSheet();
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextField(
          enabled: false,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none,
            icon: Icon(icon, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
