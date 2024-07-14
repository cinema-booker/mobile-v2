import 'dart:convert';

class CinemaAddress {
  final int id;
  final String address;
  final double longitude;
  final double latitude;

  CinemaAddress({
    required this.id,
    required this.address,
    required this.longitude,
    required this.latitude,
  });

  factory CinemaAddress.fromMap(Map<String, dynamic> json) {
    return CinemaAddress(
      id: json['id'],
      address: json['address'],
      longitude: json['longitude'],
      latitude: json['latitude'],
    );
  }

  factory CinemaAddress.fromJson(String source) =>
      CinemaAddress.fromMap(json.decode(source));
}
