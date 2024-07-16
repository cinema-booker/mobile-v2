// ignore_for_file: use_build_context_synchronously

import 'package:cinema_booker/features/event/data/booking_create_request.dart';
import 'package:cinema_booker/features/event/data/booking_create_response.dart';
import 'package:cinema_booker/features/event/data/booking_list_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cinema_booker/api/error_handler.dart';

class BookingService {
  Future<BookingCreateResponse?> create({
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

      if (response.statusCode == 200 || response.statusCode == 201) {
        showSnackBarError(
          context: context,
          message: 'Booking created successfully',
        );

        BookingCreateResponse bookingCreateResponse =
            BookingCreateResponse.fromJson(response.body);
        return bookingCreateResponse;
      } else {
        showSnackBarError(
          context: context,
          message: 'Failed to create booking',
        );

        return null;
      }
    } catch (error) {
      showSnackBarError(
        context: context,
        message: error.toString(),
      );

      return null;
    }
  }

  Future<List<BookingListItem>> list({
    required BuildContext context,
    int page = 1,
    int limit = 10,
    String search = '',
  }) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('cinema-booker-token');

      http.Response response = await http.get(
        Uri.parse(
          'http://10.0.2.2:3000/bookings?page=$page&limit=$limit&search=$search',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        BookingListResponse bookingListResponse =
            BookingListResponse.fromJson(response.body);
        return bookingListResponse.bookings;
      } else {
        showSnackBarError(
          context: context,
          message: 'Failed to fetch booking list',
        );
        return [];
      }
    } catch (error) {
      showSnackBarError(
        context: context,
        message: error.toString(),
      );
      return [];
    }
  }

  Future<BookingListItem?> details({
    required BuildContext context,
    required int bookingId,
  }) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('cinema-booker-token');

      http.Response response = await http.get(
        Uri.parse('http://10.0.2.2:3000/bookings/$bookingId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        BookingListItem bookingListItem =
            BookingListItem.fromJson(response.body);
        return bookingListItem;
      } else {
        showSnackBarError(
          context: context,
          message: 'Failed to fetch booking details',
        );
        return null;
      }
    } catch (error) {
      showSnackBarError(
        context: context,
        message: error.toString(),
      );
      return null;
    }
  }
}
