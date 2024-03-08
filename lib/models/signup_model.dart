class SignUpModel {
  final bool status;
  final String message;
  final Data? data;
  final List<dynamic> meta;
  final List<dynamic> pagination;

  SignUpModel({
    required this.status,
    required this.message,
    this.data,
    required this.meta,
    required this.pagination,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        status: json['status'],
        message: json['message'],
        data: Data.fromJson(json['data'] ?? {}),
        meta: json['meta'],
        pagination: json['pagination'],
      );

  @override
  String toString() =>
      'SignUpModel(status: $status, message: $message, data: $data, meta: $meta, pagination: $pagination)';
}

class Data {
  final String? token;

  Data({this.token});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json['token'],
      );

  @override
  String toString() => 'Data(token: $token)';
}
