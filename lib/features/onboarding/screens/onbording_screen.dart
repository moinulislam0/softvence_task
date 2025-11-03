import 'dart:async';
import 'package:flutter/material.dart';
import 'package:softvence_task/common_widget/page_indicator.dart';
import 'package:softvence_task/constant/app_colors.dart';
import 'package:softvence_task/features/onboarding/screens/location_tracker/location_tracker.dart';
import 'package:softvence_task/features/onboarding/widgets/button/ButtonWidget.dart';

import '../widgets/onboarding_page_content/onboarding_page_content.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final List<Map<String, String>> _onboardingData = [
    {
      'image': 'assets/images/screen1.png',
      'title': 'Discover the world, one journey at a time.',
      'description':
          'From hidden gems to iconic destinations, we make travel simple, inspiring, and unforgettable. Start your next adventure today.',
    },
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

    // Start auto-scrolling
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _onboardingData.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
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
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LocationTracker()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.darkBackground,
      body: Stack(
        children: [
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

          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LocationTracker()),
                );
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

          Positioned(
            bottom: 90,
            left: 20,
            right: 20,
            top: 490,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  _onboardingData[_currentPage]['title']!,
                  key: ValueKey<int>(_currentPage),
                  style: const TextStyle(
                    color: ColorConstants.textWhite,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
                Text(
                  _onboardingData[_currentPage]['description']!,
                  key: ValueKey<int>(_currentPage + 100),
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
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: Buttonwidget(
                    borderColor: ColorConstants.primaryPurple,
                    buttonbgColor: ColorConstants.primaryPurple,
                    onTap: _onNextPressed,
                    buttonText: "Next",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
