import 'dart:convert';

import 'package:cinema_booker/data/cinema_address.dart';

class CinemaListItem {
  final int id;
  final String name;
  final String description;
  final CinemaAddress address;

  CinemaListItem({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
  });

  factory CinemaListItem.fromMap(Map<String, dynamic> json) {
    return CinemaListItem(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      address: CinemaAddress.fromMap(json['address']),
    );
  }

  factory CinemaListItem.fromJson(String source) =>
      CinemaListItem.fromMap(json.decode(source));
}

class CinemaListResponse {
  final List<CinemaListItem> cinemas;

  CinemaListResponse({
    required this.cinemas,
  });

  factory CinemaListResponse.fromList(List<dynamic> list) {
    return CinemaListResponse(
      cinemas: list.map((item) => CinemaListItem.fromMap(item)).toList(),
    );
  }

  factory CinemaListResponse.fromJson(String source) =>
      CinemaListResponse.fromList(json.decode(source));
}
