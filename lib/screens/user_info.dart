import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_pay/data/api_services.dart';
import 'package:smart_pay/models/models.dart';
import 'package:smart_pay/screens/screens.dart';
import 'package:smart_pay/widgets/widgets.dart';
import 'dart:ui';
import '../app_theme.dart';
import '../main.dart';

//State Providers to handle the selected country, country shortname, flagUrl and the password obscuring
final selectedCountryProvider = StateProvider<String>((ref) => '');
final selectedCountryShortNameProvider = StateProvider<String>((ref) => '');
final selectedCountryNameProvider = StateProvider<String>((ref) => '');
final selectedCountryFlagProvider = StateProvider<String>((ref) => '');
final obscureTextProvider = StateProvider<bool>((ref) => true);


//returns true if all the textfields have values
final enableButtonProvider = Provider<bool>((ref) {
  final fullName = ref.watch(fullNameControllerProvider).text;
  final userName = ref.watch(userNameControllerProvider).text;
  // final selectedCountry = ref.watch(selectedCountryShortNameProvider);
  final password = ref.watch(passwordControllerProvider).text;

  // Check if all text fields are not empty
  return fullName.isNotEmpty &&
      userName.isNotEmpty &&
      password.isNotEmpty;
});

final searchCountryControllerProvider =
    Provider((ref) => TextEditingController());
final fullNameControllerProvider = Provider((ref) => TextEditingController());
final userNameControllerProvider = Provider((ref) => TextEditingController());
final countryControllerProvider = Provider((ref) =>
    TextEditingController(text: ref.watch(selectedCountryNameProvider)));
final passwordControllerProvider = Provider((ref) => TextEditingController());

final registerUserProvider = FutureProvider((ref) async {
  final api = ref.read(apiServiceProvider);
  return api.registerUser(
      ref.watch(fullNameControllerProvider).text,
      ref.watch(userNameControllerProvider).text,
      ref.watch(emailController).text,
      ref.watch(passwordControllerProvider).text);
});

//to manage different states of the ui
class RegisterUserState{
  final bool isLoading;
  final RegisterUserModel? data;
  final String? error;

  RegisterUserState({required this.isLoading, this.data, this.error});
}

//notifier to handle the logic for the states
class RegisterUserNotifier extends StateNotifier<RegisterUserState> {
  final ApiService apiService;
  final VoidCallback onSuccess;

  RegisterUserNotifier(this.apiService, this.onSuccess) : super(RegisterUserState(isLoading: false));

  Future<void> signUpUser(String fullName, String userName, String email, String password) async {
    try {
      state = RegisterUserState(isLoading: true);
      final data = await apiService.registerUser(fullName, userName, email, password);
      state = RegisterUserState(isLoading: false, data: data);
      onSuccess();
    } catch (error) {
      state = RegisterUserState(isLoading: false, error: error.toString());
      if (kDebugMode) {
        print(error.toString());
      }
      Fluttertoast.showToast(msg: error.toString());
    }
  }
}

final registerUserNotifierProvider = StateNotifierProvider<RegisterUserNotifier, RegisterUserState>((ref) {
  final apiService = ref.read(apiServiceProvider);
  final navigatorKey = ref.read(navigatorKeyProvider);
  return RegisterUserNotifier(apiService,  () {
    //Navigates to set pin when successful
    navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => SetPin()));
  },);
});






