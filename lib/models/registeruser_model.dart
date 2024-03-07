class RegisterUserModel {
  final bool status;
  final String message;
  final RegisterUserData? data;
  final List<dynamic> meta;
  final List<dynamic> pagination;

  RegisterUserModel({
    required this.status,
    required this.message,
    this.data,
    required this.meta,
    required this.pagination,
  });

  factory RegisterUserModel.fromJson(Map<String, dynamic> json) => RegisterUserModel(
    status: json['status'],
    message: json['message'],
    data: RegisterUserData.fromJson(json['data'] ?? {}),
    meta: json['meta'],
    pagination: json['pagination'],
  );

  @override
  String toString() =>
      'RegisterUserModel(status: $status, message: $message, data: $data, meta: $meta, pagination: $pagination)';
}

class RegisterUserData {
  final RegisterUser? user;
  final String? token;

  RegisterUserData({
    this.user,
    this.token,
  });

  factory RegisterUserData.fromJson(Map<String, dynamic> json) => RegisterUserData(
    user: RegisterUser.fromJson(json['user'] ?? {}),
    token: json['token'],
  );

  @override
  String toString() => 'RegisterUserData(user: $user, token: $token)';
}

class RegisterUser {
  final String? fullName;
  final String? username;
  final String? email;
  final String? country;
  final String? id;

  RegisterUser({
    this.fullName,
    this.username,
    this.email,
    this.country,
    this.id,
  });

  factory RegisterUser.fromJson(Map<String, dynamic> json) => RegisterUser(
    fullName: json['full_name'],
    username: json['username'],
    email: json['email'],
    country: json['country'],
    id: json['id'],
  );

  @override
  String toString() =>
      'RegisterUser(fullName: $fullName, username: $username, email: $email, country: $country, id: $id)';
}
