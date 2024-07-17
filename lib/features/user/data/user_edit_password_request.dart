import 'dart:convert';

class UserEditPasswordRequest {
  final String password;
  final String newPassword;

  UserEditPasswordRequest({
    required this.password,
    required this.newPassword,
  });

  String toJson() {
    return json.encode({
      'password': password,
      'new_password': newPassword,
    });
  }
}
