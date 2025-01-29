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
            Container(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                        labelText: 'Enter Your Fillings',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0), // Normal border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0), // Border color when focused
                    ),
                      ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20,),
              child: Container(
                width: double.infinity,
                height: 80,
                child: Row(
                  children: [
                    Expanded(
                      child:Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.emoji_emotions_outlined,
                              color: Colors.white,
                              size: 40,
                            ),
                            Text(
                              "Happy",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                     SizedBox(width: 10),
                    Expanded(
                      child:Container(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.mode_of_travel_outlined,
                              color: Colors.white,
                              size: 40,
                            ),
                            Text(
                              "travel",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                     SizedBox(width: 10),
                    Expanded(
                      child:Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.emoji_emotions_outlined,
                              color: Colors.white,
                              size: 40,
                            ),
                            Text(
                              "Sad",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
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
              padding: const EdgeInsets.all(10),
              child: Container(
                width: double.infinity,
                height: 80,
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
                     SizedBox(width: 10),
                    Expanded(
                      child:Container(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.mode_of_travel_outlined,
                              color: Colors.white,
                              size: 40,
                            ),
                            Text(
                              "travel",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                width: double.infinity,
                height: 80,
                child: Row(
                  children: [
                    Expanded(
                      child:Container(
                       child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.work_outlined,
                              color: Colors.white,
                              size: 40,
                            ),
                            Text(
                              "Work Mood",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                     SizedBox(width: 10),
                    Expanded(
                      child:Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.computer_rounded,
                              color: Colors.white,
                              size: 40,
                            ),
                            Text(
                              "Study",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child:Container(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.computer_rounded,
                              color: Colors.white,
                              size: 40,
                            ),
                            Text(
                              "Study",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                     SizedBox(width: 10),
                    Expanded(
                      child:Container(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.mode_of_travel_outlined,
                              color: Colors.white,
                              size: 40,
                            ),
                            Text(
                              "travel",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: double.infinity,
                height: 80,
                child: Row(
                  children: [
                    Expanded(
                      child:Container(
                         child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.yard_outlined,
                              color: Colors.white,
                              size: 40,
                            ),
                            Text(
                              "Gym OR Yoga",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                     SizedBox(width: 10),
                    Expanded(
                      child:Container(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.party_mode_outlined,
                              color: Colors.white,
                              size: 40,
                            ),
                            Text(
                              "Party",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child:Container(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.mode_of_travel_outlined,
                              color: Colors.white,
                              size: 40,
                            ),
                            Text(
                              "travel",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                     SizedBox(width: 10),
                    Expanded(
                      child:Container(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.mode_of_travel_outlined,
                              color: Colors.white,
                              size: 40,
                            ),
                            Text(
                              "travel",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
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