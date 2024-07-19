// ignore_for_file: use_build_context_synchronously

import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/widgets/button_text.dart';
import 'package:cinema_booker/widgets/text_input.dart';
import 'package:cinema_booker/services/auth_service.dart';
import 'package:cinema_booker/router/auth_routes.dart';
import 'package:cinema_booker/widgets/screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthService _authService = AuthService();

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

  Future<void> _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      ApiResponse<Null> response = await _authService.resetPasswordV2(
        email: _emailController.text,
        code: _codeController.text,
        password: _passwordController.text,
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
            content: Text("Password has been reset"),
          ),
        );

        context.pop(AuthRoutes.authSignIn);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextInput(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              hint: 'Email',
            ),
            TextInput(
              controller: _codeController,
              keyboardType: TextInputType.number,
              hint: 'Code',
            ),
            TextInput(
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              hint: 'Password',
            ),
            ButtonText(
              onPressed: _resetPassword,
              label: 'Reset Password',
            ),
          ],
        ),
      ),
    );
  }
}
