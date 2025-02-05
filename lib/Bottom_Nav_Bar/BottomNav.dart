import 'package:flutter/material.dart';
import 'package:namaste_guide/Mood/todays_mood.dart';
import '../Exercise/home_page.dart';
import '../Profile/profile_page.dart';

class BottomNavPage extends StatefulWidget {
  @override
  _BottomNavPageState createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int _currentIndex = 0;

  // List of pages
  final List<Widget> _pages = [
    HomePage(),
    TodaysMood(),
    ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], 
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff1f1835),
        selectedItemColor: Colors.white,
        unselectedItemColor: Color(0xff565171),
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.face_6),
            label: 'Todays Mood',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
