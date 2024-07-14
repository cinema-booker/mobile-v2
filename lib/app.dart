import 'package:flutter/material.dart';

import 'package:cinema_booker/features/auth/services/auth_service.dart';
import 'package:cinema_booker/router/app_router.dart';
import 'package:cinema_booker/theme/theme_color.dart';
import 'package:cinema_booker/theme/theme_font.dart';

class App extends StatefulWidget {
  final AppRouter router;

  const App({
    super.key,
    required this.router,
  });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _authService.getMe(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: widget.router.goRouter(context),
      theme: ThemeData(
        fontFamily: ThemeFontFamily.poppins,
        scaffoldBackgroundColor: ThemeColor.brown300,
        // BottomNavigationBar
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: ThemeColor.brown300,
          selectedItemColor: ThemeColor.yellow,
          unselectedItemColor: ThemeColor.gray,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
      ),
    );
  }
}
