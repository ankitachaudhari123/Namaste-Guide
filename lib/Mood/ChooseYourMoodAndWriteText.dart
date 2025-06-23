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

  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  Future<void> _checkUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedEmail = prefs.getString('user_email'); // Fetch email from SharedPreferences

    setState(() {
      email = storedEmail ?? ""; // Ensure the email is properly assigned
    });

    print("Retrieved email from SharedPreferences: $email"); // Debugging
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
      print("Response: ${response.body}"); // Debugging

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
          physics: const BouncingScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                _buildMoodRow([
                  _buildMoodTile("Happy", Icons.emoji_emotions_outlined),
                  _buildMoodTile("Sad", Icons.sentiment_dissatisfied),
                  _buildMoodTile("Angry", Icons.sentiment_very_dissatisfied ),
                  _buildMoodTile("Sleepy", Icons.hotel),
                ]),
                _buildMoodRow([
                  _buildMoodTile("Speak to Someone", Icons.call),
                  _buildMoodTile("Work", Icons.work_outline),
                  _buildMoodTile("Study", Icons.computer),
                  _buildMoodTile("Gym & Yoga", Icons.self_improvement ),
                ]),
                _buildMoodRow([
                  _buildMoodTile("Party", Icons.celebration ),
                  _buildMoodTile("Travel", Icons.travel_explore_rounded),
                  _buildMoodTile("Cleaning", Icons.cleaning_services ),
                  _buildMoodTile("Cooking", Icons.food_bank_outlined),
                ]),
                _buildMoodRow([
                  _buildMoodTile("Shopping", Icons.shopping_cart_outlined),
                  _buildMoodTile("Creative", Icons.brush ),
                  _buildMoodTile("Reading", Icons.menu_book ),
                  _buildMoodTile("Writing", Icons.mode_edit_outlined),
                ]),

                const SizedBox(height: 20),

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
      ),
    );
  }

  /// Builds a single row of moods
  Widget _buildMoodRow(List<Widget> moodTiles) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: moodTiles,
      ),
    );
  }

  /// Builds an individual mood tile
  Widget _buildMoodTile(String mood, IconData icon) {
    bool isSelected = selectedMood == mood;
    return Expanded(
      child: GestureDetector(
        onTap: () => toggleMood(mood),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: isSelected
                ? const LinearGradient(
                    colors: [Color(0xff7c49de), Color(0xffdcb383)],
                    begin: Alignment.bottomLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: isSelected ? null : const Color(0xff1f1835),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 40),
              const SizedBox(height: 5),
              Text(
                mood,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
