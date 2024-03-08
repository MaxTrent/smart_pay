
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../app_theme.dart';
import '../widgets/widgets.dart';

// State management provider to toggle password visibility for each field

// Providers to create TextEditingControllers for new and confirm password fields
final _newPasswordProvider =
    Provider<TextEditingController>((ref) => TextEditingController());
final _confirmPasswordProvider =
    Provider<TextEditingController>((ref) => TextEditingController());

class NewPassword extends ConsumerWidget {
  NewPassword({super.key});

  final obscureTextProvider =
  StateProviderFamily<bool, String>((ref, id) => true);


  @override
  Widget build(BuildContext context, ref) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),

      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(0,60.h),
          child: Padding(
            padding: EdgeInsets.only(top: 24.h, left: 16.w),            child: AppBar(
            primary: false,
          ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              // key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // Space content vertically
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.h),

                      SizedBox(height: 32.h),
                      Text(
                        'Create New Password',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Please, enter a new password below different from the previous password',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                fontWeight: FontWeight.w400, color: darkGrey),
                      ),
                      SizedBox(height: 32.h),
                      AppTextField(
                        controller: ref.read(_newPasswordProvider),
                        hintText: 'New Password',
                        keyboardType: TextInputType.emailAddress,
                        obscureText:
                            ref.watch(obscureTextProvider('newPassword')),
                        // Manage visibility using riverpod
                        suffixIcon: GestureDetector(
                          onTap: () =>
                              ref
                                      .read(obscureTextProvider('newPassword')
                                          .notifier)
                                      .state =
                                  !ref
                                      .read(obscureTextProvider('newPassword')
                                          .notifier)
                                      .state,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.0.w, vertical: 16.h),
                            child: SvgPicture.asset(
                              'assets/visibility.svg',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      AppTextField(
                        controller: ref.read(_confirmPasswordProvider),
                        hintText: 'Confirm Password',
                        keyboardType: TextInputType.emailAddress,
                        obscureText:
                            ref.watch(obscureTextProvider('confirmPassword')),
                        suffixIcon: GestureDetector(
                          onTap: () => ref
                                  .read(obscureTextProvider('confirmPassword')
                                      .notifier)
                                  .state =
                              !ref
                                  .read(obscureTextProvider('confirmPassword')
                                      .notifier)
                                  .state,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.0.w, vertical: 16.h),
                            child: SvgPicture.asset(
                              'assets/visibility.svg',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: Center(
                      child: AppButton(
                        text: 'Sign In',
                        onPressed: () {
                         // ...
                        },
                        width: 327,
                      ),
                    ),
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
