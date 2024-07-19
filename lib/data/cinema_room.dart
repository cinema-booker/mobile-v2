import 'dart:convert';

class CinemaRoom {
  final int id;
  final String number;
  final String type;

  CinemaRoom({
    required this.id,
    required this.number,
    required this.type,
  });

  factory CinemaRoom.fromMap(Map<String, dynamic> json) {
    return CinemaRoom(
      id: json['id'],
      number: json['number'],
      type: json['type'],
    );
  }

  factory CinemaRoom.fromJson(String source) =>
      CinemaRoom.fromMap(json.decode(source));
}
