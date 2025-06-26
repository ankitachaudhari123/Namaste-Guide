import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Bottom_Nav_Bar/BottomNav.dart';
import 'User_Info/SingnUp.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  Future<void> _checkUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('user_email');

    await Future.delayed(const Duration(seconds: 3));

    if (email != null) {
      print("Stored Email: $email");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  BottomNavPage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignUp()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xff7c49de),
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
                    gradient: const LinearGradient(
                            colors: [Color(0xff7c49de), Color(0xffdcb383)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                      )
                    ),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(
              image: AssetImage('asset/logo.png'),
              width: 200,
              height: 200,
            ),
            Text(
              "Namaste Guide",
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ],
        ),
        ),
      
      ),
    );
  }
}
