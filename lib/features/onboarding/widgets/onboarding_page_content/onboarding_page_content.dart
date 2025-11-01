import 'package:flutter/material.dart';

import 'package:softvence_task/constant/app_colors.dart';

class OnboardingPageContent extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const OnboardingPageContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(30.0),
        bottomRight: Radius.circular(30.0),
      ),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 500,
            child: Image.asset(
              image,
              fit: BoxFit.contain,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ],
      ),
    );
  }
}
