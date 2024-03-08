import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const lightGreen = Color(0xff2FA2B9);
const darkGreen = Color(0xff0A6375);
const darkGrey = Color(0xff6B7280);
const lightGrey = Color(0xffE5E7EB);
const buttonColor = Color(0xff111827);
const textFieldColor = Color(0xffF9FAFB);


class AppTheme {
  ThemeData get light => ThemeData(
    actionIconTheme: ActionIconThemeData(
      backButtonIconBuilder: (BuildContext context)=> Container(
        height: 40.h,
        width: 40.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: lightGrey,
            width: 1.w,
          ),
        ),
        child: const Icon(
          CupertinoIcons.back,
        ),
      ),
    ),
      scaffoldBackgroundColor: Colors.white,
      primaryColor: lightGreen,
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'SFPro',
          color: buttonColor,
          fontWeight: FontWeight.w600,
          fontSize: 24.sp,
        ),
        displayMedium: TextStyle(
          fontFamily: 'SFPro',
          color: buttonColor,
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
        ),
        displaySmall: TextStyle(
          fontFamily: 'SFPro',
          color: darkGrey,
          fontSize: 14.sp,
        ),
      ));
}
