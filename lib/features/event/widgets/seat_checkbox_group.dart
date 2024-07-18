import 'package:cinema_booker/features/cinema/data/cinema_room.dart';
import 'package:cinema_booker/theme/theme_color.dart';
import 'package:flutter/material.dart';

class SeatCheckboxGroup extends StatefulWidget {
  final CinemaRoom room;
  final ValueChanged<List<String>> onChanged;
  final List<String> bookedSeats;

  const SeatCheckboxGroup({
    super.key,
    required this.room,
    required this.onChanged,
    required this.bookedSeats,
  });

  @override
  State<SeatCheckboxGroup> createState() => _SeatCheckboxGroupState();
}

class _SeatCheckboxGroupState extends State<SeatCheckboxGroup> {
  final List<String> _selectedSeats = [];

  List<String> generateSeats(String roomType) {
    int seatCount;
    String prefix;

    switch (roomType.toUpperCase()) {
      case 'SMALL':
        seatCount = 10;
        prefix = 'S';
        break;
      case 'MEDIUM':
        seatCount = 15;
        prefix = 'M';
        break;
      case 'LARGE':
        seatCount = 20;
        prefix = 'L';
        break;
      default:
        throw ArgumentError('Invalid room type. Use SMALL, MEDIUM, or LARGE.');
    }

    return List.generate(seatCount, (index) {
      return '$prefix${(index + 1).toString().padLeft(2, '0')}';
    });
  }

  @override
  Widget build(BuildContext context) {
    final seats = generateSeats(widget.room.type);
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: double.infinity,
            height: 10,
            color: ThemeColor.brown100,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Column(
          children: List.generate((seats.length / 5).ceil(), (rowIndex) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (colIndex) {
                final seatIndex = rowIndex * 4 + colIndex;
                if (seatIndex >= seats.length) {
                  return const SizedBox(
                    width: 60,
                    height: 60,
                  );
                }
                final seat = seats[seatIndex];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Opacity(
                    opacity: widget.bookedSeats.contains(seat) ? 0.5 : 1.0,
                    child: TextButton(
                      onPressed: () {
                        if (widget.bookedSeats.contains(seat)) {
                          return;
                        }
                        setState(() {
                          if (_selectedSeats.contains(seat)) {
                            _selectedSeats.remove(seat);
                          } else {
                            _selectedSeats.add(seat);
                          }
                        });
                        widget.onChanged(_selectedSeats);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          _selectedSeats.contains(seat)
                              ? ThemeColor.white
                              : ThemeColor.brown100,
                        ),
                        fixedSize: MaterialStateProperty.all<Size>(
                          const Size(40, 40), // Fixed size for each seat button
                        ),
                      ),
                      child: Text(
                        seat,
                        style: TextStyle(
                          color: _selectedSeats.contains(seat)
                              ? ThemeColor.black
                              : ThemeColor.white,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            );
          }),
        )
      ],
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Column(
  //     children: generateSeats(widget.room.type).map((seat) {
  //       return Opacity(
  //         opacity: widget.bookedSeats.contains(seat) ? 0.5 : 1.0,
  //         child: TextButton(
  //           onPressed: () {
  //             if (widget.bookedSeats.contains(seat)) {
  //               return;
  //             }
  //             setState(() {
  //               if (_selectedSeats.contains(seat)) {
  //                 _selectedSeats.remove(seat);
  //               } else {
  //                 _selectedSeats.add(seat);
  //               }
  //             });
  //             widget.onChanged(_selectedSeats);
  //           },
  //           style: ButtonStyle(
  //             backgroundColor: MaterialStateProperty.all<Color>(
  //               _selectedSeats.contains(seat)
  //                   ? ThemeColor.white
  //                   : ThemeColor.brown100,
  //             ),
  //           ),
  //           child: Text(
  //             seat,
  //             style: TextStyle(
  //               color: _selectedSeats.contains(seat)
  //                   ? ThemeColor.black
  //                   : ThemeColor.white,
  //             ),
  //           ),
  //         ),
  //       );
  //     }).toList(),
  //   );
  // }
}
