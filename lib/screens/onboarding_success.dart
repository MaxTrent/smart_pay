import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_pay/widgets/app_button.dart';

import '../app_theme.dart';

class OnboardingSuccess extends ConsumerWidget {
  const OnboardingSuccess({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/successthumb.svg'),
            SizedBox(height: 32.h,),
            Text('Congratulations, James', style: Theme.of(context).textTheme.displayLarge,),
            SizedBox(height: 12.h,),
            Text(
              'You’ve completed the onboarding,\nyou can start using',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontWeight: FontWeight.w400, color: darkGrey),
            ),
            SizedBox(height: 32.h,),
            AppButton(text: 'Get Started', onPressed: (){}, width: 327)
          ],
        ),
      ),
    );
  }
}
