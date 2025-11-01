import 'package:flutter/material.dart';
import 'package:softvence_task/constant/app_colors.dart';

class Buttonwidget extends StatelessWidget {
  final VoidCallback onTap;
  const Buttonwidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorConstants.primaryPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      child: Text(
        'Next',
        style: const TextStyle(
          color: ColorConstants.textWhite,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
