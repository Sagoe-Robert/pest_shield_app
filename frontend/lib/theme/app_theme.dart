import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Open Sans + palette: teal #1FB48A, navy #364F6C, charcoal #2B2C31.
abstract final class AppColors {
  static const Color teal = Color(0xFF1FB48A);
  static const Color navy = Color(0xFF364F6C);
  static const Color charcoal = Color(0xFF2B2C31);
  static const Color pageBg = Color(0xFFF5F7FA);
  static const Color cardBorder = Color(0xFFE8ECF0);
  static const Color danger = Color(0xFFE53935);
}

ThemeData buildAppTheme() {
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: AppColors.teal,
      onPrimary: Colors.white,
      secondary: AppColors.navy,
      onSecondary: Colors.white,
      surface: Colors.white,
      onSurface: AppColors.charcoal,
      error: AppColors.danger,
    ),
  );

  return base.copyWith(
    scaffoldBackgroundColor: AppColors.pageBg,
    textTheme: GoogleFonts.openSansTextTheme(base.textTheme).copyWith(
      headlineMedium: GoogleFonts.openSans(
        fontWeight: FontWeight.w700,
        fontSize: 24,
        color: AppColors.charcoal,
      ),
      headlineSmall: GoogleFonts.openSans(
        fontWeight: FontWeight.w700,
        fontSize: 20,
        color: AppColors.charcoal,
      ),
      titleLarge: GoogleFonts.openSans(
        fontWeight: FontWeight.w600,
        fontSize: 18,
        color: AppColors.charcoal,
      ),
      titleMedium: GoogleFonts.openSans(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: AppColors.charcoal,
      ),
      bodyLarge: GoogleFonts.openSans(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: AppColors.charcoal,
        height: 1.45,
      ),
      bodyMedium: GoogleFonts.openSans(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: AppColors.charcoal,
        height: 1.4,
      ),
      bodySmall: GoogleFonts.openSans(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        color: AppColors.charcoal.withValues(alpha: 0.75),
      ),
      labelLarge: GoogleFonts.openSans(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: AppColors.charcoal,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: AppColors.charcoal,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: GoogleFonts.openSans(
        fontWeight: FontWeight.w700,
        fontSize: 22,
        color: AppColors.charcoal,
      ),
      iconTheme: const IconThemeData(color: AppColors.navy),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.cardBorder),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white,
      indicatorColor: AppColors.teal.withValues(alpha: 0.2),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        final selected = states.contains(WidgetState.selected);
        return GoogleFonts.openSans(
          fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
          fontSize: 12,
          color: selected ? AppColors.teal : AppColors.navy.withValues(alpha: 0.75),
        );
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        final selected = states.contains(WidgetState.selected);
        return IconThemeData(
          color: selected ? AppColors.teal : AppColors.navy.withValues(alpha: 0.65),
          size: 24,
        );
      }),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.teal,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: GoogleFonts.openSans(fontWeight: FontWeight.w600, fontSize: 16),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.navy,
        side: const BorderSide(color: AppColors.navy, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: GoogleFonts.openSans(fontWeight: FontWeight.w600, fontSize: 14),
      ),
    ),
  );
}
