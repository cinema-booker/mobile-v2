import 'dart:convert';

class BookingCreateResponse {
  final int sessionId;
  final int price;
  final List<String> seats;

  BookingCreateResponse({
    required this.sessionId,
    required this.price,
    required this.seats,
  });

  factory BookingCreateResponse.fromMap(Map<String, dynamic> json) {
    return BookingCreateResponse(
      sessionId: json['session_id'],
      price: json['price'],
      seats: List<String>.from(json['seats']),
    );
  }

  factory BookingCreateResponse.fromJson(String source) =>
      BookingCreateResponse.fromMap(json.decode(source));
}
