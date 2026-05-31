class AppConstants {
  AppConstants._();

  // ── App Info ──────────────────────────────────────────────
  static const String appName = 'Quran Play';
  static const String appVersion = '1.0.0';

  // ── API Configuration ─────────────────────────────────────
  static const String baseUrl = 'https://api.alquran.cloud/v1';
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  // ── Storage Keys ──────────────────────────────────────────
  static const String themeKey = 'theme_mode';

  // ── Design Sizes (untuk ScreenUtil) ───────────────────────
  static const double designWidth = 375;
  static const double designHeight = 812;
}
