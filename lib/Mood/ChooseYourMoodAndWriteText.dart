import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../Bottom_Nav_Bar/BottomNav.dart';

class ChooseYourMood extends StatefulWidget {
  const ChooseYourMood({super.key});

  @override
  State<ChooseYourMood> createState() => _ChooseYourMoodState();
}

class _ChooseYourMoodState extends State<ChooseYourMood> {
  String selectedMood = "Happy";
  String email = "";
  final TextEditingController feelingsController = TextEditingController();

  final List<Map<String, dynamic>> moods = [
    {"label": "Happy", "emoji": "😊"},
    {"label": "Sad", "emoji": "😢"},
    {"label": "Angry", "emoji": "😡"},
    {"label": "Surprise", "emoji": "😮"},
    {"label": "Confused", "emoji": "🤔"},
    {"label": "Excited", "emoji": "😍"},
    {"label": "Bored", "emoji": "😞"},
    {"label": "Anxious", "emoji": "😟"},
    {"label": "Nervous", "emoji": "😬"},
    {"label": "Frustrated", "emoji": "😤"},
    {"label": "Content", "emoji": "😊"},
    {"label": "Disappointed", "emoji": "😔"},
    {"label": "Joyful", "emoji": "🥳"},
    {"label": "Grateful", "emoji": "🙏"},
    {"label": "Embarrassed", "emoji": "😳"},
    {"label": "Proud", "emoji": "😌"},
    {"label": "Lonely", "emoji": "😔"},
    {"label": "Relaxed", "emoji": "☺️"},
    {"label": "Overwhelmed", "emoji": "😵‍💫"},
    {"label": "Motivated", "emoji": "💪"},
    {"label": "Guilty", "emoji": "😓"},
    {"label": "Euphoric", "emoji": "🥳"},
    {"label": "Hopeful", "emoji": "🌈"},
    {"label": "Fearful", "emoji": "😨"},
    {"label": "Indifferent", "emoji": "😐"},
    {"label": "Skeptical", "emoji": "🤨"},
    {"label": "Determined", "emoji": "🏆"},
    {"label": "Furious", "emoji": "😤"},
    {"label": "Cheerful", "emoji": "😄"},
    {"label": "Pessimistic", "emoji": "😒"},
  ];

  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  Future<void> _checkUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('user_email') ?? "";
    });
  }

  void toggleMood(String mood) {
    setState(() {
      selectedMood = (selectedMood == mood) ? "" : mood;
    });
  }

  Future<void> insertMood() async {
    String feelings = feelingsController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email is missing! Please log in again.")),
      );
      return;
    }

    if (selectedMood.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a mood!")),
      );
      return;
    }

    var url = Uri.parse("http://192.168.43.50/namaste_guide_api/insert_your_mood.php");

    try {
      var response = await http.post(
        url,
        body: jsonEncode({
          'email_id': email,
          'mood': selectedMood,
          'feelings': feelings,
        }),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );

      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData["message"])),
        );

        if (responseData["status"] == "success") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BottomNavPage()),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Server Error! Please try again later.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1f1835),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// TextField
              TextField(
                controller: feelingsController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Enter Your Feelings',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              /// Mood Selection Grid
              Wrap(
                spacing: 5,
                runSpacing: 10,
                children: moods.map((mood) {
                  return GestureDetector(
                    onTap: () => toggleMood(mood["label"]),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: selectedMood == mood["label"]
                            ? const Color(0xff7c49de)
                            : Color.fromARGB(255, 130, 128, 135),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white12),
                      ),
                      child: Text(
                        "${mood["emoji"]} ${mood["label"]}",
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 30),

              /// Add Mood Button
              GestureDetector(
                onTap: insertMood,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xff7c49de), Color(0xffdcb383)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "Add Mood",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
