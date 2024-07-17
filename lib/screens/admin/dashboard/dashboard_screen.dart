import 'package:cinema_booker/features/auth/providers/auth_provider.dart';
import 'package:cinema_booker/theme/theme_color.dart';
import 'package:cinema_booker/theme/theme_font.dart';
import 'package:cinema_booker/widgets/screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;

    return Screen(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome, ${user.name} (${user.role})',
            style: const TextStyle(
              fontSize: ThemeFontSize.s24,
              color: ThemeColor.white,
            ),
          ),
        ],
      ),
    );
  }
}
