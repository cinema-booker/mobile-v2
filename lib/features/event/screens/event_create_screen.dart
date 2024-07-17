// ignore_for_file: use_build_context_synchronously

import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/features/event/data/movie_autocomplete_item.dart';
import 'package:cinema_booker/features/event/services/event_service.dart';
import 'package:cinema_booker/features/event/widgets/movie_autocomplete.dart';
import 'package:cinema_booker/theme/theme_color.dart';
import 'package:cinema_booker/theme/theme_font.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EventCreateScreen extends StatefulWidget {
  const EventCreateScreen({super.key});

  @override
  State<EventCreateScreen> createState() => _EventCreateScreenState();
}

class _EventCreateScreenState extends State<EventCreateScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final EventService _eventService = EventService();
  MovieAutoCompleteItem? _selectedMovie;

  Future<void> _createEvent() async {
    if (_selectedMovie != null) {
      // _eventService.create(
      //   context: context,
      //   cinemaId: 1,
      //   movie: _selectedMovie!,
      // );

      ApiResponse<Null> response = await _eventService.createV2(
        cinemaId: 1,
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
            content: Text('Event created'),
          ),
        );

        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Create Event",
                style: TextStyle(
                  fontSize: ThemeFontSize.s32,
                  color: ThemeColor.white,
                ),
              ),
              MovieAutocomplete(
                onSelected: (movie) {
                  _selectedMovie = movie;
                },
                onClear: () {
                  _selectedMovie = null;
                },
              ),
              ElevatedButton(
                onPressed: _createEvent,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
