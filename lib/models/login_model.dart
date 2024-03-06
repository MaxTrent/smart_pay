class LoginModel {
  final String email;
  final String password;
  final String deviceName;

  const LoginModel({
    required this.email,
    required this.password,
    required this.deviceName,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    email: json['email'] as String,
    password: json['password'] as String,
    deviceName: json['device_name'] as String,
  );

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'device_name': deviceName,
  };
}
