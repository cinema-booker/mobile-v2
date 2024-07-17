// ignore_for_file: use_build_context_synchronously

import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/features/cinema/data/cinema_details_response.dart';
import 'package:cinema_booker/features/cinema/services/cinema_service.dart';
import 'package:cinema_booker/theme/theme_color.dart';
import 'package:cinema_booker/theme/theme_font.dart';
import 'package:cinema_booker/widgets/screen.dart';
import 'package:flutter/material.dart';

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
  String? _error;

  final CinemaService _cinemaService = CinemaService();

  @override
  void initState() {
    super.initState();

    _fetchCinema();
  }

  Future<void> _fetchCinema() async {
    ApiResponse<CinemaDetailsResponse> response =
        await _cinemaService.detailsV2(
      cinemaId: widget.cinemaId,
    );

    setState(() {
      _cinema = response.data;
      _error = response.error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(
        title: const Text('Cinema Details'),
      ),
      child: (_cinema == null && _error == null)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _error != null
              ? Text(
                  _error!,
                  style: const TextStyle(
                    color: ThemeColor.white,
                  ),
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
                    // MapView(
                    //   latitude: _cinema!.address.latitude,
                    //   longitude: _cinema!.address.longitude,
                    // ),
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
                  ],
                ),
    );
  }
}
