import 'package:cinema_booker/providers/auth_provider.dart';
import 'package:cinema_booker/providers/auth_user.dart';
import 'package:cinema_booker/router/viewer_bottom_navigation.dart';
import 'package:go_router/go_router.dart';

import 'package:cinema_booker/screens/viewer/dashboard/dashboard_screen.dart';

import 'package:cinema_booker/screens/viewer/account/account_details_screen.dart';
import 'package:cinema_booker/screens/viewer/account/account_edit_screen.dart';
import 'package:cinema_booker/screens/viewer/account/password_edit_screen.dart';

import 'package:cinema_booker/screens/viewer/cinema/cinema_list_screen.dart';
import 'package:cinema_booker/screens/viewer/cinema/cinema_details_screen.dart';

import 'package:cinema_booker/screens/viewer/event/event_details_screen.dart';
import 'package:cinema_booker/screens/viewer/event/event_list_screen.dart';

import 'package:cinema_booker/screens/viewer/booking/booking_details_screen.dart';
import 'package:cinema_booker/screens/viewer/booking/booking_list_screen.dart';
import 'package:cinema_booker/screens/viewer/booking/booking_create_screen.dart';
import 'package:provider/provider.dart';

class ViewerRoutes {
  static const String viewerDashboard = '/viewer/dashboard';

  static const String viewerAccount = '/viewer/account';
  static const String viewerAccountDetails = '$viewerAccount/details';
  static const String viewerAccountEdit = '$viewerAccount/edit';
  static const String viewerPasswordEdit = '$viewerAccount/password';

  static const String viewerCinema = '/viewer/cinema';
  static const String viewerCinemaList =
      '$viewerCinema/list'; // not implemented
  static const String viewerCinemaDetails =
      '$viewerCinema/details'; // not implemented

  static const String viewerEvent = '/viewer/event';
  static const String viewerEventList = '$viewerEvent/list';
  static const String viewerEventDetails = '$viewerEvent/details';

  static const String viewerBooking = '/viewer/booking';
  static const String viewerBookingList = '$viewerBooking/list';
  static const String viewerBookingDetails = '$viewerBooking/details';
  static const String viewerBookingCreate = '$viewerBooking/create';
}

class ViewerRouter {
  static StatefulShellRoute routes = StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      return ViewerBottomNavigation(navigationShell: navigationShell);
    },
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: ViewerRoutes.viewerDashboard,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: DashboardScreen(),
            ),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: ViewerRoutes.viewerCinemaList,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: CinemaListScreen(),
            ),
          ),
          GoRoute(
            path: ViewerRoutes.viewerCinemaDetails,
            pageBuilder: (context, state) {
              final params =
                  GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: CinemaDetailsScreen(
                  cinemaId: params['cinemaId']!,
                ),
              );
            },
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: ViewerRoutes.viewerEventList,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: EventListScreen(),
            ),
          ),
          GoRoute(
            path: ViewerRoutes.viewerEventDetails,
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
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: ViewerRoutes.viewerBookingList,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: BookingListScreen(),
            ),
          ),
          GoRoute(
            path: ViewerRoutes.viewerBookingDetails,
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
          GoRoute(
            path: ViewerRoutes.viewerBookingCreate,
            pageBuilder: (context, state) {
              final params =
                  GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: BookingCreateScreen(
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
            path: ViewerRoutes.viewerAccountDetails,
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
            path: ViewerRoutes.viewerAccountEdit,
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
            path: ViewerRoutes.viewerPasswordEdit,
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
