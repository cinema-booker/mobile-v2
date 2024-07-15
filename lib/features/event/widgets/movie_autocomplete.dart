import 'package:cinema_booker/features/event/data/movie_autocomplete_item.dart';
import 'package:cinema_booker/features/event/data/movie_autocomplete_response.dart';
import 'package:cinema_booker/features/event/services/movie_service.dart';
import 'package:cinema_booker/theme/theme_color.dart';
import 'package:flutter/material.dart';

class MovieAutocomplete extends StatefulWidget {
  final void Function(MovieAutoCompleteItem) onSelected;
  final void Function() onClear;

  const MovieAutocomplete({
    super.key,
    required this.onSelected,
    required this.onClear,
  });

  @override
  State<MovieAutocomplete> createState() => _MovieAutocompleteState();
}

class _MovieAutocompleteState extends State<MovieAutocomplete> {
  final MovieService _movieService = MovieService();

  List<MovieAutoCompleteItem> _movies = [];

  Future<void> _getPredictions(String query) async {
    MovieAutoCompleteResponse response =
        await _movieService.search(query: query);
    setState(() {
      _movies = response.movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<MovieAutoCompleteItem>(
      displayStringForOption: (movie) => movie.title,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<MovieAutoCompleteItem>.empty();
        }
        _getPredictions(textEditingValue.text);
        return _movies;
      },
      onSelected: (MovieAutoCompleteItem selection) {
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
            hintText: 'Search for a movie...',
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                fieldTextEditingController.clear();
                setState(() {
                  _movies = [];
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
