import 'package:cinema_booker/features/event/data/movie_autocomplete_response.dart';
import 'package:http/http.dart' as http;

class MovieService {
  final String apiKey = "a4807a61580a2274d5e7460d82ce85c2";

  Future<MovieAutoCompleteResponse> search({
    required String query,
  }) async {
    Uri url = Uri.parse('https://api.themoviedb.org/3/search/movie');

    try {
      final response = await http.get(
        url.replace(queryParameters: {
          'api_key': apiKey,
          'query': query,
          'language': 'fr-FR',
          'page': '1',
          'include_adult': 'false',
        }),
      );

      if (response.statusCode == 200) {
        MovieAutoCompleteResponse movieAutoCompleteResponse =
            MovieAutoCompleteResponse.fromJson(response.body);
        return movieAutoCompleteResponse;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }
}
