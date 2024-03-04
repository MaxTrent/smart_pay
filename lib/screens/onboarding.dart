import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_pay/appTheme.dart';

class Onboarding extends StatelessWidget {
  Onboarding({super.key});

  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 24.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      'Skip',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: primaryAppColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: 83.h,
                ),
              ],
            ),
            PageView(
              allowImplicitScrolling: true,
              physics: AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              controller: _controller,
              children: [
                AppOnboarding(text: 'Finance app the safest\nand most trusted', imageUrl: 'assets/onboarding1.png', subtext: 'Your finance work starts here. Our here to help\nyou track and deal with speeding up your\ntransactions.' ,),
                AppOnboarding(text: 'Finance app the safest\nand most trusted', imageUrl: 'assets/onboarding1.png', subtext: 'Your finance work starts here. Our here to help\nyou track and deal with speeding up your\ntransactions.' ,)
              ],
            ),
            Positioned(
              bottom: 24.h,
              child: SizedBox(
                height: 56.h,
                width: 287.w,
                child: ElevatedButton(onPressed: (){},style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ), child: Text(
                  'Get Started',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AppOnboarding extends StatelessWidget {
  AppOnboarding({
    required this.text,
    required this.imageUrl,
    required this.subtext,
    super.key,
  });

  String text;
  String subtext;
  String imageUrl;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 131.h,
          ),
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                foregroundDecoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(0),
                      Colors.white,
                      // Colors.white,
                    ],
                    stops: [0.58, 0.61],
                  ),
                ),
                child: Image.asset(
                  imageUrl,
                  height: 407.26.h,
                  width: 202.68.w,
                ),
              ),
              Positioned(
                  top: 300.h,
                  child: Column(
                    children: [
                      Text(
                        text,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Text(
                          subtext,
                        textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displaySmall,),
                      SizedBox(height: 16.h,),
                      OnboardingIndicator(positionIndex: 0, currentIndex: 0,),
                    ],
                  )),
            ],
          ),
          // SizedBox(height: 46.h,),
          // Text('Finance app the safest\nand most trusted',textAlign: TextAlign.center, style: Theme.of(context).textTheme.displayLarge,)
        ],
      ),
    );
  }
}

class OnboardingIndicator extends StatelessWidget {
  OnboardingIndicator({
    super.key, required this.positionIndex, required this.currentIndex,
  });

  final int positionIndex, currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: positionIndex == currentIndex ? 32.w : 6.h,
          height: 6.h,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(500.r)
          ),
        ),
        SizedBox(width: 4.w,),
        Container(
          height: 6.h,
          width: 6.h,
          decoration: BoxDecoration(
            color: Color(0xffE5E7EB),
            borderRadius: BorderRadius.circular(100.r)
          ),
        )
      ],
    );
  }
}
