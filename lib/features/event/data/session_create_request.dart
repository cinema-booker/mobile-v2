import 'dart:convert';

class SessionCreateRequest {
  final int roomId;
  final int price;
  final DateTime startsAt;

  SessionCreateRequest({
    required this.roomId,
    required this.price,
    required this.startsAt,
  });

  String toJson() {
    return json.encode({
      'room_id': roomId,
      'price': price,
      'starts_at': startsAt.toIso8601String(),
    });
  }
}
