import 'dart:convert';

import 'package:cinema_booker/features/cinema/data/cinema_room.dart';

class BookingSession {
  final int id;
  final int price;
  final DateTime startsAt;
  final CinemaRoom room;
  final List<String> seats; // booked seats

  BookingSession({
    required this.id,
    required this.price,
    required this.startsAt,
    required this.room,
    required this.seats,
  });

  factory BookingSession.fromMap(Map<String, dynamic> json) {
    return BookingSession(
      id: json['id'],
      price: json['price'],
      startsAt: DateTime.parse(json['starts_at']),
      room: CinemaRoom.fromMap(json['room']),
      seats: List<String>.from(json['seats']),
    );
  }

  factory BookingSession.fromJson(String source) =>
      BookingSession.fromMap(json.decode(source));
}

extension BookingSessionPriceInEuro on BookingSession {
  double get priceInEuro => price / 100.0;
}
