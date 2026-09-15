import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:upskill_consultancy/src/theme/color_schemes.dart';

class WeProvideItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final VoidCallback onTap;

  const WeProvideItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.onTap,
  });
}

/// "We Provide" 2x2 Section:
/// Horizontally 2, Vertically 2 lines:
/// 1. ITES Products
/// 2. Digital Services
/// 3. Public & Enterprise Solutions
/// 4. UpSkill Academia
/// Clean vertical card layout so titles never get clipped with an ellipsis.
class HomeWeProvideSection extends StatelessWidget {
  final VoidCallback onItesTap;
  final VoidCallback onDigitalServicesTap;
  final VoidCallback onPublicEnterpriseTap;
  final VoidCallback onAcademiaTap;

  const HomeWeProvideSection({
    super.key,
    required this.onItesTap,
    required this.onDigitalServicesTap,
    required this.onPublicEnterpriseTap,
    required this.onAcademiaTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final items = [
      WeProvideItem(
        title: 'ITES Products',
        subtitle: 'Software & SaaS',
        icon: IconsaxPlusBold.box_1,
        iconColor: UCColors.primary,
        iconBgColor: UCColors.primary.withValues(alpha: 0.1),
        onTap: onItesTap,
      ),
      WeProvideItem(
        title: 'Digital Services',
        subtitle: 'Cloud & Tech Teams',
        icon: IconsaxPlusBold.global,
        iconColor: const Color(0xFF0D9488),
        iconBgColor: const Color(0xFF0D9488).withValues(alpha: 0.1),
        onTap: onDigitalServicesTap,
      ),
      WeProvideItem(
        title: 'Public & Enterprise Solutions',
        subtitle: 'AI, SOC & SCADA',
        icon: IconsaxPlusBold.shield_security,
        iconColor: const Color(0xFF6366F1),
        iconBgColor: const Color(0xFF6366F1).withValues(alpha: 0.1),
        onTap: onPublicEnterpriseTap,
      ),
      WeProvideItem(
        title: 'Academic',
        subtitle: 'Training & Career',
        icon: IconsaxPlusBold.teacher,
        iconColor: const Color(0xFFF59E0B),
        iconBgColor: const Color(0xFFF59E0B).withValues(alpha: 0.1),
        onTap: onAcademiaTap,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title (No vertical divider, verified spelling: "We Provide")
          Text(
            'We Provide',
            style: GoogleFonts.poppins(
              fontSize: 16.5,
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 10),

          // 2x2 Grid (Horizontally 2, Vertically 2 lines)
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: _WeProvideCard(
                    item: items[0],
                    isDark: isDark,
                    colorScheme: colorScheme,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _WeProvideCard(
                    item: items[1],
                    isDark: isDark,
                    colorScheme: colorScheme,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: _WeProvideCard(
                    item: items[2],
                    isDark: isDark,
                    colorScheme: colorScheme,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _WeProvideCard(
                    item: items[3],
                    isDark: isDark,
                    colorScheme: colorScheme,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WeProvideCard extends StatelessWidget {
  final WeProvideItem item;
  final bool isDark;
  final ColorScheme colorScheme;

  const _WeProvideCard({
    required this.item,
    required this.isDark,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = isDark ? const Color(0xFF2D3748) : const Color(0xFFE2E8F0);

    return InkWell(
      onTap: item.onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark ? UCColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
              blurRadius: 4,
              offset: const Offset(0, 1.5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Top Row: Decreased Icon Container + Subtle Chevron
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: item.iconBgColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Icon(
                      item.icon,
                      color: item.iconColor,
                      size: 15,
                    ),
                  ),
                ),
                Icon(
                  IconsaxPlusLinear.arrow_right_3,
                  size: 12,
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.45),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Title in ONE line + Subtitle
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    item.title,
                    maxLines: 1,
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onSurface,
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w400,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
