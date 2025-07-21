import 'package:flutter/material.dart';
import 'package:namaste_guide/Profile/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChangeHightWeight extends StatefulWidget {
  const ChangeHightWeight({super.key});

  @override
  State<ChangeHightWeight> createState() => _ChangeHightWeightState();
}

class _ChangeHightWeightState extends State<ChangeHightWeight> {
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

  Future<void> fetchUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('user_email');

    if (email != null) {
      try {
        var url = Uri.parse('http://192.168.31.71/namaste_guide_api/feach_user_info.php');
        var response = await http.post(url, body: {
          'email_id': email,
        });

        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          if (data.isNotEmpty) {
            setState(() {
              _heightController.text = data[0]['height'];
              _weightController.text = data[0]['weight'];
            });
          }
        } else {
          print("Failed to fetch data: ${response.statusCode}");
        }
      } catch (e) {
        print("Error: $e");
      }
    } else {
      print("Email not found in SharedPreferences");
    }
  }

  Future<void> updateHeightWeight() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('user_email');
    String height = _heightController.text.trim();
    String weight = _weightController.text.trim();

    if (email != null && height.isNotEmpty && weight.isNotEmpty) {
      try {
        var url = Uri.parse('http://192.168.31.71/namaste_guide_api/update_height_weight.php');
        var response = await http.post(url, body: {
          'email_id': email,
          'height': height,
          'weight': weight,
        });

        if (response.statusCode == 200) {
          var result = json.decode(response.body);

          if (result['status'] == 'success') {
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(
            //       'Updated successfully (BMI: ${result['bmi']}, Status: ${result['bmi_status']})',
            //     ),
            //   ),
            // );
            // await Future.delayed(Duration(milliseconds: 800));
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(result['message'] ?? 'Something went wrong')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Server error: ${response.statusCode}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unexpected error: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter both height and weight')),
      );
    }
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Weight And Height"),
        backgroundColor: Color(0xff1f1835),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Color(0xff1f1835),
          child: Column(
            children: [
              SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildTextField("Change Weight in kilograms", _weightController),
                      _buildTextField("Change Height in meters", _heightController),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: GestureDetector(
                  onTap: () {
                    updateHeightWeight();
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
                      "Update",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }
}
