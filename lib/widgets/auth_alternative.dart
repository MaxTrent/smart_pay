import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app_theme.dart';

class AuthAlternative extends StatelessWidget {
  const AuthAlternative({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 142.w,
              height: 1.h,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    lightGrey.withOpacity(0.0),
                    lightGrey,
                  ])),
            ),
            SizedBox(
              width: 12.w,
            ),
            Text(
              'OR',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            SizedBox(
              width: 12.w,
            ),
            Container(
              width: 142.w,
              height: 1.h,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    lightGrey,
                    lightGrey.withOpacity(0.0),
                  ])),
            ),
          ],
        ),
        SizedBox(
          height: 24.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 56.h,
              width: 155.w,
              child: OutlinedButton(
                onPressed: () {},
                child: SvgPicture.asset('assets/google.svg'),
                style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    )),
              ),
            ),
            SizedBox(
              height: 56.h,
              width: 155.w,
              child: OutlinedButton(
                onPressed: () {},
                child: SvgPicture.asset('assets/apple.svg'),
                style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    )),
              ),
            ),
          ],
        ),

      ],
    );
  }
}