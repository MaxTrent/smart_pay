import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_pay/screens/screens.dart';

import '../app_theme.dart';
import '../widgets/widgets.dart';

class SignUp extends ConsumerWidget {
  SignUp({super.key});

  final _emailController =
      Provider<TextEditingController>((ref) => TextEditingController());

  @override
  Widget build(BuildContext context, ref) {
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
                  SizedBox(height: 30.h),
                  Text.rich(TextSpan(
                      text: 'Create a ',
                      style: Theme.of(context).textTheme.displayLarge,
                      children: [
                        TextSpan(
                          text: 'Smartpay',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(color: darkGreen),
                        ),
                        TextSpan(
                          text: '\naccount',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ])),
                  SizedBox(height: 32.h),
                  AppTextField(
                    controller: ref.watch(_emailController),
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Center(
                      child: AppButton(
                    text: 'Sign Up',
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => VerifySignUp()));
                    },
                    width: 327,
                  )),
                  SizedBox(
                    height: 32.h,
                  ),
                  AuthAlternative(),
                  SizedBox(
                    height: 117.h,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => SignIn()));
                      },
                      child: Text.rich(TextSpan(
                          text: 'Already have an account? ',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w400, color: darkGrey),
                          children: [
                            TextSpan(
                                text: 'Sign In',
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
