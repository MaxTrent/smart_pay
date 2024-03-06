import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_pay/screens/screens.dart';
import 'package:smart_pay/validators.dart';

import '../app_theme.dart';
import '../widgets/widgets.dart';

class SetPin extends ConsumerWidget {
  SetPin({super.key});

  final _formKey = GlobalKey<FormState>();
  final pinControllerProvider =
      Provider.family<TextEditingController, int>((ref, id) {
    return TextEditingController();
  });

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
              // ref.read(submitButtonColorProvider.notifier).state =
              // _formKey.currentState!.validate()
              //     ? buttonColor
              //     : buttonColor.withOpacity(0.7);
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
                'Set your PIN code',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              SizedBox(height: 8.h),
              Text(
                'We use state-of-the-art security measures to protect your information at all times',
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(fontWeight: FontWeight.w400, color: darkGrey),
              ),
              SizedBox(
                height: 32.h,
              ),
              // Row(
              //   children: [PinTextField()],
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int i = 0; i < 5; i++)
                    PinTextField(
                        onChanged: (value) {
                          if (value.isNotEmpty) {
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
                        controller: ref.watch(pinControllerProvider(i))),
                ],
              ),
              SizedBox(
                height: 123.h,
              ),
              AppButton(
                text: 'Create PIN',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => OnboardingSuccess()));
                },
                width: 327,
                // backgroundColor: ref.watch(submitButtonColorProvider),
              )
            ]),
          ),
        )),
      ),
    );
  }
}

class PinTextField extends StatelessWidget {
  PinTextField({
    this.onChanged,
    required this.controller,
    super.key,
  });

  TextEditingController controller;
  Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.h,
      width: 48.h,
      child: TextFormField(
        // key: formKey,
        // autofocus: true,
        // textInputAction: TextInputAction.next,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        cursorHeight: 24.h,
        cursorWidth: 1.w,
        style: Theme.of(context).textTheme.displayMedium,
        validator: (value) {
          if (!value!.isValidEmail) {
            return;
          }
        },
        showCursor: true,
        obscureText: true,
        cursorColor: darkGreen,

        onChanged: onChanged,
        keyboardType: TextInputType.number,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: TextEditingController(),
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: lightGreen,
              width: 1.5.w,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: lightGreen,
              width: 1.5.w,
            ),
          ),
        ),
      ),
    );
  }
}
