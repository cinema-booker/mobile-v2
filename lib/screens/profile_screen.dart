import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cinema_booker/providers/auth_provider.dart';
import 'package:cinema_booker/theme/theme_color.dart';
import 'package:cinema_booker/theme/theme_font.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Profile",
              style: TextStyle(
                fontSize: ThemeFontSize.s32,
                color: ThemeColor.white,
              ),
            ),
            Text(
              "Welcome, ${user.name} (${user.role})",
              style: const TextStyle(
                fontSize: ThemeFontSize.s24,
                color: ThemeColor.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
