import 'package:flutter/material.dart';
import 'package:music_api/modules/screens/detailsscreen/views/detailsscreen.dart';
import 'package:music_api/modules/screens/homescreen/views/homescreen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const Homescreen(),
        'details': (context) => const Details_screen(),
      },
    ),
  );
}
