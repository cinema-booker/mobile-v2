// ignore_for_file: use_build_context_synchronously

import 'package:cinema_booker/features/cinema/data/cinema_list_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cinema_booker/api/error_handler.dart';
import 'package:cinema_booker/features/cinema/data/cinema_create_request.dart';

class CinemaService {
  void create({
    required BuildContext context,
    required String name,
    required String description,
    required String address,
    required double longitude,
    required double latitude,
  }) async {
    try {
      CinemaCreateRequest body = CinemaCreateRequest(
        name: name,
        description: description,
        address: address,
        longitude: longitude,
        latitude: latitude,
      );

      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('cinema-booker-token');

      http.Response response = await http.post(
        Uri.parse('http://10.0.2.2:3000/cinemas'),
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
            message: 'Cinema created successfully',
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

  Future<List<CinemaListItem>> list({
    required BuildContext context,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('cinema-booker-token');

      http.Response response = await http.get(
        Uri.parse('http://10.0.2.2:3000/cinemas?page=$page&limit=$limit'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        CinemaListResponse cinemaListResponse =
            CinemaListResponse.fromJson(response.body);
        return cinemaListResponse.cinemas;
      } else {
        showSnackBarError(
          context: context,
          message: 'Failed to fetch cinema list',
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
