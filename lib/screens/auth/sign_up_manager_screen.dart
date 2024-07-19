// ignore_for_file: use_build_context_synchronously

import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/widgets/button.dart';
import 'package:cinema_booker/widgets/text_input.dart';
import 'package:cinema_booker/services/auth_service.dart';
import 'package:cinema_booker/widgets/screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpManagerScreen extends StatefulWidget {
  const SignUpManagerScreen({super.key});

  @override
  State<SignUpManagerScreen> createState() => _SignUpManagerScreenState();
}

class _SignUpManagerScreenState extends State<SignUpManagerScreen> {
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
      ApiResponse<Null> response = await _authService.signUp(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        role: 'MANAGER',
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
        title: const Text('Sign Up as Manager'),
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
