import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandler({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
    case 201:
      onSuccess();
      break;
    case 400:
      showSnackBarError(
        context: context,
        message: 'Bad request',
      );
      break;
    case 401:
      showSnackBarError(
        context: context,
        message: 'Unauthorized',
      );
      break;
    case 403:
      showSnackBarError(
        context: context,
        message: 'Forbidden',
      );
      break;
    case 404:
      showSnackBarError(
        context: context,
        message: 'Not found',
      );
      break;
    case 500:
      showSnackBarError(
        context: context,
        message: 'Internal server error',
      );
      break;
    default:
      showSnackBarError(
        context: context,
        message: 'An error occurred',
      );
  }
}

void showSnackBarError({
  required BuildContext context,
  required String message,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
