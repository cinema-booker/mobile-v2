// ignore_for_file: use_build_context_synchronously

import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/api/api_service.dart';
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
  ApiService apiService = ApiService();

  Future<ApiResponse<List<EventListItem>>> listV2({
    int page = 1,
    int limit = 10,
    String search = '',
  }) {
    return apiService.get<List<EventListItem>>(
      "events",
      {
        'page': page.toString(),
        'limit': limit.toString(),
        'search': search,
      },
      (data) {
        EventListResponse eventListResponse = EventListResponse.fromJson(data);
        return eventListResponse.events;
      },
    );
  }

  Future<ApiResponse<EventDetailsResponse>> detailsV2({
    required int eventId,
  }) async {
    return apiService.get<EventDetailsResponse>(
      "events/$eventId",
      null,
      (data) {
        EventDetailsResponse eventDetailsResponse =
            EventDetailsResponse.fromJson(data);
        return eventDetailsResponse;
      },
    );
  }

  Future<ApiResponse<Null>> createV2({
    required int cinemaId,
    required MovieAutoCompleteItem movie,
  }) async {
    EventCreateRequest body = EventCreateRequest(
      cinemaId: cinemaId,
      movie: movie,
    );

    return apiService.post(
      "events",
      body.toJson(),
      (_) => null,
    );
  }

  Future<List<EventListItem>> list({
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
          'http://10.0.2.2:3000/events?page=$page&limit=$limit&search=$search',
        ),
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
