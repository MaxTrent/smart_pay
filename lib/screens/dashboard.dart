import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_pay/app_theme.dart';
import 'package:smart_pay/data/api_services.dart';
import 'package:smart_pay/data/app_storage.dart';
import 'package:smart_pay/screens/screens.dart';
import 'package:smart_pay/widgets/app_button.dart';

import '../main.dart';

// State class to manage the state of sign-out process
class SignOutState {
  final bool isLoading;
  final void data;
  final String? error;

  SignOutState({required this.isLoading, this.data, this.error});
}

// Notifier class to handle sign-out logic
class SignOutNotifier extends StateNotifier<SignOutState> {
  final ApiService apiService;
  final VoidCallback onSuccess;

  SignOutNotifier(this.apiService, this.onSuccess) : super(SignOutState(isLoading: false));

  // Function to perform sign-out
  Future<void> signOut() async {
    try {
      state = SignOutState(isLoading: true);
      await apiService.logOut();
      state = SignOutState(isLoading: false);
      onSuccess();
    } catch (error) {
      state = SignOutState(isLoading: false, error: error.toString());
    }
  }
}

// Provider for the sign-out notifier
final signOutNotifierProvider = StateNotifierProvider<SignOutNotifier, SignOutState>((ref) {
  final apiService = ref.read(apiServiceProvider);
  final navigatorKey = ref.read(navigatorKeyProvider);
  return SignOutNotifier(apiService, () {
    navigatorKey.currentState?.pushAndRemoveUntil(MaterialPageRoute(
      builder: (context) => SignIn(),
    ), (route) => false);
  });
});

class Dashboard extends ConsumerWidget {
  Dashboard({super.key});

  // Provider to fetch secret information
  final getSecretProvider = FutureProvider((ref) async {
    final apiService = ref.watch(apiServiceProvider);
    return apiService.getSecret();
  });

  @override
  Widget build(BuildContext context, ref) {
    final signOutState = ref.watch(signOutNotifierProvider);
    final getSecret = ref.watch(getSecretProvider);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(0,60.h),
        child: Padding(
          padding: EdgeInsets.only(top: 24.h, left: 16.w),            child: AppBar(
          primary: false,
        ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display secret information with an animated switcher
              getSecret.when(data: (data) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) => FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                  child: Text(
                    textAlign: TextAlign.center,
                    data.data.secret,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                );
              }, error: (error, _) {
                print(error);
                print(_.toString());
                return Text('An Error Occurred: ${error.toString()}', style: Theme.of(context).textTheme.displayMedium,);
              }, loading: () {
                return CircularProgressIndicator();
              }),
              SizedBox(height: 24.h,),
              // Sign-out button with loading indicator
              signOutState.isLoading
                  ? const Center(child: CircularProgressIndicator(color: buttonColor,))
                  : AppButton(
                text: 'Sign Out',
                onPressed: () async {
                  await SharedPreferencesHelper.setLoggedOut();
                  ref.read(signOutNotifierProvider.notifier).signOut();
                },
                width: 327.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
