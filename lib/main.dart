import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cinema_booker/app.dart';
import 'package:cinema_booker/providers/auth_provider.dart';
import 'package:cinema_booker/router/app_router.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: App(
        router: AppRouter(),
      ),
    ),
  );
}
