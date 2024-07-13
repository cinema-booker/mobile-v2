// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cinema_booker/providers/auth_provider.dart';
import 'package:cinema_booker/router/app_router.dart';
import 'package:cinema_booker/api/error_handler.dart';
import 'package:cinema_booker/models/sign_in_request.dart';
import 'package:cinema_booker/models/sign_up_request.dart';
import 'package:cinema_booker/models/sign_in_response.dart';
import 'package:cinema_booker/models/get_me_response.dart';

class AuthService {
  void signUp({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      SignUpRequest body = SignUpRequest(
        name: name,
        email: email,
        password: password,
        role: 'VIEWER',
      );

      http.Response response = await http.post(
        Uri.parse('http://10.0.2.2:3000/sign-up'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body.toJson(),
      );

      httpErrorHandler(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBarError(context: context, message: 'Sign up successful');
          context.goNamed(AppRouter.signIn);
        },
      );
    } catch (error) {
      showSnackBarError(
        context: context,
        message: error.toString(),
      );
    }
  }

  void signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      SignInRequest body = SignInRequest(
        email: email,
        password: password,
      );

      http.Response response = await http.post(
        Uri.parse('http://10.0.2.2:3000/sign-in'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body.toJson(),
      );

      httpErrorHandler(
        response: response,
        context: context,
        onSuccess: () async {
          SignInResponse signInResponse =
              SignInResponse.fromJson(response.body);

          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.setString(
            'cinema-booker-token',
            signInResponse.token,
          );

          Provider.of<AuthProvider>(context, listen: false).setUser(
            signInResponse.id,
            signInResponse.name,
            signInResponse.email,
            signInResponse.role,
          );

          showSnackBarError(context: context, message: 'Sign in successful');
          context.goNamed(AppRouter.home);
        },
      );
    } catch (error) {
      showSnackBarError(
        context: context,
        message: error.toString(),
      );
    }
  }

  void getMe({required BuildContext context}) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('cinema-booker-token');

      http.Response response = await http.get(
        Uri.parse('http://10.0.2.2:3000/me'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      httpErrorHandler(
        response: response,
        context: context,
        onSuccess: () async {
          GetMeResponse getMeResponse = GetMeResponse.fromJson(response.body);

          Provider.of<AuthProvider>(context, listen: false).setUser(
            getMeResponse.id,
            getMeResponse.name,
            getMeResponse.email,
            getMeResponse.role,
          );
        },
      );
    } catch (error) {}
  }
}
