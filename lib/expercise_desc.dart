import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ExperciseDesc extends StatefulWidget {
  const ExperciseDesc({super.key});

  @override
  State<ExperciseDesc> createState() => _ExperciseDescState();
}

class _ExperciseDescState extends State<ExperciseDesc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text("Description"),
        backgroundColor: Color(0xff1f1835),
      ),
      body: Container(
        width: double.infinity,
        // height: double.infinity,
        color: Color(0xff1f1835),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.amber
                ),
              ),
            ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: double.infinity,
                  child: Text(
                    "Information : ",
                    style:TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ) ,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}