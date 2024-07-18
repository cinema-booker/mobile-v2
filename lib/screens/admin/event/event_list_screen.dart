import 'package:cinema_booker/features/event/data/event_list_response.dart';
import 'package:cinema_booker/features/event/services/event_service.dart';
import 'package:cinema_booker/router/admin_routes.dart';
import 'package:cinema_booker/theme/theme_color.dart';
import 'package:cinema_booker/widgets/infinite_list_v2.dart';
import 'package:cinema_booker/widgets/screen_list.dart';
import 'package:cinema_booker/widgets/search_input.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EventListScreen extends StatefulWidget {
  const EventListScreen({super.key});

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  Key _key = UniqueKey();
  String _search = '';

  final EventService _eventService = EventService();

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
        title: const Text('Event List'),
        actions: [
          IconButton(
            onPressed: () async {
              await context.push(AdminRoutes.adminEventCreate);
              _key = UniqueKey();
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchInput(
            onChanged: _updateSearch,
          ),
          Expanded(
            child: InfiniteList<EventListItem>(
              key: _key,
              builder: (context, item) {
                EventListItem event = item;
                return ListTile(
                  leading: const Icon(Icons.theaters),
                  title: Text(
                    "Cinema : ${event.cinema.name}",
                    style: const TextStyle(
                      color: ThemeColor.white,
                    ),
                  ),
                  subtitle: Text(
                    "Movie : ${event.movie.title}",
                    style: const TextStyle(
                      color: ThemeColor.white,
                    ),
                  ),
                  onTap: () => context.push(
                    AdminRoutes.adminEventDetails,
                    extra: {
                      "eventId": event.id,
                    },
                  ),
                );
              },
              fetch: (BuildContext context, int page, int limit) async {
                return await _eventService.listV2(
                  page: page,
                  limit: limit,
                  search: _search,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
