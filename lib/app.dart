import 'package:cinema_booker/theme/theme_color.dart';
import 'package:cinema_booker/theme/theme_font.dart';
import 'package:flutter/material.dart';

import 'package:cinema_booker/router/app_router.dart';

class App extends StatelessWidget {
  final AppRouter router;

  const App({
    super.key,
    required this.router,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: router.onGenerateRoute,
      initialRoute: AppRouter.signUp,
      theme: ThemeData(
        fontFamily: ThemeFontFamily.poppins,
        scaffoldBackgroundColor: ThemeColor.brown300,
      ),
    );
  }
}
