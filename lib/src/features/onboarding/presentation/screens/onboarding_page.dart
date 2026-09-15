import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
      imageUrl:
          'https://static.wixstatic.com/media/e42409_84587cb1e9ee4a9293014621cc86030b~mv2.png/v1/fill/w_498,h_426,al_c,lg_1,q_85,enc_avif,quality_auto/e42409_84587cb1e9ee4a9293014621cc86030b~mv2.png',
      assetPath: 'assets/images/onboarding1.avif',
      badgeIcon: Icons.rocket_launch_rounded,
    ),
    _OnboardingItem(
      statKey: 'onboarding.stat_2',
      titleKey: 'onboarding.title_2',
      subtitleKey: 'onboarding.subtitle_2',
      imageUrl:
          'https://static.wixstatic.com/media/e42409_99091069f59449b992149273e2865baf~mv2.png/v1/fill/w_448,h_442,al_c,lg_1,q_85,enc_avif,quality_auto/e42409_99091069f59449b992149273e2865baf~mv2.png',
      assetPath: 'assets/images/onboarding2.avif',
      badgeIcon: Icons.badge_rounded,
    ),
    _OnboardingItem(
      statKey: 'onboarding.stat_3',
      titleKey: 'onboarding.title_3',
      subtitleKey: 'onboarding.subtitle_3',
      imageUrl:
          'https://static.wixstatic.com/media/e42409_80878018ca67424e8665e072a0bf0f2e~mv2.png/v1/fill/w_466,h_470,al_c,q_85,usm_0.66_1.00_0.01,enc_avif,quality_auto/e42409_80878018ca67424e8665e072a0bf0f2e~mv2.png',
      assetPath: 'assets/images/onboarding3.avif',
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

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_seen_onboarding', true);
    if (!mounted) return;
    context.go(AppRoutes.login);
  }

  void _onNext() {
    if (_currentIndex < _slides.length - 1) {
      _pageController.animateToPage(
        _currentIndex + 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _onBack() {
    if (_currentIndex > 0) {
      _pageController.animateToPage(
        _currentIndex - 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

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

            // PageView Area with Animated Illustrations and Texts
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _slides.length,
                onPageChanged: (idx) => setState(() => _currentIndex = idx),
                itemBuilder: (context, index) {
                  final slide = _slides[index];
                  final isCurrent = _currentIndex == index;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),

                        // Network Image Container with Animation & Ambient Glow
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            // Soft Ambient Aura
                            Container(
                              width: 260,
                              height: 260,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: UCColors.primary.withValues(alpha: 0.1),
                              ),
                            )
                                .animate(target: isCurrent ? 1 : 0)
                                .scale(
                                  duration: 600.ms,
                                  curve: Curves.easeOutBack,
                                )
                                .fadeIn(duration: 400.ms),

                            // Main Illustration Card
                            Container(
                              constraints: const BoxConstraints(
                                maxHeight: 270,
                                maxWidth: 320,
                              ),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? UCColors.surfaceDark.withValues(alpha: 0.6)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(28),
                                boxShadow: [
                                  BoxShadow(
                                    color: UCColors.primary.withValues(alpha: 0.12),
                                    blurRadius: 28,
                                    offset: const Offset(0, 14),
                                  ),
                                ],
                                border: Border.all(
                                  color: UCColors.primary.withValues(alpha: 0.18),
                                  width: 1.5,
                                ),
                              ),
                              padding: const EdgeInsets.all(16),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  slide.assetPath,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return CachedNetworkImage(
                                      imageUrl: slide.imageUrl,
                                      fit: BoxFit.contain,
                                      placeholder: (context, url) => Container(
                                        height: 200,
                                        color: isDark ? Colors.white10 : Colors.black12,
                                        child: const Center(
                                          child: SizedBox(
                                            width: 32,
                                            height: 32,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2.5,
                                              valueColor: AlwaysStoppedAnimation<Color>(
                                                UCColors.primary,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) => Image.asset(
                                        'assets/icons/uc_icon_transparent.png',
                                        fit: BoxFit.contain,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                                .animate(target: isCurrent ? 1 : 0)
                                .fadeIn(duration: 500.ms)
                                .scale(
                                  begin: const Offset(0.9, 0.9),
                                  end: const Offset(1, 1),
                                  curve: Curves.easeOutBack,
                                  duration: 500.ms,
                                )
                                .slideY(
                                  begin: 0.08,
                                  end: 0,
                                  curve: Curves.easeOutCubic,
                                  duration: 500.ms,
                                ),
                          ],
                        ),

                        const Spacer(),

                        // Animated Stat Pill Badge (e.g. 100+, 2500+, 10,000+)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
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
                        )
                            .animate(target: isCurrent ? 1 : 0)
                            .fadeIn(duration: 400.ms, delay: 100.ms)
                            .scale(
                              begin: const Offset(0.8, 0.8),
                              end: const Offset(1, 1),
                              curve: Curves.elasticOut,
                              duration: 700.ms,
                            ),

                        const SizedBox(height: 18),

                        // Title Text (e.g. Custom Software Solution / IT Professionals placed)
                        Text(
                          slide.titleKey.tr(),
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: isDark ? Colors.white : UCColors.charcoalDark,
                            height: 1.25,
                          ),
                        )
                            .animate(target: isCurrent ? 1 : 0)
                            .fadeIn(duration: 450.ms, delay: 150.ms)
                            .slideY(
                              begin: 0.15,
                              end: 0,
                              curve: Curves.easeOutCubic,
                            ),

                        const SizedBox(height: 8),

                        // Subtitle Text (e.g. in Global Market / in the USA)
                        Text(
                          slide.subtitleKey.tr(),
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: isDark ? Colors.white70 : UCColors.charcoalLight,
                            fontWeight: FontWeight.w500,
                            height: 1.4,
                          ),
                        )
                            .animate(target: isCurrent ? 1 : 0)
                            .fadeIn(duration: 500.ms, delay: 200.ms)
                            .slideY(
                              begin: 0.2,
                              end: 0,
                              curve: Curves.easeOutCubic,
                            ),

                        const SizedBox(height: 20),
                      ],
                    ),
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
    required this.imageUrl,
    required this.assetPath,
    required this.badgeIcon,
  });

  final String statKey;
  final String titleKey;
  final String subtitleKey;
  final String imageUrl;
  final String assetPath;
  final IconData badgeIcon;
}
