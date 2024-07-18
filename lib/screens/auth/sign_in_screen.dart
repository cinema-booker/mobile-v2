// ignore_for_file: use_build_context_synchronously

import 'package:cinema_booker/api/api_constants.dart';
import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/features/auth/data/get_me_response.dart';
import 'package:cinema_booker/features/auth/data/sign_in_response.dart';
import 'package:cinema_booker/features/auth/providers/auth_provider.dart';
import 'package:cinema_booker/features/auth/services/auth_service.dart';
import 'package:cinema_booker/router/admin_routes.dart';
import 'package:cinema_booker/router/auth_routes.dart';
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
      ApiResponse<SignInResponse> response = await _authService.signInV2(
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

        ApiResponse<GetMeResponse> meResponse = await _authService.meV2();
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
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "Email",
              ),
            ),
            TextFormField(
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              decoration: const InputDecoration(
                hintText: "Password",
              ),
            ),
            ElevatedButton(
              onPressed: _signIn,
              child: const Text('Sign In'),
            ),
            ElevatedButton(
              onPressed: () {
                context.push(AuthRoutes.authForgetPassword);
              },
              child: const Text('Forget Password'),
            ),
            ElevatedButton(
              onPressed: () {
                context.push(AuthRoutes.authSignUpViewer);
              },
              child: const Text('Sign Up as Viewer'),
            ),
            ElevatedButton(
              onPressed: () {
                context.push(AuthRoutes.authSignUpManager);
              },
              child: const Text('Sign Up as Manager'),
            ),
          ],
        ),
      ),
    );
  }
}
