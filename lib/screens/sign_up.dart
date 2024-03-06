import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_pay/data/api_services.dart';
import 'package:smart_pay/models/models.dart';
import 'package:smart_pay/screens/screens.dart';

import '../app_theme.dart';
import '../widgets/widgets.dart';


final _emailController =
Provider<TextEditingController>((ref) => TextEditingController());

class SignUp extends ConsumerWidget {
  SignUp({super.key});



  @override
  Widget build(BuildContext context, ref) {
    final email = ref
        .watch(_emailController)
        .text;
    final getEmailTokenProvider =
    FutureProvider.family<SignUpModel, String>((ref, email) async {
      print('getEmailTokenProvider executed');
      try {
        final api = ref.read(apiServiceProvider);
        return api.getEmailToken(email);
      } catch (e) {
        print(e.toString());
        throw e;
      }
    });

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              // key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 8.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40.h,
                      width: 40.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: lightGrey,
                          width: 1.w,
                        ),
                      ),
                      child: Icon(
                        CupertinoIcons.back,
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Text.rich(TextSpan(
                      text: 'Create a ',
                      style: Theme
                          .of(context)
                          .textTheme
                          .displayLarge,
                      children: [
                        TextSpan(
                          text: 'Smartpay',
                          style: Theme
                              .of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(color: darkGreen),
                        ),
                        TextSpan(
                          text: '\naccount',
                          style: Theme
                              .of(context)
                              .textTheme
                              .displayLarge,
                        ),
                      ])),
                  SizedBox(height: 32.h),
                  AppTextField(
                    controller: ref.watch(_emailController),
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Center(
                      child: AppButton(
                        text: 'Sign Up',
                        onPressed: () async {
                          final result = await ref.watch(getEmailTokenProvider(email).future);
                          print('before await result.when');
                          result.when(
                            data: (signUpModel) {
                              print(signUpModel);
                              print('success');
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VerifySignUp()));
                            },
                            error: (error, _) {
                              print('error oooo');
                            },
                            loading: () {
                              print('loading');
                              return Center(child: SizedBox(height: 20,
                                  width: 25,
                                  child: CircularProgressIndicator()));
                            },
                          );
                          print('After await result.when');

                          // Navigator.of(context).push(
                          //     MaterialPageRoute(builder: (context) => VerifySignUp()));
                        },
                        width: 327,
                      )),
                  SizedBox(
                    height: 32.h,
                  ),
                  AuthAlternative(),
                  SizedBox(
                    height: 117.h,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => SignIn()));
                      },
                      child: Text.rich(TextSpan(
                          text: 'Already have an account? ',
                          style: Theme
                              .of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                              fontWeight: FontWeight.w400, color: darkGrey),
                          children: [
                            TextSpan(
                                text: 'Sign In',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(color: darkGreen))
                          ])),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
