
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_pay/app_theme.dart';

class AppButton extends StatelessWidget {
  AppButton({
    required this.text,
    required this.onPressed,
    required this.width,
    this.backgroundColor = buttonColor,
    super.key,
  });

  String text;
  Function()? onPressed;
  double width;
  Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.h,
      width: width.w,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            elevation: 0,
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: Colors.white),
          )),
    );
  }
}
