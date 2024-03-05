import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_pay/validators.dart';

import '../app_theme.dart';

class AppTextField extends ConsumerWidget {
  AppTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.keyboardType,
    this.suffixIcon,
    this.obscureText,
  });

  final TextEditingController controller;
  String hintText;
  TextInputType keyboardType;
  Widget? suffixIcon;
  bool? obscureText;

  // GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context, ref) {
    return SizedBox(
      height: 56.h,
      child: TextFormField(
        // key: formKey,
        obscureText: obscureText ?? false,
        textAlignVertical: TextAlignVertical.bottom,
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
        onChanged: (value) {
          if (value.isNotEmpty) {
          } else {}
        },
        keyboardType: keyboardType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(fontWeight: FontWeight.w400, color: Color(0xff9CA3AF)),
          filled: true,
          fillColor: textFieldColor,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(
              color: lightGreen,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}