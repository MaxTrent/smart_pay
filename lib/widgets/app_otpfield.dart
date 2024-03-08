import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_theme.dart';

class AppOtpField extends StatelessWidget {
  AppOtpField({
    required this.controller,
    required this.onChanged,
    super.key,
  });

  TextEditingController controller;
  Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.h,
      width: 56.h,
      child: TextFormField(
        // key: formKey,
        // autofocus: true,
        // textInputAction: TextInputAction.next,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1)
        ],
        textInputAction: TextInputAction.next,
        onEditingComplete: () => FocusScope.of(context).nextFocus(),
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        cursorHeight: 20.h,
        cursorWidth: 1.w,
        style: Theme.of(context).textTheme.displayMedium,
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