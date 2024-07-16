// ignore_for_file: use_build_context_synchronously

import 'package:cinema_booker/features/event/data/booking_create_request.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cinema_booker/api/error_handler.dart';

class BookingService {
  void create({
    required BuildContext context,
    required int sessionId,
    required List<String> seats,
  }) async {
    try {
      BookingCreateRequest body = BookingCreateRequest(
        sessionId: sessionId,
        seats: seats,
      );

      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('cinema-booker-token');

      http.Response response = await http.post(
        Uri.parse('http://10.0.2.2:3000/bookings'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: body.toJson(),
      );

      httpErrorHandler(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBarError(
            context: context,
            message: 'Booking created successfully',
          );
        },
      );
    } catch (error) {
      showSnackBarError(
        context: context,
        message: error.toString(),
      );
    }
  }
}
