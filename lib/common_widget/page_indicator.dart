import 'package:flutter/material.dart';
import 'package:softvence_task/constant/app_colors.dart';

// A reusable widget for showing a page indicator dot.
// It can be used in any PageView or carousel in the app.
class PageIndicator extends StatelessWidget {
  final bool isActive;

  const PageIndicator({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      width: isActive ? 8.0 : 8.0,
      height: 8.0,
      decoration: BoxDecoration(
        color: isActive
            ? ColorConstants.indicatorActive
            : ColorConstants.indicatorInactive,
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
  }
}
