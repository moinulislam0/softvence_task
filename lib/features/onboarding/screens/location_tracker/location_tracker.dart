import 'package:flutter/material.dart';
import 'package:softvence_task/constant/app_colors.dart';
import 'package:softvence_task/features/onboarding/widgets/button/ButtonWidget.dart';

class LocationTracker extends StatelessWidget {
  const LocationTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF6200EE), Color(0xFF3700B3)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor:
              Colors.transparent, // AppBar-কেও transparent করা হয়েছে।
          elevation: 0, // AppBar-এর নিচের shadow দূর করা হয়েছে।
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Text("Welcome! Your Smart Travel Alarm"),
              Text("Stay on schedule and enjoy every moment of your journey"),
              Image.asset("assets/images/location_tracker.png"),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("Use current location"), Icon(Icons.add)],
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: Buttonwidget(
                  borderColor: ColorConstants.primaryPurple,
                  onTap: () {},
                  buttonText: "Home",
                  buttonbgColor: ColorConstants.primaryPurple,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
