

class VerifySignUpModel {
  final String email;
  final String token;

  const VerifySignUpModel({
    required this.email,
    required this.token,
  });

  factory VerifySignUpModel.fromJson(Map<String, dynamic> json) => VerifySignUpModel(
    email: json['email'] as String,
    token: json['token'] as String,
  );

  Map<String, dynamic> toJson() => {
    'email': email,
    'token': token,
  };
}
