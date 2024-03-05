extension ExtString on String {
  bool get isValidEmail {
    final emailRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+[a-zA-Z]+[a-zA-Z]");
    return emailRegExp.hasMatch(this);
  }
}