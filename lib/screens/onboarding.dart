import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_pay/app_theme.dart';
import 'package:smart_pay/screens/screens.dart';
import 'package:smart_pay/screens/sign_in.dart';

import '../widgets/widgets.dart';

final currentIndex = StateProvider<int>((ref) => 0);
final positionIndex = StateProvider<int>((ref) => 0);

class Onboarding extends ConsumerWidget {
  Onboarding({super.key});

  final _controller = PageController();
  final List<OnboardingPage> _pages = [
    OnboardingPage(
      text: 'Finance app the safest\nand most trusted',
      imageUrl: 'assets/onboarding1.png',
      subtext:
          'Your finance work starts here. Our here to help\nyou track and deal with speeding up your\ntransactions.',
    ),
    OnboardingPage(
      text: 'The fastest transaction\nprocess only here',
      imageUrl: 'assets/onboarding2.png',
      subtext:
          'Get easy to pay all your bills with just a few\nsteps. Paying your bills become fast and\nefficient.',
    ),
  ];

  @override
  Widget build(BuildContext context, ref) {
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
                    child: GestureDetector(

                      onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SignIn())),
                      child: Text(
                        'Skip',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(color: lightGreen),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 83.h,
                ),
              ],
            ),
            PageView(
              onPageChanged: (index) {
                ref.read(currentIndex.notifier).state = index;
              },
              allowImplicitScrolling: true,
              physics: AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              controller: _controller,
              children:
                  _pages.map((page) => AppOnboarding(pageInfo: page)).toList(),
            ),
            Positioned(
              bottom: 24.h,
              child: Column(
                children: [
                  Row(
                    children: List.generate(
                      _pages.length,
                      (index) => OnboardingIndicator(
                        positionIndex: index,
                        currentIndex: currentIndex,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 34.h,
                  ),
                  AppButton(text: 'Get Started', onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SignUp())); }, width: 287,),
                ],
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
    required this.pageInfo,
    super.key,
  });

  final OnboardingPage pageInfo;

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
                  pageInfo.imageUrl,
                  height: 407.26.h,
                  width: 202.68.w,
                ),
              ),
              Positioned(
                  top: 300.h,
                  child: Column(
                    children: [
                      Text(
                        pageInfo.text,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Text(
                        pageInfo.subtext,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
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



class OnboardingPage {
  final String text;
  final String imageUrl;
  final String subtext;

  OnboardingPage({
    required this.text,
    required this.imageUrl,
    required this.subtext,
  });
}
