import 'package:cinema_booker/features/account/screens/profile_screen.dart';
import 'package:cinema_booker/features/auth/providers/auth_user.dart';
import 'package:cinema_booker/features/cinema/screens/cinema_list_screen.dart';
import 'package:cinema_booker/features/event/screens/booking_details_screen.dart';
import 'package:cinema_booker/features/event/screens/booking_list_screen.dart';
import 'package:cinema_booker/features/event/screens/event_booking_screen.dart';
import 'package:cinema_booker/features/event/screens/event_create_screen.dart';
import 'package:cinema_booker/features/event/screens/event_details_screen.dart';
import 'package:cinema_booker/features/event/screens/event_list_screen.dart';
import 'package:cinema_booker/features/event/screens/event_search_screen.dart';
import 'package:cinema_booker/features/event/screens/session_create_screen.dart';
import 'package:cinema_booker/features/user/screens/user_details_screen.dart';
import 'package:cinema_booker/features/user/screens/user_edit_screen.dart';
import 'package:cinema_booker/features/user/screens/user_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'package:cinema_booker/features/auth/providers/auth_provider.dart';
import 'package:cinema_booker/router/bottom_navigation.dart';
import 'package:cinema_booker/features/auth/screens/sign_up_screen.dart';
import 'package:cinema_booker/features/auth/screens/sign_in_screen.dart';
import 'package:cinema_booker/features/auth/screens/forget_password_screen.dart';
import 'package:cinema_booker/screens/home_screen.dart';
import 'package:cinema_booker/features/cinema/screens/cinema_details_screen.dart';
import 'package:cinema_booker/features/cinema/screens/cinema_create_screen.dart';
import 'package:cinema_booker/features/cinema/screens/room_create_screen.dart';

class AppRouter {
  static const String onboarding = '/onboarding';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String forgetPassword = '/forget-password';

  static const String home = '/home';
  static const String profile = '/profile';

  static const String userList = '/user-list';
  static const String userDetails = 'user-details';
  static const String userEdit = 'user-edit';

  static const String cinemaList = '/cinema-list';
  static const String cinemaDetails = '/cinema-details';
  static const String cinemaCreate = '/cinema-create';
  static const String roomCreate = 'room-create';

  static const String eventSearch = '/event-search';
  static const String eventBooking = 'event-booking';

  static const String eventList = '/event-list';
  static const String eventCreate = 'event-create';
  static const String eventDetails = 'event-details';
  static const String sessionCreate = 'session-create';

  static const String bookingList = '/booking-list';
  static const String bookingDetails = 'booking-details';

  List<String> authRoutes = [signIn, signUp, forgetPassword];
  List<String> privateRoutes = [
    home,
    profile,
    eventSearch,
    // eventBooking,
    userList,
    // userDetails,
    // userEdit,
    cinemaList,
    cinemaDetails,
    cinemaCreate,
    // roomCreate,
    eventList,
    // eventCreate,
    // eventDetails,
    // sessionCreate,
    bookingList,
    // bookingDetails,
  ];

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
                  name: eventSearch,
                  path: eventSearch,
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: EventSearchScreen(),
                  ),
                  routes: [
                    GoRoute(
                      name: eventBooking,
                      path: eventBooking,
                      pageBuilder: (context, state) {
                        final params =
                            GoRouterState.of(context).extra as Map<String, int>;
                        return NoTransitionPage(
                          child: EventBookingScreen(
                            eventId: params['eventId']!,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: profile,
                  path: profile,
                  pageBuilder: (context, state) {
                    AuthUser user =
                        Provider.of<AuthProvider>(context, listen: false).user;
                    return NoTransitionPage(
                      child: ProfileScreen(userId: user.id),
                    );
                  },
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
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: cinemaDetails,
                  path: cinemaDetails,
                  pageBuilder: (context, state) {
                    final params =
                        GoRouterState.of(context).extra as Map<String, int>;
                    return NoTransitionPage(
                      child: CinemaDetailsScreen(
                        cinemaId: params['cinemaId']!,
                      ),
                    );
                  },
                  routes: [
                    GoRoute(
                      name: roomCreate,
                      path: roomCreate,
                      pageBuilder: (context, state) {
                        final params =
                            GoRouterState.of(context).extra as Map<String, int>;
                        return NoTransitionPage(
                          child: RoomCreateScreen(
                            cinemaId: params['cinemaId']!,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: eventList,
                  path: eventList,
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: EventListScreen(),
                  ),
                  routes: [
                    GoRoute(
                      name: eventCreate,
                      path: eventCreate,
                      pageBuilder: (context, state) {
                        return const NoTransitionPage(
                          child: EventCreateScreen(),
                        );
                      },
                    ),
                    GoRoute(
                      name: eventDetails,
                      path: eventDetails,
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
                      name: sessionCreate,
                      path: sessionCreate,
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
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: userList,
                  path: userList,
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: UserListScreen(),
                  ),
                  routes: [
                    GoRoute(
                      name: userDetails,
                      path: userDetails,
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
                      name: userEdit,
                      path: userEdit,
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
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                    name: bookingList,
                    path: bookingList,
                    pageBuilder: (context, state) => const NoTransitionPage(
                          child: BookingListScreen(),
                        ),
                    routes: [
                      GoRoute(
                        name: bookingDetails,
                        path: bookingDetails,
                        pageBuilder: (context, state) {
                          final params = GoRouterState.of(context).extra
                              as Map<String, int>;
                          return NoTransitionPage(
                            child: BookingDetailsScreen(
                              bookingId: params['bookingId']!,
                            ),
                          );
                        },
                      ),
                    ]),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
