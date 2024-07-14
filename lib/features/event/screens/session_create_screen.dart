import 'package:cinema_booker/features/event/services/session_service.dart';
import 'package:cinema_booker/widgets/date_time_input.dart';
import 'package:flutter/material.dart';

import 'package:cinema_booker/theme/theme_color.dart';
import 'package:cinema_booker/theme/theme_font.dart';
import 'package:cinema_booker/widgets/text_input.dart';

class SessionCreateScreen extends StatefulWidget {
  final int eventId;

  const SessionCreateScreen({
    super.key,
    required this.eventId,
  });

  @override
  State<SessionCreateScreen> createState() => _SessionCreateScreenState();
}

class _SessionCreateScreenState extends State<SessionCreateScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _startsAtController = TextEditingController();

  final SessionService _sessionService = SessionService();

  @override
  void dispose() {
    _priceController.dispose();
    _startsAtController.dispose();

    super.dispose();
  }

  void _createSession() {
    if (_formKey.currentState!.validate()) {
      _sessionService.create(
        context: context,
        eventId: widget.eventId,
        roomId: 1,
        price: int.parse(_priceController.text),
        startsAt: DateTime.parse(_startsAtController.text),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Create Session",
                style: TextStyle(
                  fontSize: ThemeFontSize.s32,
                  color: ThemeColor.white,
                ),
              ),
              TextInput(
                hint: "Price",
                controller: _priceController,
                keyboardType: TextInputType.number,
              ),
              DateTimeInput(controller: _startsAtController),
              ElevatedButton(
                onPressed: _createSession,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
