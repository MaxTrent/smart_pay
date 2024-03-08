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
    final currentIdx = ref.watch(currentIndex);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
      width: positionIndex == currentIdx ? 32.w : 6.h, // Animate width
      height: 6.h,
      decoration: BoxDecoration(
        color: positionIndex == currentIdx ? Colors.black : lightGrey,
        borderRadius: BorderRadius.circular(500.r),
      ),
    );
  }
}