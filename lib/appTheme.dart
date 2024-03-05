import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

const lightGreen = Color(0xff2FA2B9);
const darkGreen = Color(0xff0A6375);
const darkGrey = Color(0xff6B7280);
const lightGrey = Color(0xffE5E7EB);
const buttonColor = Color(0xff111827);
const textFieldColor = Color(0xffF9FAFB);


class AppTheme {
  ThemeData get light => ThemeData(
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
