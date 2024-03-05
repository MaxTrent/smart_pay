import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_pay/app_theme.dart';

class OnboardingIndicator extends ConsumerWidget {
  OnboardingIndicator({
    super.key,
    required this.positionIndex,
    required this.currentIndex,
  });

  final int positionIndex;
  final StateProvider currentIndex;

  @override
  Widget build(BuildContext context, ref) {
    return Row(
      children: [
        Container(
          width: positionIndex == ref.watch(currentIndex) ? 32.w : 6.h,
          height: 6.h,
          decoration: BoxDecoration(
              color: positionIndex == ref.watch(currentIndex)
                  ? Colors.black
                  : lightGrey,
              borderRadius: BorderRadius.circular(500.r)),
        ),
      ],
    );
  }
}