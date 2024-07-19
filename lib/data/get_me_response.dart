import 'dart:convert';

class GetMeResponse {
  final int id;
  final String name;
  final String email;
  final String role;
  final int? cinemaId;

  GetMeResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.cinemaId,
  });

  factory GetMeResponse.fromMap(Map<String, dynamic> json) {
    return GetMeResponse(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      cinemaId: json['cinema_id'],
    );
  }

  factory GetMeResponse.fromJson(String source) =>
      GetMeResponse.fromMap(json.decode(source));
}
