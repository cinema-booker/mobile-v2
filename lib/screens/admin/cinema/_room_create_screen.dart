// ignore_for_file: use_build_context_synchronously

import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/widgets/button.dart';
import 'package:cinema_booker/services/room_service.dart';
import 'package:cinema_booker/widgets/screen.dart';
import 'package:cinema_booker/widgets/text_input.dart';
import 'package:flutter/material.dart';
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
      ApiResponse<Null> response = await _roomService.create(
        cinemaId: widget.cinemaId,
        number: _numberController.text,
        type: _typeController.text,
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
            content: Text("Room created successfully"),
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
        title: const Text('Room Create'),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Button(
              onPressed: _createRoom,
              label: 'Create Room',
            ),
          ],
        ),
      ),
    );
  }
}
