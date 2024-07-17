import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/features/cinema/services/room_service.dart';
import 'package:flutter/material.dart';

import 'package:cinema_booker/theme/theme_color.dart';
import 'package:cinema_booker/theme/theme_font.dart';
import 'package:cinema_booker/widgets/text_input.dart';
import 'package:go_router/go_router.dart';

class RoomCreateScreen extends StatefulWidget {
  final int cinemaId;

  const RoomCreateScreen({
    super.key,
    required this.cinemaId,
  });

  @override
  State<RoomCreateScreen> createState() => _RoomCreateScreenState();
}

class _RoomCreateScreenState extends State<RoomCreateScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();

  final RoomService _roomService = RoomService();

  @override
  void dispose() {
    _numberController.dispose();
    _typeController.dispose();
    super.dispose();
  }

  Future<void> _createRoom() async {
    if (_formKey.currentState!.validate()) {
      ApiResponse<Null> response = await _roomService.createV2(
        cinemaId: widget.cinemaId,
        number: _numberController.text,
        type: _typeController.text,
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
            content: Text("Room created"),
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
                "Create Room",
                style: TextStyle(
                  fontSize: ThemeFontSize.s32,
                  color: ThemeColor.white,
                ),
              ),
              TextInput(
                hint: "Number",
                controller: _numberController,
                keyboardType: TextInputType.text,
              ),
              TextInput(
                hint: "Type",
                controller: _typeController,
                keyboardType: TextInputType.text,
              ),
              ElevatedButton(
                onPressed: _createRoom,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
