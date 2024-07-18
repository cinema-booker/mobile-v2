import 'package:cinema_booker/features/event/data/booking_list_response.dart';
import 'package:cinema_booker/features/event/services/booking_service.dart';
import 'package:cinema_booker/router/admin_routes.dart';
import 'package:cinema_booker/theme/theme_color.dart';
import 'package:cinema_booker/widgets/infinite_list_v2.dart';
import 'package:cinema_booker/widgets/screen_list.dart';
import 'package:cinema_booker/widgets/search_input.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BookingListScreen extends StatefulWidget {
  const BookingListScreen({super.key});

  @override
  State<BookingListScreen> createState() => _BookingListScreenState();
}

class _BookingListScreenState extends State<BookingListScreen> {
  Key _key = UniqueKey();
  String _search = '';

  final BookingService _bookingService = BookingService();

  void _updateSearch(String search) {
    setState(() {
      _search = search;
      _key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenList(
      appBar: AppBar(
        title: const Text('Booking List'),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchInput(
            onChanged: _updateSearch,
          ),
          Expanded(
            child: InfiniteList<BookingListItem>(
              key: _key,
              builder: (context, item) {
                BookingListItem booking = item;
                return ListTile(
                  leading: const Icon(Icons.airplane_ticket),
                  title: Text(
                    "Movie : ${booking.session.event.movie.title}",
                    style: const TextStyle(
                      color: ThemeColor.white,
                    ),
                  ),
                  subtitle: Text(
                    "Room : ${booking.session.room.number} - Seat : ${booking.place}",
                    style: const TextStyle(
                      color: ThemeColor.gray,
                    ),
                  ),
                  onTap: () async {
                    await context.push(
                      AdminRoutes.adminBookingDetails,
                      extra: {
                        "bookingId": booking.id,
                      },
                    );
                  },
                );
              },
              fetch: (BuildContext context, int page, int limit) async {
                return await _bookingService.listV2(
                  page: page,
                  limit: limit,
                  search: _search,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
