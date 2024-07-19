import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/data/booking_list_response.dart';
import 'package:cinema_booker/services/booking_service.dart';
import 'package:cinema_booker/theme/theme_color.dart';
import 'package:cinema_booker/widgets/screen.dart';
import 'package:flutter/material.dart';

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
  String? _error;

  final BookingService _bookingService = BookingService();

  @override
  void initState() {
    super.initState();

    _fetchBooking();
  }

  void _fetchBooking() async {
    ApiResponse<BookingListItem> response = await _bookingService.details(
      bookingId: widget.bookingId,
    );

    setState(() {
      _booking = response.data;
      _error = response.error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(
        title: const Text('Booking Details'),
      ),
      child: (_booking == null && _error == null)
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
    );
  }
}
