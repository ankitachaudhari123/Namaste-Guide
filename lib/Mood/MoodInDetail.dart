import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MoodInDetail extends StatefulWidget {
  final String MoodId;
  const MoodInDetail({super.key, required this.MoodId});

  @override
  State<MoodInDetail> createState() => _MoodInDetailState();
}

class _MoodInDetailState extends State<MoodInDetail> {
  List moodinfo = [];
  bool isLoading = true; // Added to track loading state

  @override
  void initState() {
    super.initState();
    fetchmoodinfo();
  }

  Future<void> fetchmoodinfo() async {
    String uri = "http://192.168.1.36/namaste_guide_api/feach_mood_desc.php";

    try {
      var response = await http.post(
        Uri.parse(uri),
        body: {'mood_id': widget.MoodId},
      );

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        print("mood list: $data");

        setState(() {
          moodinfo = data; // Update moodinfo
          isLoading = false;
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Feelings"),
        backgroundColor: const Color(0xff1f1835),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xff1f1835),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: isLoading
              ? const Center(child: CircularProgressIndicator()) // Show loading
              : moodinfo.isEmpty
                  ? const Center(
                      child: Text(
                        "No mood data available",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Mood: ${moodinfo[0]['mood']}",
                          style: const TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Time: ${moodinfo[0]['time']}",
                          style: const TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Date: ${moodinfo[0]['date']}",
                          style: const TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Your Feelings: ${moodinfo[0]['fellings']}",
                          style: const TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
