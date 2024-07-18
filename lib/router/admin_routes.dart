import 'package:go_router/go_router.dart';

import 'package:cinema_booker/features/auth/providers/auth_provider.dart';
import 'package:cinema_booker/features/auth/providers/auth_user.dart';
import 'package:cinema_booker/router/admin_bottom_navigation.dart';

import 'package:cinema_booker/screens/admin/dashboard/dashboard_screen.dart';

import 'package:cinema_booker/screens/admin/account/account_details_screen.dart';
import 'package:cinema_booker/screens/admin/account/account_edit_screen.dart';
import 'package:cinema_booker/screens/admin/account/password_edit_screen.dart';

import 'package:cinema_booker/screens/admin/user/user_create_screen.dart';
import 'package:cinema_booker/screens/admin/user/user_details_screen.dart';
import 'package:cinema_booker/screens/admin/user/user_edit_screen.dart';
import 'package:cinema_booker/screens/admin/user/user_list_screen.dart';

import 'package:cinema_booker/screens/admin/cinema/cinema_create_screen.dart';
import 'package:cinema_booker/screens/admin/cinema/cinema_details_screen.dart';
import 'package:cinema_booker/screens/admin/cinema/cinema_edit_screen.dart';
import 'package:cinema_booker/screens/admin/cinema/cinema_list_screen.dart';
import 'package:cinema_booker/screens/admin/cinema/_room_create_screen.dart';

import 'package:cinema_booker/screens/admin/event/event_details_screen.dart';
import 'package:cinema_booker/screens/admin/event/event_list_screen.dart';
import 'package:cinema_booker/screens/admin/event/_session_create_screen.dart';

import 'package:cinema_booker/screens/admin/booking/booking_details_screen.dart';
import 'package:cinema_booker/screens/admin/booking/booking_list_screen.dart';
import 'package:provider/provider.dart';

class AdminRoutes {
  static const String adminDashboard = '/admin/dashboard';

  static const String adminAccount = '/admin/account';
  static const String adminAccountDetails = '$adminAccount/details';
  static const String adminAccountEdit = '$adminAccount/edit';
  static const String adminPasswordEdit = '$adminAccount/password';

  static const String adminUser = '/admin/user';
  static const String adminUserList = '$adminUser/list';
  static const String adminUserDetails = '$adminUser/details';
  static const String adminUserEdit = '$adminUser/edit'; // not implemented
  static const String adminUserCreate = '$adminUser/create';

  static const String adminCinema = '/admin/cinema';
  static const String adminCinemaList = '$adminCinema/list';
  static const String adminCinemaDetails = '$adminCinema/details';
  static const String adminCinemaEdit = '$adminCinema/edit'; // not implemented
  static const String adminCinemaCreate =
      '$adminCinema/create'; // not implemented
  static const String adminCinemaRoomCreate = '$adminCinema/room/create';

  static const String adminEvent = '/admin/event';
  static const String adminEventList = '$adminEvent/list';
  static const String adminEventDetails = '$adminEvent/details';
  static const String adminEventCreate =
      '$adminEvent/create'; // not implemented
  static const String adminEventSessionCreate = '$adminEvent/session/create';

  static const String adminBooking = '/admin/booking';
  static const String adminBookingList = '$adminBooking/list';
  static const String adminBookingDetails = '$adminBooking/details';
}

class AdminRouter {
  static StatefulShellRoute routes = StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      return AdminBottomNavigation(navigationShell: navigationShell);
    },
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AdminRoutes.adminDashboard,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: DashboardScreen(),
            ),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AdminRoutes.adminUserList,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: UserListScreen(),
            ),
          ),
          GoRoute(
            path: AdminRoutes.adminUserDetails,
            pageBuilder: (context, state) {
              final params =
                  GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: UserDetailsScreen(
                  userId: params['userId']!,
                ),
              );
            },
          ),
          GoRoute(
            path: AdminRoutes.adminUserEdit,
            pageBuilder: (context, state) {
              final params =
                  GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: UserEditScreen(
                  userId: params['userId']!,
                ),
              );
            },
          ),
          GoRoute(
            path: AdminRoutes.adminUserCreate,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: UserCreateScreen(),
            ),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AdminRoutes.adminCinemaList,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: CinemaListScreen(),
            ),
          ),
          GoRoute(
            path: AdminRoutes.adminCinemaDetails,
            pageBuilder: (context, state) {
              final params =
                  GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: CinemaDetailsScreen(
                  cinemaId: params["cinemaId"]!,
                ),
              );
            },
          ),
          GoRoute(
            path: AdminRoutes.adminCinemaEdit,
            pageBuilder: (context, state) {
              final params =
                  GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: CinemaEditScreen(
                  cinemaId: params["cinemaId"]!,
                ),
              );
            },
          ),
          GoRoute(
            path: AdminRoutes.adminCinemaCreate,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: CinemaCreateScreen(),
            ),
          ),
          GoRoute(
            path: AdminRoutes.adminCinemaRoomCreate,
            pageBuilder: (context, state) {
              final params =
                  GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: RoomCreateScreen(
                  cinemaId: params["cinemaId"]!,
                ),
              );
            },
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AdminRoutes.adminEventList,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: EventListScreen(),
            ),
          ),
          GoRoute(
            path: AdminRoutes.adminEventDetails,
            pageBuilder: (context, state) {
              final params =
                  GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: EventDetailsScreen(
                  eventId: params['eventId']!,
                ),
              );
            },
          ),
          GoRoute(
            path: AdminRoutes.adminEventSessionCreate,
            pageBuilder: (context, state) {
              final params =
                  GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: SessionCreateScreen(
                  eventId: params['eventId']!,
                ),
              );
            },
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AdminRoutes.adminBookingList,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: BookingListScreen(),
            ),
          ),
          GoRoute(
            path: AdminRoutes.adminBookingDetails,
            pageBuilder: (context, state) {
              final params =
                  GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: BookingDetailsScreen(
                  bookingId: params['bookingId']!,
                ),
              );
            },
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AdminRoutes.adminAccountDetails,
            pageBuilder: (context, state) {
              AuthUser user =
                  Provider.of<AuthProvider>(context, listen: false).user;
              return NoTransitionPage(
                child: AccountDetailsScreen(
                  userId: user.id,
                ),
              );
            },
          ),
          GoRoute(
            path: AdminRoutes.adminAccountEdit,
            pageBuilder: (context, state) {
              final params =
                  GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: AccountEditScreen(
                  userId: params['userId']!,
                ),
              );
            },
          ),
          GoRoute(
            path: AdminRoutes.adminPasswordEdit,
            pageBuilder: (context, state) {
              final params =
                  GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: PasswordEditScreen(
                  userId: params['userId']!,
                ),
              );
            },
          ),
        ],
      )
    ],
  );
}
