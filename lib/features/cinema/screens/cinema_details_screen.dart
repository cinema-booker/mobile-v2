import 'package:flutter/material.dart';

import 'package:cinema_booker/theme/theme_color.dart';
import 'package:cinema_booker/theme/theme_font.dart';
import 'package:cinema_booker/features/cinema/widgets/map_view.dart';
import 'package:cinema_booker/features/cinema/services/cinema_service.dart';
import 'package:cinema_booker/features/cinema/data/cinema_details_response.dart';

const String mapBoxStyleDarkId = 'mapbox/dark-v11';

class CinemaDetailsScreen extends StatefulWidget {
  final int cinemaId;

  const CinemaDetailsScreen({
    super.key,
    required this.cinemaId,
  });

  @override
  State<CinemaDetailsScreen> createState() => _CinemaDetailsScreenState();
}

class _CinemaDetailsScreenState extends State<CinemaDetailsScreen> {
  CinemaDetailsResponse? _cinema;

  final CinemaService _cinemaService = CinemaService();

  @override
  void initState() {
    super.initState();
    _fetchCinema();
  }

  void _fetchCinema() async {
    CinemaDetailsResponse? cinema = await _cinemaService.details(
      context: context,
      cinemaId: widget.cinemaId,
    );

    setState(() {
      _cinema = cinema;
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
              "Cinema Details",
              style: TextStyle(
                fontSize: ThemeFontSize.s32,
                color: ThemeColor.white,
              ),
            ),
            _cinema == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name: ${_cinema!.name}",
                        style: const TextStyle(
                          color: ThemeColor.white,
                        ),
                      ),
                      Text(
                        "Description: ${_cinema!.description}",
                        style: const TextStyle(
                          color: ThemeColor.white,
                        ),
                      ),
                      Text(
                        "Address: ${_cinema!.address.address}",
                        style: const TextStyle(
                          color: ThemeColor.white,
                        ),
                      ),
                      MapView(
                        latitude: _cinema!.address.latitude,
                        longitude: _cinema!.address.longitude,
                      ),
                      const Text(
                        "Rooms",
                        style: TextStyle(
                          fontSize: ThemeFontSize.s20,
                          color: ThemeColor.white,
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: _cinema!.rooms.length,
                        itemBuilder: (context, index) {
                          final room = _cinema!.rooms[index];
                          return ListTile(
                            title: Text(
                              room.number,
                              style: const TextStyle(
                                color: ThemeColor.white,
                              ),
                            ),
                            subtitle: Text(
                              room.type,
                              style: const TextStyle(
                                color: ThemeColor.gray,
                              ),
                            ),
                          );
                        },
                      ),
                      ElevatedButton(
                        onPressed: () => {},
                        child: const Text("Add room"),
                      )
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
