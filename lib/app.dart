// ignore_for_file: use_build_context_synchronously

import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/data/get_me_response.dart';
import 'package:cinema_booker/providers/auth_provider.dart';
import 'package:cinema_booker/router/admin_routes.dart';
import 'package:cinema_booker/router/app_router.dart';
import 'package:flutter/material.dart';

import 'package:cinema_booker/services/auth_service.dart';
import 'package:cinema_booker/theme/theme_color.dart';
import 'package:cinema_booker/theme/theme_font.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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

    _fetchMe();
  }

  Future<void> _fetchMe() async {
    ApiResponse<GetMeResponse> response = await _authService.me();

    if (response.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.error!),
        ),
      );
    } else if (response.data != null) {
      GetMeResponse me = response.data!;
      Provider.of<AuthProvider>(context, listen: false).setUser(
        me.id,
        me.name,
        me.email,
        me.role,
        me.cinemaId,
      );
      context.go(AdminRoutes.adminDashboard);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: widget.router.goRouter(context),
      theme: ThemeData(
        fontFamily: ThemeFontFamily.poppins,
        scaffoldBackgroundColor: ThemeColor.brown300,
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          iconTheme: IconThemeData(
            color: ThemeColor.gray,
          ),
          backgroundColor: ThemeColor.brown300,
          titleTextStyle: TextStyle(
            color: ThemeColor.white,
            fontSize: 20,
          ),
        ),
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
