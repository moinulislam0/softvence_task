import 'package:flutter/material.dart';
import 'package:softvence_task/features/onboarding/screens/onbording_screen.dart';
import 'package:softvence_task/helper/notification_service/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  runApp(MyApps());
}

class MyApps extends StatelessWidget {
  const MyApps({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "poppins"),
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
    );
  }
}
