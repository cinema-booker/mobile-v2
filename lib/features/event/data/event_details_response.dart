import 'dart:convert';

import 'package:cinema_booker/features/cinema/data/cinema_list_response.dart';
import 'package:cinema_booker/features/event/data/event_movie.dart';
import 'package:cinema_booker/features/event/data/event_session.dart';

class EventDetailsResponse {
  final int id;
  final CinemaListItem cinema;
  final EventMovie movie;
  final List<EventSession> sessions;

  EventDetailsResponse({
    required this.id,
    required this.cinema,
    required this.movie,
    required this.sessions,
  });

  factory EventDetailsResponse.fromMap(Map<String, dynamic> json) {
    return EventDetailsResponse(
      id: json['id'],
      cinema: CinemaListItem.fromMap(json['cinema']),
      movie: EventMovie.fromMap(json['movie']),
      sessions: List<EventSession>.from(json['sessions'].map(
        (x) => EventSession.fromMap(x),
      )),
    );
  }

  factory EventDetailsResponse.fromJson(String source) =>
      EventDetailsResponse.fromMap(json.decode(source));
}
