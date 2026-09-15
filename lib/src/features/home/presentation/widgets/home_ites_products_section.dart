import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:upskill_consultancy/src/theme/color_schemes.dart';

class ItesProductItem {
  final String id;
  final String title;
  final String category;
  final String description;
  final String badge;
  final String imageUrl;
  final List<String> features;

  const ItesProductItem({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.badge,
    required this.imageUrl,
    required this.features,
  });
}

/// Top ITES Products Section
/// Displays UpSkill's flagship software and IT-enabled products.
class HomeItesProductsSection extends StatelessWidget {
  final VoidCallback onViewAll;
  final ValueChanged<ItesProductItem>? onProductTap;

  const HomeItesProductsSection({
    super.key,
    required this.onViewAll,
    this.onProductTap,
  });

  static const List<ItesProductItem> products = [
    ItesProductItem(
      id: 'ites_01',
      title: 'UpCare MediConnect',
      category: 'HealthTech & AI',
      description:
          'HIPAA-compliant EHR, smart telemedicine & automated clinical workflow system.',
      badge: 'AI-Powered',
      imageUrl:
          'https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?w=600&auto=format&fit=crop&q=80',
      features: ['Telehealth Portal', 'Smart EHR', 'E-Prescriptions'],
    ),
    ItesProductItem(
      id: 'ites_02',
      title: 'UpLearn EduTech',
      category: 'EdTech & SaaS',
      description:
          'Modern cloud LMS with interactive coding sandboxes, live webinars & AI assessment.',
      badge: 'Enterprise LMS',
      imageUrl:
          'https://images.unsplash.com/photo-1501504905252-473c47e087f8?w=600&auto=format&fit=crop&q=80',
      features: ['Interactive Labs', 'AI Proctoring', 'Skill Analytics'],
    ),
    ItesProductItem(
      id: 'ites_03',
      title: 'UpSales BizHub',
      category: 'CRM & ERP',
      description:
          'Omnichannel customer engagement, AI sales forecasting & automated marketing pipeline.',
      badge: 'Cloud CRM',
      imageUrl:
          'https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=600&auto=format&fit=crop&q=80',
      features: ['Omnichannel Inbox', 'Pipeline Automation', 'KPI Dashboard'],
    ),
    ItesProductItem(
      id: 'ites_04',
      title: 'Omni Smart SCADA',
      category: 'IoT & Telemetry',
      description:
          'Industrial telemetry, predictive machine maintenance & edge-device telemetry.',
      badge: 'IoT Solutions',
      imageUrl:
          'https://images.unsplash.com/photo-1518770660439-4636190af475?w=600&auto=format&fit=crop&q=80',
      features: ['Real-time Telemetry', 'Fault Prediction', 'Cloud SCADA'],
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
                  'Top ITES Products',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 16.5,
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

        // Horizontal Product Cards
        SizedBox(
          height: 255,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              final product = products[index];
              return _ItesProductCard(
                product: product,
                isDark: isDark,
                onTap: () {
                  if (onProductTap != null) {
                    onProductTap!(product);
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

class _ItesProductCard extends StatelessWidget {
  final ItesProductItem product;
  final bool isDark;
  final VoidCallback onTap;

  const _ItesProductCard({
    required this.product,
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
            // Thumbnail image with category pill
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(7)),
              child: SizedBox(
                height: 105,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: product.imageUrl,
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
                          color: UCColors.primary,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          product.badge,
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
                    product.category.toUpperCase(),
                    style: GoogleFonts.poppins(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w600,
                      color: UCColors.primary,
                      letterSpacing: 0.4,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    product.title,
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
                    product.description,
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
                        'Explore Product',
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
