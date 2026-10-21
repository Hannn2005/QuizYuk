import 'package:flutter/material.dart';

class AppColors {
  static const bg = Color(0xFFFAFAFA); 
  static const primary = Color(0xFF364FAB); 
  static const mint = Color(0xFF00EDB3); 
  static const onMint = Color(0xFF0B1B2B);
  static const wrong = Color(0xFFE5484D);
  static const darkBg = Color(0xFF111522);
  static const darkSurface = Color(0xFF1B2136);

  static bool isDark(BuildContext c) =>
      Theme.of(c).brightness == Brightness.dark;
  // Biru identitas; versi lebih terang untuk teks/border di Dark Mode agar kontras.
  static Color brand(BuildContext c) =>
      isDark(c) ? const Color(0xFF9DB0FF) : primary;
  static Color surface(BuildContext c) =>
      isDark(c) ? darkSurface : Colors.white;
}

class AppTheme {
  static final ThemeData light = _build(Brightness.light);
  static final ThemeData dark = _build(Brightness.dark);

  static ThemeData _build(Brightness b) {
    final dark = b == Brightness.dark;
    final scheme =
        ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: b,
        ).copyWith(
          primary: AppColors.primary,
          onPrimary: Colors.white,
          secondary: AppColors.mint,
          onSecondary: AppColors.onMint,
          surface: dark ? AppColors.darkSurface : Colors.white,
        );
    final base = ThemeData(
      useMaterial3: true,
      brightness: b,
      colorScheme: scheme,
      scaffoldBackgroundColor: dark ? AppColors.darkBg : AppColors.bg,
    );
    return base.copyWith(
      textTheme: base.textTheme.apply(fontFamily: 'PlusJakartaSans'),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'PlusJakartaSans',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: scheme.onSurface,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surface,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}

/// Membatasi lebar konten agar nyaman di tablet/browser.
class ContentWidth extends StatelessWidget {
  final Widget child;
  const ContentWidth({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 640),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w < 400 ? 16 : 24),
          child: child,
        ),
      ),
    );
  }
}
