import 'package:flutter/material.dart';
import 'package:namaste_guide/User_Info/SignIn.dart';
import 'package:namaste_guide/User_Info/SingnUp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'ChangeUserName.dart';
import 'YourInfo.dart';
import 'changeWeightAndHeight.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_email');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const SignIn()),
      (route) => false,
    );
  }
   Future<void> _delete(BuildContext context) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
  String? email = prefs.getString('user_email');

  if (email == null || email.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Email not found in preferences")),
    );
    return;
  }

  try {
    var response = await http.post(
      Uri.parse("http://192.168.43.50/namaste_guide_api/delete_account.php"),
      body: {'email_id': email},
    );

    var result = jsonDecode(response.body); 

    if (result == "account delete successfully") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account deleted successfully")),
      );
      // await prefs.remove('user_email');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SignUp()),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please try again")),
      );
    }
  } catch (e) {
    print("Error deleting account: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Something went wrong")),
    );
  }
}

  void _showlogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout your account? "),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _logout(context);
            },
            child: const Text("Logout", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showdeleteDialog(){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Account"),
        content: const Text("Are you sure you want to Delete your account? "),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _delete(context);
            },
            child: const Text("Delete Account", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  String email = "";
  List userinfo = [];

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
      userinfodata();
    }
  }

  Future<void> userinfodata() async {
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("profile page Shared preferences email ID missing")),
      );
      return;
    }

    String uri = "http://192.168.43.50/namaste_guide_api/feach_user_info.php";

    try {
      var response = await http.post(
        Uri.parse(uri),
        body: {'email_id': email},
      );
      if (response.statusCode == 200) {
        setState(() {
          userinfo = jsonDecode(response.body);
        });
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        backgroundColor: const Color(0xff1f1835),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xff1f1835),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                userinfo.isNotEmpty ? userinfo[0]['user_name'] ?? "No Name" : "No Name",
                                style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 10,),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ChangeUserName()),);
                                },
                                child:Icon(Icons.edit,color: Colors.white,),
                              ),
                              
                            ],
                          ),
                          Text(
                            userinfo.isNotEmpty ? userinfo[0]['user_email_id'] ?? "No email id" : "No email id",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildProfileTile(Icons.info_outline, "Chnage Your weight & height", () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangeHightWeight()));
                    }),
                    _buildProfileTile(Icons.health_and_safety_outlined, "Your Info", () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const YourInfo()));
                    }),
                    _buildProfileTile(Icons.share, "Share App", () {}),
                    _buildProfileTile(Icons.star_border, "Rate App", () {}),
                    _buildProfileTile(Icons.logout, "Logout", _showlogoutDialog),
                    _buildProfileTile(Icons.delete, "Delete Account", _showdeleteDialog),
                  ],
                ),
              ),

              const Divider(
                color: Colors.white70,
                thickness: 2,
                indent: 10,
                endIndent: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Privacy Policy", style: TextStyle(color: Colors.white70, fontSize: 16)),
                    Text("Change Log", style: TextStyle(color: Colors.white70, fontSize: 16)),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Text("Version 1.0.0", style: TextStyle(color: Colors.white70, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileTile(IconData icon, String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: onTap,
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
          child: Row(
            children: [
              SizedBox(width: 15),
              Icon(icon, color: Colors.white, size: 30),
              SizedBox(width: 14),
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
