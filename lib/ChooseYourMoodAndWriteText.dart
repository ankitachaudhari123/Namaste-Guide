import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ChooseYourMood extends StatefulWidget {
  const ChooseYourMood({super.key});

  @override
  State<ChooseYourMood> createState() => _ChooseYourMoodState();
}

class _ChooseYourMoodState extends State<ChooseYourMood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xff1f1835),
        child:Column(
          children: [
            // Container(
            //   child: Padding(
            //     padding: const EdgeInsets.all(20),
            //     child: TextField(
            //       style: TextStyle(
            //         color: Colors.white,
            //       ),
            //       decoration: InputDecoration(
            //             labelText: 'Enter Your Fillings',
            //             labelStyle: TextStyle(color: Colors.white),
            //             enabledBorder: OutlineInputBorder(
            //           borderSide: BorderSide(color: Colors.white, width: 2.0), // Normal border color
            //         ),
            //         focusedBorder: OutlineInputBorder(
            //           borderSide: BorderSide(color: Colors.white, width: 2.0), // Border color when focused
            //         ),
            //           ),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Container(
                width: double.infinity,
                height: 100,
                child: Row(
                  children: [
                    Expanded(
                      child:Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                            ),
                            Text(
                              "gsfsdhcj"
                            )
                          ],
                        ),
                      ),
                    ),
                     SizedBox(width: 10),
                    Expanded(
                      child:Container(
                        color:Colors.red[300],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child:Container(
                        color:Colors.red[400],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: double.infinity,
                height: 100,
                child: Row(
                  children: [
                    Expanded(
                      child:Container(
                       color:Colors.red[400],
                      ),
                    ),
                     SizedBox(width: 10),
                    Expanded(
                      child:Container(
                        color:Colors.red[600],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child:Container(
                        color:Colors.red[900],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                width: double.infinity,
                height: 100,
                child: Row(
                  children: [
                    Expanded(
                      child:Container(
                       color:Colors.red[100],
                      ),
                    ),
                     SizedBox(width: 10),
                    Expanded(
                      child:Container(
                        color:Colors.red[300],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child:Container(
                        color:Colors.red[400],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),




          


      ),
    );
  }
}