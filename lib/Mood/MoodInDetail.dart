import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MoodInDetail extends StatefulWidget {
  const MoodInDetail({super.key});

  @override
  State<MoodInDetail> createState() => _MoodInDetailState();
}

class _MoodInDetailState extends State<MoodInDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Fellings"),
        backgroundColor: Color(0xff1f1835),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xff1f1835),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Text(
                  "Mood : Happy",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                child: Text(
                  "Time : 10:10 Am",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width:double.infinity,
                child: Row(
                  children: [
                    Container(
                      width: 130,
                      child: Text(
                        "Your Fellings : ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                        ),
                      ),
                    ),
                    Container(
                      width: 210,
                      child: Text(
                        "todays my mood is so happy because ....... is a special incedant in my life.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}