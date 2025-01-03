import 'package:flutter/material.dart';
import 'the_front.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HotelBookingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}