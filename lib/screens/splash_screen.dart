// Import required libraries for asynchronous operations, UI elements,
// responsive layout (optional), state management, SVG image display,
// shared preferences access, navigation, and app data storage/retrieval.
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_pay/screens/onboarding.dart';
import 'package:smart_pay/screens/pin_login.dart';
import 'package:smart_pay/screens/screens.dart';

import '../data/app_storage.dart';
import '../main.dart';

// Provider to create a timer that triggers navigation logic after 3 seconds
final splashScreenTimerProvider = Provider<Timer>((ref) {
  return Timer(
    const Duration(seconds: 3),
        () async {
      // Check user's onboarding and login status using shared preferences
      if (await SharedPreferencesHelper.isOnboardingCompleted()) {
        if (await SharedPreferencesHelper.isLoggedIn()) {
          // User logged in, navigate to PIN screen
          ref.read(navigatorKeyProvider).currentState!.pushReplacement(
            MaterialPageRoute(builder: (context) => PinLogin()),
          );
        } else {
          // User not logged in, navigate to login screen
          ref.read(navigatorKeyProvider).currentState!.pushReplacement(
            MaterialPageRoute(builder: (context) => SignIn()),
          );
        }
      } else {
        // Onboarding not completed, navigate to onboarding screen
        ref.read(navigatorKeyProvider).currentState!.pushReplacement(
          MaterialPageRoute(builder: (context) => Onboarding()),
        );
      }
    },
  );
});

class SplashScreen extends ConsumerWidget {
  static const String id = 'splash-screen'; // Unique identifier for navigation

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    // Start the timer provided by splashScreenTimerProvider
    ref.watch(splashScreenTimerProvider);

    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 1500),
          opacity: 1,
          curve: Curves.easeIn,
          child: SvgPicture.asset(
            'assets/logo.svg',
            width: 150.w
          ),
        ),
      ),
    );
  }
}
