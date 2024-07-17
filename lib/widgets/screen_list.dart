import 'package:flutter/material.dart';

class ScreenList extends StatelessWidget {
  final Widget child;
  final PreferredSizeWidget? appBar;

  const ScreenList({
    super.key,
    required this.child,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: child,
      ),
    );
  }
}
