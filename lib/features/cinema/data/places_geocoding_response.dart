import 'dart:convert';

class PlacesGeocodingResponse {
  final double longitude;
  final double latitude;

  PlacesGeocodingResponse({
    required this.longitude,
    required this.latitude,
  });

  factory PlacesGeocodingResponse.formMap(Map<String, dynamic> json) {
    return PlacesGeocodingResponse(
      longitude: json['result']['geometry']['location']['lng'],
      latitude: json['result']['geometry']['location']['lat'],
    );
  }

  factory PlacesGeocodingResponse.fromJson(String source) =>
      PlacesGeocodingResponse.formMap(json.decode(source));
}
