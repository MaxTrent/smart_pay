class RegisterUserModel {
  final String fullName;
  final String? username; // username is optional
  final String email;
  final String country;
  final String password;
  final String deviceName;

  const RegisterUserModel({
    required this.fullName,
    this.username,
    required this.email,
    required this.country,
    required this.password,
    required this.deviceName,
  });

  factory RegisterUserModel.fromJson(Map<String, dynamic> json) => RegisterUserModel(
    fullName: json['full_name'] as String,
    username: json['username'] as String?, // Handle null for optional field
    email: json['email'] as String,
    country: json['country'] as String,
    password: json['password'] as String,
    deviceName: json['device_name'] as String,
  );

  Map<String, dynamic> toJson() => {
    'full_name': fullName,
    'username': username,
    'email': email,
    'country': country,
    'password': password,
    'device_name': deviceName,
  };
}
