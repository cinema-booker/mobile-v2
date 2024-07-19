import 'package:cinema_booker/theme/theme_color.dart';
import 'package:flutter/material.dart';

import 'package:cinema_booker/services/places_service.dart';
import 'package:cinema_booker/data/places_autocomplete_response.dart';
import 'package:cinema_booker/data/places_autocomplete_prediction.dart';

class AddressAutocomplete extends StatefulWidget {
  final void Function(PlacesAutoCompletePrediction) onSelected;
  final void Function() onClear;

  const AddressAutocomplete({
    super.key,
    required this.onSelected,
    required this.onClear,
  });

  @override
  State<AddressAutocomplete> createState() => _AddressAutocompleteState();
}

class _AddressAutocompleteState extends State<AddressAutocomplete> {
  final PlacesService _placesService = PlacesService();

  List<PlacesAutoCompletePrediction> _predictions = [];

  Future<void> _getPredictions(String query) async {
    PlacesAutoCompleteResponse response =
        await _placesService.autoComplete(query: query);
    setState(() {
      _predictions = response.predictions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<PlacesAutoCompletePrediction>(
      displayStringForOption: (prediction) => prediction.description,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<PlacesAutoCompletePrediction>.empty();
        }
        _getPredictions(textEditingValue.text);
        return _predictions;
      },
      onSelected: (PlacesAutoCompletePrediction selection) {
        widget.onSelected(selection);
      },
      fieldViewBuilder: (
        BuildContext context,
        TextEditingController fieldTextEditingController,
        FocusNode fieldFocusNode,
        VoidCallback onFieldSubmitted,
      ) {
        return TextFormField(
          keyboardType: TextInputType.streetAddress,
          controller: fieldTextEditingController,
          focusNode: fieldFocusNode,
          decoration: InputDecoration(
            hintText: 'Search for a place...',
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                fieldTextEditingController.clear();
                setState(() {
                  _predictions = [];
                });
                widget.onClear();
              },
            ),
            hintStyle: const TextStyle(
              color: ThemeColor.gray,
            ),
          ),
          style: const TextStyle(
            color: ThemeColor.white,
          ),
          onFieldSubmitted: (String value) {
            onFieldSubmitted();
          },
        );
      },
    );
  }
}
