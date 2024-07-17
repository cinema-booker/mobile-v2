// ignore_for_file: use_build_context_synchronously

import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/features/event/data/event_details_response.dart';
import 'package:cinema_booker/features/event/services/event_service.dart';
import 'package:cinema_booker/features/event/services/session_service.dart';
import 'package:cinema_booker/router/admin_routes.dart';
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
  final SessionService _sessionService = SessionService();

  @override
  void initState() {
    super.initState();

    _fetchEvent();
  }

  void _fetchEvent() async {
    ApiResponse<EventDetailsResponse> response = await _eventService.detailsV2(
      eventId: widget.eventId,
    );

    setState(() {
      _event = response.data;
      _error = response.error;
    });
  }

  Future<void> _deleteSession(int sessionId) async {
    ApiResponse<Null> response = await _sessionService.deleteV2(
      eventId: widget.eventId,
      sessionId: sessionId,
    );
    if (response.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.error!),
        ),
      );
    } else {
      _fetchEvent();
    }
  }

  void _showConfirmationDialog(BuildContext context, int sessionId) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this item?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                _deleteSession(sessionId);
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
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
                    Text(
                      "Movie : ${_event!.movie.title}",
                      style: const TextStyle(
                        color: ThemeColor.white,
                      ),
                    ),
                    Text(
                      "Cinema : ${_event!.cinema.name}",
                      style: const TextStyle(
                        color: ThemeColor.white,
                      ),
                    ),
                    Text(
                      "Address : ${_event!.cinema.address.address}",
                      style: const TextStyle(
                        color: ThemeColor.white,
                      ),
                    ),
                    // MapView(
                    //   latitude: _event!.cinema.address.latitude,
                    //   longitude: _event!.cinema.address.longitude,
                    // ),
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
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _showConfirmationDialog(
                              context,
                              session.id,
                            ),
                          ),
                        );
                      },
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        context.push(
                          AdminRoutes.adminEventSessionCreate,
                          extra: {
                            "eventId": _event!.id,
                          },
                        );
                      },
                      child: const Text("Add session"),
                    ),
                  ],
                ),
    );
  }
}
