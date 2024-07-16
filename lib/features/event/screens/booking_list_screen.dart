import 'package:cinema_booker/features/event/data/booking_list_response.dart';
import 'package:cinema_booker/features/event/services/booking_service.dart';
import 'package:cinema_booker/router/app_router.dart';
import 'package:flutter/material.dart';

import 'package:cinema_booker/theme/theme_color.dart';
import 'package:cinema_booker/theme/theme_font.dart';
import 'package:go_router/go_router.dart';

class BookingListScreen extends StatefulWidget {
  const BookingListScreen({super.key});

  @override
  State<BookingListScreen> createState() => _BookingListScreenState();
}

class _BookingListScreenState extends State<BookingListScreen> {
  List<BookingListItem> _bookings = [];
  int _page = 1;
  bool _hasMore = true;
  bool _isLoading = false;

  final BookingService _bookingService = BookingService();
  final ScrollController _scrollController = ScrollController();
  final int _limit = 10;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _refetchEvents();
      }
    });
    _fetchEvents();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _fetchEvents() async {
    if (_isLoading) return;
    _isLoading = true;

    setState(() {
      _bookings = [];
      _page = 1;
    });
    List<BookingListItem> bookings = await _bookingService.list(
      context: context,
      page: 1,
      limit: _limit,
    );
    setState(() {
      _bookings = bookings;
      _page++;
      _isLoading = false;
      if (bookings.length < _limit) {
        _hasMore = false;
      }
    });
  }

  void _refetchEvents() async {
    List<BookingListItem> bookings = await _bookingService.list(
      context: context,
      page: _page,
      limit: _limit,
    );
    setState(() {
      _bookings.addAll(bookings);
      _page++;
      if (bookings.length < _limit) {
        _hasMore = false;
      }
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
              "Booking List",
              style: TextStyle(
                fontSize: ThemeFontSize.s32,
                color: ThemeColor.white,
              ),
            ),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : RefreshIndicator(
                      onRefresh: () async {
                        _fetchEvents();
                      },
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: _bookings.length + 1,
                        itemBuilder: (context, index) {
                          if (index == _bookings.length) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                              child: Center(
                                child: _hasMore
                                    ? const CircularProgressIndicator()
                                    : const Text(
                                        'No more data to load',
                                        style: TextStyle(
                                          color: ThemeColor.white,
                                        ),
                                      ),
                              ),
                            );
                          }

                          BookingListItem booking = _bookings[index];
                          return ListTile(
                            leading: const Icon(Icons.theaters),
                            title: Text(
                              "Cinema : ${booking.session.event.cinema.name} - Movie : ${booking.session.event.movie.title}",
                              style: const TextStyle(
                                color: ThemeColor.white,
                              ),
                            ),
                            subtitle: Text(
                              "Room : ${booking.session.room.number} - Seat : ${booking.place}",
                              style: const TextStyle(
                                color: ThemeColor.white,
                              ),
                            ),
                            onTap: () => context.pushNamed(
                              AppRouter.bookingDetails,
                              extra: {
                                "bookingId": booking.id,
                              },
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
