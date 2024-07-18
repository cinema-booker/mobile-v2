import 'dart:convert';

class ForgetPasswordRequest {
  final String email;

  ForgetPasswordRequest({
    required this.email,
  });

  String toJson() {
    return json.encode({
      'email': email,
    });
  }
}
