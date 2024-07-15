import 'dart:convert';

import 'package:cinema_booker/features/event/data/movie_autocomplete_item.dart';

class EventCreateRequest {
  final int cinemaId;
  final MovieAutoCompleteItem movie;

  EventCreateRequest({
    required this.cinemaId,
    required this.movie,
  });

  String toJson() {
    return json.encode({
      'cinema_id': cinemaId,
      'movie_title': movie.title,
      'movie_description': movie.description,
      'movie_poster': movie.poster,
      'movie_backdrop': movie.backdrop,
      'movie_language': movie.language,
    });
  }
}
