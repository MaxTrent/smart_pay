import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_pay/screens/onboarding.dart';

import '../main.dart';

final splashScreenTimerProvider = Provider<Timer>((ref) {
  return Timer(
    const Duration(seconds: 3),
    () {
      ref.read(navigatorKeyProvider).currentState!.pushReplacement(
            MaterialPageRoute(builder: (context) => Onboarding()),
          );
    },
  );
});

class SplashScreen extends ConsumerWidget {
  static const String id = 'splash-screen';

  SplashScreen({Key? key}) : super(key: key);

  // void initState() {
  //   Timer(
  //       const Duration(
  //         seconds: 5,
  //       ), () {
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => Onboarding()));
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context, ref) {
    ref.watch(splashScreenTimerProvider);

    return Scaffold(body: Center(child: SvgPicture.asset('assets/logo.svg')));
  }
}
