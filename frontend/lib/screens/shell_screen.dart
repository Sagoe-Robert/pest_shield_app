import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';
import 'tips_screen.dart';

class ShellScreen extends StatefulWidget {
  const ShellScreen({super.key});

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {
  int _index = 0;

  static const _titles = ['Home', 'Field tips', 'Profile', 'Settings'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: const [
          HomeScreen(),
          TipsScreen(),
          ProfileScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home_outlined, color: AppColors.navy.withValues(alpha: 0.65)),
            selectedIcon: const Icon(Icons.home_rounded, color: AppColors.teal),
            label: _titles[0],
          ),
          NavigationDestination(
            icon: Icon(Icons.grass_outlined, color: AppColors.navy.withValues(alpha: 0.65)),
            selectedIcon: const Icon(Icons.eco_rounded, color: AppColors.teal),
            label: _titles[1],
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded, color: AppColors.navy.withValues(alpha: 0.65)),
            selectedIcon: const Icon(Icons.person_rounded, color: AppColors.teal),
            label: _titles[2],
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined, color: AppColors.navy.withValues(alpha: 0.65)),
            selectedIcon: const Icon(Icons.settings_rounded, color: AppColors.teal),
            label: _titles[3],
          ),
        ],
      ),
    );
  }
}
