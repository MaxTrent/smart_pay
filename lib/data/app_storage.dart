import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

final storage = FlutterSecureStorage();

// Store Login Pin
Future<void> storePin(String pin) async {
  await storage.write(key: 'pin', value: pin);
  if (kDebugMode) {
    print('pin stored');
  }
}

// Retrieve the login pin you stored
Future<String?> getStoredPin() async {
  return await storage.read(key: 'pin');
}

// Retrieve the stored full name
Future<String?> getStoredName() async {
  return await storage.read(key: 'fullName');
}

class SharedPreferencesHelper {
  static const String onboardingKey = 'onboarding';
  static const String loggedInKey = 'loggedIn';

  // Set onboarding as completed
  static Future<void> setOnboardingCompleted() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(onboardingKey, true);
  }

  // Check if onboarding is completed
  static Future<bool> isOnboardingCompleted() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(onboardingKey) ?? false;
  }

  // Set user as logged in
  static Future<void> setLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(loggedInKey, true);
  }

  // Set user as logged out
  static Future<void> setLoggedOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(loggedInKey, false);
  }

  // Check if the user is logged in
  static Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(loggedInKey) ?? false;
  }
}
