import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:upskill_consultancy/src/theme/color_schemes.dart';

class EnterpriseSolutionItem {
  final String id;
  final String title;
  final String domain;
  final String description;
  final String badge;
  final String imageUrl;
  final IconData icon;

  const EnterpriseSolutionItem({
    required this.id,
    required this.title,
    required this.domain,
    required this.description,
    required this.badge,
    required this.imageUrl,
    required this.icon,
  });
}

/// Top Public & Enterprise Solutions Section
/// Displays UpSkill's public sector and enterprise digital transformation solutions.
class HomeEnterpriseSolutionsSection extends StatelessWidget {
  final VoidCallback onViewAll;
  final ValueChanged<EnterpriseSolutionItem>? onSolutionTap;

  const HomeEnterpriseSolutionsSection({
    super.key,
    required this.onViewAll,
    this.onSolutionTap,
  });

  static const List<EnterpriseSolutionItem> solutions = [
    EnterpriseSolutionItem(
      id: 'sol_01',
      title: 'AI CRM & Agentic Automation',
      domain: 'Enterprise Intelligence',
      description:
          'Autonomous customer service agents, smart workflow routing & predictive revenue analytics.',
      badge: 'Enterprise AI',
      imageUrl:
          'https://images.unsplash.com/photo-1551836022-d5d88e9218df?w=600&auto=format&fit=crop&q=80',
      icon: IconsaxPlusBold.cpu,
    ),
    EnterpriseSolutionItem(
      id: 'sol_02',
      title: 'Cyber Security & SOC Defense',
      domain: 'Public & Enterprise Defense',
      description:
          '24/7 SIEM threat monitoring, Zero-Trust network segmentation & vulnerability hardening.',
      badge: 'Zero-Trust',
      imageUrl:
          'https://images.unsplash.com/photo-1563986768609-322da13575f3?w=600&auto=format&fit=crop&q=80',
      icon: IconsaxPlusBold.shield_security,
    ),
    EnterpriseSolutionItem(
      id: 'sol_03',
      title: 'Supply Chain SCADA Telemetry',
      domain: 'Industrial Infrastructure',
      description:
          'High-precision telemetry, automated distribution logistics & predictive hardware maintenance.',
      badge: 'SCADA IoT',
      imageUrl:
          'https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?w=600&auto=format&fit=crop&q=80',
      icon: IconsaxPlusBold.truck_fast,
    ),
    EnterpriseSolutionItem(
      id: 'sol_04',
      title: 'E-Government Citizen Portals',
      domain: 'Public Sector Governance',
      description:
          'Unified digital citizen identity, automated civic licensing & multi-ministry document vaults.',
      badge: 'Public Sector',
      imageUrl:
          'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=600&auto=format&fit=crop&q=80',
      icon: IconsaxPlusBold.buildings,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header (No vertical divider, overflow-safe)
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'Public & Enterprise Solutions',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: onViewAll,
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'View All',
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: UCColors.primary,
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Icon(
                        IconsaxPlusLinear.arrow_right_3,
                        size: 13,
                        color: UCColors.primary,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // Horizontal Solution Cards
        SizedBox(
          height: 255,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: solutions.length,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              final solution = solutions[index];
              return _EnterpriseSolutionCard(
                solution: solution,
                isDark: isDark,
                onTap: () {
                  if (onSolutionTap != null) {
                    onSolutionTap!(solution);
                  } else {
                    onViewAll();
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _EnterpriseSolutionCard extends StatelessWidget {
  final EnterpriseSolutionItem solution;
  final bool isDark;
  final VoidCallback onTap;

  const _EnterpriseSolutionCard({
    required this.solution,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 245,
        decoration: BoxDecoration(
          color: isDark ? UCColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: colorScheme.outlineVariant.withValues(
              alpha: isDark ? 0.25 : 0.45,
            ),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail image with domain pill
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(7)),
              child: SizedBox(
                height: 105,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: solution.imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => ColoredBox(
                        color: isDark ? const Color(0xFF1E252B) : const Color(0xFFF1F5F9),
                      ),
                      errorWidget: (_, __, ___) => const ColoredBox(
                        color: UCColors.charcoalDark,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withValues(alpha: 0.5),
                            Colors.transparent,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    // Badge Top Left
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F766E), // Deep Teal badge for enterprise
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          solution.badge,
                          style: GoogleFonts.poppins(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Body
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    solution.domain.toUpperCase(),
                    style: GoogleFonts.poppins(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0F766E),
                      letterSpacing: 0.4,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    solution.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    solution.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: colorScheme.onSurfaceVariant,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Explore Link
                  Row(
                    children: [
                      Text(
                        'Request Solution',
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: UCColors.primary,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        IconsaxPlusLinear.arrow_right_3,
                        size: 11,
                        color: UCColors.primary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
