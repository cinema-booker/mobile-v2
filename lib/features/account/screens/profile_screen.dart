import 'package:cinema_booker/features/user/data/user_details_response.dart';
import 'package:cinema_booker/features/user/services/user_service.dart';
import 'package:cinema_booker/router/app_router.dart';
import 'package:flutter/material.dart';

import 'package:cinema_booker/theme/theme_color.dart';
import 'package:cinema_booker/theme/theme_font.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  final int userId;

  const ProfileScreen({
    super.key,
    required this.userId,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserDetailsResponse? _user;
  final UserService _userService = UserService();

  @override
  void initState() {
    super.initState();

    _fetchUser();
  }

  void _fetchUser() async {
    UserDetailsResponse? user = await _userService.details(
      context: context,
      userId: widget.userId,
    );

    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              context.pushNamed(
                AppRouter.userEdit,
                extra: {
                  'userId': widget.userId,
                },
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Profile",
              style: TextStyle(
                fontSize: ThemeFontSize.s32,
                color: ThemeColor.white,
              ),
            ),
            _user == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name: ${_user!.name}",
                        style: const TextStyle(
                          color: ThemeColor.white,
                        ),
                      ),
                      Text(
                        "Email: ${_user!.email}",
                        style: const TextStyle(
                          color: ThemeColor.white,
                        ),
                      ),
                      Text(
                        "Role: ${_user!.role}",
                        style: const TextStyle(
                          color: ThemeColor.white,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => {
                          context.pushNamed(
                            AppRouter.cinemaDetails,
                            extra: {
                              'cinemaId': _user!.cinemaId!,
                            },
                          )
                        },
                        child: const Text("My cinema"),
                      ),
                      ElevatedButton(
                        onPressed: () => {},
                        child: const Text("Password update"),
                      ),
                      ElevatedButton(
                        onPressed: () => {},
                        child: const Text("Preferences"),
                      )
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
