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

import '../data/app_storage.dart';
import '../widgets/widgets.dart';

final currentIndex = StateProvider<int>((ref) => 0);
final positionIndex = StateProvider<int>((ref) => 0);

class Onboarding extends ConsumerWidget {
  Onboarding({super.key});

  final _controller = PageController();
  final List<OnboardingPage> _pages = [
    // Define the onboarding pages with text, image, and subtext.
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
            // PageView to display onboarding pages.
            PageView(
              onPageChanged: (index) {
                // Update the current index when the page changes.
                ref.read(currentIndex.notifier).state = index;
              },
              allowImplicitScrolling: true,
              physics: AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              controller: _controller,
              children: _pages.map((page) => AppOnboarding(pageInfo: page)).toList(),
            ),
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
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUp())),
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
            Positioned(
              bottom: 24.h,
              child: Column(
                children: [
                  // Display indicators for each onboarding page.
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
                  // Button to proceed after completing onboarding.
                  AppButton(
                    text: 'Get Started',
                    onPressed: () async {
                      await SharedPreferencesHelper.setOnboardingCompleted();
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    width: 287,
                  ),
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
            clipBehavior: Clip.none, // Allow content to be drawn outside its box.
            alignment: Alignment.center, // Align content in the center.
            children: [
              Container(
                foregroundDecoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(0),
                      Colors.white,
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
                top: 300.h, // Position the text content below the top.
                child: Column(
                  children: [
                    Text(
                      pageInfo.text,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayLarge,   ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      pageInfo.subtext,
                      textAlign: TextAlign.center, // Center-align the subtext.
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



// Data structure for the onboarding page, holding text, image URL, and subtext.
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
