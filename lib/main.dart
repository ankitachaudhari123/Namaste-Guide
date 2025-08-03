import 'package:flutter/material.dart';
import 'package:namaste_guide/Bottom_Nav_Bar/BottomNav.dart';

import 'notification_service.dart'; 
import 'SplashScreen.dart';
import 'User_Info/EditSingnUpInfo.dart';
import 'User_Info/SingnUp.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await NotificationService.init(); 
  await askNotificationPermission();
  runApp(const MyApp());
}
Future<void> askNotificationPermission() async {
  final status = await Permission.notification.status;
  if (!status.isGranted) {
    final result = await Permission.notification.request();
    print('🔐 Notification permission: $result');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Namaste Guide',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      routes: {
        'editProfile': (context) => EditInfo(), 
        'HomePage': (context) => BottomNavPage(), 
      },
    );
  }
}
