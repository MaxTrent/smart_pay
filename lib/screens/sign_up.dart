import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_pay/data/api_services.dart';
import 'package:smart_pay/models/models.dart';
import 'package:smart_pay/screens/screens.dart';

import '../app_theme.dart';
import '../main.dart';
import '../widgets/widgets.dart';

final emailController =
    Provider.autoDispose<TextEditingController>((ref) => TextEditingController());

class SignUpState {
  final bool isLoading;
  final SignUpModel? data;
  final String? error;

  SignUpState({required this.isLoading, this.data, this.error});
}

class SignUpNotifier extends StateNotifier<SignUpState> {
  final ApiService apiService;
  final VoidCallback onSuccess;

  SignUpNotifier(this.apiService, this.onSuccess)
      : super(SignUpState(isLoading: false));

  Future<void> signUp(String email) async {
    try {
      state = SignUpState(isLoading: true);
      final data = await apiService.getEmailToken(email);
      state = SignUpState(isLoading: false, data: data);
      onSuccess();
    } catch (error) {
      state = SignUpState(isLoading: false, error: error.toString());
    }
  }
}

// Riverpod state provider for SignUpNotifier
final signUpNotifierProvider =
StateNotifierProvider<SignUpNotifier, SignUpState>((ref) {
  final apiService = ref.read(apiServiceProvider);
  final navigatorKey = ref.read(navigatorKeyProvider);
  return SignUpNotifier(
    apiService,
        () {
      // Navigates to VerifySignUp screen when successful
      navigatorKey.currentState
          ?.push(MaterialPageRoute(builder: (context) => VerifySignUp()));
    },
  );
});

class SignUp extends ConsumerWidget {
  SignUp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    // Get the current state of SignUpNotifier
    final signUpState = ref.watch(signUpNotifierProvider);

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
                      style: Theme.of(context).textTheme.displayLarge,
                      children: [
                        TextSpan(
                          text: 'Smartpay',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(color: darkGreen),
                        ),
                        TextSpan(
                          text: '\naccount',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ])),
                  SizedBox(height: 32.h),
                  AppTextField(
                    controller: ref.watch(emailController),
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Center(
                    child: signUpState.isLoading
                        ? AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: signUpState.isLoading ? 1.0 : 0.0,
                      child: const CircularProgressIndicator(
                        color: buttonColor,
                      ),
                    )
                        : AppButton(
                      text: 'Sign Up',
                      onPressed: () async {
                        final email = ref.watch(emailController).text;
                        ref
                            .read(signUpNotifierProvider.notifier)
                            .signUp(email);
                      },
                      width: 327,
                    ),
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  // Auth alternatives (e.g., social media sign-up)
                  AuthAlternative(),
                  SizedBox(
                    height: 117.h,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            settings: const RouteSettings(name: "SignIn"),
                            builder: (context) => SignIn()));
                      },
                      child: Text.rich(
                        TextSpan(
                          text: 'Already have an account? ',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                              fontWeight: FontWeight.w400, color: darkGrey),
                          children: [
                            TextSpan(
                              text: 'Sign In',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(color: darkGreen),
                            )
                          ],
                        ),
                      ),
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
