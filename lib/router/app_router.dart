import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'package:cinema_booker/providers/auth_provider.dart';
import 'package:cinema_booker/router/bottom_navigation.dart';
import 'package:cinema_booker/screens/sign_up_screen.dart';
import 'package:cinema_booker/screens/sign_in_screen.dart';
import 'package:cinema_booker/screens/forget_password_screen.dart';
import 'package:cinema_booker/screens/home_screen.dart';
import 'package:cinema_booker/screens/profile_screen.dart';
import 'package:cinema_booker/features/cinema/screens/cinema_create_screen.dart';
import 'package:cinema_booker/features/cinema/screens/cinema_list_screen.dart';

class AppRouter {
  static const String onboarding = '/onboarding';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String forgetPassword = '/forget-password';
  static const String home = '/home';
  static const String profile = '/profile';

  static const String cinemaList = '/cinema-list';
  static const String cinemaCreate = '/cinema-create';

  List<String> authRoutes = [signIn, signUp, forgetPassword];
  List<String> privateRoutes = [home, profile, cinemaCreate];

  GoRouter goRouter(BuildContext context) {
    return GoRouter(
      initialLocation: signIn,
      refreshListenable: Provider.of<AuthProvider>(context, listen: false),
      redirect: (BuildContext context, GoRouterState state) {
        final bool isLogged =
            Provider.of<AuthProvider>(context, listen: false).isLogged;
        final bool isAuthRoute = authRoutes.contains(state.fullPath);
        final bool isPrivateRoute = privateRoutes.contains(state.fullPath);
        if (!isLogged && isPrivateRoute) {
          return signIn;
        }
        if (isLogged && isAuthRoute) {
          return home;
        }
        return null;
      },
      routes: [
        GoRoute(
          name: signUp,
          path: signUp,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: SignUpScreen(),
          ),
        ),
        GoRoute(
          name: signIn,
          path: signIn,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: SignInScreen(),
          ),
        ),
        GoRoute(
          name: forgetPassword,
          path: forgetPassword,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ForgetPasswordScreen(),
          ),
        ),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return BottomNavigation(navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: home,
                  path: home,
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: HomeScreen(),
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: profile,
                  path: profile,
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: ProfileScreen(),
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: cinemaList,
                  path: cinemaList,
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: CinemaListScreen(),
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: cinemaCreate,
                  path: cinemaCreate,
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: CinemaCreateScreen(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
