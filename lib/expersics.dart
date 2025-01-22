import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'expercise_desc.dart';

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
          itemCount: 3,
          itemBuilder: ( context, int index) {
            return GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ExperciseDesc()),
                  ); 
              },
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [Color(0xff7c49de), Color(0xffdcb383)],
                        begin: Alignment.bottomLeft,
                        end: Alignment.bottomRight
                      )
                    ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            border: Border.all(
                              color: Colors.black,
                              width: 2
                            ),
                            borderRadius: BorderRadius.circular(50)
                          ),
                        ),
                      ),
                      Container(
                        width:230,
                        // color: Colors.green,
                        child: Text(
                          "Diaphragmatic Breathing",
                          style:TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          ) ,
                          ),
                      ),
                    ],
                  ),
                  )
            );
          }
        ),
      ),
    );
  }
}