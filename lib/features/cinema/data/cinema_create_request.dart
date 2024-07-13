import 'dart:convert';

class CinemaCreateRequest {
  final String name;
  final String description;
  final String address;
  final double longitude;
  final double latitude;

  CinemaCreateRequest({
    required this.name,
    required this.description,
    required this.address,
    required this.longitude,
    required this.latitude,
  });

  String toJson() {
    return json.encode({
      'name': name,
      'description': description,
      'address_address': address,
      'address_longitude': longitude,
      'address_latitude': latitude,
    });
  }
}
