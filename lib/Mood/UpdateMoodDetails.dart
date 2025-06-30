import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpdateMoodDetails extends StatefulWidget {
  final String moodId;
  final bool isEdit;
  final Map<String, dynamic>? existingMoodData;

  const UpdateMoodDetails({
    super.key,
    required this.moodId,
    required this.isEdit,
    this.existingMoodData,
  });

  @override
  State<UpdateMoodDetails> createState() => _UpdateMoodDetailsState();
}

class _UpdateMoodDetailsState extends State<UpdateMoodDetails> {
  String selectedMood = "Happy";
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

    if (widget.isEdit && widget.existingMoodData != null) {
      selectedMood = widget.existingMoodData!['mood'] ?? selectedMood;
      feelingsController.text = widget.existingMoodData!['fellings'] ?? "";
    }
  }

  void toggleMood(String mood) {
    setState(() {
      selectedMood = (selectedMood == mood) ? "" : mood;
    });
  }

  Future<void> updateMoodToBackend() async {
    String updatedMood = selectedMood;
    String updatedFeelings = feelingsController.text.trim();

    if (updatedMood.isEmpty || updatedFeelings.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a mood and enter your feelings.")),
      );
      return;
    }

    try {
      var response = await http.post(
        Uri.parse("http://192.168.43.50/namaste_guide_api/update_mood.php"),
        body: {
          'mood_id': widget.moodId,
          'mood': updatedMood,
          'fellings': updatedFeelings,
        },
      );

      print("Update Response: ${response.body}");

      if (response.statusCode == 200 && response.body == "success") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Mood updated successfully!")),
        );
        Navigator.pop(context); // Go back to previous page
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to update mood.")),
        );
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Mood Info"),
        backgroundColor: const Color(0xff1f1835),
      ),
      backgroundColor: const Color(0xff1f1835),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// TextField for Feelings
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
                            : const Color.fromARGB(255, 130, 128, 135),
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

              /// Update Mood Button
              GestureDetector(
                onTap: updateMoodToBackend,
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
                    "Update Mood",
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
