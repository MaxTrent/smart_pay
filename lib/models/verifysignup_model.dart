import 'package:smart_pay/models/models.dart';

class VerifySignUpModel {
  final bool status;
  final String message;
  final Data? data;
  final List<dynamic> meta;
  final List<dynamic> pagination;

  VerifySignUpModel({
    required this.status,
    required this.message,
    this.data,
    required this.meta,
    required this.pagination,
  });

  factory VerifySignUpModel.fromJson(Map<String, dynamic> json) => VerifySignUpModel(
    status: json['status'],
    message: json['message'],
    data: Data.fromJson(json['data'] ?? {}),
    meta: json['meta'],
    pagination: json['pagination'],
  );

  @override
  String toString() =>
      'VerifySignUp(status: $status, message: $message, data: $data, meta: $meta, pagination: $pagination)';
}

class VerifySignUpData {
  final String? email; // Adjust this based on the actual structure of your 'data'

  VerifySignUpData({
    this.email,
  });

  factory VerifySignUpData.fromJson(Map<String, dynamic> json) => VerifySignUpData(
    email: json['email'],
  );

  @override
  String toString() => 'VerifySignUpData(email: $email)';
}
