import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../app_theme.dart';
import '../widgets/widgets.dart';

class NewPassword extends ConsumerWidget {
  NewPassword({super.key});
  final obscureTextProvider = StateProviderFamily<bool, String>((ref, id) => true);
  final _newPasswordProvider =
  Provider<TextEditingController>((ref) => TextEditingController());
  final _confirmPasswordProvider =
  Provider<TextEditingController>((ref) => TextEditingController());

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              // key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
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
                        'Create New Password',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Please, enter a new password below different from the previous password',
                        style: Theme.of(context).textTheme.displayMedium!.copyWith(
                            fontWeight: FontWeight.w400, color: darkGrey),
                      ),
                      SizedBox(height: 32.h),
                      AppTextField(
                        controller: ref.read(_newPasswordProvider),
                        hintText: 'New Password',
                        keyboardType: TextInputType.emailAddress,
                        obscureText: ref.watch(obscureTextProvider('newPassword')),
                        suffixIcon: GestureDetector(
                          onTap: () =>
                          ref.read(obscureTextProvider('newPassword').notifier).state =
                          !ref.read(obscureTextProvider('newPassword').notifier).state,
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
                        height: 16.h,
                      ),
                      AppTextField(
                        controller: ref.read(_confirmPasswordProvider),
                        hintText: 'Confirm Password',
                        keyboardType: TextInputType.emailAddress,
                        obscureText: ref.watch(obscureTextProvider('confirmPassword')),
                        suffixIcon: GestureDetector(
                          onTap: () =>
                          ref.read(obscureTextProvider('confirmPassword').notifier).state =
                          !ref.read(obscureTextProvider('confirmPassword').notifier).state,
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
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: Center(
                        child: AppButton(
                          text: 'Sign In',
                          onPressed: () {},
                          width: 327,
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
