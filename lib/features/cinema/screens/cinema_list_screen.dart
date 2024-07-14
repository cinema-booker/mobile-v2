import 'package:cinema_booker/router/app_router.dart';
import 'package:flutter/material.dart';

import 'package:cinema_booker/theme/theme_color.dart';
import 'package:cinema_booker/theme/theme_font.dart';
import 'package:cinema_booker/features/cinema/data/cinema_list_response.dart';
import 'package:cinema_booker/features/cinema/services/cinema_service.dart';
import 'package:go_router/go_router.dart';

class CinemaListScreen extends StatefulWidget {
  const CinemaListScreen({super.key});

  @override
  State<CinemaListScreen> createState() => _CinemaListScreenState();
}

class _CinemaListScreenState extends State<CinemaListScreen> {
  List<CinemaListItem> _cinemas = [];
  int _page = 1;
  bool _hasMore = true;
  bool _isLoading = false;

  final CinemaService _cinemaService = CinemaService();
  final ScrollController _scrollController = ScrollController();
  final int _limit = 10;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _refetchCinemas();
      }
    });
    _fetchCinemas();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _fetchCinemas() async {
    if (_isLoading) return;
    _isLoading = true;

    setState(() {
      _cinemas = [];
      _page = 1;
    });
    List<CinemaListItem> cinemas = await _cinemaService.list(
      context: context,
      page: 1,
      limit: _limit,
    );
    setState(() {
      _cinemas = cinemas;
      _page++;
      _isLoading = false;
      if (cinemas.length < _limit) {
        _hasMore = false;
      }
    });
  }

  void _refetchCinemas() async {
    List<CinemaListItem> cinemas = await _cinemaService.list(
      context: context,
      page: _page,
      limit: _limit,
    );
    setState(() {
      _cinemas.addAll(cinemas);
      _page++;
      if (cinemas.length < _limit) {
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
              "Cinema List",
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
                        _fetchCinemas();
                      },
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: _cinemas.length + 1,
                        itemBuilder: (context, index) {
                          if (index == _cinemas.length) {
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

                          CinemaListItem cinema = _cinemas[index];
                          return ListTile(
                            leading: const Icon(Icons.theaters),
                            title: Text(
                              cinema.name,
                              style: const TextStyle(
                                color: ThemeColor.white,
                              ),
                            ),
                            subtitle: Text(
                              cinema.description,
                              style: const TextStyle(
                                color: ThemeColor.white,
                              ),
                            ),
                            onTap: () => context.pushNamed(
                              AppRouter.cinemaDetails,
                              extra: {
                                "cinemaId": cinema.id,
                              },
                            ),
                          );
                        },
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
