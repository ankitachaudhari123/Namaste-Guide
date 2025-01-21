import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'breathing_expercise.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Plans"),
        backgroundColor: Color(0xff1f1835),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xff1f1835),
        child: Container(
                width: double.infinity, 
                height: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, right: 10, left:10),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context, MaterialPageRoute(builder: (context)=> Breathing_expercise())
                            );
                          },
                        child: Container(
                          width: double.infinity,
                          height: 185,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors:[Color(0xff7c49de), Color(0xffdcb383)],
                              begin: Alignment.bottomLeft,
                              end: Alignment.bottomRight
                              )
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 170,
                                height: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 60, bottom: 60, left: 20),
                                  child: Text(
                                    "Breathing Expercise",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),                                
                              ),
                              Container(
                                width: 170,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('asset/breathing_expercise.png'),
                                    fit: BoxFit.cover
                                    )
                                ),
                               )
                            ],
                          )
                        ),
                      ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context, MaterialPageRoute(builder: (context)=> Breathing_expercise()),
                            );
                          },
                        child: Container(
                          width: double.infinity,
                          height: 185,
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
                              Container(
                                width: 170,
                                height: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 60, bottom: 60, left: 20),
                                  child: Text(
                                    "Yoga classes",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),                                
                              ),
                              Container(
                                width: 170,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('asset/yoga.png'),
                                    fit: BoxFit.cover
                                    )
                                ),
                               )
                            ],
                          )
                        ),
                      ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        child:GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context, MaterialPageRoute(builder: (context)=> Breathing_expercise()),
                            );
                          },                       
                        child: Container(
                          width: double.infinity,
                          height: 185,
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
                              Container(
                                width: 170,
                                height: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 60, bottom: 60, left: 20),
                                  child: Text(
                                    "Guided Meditatin",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),                                
                              ),
                              Container(
                                width: 170,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('asset/meditation.png'),
                                    fit: BoxFit.cover
                                    )
                                ),
                               )
                            ],
                          )
                        ),
                       ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xff1f1835),
          selectedItemColor: Colors.white,
          unselectedItemColor: Color(0xff565171),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.face_6),
            label: 'todys mood',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}