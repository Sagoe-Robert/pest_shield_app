import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_theme.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      (
        'Scouting rhythm',
        'Walk transects weekly; focus on crop edges and stressed plants.',
      ),
      (
        'Photo quality',
        'Fill the frame with the pest or damage; avoid harsh shadow.',
      ),
      (
        'Before spraying',
        'Confirm ID with extension; respect PHI labels.',
      ),
    ];
    return SafeArea(
      child: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: items.length + 1,
        itemBuilder: (context, i) {
          if (i == 0) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text('Field tips', style: Theme.of(context).textTheme.headlineSmall),
            );
          }
          final item = items[i - 1];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(18),
                leading: CircleAvatar(
                  backgroundColor: AppColors.teal.withValues(alpha: 0.15),
                  foregroundColor: AppColors.teal,
                  child: const Icon(Icons.eco_rounded),
                ),
                title: Text(item.$1, style: GoogleFonts.openSans(fontWeight: FontWeight.w600)),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(item.$2),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
