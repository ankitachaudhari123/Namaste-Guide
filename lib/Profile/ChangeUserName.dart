import 'package:flutter/material.dart';
import 'package:namaste_guide/Profile/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChangeUserName extends StatefulWidget {
  const ChangeUserName({super.key});

  @override
  State<ChangeUserName> createState() => _ChangeUserNameState();
}

class _ChangeUserNameState extends State<ChangeUserName> {
  TextEditingController _usernameController = TextEditingController();

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
        var url = Uri.parse('http://192.168.43.50/namaste_guide_api/feach_user_info.php');
        var response = await http.post(url, body: {
          'email_id': email,
        });

        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          if (data.isNotEmpty) {
            setState(() {
              _usernameController.text = data[0]['user_name'];
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

  Future<void> updateUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('user_email');
    String newUsername = _usernameController.text.trim();

    if (email != null && newUsername.isNotEmpty) {
      try {
        var url = Uri.parse('http://192.168.43.50/namaste_guide_api/update_username.php');
        var response = await http.post(url, body: {
          'email_id': email,
          'username': newUsername,
        });

        if (response.statusCode == 200) {
          var result = json.decode(response.body);
          if (result == "data update successfully") {
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(content: Text('Username updated successfully')),
            // );
            //  await Future.delayed(Duration(milliseconds: 500));

          // Navigate to ProfilePage
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage()),
          );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Something Went to wrong Please try again')),
            );
          }
        } else {
          print("Server error: ${response.statusCode}");
        }
      } catch (e) {
        print("Error updating username: $e");
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Username or email is missing')),
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Username"),
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
                      _buildTextField("Change Username"),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: GestureDetector(
                  onTap: () {
                    updateUsername();
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
                      "Update Username",
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

  Widget _buildTextField(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextField(
        controller: _usernameController,
        style: TextStyle(color: Colors.white),
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
