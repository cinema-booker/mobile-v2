// ignore_for_file: use_build_context_synchronously

import 'package:cinema_booker/features/event/data/event_list_response.dart';
import 'package:flutter/material.dart';
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
}
