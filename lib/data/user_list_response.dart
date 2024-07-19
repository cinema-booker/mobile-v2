import 'dart:convert';

class UserListItem {
  final int id;
  final String name;
  final String email;
  final String role;

  UserListItem({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory UserListItem.fromMap(Map<String, dynamic> json) {
    return UserListItem(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
    );
  }

  factory UserListItem.fromJson(String source) =>
      UserListItem.fromMap(json.decode(source));
}

class UserListResponse {
  final List<UserListItem> users;

  UserListResponse({
    required this.users,
  });

  factory UserListResponse.fromList(List<dynamic> list) {
    return UserListResponse(
      users: list.map((item) => UserListItem.fromMap(item)).toList(),
    );
  }

  factory UserListResponse.fromJson(String source) =>
      UserListResponse.fromList(json.decode(source));
}
