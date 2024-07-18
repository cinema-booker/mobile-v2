// ignore_for_file: use_build_context_synchronously

import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/core/button.dart';
import 'package:cinema_booker/features/cinema/data/cinema_details_response.dart';
import 'package:cinema_booker/features/cinema/services/cinema_service.dart';
import 'package:cinema_booker/theme/theme_color.dart';
import 'package:cinema_booker/widgets/screen.dart';
import 'package:cinema_booker/core/text_input.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CinemaEditScreen extends StatefulWidget {
  final int cinemaId;

  const CinemaEditScreen({
    super.key,
    required this.cinemaId,
  });

  @override
  State<CinemaEditScreen> createState() => _CinemaEditScreenState();
}

class _CinemaEditScreenState extends State<CinemaEditScreen> {
  CinemaDetailsResponse? _cinema;
  String? _error;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final CinemaService _cinemaService = CinemaService();

  @override
  void initState() {
    super.initState();

    _fetchCinema();
  }

  @override
  void dispose() {
    _nameController.dispose();

    super.dispose();
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

  void _editCinema() async {
    if (_formKey.currentState!.validate()) {
      ApiResponse<Null> response = await _cinemaService.editV2(
        cinemaId: widget.cinemaId,
        name: _nameController.text,
        description: _descriptionController.text,
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
            content: Text("Cinema updated successfully"),
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
        title: const Text('Cinema Edit'),
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
              : Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextInput(
                        hint: "Name",
                        controller: _nameController,
                        keyboardType: TextInputType.text,
                        defaultValue: _cinema!.name,
                      ),
                      TextInput(
                        hint: "Description",
                        controller: _descriptionController,
                        keyboardType: TextInputType.text,
                        defaultValue: _cinema!.description,
                      ),
                      Button(
                        onPressed: _editCinema,
                        label: 'Save',
                      ),
                    ],
                  ),
                ),
    );
  }
}
