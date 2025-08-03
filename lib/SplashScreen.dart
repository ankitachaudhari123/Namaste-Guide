import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Bottom_Nav_Bar/BottomNav.dart';
import 'User_Info/SingnUp.dart';
import 'notification_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkUserAndScheduleNotification(); // just one flow
  }

  Future<void> _checkUserAndScheduleNotification() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? email = prefs.getString('user_email');

  await Future.delayed(const Duration(seconds: 2));

  if (email != null) {
    print("Stored Email: $email");

    /// 🧹 Force clear to reschedule every time (for testing)
    await prefs.remove('hasScheduledNotification');

    bool? hasScheduled = prefs.getBool('hasScheduledNotification');
    if (hasScheduled != true) {
      await NotificationService.scheduleDailyNotification(hour: 7, minutes: 0);
      await prefs.setBool('hasScheduledNotification', true);
      print("✅ Daily notification scheduled at 7:0 PM");
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => BottomNavPage()),
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
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff7c49de), Color(0xffdcb383)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
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
