import 'package:cinema_booker/router/app_router.dart';
import 'package:cinema_booker/widgets/infinite_list.dart';
import 'package:cinema_booker/widgets/search_input.dart';
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
  Key _key = UniqueKey();
  String _search = '';

  final CinemaService _cinemaService = CinemaService();

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
              "Cinema List",
              style: TextStyle(
                fontSize: ThemeFontSize.s32,
                color: ThemeColor.white,
              ),
            ),
            Text(
              _search,
              style: const TextStyle(
                color: ThemeColor.white,
              ),
            ),
            SearchInput(
              onChanged: _updateSearch,
            ),
            Expanded(
              child: InfiniteList<CinemaListItem>(
                key: _key,
                builder: (context, item) {
                  CinemaListItem cinema = item;
                  return ListTile(
                    title: Text(
                      cinema.name,
                      style: const TextStyle(
                        color: ThemeColor.white,
                      ),
                    ),
                    subtitle: Text(
                      cinema.address.address,
                      style: const TextStyle(
                        color: ThemeColor.gray,
                      ),
                    ),
                    onTap: () {
                      context.pushNamed(
                        AppRouter.cinemaDetails,
                        extra: {
                          "cinemaId": cinema.id,
                        },
                      );
                    },
                  );
                },
                fetch: (BuildContext context, int page, int limit) async {
                  List<CinemaListItem> cinemas = await _cinemaService.list(
                    context: context,
                    page: page,
                    limit: limit,
                    search: _search,
                  );
                  return cinemas;
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
