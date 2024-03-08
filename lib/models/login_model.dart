class LoginModel {
  final bool status;
  final String message;
  final LoginUserData? data;
  final List<dynamic> meta;
  final List<dynamic> pagination;

  LoginModel({
    required this.status,
    required this.message,
    this.data,
    required this.meta,
    required this.pagination,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    status: json['status'],
    message: json['message'],
    data: LoginUserData.fromJson(json['data'] ?? {}),
    meta: json['meta'],
    pagination: json['pagination'],
  );

  @override
  String toString() =>
      'LoginModel(status: $status, message: $message, data: $data, meta: $meta, pagination: $pagination)';
}

class LoginUserData {
  final LoginUser? user;
  final String? token;

  LoginUserData({
    this.user,
    this.token,
  });

  factory LoginUserData.fromJson(Map<String, dynamic> json) => LoginUserData(
    user: LoginUser.fromJson(json['user'] ?? {}),
    token: json['token'],
  );

  @override
  String toString() => 'LoginUserData(user: $user, token: $token)';
}

class LoginUser {
  final String? fullName;
  final String? username;
  final String? email;
  final String? country;
  final String? id;

  LoginUser({
    this.fullName,
    this.username,
    this.email,
    this.country,
    this.id,
  });

  factory LoginUser.fromJson(Map<String, dynamic> json) => LoginUser(
    fullName: json['full_name'],
    username: json['username'],
    email: json['email'],
    country: json['country'],
    id: json['id'],
  );

  @override
  String toString() =>
      'LoginUser(fullName: $fullName, username: $username, email: $email, country: $country, id: $id)';
}
