// ignore_for_file: use_build_context_synchronously

import 'package:cinema_booker/api/api_constants.dart';
import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/widgets/button.dart';
import 'package:cinema_booker/widgets/button_text.dart';
import 'package:cinema_booker/widgets/password_input.dart';
import 'package:cinema_booker/widgets/text_input.dart';
import 'package:cinema_booker/data/get_me_response.dart';
import 'package:cinema_booker/data/sign_in_response.dart';
import 'package:cinema_booker/providers/auth_provider.dart';
import 'package:cinema_booker/services/auth_service.dart';
import 'package:cinema_booker/router/admin_routes.dart';
import 'package:cinema_booker/router/auth_routes.dart';
import 'package:cinema_booker/theme/theme_color.dart';
import 'package:cinema_booker/widgets/screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      ApiResponse<SignInResponse> response = await _authService.signIn(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (response.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.error!),
          ),
        );
      } else {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setString(
          ApiConstants.tokenKey,
          response.data!.token,
        );

        ApiResponse<GetMeResponse> meResponse = await _authService.me();
        if (meResponse.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(meResponse.error!),
            ),
          );
        } else if (meResponse.data != null) {
          GetMeResponse me = meResponse.data!;
          Provider.of<AuthProvider>(context, listen: false).setUser(
            me.id,
            me.name,
            me.email,
            me.role,
            me.cinemaId,
          );

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Sign in successful"),
            ),
          );
          context.go(AdminRoutes.adminDashboard);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            TextInput(
              hint: 'Email',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            PasswordInput(
              hint: 'Password',
              controller: _passwordController,
            ),
            const SizedBox(height: 16),
            ButtonText(
              label: "Forget password ?",
              onPressed: () => context.push(AuthRoutes.authForgetPassword),
            ),
            const SizedBox(height: 16),
            Button(label: "Sign In", onPressed: _signIn),
            const SizedBox(height: 16),
            const Divider(
              color: ThemeColor.brown100,
            ),
            const SizedBox(height: 16),
            Button(
              label: "Sign up as Manager",
              onPressed: () => context.push(AuthRoutes.authSignUpManager),
            ),
            const SizedBox(height: 16),
            Button(
              label: "Sign up as Viewer",
              onPressed: () => context.push(AuthRoutes.authSignUpViewer),
            ),
          ],
        ),
      ),
    );
  }
}
