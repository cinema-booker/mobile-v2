import 'dart:convert';

import 'package:cinema_booker/features/event/data/event_movie.dart';
import 'package:cinema_booker/features/event/data/event_session.dart';

class EventDetailsResponse {
  final int id;
  final EventMovie movie;
  final List<EventSession> sessions;

  EventDetailsResponse({
    required this.id,
    required this.movie,
    required this.sessions,
  });

  factory EventDetailsResponse.fromMap(Map<String, dynamic> json) {
    return EventDetailsResponse(
      id: json['id'],
      movie: EventMovie.fromMap(json['movie']),
      sessions: List<EventSession>.from(json['sessions'].map(
        (x) => EventSession.fromMap(x),
      )),
    );
  }

  factory EventDetailsResponse.fromJson(String source) =>
      EventDetailsResponse.fromMap(json.decode(source));
}
