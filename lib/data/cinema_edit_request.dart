import 'dart:convert';

class CinemaEditRequest {
  final String name;
  final String description;

  CinemaEditRequest({
    required this.name,
    required this.description,
  });

  String toJson() {
    return json.encode({
      'name': name,
      'description': description,
    });
  }
}
