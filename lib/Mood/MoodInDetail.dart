import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:namaste_guide/Mood/UpdateMoodDetails.dart';
import 'package:namaste_guide/Mood/todays_mood.dart';
import 'dart:convert';
import 'ChooseYourMoodAndWriteText.dart';

class MoodInDetail extends StatefulWidget {
  final String MoodId;
  const MoodInDetail({super.key, required this.MoodId});

  @override
  State<MoodInDetail> createState() => _MoodInDetailState();
}

class _MoodInDetailState extends State<MoodInDetail> {
  List moodinfo = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchmoodinfo();
  }

  Future<void> fetchmoodinfo() async {
    String uri = "http://192.168.31.71/namaste_guide_api/feach_mood_desc.php";

    try {
      var response = await http.post(
        Uri.parse(uri),
        body: {'mood_id': widget.MoodId},
      );

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        print("mood list: $data");

        setState(() {
          moodinfo = data;
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

  Future<void> deletemoodinfo() async {
    String uri = "http://192.168.31.71/namaste_guide_api/delete_mood.php";

    try {
      var response = await http.post(
        Uri.parse(uri),
        body: {'mood_id': widget.MoodId},
      );

      print("Delete API Response: ${response.body}");

      if (response.body == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Deleted successfully!")),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TodaysMood()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to delete mood.")),
        );
      }
    } catch (e) {
      print("Exception: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Exception: $e")),
      );
    }
  }

  void showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete Mood"),
          content: Text("Are you sure you want to delete this mood?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                deletemoodinfo();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Feelings"),
        backgroundColor: const Color(0xff1f1835),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              if (moodinfo.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateMoodDetails(
                      moodId: widget.MoodId,
                      isEdit: true,
                      existingMoodData: {
                        'mood': moodinfo[0]['mood'],
                        'fellings': moodinfo[0]['fellings'],
                      },
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Mood data not available yet")),
                );
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: showDeleteDialog,
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xff1f1835),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
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
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Time: ${moodinfo[0]['time']}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Date: ${moodinfo[0]['date']}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Your Feelings: ${moodinfo[0]['fellings']}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
