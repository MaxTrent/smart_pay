import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:smart_pay/models/models.dart';

final apiServiceProvider = Provider((ref) => ApiService());

class ApiService {
  final storage = FlutterSecureStorage();
  String baseUrl = 'mobile-test-2d7e555a4f85.herokuapp.com';

  // Get email verification token
  Future<SignUpModel> getEmailToken(String email) async {
    late SignUpModel signUpModel;

    final response = await http.post(
      Uri.https(baseUrl, '/api/v1/auth/email'),
      body: ({
        "email": email,
      }),
      headers: {'Accept': 'application/json'},
    );

    print('getEmailToken executing...');

    try {
      if (response.statusCode == 200) {
        // Successful response
        print('getEmailToken executing hmm...');
        print(response.body);
        var data = json.decode(response.body);
        var token = data['data']['token'];
        print(token);
        signUpModel = SignUpModel.fromJson(data);
        Fluttertoast.showToast(msg: 'Token: ${signUpModel.data?.token}');
        if (kDebugMode) {
          print('Response gotten');
        }
      } else {
        // Error response
        var data = json.decode(response.body);
        Fluttertoast.showToast(
          msg: 'Unable to confirm email: ${data['errors'] ?? 'Unknown error'} ',
        );
        throw Exception('Unable to confirm email: ${data}');
      }

      return signUpModel;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw Exception(e);
    }
  }

  // Verify user email with token
  Future<VerifySignUpModel> verifyEmail(String email, String token) async {
    late VerifySignUpModel verifySignUpModel;

    final response = await http.post(
      Uri.https(baseUrl, '/api/v1/auth/email/verify'),
      body: ({
        "email": email,
        "token": token,
      }),
      headers: {'Accept': 'application/json'},
    );

    try {
      if (response.statusCode == 200) {
        // Successful verification
        var data = json.decode(response.body);
        verifySignUpModel = VerifySignUpModel.fromJson(data);

        if (kDebugMode) {
          print('verified');
        }
      } else {
        // Verification error
        var data = json.decode(response.body);
        Fluttertoast.showToast(
          msg: 'Unable to verify user: ${data['message'] ?? 'Unknown error'} ',
        );
        throw Exception('Unable to verify user: ${response.body}');
      }

      return verifySignUpModel;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw Exception(e);
    }
  }

  // Register a new user
  Future<RegisterUserModel> registerUser(
      String fullName,
      String userName,
      String email,
      String password,
      ) async {
    late RegisterUserModel registerUserModel;

    final response = await http.post(
      Uri.https(baseUrl, '/api/v1/auth/register'),
      body: ({
        'full_name': fullName,
        'username': userName,
        'email': email,
        'country': 'NG',
        'password': password,
        "device_name": "web",
      }),
      headers: {'Accept': 'application/json'},
    );

    try {
      if (response.statusCode == 200) {
        // Successful registration
        var data = json.decode(response.body);
        registerUserModel = RegisterUserModel.fromJson(data);

        // Store the user's full name
        await storage.write(
          key: 'fullName',
          value: registerUserModel.data?.user?.fullName,
        );

        final name = await storage.read(key: 'fullName');
        print(name);

        if (kDebugMode) {
          print('Response gotten');
        }
      } else {
        // Registration error
        var data = json.decode(response.body);
        Fluttertoast.showToast(
          timeInSecForIosWeb: 5,
          msg: 'Unable to register user: ${data['errors'] ?? 'Unknown error'} ',
        );
        throw Exception('Unable to register user: ${response.body}');
      }

      return registerUserModel;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }

      throw Exception(e.toString());
    }
  }

  // User login
  Future<LoginModel> login(String email, String password) async {
    late LoginModel loginModel;
    final storage = FlutterSecureStorage();

    final response = await http.post(
      Uri.https(baseUrl, '/api/v1/auth/login'),
      body: ({'email': email, 'password': password, "device_name": "web"}),
      headers: {'Accept': 'application/json'},
    );

    try {
      if (response.statusCode == 200) {
        // Successful login
        var data = json.decode(response.body);
        loginModel = LoginModel.fromJson(data);
        var token = loginModel.data?.token;

        if (token != null) {
          // Store the token
          await storage.write(key: 'token', value: token);
        }
        if (kDebugMode) {
          print('Token stored: $token');
        }
        if (kDebugMode) {
          print('Response gotten');
        }
      } else {
        // Login error
        var data = json.decode(response.body);
        Fluttertoast.showToast(
          timeInSecForIosWeb: 5,
          msg: 'Unable to sign in: ${data['errors']} ',
        );
        throw Exception('Unable to log user in: ${response.body}');
      }
      print(json.decode(response.body));
      return loginModel;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw Exception(e);
    }
  }

  // User logout
  Future<void> logOut() async {
    final response = await http.post(
      Uri.https(baseUrl, '/api/v1/auth/logout'),
      headers: {'Accept': 'application/json'},
    );
    try {
      if (response.statusCode == 200) {
        // Successful logout
        var data = json.decode(response.body);

        if (kDebugMode) {
          print('logged out');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  // Get secret data using a user token
  Future<Home> getSecret() async {
    late Home homeModel;
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');

    try {
      final response = await http.get(
        Uri.https(baseUrl, '/api/v1/dashboard'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        // Successful data retrieval
        var data = json.decode(response.body);
        homeModel = Home.fromJson(data);
        print('Secret data: ${data}');
      } else {
        // Error in fetching data
        print('Failed to fetch secret: ${response.body}');
      }
      return homeModel;
    } catch (e) {
      throw Exception(e);
    }
  }
}
