// ignore_for_file: use_build_context_synchronously

import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/core/button.dart';
import 'package:cinema_booker/core/text_input.dart';
import 'package:cinema_booker/features/auth/services/auth_service.dart';
import 'package:cinema_booker/widgets/screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpViewerScreen extends StatefulWidget {
  const SignUpViewerScreen({super.key});

  @override
  State<SignUpViewerScreen> createState() => _SignUpViewerScreenState();
}

class _SignUpViewerScreenState extends State<SignUpViewerScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthService _authService = AuthService();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      ApiResponse<Null> response = await _authService.signUpV2(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        role: 'VIEWER',
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
            content: Text('Sign up successful'),
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
        title: const Text('Sign Up as Viewer'),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextInput(
              controller: _nameController,
              keyboardType: TextInputType.name,
              hint: 'Name',
            ),
            TextInput(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              hint: 'Email',
            ),
            TextInput(
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              hint: 'Password',
            ),
            Button(
              onPressed: _signUp,
              label: 'Sign Up',
            ),
            Button(
              onPressed: () {
                context.pop();
              },
              label: 'Sign In',
            ),
          ],
        ),
      ),
    );
  }
}
