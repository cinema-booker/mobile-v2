import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/features/user/data/user_details_response.dart';
import 'package:cinema_booker/features/user/services/user_service.dart';
import 'package:cinema_booker/router/admin_routes.dart';
import 'package:cinema_booker/theme/theme_color.dart';
import 'package:cinema_booker/widgets/screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserDetailsScreen extends StatefulWidget {
  final int userId;

  const UserDetailsScreen({
    super.key,
    required this.userId,
  });

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  UserDetailsResponse? _user;
  String? _error;

  final UserService _userService = UserService();

  @override
  void initState() {
    super.initState();

    _fetchUser();
  }

  Future<void> _fetchUser() async {
    ApiResponse<UserDetailsResponse> response = await _userService.detailsV2(
      userId: widget.userId,
    );

    setState(() {
      _user = response.data;
      _error = response.error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(
        title: const Text('User Details'),
        actions: [
          IconButton(
            onPressed: () async {
              await context.push(
                AdminRoutes.adminUserEdit,
                extra: {
                  'userId': widget.userId,
                },
              );
              setState(() {
                _fetchUser();
              });
            },
            icon: const Icon(Icons.edit),
          )
        ],
      ),
      child: (_user == null && _error == null)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _error != null
              ? Text(
                  _error!,
                  style: const TextStyle(
                    color: ThemeColor.white,
                  ),
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
                  ],
                ),
    );
  }
}
