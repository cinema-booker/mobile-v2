import 'dart:convert';

class RoomCreateRequest {
  final String number;
  final String type;

  RoomCreateRequest({
    required this.number,
    required this.type,
  });

  String toJson() {
    return json.encode({
      'number': number,
      'type': type,
    });
  }
}
