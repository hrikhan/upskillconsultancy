import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Defines the full Material 3 typescale for UpSkill Consultancy.
/// Heading Font: Poppins
/// Body Font: Inter
/// Bengali Font: Noto Sans Bengali (fontFamilyFallback)
TextTheme buildTextTheme() {
  final bengaliFallback = [
    GoogleFonts.notoSansBengali().fontFamily!,
    'sans-serif',
  ];

  TextStyle poppinsStyle({
    required double fontSize,
    required FontWeight fontWeight,
    double letterSpacing = 0,
    double? height,
  }) {
    return GoogleFonts.poppins(
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        height: height,
        fontFamilyFallback: bengaliFallback,
      ),
    );
  }

  TextStyle interStyle({
    required double fontSize,
    required FontWeight fontWeight,
    double letterSpacing = 0,
    double? height,
  }) {
    return GoogleFonts.inter(
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        height: height,
        fontFamilyFallback: bengaliFallback,
      ),
    );
  }

  return TextTheme(
    // ── Display (Poppins) ──────────────────────────────────────────────────
    displayLarge: poppinsStyle(fontSize: 57, fontWeight: FontWeight.w700, letterSpacing: -0.25),
    displayMedium: poppinsStyle(fontSize: 45, fontWeight: FontWeight.w700, letterSpacing: 0),
    displaySmall: poppinsStyle(fontSize: 36, fontWeight: FontWeight.w600, letterSpacing: 0),

    // ── Headline (Poppins) ─────────────────────────────────────────────────
    headlineLarge: poppinsStyle(fontSize: 32, fontWeight: FontWeight.w600, letterSpacing: 0),
    headlineMedium: poppinsStyle(fontSize: 28, fontWeight: FontWeight.w600, letterSpacing: 0),
    headlineSmall: poppinsStyle(fontSize: 24, fontWeight: FontWeight.w600, letterSpacing: 0),

    // ── Title (Poppins) ────────────────────────────────────────────────────
    titleLarge: poppinsStyle(fontSize: 22, fontWeight: FontWeight.w600, letterSpacing: 0),
    titleMedium: poppinsStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.15),
    titleSmall: poppinsStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),

    // ── Body (Inter) ───────────────────────────────────────────────────────
    bodyLarge: interStyle(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
    bodyMedium: interStyle(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    bodySmall: interStyle(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),

    // ── Label (Inter) ──────────────────────────────────────────────────────
    labelLarge: interStyle(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.1),
    labelMedium: interStyle(fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.5),
    labelSmall: interStyle(fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 0.5),
  );
}

