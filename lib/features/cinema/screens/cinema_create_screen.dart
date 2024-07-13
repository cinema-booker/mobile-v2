import 'package:cinema_booker/features/cinema/services/cinema_service.dart';
import 'package:flutter/material.dart';

import 'package:cinema_booker/theme/theme_color.dart';
import 'package:cinema_booker/theme/theme_font.dart';
import 'package:cinema_booker/widgets/text_input.dart';
import 'package:cinema_booker/features/cinema/data/places_autocomplete_prediction.dart';
import 'package:cinema_booker/features/cinema/data/places_geocoding_response.dart';
import 'package:cinema_booker/features/cinema/services/places_service.dart';
import 'package:cinema_booker/features/cinema/widgets/address_autocomplete.dart';

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

  void _createCinema() {
    // @todo validate `_address`, `_longitude`, `_latitude`
    if (_formKey.currentState!.validate()) {
      _cinemaService.create(
        context: context,
        name: _nameController.text,
        description: _descriptionController.text,
        address: _address,
        longitude: _longitude,
        latitude: _latitude,
      );
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
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Create Cinema",
                style: TextStyle(
                  fontSize: ThemeFontSize.s32,
                  color: ThemeColor.white,
                ),
              ),
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
              ElevatedButton(
                onPressed: _createCinema,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
