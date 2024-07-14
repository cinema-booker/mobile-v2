import 'dart:convert';

import 'package:cinema_booker/features/cinema/data/cinema_address.dart';
import 'package:cinema_booker/features/cinema/data/cinema_room.dart';

class CinemaDetailsResponse {
  final int id;
  final String name;
  final String description;
  final CinemaAddress address;
  final List<CinemaRoom> rooms;

  CinemaDetailsResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.rooms,
  });

  factory CinemaDetailsResponse.fromMap(Map<String, dynamic> json) {
    return CinemaDetailsResponse(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      address: CinemaAddress.fromMap(json['address']),
      rooms: List<CinemaRoom>.from(json['rooms'].map(
        (x) => CinemaRoom.fromMap(x),
      )),
    );
  }

  factory CinemaDetailsResponse.fromJson(String source) =>
      CinemaDetailsResponse.fromMap(json.decode(source));
}
