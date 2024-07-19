// ignore_for_file: use_build_context_synchronously

import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/widgets/button.dart';
import 'package:cinema_booker/data/user_details_response.dart';
import 'package:cinema_booker/services/user_service.dart';
import 'package:cinema_booker/theme/theme_color.dart';
import 'package:cinema_booker/theme/theme_font.dart';
import 'package:cinema_booker/widgets/screen.dart';
import 'package:cinema_booker/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserEditScreen extends StatefulWidget {
  final int userId;

  const UserEditScreen({
    super.key,
    required this.userId,
  });

  @override
  State<UserEditScreen> createState() => _UserEditScreenState();
}

class _UserEditScreenState extends State<UserEditScreen> {
  UserDetailsResponse? _user;
  String? _error;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final UserService _userService = UserService();

  @override
  void initState() {
    super.initState();

    _fetchUser();
  }

  @override
  void dispose() {
    _nameController.dispose();

    super.dispose();
  }

  Future<void> _fetchUser() async {
    ApiResponse<UserDetailsResponse> response = await _userService.details(
      userId: widget.userId,
    );

    setState(() {
      _user = response.data;
      _error = response.error;
    });
  }

  void _editUser() async {
    if (_formKey.currentState!.validate()) {
      ApiResponse<Null> response = await _userService.edit(
        userId: widget.userId,
        name: _nameController.text,
      );

      if (response.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.error!),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("User updated successfully"),
          ),
        );
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(
        title: const Text('User Edit'),
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
              : Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Edit User",
                        style: TextStyle(
                          fontSize: ThemeFontSize.s32,
                          color: ThemeColor.white,
                        ),
                      ),
                      TextInput(
                        hint: "Name",
                        controller: _nameController,
                        keyboardType: TextInputType.text,
                        defaultValue: _user!.name,
                      ),
                      Button(
                        onPressed: _editUser,
                        label: 'Edit User',
                      ),
                    ],
                  ),
                ),
    );
  }
}
