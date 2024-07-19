import 'dart:convert';

class ResetPasswordRequest {
  final String email;
  final String code;
  final String password;

  ResetPasswordRequest({
    required this.email,
    required this.password,
    required this.code,
  });

  String toJson() {
    return json.encode({
      'email': email,
      'code': code,
      'password': password,
    });
  }
}