class UserInfo extends ConsumerWidget {
  UserInfo({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final registerUser = ref.watch(registerUserProvider);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
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
                  SizedBox(height: 32.h),
                  Text.rich(
                    TextSpan(
                        text: 'Hey there! tell us a bit\nabout ',
                        style: Theme.of(context).textTheme.displayLarge,
                        children: [
                          TextSpan(
                            text: 'yourself',
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(color: darkGreen),
                          )
                        ]),
                  ),
                  SizedBox(height: 32.h),
                  AppTextField(
                      controller: ref.watch(fullNameControllerProvider),
                      hintText: 'Full name',
                      keyboardType: TextInputType.name),
                  SizedBox(height: 16.h),
                  AppTextField(
                      controller: ref.watch(userNameControllerProvider),
                      hintText: 'Username',
                      keyboardType: TextInputType.name),
                  SizedBox(height: 16.h),
                  AppTextField(
                    showCursor: false,
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          builder: (BuildContext context) => BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                                child: Container(
                                  height: 617.h,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40.r),
                                        topRight: Radius.circular(40.r),
                                        bottomRight: Radius.circular(0.r),
                                        bottomLeft: Radius.circular(0.r),
                                      )),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 24.w),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 32.h),
                                        AppTextField(
                                            suffixIcon: TextButton(
                                                onPressed: () {
                                                  ref
                                                      .read(
                                                          searchCountryControllerProvider)
                                                      .clear();
                                                },
                                                style: ButtonStyle(
                                                  padding: MaterialStateProperty
                                                      .all<EdgeInsets>(
                                                          EdgeInsets.zero),
                                                  overlayColor:
                                                      MaterialStateProperty.all(
                                                          Colors.transparent),
                                                ),
                                                child: Text(
                                                  'Cancel',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium,
                                                )),
                                            prefixIcon: const Icon(
                                              CupertinoIcons.search,
                                            ),
                                            controller: ref.watch(
                                                searchCountryControllerProvider),
                                            hintText: 'Search',
                                            keyboardType: TextInputType.text),
                                        SizedBox(
                                          height: 24.h,
                                        ),
                                        CountryListTile(
                                          countryFlagUrl:
                                              'assets/UnitedStatesMinorOutlyingIslands.svg',
                                          countryName: 'United States',
                                          countryNameShort: 'US',
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        CountryListTile(
                                            countryFlagUrl:
                                                'assets/UnitedKingdom.svg',
                                            countryName: 'United Kingdom',
                                            countryNameShort: 'UK'),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        CountryListTile(
                                            countryFlagUrl:
                                                'assets/Singapore.svg',
                                            countryName: 'Singapore',
                                            countryNameShort: 'SG'),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        CountryListTile(
                                            countryFlagUrl: 'assets/China.svg',
                                            countryName: 'China',
                                            countryNameShort: 'CN'),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        CountryListTile(
                                            countryFlagUrl:
                                                'assets/Netherlands.svg',
                                            countryName: 'Netherland',
                                            countryNameShort: 'NL'),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        CountryListTile(
                                            countryFlagUrl:
                                                'assets/Indonesia.svg',
                                            countryName: 'Indonesia',
                                            countryNameShort: 'ID'),
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                    },
                    readOnly: true,
                    controller: ref.watch(countryControllerProvider),
                    hintText: 'Select Country',
                    keyboardType: TextInputType.name,
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.0.w, vertical: 16.h),
                      child: SvgPicture.asset(
                          ref.watch(selectedCountryFlagProvider)),
                    ),
                    suffixIcon: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0.w, vertical: 18.h),
                      child: Icon(
                        CupertinoIcons.chevron_down,
                        color: darkGrey,
                        size: 20.h,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  AppTextField(
                    controller: ref.read(passwordControllerProvider),
                    hintText: 'New Password',
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
                  SizedBox(
                    height: 24.h,
                  ),
                  AppButton(
                      backgroundColor: ref.watch(enableButtonProvider)
                          ? buttonColor
                          : buttonColor.withOpacity(0.7),
                      text: 'Continue',
                      onPressed: () {
                        ref.watch(enableButtonProvider)
                            ? registerUser.when(data: (data) {
                                print('Registration Success');
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SetPin()));
                              }, error: (error, stackTrace) {
                                Fluttertoast.showToast(
                                    msg:
                                        'Registration Error: ${error.toString()}');
                                print('Registration Error: $error');
                                print(stackTrace);
                              }, loading: () {
                                print('loading');
                                print(ref
                                    .watch(selectedCountryShortNameProvider));
                                return CircularProgressIndicator();
                              })
                            : null;
                      },
                      width: 327)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CountryListTile extends ConsumerWidget {
  CountryListTile({
    required this.countryFlagUrl,
    required this.countryName,
    required this.countryNameShort,
    super.key,
  });

  String countryName;
  String countryNameShort;
  String countryFlagUrl;

  @override
  Widget build(BuildContext context, ref) {
    final selectedCountry = ref.watch(selectedCountryProvider);

    return GestureDetector(
      onTap: () {
        ref.read(selectedCountryProvider.notifier).state = countryNameShort;
        ref.read(selectedCountryNameProvider.notifier).state = countryName;
        ref.read(selectedCountryFlagProvider.notifier).state = countryFlagUrl;
        ref.read(selectedCountryShortNameProvider.notifier).state =
            countryNameShort;
        Navigator.pop(context);
      },
      child: Container(
        height: 64.h,
        width: 327.w,
        decoration: BoxDecoration(
          color: textFieldColor,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(countryFlagUrl),
                  SizedBox(
                    width: 16.w,
                  ),
                  Text(
                    countryNameShort,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontWeight: FontWeight.w500, color: darkGrey),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Text(countryName,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: buttonColor)),
                ],
              ),
              if (selectedCountry == countryNameShort)
                SvgPicture.asset('assets/countrycheck.svg'),
            ],
          ),
        ),
      ),
    );
  }
}
