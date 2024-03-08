import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_pay/app_theme.dart';
import 'package:smart_pay/screens/screens.dart';
import 'package:smart_pay/widgets/app_button.dart';
import 'package:smart_pay/widgets/app_textfield.dart';

class RecoverPassword extends ConsumerWidget {
  RecoverPassword({super.key});

  final _emailController = Provider((ref) => TextEditingController());

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 35.71.h),
                        child: SvgPicture.asset(
                          'assets/passwordrecovery.svg',
                          width: 90.24.w,
                          height: 76.29.h,
                        ),
                      ),
                      SizedBox(height: 24.h,),
                      Text(
                        'Passsword Recovery',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      SizedBox(height: 12.h,),
                      Text(
                        'Enter your registered email below to receive password instructions',
                        style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: darkGrey,
                        ),
                      ),
                      SizedBox(height: 32.h,),
                      AppTextField(
                        controller: ref.watch(_emailController),
                        hintText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: AppButton(
                      text: 'Send me email',
                      onPressed: () {
                        // Navigate to VerifyIdentity screen on button press
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => VerifyIdentity()),
                        );
                      },
                      width: 327,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

