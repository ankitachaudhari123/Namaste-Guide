import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '../User_Info/SingnUp.dart';
import 'ChangeUserName.dart';
import 'YourInfo.dart';
import 'changeWeightAndHeight.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
   Future<void> _deleteAccount(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_email'); // Remove stored email

    print("Stored email deleted"); // Debugging purpose

    // Navigate to SignUp and remove previous screens from stack
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const SignUp()),
      (route) => false, // Removes all previous routes
    );
  }

  // Show confirmation dialog before deleting account
  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Account"),
        content: const Text("Are you sure you want to delete your account? This action cannot be undone."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Close dialog
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              _deleteAccount(context); // Delete account
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
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

    print("profile email: $email");

    if (email.isNotEmpty) {
      userinfodata();
    }
  }

  Future<void> userinfodata() async{
 if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("profile page Shared preferences email ID missing")),
      );
      return;
    }

    String uri = "http://192.168.1.36/namaste_guide_api/feach_user_info.php";

    try{
      var response = await http.post(
        Uri.parse(uri),
        body: {'email_id': email},
      );
       if (response.statusCode == 200) {
        setState(() {
          userinfo = jsonDecode(response.body);
          print("user info list : $userinfo");
        });
      } else {
        print("Error: ${response.statusCode}");
        setState(() {
        });
      }
    }catch(e){
      print("Exception: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text("My Profile"),
        backgroundColor: Color(0xff1f1835),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xff1f1835),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      userinfo[0]['user_name']??"No Name",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      userinfo[0]['user_email_id']??"No email id",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child:GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChangeUserName()),
                  );
                },
              child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                            colors: [Color(0xff7c49de), Color(0xffdcb383)],
                            begin: Alignment.bottomLeft,
                            end: Alignment.bottomRight,
                      )
                    ),
                    child: Row(
                      children: [
                        Container(
                         width: 60,
                         child: Icon(
                          Icons.edit_document,
                              color: Colors.white,
                              size: 30,
                         ),
                        ),
                        Container(
                          width: 280,
                          child: Text(
                            "Chnage Username",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                            ),
                            ),
                        ),
                      ],
                    ),
                )
                ),
            ),
             Padding(
               padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),

               child:GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChangeHightWeight()),
                  );
                },
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
                        Container(
                         width: 60,
                         child: Icon(
                          Icons.info_outline,
                              color: Colors.white,
                              size: 30,
                         ),
                        ),
                        Container(
                          width: 280,
                          child: Text(
                            "Chnage Your weight & height",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                            ),
                            ),
                        ),
                      ],
                    ),
                ),
 ),
             ),
             Padding(
               padding: const EdgeInsets.only(left: 10, right: 10),
               child:GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const YourInfo()),
                  );
                },
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
                        Container(
                         width: 60,
                         child: Icon(
                          Icons.health_and_safety_outlined,
                              color: Colors.white,
                              size: 30,
                         ),
                        ),
                        Container(
                          width: 280,
                          child: Text(
                            "Your Info",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                            ),
                            ),
                        ),
                      ],
                    ),
                ),

),

             ),
              Padding(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                onTap: _showDeleteDialog, // Show confirmation dialog
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
                      const SizedBox(width: 15),
                      const Icon(
                        Icons.delete_outline_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                      const SizedBox(width: 14),
                      const Text(
                        "Delete Account",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}