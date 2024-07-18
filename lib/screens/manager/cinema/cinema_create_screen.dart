// ignore_for_file: use_build_context_synchronously

import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/core/button.dart';
import 'package:cinema_booker/features/auth/data/get_me_response.dart';
import 'package:cinema_booker/features/auth/providers/auth_provider.dart';
import 'package:cinema_booker/features/auth/services/auth_service.dart';
import 'package:cinema_booker/features/cinema/data/places_autocomplete_prediction.dart';
import 'package:cinema_booker/features/cinema/data/places_geocoding_response.dart';
import 'package:cinema_booker/features/cinema/services/cinema_service.dart';
import 'package:cinema_booker/features/cinema/services/places_service.dart';
import 'package:cinema_booker/features/cinema/widgets/address_autocomplete.dart';
import 'package:cinema_booker/router/manager_routes.dart';
import 'package:cinema_booker/widgets/screen.dart';
import 'package:cinema_booker/core/text_input.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
  final AuthService _authService = AuthService();

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
      ApiResponse<Null> resonse = await _cinemaService.createV2(
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

        ApiResponse<GetMeResponse> response = await _authService.meV2();
        if (response.data != null && response.error == null) {
          GetMeResponse me = response.data!;
          Provider.of<AuthProvider>(context, listen: false).setUser(
            me.id,
            me.name,
            me.email,
            me.role,
            me.cinemaId,
          );
          context.go(ManagerRoutes.managerDashboard);
        }
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
