import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Profile', style: t.textTheme.headlineSmall),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: AppColors.teal.withValues(alpha: 0.2),
                    child: Icon(Icons.groups_rounded, size: 32, color: AppColors.navy),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Group 26B', style: GoogleFonts.openSans(fontWeight: FontWeight.w700, fontSize: 18)),
                        const SizedBox(height: 4),
                        Text('Dept. of IT & Decision Science · Pest Shield', style: t.textTheme.bodySmall),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.school_outlined, color: AppColors.navy.withValues(alpha: 0.8)),
                  title: Text('Supervisor', style: t.textTheme.titleSmall),
                  subtitle: const Text('Mr. Michael Ayitey Junior'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.shield_outlined, color: AppColors.teal),
                  title: Text('Scope', style: t.textTheme.titleSmall),
                  subtitle: const Text('AI-assisted pest identification for Ghanaian smallholders.'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
