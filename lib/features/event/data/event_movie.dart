import 'dart:convert';

class EventMovie {
  final int id;
  final String title;
  final String description;
  final String language;
  final String poster;
  final String backdrop;

  EventMovie({
    required this.id,
    required this.title,
    required this.description,
    required this.language,
    required this.poster,
    required this.backdrop,
  });

  factory EventMovie.fromMap(Map<String, dynamic> json) {
    return EventMovie(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      language: json['language'],
      poster: json['poster'],
      backdrop: json['backdrop'],
    );
  }

  factory EventMovie.fromJson(String source) =>
      EventMovie.fromMap(json.decode(source));
}
