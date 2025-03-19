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
  bool isLoading = true; // New variable to track loading state

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

    String uri = "http://192.168.1.48/namaste_guide_api/feach_your_mood_data.php";

    try {
      var response = await http.post(
        Uri.parse(uri),
        body: {'email_id': email},
      );

      if (response.statusCode == 200) {
        setState(() {
          moodlist = jsonDecode(response.body);
          isLoading = false; 
          print("mood list : $moodlist");
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xff1f1835),
        child: Column(
          children: [
            Expanded(
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : moodlist.isEmpty
                      ? Center(
                          child: Text(
                            "No mood data available",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        )
                      : ListView.builder(
                          itemCount: moodlist.length,
                          itemBuilder: (context, index) {
                            String mood = moodlist[index]['mood'] ?? "Unknown";
                            IconData getMoodIcon(String mood) {
      switch (mood.toLowerCase()) {
        case 'happy':
          return Icons.emoji_emotions_outlined;
        case 'sad':
          return Icons.sentiment_dissatisfied;
        case 'angry':
          return Icons.sentiment_very_dissatisfied;
        case 'sleepy':
          return Icons.hotel;
        case 'speak to someone':
          return Icons.call;
        case 'work':
          return Icons.work_outline;
        case 'study':
          return Icons.computer;
        case 'gym & yoga':
          return Icons.self_improvement;
        case 'party':
          return Icons.celebration;
        case 'travel':
          return Icons.travel_explore_rounded;
        case 'cleaning':
          return Icons.cleaning_services;
        case 'cooking':
          return Icons.food_bank_outlined;
        case 'shopping':
          return Icons.shopping_cart_outlined;
        case 'creative':
          return Icons.brush;
        case 'reading':
          return Icons.menu_book;
        case 'writing':
          return Icons.mode_edit_outlined;
        default:
          return Icons.help_outline; // Default icon for unknown moods
      }
    }
                            return GestureDetector(
                              onTap: () {
                                String moodId = moodlist[index]['mood_id'].toString();

                                print("mood id :$moodId");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => MoodInDetail(MoodId: moodId)),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                child: Container(
                                  width: double.infinity,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: const LinearGradient(
                                      colors: [Color(0xff7c49de), Color(0xffdcb383)],
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  child: ListTile(
                                    leading: Icon(
                                     getMoodIcon(mood),
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                    trailing: Text(
                                      moodlist[index]['time'] ?? "No Time",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    title: Text(
                                      "Mood: ${moodlist[index]['mood']}",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
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
