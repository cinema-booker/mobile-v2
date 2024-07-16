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
    EventDetailsResponse? event = await _eventService.details(
      context: context,
      eventId: widget.eventId,
    );

    setState(() {
      _event = event;
    });
  }

  Future<void> _bookEvent(BuildContext context) async {
    if (_selectedSession == null || _selectedSeats.isEmpty) {
      return;
    }
    BookingCreateResponse? bookingCreateResponse = await _bookingService.create(
      context: context,
      sessionId: _selectedSession!.id,
      seats: _selectedSeats,
    );

    if (bookingCreateResponse != null) {
      await StripeService.stripePaymentCheckout(
        bookingCreateResponse.sessionId,
        bookingCreateResponse.seats,
        bookingCreateResponse.price,
        // ignore: use_build_context_synchronously
        context,
        true,
        onSuccess: () {
          print('Success');
        },
        onCancel: () {
          print('Cancel');
        },
        onError: (error) {
          print(
            'Error : ${error.toString()}',
          );
        },
      );
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
              _event == null
                  ? const Center(
                      child: CircularProgressIndicator(),
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
                        ElevatedButton(
                          onPressed: () async {
                            var items = ["S01", "S02"];
                          },
                          child: const Text('Pay'),
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
