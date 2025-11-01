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
          colors: [Color(0xFF0F063C), Color(0xFF0B184D)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Text(
                "Welcome! Your Smart",

                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),

              Text(
                "Travel Alarm",

                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  "Stay on schedule and enjoy every moment of your journey",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 70),
              Container(
                width: double.infinity,

                child: Image.asset(
                  "assets/images/location_tracker.png",
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 90),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(color: Colors.white),
                    backgroundColor: Color(0xFF0B184D),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Use current location",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        height: 20,
                        width: 20,
                        child: Image.asset(
                          "assets/images/location_logo.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
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
