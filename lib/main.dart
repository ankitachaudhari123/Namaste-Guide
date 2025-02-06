import 'package:flutter/material.dart';
import 'package:namaste_guide/Bottom_Nav_Bar/BottomNav.dart';

import 'User_Info/SingnUp.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Namaste Guide',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: BottomNavPage(),
      home: SingnUp(),
    );
  }
}

