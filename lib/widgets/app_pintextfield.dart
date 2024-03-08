
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_theme.dart';

class PinTextField extends StatelessWidget {
  PinTextField({
    required this.onChanged,
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
        textInputAction: TextInputAction.next,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1)
        ],
        textAlign: TextAlign.center,
        onEditingComplete: () => FocusScope.of(context).nextFocus(),
        textAlignVertical: TextAlignVertical.center,
        cursorHeight: 24.h,
        cursorWidth: 1.w,
        style: Theme.of(context).textTheme.displayMedium,
        showCursor: true,
        obscureText: true,
        cursorColor: darkGreen,

        onChanged: onChanged,
        keyboardType: TextInputType.number,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
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