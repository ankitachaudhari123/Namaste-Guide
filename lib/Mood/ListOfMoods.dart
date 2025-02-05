import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:namaste_guide/Exercise/home_page.dart';

import 'MoodInDetail.dart';

class ListOfMoods extends StatefulWidget {
  const ListOfMoods({super.key});

  @override
  State<ListOfMoods> createState() => _ListOfMoodsState();
}

class _ListOfMoodsState extends State<ListOfMoods> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xff1f1835),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MoodInDetail()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                            colors: [Color(0xff7c49de), Color(0xffdcb383)],
                            begin: Alignment.bottomLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.emoji_emotions_outlined,
                              color: Colors.white,
                              size: 40,
                          ),
                          trailing: Text(
                            "10:10 AM",
                            style: TextStyle(
                              color: Colors.white,
                              // fontSize: 12
                            ),
                          ),
                          title: Text(
                            "Mood : Happy",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
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