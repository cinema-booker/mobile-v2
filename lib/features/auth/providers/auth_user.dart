import 'dart:convert';

class AuthUser {
  final int id;
  final String name;
  final String email;
  final String role;
  final int? cinemaId;

  AuthUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.cinemaId,
  });

  factory AuthUser.getEmpty() {
    return AuthUser(
      id: -1,
      name: '',
      email: '',
      role: '',
      cinemaId: null,
    );
  }

  factory AuthUser.fromMap(Map<String, dynamic> json) {
    return AuthUser(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      cinemaId: json['cinema_id'],
    );
  }

  factory AuthUser.fromJson(String source) =>
      AuthUser.fromMap(json.decode(source));
}
