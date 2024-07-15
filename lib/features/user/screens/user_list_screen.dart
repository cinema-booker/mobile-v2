import 'package:cinema_booker/features/user/data/user_list_response.dart';
import 'package:cinema_booker/features/user/services/user_service.dart';
import 'package:cinema_booker/router/app_router.dart';
import 'package:flutter/material.dart';

import 'package:cinema_booker/theme/theme_color.dart';
import 'package:cinema_booker/theme/theme_font.dart';
import 'package:go_router/go_router.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<UserListItem> _users = [];
  int _page = 1;
  bool _hasMore = true;
  bool _isLoading = false;

  final UserService _userService = UserService();
  final ScrollController _scrollController = ScrollController();
  final int _limit = 10;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _refetchUsers();
      }
    });
    _fetchUsers();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _fetchUsers() async {
    if (_isLoading) return;
    _isLoading = true;

    setState(() {
      _users = [];
      _page = 1;
    });
    List<UserListItem> events = await _userService.list(
      context: context,
      page: 1,
      limit: _limit,
    );
    setState(() {
      _users = events;
      _page++;
      _isLoading = false;
      if (events.length < _limit) {
        _hasMore = false;
      }
    });
  }

  void _refetchUsers() async {
    List<UserListItem> users = await _userService.list(
      context: context,
      page: _page,
      limit: _limit,
    );
    setState(() {
      _users.addAll(users);
      _page++;
      if (users.length < _limit) {
        _hasMore = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "User List",
              style: TextStyle(
                fontSize: ThemeFontSize.s32,
                color: ThemeColor.white,
              ),
            ),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : RefreshIndicator(
                      onRefresh: () async {
                        _fetchUsers();
                      },
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: _users.length + 1,
                        itemBuilder: (context, index) {
                          if (index == _users.length) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                              child: Center(
                                child: _hasMore
                                    ? const CircularProgressIndicator()
                                    : const Text(
                                        'No more data to load',
                                        style: TextStyle(
                                          color: ThemeColor.white,
                                        ),
                                      ),
                              ),
                            );
                          }

                          UserListItem user = _users[index];
                          return ListTile(
                            leading: const Icon(Icons.theaters),
                            title: Text(
                              user.name,
                              style: const TextStyle(
                                color: ThemeColor.white,
                              ),
                            ),
                            subtitle: Text(
                              "${user.role} - ${user.email}",
                              style: const TextStyle(
                                color: ThemeColor.white,
                              ),
                            ),
                            onTap: () => context.pushNamed(
                              AppRouter.userDetails,
                              extra: {
                                "userId": user.id,
                              },
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
