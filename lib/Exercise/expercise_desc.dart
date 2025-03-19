import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExperciseDesc extends StatefulWidget {
  final String yogaExerciseID;
  const ExperciseDesc({super.key, required this.yogaExerciseID});

  @override
  State<ExperciseDesc> createState() => _ExperciseDescState();
}

class _ExperciseDescState extends State<ExperciseDesc> {
  List exerciseinfo = [];
  bool isLoading = true; // Track loading state

  Future<void> funfeachexerciseinfo() async {
    String uri = "http://192.168.1.48/namaste_guide_api/feach_info_of_exercise.php";
    try {
      var response = await http.post(
        Uri.parse(uri),
        body: {
          'yoga_exercise_id': widget.yogaExerciseID,
        },
      );

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          setState(() {
            exerciseinfo = data;
            isLoading = false; 
          });
        } else {
          print("No exercise data found");
          setState(() {
            isLoading = false; 
          });
        }
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
    funfeachexerciseinfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xff1f1835),
      appBar: AppBar(
        title: Text(
          exerciseinfo.isNotEmpty ? exerciseinfo[0]['exercise_name'] : "Exercise Details",
        ),
        backgroundColor: Color(0xff1f1835),
      ),
      body: isLoading
    ? Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      )
    : SingleChildScrollView( // Enables scrolling
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: double.infinity,
                height: 400, // Keep a fixed height for the image
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage('asset/${exerciseinfo[0]['exercise_img'] ?? 'default_image.png'}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
             Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
              child: Container(
                width: double.infinity,
                child: Text(
                  "Descreption :",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: double.infinity,
                child: Text(
                  exerciseinfo[0]['exercise_desc'] ?? "No info",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
