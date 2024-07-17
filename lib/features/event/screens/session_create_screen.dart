import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/features/event/services/session_service.dart';
import 'package:cinema_booker/widgets/date_time_input.dart';
import 'package:flutter/material.dart';

import 'package:cinema_booker/theme/theme_color.dart';
import 'package:cinema_booker/theme/theme_font.dart';
import 'package:cinema_booker/widgets/text_input.dart';
import 'package:go_router/go_router.dart';

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

  Future<void> _createSession() async {
    if (_formKey.currentState!.validate()) {
      ApiResponse<Null> response = await _sessionService.createV2(
        eventId: widget.eventId,
        roomId: 1,
        price: int.parse(_priceController.text),
        startsAt: DateTime.parse(_startsAtController.text),
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
            content: Text("Session created"),
          ),
        );
        // ignore: use_build_context_synchronously
        context.pop();
      }
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
