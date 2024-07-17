import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/features/event/data/booking_create_response.dart';
import 'package:cinema_booker/features/event/data/booking_session.dart';
import 'package:cinema_booker/features/event/data/event_details_response.dart';
import 'package:cinema_booker/features/event/services/booking_service.dart';
import 'package:cinema_booker/features/event/services/event_service.dart';
import 'package:cinema_booker/features/event/services/stripe_service.dart';
import 'package:cinema_booker/features/event/widgets/seat_checkbox_group.dart';
import 'package:cinema_booker/features/event/widgets/session_checkbox_group.dart';
import 'package:flutter/material.dart';

import 'package:cinema_booker/theme/theme_color.dart';
import 'package:cinema_booker/theme/theme_font.dart';

class EventBookingScreen extends StatefulWidget {
  final int eventId;

  const EventBookingScreen({
    super.key,
    required this.eventId,
  });

  @override
  State<EventBookingScreen> createState() => _EventBookingScreenState();
}

class _EventBookingScreenState extends State<EventBookingScreen> {
  EventDetailsResponse? _event;
  String? _error;

  final EventService _eventService = EventService();
  final BookingService _bookingService = BookingService();

  BookingSession? _selectedSession;
  List<String> _selectedSeats = [];

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

  Future<void> _bookEvent(BuildContext context) async {
    if (_selectedSession != null || !_selectedSeats.isEmpty) {
      ApiResponse<BookingCreateResponse> response =
          await _bookingService.createV2(
        sessionId: _selectedSession!.id,
        seats: _selectedSeats,
      );

      if (response.data != null && response.error != null) {
        await StripeService.stripePaymentCheckout(
          response.data!.sessionId,
          response.data!.seats,
          response.data!.price,
          // ignore: use_build_context_synchronously
          context,
          true,
          onSuccess: () {
            // ignore: avoid_print
            print('Success');
          },
          onCancel: () {
            // ignore: avoid_print
            print('Cancel');
          },
          onError: (error) {
            // ignore: avoid_print
            print(
              'Error : ${error.toString()}',
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Event Booking",
                style: TextStyle(
                  fontSize: ThemeFontSize.s32,
                  color: ThemeColor.white,
                ),
              ),
              (_event == null && _error == null)
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
                            SessionCheckboxGroup(
                              sessions: _event!.sessions,
                              onChanged: (session) {
                                setState(() {
                                  _selectedSession = session;
                                });
                              },
                            ),
                            _selectedSession == null
                                ? const SizedBox()
                                : SeatCheckboxGroup(
                                    bookedSeats: _selectedSession!.seats,
                                    room: _selectedSession!.room,
                                    onChanged: (seats) {
                                      setState(() {
                                        _selectedSeats = seats;
                                      });
                                    },
                                  ),
                            Text(
                              'Total Price: ${_selectedSeats.length * (_selectedSession?.priceInEuro ?? 0)} €',
                              style: const TextStyle(
                                fontSize: ThemeFontSize.s18,
                                color: ThemeColor.white,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _bookEvent(context);
                              },
                              child: const Text('Book'),
                            ),
                          ],
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
