import 'dart:convert';

import 'package:cinema_booker/models/sign_in_response.dart';
import 'package:flutter/material.dart';

class AuthUser {
  final int id;
  final String name;
  final String email;
  final String role;

  AuthUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory AuthUser.getEmptyUser() {
    return AuthUser(
      id: 0,
      name: '',
      email: '',
      role: '',
    );
  }

  factory AuthUser.fromMap(Map<String, dynamic> json) {
    return AuthUser(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
    );
  }

  factory AuthUser.fromJson(String source) =>
      AuthUser.fromMap(json.decode(source));
}

class AuthProvider extends ChangeNotifier {
  SignInResponse _user = SignInResponse.getEmpty();

  SignInResponse get user {
    return _user;
  }

  void setUser(SignInResponse user) {
    _user = user;
    notifyListeners();
  }
}
