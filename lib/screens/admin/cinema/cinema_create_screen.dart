// ignore_for_file: use_build_context_synchronously

import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/widgets/button.dart';
import 'package:cinema_booker/data/places_autocomplete_prediction.dart';
import 'package:cinema_booker/data/places_geocoding_response.dart';
import 'package:cinema_booker/services/cinema_service.dart';
import 'package:cinema_booker/services/places_service.dart';
import 'package:cinema_booker/widgets/address_autocomplete.dart';
import 'package:cinema_booker/widgets/screen.dart';
import 'package:cinema_booker/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CinemaCreateScreen extends StatefulWidget {
  const CinemaCreateScreen({super.key});

  @override
  State<CinemaCreateScreen> createState() => _CinemaCreateScreenState();
}

class _CinemaCreateScreenState extends State<CinemaCreateScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final PlacesService _placesService = PlacesService();
  final CinemaService _cinemaService = CinemaService();

  // ignore: unused_field
  String _address = '';
  // ignore: unused_field
  double _longitude = 0.0;
  // ignore: unused_field
  double _latitude = 0.0;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _createCinema() async {
    if (_formKey.currentState!.validate() &&
        _longitude != 0.0 &&
        _latitude != 0.0 &&
        _address.isNotEmpty) {
      ApiResponse<Null> resonse = await _cinemaService.create(
        name: _nameController.text,
        description: _descriptionController.text,
        address: _address,
        longitude: _longitude,
        latitude: _latitude,
      );
      if (resonse.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(resonse.error!),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cinema created successfully'),
          ),
        );

        context.pop();
      }
    }
  }

  void _getLongitudeLatitude(String placeId) async {
    PlacesGeocodingResponse response =
        await _placesService.getGeocoding(placeId: placeId);
    setState(() {
      _longitude = response.longitude;
      _latitude = response.latitude;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(
        title: const Text('Cinema Create'),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextInput(
              hint: "Name",
              controller: _nameController,
              keyboardType: TextInputType.text,
            ),
            AddressAutocomplete(
              onSelected: (PlacesAutoCompletePrediction prediction) {
                _getLongitudeLatitude(prediction.placeId);
                setState(() {
                  _address = prediction.description;
                });
              },
              onClear: () {
                setState(() {
                  _address = '';
                  _longitude = 0.0;
                  _latitude = 0.0;
                });
              },
            ),
            TextInput(
              hint: "Description",
              controller: _descriptionController,
              keyboardType: TextInputType.multiline,
            ),
            Button(
              onPressed: _createCinema,
              label: 'Create Cinema',
            ),
          ],
        ),
      ),
    );
  }
}
