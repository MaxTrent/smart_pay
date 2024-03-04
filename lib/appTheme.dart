import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

const primaryAppColor = Color(0xff2FA2B9);
const accentColor = Color(0xff6B7280);

class AppTheme {
  ThemeData get light => ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primaryColor: primaryAppColor,
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'SFPro',
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 24.sp,
        ),
        displayMedium: TextStyle(
          fontFamily: 'SFPro',
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
        ),
        displaySmall: TextStyle(
          fontFamily: 'SFPro',
          color: accentColor,
          fontSize: 14.sp,
        ),
      ));
}
