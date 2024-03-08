import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_pay/app_theme.dart';
import 'package:smart_pay/models/login_model.dart';
import 'package:smart_pay/screens/screens.dart';
import 'package:smart_pay/widgets/widgets.dart';

import '../data/api_services.dart';
import '../data/app_storage.dart';
import '../main.dart';

final _emailController = Provider.autoDispose<TextEditingController>(
    (ref) => TextEditingController());
final _passwordController = Provider.autoDispose<TextEditingController>(
    (ref) => TextEditingController());

class SignInState {
  final bool isLoading;
  final LoginModel? data;
  final String? error;

  SignInState({required this.isLoading, this.data, this.error});
}

class SignInNotifier extends StateNotifier<SignInState> {
  final ApiService apiService;
  final VoidCallback onSuccess;

  SignInNotifier(this.apiService, this.onSuccess)
      : super(SignInState(isLoading: false));

  Future<void> signIn(String email, String password) async {
    try {
      state = SignInState(isLoading: true);
      final data = await apiService.login(email, password);
      state = SignInState(isLoading: false, data: data);
      onSuccess();
    } catch (error) {
      state = SignInState(isLoading: false, error: error.toString());
    }
  }
}

final signInNotifierProvider =
    StateNotifierProvider<SignInNotifier, SignInState>((ref) {
  final apiService = ref.read(apiServiceProvider);
  final navigatorKey = ref.read(navigatorKeyProvider);
  return SignInNotifier(apiService, () async {
    navigatorKey.currentState
        ?.push(MaterialPageRoute(builder: (context) => Dashboard()));
    await SharedPreferencesHelper.setLoggedIn();
  });
});

class SignIn extends ConsumerWidget {
  SignIn({super.key});

  final obscureTextProvider = StateProvider<bool>((ref) => true);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, ref) {
    final signInState = ref.watch(signInNotifierProvider);

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
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Form(
                // key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 32.h),
                    Text(
                      'Hi There! 👋',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Welcome back, Sign in to your account',
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                fontWeight: FontWeight.w400,
                                color: darkGrey,
                              ),
                    ),
                    SizedBox(height: 32.h),
                    AppTextField(
                      controller: ref.watch(_emailController),
                      hintText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 16.h),
                    AppTextField(
                      controller: ref.watch(_passwordController),
                      hintText: 'Password',
                      keyboardType: TextInputType.emailAddress,
                      obscureText: ref.watch(obscureTextProvider),
                      suffixIcon: GestureDetector(
                        onTap: () =>
                            ref.read(obscureTextProvider.notifier).state =
                                !ref.read(obscureTextProvider.notifier).state,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0.w, vertical: 16.h),
                          child: SvgPicture.asset(
                            'assets/visibility.svg',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    // Forgot password button
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => RecoverPassword()),
                        );
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.zero,
                        ),
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: Text(
                        'Forgot Password?',
                        style:
                            Theme.of(context).textTheme.displayMedium!.copyWith(
                                  color: darkGreen,
                                ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    // Sign In button or loading indicator
                    Center(
                      child: signInState.isLoading
                          ? const CircularProgressIndicator(
                              color: buttonColor,
                            )
                          : AppButton(
                              text: 'Sign In',
                              onPressed: () async {
                                final email = ref.watch(_emailController).text;
                                final password =
                                    ref.watch(_passwordController).text;
                                ref
                                    .read(signInNotifierProvider.notifier)
                                    .signIn(email, password);
                              },
                              width: 327,
                            ),
                    ),
                    SizedBox(height: 32.h),
                    // Auth alternatives (e.g., social media sign-in)
                    const AuthAlternative(),
                    SizedBox(height: 138.h),
                    // Text to navigate to the Sign-Up screen
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => SignUp()),
                          );
                        },
                        child: Text.rich(
                          TextSpan(
                            text: 'Don’t have an account? ',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: darkGrey,
                                ),
                            children: [
                              TextSpan(
                                text: 'Sign Up',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                      color: darkGreen,
                                    ),
                              ),
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
      ),
    );
  }
}
