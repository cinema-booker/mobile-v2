import 'dart:convert';

import 'package:cinema_booker/data/cinema_room.dart';

class EventSession {
  final int id;
  final int price;
  final DateTime startsAt;
  final CinemaRoom room;

  EventSession({
    required this.id,
    required this.price,
    required this.startsAt,
    required this.room,
  });

  factory EventSession.fromMap(Map<String, dynamic> json) {
    return EventSession(
      id: json['id'],
      price: json['price'],
      startsAt: DateTime.parse(json['starts_at']),
      room: CinemaRoom.fromMap(json['room']),
    );
  }

  factory EventSession.fromJson(String source) =>
      EventSession.fromMap(json.decode(source));
}

extension EventSessionPriceInEuro on EventSession {
  double get priceInEuro => price / 100.0;
}
