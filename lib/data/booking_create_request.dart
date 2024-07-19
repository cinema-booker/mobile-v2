import 'dart:convert';

class BookingCreateRequest {
  final int sessionId;
  final List<String> seats;

  BookingCreateRequest({
    required this.sessionId,
    required this.seats,
  });

  String toJson() {
    return json.encode({
      'session_id': sessionId,
      'seats': seats,
    });
  }
}
