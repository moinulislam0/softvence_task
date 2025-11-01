import 'package:flutter/material.dart';
import 'package:softvence_task/common_widget/page_indicator.dart';
import 'package:softvence_task/constant/app_colors.dart';
import 'package:softvence_task/features/onboarding/widgets/button/ButtonWidget.dart';

import '../widgets/onboarding_page_content/onboarding_page_content.dart';

// This is the main screen for the onboarding feature.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Data for the onboarding pages. Can be expanded easily.
  final List<Map<String, String>> _onboardingData = [
    {
      'image': 'assets/images/screen1.png',
      'title': 'Discover the world, one journey at a time.',
      'description':
          'From hidden gems to iconic destinations, we make travel simple, inspiring, and unforgettable. Start your next adventure today.',
    },
    // Add more pages here if needed
    {
      'image': 'assets/images/screen2.png',
      'title': 'Explore new horizons one step at a time',
      'description':
          'Every trip holds a stroy waiting to be lived.Let us guide you to experience that inspire,connect,and last a lifetime',
    },
    {
      'image': 'assets/images/screen3.png',
      'title': 'See the beauty,one journey at a time',
      'description':
          'Travel made simple and exciting-- discover places you\'ll love and moments you\'ll never forget',
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (_pageController.page != null) {
        setState(() {
          _currentPage = _pageController.page!.round();
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNextPressed() {
    if (_currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      // Handle action for the last page, e.g., navigate to home screen
      print("Onboarding complete!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.darkBackground,
      body: Stack(
        children: [
          // Background content (Image/Icon + Gradient)
          PageView.builder(
            controller: _pageController,
            itemCount: _onboardingData.length,
            itemBuilder: (context, index) {
              return OnboardingPageContent(
                image: _onboardingData[index]['image']!,
                title: _onboardingData[index]['title']!,
                description: _onboardingData[index]['description']!,
              );
            },
          ),
          // "Skip" Button
          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              onPressed: () {
                // Handle skip action
                print("Skip pressed");
              },
              child: const Text(
                'Skip',
                style: TextStyle(
                  color: ColorConstants.textWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          // Bottom content (Text, Indicators, Button)
          Positioned(
            bottom: 90,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _onboardingData[_currentPage]['title']!,
                  key: ValueKey<int>(_currentPage), // Helps with animation
                  style: const TextStyle(
                    color: ColorConstants.textWhite,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  _onboardingData[_currentPage]['description']!,
                  key: ValueKey<int>(_currentPage + 100), // Unique key
                  style: const TextStyle(
                    color: ColorConstants.textGrey,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _onboardingData.length,
                    (index) => PageIndicator(isActive: index == _currentPage),
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: Buttonwidget(onTap: _onNextPressed),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
