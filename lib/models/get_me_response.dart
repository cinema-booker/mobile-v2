import 'dart:convert';

class GetMeResponse {
  final int id;
  final String name;
  final String email;
  final String role;

  GetMeResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory GetMeResponse.fromMap(Map<String, dynamic> json) {
    return GetMeResponse(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
    );
  }

  factory GetMeResponse.fromJson(String source) =>
      GetMeResponse.fromMap(json.decode(source));
}
