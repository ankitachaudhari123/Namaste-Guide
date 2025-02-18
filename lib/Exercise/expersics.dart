import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'expercise_desc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Breathing_expercise extends StatefulWidget {
  final String yogaPlanId;
  const Breathing_expercise({super.key , required this.yogaPlanId});

  @override
  State<Breathing_expercise> createState() => _Breathing_experciseState();
}

class _Breathing_experciseState extends State<Breathing_expercise> {
  List exerciselist = [];

Future<void> fetchExerciseList() async {  
  String uri = "http://192.168.1.34/namaste_guide_api/feach_exercise.php";

  try {
    var response = await http.post(
      Uri.parse(uri),
       body: {
          'yoga_plan_id': widget.yogaPlanId, // Send yoga_plan_id to backend
        },
    );

    if (response.statusCode == 200) {
      setState(() {
        exerciselist = jsonDecode(response.body);
        print("this is exercise listttttt ${exerciselist}");
      });
    } else {
      print("Error: ${response.statusCode}");
    }
  } catch (e) {
    print("Exception: $e");
  }
}

@override
void initState() {
  super.initState();
  fetchExerciseList(); 
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Brething Exercise"),
        backgroundColor: Color(0xff1f1835),
      ),
      body: Container(
        width: double.infinity,
        color: Color(0xff1f1835),
        child: ListView.builder(
          itemCount: exerciselist.isNotEmpty ? exerciselist.length : 0,
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
                            image: DecorationImage(
                              image: AssetImage('asset/${exerciselist[index]['exercise_cover_img']??'default_image.png'}')),
                            border: Border.all(
                              color: Colors.white,
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
                          exerciselist[index]['exercise_name'] ?? "No Name",
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