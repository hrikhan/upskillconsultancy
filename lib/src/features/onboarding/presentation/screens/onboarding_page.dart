import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:upskill_consultancy/src/routing/app_routes.dart';
import 'package:upskill_consultancy/src/theme/color_schemes.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late final PageController _pageController;
  int _currentIndex = 0;

  final List<_OnboardingItem> _slides = const [
    _OnboardingItem(
      statKey: 'onboarding.stat_1',
      titleKey: 'onboarding.title_1',
      subtitleKey: 'onboarding.subtitle_1',
      assetPath: 'assets/images/onboarding1.png',
      badgeIcon: Icons.rocket_launch_rounded,
    ),
    _OnboardingItem(
      statKey: 'onboarding.stat_2',
      titleKey: 'onboarding.title_2',
      subtitleKey: 'onboarding.subtitle_2',
      assetPath: 'assets/images/onboarding2.png',
      badgeIcon: Icons.badge_rounded,
    ),
    _OnboardingItem(
      statKey: 'onboarding.stat_3',
      titleKey: 'onboarding.title_3',
      subtitleKey: 'onboarding.subtitle_3',
      assetPath: 'assets/images/onboarding3.png',
      badgeIcon: Icons.school_rounded,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _completeOnboarding() {
    // Navigate to membership screen after onboarding
    context.go(AppRoutes.membership);
  }

  void _onNext() {
    if (_currentIndex < _slides.length - 1) {
      _pageController.animateToPage(
        _currentIndex + 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _onBack() {
    if (_currentIndex > 0) {
      _pageController.animateToPage(
        _currentIndex - 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final size = MediaQuery.sizeOf(context);
    final cardSize = (size.width - 64).clamp(240.0, 310.0);

    return Scaffold(
      backgroundColor: isDark ? UCColors.backgroundDark : UCColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar: Brand Mark + Skip
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/uc_icon_transparent.png',
                        width: 34,
                        height: 34,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.apartment_rounded,
                          color: UCColors.primary,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'UpSkill Consultancy',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: isDark ? Colors.white : UCColors.charcoalDark,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ],
                  ),

                  // Skip Action
                  if (_currentIndex < _slides.length - 1)
                    TextButton(
                      onPressed: _completeOnboarding,
                      style: TextButton.styleFrom(
                        foregroundColor: isDark ? Colors.white70 : UCColors.charcoalLight,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      ),
                      child: Text(
                        'shared.skip'.tr(),
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  else
                    const SizedBox(width: 48, height: 36),
                ],
              ),
            ),

            // PageView Area with Silky-Smooth AnimatedBuilder Parallax & Scaling
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _slides.length,
                onPageChanged: (idx) => setState(() => _currentIndex = idx),
                itemBuilder: (context, index) {
                  final slide = _slides[index];

                  return AnimatedBuilder(
                    animation: _pageController,
                    builder: (context, child) {
                      double page = index.toDouble();
                      if (_pageController.hasClients &&
                          _pageController.position.haveDimensions &&
                          _pageController.page != null) {
                        page = _pageController.page!;
                      }
                      final double delta = index - page;
                      final double clampedDelta = delta.clamp(-1.0, 1.0);
                      final double absDelta = clampedDelta.abs();

                      // Silky smooth, continuous scaling and subtle parallax
                      final double scale =
                          (1.0 - (absDelta * 0.10)).clamp(0.90, 1.0);
                      final double opacity =
                          (1.0 - (absDelta * 0.45)).clamp(0.25, 1.0);
                      final double parallaxOffset = clampedDelta * -24.0;
                      final double textOffset = clampedDelta * 18.0;

                      return Opacity(
                        opacity: opacity,
                        child: Transform.scale(
                          scale: scale,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Spacer(),

                                // Hero Illustration Canvas with continuous breathing radial aura
                                Transform.translate(
                                  offset: Offset(parallaxOffset, 0),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      // Soft Ambient Radial Aura (smooth continuous breathing)
                                      Container(
                                        width: cardSize + 44,
                                        height: cardSize + 44,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: RadialGradient(
                                            colors: [
                                              UCColors.primary.withValues(
                                                alpha: isDark ? 0.28 : 0.18,
                                              ),
                                              UCColors.primary.withValues(alpha: 0),
                                            ],
                                          ),
                                        ),
                                      )
                                          .animate(onPlay: (c) => c.repeat(reverse: true))
                                          .scale(
                                            begin: const Offset(0.96, 0.96),
                                            end: const Offset(1.05, 1.05),
                                            duration: 2600.ms,
                                            curve: Curves.easeInOut,
                                          ),

                                      // Main High-Res 3D Artwork Frame
                                      Container(
                                        width: cardSize,
                                        height: cardSize,
                                        decoration: BoxDecoration(
                                          color: isDark ? UCColors.surfaceDark : Colors.white,
                                          borderRadius: BorderRadius.circular(28),
                                          border: Border.all(
                                            color: UCColors.primary.withValues(
                                              alpha: isDark ? 0.28 : 0.15,
                                            ),
                                            width: 1.5,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: UCColors.primary.withValues(
                                                alpha: isDark ? 0.22 : 0.12,
                                              ),
                                              blurRadius: 30,
                                              spreadRadius: 2,
                                              offset: const Offset(0, 12),
                                            ),
                                            BoxShadow(
                                              color: Colors.black.withValues(
                                                alpha: isDark ? 0.35 : 0.04,
                                              ),
                                              blurRadius: 16,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(26),
                                          child: Image.asset(
                                            slide.assetPath,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) =>
                                                Center(
                                              child: Icon(
                                                slide.badgeIcon,
                                                size: 72,
                                                color: UCColors.primary,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const Spacer(),

                                // Stat Pill Badge (e.g. 100+, 2500+, 10,000+)
                                Transform.translate(
                                  offset: Offset(textOffset * 0.6, 0),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 22,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          UCColors.primary,
                                          UCColors.primaryDark,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                          color: UCColors.primary.withValues(alpha: 0.35),
                                          blurRadius: 14,
                                          offset: const Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          slide.badgeIcon,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          slide.statKey.tr(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w800,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 18),

                                // Title Text
                                Transform.translate(
                                  offset: Offset(textOffset, 0),
                                  child: Text(
                                    slide.titleKey.tr(),
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.headlineSmall?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: isDark ? Colors.white : UCColors.charcoalDark,
                                      height: 1.25,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 8),

                                // Subtitle Text
                                Transform.translate(
                                  offset: Offset(textOffset * 1.2, 0),
                                  child: Text(
                                    slide.subtitleKey.tr(),
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      color: isDark ? Colors.white70 : UCColors.charcoalLight,
                                      fontWeight: FontWeight.w500,
                                      height: 1.4,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            // Bottom Navigation: Back + Page Indicator + Next/Get Started
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back Arrow
                  if (_currentIndex > 0)
                    IconButton.filledTonal(
                      onPressed: _onBack,
                      icon: const Icon(Icons.arrow_back_rounded, size: 20),
                      style: IconButton.styleFrom(
                        backgroundColor: isDark
                            ? UCColors.surfaceDark
                            : UCColors.primary.withValues(alpha: 0.12),
                        foregroundColor: UCColors.primary,
                        minimumSize: const Size(48, 48),
                      ),
                    )
                  else
                    const SizedBox(width: 48, height: 48),

                  // Smooth Page Indicator
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: _slides.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: UCColors.primary,
                      dotColor: isDark
                          ? Colors.white24
                          : UCColors.primary.withValues(alpha: 0.25),
                      dotHeight: 8,
                      dotWidth: 8,
                      expansionFactor: 3.5,
                      spacing: 6,
                    ),
                  ),

                  // Next / Get Started Action
                  AnimatedCrossFade(
                    alignment: Alignment.centerRight,
                    duration: const Duration(milliseconds: 250),
                    crossFadeState: _currentIndex == _slides.length - 1
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    firstChild: IconButton.filled(
                      onPressed: _onNext,
                      icon: const Icon(Icons.arrow_forward_rounded, size: 20),
                      style: IconButton.styleFrom(
                        backgroundColor: UCColors.primary,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(48, 48),
                      ),
                    ),
                    secondChild: FilledButton.icon(
                      onPressed: _onNext,
                      icon: const Icon(Icons.check_circle_rounded, size: 18),
                      label: Text(
                        'shared.get_started'.tr(),
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      style: FilledButton.styleFrom(
                        backgroundColor: UCColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
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

class _OnboardingItem {
  const _OnboardingItem({
    required this.statKey,
    required this.titleKey,
    required this.subtitleKey,
    required this.assetPath,
    required this.badgeIcon,
  });

  final String statKey;
  final String titleKey;
  final String subtitleKey;
  final String assetPath;
  final IconData badgeIcon;
}
