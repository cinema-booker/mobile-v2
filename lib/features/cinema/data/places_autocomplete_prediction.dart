class PlacesAutoCompletePrediction {
  final String placeId;
  final String description;

  PlacesAutoCompletePrediction({
    required this.placeId,
    required this.description,
  });

  factory PlacesAutoCompletePrediction.fromJson(Map<String, dynamic> json) {
    return PlacesAutoCompletePrediction(
      placeId: json['place_id'],
      description: json['description'],
    );
  }
}
