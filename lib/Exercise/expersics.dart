import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'expercise_desc.dart';

class Breathing_expercise extends StatefulWidget {
  final String yogaPlanId;
  const Breathing_expercise({super.key, required this.yogaPlanId});

  @override
  State<Breathing_expercise> createState() => _Breathing_experciseState();
}

class _Breathing_experciseState extends State<Breathing_expercise> {
  List exerciselist = [];
  bool isLoading = true; // Initially, loading is true

  Future<void> fetchExerciseList() async {
    String uri = "http://192.168.1.34/namaste_guide_api/feach_exercise.php";

    try {
      var response = await http.post(
        Uri.parse(uri),
        body: {'yoga_plan_id': widget.yogaPlanId},
      );

      if (response.statusCode == 200) {
        setState(() {
          exerciselist = jsonDecode(response.body);
          isLoading = false; // Set loading to false when data is fetched
        });
      } else {
        print("Error: ${response.statusCode}");
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Exception: $e");
      setState(() {
        isLoading = false;
      });
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
      backgroundColor: Color(0xff1f1835),
      appBar: AppBar(
        title: Text(isLoading ? "Loading..." : (exerciselist.isNotEmpty ? exerciselist[0]['yoga_plan_name'] : "No Name")),
        backgroundColor: Color(0xff1f1835),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : Container(
              width: double.infinity,
              color: Color(0xff1f1835),
              child: ListView.builder(
                itemCount: exerciselist.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      String yogaExerciseID = exerciselist[index]['yoga_exercise_id'].toString();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExperciseDesc(yogaExerciseID: yogaExerciseID),
                        ),
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
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 80,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('asset/${exerciselist[index]['exercise_cover_img'] ?? 'default_image.png'}'),
                                ),
                                border: Border.all(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          Container(
                            width: 230,
                            child: Text(
                              exerciselist[index]['exercise_name'] ?? "No Name",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
