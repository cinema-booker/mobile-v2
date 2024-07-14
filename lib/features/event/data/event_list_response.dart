import 'dart:convert';

import 'package:cinema_booker/features/event/data/event_movie.dart';

class EventListItem {
  final int id;
  final EventMovie movie;

  EventListItem({
    required this.id,
    required this.movie,
  });

  factory EventListItem.fromMap(Map<String, dynamic> json) {
    return EventListItem(
      id: json['id'],
      movie: EventMovie.fromMap(json['movie']),
    );
  }

  factory EventListItem.fromJson(String source) =>
      EventListItem.fromMap(json.decode(source));
}

class EventListResponse {
  final List<EventListItem> events;

  EventListResponse({
    required this.events,
  });

  factory EventListResponse.fromList(List<dynamic> list) {
    return EventListResponse(
      events: list.map((item) => EventListItem.fromMap(item)).toList(),
    );
  }

  factory EventListResponse.fromJson(String source) =>
      EventListResponse.fromList(json.decode(source));
}
