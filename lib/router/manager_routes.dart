import 'package:cinema_booker/router/manager_bottom_navigation.dart';
import 'package:go_router/go_router.dart';

import 'package:cinema_booker/screens/manager/dashboard/dashboard_screen.dart';

import 'package:cinema_booker/screens/manager/account/account_details_screen.dart';
import 'package:cinema_booker/screens/manager/account/account_edit_screen.dart';
import 'package:cinema_booker/screens/manager/account/password_edit_screen.dart';

import 'package:cinema_booker/screens/manager/cinema/cinema_create_screen.dart';
import 'package:cinema_booker/screens/manager/cinema/cinema_details_screen.dart';
import 'package:cinema_booker/screens/manager/cinema/cinema_edit_screen.dart';
import 'package:cinema_booker/screens/manager/cinema/_room_create_screen.dart';
import 'package:cinema_booker/screens/manager/cinema/_room_edit_screen.dart';

import 'package:cinema_booker/screens/manager/event/event_details_screen.dart';
import 'package:cinema_booker/screens/manager/event/event_list_screen.dart';
import 'package:cinema_booker/screens/manager/event/event_edit_screen.dart';
import 'package:cinema_booker/screens/manager/event/event_create_screen.dart';
import 'package:cinema_booker/screens/manager/event/_session_create_screen.dart';
import 'package:cinema_booker/screens/manager/event/_session_edit_screen.dart';

import 'package:cinema_booker/screens/manager/booking/booking_details_screen.dart';
import 'package:cinema_booker/screens/manager/booking/booking_list_screen.dart';

class ManagerRoutes {
  static const String managerDashboard = '/manager/account';

  static const String managerAccount = '/manager/account';
  static const String managerAccountDetails = '$managerAccount/details';
  static const String managerAccountEdit = '$managerAccount/edit';
  static const String managerPasswordEdit = '$managerAccount/password';

  static const String managerCinema = '/manager/cinema';
  static const String managerCinemaDetails = '$managerCinema/details';
  static const String managerCinemaEdit =
      '$managerCinema/edit'; // not implemented
  static const String managerCinemaCreate = '$managerCinema/create';

  static const String managerCinemaRoomEdit = '$managerCinema/room/edit';
  static const String managerCinemaRoomCreate = '$managerCinema/room/create';

  static const String managerEvent = '/manager/event';
  static const String managerEventList = '$managerEvent/list';
  static const String managerEventDetails = '$managerEvent/details';
  static const String managerEventEdit =
      '$managerEvent/edit'; // not implemented
  static const String managerEventCreate = '$managerEvent/create';

  static const String managerEventSessionEdit = '$managerEvent/session/edit';
  static const String managerEventSessionCreate =
      '$managerEvent/session/create';

  static const String managerBooking = '/manager/booking';
  static const String managerBookingList = '$managerBooking/list';
  static const String managerBookingDetails = '$managerBooking/details';
}

class ManagerRouter {
  static StatefulShellRoute routes = StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      return ManagerBottomNavigation(navigationShell: navigationShell);
    },
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: ManagerRoutes.managerDashboard,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: DashboardScreen(),
            ),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: ManagerRoutes.managerAccountDetails,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: AccountDetailsScreen(),
            ),
          ),
          GoRoute(
            path: ManagerRoutes.managerAccountEdit,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: AccountEditScreen(),
            ),
          ),
          GoRoute(
            path: ManagerRoutes.managerPasswordEdit,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: PasswordEditScreen(),
            ),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: ManagerRoutes.managerCinemaDetails,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: CinemaDetailsScreen(),
            ),
          ),
          GoRoute(
            path: ManagerRoutes.managerCinemaEdit,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: CinemaCreateScreen(),
            ),
          ),
          GoRoute(
            path: ManagerRoutes.managerCinemaCreate,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: CinemaEditScreen(),
            ),
          ),
          GoRoute(
            path: ManagerRoutes.managerCinemaRoomCreate,
            builder: (context, state) => const RoomCreateScreen(),
          ),
          GoRoute(
            path: ManagerRoutes.managerCinemaRoomEdit,
            builder: (context, state) => const RoomEditScreen(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: ManagerRoutes.managerEventList,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: EventListScreen(),
            ),
          ),
          GoRoute(
            path: ManagerRoutes.managerEventDetails,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: EventDetailsScreen(),
            ),
          ),
          GoRoute(
            path: ManagerRoutes.managerEventCreate,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: EventCreateScreen(),
            ),
          ),
          GoRoute(
            path: ManagerRoutes.managerEventEdit,
            builder: (context, state) => const EventEditScreen(),
          ),
          GoRoute(
            path: ManagerRoutes.managerEventSessionCreate,
            builder: (context, state) => const SessionCreateScreen(),
          ),
          GoRoute(
            path: ManagerRoutes.managerEventSessionEdit,
            builder: (context, state) => const SessionEditScreen(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: ManagerRoutes.managerBookingList,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: BookingListScreen(),
            ),
          ),
          GoRoute(
            path: ManagerRoutes.managerBookingDetails,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: BookingDetailsScreen(),
            ),
          ),
        ],
      ),
    ],
  );
}
