import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/features/auth/data/get_me_response.dart';
import 'package:cinema_booker/features/auth/data/sign_in_response.dart';
import 'package:cinema_booker/features/auth/providers/auth_provider.dart';
import 'package:cinema_booker/router/app_router.dart';
import 'package:flutter/material.dart';

import 'package:cinema_booker/features/auth/services/auth_service.dart';
import 'package:cinema_booker/theme/theme_color.dart';
import 'package:cinema_booker/theme/theme_font.dart';
import 'package:cinema_booker/widgets/text_input.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthService _authService = AuthService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      ApiResponse<SignInResponse> response = await _authService.signInV2(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (response.error != null) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.error!),
          ),
        );
      } else {
        ApiResponse<GetMeResponse> meResponse = await _authService.meV2();
        if (meResponse.error != null) {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(meResponse.error!),
            ),
          );
        } else if (meResponse.data != null) {
          GetMeResponse me = meResponse.data!;
          // ignore: use_build_context_synchronously
          Provider.of<AuthProvider>(context, listen: false).setUser(
            me.id,
            me.name,
            me.email,
            me.role,
            me.cinemaId,
          );
          // ignore: use_build_context_synchronously
          context.goNamed(AppRouter.home);
        }
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
                "Sign In",
                style: TextStyle(
                  fontSize: ThemeFontSize.s32,
                  color: ThemeColor.white,
                ),
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
                onPressed: _signIn,
                child: const Text('Sign In'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.goNamed(AppRouter.signUp);
                },
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
