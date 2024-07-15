import 'dart:convert';

class UserDetailsResponse {
  final int id;
  final String name;
  final String email;
  final String role;

  UserDetailsResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory UserDetailsResponse.fromMap(Map<String, dynamic> json) {
    return UserDetailsResponse(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
    );
  }

  factory UserDetailsResponse.fromJson(String source) =>
      UserDetailsResponse.fromMap(json.decode(source));
}
