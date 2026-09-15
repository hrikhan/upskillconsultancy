import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:upskill_consultancy/src/theme/color_schemes.dart';

/// Step 16 (Part 2): Home Course Categories Section
/// Shows course categories below practice tools with responsive chips/cards.
class HomeCategoriesSection extends StatelessWidget {
  final List<String> categories;
  final ValueChanged<String> onCategoryTap;

  const HomeCategoriesSection({
    super.key,
    required this.categories,
    required this.onCategoryTap,
  });

  static const Map<String, IconData> _categoryIcons = {
    'Software Engineering': IconsaxPlusBold.code_1,
    'QA Automation': IconsaxPlusBold.verify,
    'Cloud & DevOps': IconsaxPlusBold.cloud,
    'AI & Data Science': IconsaxPlusBold.cpu,
    'Cyber Security': IconsaxPlusBold.shield_security,
    'General': IconsaxPlusBold.category,
  };

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 4),
          child: Text(
            'home.course_categories'.tr(),
            style: GoogleFonts.poppins(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'home.course_categories_sub'.tr(),
            style: GoogleFonts.inter(
              fontSize: 12,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Horizontal scrolling category chips / cards
        SizedBox(
          height: 90,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final cat = categories[index];
              final icon = _categoryIcons[cat] ?? IconsaxPlusBold.folder;

              return InkWell(
                onTap: () => onCategoryTap(cat),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 130,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark ? UCColors.surfaceDark : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: colorScheme.outlineVariant.withValues(
                        alpha: isDark ? 0.2 : 0.4,
                      ),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: isDark ? 0.15 : 0.03),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: UCColors.primary.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          icon,
                          color: UCColors.primary,
                          size: 20,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        cat,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
