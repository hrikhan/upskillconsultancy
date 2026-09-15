import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:upskill_consultancy/src/routing/app_routes.dart';
import 'package:upskill_consultancy/src/theme/color_schemes.dart';

// Repositories & Models
import 'package:upskill_consultancy/src/features/courses/data/models/course_model.dart';
import 'package:upskill_consultancy/src/features/courses/data/repositories/courses_repository_impl.dart';
import 'package:upskill_consultancy/src/features/home/data/models/announcement_model.dart';
import 'package:upskill_consultancy/src/features/home/data/repositories/announcements_repository.dart';

// Home Section Widgets
import 'package:upskill_consultancy/src/features/home/presentation/widgets/home_app_bar.dart';
import 'package:upskill_consultancy/src/features/home/presentation/widgets/home_announcement_card.dart';
import 'package:upskill_consultancy/src/features/home/presentation/widgets/home_banner_carousel.dart';
import 'package:upskill_consultancy/src/features/home/presentation/widgets/home_we_provide_section.dart';
import 'package:upskill_consultancy/src/features/home/presentation/widgets/home_top_courses_section.dart';
import 'package:upskill_consultancy/src/features/home/presentation/widgets/home_ites_products_section.dart';
import 'package:upskill_consultancy/src/features/home/presentation/widgets/home_enterprise_solutions_section.dart';

/// Professional Home Page tailored for UpSkill Consultancy & Training:
/// 1. App Bar (Official UC Logo & Dual-color UpSkill text, Announcement action)
/// 2. Gradient Announcement Banner ("New Course Available" with cross dismiss and Join Us button)
/// 3. Top Banner Carousel (4-card carousel: Career, Courses, Membership, Services)
/// 4. Top Training Courses (Clean cards, no vertical divider, price & Join action)
/// 5. Top ITES Products (HealthTech, EdTech, Cloud CRM, SCADA)
/// 6. Top Public & Enterprise Solutions (Enterprise AI, Cyber Defense, Supply Chain, E-Gov)
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _announcementsRepo = AnnouncementsRepositoryImpl();
  final _coursesRepo = CoursesRepositoryImpl();

  List<AnnouncementModel> _announcements = [];
  AnnouncementModel? _latestAnnouncement;
  List<CourseModel> _topCourses = [];
  bool _isLoading = true;
  bool _isAnnouncementDismissed = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    final announcementsRes = await _announcementsRepo.getAnnouncements();
    final latestAnnouncementRes = await _announcementsRepo.getLatestAnnouncement();
    final topCoursesRes = await _coursesRepo.getTopCourses();

    if (!mounted) return;

    setState(() {
      _announcements = announcementsRes.getOrElse((_) => []);
      _latestAnnouncement = latestAnnouncementRes.getOrElse((_) => null);
      _topCourses = topCoursesRes.getOrElse((_) => []);
      _isLoading = false;
    });
  }

  void _handleJoinCourse(CourseModel course) {
    context.push(AppRoutes.membership);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? UCColors.backgroundDark : UCColors.backgroundLight,
      // Home App Bar with Logo, UpSkill dual-color typography, and Announcement Icon
      appBar: HomeAppBar(
        announcements: _announcements,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: UCColors.primary,
              ),
            )
          : RefreshIndicator(
              color: UCColors.primary,
              onRefresh: _loadData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 6),

                    // 1. Gradient Announcement Banner ("New Course Available" + dismiss cross + "Join Us" button)
                    if (_latestAnnouncement != null && !_isAnnouncementDismissed)
                      HomeAnnouncementCard(
                        announcement: _latestAnnouncement!,
                        onDismiss: () {
                          setState(() => _isAnnouncementDismissed = true);
                        },
                        onJoin: () {
                          context.push(AppRoutes.membership);
                        },
                      ),

                    const SizedBox(height: 8),

                    // 2. Top Banner Carousel (4-card carousel: Career, Courses, Membership, Services)
                    HomeBannerCarousel(
                      onJoinCareer: () => context.push(AppRoutes.membership),
                      onExploreCourses: () => context.go(AppRoutes.courses),
                      onGetMembership: () => context.push(AppRoutes.membership),
                      onSeeServices: () => context.go(AppRoutes.services),
                    ),

                    const SizedBox(height: 8),

                    // 3. What We Provide (2x2 Grid: ITES Products, Digital Services, Public & Enterprise Solutions, UpSkill Academia)
                    HomeWeProvideSection(
                      onItesTap: () => context.go(AppRoutes.services),
                      onDigitalServicesTap: () => context.go(AppRoutes.services),
                      onPublicEnterpriseTap: () => context.go(AppRoutes.services),
                      onAcademiaTap: () => context.go(AppRoutes.courses),
                    ),

                    const SizedBox(height: 8),

                    // 4. Top Training Courses (Title without vertical divider, clean cards, no fees, Join action)
                    HomeTopCoursesSection(
                      courses: _topCourses,
                      onViewAll: () => context.go(AppRoutes.courses),
                      onJoinCourse: _handleJoinCourse,
                      onCourseTap: (course) => context.go(AppRoutes.courses),
                    ),

                    // 4. Top ITES Products (UpCare MediConnect, UpLearn EduTech, UpSales BizHub, Omni Smart SCADA)
                    HomeItesProductsSection(
                      onViewAll: () => context.go(AppRoutes.services),
                      onProductTap: (product) => context.go(AppRoutes.services),
                    ),

                    // 5. Top Public & Enterprise Solutions (Enterprise AI, Cyber Defense, SCADA, E-Gov)
                    HomeEnterpriseSolutionsSection(
                      onViewAll: () => context.go(AppRoutes.services),
                      onSolutionTap: (solution) => context.go(AppRoutes.services),
                    ),

                    // Comfortable bottom padding above the bottom navbar
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ),
    );
  }
}
