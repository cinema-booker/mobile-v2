import 'dart:convert';

class UserDetailsResponse {
  final int id;
  final String name;
  final String email;
  final String role;
  final int? cinemaId;

  UserDetailsResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.cinemaId,
  });

  factory UserDetailsResponse.fromMap(Map<String, dynamic> json) {
    return UserDetailsResponse(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      cinemaId: json['cinema_id'],
    );
  }

  factory UserDetailsResponse.fromJson(String source) =>
      UserDetailsResponse.fromMap(json.decode(source));
}
