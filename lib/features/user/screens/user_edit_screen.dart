import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/features/user/data/user_details_response.dart';
import 'package:cinema_booker/features/user/services/user_service.dart';
import 'package:flutter/material.dart';

import 'package:cinema_booker/theme/theme_color.dart';
import 'package:cinema_booker/theme/theme_font.dart';
import 'package:cinema_booker/widgets/text_input.dart';
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
    ApiResponse<UserDetailsResponse> response = await _userService.detailsV2(
      userId: widget.userId,
    );

    setState(() {
      _user = response.data;
      _error = response.error;
    });
  }

  void _editUser() async {
    if (_formKey.currentState!.validate()) {
      ApiResponse<Null> response = await _userService.editV2(
        userId: widget.userId,
        name: _nameController.text,
      );

      if (response.error != null) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.error!),
          ),
        );
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("User updated"),
          ),
        );
        // ignore: use_build_context_synchronously
        context.pop();
      }
    }
  }

  Widget _buildForm(BuildContext context, UserDetailsResponse user) {
    return Form(
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
            defaultValue: user.name,
          ),
          ElevatedButton(
            onPressed: _editUser,
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                : _buildForm(context, _user!),
      ),
    );
  }
}
