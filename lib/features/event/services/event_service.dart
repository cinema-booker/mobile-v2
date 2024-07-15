// ignore_for_file: use_build_context_synchronously

import 'package:cinema_booker/features/event/data/event_create_request.dart';
import 'package:cinema_booker/features/event/data/event_details_response.dart';
import 'package:cinema_booker/features/event/data/event_list_response.dart';
import 'package:cinema_booker/features/event/data/movie_autocomplete_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cinema_booker/api/error_handler.dart';

class EventService {
  Future<List<EventListItem>> list({
    required BuildContext context,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('cinema-booker-token');

      http.Response response = await http.get(
        Uri.parse('http://10.0.2.2:3000/events?page=$page&limit=$limit'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        EventListResponse eventListResponse =
            EventListResponse.fromJson(response.body);
        return eventListResponse.events;
      } else {
        showSnackBarError(
          context: context,
          message: 'Failed to fetch event list',
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

  Future<EventDetailsResponse?> details({
    required BuildContext context,
    required int eventId,
  }) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('cinema-booker-token');

      http.Response response = await http.get(
        Uri.parse('http://10.0.2.2:3000/events/$eventId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        EventDetailsResponse eventDetailsResponse =
            EventDetailsResponse.fromJson(response.body);
        return eventDetailsResponse;
      } else {
        showSnackBarError(
          context: context,
          message: 'Failed to fetch event details',
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

  void create({
    required BuildContext context,
    required int cinemaId,
    required MovieAutoCompleteItem movie,
  }) async {
    try {
      EventCreateRequest body = EventCreateRequest(
        cinemaId: cinemaId,
        movie: movie,
      );

      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('cinema-booker-token');

      http.Response response = await http.post(
        Uri.parse('http://10.0.2.2:3000/events'),
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
            message: 'Event created successfully',
          );

          context.pop();
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
