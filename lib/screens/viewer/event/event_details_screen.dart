// ignore_for_file: use_build_context_synchronously

import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/widgets/button.dart';
import 'package:cinema_booker/widgets/map_view.dart';
import 'package:cinema_booker/data/event_details_response.dart';
import 'package:cinema_booker/services/event_service.dart';
import 'package:cinema_booker/router/viewer_routes.dart';
import 'package:cinema_booker/theme/theme_color.dart';
import 'package:cinema_booker/widgets/screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EventDetailsScreen extends StatefulWidget {
  final int eventId;

  const EventDetailsScreen({
    super.key,
    required this.eventId,
  });

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  EventDetailsResponse? _event;
  String? _error;

  final EventService _eventService = EventService();

  @override
  void initState() {
    super.initState();

    _fetchEvent();
  }

  void _fetchEvent() async {
    ApiResponse<EventDetailsResponse> response = await _eventService.details(
      eventId: widget.eventId,
    );

    setState(() {
      _event = response.data;
      _error = response.error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(
        title: const Text('Event Details'),
      ),
      child: (_event == null && _error == null)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _error != null
              ? Center(
                  child: Text(
                    _error!,
                    style: const TextStyle(
                      color: ThemeColor.white,
                    ),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        "https://image.tmdb.org/t/p/w500${_event!.movie.backdrop}",
                        width: double.infinity,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _event!.movie.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: ThemeColor.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _event!.movie.description,
                      style: const TextStyle(
                        color: ThemeColor.gray,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(
                      color: ThemeColor.brown100,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _event!.cinema.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: ThemeColor.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    MapView(
                      latitude: _event!.cinema.address.latitude,
                      longitude: _event!.cinema.address.longitude,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _event!.cinema.address.address,
                      style: const TextStyle(
                        color: ThemeColor.gray,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(
                      color: ThemeColor.brown100,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Sessions",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: ThemeColor.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _event!.sessions.length,
                      itemBuilder: (context, index) {
                        final session = _event!.sessions[index];
                        return ListTile(
                          title: Text(
                            session.startsAt.toString(),
                            style: const TextStyle(
                              color: ThemeColor.white,
                            ),
                          ),
                          subtitle: Text(
                            "${session.room.number} - ${session.price.toString()} €",
                            style: const TextStyle(
                              color: ThemeColor.gray,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    Button(
                      onPressed: () {
                        context.push(
                          ViewerRoutes.viewerBookingCreate,
                          extra: {
                            "eventId": widget.eventId,
                          },
                        );
                      },
                      label: 'Book event',
                    )
                  ],
                ),
    );
  }
}
