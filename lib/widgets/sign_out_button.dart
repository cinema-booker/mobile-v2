// ignore_for_file: use_build_context_synchronously

import 'package:cinema_booker/api/api_constants.dart';
import 'package:cinema_booker/features/auth/providers/auth_provider.dart';
import 'package:cinema_booker/router/auth_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({super.key});

  Future<void> _signOut(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(ApiConstants.tokenKey);

    Provider.of<AuthProvider>(context, listen: false)
        .setUser(-1, "", "", "", null);

    context.go(AuthRoutes.authSignIn);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Signed out successfully"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _signOut(context);
      },
      child: const Text("Sign Out"),
    );
  }
}
