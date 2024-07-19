import 'dart:convert';

import 'package:cinema_booker/data/cinema_list_response.dart';
import 'package:cinema_booker/data/cinema_room.dart';
import 'package:cinema_booker/data/event_movie.dart';

class BookingUser {
  final int id;
  final String name;

  BookingUser({
    required this.id,
    required this.name,
  });

  factory BookingUser.fromMap(Map<String, dynamic> json) {
    return BookingUser(
      id: json['id'],
      name: json['name'],
    );
  }

  factory BookingUser.fromJson(String source) =>
      BookingUser.fromMap(json.decode(source));
}

class BookingEvent {
  final int id;
  final CinemaListItem cinema;
  final EventMovie movie;

  BookingEvent({
    required this.id,
    required this.cinema,
    required this.movie,
  });

  factory BookingEvent.fromMap(Map<String, dynamic> json) {
    return BookingEvent(
      id: json['id'],
      cinema: CinemaListItem.fromMap(json['cinema']),
      movie: EventMovie.fromMap(json['movie']),
    );
  }

  factory BookingEvent.fromJson(String source) =>
      BookingEvent.fromMap(json.decode(source));
}

class BookingSession {
  final int id;
  final int price;
  final DateTime startsAt;
  final CinemaRoom room;
  final BookingEvent event;

  BookingSession({
    required this.id,
    required this.price,
    required this.startsAt,
    required this.room,
    required this.event,
  });

  factory BookingSession.fromMap(Map<String, dynamic> json) {
    return BookingSession(
      id: json['id'],
      price: json['price'],
      startsAt: DateTime.parse(json['starts_at']),
      room: CinemaRoom.fromMap(json['room']),
      event: BookingEvent.fromMap(json['event']),
    );
  }

  factory BookingSession.fromJson(String source) =>
      BookingSession.fromMap(json.decode(source));
}

class BookingListItem {
  final int id;
  final String place;
  final String status;
  final BookingUser user;
  final BookingSession session;

  BookingListItem({
    required this.id,
    required this.place,
    required this.status,
    required this.user,
    required this.session,
  });

  factory BookingListItem.fromMap(Map<String, dynamic> json) {
    return BookingListItem(
      id: json['id'],
      place: json['place'],
      status: json['status'],
      user: BookingUser.fromMap(json['user']),
      session: BookingSession.fromMap(json['session']),
    );
  }

  factory BookingListItem.fromJson(String source) =>
      BookingListItem.fromMap(json.decode(source));
}

class BookingListResponse {
  final List<BookingListItem> bookings;

  BookingListResponse({
    required this.bookings,
  });

  factory BookingListResponse.fromList(List<dynamic> list) {
    return BookingListResponse(
      bookings: list.map((item) => BookingListItem.fromMap(item)).toList(),
    );
  }

  factory BookingListResponse.fromJson(String source) =>
      BookingListResponse.fromList(json.decode(source));
}
