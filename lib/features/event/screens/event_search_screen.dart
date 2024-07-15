import 'package:cinema_booker/features/event/data/event_list_response.dart';
import 'package:cinema_booker/features/event/services/event_service.dart';
import 'package:cinema_booker/router/app_router.dart';
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
  List<EventListItem> _events = [];
  int _page = 1;
  bool _hasMore = true;
  bool _isLoading = false;

  final EventService _eventService = EventService();
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
      _events = [];
      _page = 1;
    });
    List<EventListItem> events = await _eventService.list(
      context: context,
      page: 1,
      limit: _limit,
    );
    setState(() {
      _events = events;
      _page++;
      _isLoading = false;
      if (events.length < _limit) {
        _hasMore = false;
      }
    });
  }

  void _refetchEvents() async {
    List<EventListItem> events = await _eventService.list(
      context: context,
      page: _page,
      limit: _limit,
    );
    setState(() {
      _events.addAll(events);
      _page++;
      if (events.length < _limit) {
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
              "Event Search",
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
                        itemCount: _events.length + 1,
                        itemBuilder: (context, index) {
                          if (index == _events.length) {
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

                          EventListItem event = _events[index];
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
                            onTap: () => context.pushNamed(
                              AppRouter.eventDetails,
                              extra: {
                                "eventId": event.id,
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
