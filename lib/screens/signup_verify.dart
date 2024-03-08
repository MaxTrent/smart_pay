import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_pay/data/api_services.dart';
import 'package:smart_pay/models/models.dart';
import 'package:smart_pay/screens/screens.dart';
import 'package:smart_pay/widgets/app_button.dart';
import 'package:smart_pay/widgets/widgets.dart';

import '../app_theme.dart';
import '../main.dart';

final startTimeProvider = StateProvider<DateTime>((ref) => DateTime.now());
final otpFieldHeightProvider = StateProvider<double>((ref) => 48.h);
final otpProvider = StateProvider<String>((ref) => '');

final otpControllersProvider =
    Provider.family<TextEditingController, int>((ref, id) {
  return TextEditingController();
});

//to manage different states of the ui
class SignUpVerifyState {
  final bool isLoading;
  final VerifySignUpModel? data;
  final String? error;

  SignUpVerifyState({required this.isLoading, this.data, this.error});
}

class SignUpVerifyNotifier extends StateNotifier<SignUpVerifyState> {
  final ApiService apiService;
  final VoidCallback onSuccess;

  SignUpVerifyNotifier(this.apiService, this.onSuccess)
      : super(SignUpVerifyState(isLoading: false));

  Future<void> verifyUserEmail(String email, String token) async {
    try {
      state = SignUpVerifyState(isLoading: true);
      final data = await apiService.verifyEmail(email, token);
      state = SignUpVerifyState(isLoading: false, data: data);
      onSuccess();
    } catch (error) {
      state = SignUpVerifyState(isLoading: false, error: error.toString());
      if (kDebugMode) {
        print(error.toString());
      }
      Fluttertoast.showToast(msg: error.toString());
    }
  }
}

// Riverpod state provider for SignUpVerifyNotifier
final signUpVerifyNotifierProvider =
    StateNotifierProvider<SignUpVerifyNotifier, SignUpVerifyState>((ref) {
  final apiService = ref.read(apiServiceProvider);
  final navigatorKey = ref.read(navigatorKeyProvider);
  return SignUpVerifyNotifier(
    apiService,
    () {
      // Navigates to UserInfo screen when successful
      navigatorKey.currentState
          ?.push(MaterialPageRoute(builder: (context) => UserInfo()));
    },
  );
});

class VerifySignUp extends ConsumerWidget {
  VerifySignUp({super.key});

  // Riverpod state provider for submit button color
  final submitButtonColorProvider =
      StateProvider<Color>((ref) => buttonColor.withOpacity(0.7));

  final _formKey = GlobalKey<FormState>();

  // Riverpod stream provider for the countdown timer
  final _countdownStreamProvider = StreamProvider<int>(
    (ref) => Stream.periodic(
        const Duration(seconds: 1),
        (_) => max(
            0,
            30 -
                DateTime.now()
                    .difference(ref.watch(startTimeProvider))
                    .inSeconds)).handleError((error) => 0),
  );

  // Riverpod state provider for enabling the submit button
  final enableButton = StateProvider((ref) => false);

  @override
  Widget build(BuildContext context, ref) {
    final signUpVerifyState = ref.watch(signUpVerifyNotifierProvider);
    final otpControllers =
        List.generate(5, (i) => ref.watch(otpControllersProvider(i)));
    final remainingSeconds = ref.watch(_countdownStreamProvider);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(0, 60.h),
          child: Padding(
            padding: EdgeInsets.only(top: 24.h, left: 16.w),
            child: AppBar(
              primary: false,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              // key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 32.h),
                    // Title for verifying the user
                    Text(
                      'Verify it’s you',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    SizedBox(height: 8.h),
                    Text.rich(TextSpan(
                        text: 'We send a code to ( ',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                fontWeight: FontWeight.w400, color: darkGrey),
                        children: [
                          TextSpan(
                            text: '*****@mail.com',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: buttonColor),
                          ),
                          TextSpan(
                              text: ' ). Enter it here to verify your identity')
                        ])),
                    SizedBox(height: 32.h),
                    // OTP input fields
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (int i = 0; i < 5; i++)
                          AnimatedOpacity(
                            opacity: ref
                                    .watch(otpControllersProvider(i))
                                    .text
                                    .isEmpty
                                ? 0.5
                                : 1.0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                            child: AppOtpField(
                              controller: ref.watch(otpControllersProvider(i)),
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  if (i < 4) {
                                    FocusScope.of(context).nextFocus();
                                  }

                                  final text =
                                      ref.read(otpProvider.notifier).state;

                                  // Concatenates the values in the text fields as one
                                  ref.read(otpProvider.notifier).state =
                                      (i < text.length)
                                          ? text.substring(0, i) +
                                              value +
                                              text.substring(i + 1)
                                          : text + value;
                                } else {
                                  if (i > 0) {
                                    FocusScope.of(context).previousFocus();
                                  }
                                }

                                ref.read(enableButton.notifier).state =
                                    otpControllers.every((controller) =>
                                        controller.text.isNotEmpty);
                              },
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 32.h),
                    // Resend code and countdown timer
                    Center(
                      child: Text(
                        'Resend Code ${remainingSeconds.value} secs',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                fontWeight: FontWeight.w700,
                                color: Color(0xff727272)),
                      ),
                    ),
                    SizedBox(height: 67.h),
                    // Loading indicator or Continue button
                    signUpVerifyState.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: buttonColor,
                            ),
                          )
                        : AppButton(
                            text: 'Continue',
                            onPressed: () {
                              final combinedOtp = ref.read(otpProvider);
                              final token = ref.watch(otpProvider);
                              final email = ref.watch(emailController).text;
                              if (kDebugMode) {
                                print(combinedOtp);
                              }
                              ref.watch(enableButton)
                                  ? ref
                                      .read(
                                          signUpVerifyNotifierProvider.notifier)
                                      .verifyUserEmail(email, token)
                                  : null;
                            },
                            width: 327,
                            backgroundColor: ref.watch(enableButton)
                                ? buttonColor
                                : ref.watch(submitButtonColorProvider),
                          )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
