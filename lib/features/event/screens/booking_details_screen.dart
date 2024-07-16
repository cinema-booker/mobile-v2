import 'package:cinema_booker/features/event/data/booking_list_response.dart';
import 'package:cinema_booker/features/event/services/booking_service.dart';
import 'package:flutter/material.dart';

import 'package:cinema_booker/theme/theme_color.dart';
import 'package:cinema_booker/theme/theme_font.dart';

class BookingDetailsScreen extends StatefulWidget {
  final int bookingId;

  const BookingDetailsScreen({
    super.key,
    required this.bookingId,
  });

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  BookingListItem? _booking;
  final BookingService _bookingService = BookingService();

  @override
  void initState() {
    super.initState();

    _fetchBooking();
  }

  void _fetchBooking() async {
    BookingListItem? booking = await _bookingService.details(
      context: context,
      bookingId: widget.bookingId,
    );

    setState(() {
      _booking = booking;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Booking Details",
              style: TextStyle(
                fontSize: ThemeFontSize.s32,
                color: ThemeColor.white,
              ),
            ),
            _booking == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Cinema : ${_booking!.session.event.cinema.name}",
                        style: const TextStyle(
                          color: ThemeColor.white,
                        ),
                      ),
                      Text(
                        "Movie : ${_booking!.session.event.movie.title}",
                        style: const TextStyle(
                          color: ThemeColor.white,
                        ),
                      ),
                      Text(
                        "Room : ${_booking!.session.room.number}",
                        style: const TextStyle(
                          color: ThemeColor.white,
                        ),
                      ),
                      Text(
                        "Seat : ${_booking!.place}",
                        style: const TextStyle(
                          color: ThemeColor.white,
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
