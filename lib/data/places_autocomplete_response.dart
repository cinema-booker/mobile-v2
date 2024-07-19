import 'dart:convert';

import 'package:cinema_booker/data/places_autocomplete_prediction.dart';

class PlacesAutoCompleteResponse {
  final List<PlacesAutoCompletePrediction> predictions;

  PlacesAutoCompleteResponse({
    required this.predictions,
  });

  factory PlacesAutoCompleteResponse.formMap(Map<String, dynamic> json) {
    List<PlacesAutoCompletePrediction> predictions = [];
    for (var prediction in json['predictions']) {
      predictions.add(PlacesAutoCompletePrediction.fromJson(prediction));
    }
    return PlacesAutoCompleteResponse(predictions: predictions);
  }

  factory PlacesAutoCompleteResponse.fromJson(String source) =>
      PlacesAutoCompleteResponse.formMap(json.decode(source));
}
