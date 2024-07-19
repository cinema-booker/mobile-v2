// ignore_for_file: use_build_context_synchronously

import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/widgets/button.dart';
import 'package:cinema_booker/services/session_service.dart';
import 'package:cinema_booker/widgets/date_time_input.dart';
import 'package:cinema_booker/widgets/screen.dart';
import 'package:cinema_booker/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SessionCreateScreen extends StatefulWidget {
  final int eventId;
  final int cinemaId; // TODO: use it to populate rooms select

  const SessionCreateScreen({
    super.key,
    required this.eventId,
    required this.cinemaId,
  });

  @override
  State<SessionCreateScreen> createState() => _SessionCreateScreenState();
}

class _SessionCreateScreenState extends State<SessionCreateScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _roomIdController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _startsAtController = TextEditingController();

  final SessionService _sessionService = SessionService();

  @override
  void dispose() {
    _priceController.dispose();
    _startsAtController.dispose();

    super.dispose();
  }

  Future<void> _createSession() async {
    if (_formKey.currentState!.validate()) {
      ApiResponse<Null> response = await _sessionService.create(
        eventId: widget.eventId,
        roomId: int.parse(_roomIdController.text),
        price: int.parse(_priceController.text),
        startsAt: DateTime.parse(_startsAtController.text),
      );

      if (response.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.error!),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Session created successfully"),
          ),
        );

        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(
        title: const Text('Session Create'),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextInput(
              hint: "Room Id",
              controller: _roomIdController,
              keyboardType: TextInputType.number,
            ),
            TextInput(
              hint: "Price",
              controller: _priceController,
              keyboardType: TextInputType.number,
            ),
            DateTimeInput(controller: _startsAtController),
            Button(
              onPressed: _createSession,
              label: 'Create Session',
            ),
          ],
        ),
      ),
    );
  }
}
