import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'ChooseYourMoodAndWriteText.dart';


void main() => runApp(TodaysMood());

class TodaysMood extends StatefulWidget {
  const TodaysMood({super.key});

  @override
  State<TodaysMood> createState() => _TodaysMoodState();
  
}

class _TodaysMoodState extends State<TodaysMood> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('Todays Mood'),
          backgroundColor: Color(0xff1f1835),
          bottom: TabBar(
            tabs: [
              Tab(text: "Home"),
              Tab(text: "Profile"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ChooseYourMood(),
            Center(child: Text('Profile Content')),
          ],
        ),
      ),
    );
  }
}