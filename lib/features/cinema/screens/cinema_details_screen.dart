import 'package:cinema_booker/api/api_response.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:cinema_booker/theme/theme_color.dart';
import 'package:cinema_booker/theme/theme_font.dart';
import 'package:cinema_booker/router/app_router.dart';
import 'package:cinema_booker/features/cinema/services/cinema_service.dart';
import 'package:cinema_booker/features/cinema/data/cinema_details_response.dart';
import 'package:cinema_booker/features/cinema/services/room_service.dart';

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
  Key _key = UniqueKey();

  CinemaDetailsResponse? _cinema;
  String? _error;

  final CinemaService _cinemaService = CinemaService();
  final RoomService _roomService = RoomService();

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

  Future<void> _deleteRoom(int roomId) async {
    ApiResponse<Null> response = await _roomService.deleteV2(
      cinemaId: widget.cinemaId,
      roomId: roomId,
    );
    if (response.error != null) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.error!),
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Room deleted successfully"),
        ),
      );
      _fetchCinema();
    }
  }

  void _refreshList() {
    setState(() {
      _key = UniqueKey();
    });
  }

  void _showConfirmationDialog(BuildContext context, int roomId) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this item?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                _deleteRoom(roomId);
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
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
            (_cinema == null && _error == null)
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
                            key: _key,
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
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => _showConfirmationDialog(
                                    context,
                                    room.id,
                                  ),
                                ),
                              );
                            },
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await context.pushNamed(
                                AppRouter.roomCreate,
                                extra: {
                                  "cinemaId": _cinema!.id,
                                },
                              );
                              _refreshList();
                            },
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
