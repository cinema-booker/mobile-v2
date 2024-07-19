// ignore_for_file: use_build_context_synchronously

import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/widgets/button.dart';
import 'package:cinema_booker/widgets/password_input.dart';
import 'package:cinema_booker/services/user_service.dart';
import 'package:cinema_booker/widgets/screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PasswordEditScreen extends StatefulWidget {
  final int userId;

  const PasswordEditScreen({
    super.key,
    required this.userId,
  });

  @override
  State<PasswordEditScreen> createState() => _PasswordEditScreenState();
}

class _PasswordEditScreenState extends State<PasswordEditScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  final UserService _userService = UserService();

  void _editPassword() async {
    if (_formKey.currentState!.validate()) {
      ApiResponse<Null> response = await _userService.editPasswordV2(
        userId: widget.userId,
        password: _passwordController.text,
        newPassword: _newPasswordController.text,
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
            content: Text("Password updated successfully"),
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
        title: const Text('Profile Password'),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PasswordInput(
              hint: "Current Password",
              controller: _passwordController,
            ),
            PasswordInput(
              hint: "New Password",
              controller: _newPasswordController,
            ),
            Button(
              onPressed: _editPassword,
              label: 'Edit Password',
            ),
          ],
        ),
      ),
    );
  }
}
