import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/router/app_router.dart';
import 'package:flutter/material.dart';

import 'package:cinema_booker/features/auth/services/auth_service.dart';
import 'package:cinema_booker/theme/theme_color.dart';
import 'package:cinema_booker/theme/theme_font.dart';
import 'package:cinema_booker/widgets/text_input.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.error!),
          ),
        );
      } else {
        // ignore: use_build_context_synchronously
        context.pushNamed(AppRouter.signIn);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: ThemeFontSize.s32,
                  color: ThemeColor.white,
                ),
              ),
              TextInput(
                hint: "Full name",
                controller: _nameController,
                keyboardType: TextInputType.name,
              ),
              TextInput(
                hint: "Email",
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              TextInput(
                hint: "Password",
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
              ),
              ElevatedButton(
                onPressed: _signUp,
                child: const Text('Sign Up'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRouter.signIn);
                },
                child: const Text('Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
