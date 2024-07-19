import 'package:cinema_booker/data/user_list_response.dart';
import 'package:cinema_booker/services/user_service.dart';
import 'package:cinema_booker/router/admin_routes.dart';
import 'package:cinema_booker/theme/theme_color.dart';
import 'package:cinema_booker/widgets/infinite_list.dart';
import 'package:cinema_booker/widgets/screen_list.dart';
import 'package:cinema_booker/widgets/search_input.dart';
import 'package:flutter/material.dart';
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
    return ScreenList(
      appBar: AppBar(
        title: const Text('User List'),
        actions: [
          IconButton(
            onPressed: () async {
              await context.push(AdminRoutes.adminUserCreate);
              _key = UniqueKey();
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                  onTap: () async {
                    await context.push(
                      AdminRoutes.adminUserDetails,
                      extra: {
                        "userId": user.id,
                      },
                    );
                  },
                );
              },
              fetch: (BuildContext context, int page, int limit) async {
                return await _userService.list(
                  page: page,
                  limit: limit,
                  search: _search,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
