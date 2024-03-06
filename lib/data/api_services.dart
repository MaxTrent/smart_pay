import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:smart_pay/models/models.dart';
import 'package:smart_pay/screens/screens.dart';



final apiServiceProvider = Provider((ref) => ApiService());

class ApiService{
  String baseUrl = 'mobile-test-2d7e555a4f85.herokuapp.com';

  Future<SignUpModel> getEmailToken(String email) async {
    late SignUpModel signUpModel;

    final response = await http.post(Uri.https(baseUrl, '/api/v1/auth/email'),
        body: ({
          "email": email,
        }),
        headers: {'Accept': 'application/json'});
    print('getEmailToken executing...');



    try {

      if (response.statusCode == 200) {
        print('getEmailToken executing hmm...');
        print(response.body);
        var data = json.decode(response.body);
        var token = data['data']['token'];
        print(token);
        signUpModel = SignUpModel.fromJson(data);

        if (kDebugMode) {
          print('Response gotten');
        }

      }
      else {
        var data = json.decode(response.body);

        Fluttertoast.showToast(msg: 'Unable to confirm email: ${data['message']?? 'Unknown error'} ');
        throw Exception('Unable to confirm email: ${data['message']}');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return signUpModel;
  }

  Future<VerifySignUpModel> verifyEmail(
      BuildContext context, String email, String token) async {
    late VerifySignUpModel verifySignUpModel;


    final response = await http.post(Uri.https(baseUrl, 'auth/email/verify'),
        body: ({
          "email": email,
          "token": token,
        }),
        headers: {'Accept': 'application/json'});
    try {
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        verifySignUpModel = VerifySignUpModel.fromJson(data);

        if (kDebugMode) {
          print('Response gotten');
        }
        if (context.mounted) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => UserInfo()));
        }
      }
      throw Exception('Unable to verify user: ${response.body}');
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return verifySignUpModel;
  }

  Future<RegisterUserModel> registerUser(BuildContext context, String fullName,
      String userName, String email, String country, String password) async {
    late RegisterUserModel registerUserModel;

    final response = await http.post(Uri.https(baseUrl, 'auth/register'),
        body: ({
          'full_name': fullName,
          'username': userName,
          'email': email,
          'country': country,
          'password': password
        }),
        headers: {'Accept': 'application/json'});

    try {
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        registerUserModel = RegisterUserModel.fromJson(data);

        if (kDebugMode) {
          print('Response gotten');
        }
        if (context.mounted) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => SetPin()));
        }
      }
      throw Exception('Unable to register user: ${response.body}');
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return registerUserModel;
  }

  Future<LoginModel> login(
      BuildContext context, String email, String password) async {
    late LoginModel loginModel;

    final response = await http.post(Uri.https(baseUrl, 'auth/login'),
        body: ({
          'email': email,
          'password': password,
        }),
        headers: {'Accept': 'application/json'});

    try {
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        loginModel = LoginModel.fromJson(data);

        if (kDebugMode) {
          print('Response gotten');
        }
        if (context.mounted) {
          // Navigator.pushReplacement(
          //     context, MaterialPageRoute(builder: (context) => ()));
        }
      }
      throw Exception('Unable to log user in: ${response.body}');
    } catch (e) {
      print(e.toString());
    }
    return loginModel;
  }

  Future<void> logOut(BuildContext context) async {
    final response = await http.post(Uri.https(baseUrl, 'auth/logout'),
        headers: {'Accept': 'application/json'});
    try {
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (kDebugMode) {
          print('logged out');
        }
        if (context.mounted) {
          // Navigator.pushReplacement(
          //     context, MaterialPageRoute(builder: (context) => ()));
        }
      }
      throw Exception('Unable to log user out: ${response.body}');
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }

  }

  // Future<void> getSecret() async{
  //
  //   final response = await http.post(Uri.https(baseUrl, 'auth/login'),
  //
  //       headers: {'Accept': 'application/json', "Authorization": "Bearer "});
  // }

}
