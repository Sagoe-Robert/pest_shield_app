import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Settings', style: t.textTheme.headlineSmall),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.science_outlined, color: AppColors.teal),
                  title: Text('Classifier', style: t.textTheme.titleSmall),
                  subtitle: Text(
                    'Uses Render/FastAPI when API_BASE_URL is provided; otherwise falls back to demo scores.',
                    style: t.textTheme.bodySmall,
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.cloud_outlined, color: AppColors.navy.withValues(alpha: 0.75)),
                  title: Text('Deploy target', style: t.textTheme.titleSmall),
                  subtitle: const Text('Render web service: POST /analyze-pest'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.info_outline_rounded, color: AppColors.navy.withValues(alpha: 0.75)),
                  title: Text('Version', style: t.textTheme.titleSmall),
                  subtitle: const Text('1.0.0'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
