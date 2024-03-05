import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_pay/screens/create_new_password.dart';

import '../app_theme.dart';
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
                    padding: EdgeInsets.only(top: 40.h),
                    child: SvgPicture.asset(
                      'assets/verifyidentity.svg',
                      width: 84.23.w,
                      height: 77.23.h,
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
                              .copyWith(
                                  fontWeight: FontWeight.w400, color: darkGrey),
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
                              .copyWith(
                                  fontWeight: FontWeight.w400, color: darkGrey),
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 34.h, horizontal: 16.w),
                          child: SvgPicture.asset('assets/check.svg'),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Email',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith()),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text('A*******@mail.com',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500))
                          ],
                        ),
                        SizedBox(
                          width: 128.w,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 32.h, bottom: 32.h, right: 16.w),
                          child: SvgPicture.asset('assets/mail.svg'),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: AppButton(
                    text: 'Continue',
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => NewPassword()));
                    },
                    width: 327),
              )
            ],
          ),
        )),
      ),
    );
  }
}
