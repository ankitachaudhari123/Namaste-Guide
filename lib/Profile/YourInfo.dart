import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class YourInfo extends StatefulWidget {
  const YourInfo({super.key});

  @override
  State<YourInfo> createState() => _YourInfoState();
}

class _YourInfoState extends State<YourInfo> {
  List yourinfo = [];
  bool isLoading = true;

  Future<void> fetchUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('user_email');

    if (email != null) {
      try {
        var url = Uri.parse('http://192.168.43.50/namaste_guide_api/feach_user_info.php');
        var response = await http.post(url, body: {
          'email_id': email,
        });

        if (response.statusCode == 200) {
          setState(() {
            yourinfo = jsonDecode(response.body);
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
  }

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Info"),
        backgroundColor: const Color(0xff1f1835),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xff1f1835),
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : yourinfo.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow("Username", yourinfo[0]['user_name']),
                      _buildInfoRow("Weight", "${yourinfo[0]['weight']} kg"),
                      _buildInfoRow("Height", "${yourinfo[0]['height']} Meters"),
                      _buildInfoRow("BMI", "${yourinfo[0]['bmi']}"),
                      _buildInfoRow("BMI Status", "${yourinfo[0]['bmi_status']}")
                    ],
                  )
                : const Center(
                    child: Text(
                      "No user data found.",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label : ",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }

  String calculateBMI(double? heightCm, double? weightKg) {
    if (heightCm == null || weightKg == null || heightCm == 0) return "N/A";
    double heightM = heightCm / 100;
    double bmi = weightKg / (heightM * heightM);
    return bmi.toStringAsFixed(1);
  }
}
