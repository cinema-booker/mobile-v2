// ignore_for_file: use_build_context_synchronously

import 'package:cinema_booker/features/cinema/data/room_create_request.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cinema_booker/api/error_handler.dart';

class RoomService {
  void create({
    required BuildContext context,
    required int cinemaId,
    required String number,
    required String type,
  }) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('cinema-booker-token');

      RoomCreateRequest body = RoomCreateRequest(
        number: number,
        type: type,
      );

      http.Response response = await http.post(
        Uri.parse('http://10.0.2.2:3000/cinemas/$cinemaId/rooms'),
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
            message: 'Room created successfully',
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

  void delete({
    required BuildContext context,
    required int cinemaId,
    required int roomId,
  }) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('cinema-booker-token');

      http.Response response = await http.delete(
        Uri.parse('http://10.0.2.2:3000/cinemas/$cinemaId/rooms/$roomId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      httpErrorHandler(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBarError(
            context: context,
            message: 'Room deleted successfully',
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
