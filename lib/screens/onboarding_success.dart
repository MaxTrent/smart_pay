import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_pay/models/models.dart';
import 'package:smart_pay/models/registeruser_model.dart';
import 'package:smart_pay/screens/screens.dart';
import 'package:smart_pay/widgets/app_button.dart';

import '../app_theme.dart';


class OnboardingSuccess extends ConsumerWidget {
  OnboardingSuccess({required this.fullName, super.key});

  String? fullName;

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SVG image depicting a successful thumbs-up.
              SvgPicture.asset('assets/successthumb.svg'),
              SizedBox(
                height: 32.h,
              ),

              Text(
                'Congratulations, ${fullName!.split(' ').first}',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              SizedBox(
                height: 12.h,
              ),

              Text(
                'You’ve completed the onboarding,\nyou can start using',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(fontWeight: FontWeight.w400, color: darkGrey),
              ),
              SizedBox(
                height: 32.h,
              ),
              // Button to navigate to the SignIn screen.
              AppButton(
                  text: 'Get Started',
                  onPressed: () {
                    // Navigate to the SignIn screen and remove the current screen from the stack.
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => SignIn(),
                      ),
                          (route) => false,
                    );
                  },
                  width: 327)
            ],
          ),
        ),
      ),
    );
  }
}
