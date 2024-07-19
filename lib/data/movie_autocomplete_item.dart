class MovieAutoCompleteItem {
  final String title;
  final String description;
  final String poster;
  final String backdrop;
  final String language;

  MovieAutoCompleteItem({
    required this.title,
    required this.description,
    required this.poster,
    required this.backdrop,
    required this.language,
  });

  factory MovieAutoCompleteItem.fromJson(Map<String, dynamic> json) {
    return MovieAutoCompleteItem(
      title: json['title'],
      description: json['overview'],
      poster: json['poster_path'],
      backdrop: json['backdrop_path'],
      language: json['original_language'],
    );
  }
}
