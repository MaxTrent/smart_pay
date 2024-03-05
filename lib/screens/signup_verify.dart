import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_pay/screens/screens.dart';
import 'package:smart_pay/validators.dart';
import 'package:smart_pay/widgets/app_button.dart';

import '../app_theme.dart';

final submitButtonColorProvider =
    StateProvider<Color>((ref) => buttonColor.withOpacity(0.7));

class VerifySignUp extends ConsumerWidget {
  VerifySignUp({super.key});

  final _formKey = GlobalKey<FormState>();

  final otpControllersProvider =
      Provider.family<TextEditingController, int>((ref, id) {
    return TextEditingController();
  });

  final enableButton = StateProvider((ref) => false);

  @override
  Widget build(BuildContext context, ref) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            onChanged: () {
              ref.read(submitButtonColorProvider.notifier).state =
                  _formKey.currentState!.validate()
                      ? buttonColor
                      : buttonColor.withOpacity(0.7);
            },
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                'Verify it’s you',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              SizedBox(height: 8.h),
              Text.rich(TextSpan(
                  text: 'We send a code to ( ',
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(fontWeight: FontWeight.w400, color: darkGrey),
                  children: [
                    TextSpan(
                      text: '*****@mail.com',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              fontWeight: FontWeight.w500, color: buttonColor),
                    ),
                    TextSpan(text: ' ). Enter it here to verify your identity')
                  ])),
              SizedBox(
                height: 32.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int i = 0; i < 5; i++)
                    AppOtpField(
                      controller: ref.watch(otpControllersProvider(i)),
                      onChanged: (value) {
                        if (value!.isNotEmpty) {
                          if (i < 4) {
                            FocusScope.of(context).nextFocus();
                          } else {
                            // Focus is on the last field, submit or perform desired action
                          }
                        } else {
                          if (i > 0) {
                            FocusScope.of(context).previousFocus();
                          }
                        }
                      },
                    ),
                ],
              ),
              SizedBox(
                height: 32.h,
              ),
              Center(
                child: Text(
                  'Resend Code 30 secs',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontWeight: FontWeight.w700, color: Color(0xff727272)),
                ),
              ),
              SizedBox(
                height: 67.h,
              ),
              AppButton(
                text: 'Continue',
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => UserInfo()));
                },
                width: 327,
                backgroundColor: ref.watch(submitButtonColorProvider),
              )
            ]),
          ),
        )),
      ),
    );
  }
}

class AppOtpField extends StatelessWidget {
  AppOtpField({
    required this.controller,
    required this.onChanged,
    super.key,
  });

  TextEditingController controller;
  Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.h,
      width: 56.h,
      child: TextFormField(
        // key: formKey,
        // autofocus: true,
        // textInputAction: TextInputAction.next,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        cursorHeight: 20.h,
        cursorWidth: 1.w,
        style: Theme.of(context).textTheme.displayMedium,
        validator: (value) {
          if (!value!.isValidEmail) {
            return;
          }
        },
        showCursor: true,
        cursorColor: buttonColor,
        onChanged: onChanged,
        keyboardType: TextInputType.number,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: textFieldColor,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(
              color: lightGreen,
              width: 1.w,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
