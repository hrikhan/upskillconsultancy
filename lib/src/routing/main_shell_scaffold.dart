import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:upskill_consultancy/src/shared/widgets/app_bottom_nav_bar.dart';

/// The root scaffold hosting the persistent bottom navigation bar
/// for the main application shell using [StatefulNavigationShell].
class MainShellScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShellScaffold({
    super.key,
    required this.navigationShell,
  });

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: navigationShell.currentIndex,
        onTap: _onTap,
      ),
    );
  }
}
