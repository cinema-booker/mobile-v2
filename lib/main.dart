import 'package:cinema_booker/router/app_router_v2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cinema_booker/app.dart';
import 'package:cinema_booker/features/auth/providers/auth_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: App(
        router: AppRouterV2(),
      ),
    ),
  );
}
