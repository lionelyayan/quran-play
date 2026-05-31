import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Brand Colors ──────────────────────────────────────────
  static const Color primary = Color(0xFFD92126);
  static const Color primaryDark = Color(0xFF8F1216);
  static const Color primaryLight = Color(0xFFF09497);

  // ── Neutral Colors ────────────────────────────────────────
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF8F8F8);
  static const Color textPrimary = Color(0xFF222222);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textHint = Color(0xFF999999);
  static const Color divider = Color(0xFFE0E0E0);
  static const Color border = Color(0xFFD0D0D0);

  // ── Semantic Colors ───────────────────────────────────────
  static const Color success = Color(0xFF2ECC71);
  static const Color warning = Color(0xFFF39C12);
  static const Color error = Color(0xFFE74C3C);
  static const Color info = Color(0xFF3498DB);

  // ── Dark Theme Colors ─────────────────────────────────────
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkCard = Color(0xFF2A2A2A);
  static const Color darkTextPrimary = Color(0xFFF5F5F5);
  static const Color darkTextSecondary = Color(0xFFB0B0B0);
  static const Color darkTextHint = Color(0xFF757575);
  static const Color darkDivider = Color(0xFF3A3A3A);
  static const Color darkBorder = Color(0xFF444444);

  // ── Dark Brand Colors ──────────────────────────────────────
  static const Color darkPrimary = Color(0xFFE8555A);
  static const Color darkPrimaryDark = Color(0xFFB82E33);
  static const Color darkPrimaryLight = Color(0xFF5C2325);
  static const Color darkAccent = Color(0xFFF4B8BA);

  // ── Dark Semantic Colors ──────────────────────────────────
  static const Color darkSuccess = Color(0xFF5AE099);
  static const Color darkWarning = Color(0xFFF7B84D);
  static const Color darkError = Color(0xFFEF7B73);
  static const Color darkInfo = Color(0xFF6BB3E8);

  // ── Shimmer / Skeleton ────────────────────────────────────
  static const Color shimmerBase = Color(0xFFE0E0E0);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);
  static const Color darkShimmerBase = Color(0xFF2A2A2A);
  static const Color darkShimmerHighlight = Color(0xFF3A3A3A);

  // ── Material Color Swatch ─────────────────────────────────────
  static const MaterialColor primarySwatch = MaterialColor(
    0xFFD92126,
    <int, Color>{
      50: Color(0xFFFBE4E5),
      100: Color(0xFFF5BCBE),
      200: Color(0xFFF09497),
      300: Color(0xFFE86B6E),
      400: Color(0xFFE14A4E),
      500: Color(0xFFD92126),
      600: Color(0xFFCB1D22),
      700: Color(0xFFBA171C),
      800: Color(0xFFAA1217),
      900: Color(0xFF8F1216),
    },
  );
}
