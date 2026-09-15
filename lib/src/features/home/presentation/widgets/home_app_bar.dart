import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:upskill_consultancy/src/routing/app_routes.dart';
import 'package:upskill_consultancy/src/theme/color_schemes.dart';
import 'package:upskill_consultancy/src/features/home/data/models/announcement_model.dart';
import 'package:upskill_consultancy/src/features/home/presentation/widgets/announcement_modal_sheet.dart';

/// Step 11: Home App Bar
/// Features:
/// - Official UC logo
/// - UpSkill brand typography ("Up" in Charcoal/White, "Skill" in vibrant UC Blue)
/// - Announcement action button with badge indicator (as explicitly requested)
/// - Notification and Profile quick-actions
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<AnnouncementModel> announcements;
  final VoidCallback? onNotificationTap;

  const HomeAppBar({
    super.key,
    required this.announcements,
    this.onNotificationTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(66);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final backgroundColor = isDark ? UCColors.surfaceDark : colorScheme.surface;
    final borderColor = isDark ? const Color(0xFF2D3748) : const Color(0xFFE2E8F0);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          bottom: BorderSide(color: borderColor, width: 1.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.05),
            blurRadius: 4,
            offset: const Offset(0, 1.5),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              // Logo + Brand Text
              Image.asset(
                'assets/icons/uc_icon_transparent.png',
                height: 34,
                width: 34,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: UCColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'UC',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),

              // UpSkill Brand Typography: Up in primary color, Skill & Consultancy in graytype color
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Up',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: UCColors.primary,
                            letterSpacing: -0.4,
                          ),
                        ),
                        TextSpan(
                          text: 'Skill',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: isDark ? const Color(0xFFCBD5E1) : const Color(0xFF475569),
                            letterSpacing: -0.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'CONSULTANCY',
                    style: GoogleFonts.poppins(
                      fontSize: 8.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                      color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // Action 1: Announcement Icon with badge
              _ActionButton(
                icon: Icons.campaign_rounded,
                hasBadge: announcements.isNotEmpty,
                badgeColor: const Color(0xFFF59E0B), // Amber badge
                tooltip: 'Announcements',
                onTap: () {
                  AnnouncementModalSheet.show(context, announcements);
                },
              ),

              const SizedBox(width: 8),

              // Action 2: Notifications Icon with unread dot
              _ActionButton(
                icon: IconsaxPlusLinear.notification_bing,
                hasBadge: true,
                badgeColor: UCColors.primary,
                tooltip: 'Notifications',
                onTap: () {
                  if (onNotificationTap != null) {
                    onNotificationTap!();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'No new notifications at this time',
                          style: GoogleFonts.inter(fontSize: 13),
                        ),
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                },
              ),

              const SizedBox(width: 8),

              // Action 3: Profile Avatar (Navigates to Dashboard)
              InkWell(
                onTap: () => context.go(AppRoutes.dashboard),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [
                        UCColors.primary,
                        UCColors.primaryDark,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(
                      color: UCColors.white.withValues(alpha: 0.3),
                      width: 1.5,
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      IconsaxPlusBold.user,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final bool hasBadge;
  final Color badgeColor;
  final String tooltip;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.hasBadge,
    required this.badgeColor,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colorScheme = theme.colorScheme;

    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: isDark
                ? colorScheme.surfaceContainerHighest.withValues(alpha: 0.4)
                : UCColors.backgroundLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: colorScheme.outlineVariant.withValues(alpha: isDark ? 0.2 : 0.4),
              width: 1,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                icon,
                size: 20,
                color: colorScheme.onSurface,
              ),
              if (hasBadge)
                Positioned(
                  top: 7,
                  right: 7,
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: badgeColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isDark ? UCColors.surfaceDark : Colors.white,
                        width: 1,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
