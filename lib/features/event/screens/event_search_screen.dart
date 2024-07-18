import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/features/event/data/event_list_response.dart';
import 'package:cinema_booker/features/event/services/event_service.dart';
import 'package:cinema_booker/router/app_router.dart';
import 'package:cinema_booker/widgets/infinite_list_v2.dart';
import 'package:cinema_booker/widgets/search_input.dart';
import 'package:flutter/material.dart';

import 'package:cinema_booker/theme/theme_color.dart';
import 'package:cinema_booker/theme/theme_font.dart';
import 'package:go_router/go_router.dart';

class EventSearchScreen extends StatefulWidget {
  const EventSearchScreen({super.key});

  @override
  State<EventSearchScreen> createState() => _EventSearchScreenState();
}

class _EventSearchScreenState extends State<EventSearchScreen> {
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
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Event List",
              style: TextStyle(
                fontSize: ThemeFontSize.s32,
                color: ThemeColor.white,
              ),
            ),
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
                    onTap: () async {
                      await context.pushNamed(
                        AppRouter.eventDetails,
                        extra: {
                          "eventId": event.id,
                        },
                      );
                    },
                  );
                },
                fetch: (BuildContext context, int page, int limit) async {
                  ApiResponse<List<EventListItem>> response =
                      await _eventService.listV2(
                    page: page,
                    limit: limit,
                    search: _search,
                  );
                  return response;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
