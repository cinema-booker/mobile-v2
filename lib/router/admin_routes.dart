import 'package:go_router/go_router.dart';
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
import 'package:cinema_booker/screens/admin/cinema/_room_edit_screen.dart';

import 'package:cinema_booker/screens/admin/event/event_details_screen.dart';
import 'package:cinema_booker/screens/admin/event/event_list_screen.dart';
import 'package:cinema_booker/screens/admin/event/event_edit_screen.dart';
import 'package:cinema_booker/screens/admin/event/event_create_screen.dart';
import 'package:cinema_booker/screens/admin/event/_session_create_screen.dart';
import 'package:cinema_booker/screens/admin/event/_session_edit_screen.dart';

import 'package:cinema_booker/screens/admin/booking/booking_details_screen.dart';
import 'package:cinema_booker/screens/admin/booking/booking_list_screen.dart';

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

  static const String adminCinemaRoomEdit = '$adminCinema/room/edit';
  static const String adminCinemaRoomCreate = '$adminCinema/room/create';

  static const String adminEvent = '/admin/event';
  static const String adminEventList = '$adminEvent/list';
  static const String adminEventDetails = '$adminEvent/details';
  static const String adminEventEdit = '$adminEvent/edit'; // not implemented
  static const String adminEventCreate =
      '$adminEvent/create'; // not implemented

  static const String adminEventSessionEdit = '$adminEvent/session/edit';
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
            path: AdminRoutes.adminAccountDetails,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: AccountDetailsScreen(),
            ),
          ),
          GoRoute(
            path: AdminRoutes.adminAccountEdit,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: AccountEditScreen(),
            ),
          ),
          GoRoute(
            path: AdminRoutes.adminPasswordEdit,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: PasswordEditScreen(),
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
            pageBuilder: (context, state) => const NoTransitionPage(
              child: UserDetailsScreen(),
            ),
          ),
          GoRoute(
            path: AdminRoutes.adminUserEdit,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: UserEditScreen(),
            ),
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
            pageBuilder: (context, state) => const NoTransitionPage(
              child: CinemaDetailsScreen(),
            ),
          ),
          GoRoute(
            path: AdminRoutes.adminCinemaEdit,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: CinemaCreateScreen(),
            ),
          ),
          GoRoute(
            path: AdminRoutes.adminCinemaCreate,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: CinemaEditScreen(),
            ),
          ),
          GoRoute(
            path: AdminRoutes.adminCinemaRoomCreate,
            builder: (context, state) => const RoomCreateScreen(),
          ),
          GoRoute(
            path: AdminRoutes.adminCinemaRoomEdit,
            builder: (context, state) => const RoomEditScreen(),
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
            pageBuilder: (context, state) => const NoTransitionPage(
              child: EventDetailsScreen(),
            ),
          ),
          GoRoute(
            path: AdminRoutes.adminEventCreate,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: EventCreateScreen(),
            ),
          ),
          GoRoute(
            path: AdminRoutes.adminEventEdit,
            builder: (context, state) => const EventEditScreen(),
          ),
          GoRoute(
            path: AdminRoutes.adminEventSessionCreate,
            builder: (context, state) => const SessionCreateScreen(),
          ),
          GoRoute(
            path: AdminRoutes.adminEventSessionEdit,
            builder: (context, state) => const SessionEditScreen(),
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
            pageBuilder: (context, state) => const NoTransitionPage(
              child: BookingDetailsScreen(),
            ),
          ),
        ],
      ),
    ],
  );
}
