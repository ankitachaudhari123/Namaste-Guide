import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'MoodInDetail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListOfMoods extends StatefulWidget {
  const ListOfMoods({super.key});

  @override
  State<ListOfMoods> createState() => _ListOfMoodsState();
}

class _ListOfMoodsState extends State<ListOfMoods> {
  String email = "";
  List moodlist = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    useremail();
  }

  Future<void> useremail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedEmail = prefs.getString('user_email');
    setState(() {
      email = storedEmail ?? "";
    });

    print("mood email: $email");

    if (email.isNotEmpty) {
      FetchMoodData();
    }
  }

  Future<void> FetchMoodData() async {
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Shared preferences email ID missing")),
      );
      return;
    }

    String uri = "http://192.168.43.50/namaste_guide_api/feach_your_mood_data.php";

    try {
      var response = await http.post(
        Uri.parse(uri),
        body: {'email_id': email},
      );

      if (response.statusCode == 200) {
        setState(() {
          moodlist = jsonDecode(response.body);
          isLoading = false;
          print("mood list: $moodlist");
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

  String getMoodEmoji(String mood) {
    switch (mood.toLowerCase()) {
      case 'happy':
        return "😊";
      case 'sad':
        return "😢";
      case 'angry':
        return "😡";
      case 'surprise':
        return "😮";
      case 'confused':
        return "🤔";
      case 'excited':
        return "😍";
      case 'bored':
        return "😞";
      case 'anxious':
        return "😟";
      case 'nervous':
        return "😬";
      case 'frustrated':
        return "😤";
      case 'content':
        return "😊";
      case 'disappointed':
        return "😔";
      case 'joyful':
        return "🥳";
      case 'grateful':
        return "🙏";
      case 'embarrassed':
        return "😳";
      case 'proud':
        return "😌";
      case 'lonely':
        return "😔";
      case 'relaxed':
        return "☺️";
      case 'overwhelmed':
        return "😵‍💫";
      case 'motivated':
        return "💪";
      case 'guilty':
        return "😓";
      case 'euphoric':
        return "🥳";
      case 'hopeful':
        return "🌈";
      case 'fearful':
        return "😨";
      case 'indifferent':
        return "😐";
      case 'skeptical':
        return "🤨";
      case 'determined':
        return "🏆";
      case 'furious':
        return "😤";
      case 'cheerful':
        return "😄";
      case 'pessimistic':
        return "😒";
      default:
        return "❓";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: const Color(0xff1f1835),
    appBar: AppBar(
      title: Text(
        isLoading ? "Loading..." : (moodlist.isNotEmpty ? "Your Moods" : "No Mood Data"),
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: const Color(0xff1f1835),
      iconTheme: const IconThemeData(color: Colors.white),
    ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xff1f1835),
        child: Column(
          children: [
            Expanded(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : moodlist.isEmpty
                      ? const Center(
                          child: Text(
                            "No mood data available",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        )
                      : ListView.builder(
                          itemCount: moodlist.length,
                          itemBuilder: (context, index) {
                            String mood = moodlist[index]['mood'] ?? "Unknown";
                            String moodId = moodlist[index]['mood_id'].toString();
                            String moodTime = moodlist[index]['time'] ?? "No Time";

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MoodInDetail(MoodId: moodId),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                child: Container(
                                  width: double.infinity,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: const LinearGradient(
                                      colors: [Color(0xff7c49de), Color(0xffdcb383)],
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  child: ListTile(
                                    leading: Text(
                                      getMoodEmoji(mood),
                                      style: const TextStyle(fontSize: 30),
                                    ),
                                    title: Text(
                                      "Mood: $mood",
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                    trailing: Text(
                                      moodTime,
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
