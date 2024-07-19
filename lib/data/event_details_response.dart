import 'dart:convert';

import 'package:cinema_booker/data/cinema_list_response.dart';
import 'package:cinema_booker/data/booking_session.dart';
import 'package:cinema_booker/data/event_movie.dart';

class EventDetailsResponse {
  final int id;
  final CinemaListItem cinema;
  final EventMovie movie;
  final List<BookingSession> sessions;

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
      sessions: List<BookingSession>.from(json['sessions'].map(
        (x) => BookingSession.fromMap(x),
      )),
    );
  }

  factory EventDetailsResponse.fromJson(String source) =>
      EventDetailsResponse.fromMap(json.decode(source));
}
