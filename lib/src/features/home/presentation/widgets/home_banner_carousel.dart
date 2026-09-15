import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:upskill_consultancy/src/theme/color_schemes.dart';

class BannerItem {
  final String tag;
  final String title;
  final String subtitle;
  final String buttonText;
  final String imageUrl;
  final VoidCallback onTap;

  const BannerItem({
    required this.tag,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.imageUrl,
    required this.onTap,
  });
}

/// Top Banner Card Carousel:
/// 1. Join Career ("Build Your Tech Career with UpSkill") + "Join Us" button
/// 2. Explore Our Courses ("Master In-Demand Tech Skills") + "Explore Courses" button
/// 3. Get Membership ("All-Access Student Membership") + "Get Membership" button
/// 4. See Our Services ("Enterprise AI & Global IT Staffing") + "See Services" button
class HomeBannerCarousel extends StatefulWidget {
  final VoidCallback onJoinCareer;
  final VoidCallback onExploreCourses;
  final VoidCallback onGetMembership;
  final VoidCallback onSeeServices;

  const HomeBannerCarousel({
    super.key,
    required this.onJoinCareer,
    required this.onExploreCourses,
    required this.onGetMembership,
    required this.onSeeServices,
  });

  @override
  State<HomeBannerCarousel> createState() => _HomeBannerCarouselState();
}

class _HomeBannerCarouselState extends State<HomeBannerCarousel> {
  late final PageController _pageController;
  Timer? _autoScrollTimer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.92);
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!mounted) return;
      final nextPage = (_currentPage + 1) % 4;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  List<BannerItem> get _banners => [
        BannerItem(
          tag: 'CAREER PLACEMENT',
          title: 'Fast-Track Your Tech Career',
          subtitle: '1-on-1 industry mentorship & guaranteed USA/global placement support.',
          buttonText: 'Join Us',
          imageUrl:
              'https://images.unsplash.com/photo-1522071820081-009f0129c71c?w=700&auto=format&fit=crop&q=80',
          onTap: widget.onJoinCareer,
        ),
        BannerItem(
          tag: 'FEATURED COURSES',
          title: 'Master In-Demand Tech Skills',
          subtitle: 'Hands-on training in Full Stack, Cloud DevOps, QA & Applied AI.',
          buttonText: 'Explore Courses',
          imageUrl:
              'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=700&auto=format&fit=crop&q=80',
          onTap: widget.onExploreCourses,
        ),
        BannerItem(
          tag: 'MEMBERSHIP ACCESS',
          title: 'All-Access Student Membership',
          subtitle: 'Unlimited live bootcamps, real production projects & hiring drives.',
          buttonText: 'Get Membership',
          imageUrl:
              'https://images.unsplash.com/photo-1531482615713-2afd69097998?w=700&auto=format&fit=crop&q=80',
          onTap: widget.onGetMembership,
        ),
        BannerItem(
          tag: 'ENTERPRISE SOLUTIONS',
          title: 'See Our Public & IT Services',
          subtitle: 'Enterprise custom software, scalable cloud architecture & IT staffing.',
          buttonText: 'Our Services',
          imageUrl:
              'https://images.unsplash.com/photo-1497366216548-37526070297c?w=700&auto=format&fit=crop&q=80',
          onTap: widget.onSeeServices,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 175,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemCount: _banners.length,
            itemBuilder: (context, index) {
              final banner = _banners[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                child: _BannerCard(
                  banner: banner,
                  isDark: isDark,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        // Dots Indicator
        SmoothPageIndicator(
          controller: _pageController,
          count: _banners.length,
          effect: ExpandingDotsEffect(
            dotHeight: 5,
            dotWidth: 5,
            expansionFactor: 3.5,
            activeDotColor: UCColors.primary,
            dotColor: isDark
                ? Colors.white.withValues(alpha: 0.2)
                : Colors.black.withValues(alpha: 0.15),
            spacing: 5,
          ),
        ),
      ],
    );
  }
}

class _BannerCard extends StatelessWidget {
  final BannerItem banner;
  final bool isDark;

  const _BannerCard({
    required this.banner,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: banner.onTap,
      borderRadius: BorderRadius.circular(8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background Image
              CachedNetworkImage(
                imageUrl: banner.imageUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) => ColoredBox(
                  color: isDark ? const Color(0xFF1E252B) : const Color(0xFFE2E8F0),
                ),
                errorWidget: (_, __, ___) => const ColoredBox(
                  color: UCColors.charcoalDark,
                ),
              ),

              // Gradient Overlay (Darkens left side for crystal-clear readability)
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withValues(alpha: 0.88),
                      Colors.black.withValues(alpha: 0.65),
                      Colors.black.withValues(alpha: 0.25),
                    ],
                    stops: const [0.0, 0.6, 1.0],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),

              // Content Layout
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Tag
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                      decoration: BoxDecoration(
                        color: UCColors.primary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        banner.tag,
                        style: GoogleFonts.poppins(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),

                    // Title & Subtitle
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          banner.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 3),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 280),
                          child: Text(
                            banner.subtitle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              color: Colors.white.withValues(alpha: 0.85),
                              height: 1.3,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // CTA Button
                    SizedBox(
                      height: 28,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: UCColors.charcoalDark,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        onPressed: banner.onTap,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              banner.buttonText,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              IconsaxPlusLinear.arrow_right_3,
                              size: 11,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
