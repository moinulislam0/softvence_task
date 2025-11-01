import 'package:flutter/material.dart';
import 'package:softvence_task/constant/app_colors.dart';

class Buttonwidget extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  final Color buttonbgColor, borderColor;
  const Buttonwidget({
    super.key,
    required this.onTap,
    required this.buttonText,
    required this.buttonbgColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonbgColor,

        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      child: Text(
        buttonText,
        style: const TextStyle(
          color: ColorConstants.textWhite,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
