import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:upskill_consultancy/src/theme/theme_constants.dart';

/// Ultra-responsive custom bottom navigation bar featuring:
/// - 4 symmetrical side tabs with labels: Home, Courses, Services, Dashboard
/// - Center floating action button for "My Learning" (Icon-only, no label)
/// - Dynamic color switching: Vibrant #2BA2DD blue gradient when selected, sleek neutral when unselected
/// - Smooth rounded bar with crisp top border and soft elevation shadow (no notch cutout)
/// - Flexible layout with FittedBox scaling to guarantee zero text overflow on all devices
/// - Material 3 adaptive theming (Light and Dark mode)
/// - Interactive scale animations and haptic feedback
class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const double _barHeight = 66;
  static const double _fabSize = 56;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final backgroundColor = isDark ? UCColors.surfaceDark : colorScheme.surface;
    final borderColor = isDark ? const Color(0xFF2D3748) : const Color(0xFFE2E8F0);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: (isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark).copyWith(
        systemNavigationBarColor: backgroundColor,
        systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(24),
          ),
          border: Border(
            top: BorderSide(color: borderColor, width: 1.2),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.06),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: _barHeight,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // 5 navigation slots: 4 side tabs + 1 center spacer (No label for My Learning)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Tab 0: Home
                    Expanded(
                      child: _NavItem(
                        index: 0,
                        currentIndex: currentIndex,
                        label: 'nav.home'.tr(),
                        activeIcon: IconsaxPlusBold.home,
                        inactiveIcon: IconsaxPlusLinear.home,
                        onTap: onTap,
                      ),
                    ),

                    // Tab 1: Courses
                    Expanded(
                      child: _NavItem(
                        index: 1,
                        currentIndex: currentIndex,
                        label: 'nav.courses'.tr(),
                        activeIcon: IconsaxPlusBold.book_1,
                        inactiveIcon: IconsaxPlusLinear.book_1,
                        onTap: onTap,
                      ),
                    ),

                    // Tab 2: Clean center spacer slot (NO text label)
                    const Expanded(
                      child: SizedBox(),
                    ),

                    // Tab 3: Services
                    Expanded(
                      child: _NavItem(
                        index: 3,
                        currentIndex: currentIndex,
                        label: 'nav.services'.tr(),
                        activeIcon: IconsaxPlusBold.briefcase,
                        inactiveIcon: IconsaxPlusLinear.briefcase,
                        onTap: onTap,
                      ),
                    ),

                    // Tab 4: Dashboard
                    Expanded(
                      child: _NavItem(
                        index: 4,
                        currentIndex: currentIndex,
                        label: 'nav.dashboard'.tr(),
                        activeIcon: IconsaxPlusBold.category,
                        inactiveIcon: IconsaxPlusLinear.category,
                        onTap: onTap,
                      ),
                    ),
                  ],
                ),

                // Center Floating Action Button (Color changes dynamically when selected)
                Positioned(
                  top: -(_fabSize * 0.36),
                  child: _CenterFloatingButton(
                    isSelected: currentIndex == 2,
                    isDark: isDark,
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      onTap(2);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Standard item for the side tabs with responsive text scaling
class _NavItem extends StatelessWidget {
  final int index;
  final int currentIndex;
  final String label;
  final IconData activeIcon;
  final IconData inactiveIcon;
  final ValueChanged<int> onTap;

  const _NavItem({
    required this.index,
    required this.currentIndex,
    required this.label,
    required this.activeIcon,
    required this.inactiveIcon,
    required this.onTap,
  });

  bool get isSelected => currentIndex == index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    const primaryColor = UCColors.primary;
    final unselectedColor = colorScheme.onSurfaceVariant.withValues(alpha: 0.65);

    return InkWell(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap(index);
      },
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated Icon
            AnimatedScale(
              scale: isSelected ? 1.08 : 1.0,
              duration: AppDurations.fast,
              curve: AppCurves.standard,
              child: AnimatedSwitcher(
                duration: AppDurations.fast,
                child: Icon(
                  isSelected ? activeIcon : inactiveIcon,
                  key: ValueKey<bool>(isSelected),
                  color: isSelected ? primaryColor : unselectedColor,
                  size: 24,
                ),
              ),
            ),
            const SizedBox(height: 3),

            // Responsive Animated Label (never overflows or clips)
            FittedBox(
              fit: BoxFit.scaleDown,
              child: AnimatedDefaultTextStyle(
                duration: AppDurations.fast,
                curve: AppCurves.standard,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? primaryColor : unselectedColor,
                  letterSpacing: 0.1,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                child: Text(label),
              ),
            ),
            const SizedBox(height: 2),

            // Active Dot Indicator
            AnimatedContainer(
              duration: AppDurations.fast,
              curve: AppCurves.standard,
              width: isSelected ? 4 : 0,
              height: 4,
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : Colors.transparent,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Floating center button for "My Learning" (Icon-only, no label, dynamic color switching)
class _CenterFloatingButton extends StatelessWidget {
  final bool isSelected;
  final bool isDark;
  final VoidCallback onTap;

  const _CenterFloatingButton({
    required this.isSelected,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const size = AppBottomNavBar._fabSize;

    // Same iconic UpSkill Blue color, reversed gradient when selected
    final gradient = isSelected
        ? const LinearGradient(
            colors: [
              Color(0xFF0072BD),
              UCColors.primary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : const LinearGradient(
            colors: [
              UCColors.primary,
              Color(0xFF0072BD),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );

    final shadowColor = UCColors.primary.withValues(
      alpha: isSelected ? 0.65 : (isDark ? 0.42 : 0.32),
    );

    return Tooltip(
      message: 'nav.my_learning'.tr(),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: AppDurations.fast,
          curve: AppCurves.standard,
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: gradient,
            border: Border.all(
              color: Colors.white,
              width: isSelected ? 3.0 : 2.0,
            ),
            boxShadow: [
              BoxShadow(
                color: shadowColor,
                blurRadius: isSelected ? 16 : 10,
                spreadRadius: isSelected ? 2 : 0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: AnimatedScale(
              scale: isSelected ? 1.1 : 1.0,
              duration: AppDurations.fast,
              curve: AppCurves.standard,
              child: const Icon(
                IconsaxPlusBold.teacher,
                color: Colors.white,
                size: 26,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
