import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cinema_booker/providers/auth_provider.dart';
import 'package:cinema_booker/services/auth_service.dart';
import 'package:cinema_booker/theme/theme_color.dart';
import 'package:cinema_booker/theme/theme_font.dart';
import 'package:cinema_booker/router/app_router.dart';
import 'package:cinema_booker/screens/home_screen.dart';
import 'package:cinema_booker/screens/sign_in_screen.dart';

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
    return MaterialApp(
      onGenerateRoute: widget.router.onGenerateRoute,
      home: Provider.of<AuthProvider>(context).isLogged
          ? const HomeScreen()
          : const SignInScreen(),
      theme: ThemeData(
        fontFamily: ThemeFontFamily.poppins,
        scaffoldBackgroundColor: ThemeColor.brown300,
      ),
    );
  }
}
