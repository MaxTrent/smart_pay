import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_pay/data/app_storage.dart';
import 'package:smart_pay/screens/screens.dart';
import '../app_theme.dart';
import '../widgets/widgets.dart';

final pinProvider = StateProvider<String>((ref) => '');
final pinControllerProvider =
    Provider.family<TextEditingController, int>((ref, id) {
  return TextEditingController();
});

final isLoading = StateProvider((ref) => false);

class SetPin extends ConsumerWidget {
  SetPin({super.key});

  final _formKey = GlobalKey<FormState>();

  final enableButton = StateProvider((ref) => false);

  @override
  Widget build(BuildContext context, ref) {
    // Generate a list of TextEditingController instances for PIN text fields
    final pinControllers =
    List.generate(5, (i) => ref.watch(pinControllerProvider(i)));

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              // key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.h,),
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
                  SizedBox(height: 32.h),
                  // Title for setting PIN
                  Text(
                    'Set your PIN code',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'We use state-of-the-art security measures to protect your information at all times',
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontWeight: FontWeight.w400, color: darkGrey),
                  ),
                  SizedBox(height: 32.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (int i = 0; i < 5; i++)
                        PinTextField(
                          controller: ref.watch(pinControllerProvider(i)),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              if (i < 4) {
                                FocusScope.of(context).nextFocus();
                              }
                              // Focus is on the last field
                              final text = ref.read(pinProvider.notifier).state;

                              // Concatenates the values in the text fields as one
                              ref.read(pinProvider.notifier).state =
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
                            // Enable the button if all PIN text fields are filled
                            ref.read(enableButton.notifier).state =
                                pinControllers.every(
                                        (controller) => controller.text.isNotEmpty);
                          },
                        ),
                    ],
                  ),
                  SizedBox(height: 123.h),
                  // Conditional rendering of loading indicator or Create PIN button
                  ref.watch(isLoading)
                      ? const Center(
                    child: CircularProgressIndicator(
                      color: buttonColor,
                    ),
                  )
                      : AppButton(
                    text: 'Create PIN',
                    onPressed: () async {
                      final name = await storage.read(key: 'fullName');
                      ref.read(isLoading.notifier).state = true;
                      final pin = ref.read(pinProvider);
                      await storePin(pin);

                      // Navigate to OnboardingSuccess screen on successful PIN creation
                      if (context.mounted) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OnboardingSuccess(fullName: name,)));
                      }
                      ref.read(isLoading.notifier).state = false;
                    },
                    width: 327,
                    // Button's background color depends on the enableButton state
                    backgroundColor: ref.watch(enableButton)
                        ? buttonColor
                        : buttonColor.withOpacity(0.7),
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

