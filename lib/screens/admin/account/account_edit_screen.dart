// ignore_for_file: use_build_context_synchronously

import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/core/button.dart';
import 'package:cinema_booker/features/user/data/user_details_response.dart';
import 'package:cinema_booker/features/user/services/user_service.dart';
import 'package:cinema_booker/theme/theme_color.dart';
import 'package:cinema_booker/theme/theme_font.dart';
import 'package:cinema_booker/widgets/screen.dart';
import 'package:cinema_booker/core/text_input.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AccountEditScreen extends StatefulWidget {
  final int userId;

  const AccountEditScreen({
    super.key,
    required this.userId,
  });

  @override
  State<AccountEditScreen> createState() => _AccountEditScreenState();
}

class _AccountEditScreenState extends State<AccountEditScreen> {
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
    ApiResponse<UserDetailsResponse> response = await _userService.detailsV2(
      userId: widget.userId,
    );

    setState(() {
      _user = response.data;
      _error = response.error;
    });
  }

  void _editProfile() async {
    if (_formKey.currentState!.validate()) {
      ApiResponse<Null> response = await _userService.editV2(
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
            content: Text("Profile updated successfully"),
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
        title: const Text('Profile Edit'),
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
                        onPressed: _editProfile,
                        label: "Save",
                      ),
                    ],
                  ),
                ),
    );
  }
}
