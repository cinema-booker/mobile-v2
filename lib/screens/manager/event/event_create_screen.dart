// ignore_for_file: use_build_context_synchronously

import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/widgets/button.dart';
import 'package:cinema_booker/data/movie_autocomplete_item.dart';
import 'package:cinema_booker/services/event_service.dart';
import 'package:cinema_booker/widgets/movie_autocomplete.dart';
import 'package:cinema_booker/widgets/screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EventCreateScreen extends StatefulWidget {
  final int cinemaId;

  const EventCreateScreen({
    super.key,
    required this.cinemaId,
  });

  @override
  State<EventCreateScreen> createState() => _EventCreateScreenState();
}

class _EventCreateScreenState extends State<EventCreateScreen> {
  MovieAutoCompleteItem? _selectedMovie;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final EventService _eventService = EventService();

  Future<void> _createEvent() async {
    if (_formKey.currentState!.validate() && _selectedMovie != null) {
      ApiResponse<Null> response = await _eventService.create(
        cinemaId: widget.cinemaId,
        movie: _selectedMovie!,
      );
      if (response.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.error!),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Event created successfully'),
          ),
        );

        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(
        title: const Text('Event Create'),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MovieAutocomplete(
              onSelected: (movie) {
                _selectedMovie = movie;
              },
              onClear: () {
                _selectedMovie = null;
              },
            ),
            Button(
              onPressed: _createEvent,
              label: 'Create Event',
            ),
          ],
        ),
      ),
    );
  }
}
