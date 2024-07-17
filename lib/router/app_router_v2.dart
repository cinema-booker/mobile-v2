import 'package:cinema_booker/router/manager_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:cinema_booker/features/auth/providers/auth_provider.dart';
import 'package:cinema_booker/router/admin_routes.dart';
import 'package:cinema_booker/router/auth_routes.dart';

import 'package:cinema_booker/screens/auth/sign_in_screen.dart';
import 'package:cinema_booker/screens/auth/sign_up_manager_screen.dart';
import 'package:cinema_booker/screens/auth/sign_up_viewer_screen.dart';

class AppRouterV2 {
  GoRouter goRouter(BuildContext context) {
    return GoRouter(
      initialLocation: AuthRoutes.authSignIn,
      refreshListenable: Provider.of<AuthProvider>(context, listen: false),
      redirect: (BuildContext context, GoRouterState state) {
        final bool isLogged =
            Provider.of<AuthProvider>(context, listen: false).isLogged;
        print(isLogged ? 'isLogged' : 'notLogged');
        return state.fullPath;
      },
      routes: [
        GoRoute(
          path: AuthRoutes.authSignIn,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: SignInScreen(),
          ),
        ),
        GoRoute(
          path: AuthRoutes.authSignUpManager,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: SignUpManagerScreen(),
          ),
        ),
        GoRoute(
          path: AuthRoutes.authSignUpViewer,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: SignUpViewerScreen(),
          ),
        ),
        AdminRouter.routes,
        ManagerRouter.routes,
      ],
    );
  }
}
