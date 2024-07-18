import 'package:cinema_booker/features/auth/providers/auth_user.dart';
import 'package:cinema_booker/router/manager_routes.dart';
import 'package:cinema_booker/router/viewer_routes.dart';
import 'package:cinema_booker/screens/auth/forget_password_screen.dart';
import 'package:cinema_booker/screens/auth/reset_password_screen.dart';
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
        AuthUser user = Provider.of<AuthProvider>(context, listen: false).user;
        final bool isLogged =
            Provider.of<AuthProvider>(context, listen: false).isLogged;

        if (!isLogged &&
            state.fullPath!.startsWith("/admin") &&
            state.fullPath!.startsWith("/manager") &&
            state.fullPath!.startsWith("/viewer")) {
          return AuthRoutes.authSignIn;
        }

        if (isLogged &&
            user.role == "ADMIN" &&
            !state.fullPath!.startsWith("/admin") &&
            !state.fullPath!.startsWith("/auth")) {
          return AdminRoutes.adminDashboard;
        }

        if (isLogged &&
            user.role == "MANAGER" &&
            !state.fullPath!.startsWith("/manager") &&
            !state.fullPath!.startsWith("/auth")) {
          if (user.cinemaId == null) {
            return ManagerRoutes.managerCinemaCreate;
          }
          return ManagerRoutes.managerDashboard;
        }

        if (isLogged &&
            user.role == "VIEWER" &&
            !state.fullPath!.startsWith("/viewer") &&
            !state.fullPath!.startsWith("/auth")) {
          return ViewerRoutes.viewerDashboard;
        }

        if (isLogged &&
            user.role == "MANAGER" &&
            state.fullPath!.startsWith("/manager") &&
            !state.fullPath!.startsWith("/manager/account")) {
          if (user.cinemaId == null) {
            return ManagerRoutes.managerCinemaCreate;
          }
          return state.fullPath;
        }

        if (isLogged && state.fullPath!.startsWith("/auth")) {
          if (user.role == "ADMIN") {
            return AdminRoutes.adminDashboard;
          } else if (user.role == "MANAGER") {
            if (user.cinemaId == null) {
              return ManagerRoutes.managerCinemaCreate;
            }
            return ManagerRoutes.managerDashboard;
          } else if (user.role == "VIEWER") {
            return ViewerRoutes.viewerDashboard;
          }
        }

        return null;
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
        GoRoute(
          path: AuthRoutes.authForgetPassword,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ForgetPasswordScreen(),
          ),
        ),
        GoRoute(
          path: AuthRoutes.authResetPassword,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ResetPasswordScreen(),
          ),
        ),
        AdminRouter.routes,
        ManagerRouter.routes,
        ViewerRouter.routes,
      ],
    );
  }
}
