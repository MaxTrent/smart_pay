
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_pay/appTheme.dart';

class AppButton extends StatelessWidget {
  AppButton({
    required this.text,
    required this.onPressed,
    required this.width,
    super.key,
  });

  String text;
  Function()? onPressed;
  double width;

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
            backgroundColor: buttonColor,
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
