import 'package:cinema_booker/features/event/data/event_session.dart';
import 'package:cinema_booker/theme/theme_color.dart';
import 'package:flutter/material.dart';

class SessionCheckboxGroup extends StatefulWidget {
  final List<EventSession> sessions;
  final ValueChanged<EventSession> onChanged;

  const SessionCheckboxGroup({
    super.key,
    required this.sessions,
    required this.onChanged,
  });

  @override
  State<SessionCheckboxGroup> createState() => _SessionCheckboxGroupState();
}

class _SessionCheckboxGroupState extends State<SessionCheckboxGroup> {
  EventSession? _selectedSession;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.sessions.map((session) {
        return TextButton(
          onPressed: () {
            setState(() {
              _selectedSession = session;
            });
            widget.onChanged(session);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              session.id == _selectedSession?.id
                  ? ThemeColor.white
                  : ThemeColor.brown100,
            ),
          ),
          child: Text(
            session.startsAt.toString(),
            style: TextStyle(
              color: session.id == _selectedSession?.id
                  ? ThemeColor.black
                  : ThemeColor.white,
            ),
          ),
        );
      }).toList(),
    );
  }
}
