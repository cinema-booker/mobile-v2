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
    return Column(
      children: generateSeats(widget.room.type).map((seat) {
        return Opacity(
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
        );
      }).toList(),
    );
  }
}
