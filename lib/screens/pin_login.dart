import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_pay/data/app_storage.dart';
import 'package:smart_pay/screens/screens.dart';

import '../app_theme.dart';
import '../widgets/widgets.dart';

// Providers for PIN-related state management.
final _pinProvider = StateProvider<String>((ref) => '');

final _pinControllerProvider =
    Provider.family<TextEditingController, int>((ref, id) {
  return TextEditingController();
});

final _isLoading = StateProvider((ref) => false);

class PinLogin extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  final enableButton = StateProvider((ref) => false);

  @override
  Widget build(BuildContext context, ref) {
    final _pinControllers =
        List.generate(5, (i) => ref.watch(_pinControllerProvider(i)));

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Section for PIN entry.
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 8.h,
                        ),
                        SizedBox(height: 32.h),
                        Text(
                          'Sign in with your PIN code',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        SizedBox(
                          height: 32.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            for (int i = 0; i < 5; i++)
                              AppOtpField(
                                controller:
                                    ref.watch(_pinControllerProvider(i)),
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    if (i < 4) {
                                      FocusScope.of(context).nextFocus();
                                    }

                                    final text =
                                        ref.read(_pinProvider.notifier).state;

                                    // Concatenate the values in the textfields as one.
                                    ref.read(_pinProvider.notifier).state =
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

                                  // Enable the sign-in button when all PIN fields are filled.
                                  ref.read(enableButton.notifier).state =
                                      _pinControllers.every((controller) =>
                                          controller.text.isNotEmpty);
                                },
                              ),
                          ],
                        ),
                      ]),
                  // Section for the loading indicator and sign-in button.
                  ref.watch(_isLoading)
                      ? Center(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 16.h),
                            child: const CircularProgressIndicator(
                              color: buttonColor,
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: AppButton(
                            text: 'Sign In',
                            onPressed: () async {
                              final inputtedPin = ref.watch(_pinProvider);
                              final storedPin = await getStoredPin();
                              if (kDebugMode) {
                                print(inputtedPin);
                              }
                              if (kDebugMode) {
                                print(storedPin);
                              }
                              ref.read(_isLoading.notifier).state = true;
                              inputtedPin == storedPin
                                  ? Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => Dashboard()))
                                  : null;
                              // Delay to simulate asynchronous operations
                              Future.delayed(const Duration(seconds: 2), () {
                                ref.read(_isLoading.notifier).state = false;
                              });
                            },
                            width: 327,
                            backgroundColor: ref.watch(enableButton)
                                ? buttonColor
                                : buttonColor.withOpacity(0.7),
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
