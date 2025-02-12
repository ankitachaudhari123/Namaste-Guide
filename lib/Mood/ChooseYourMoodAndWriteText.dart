import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ChooseYourMood extends StatefulWidget {
  const ChooseYourMood({super.key});

  @override
  State<ChooseYourMood> createState() => _ChooseYourMoodState();
}

class _ChooseYourMoodState extends State<ChooseYourMood> {
  String selectedMood = "Happy";

  void toggleMood(String mood) {
    setState(() {
      selectedMood = selectedMood == mood ? "" : mood;
    });
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
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                height: 80,
                child: Row(
                  children: [
                    _buildMoodTile("Happy", Icons.emoji_emotions_outlined),
                    const SizedBox(width: 10),
                    _buildMoodTile("Sad", Icons.water_drop_rounded),
                    const SizedBox(width: 10),
                    _buildMoodTile("Angry", Icons.brightness_auto_sharp),
                    const SizedBox(width: 10),
                    _buildMoodTile("Sleepy", Icons.airline_seat_flat),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),  // Add space between rows
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20),
  child: Container(
    width: double.infinity,
    height: 80,
    child: Row(
      children: [
        _buildMoodTile("Speak to some one", Icons.call),
                    const SizedBox(width: 10),
                    _buildMoodTile("Work", Icons.work_outline),
                    const SizedBox(width: 10),
                    _buildMoodTile("Study", Icons.computer),
                    const SizedBox(width: 10),
                    _buildMoodTile("Gym & Yoga", Icons.yard_outlined),
      ],
    ),
  ),
),
SizedBox(height: 10),  // Add space between rows
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20),
  child: Container(
    width: double.infinity,
    height: 80,
    child: Row(
      children: [
        _buildMoodTile("Party", Icons.party_mode_outlined),
                    const SizedBox(width: 10),
                    _buildMoodTile("Travel", Icons.travel_explore_rounded),
                    const SizedBox(width: 10),
                    _buildMoodTile("Cleaning", Icons.clean_hands_outlined),
                    const SizedBox(width: 10),
                    _buildMoodTile("Cooking", Icons.food_bank_outlined),
      ],
    ),
  ),
),
SizedBox(height: 10),  // Add space between rows
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20),
  child: Container(
    width: double.infinity,
    height: 80,
    child: Row(
      children: [
        _buildMoodTile("Shopping", Icons.shopping_cart_outlined),
                    const SizedBox(width: 10),
                    _buildMoodTile("Creative", Icons.party_mode_outlined),
                    const SizedBox(width: 10),
                    _buildMoodTile("Reading", Icons.book_outlined),
                    const SizedBox(width: 10),
                    _buildMoodTile("Writing", Icons.mode_edit_outlined),
      ],
    ),
  ),
),
            const Spacer(),
            Padding(
                padding: const EdgeInsets.all(20),
                child: GestureDetector(
                  onTap: () {
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                         colors: [Color(0xff7c49de), Color(0xffdcb383)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Add Mood",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoodTile(String mood, IconData icon) {
    bool isSelected = selectedMood == mood;
    return Expanded(
      child: GestureDetector(
        onTap: () => toggleMood(mood),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: isSelected
                ? const LinearGradient(
                    colors: [Color(0xff7c49de), Color(0xffdcb383)],
                    begin: Alignment.bottomLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: isSelected ? null : Color(0xff1f1835),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 40),
              Text(
                mood,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
