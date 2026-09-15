import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:upskill_consultancy/src/features/home/data/models/membership_plan_model.dart';
import 'package:upskill_consultancy/src/theme/color_schemes.dart';

/// Student Subscription / Membership Plans Section
/// As per UpSkill business model: Courses are unlocked via 3 student membership plans.
/// Features clean, minimal design with soft grey shadows (no harsh color shadows) and a direct 'Join' button.
class HomeSubscriptionSection extends StatelessWidget {
  final List<MembershipPlanModel> plans;
  final ValueChanged<MembershipPlanModel>? onJoinPlan;

  const HomeSubscriptionSection({
    super.key,
    this.plans = MembershipPlanModel.defaultPlans,
    this.onJoinPlan,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 18,
                decoration: BoxDecoration(
                  color: UCColors.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Student Membership',
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: colorScheme.onSurface,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isDark
                      ? colorScheme.surfaceContainerHighest.withValues(alpha: 0.5)
                      : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'All-Access Learning',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Horizontal 3 Subscription Cards
        SizedBox(
          height: 275,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: plans.length,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              final plan = plans[index];
              return _SubscriptionCard(
                plan: plan,
                isDark: isDark,
                onJoin: () {
                  if (onJoinPlan != null) {
                    onJoinPlan!(plan);
                  } else {
                    _showJoinSuccess(context, plan);
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _showJoinSuccess(BuildContext context, MembershipPlanModel plan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Selected ${plan.name} plan (${plan.price}${plan.period})',
          style: GoogleFonts.inter(fontSize: 13),
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

class _SubscriptionCard extends StatelessWidget {
  final MembershipPlanModel plan;
  final bool isDark;
  final VoidCallback onJoin;

  const _SubscriptionCard({
    required this.plan,
    required this.isDark,
    required this.onJoin,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Subtle border and clean neutral surface
    final borderColor = plan.isPopular
        ? UCColors.primary.withValues(alpha: 0.6)
        : colorScheme.outlineVariant.withValues(alpha: isDark ? 0.25 : 0.45);

    return Container(
      width: 240,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? UCColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor, width: plan.isPopular ? 1.5 : 1),
        // Soft neutral grey shadow only - zero harsh colored shadows
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
          // Header: Plan Name + Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                plan.name,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: colorScheme.onSurface,
                ),
              ),
              if (plan.badge != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                  decoration: BoxDecoration(
                    color: plan.isPopular
                        ? UCColors.primary
                        : (isDark
                            ? colorScheme.surfaceContainerHighest
                            : const Color(0xFFE2E8F0)),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    plan.badge!,
                    style: GoogleFonts.poppins(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w600,
                      color: plan.isPopular ? Colors.white : colorScheme.onSurface,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 8),

          // Price
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                plan.price,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(width: 3),
              Text(
                plan.period,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Core Features List (Max 3 for conciseness)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: plan.features.take(3).map((feature) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.check_circle_rounded,
                        size: 14,
                        color: UCColors.primary,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          feature,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            fontSize: 11.5,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 8),

          // Join Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: plan.isPopular ? UCColors.primary : Colors.transparent,
                foregroundColor: plan.isPopular ? Colors.white : UCColors.primary,
                elevation: 0,
                side: plan.isPopular
                    ? BorderSide.none
                    : BorderSide(
                        color: UCColors.primary.withValues(alpha: 0.5),
                        width: 1,
                      ),
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: onJoin,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Join Plan',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(IconsaxPlusLinear.arrow_right_3, size: 14),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
