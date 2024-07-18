import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/core/button.dart';
import 'package:cinema_booker/features/user/data/user_details_response.dart';
import 'package:cinema_booker/features/user/services/user_service.dart';
import 'package:cinema_booker/router/viewer_routes.dart';
import 'package:cinema_booker/theme/theme_color.dart';
import 'package:cinema_booker/widgets/screen.dart';
import 'package:cinema_booker/widgets/sign_out_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AccountDetailsScreen extends StatefulWidget {
  final int userId;

  const AccountDetailsScreen({
    super.key,
    required this.userId,
  });

  @override
  State<AccountDetailsScreen> createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
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
        title: const Text('Profile'),
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
                      _user!.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: ThemeColor.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _user!.email,
                      style: const TextStyle(
                        color: ThemeColor.gray,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      color: ThemeColor.brown100,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        child: Text(
                          _user!.role,
                          style: const TextStyle(
                            color: ThemeColor.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Button(
                      onPressed: () async {
                        await context.push(
                          ViewerRoutes.viewerAccountEdit,
                          extra: {
                            'userId': _user!.id,
                          },
                        );
                        setState(() {
                          _fetchUser();
                        });
                      },
                      label: 'Edit Account',
                    ),
                    const SizedBox(height: 16),
                    Button(
                      onPressed: () async {
                        await context.push(
                          ViewerRoutes.viewerPasswordEdit,
                          extra: {
                            'userId': _user!.id,
                          },
                        );
                        setState(() {
                          _fetchUser();
                        });
                      },
                      label: 'Change Password',
                    ),
                    const SizedBox(height: 16),
                    const SignOutButton(),
                  ],
                ),
    );
  }
}
