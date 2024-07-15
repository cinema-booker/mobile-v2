import 'dart:convert';

class UserEditRequest {
  final String name;

  UserEditRequest({
    required this.name,
  });

  String toJson() {
    return json.encode({
      'name': name,
    });
  }
}
