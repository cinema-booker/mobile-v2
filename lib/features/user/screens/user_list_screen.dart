import 'package:cinema_booker/features/user/data/user_list_response.dart';
import 'package:cinema_booker/features/user/services/user_service.dart';
import 'package:cinema_booker/router/app_router.dart';
import 'package:cinema_booker/widgets/infinite_list.dart';
import 'package:cinema_booker/widgets/search_input.dart';
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
  Key _key = UniqueKey();
  String _search = '';

  final UserService _userService = UserService();

  void _updateSearch(String search) {
    setState(() {
      _search = search;
      _key = UniqueKey();
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
            Text(
              _search,
              style: const TextStyle(
                color: ThemeColor.white,
              ),
            ),
            SearchInput(
              onChanged: _updateSearch,
            ),
            Expanded(
              child: InfiniteList<UserListItem>(
                key: _key,
                builder: (context, item) {
                  UserListItem user = item;
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
                fetch: (BuildContext context, int page, int limit) async {
                  List<UserListItem> users = await _userService.list(
                    context: context,
                    page: page,
                    limit: limit,
                    search: _search,
                  );
                  return users;
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
