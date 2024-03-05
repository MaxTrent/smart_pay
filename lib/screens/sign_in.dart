import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_pay/appTheme.dart';
import 'package:smart_pay/screens/screens.dart';
import 'package:smart_pay/validators.dart';
import 'package:smart_pay/widgets/widgets.dart';

class SignIn extends ConsumerWidget {
  SignIn({super.key});

  final _emailController =
      Provider<TextEditingController>((ref) => TextEditingController());
  final _passwordController =
      Provider<TextEditingController>((ref) => TextEditingController());

  final obscureTextProvider = StateProvider<bool>((ref) => true);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, ref) {
    final emailController = ref.read(_emailController);
    final passwordController = ref.read(_passwordController);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              // key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 8.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40.h,
                      width: 40.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: lightGrey,
                          width: 1.w,
                        ),
                      ),
                      child: Icon(
                        CupertinoIcons.back,
                      ),
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Text(
                    'Hi There! 👋',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Welcome back, Sign in to your account',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.w400, color: darkGrey),
                  ),
                  SizedBox(height: 32.h),
                  AppTextField(
                    controller: emailController,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  AppTextField(
                    controller: ref.read(_passwordController),
                    hintText: 'Password',
                    keyboardType: TextInputType.emailAddress,
                    obscureText: ref.watch(obscureTextProvider),
                    suffixIcon: GestureDetector(
                      onTap: () =>
                          ref.read(obscureTextProvider.notifier).state =
                              !ref.read(obscureTextProvider.notifier).state,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0.w, vertical: 16.h),
                        child: SvgPicture.asset(
                          'assets/visibility.svg',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RecoverPassword()));
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.zero),
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: Text(
                        'Forgot Password?',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(color: darkGreen),
                      )),
                  SizedBox(
                    height: 24.h,
                  ),
                  Center(
                      child: AppButton(
                    text: 'Sign In',
                    onPressed: () {},
                    width: 327,
                  )),
                  SizedBox(
                    height: 32.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 142.w,
                        height: 1.h,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                          lightGrey.withOpacity(0.0),
                          lightGrey,
                        ])),
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      Text(
                        'OR',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      Container(
                        width: 142.w,
                        height: 1.h,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                          lightGrey,
                          lightGrey.withOpacity(0.0),
                        ])),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 56.h,
                        width: 155.w,
                        child: OutlinedButton(
                          onPressed: () {},
                          child: SvgPicture.asset('assets/google.svg'),
                          style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.r),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 56.h,
                        width: 155.w,
                        child: OutlinedButton(
                          onPressed: () {},
                          child: SvgPicture.asset('assets/apple.svg'),
                          style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.r),
                              )),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 138.h,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {},
                      child: Text.rich(TextSpan(
                          text: 'Don’t have an account? ',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: darkGrey),
                          children: [
                            TextSpan(
                                text: 'Sign Up',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(color: darkGreen))
                          ])),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


