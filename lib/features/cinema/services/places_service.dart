import 'package:http/http.dart' as http;

import 'package:cinema_booker/features/cinema/data/places_autocomplete_response.dart';
import 'package:cinema_booker/features/cinema/data/places_geocoding_response.dart';

class PlacesService {
  final String apiKey = "AIzaSyDa1cA8ny2xUDoieyawipxpL4RYJkOR-iU";

  Future<PlacesAutoCompleteResponse> autoComplete({
    required String query,
  }) async {
    Uri url = Uri.https(
      'maps.googleapis.com',
      'maps/api/place/autocomplete/json',
      {
        'input': query,
        'key': apiKey,
      },
    );

    try {
      final response = await http.get(Uri.parse(url.toString()));
      if (response.statusCode == 200) {
        PlacesAutoCompleteResponse placesAutoCompleteResponse =
            PlacesAutoCompleteResponse.fromJson(response.body);
        return placesAutoCompleteResponse;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }

  Future<PlacesGeocodingResponse> getGeocoding({
    required String placeId,
  }) async {
    Uri url = Uri.https(
      'maps.googleapis.com',
      'maps/api/place/details/json',
      {
        'place_id': placeId,
        'fields': 'geometry',
        'key': apiKey,
      },
    );

    try {
      final response = await http.get(Uri.parse(url.toString()));
      if (response.statusCode == 200) {
        PlacesGeocodingResponse placesGeocodingResponse =
            PlacesGeocodingResponse.fromJson(response.body);
        return placesGeocodingResponse;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }
}
