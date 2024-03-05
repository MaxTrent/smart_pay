import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../appTheme.dart';
import '../widgets/widgets.dart';

class VerifyIdentity extends ConsumerWidget {
  const VerifyIdentity({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 35.71.h),
                    child: SvgPicture.asset(
                      'assets/verifyidentity.svg',
                      width: 90.24.w,
                      height: 76.29.h,
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Text(
                    'Verify your identity',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Where would you like ',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(fontWeight: FontWeight.w400, color: darkGrey),
                        ),
                        TextSpan(
                          text: 'Smartpay',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(color: darkGreen),
                        ),
                        TextSpan(
                          text: ' to send your security code?',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(fontWeight: FontWeight.w400, color: darkGrey),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  Container(
                    height: 88.h,
                    width: 327.w,
                    decoration: BoxDecoration(
                      color: textFieldColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child:
                    AppButton(text: 'Continue', onPressed: () {}, width: 327),
              )
            ],
          ),
        )),
      ),
    );
  }
}
