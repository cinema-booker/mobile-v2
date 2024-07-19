import 'dart:convert';

class SignInResponse {
  final int id;
  final String name;
  final String email;
  final String role;
  final String token;

  SignInResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.token,
  });

  factory SignInResponse.fromMap(Map<String, dynamic> json) {
    return SignInResponse(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      token: json['token'],
    );
  }

  factory SignInResponse.fromJson(String source) =>
      SignInResponse.fromMap(json.decode(source));
}
