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

    if (email.isNotEmpty) {
      FetchMoodData();
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> FetchMoodData() async {
    String uri =
        "http://192.168.43.50/namaste_guide_api/feach_your_mood_data.php";

    try {
      var response = await http.post(
        Uri.parse(uri),
        body: {'email_id': email},
      );

      if (response.statusCode == 200) {
        setState(() {
          moodlist = jsonDecode(response.body);
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

  // Group moods by month-year
  Map<String, List<dynamic>> groupMoodsByMonth(List moods) {
    Map<String, List<dynamic>> grouped = {};

    for (var mood in moods) {
      String dateStr = mood['date'] ?? "";
      if (dateStr.isEmpty) continue;

      DateTime parsedDate = DateTime.tryParse(dateStr) ?? DateTime.now();

      String monthYear = "${getMonthName(parsedDate.month)} ${parsedDate.year}";

      if (!grouped.containsKey(monthYear)) {
        grouped[monthYear] = [];
      }
      grouped[monthYear]!.add(mood);
    }

    // Sort months descending (latest first)
    var sortedKeys = grouped.keys.toList()
      ..sort((a, b) {
        DateTime dateA = DateTime.parse(
            "${a.split(" ")[1]}-${monthNumber(a.split(" ")[0]).toString().padLeft(2, "0")}-01");
        DateTime dateB = DateTime.parse(
            "${b.split(" ")[1]}-${monthNumber(b.split(" ")[0]).toString().padLeft(2, "0")}-01");
        return dateB.compareTo(dateA);
      });

    Map<String, List<dynamic>> sortedMap = {
      for (var key in sortedKeys) key: grouped[key]!
    };

    return sortedMap;
  }

  // Month name helper
  String getMonthName(int month) {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return months[month - 1];
  }

  // Month number helper
  int monthNumber(String monthName) {
    const months = {
      "January": 1,
      "February": 2,
      "March": 3,
      "April": 4,
      "May": 5,
      "June": 6,
      "July": 7,
      "August": 8,
      "September": 9,
      "October": 10,
      "November": 11,
      "December": 12,
    };
    return months[monthName] ?? 1;
  }

  // Emoji for moods
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
    final groupedMoods = groupMoodsByMonth(moodlist);

    return Scaffold(
      backgroundColor: const Color(0xff1f1835),
      // appBar: AppBar(
      //   title: const Text("Your Moods", style: TextStyle(color: Colors.white)),
      //   backgroundColor: const Color(0xff1f1835),
      //   iconTheme: const IconThemeData(color: Colors.white),
      // ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xff1f1835),
        child: isLoading
            ? const Center(child: CircularProgressIndicator(color: Colors.white))
            : groupedMoods.isEmpty
                ? const Center(
                    child: Text(
                      "No mood data available",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  )
                : ListView(
                    children: groupedMoods.entries.map((entry) {
                      String month = entry.key;
                      List moods = entry.value;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Month Header
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              month,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          // Mood Items
                          ...moods.map((mood) {
                            String moodName = mood['mood'] ?? "Unknown";
                            String moodId = mood['mood_id'].toString();
                            String moodTime = mood['time'] ?? "No Time";

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        MoodInDetail(MoodId: moodId),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Container(
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xff7c49de),
                                        Color(0xffdcb383)
                                      ],
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  child: ListTile(
                                    leading: Text(
                                      getMoodEmoji(moodName),
                                      style: const TextStyle(fontSize: 30),
                                    ),
                                    title: Text(
                                      "Mood: $moodName",
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
                          }).toList()
                        ],
                      );
                    }).toList(),
                  ),
      ),
    );
  }
}
