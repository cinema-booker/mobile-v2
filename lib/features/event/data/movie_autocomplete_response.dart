import 'dart:convert';

import 'package:cinema_booker/features/event/data/movie_autocomplete_item.dart';

class MovieAutoCompleteResponse {
  final List<MovieAutoCompleteItem> movies;

  MovieAutoCompleteResponse({
    required this.movies,
  });

  factory MovieAutoCompleteResponse.formMap(Map<String, dynamic> json) {
    List<MovieAutoCompleteItem> movies = [];
    for (var movie in json['results']) {
      movies.add(MovieAutoCompleteItem.fromJson(movie));
    }
    return MovieAutoCompleteResponse(movies: movies);
  }

  factory MovieAutoCompleteResponse.fromJson(String source) =>
      MovieAutoCompleteResponse.formMap(json.decode(source));
}
