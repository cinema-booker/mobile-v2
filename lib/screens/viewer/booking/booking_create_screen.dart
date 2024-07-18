// ignore_for_file: use_build_context_synchronously

import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/core/button.dart';
import 'package:cinema_booker/features/event/data/booking_create_response.dart';
import 'package:cinema_booker/features/event/data/booking_session.dart';
import 'package:cinema_booker/features/event/data/event_details_response.dart';
import 'package:cinema_booker/features/event/services/booking_service.dart';
import 'package:cinema_booker/features/event/services/event_service.dart';
import 'package:cinema_booker/features/event/services/stripe_service.dart';
import 'package:cinema_booker/features/event/widgets/seat_checkbox_group.dart';
import 'package:cinema_booker/features/event/widgets/session_checkbox_group.dart';
import 'package:cinema_booker/theme/theme_color.dart';
import 'package:cinema_booker/theme/theme_font.dart';
import 'package:cinema_booker/widgets/screen.dart';
import 'package:flutter/material.dart';

class BookingCreateScreen extends StatefulWidget {
  final int eventId;

  const BookingCreateScreen({
    super.key,
    required this.eventId,
  });

  @override
  State<BookingCreateScreen> createState() => _BookingCreateScreenState();
}

class _BookingCreateScreenState extends State<BookingCreateScreen> {
  EventDetailsResponse? _event;
  String? _error;
  BookingSession? _selectedSession;
  List<String> _selectedSeats = [];

  final EventService _eventService = EventService();
  final BookingService _bookingService = BookingService();

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
    if (_selectedSession != null || _selectedSeats.isNotEmpty) {
      ApiResponse<BookingCreateResponse> response =
          await _bookingService.createV2(
        sessionId: _selectedSession!.id,
        seats: _selectedSeats,
      );

      if (response.data != null && response.error == null) {
        await StripeService.stripePaymentCheckout(
          response.data!.sessionId,
          response.data!.seats,
          response.data!.price,
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
    return Screen(
      appBar: AppBar(
        title: const Text('Booking Create'),
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
                    const Text(
                      "Choose a session",
                      style: TextStyle(
                        color: ThemeColor.gray,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SessionCheckboxGroup(
                      sessions: _event!.sessions,
                      onChanged: (session) {
                        setState(() {
                          _selectedSession = session;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    _selectedSession == null
                        ? const SizedBox()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _selectedSession!.startsAt.toString(),
                                style: const TextStyle(
                                  color: ThemeColor.gray,
                                ),
                              ),
                              const SizedBox(height: 16),
                              SeatCheckboxGroup(
                                bookedSeats: _selectedSession!.seats,
                                room: _selectedSession!.room,
                                onChanged: (seats) {
                                  setState(() {
                                    _selectedSeats = seats;
                                  });
                                },
                              ),
                              const SizedBox(height: 30),
                              Text(
                                'Total Price : ${_selectedSeats.length * (_selectedSession?.price ?? 0)} €',
                                style: const TextStyle(
                                  color: ThemeColor.gray,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Button(
                                onPressed: () {
                                  _bookEvent(context);
                                },
                                label: 'Pay Now',
                              )
                            ],
                          ),
                  ],
                ),
    );
  }
}
