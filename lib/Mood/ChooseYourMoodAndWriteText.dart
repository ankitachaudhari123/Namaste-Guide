import 'package:flutter/material.dart';

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
      backgroundColor: Color(0xff1f1835),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
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
                  _buildMoodTile("Sad", Icons.water_drop_rounded),
                  _buildMoodTile("Angry", Icons.brightness_auto_sharp),
                  _buildMoodTile("Sleepy", Icons.airline_seat_flat),
                ]),
                _buildMoodRow([
                  _buildMoodTile("Speak to Someone", Icons.call),
                  _buildMoodTile("Work", Icons.work_outline),
                  _buildMoodTile("Study", Icons.computer),
                  _buildMoodTile("Gym & Yoga", Icons.yard_outlined),
                ]),
                _buildMoodRow([
                  _buildMoodTile("Party", Icons.party_mode_outlined),
                  _buildMoodTile("Travel", Icons.travel_explore_rounded),
                  _buildMoodTile("Cleaning", Icons.clean_hands_outlined),
                  _buildMoodTile("Cooking", Icons.food_bank_outlined),
                ]),
                _buildMoodRow([
                  _buildMoodTile("Shopping", Icons.shopping_cart_outlined),
                  _buildMoodTile("Creative", Icons.palette_outlined),
                  _buildMoodTile("Reading", Icons.book_outlined),
                  _buildMoodTile("Writing", Icons.mode_edit_outlined),
                ]),

                const SizedBox(height: 20),

                /// Add Mood Button
                GestureDetector(
                  onTap: () {
                    print("Selected Mood: $selectedMood");
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
          margin: EdgeInsets.symmetric(horizontal: 5),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: isSelected
                ? LinearGradient(
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
              SizedBox(height: 5),
              Text(
                mood,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
