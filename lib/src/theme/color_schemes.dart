import 'package:flutter/material.dart';

/// App-specific colors that aren't part of the standard [ColorScheme].
/// Access via `context.appColors` (defined in `context_extension.dart`).
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  const AppColorsExtension({
    required this.success,
    required this.onSuccess,
    required this.warning,
    required this.onWarning,
    required this.info,
    required this.onInfo,
    this.successContainer,
    this.onSuccessContainer,
    this.warningContainer,
    this.onWarningContainer,
    this.infoContainer,
    this.onInfoContainer,
  });

  final Color success;
  final Color onSuccess;
  final Color warning;
  final Color onWarning;
  final Color info;
  final Color onInfo;
  final Color? successContainer;
  final Color? onSuccessContainer;
  final Color? warningContainer;
  final Color? onWarningContainer;
  final Color? infoContainer;
  final Color? onInfoContainer;

  @override
  ThemeExtension<AppColorsExtension> copyWith({
    Color? success,
    Color? onSuccess,
    Color? warning,
    Color? onWarning,
    Color? info,
    Color? onInfo,
    Color? successContainer,
    Color? onSuccessContainer,
    Color? warningContainer,
    Color? onWarningContainer,
    Color? infoContainer,
    Color? onInfoContainer,
  }) {
    return AppColorsExtension(
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      info: info ?? this.info,
      onInfo: onInfo ?? this.onInfo,
      successContainer: successContainer ?? this.successContainer,
      onSuccessContainer: onSuccessContainer ?? this.onSuccessContainer,
      warningContainer: warningContainer ?? this.warningContainer,
      onWarningContainer: onWarningContainer ?? this.onWarningContainer,
      infoContainer: infoContainer ?? this.infoContainer,
      onInfoContainer: onInfoContainer ?? this.onInfoContainer,
    );
  }

  @override
  ThemeExtension<AppColorsExtension> lerp(
    covariant ThemeExtension<AppColorsExtension>? other,
    double t,
  ) {
    if (other is! AppColorsExtension) {
      return this;
    }
    return AppColorsExtension(
      success: Color.lerp(success, other.success, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      onWarning: Color.lerp(onWarning, other.onWarning, t)!,
      info: Color.lerp(info, other.info, t)!,
      onInfo: Color.lerp(onInfo, other.onInfo, t)!,
      successContainer: Color.lerp(successContainer, other.successContainer, t),
      onSuccessContainer: Color.lerp(onSuccessContainer, other.onSuccessContainer, t),
      warningContainer: Color.lerp(warningContainer, other.warningContainer, t),
      onWarningContainer: Color.lerp(onWarningContainer, other.onWarningContainer, t),
      infoContainer: Color.lerp(infoContainer, other.infoContainer, t),
      onInfoContainer: Color.lerp(onInfoContainer, other.onInfoContainer, t),
    );
  }
}

/// UC Brand Colors as defined in development plan:
/// Original UC Blue, Charcoal and White.
class UCColors {
  UCColors._();

  // Primary Brand Colors
  static const Color primary = Color(0xFF2BA2DD); // UpSkill Primary Blue
  static const Color primaryDark = Color(0xFF1E88C7);
  static const Color primaryLight = Color(0xFFE8F6FD);

  // Charcoal Palette
  static const Color charcoal = Color(0xFF3C4A54); // Original UC Charcoal
  static const Color charcoalDark = Color(0xFF1E252B); // Deep Charcoal
  static const Color charcoalLight = Color(0xFF5A6874);

  // Neutral Palette
  static const Color white = Colors.white;
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color surfaceLight = Color(0xFFFFFFFF);

  static const Color backgroundDark = Color(0xFF12161A);
  static const Color surfaceDark = Color(0xFF1E252B);

  // Semantic
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF2BA2DD);
}

/// Helper class to define the actual color palettes
class AppPalettes {
  AppPalettes._();

  static const light = AppColorsExtension(
    success: UCColors.success,
    onSuccess: Colors.white,
    successContainer: Color(0xFFD1FAE5),
    onSuccessContainer: Color(0xFF065F46),
    warning: UCColors.warning,
    onWarning: Colors.white,
    warningContainer: Color(0xFFFEF3C7),
    onWarningContainer: Color(0xFF92400E),
    info: UCColors.info,
    onInfo: Colors.white,
    infoContainer: UCColors.primaryLight,
    onInfoContainer: UCColors.primaryDark,
  );

  static const dark = AppColorsExtension(
    success: Color(0xFF34D399),
    onSuccess: Color(0xFF064E3B),
    successContainer: Color(0xFF065F46),
    onSuccessContainer: Color(0xFFA7F3D0),
    warning: Color(0xFFFBBF24),
    onWarning: Color(0xFF78350F),
    warningContainer: Color(0xFF92400E),
    onWarningContainer: Color(0xFFFDE68A),
    info: Color(0xFF38BDF8),
    onInfo: Color(0xFF0C4A6E),
    infoContainer: Color(0xFF0369A1),
    onInfoContainer: Color(0xFFBAE6FD),
  );
}

/// Access semantic colors via `context.appColors` from `context_extension.dart`.
/// Example: `context.appColors.success`
