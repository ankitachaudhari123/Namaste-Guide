import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'home_page.dart';

class Breathing_expercise extends StatefulWidget {
  const Breathing_expercise({super.key});

  @override
  State<Breathing_expercise> createState() => _Breathing_experciseState();
}

class _Breathing_experciseState extends State<Breathing_expercise> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Brething Expercise"),
        backgroundColor: Color(0xff1f1835),
      ),
      body: Container(
        width: double.infinity,
        color: Color(0xff1f1835),
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  ); 
                  
                  child: Container(
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [Color(0xff7c49de), Color(0xffdcb383)],
                        begin: Alignment.bottomLeft,
                        end: Alignment.bottomRight
                      )
                    ),
                  );
                }
            );
          }
        ),
      ),
    );
  }
}