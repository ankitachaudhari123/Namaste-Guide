import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

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
        color: Color(0xff1f1835),
        child: Column(
          children: [
            Container(
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
            ),
             Container(
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
            ),
          ],
        ),
      ),
    );
  }
}