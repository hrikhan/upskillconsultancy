import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:upskill_consultancy/src/features/my_learning/data/models/enrollment_model.dart';
import 'package:upskill_consultancy/src/features/my_learning/data/repositories/my_learning_repository_impl.dart';
import 'package:upskill_consultancy/src/features/my_learning/domain/repositories/my_learning_repository.dart';
import 'package:upskill_consultancy/src/theme/color_schemes.dart';
import 'package:upskill_consultancy/src/theme/theme_constants.dart';

class MyLearningPage extends StatefulWidget {
  const MyLearningPage({super.key});

  @override
  State<MyLearningPage> createState() => _MyLearningPageState();
}

class _MyLearningPageState extends State<MyLearningPage> {
  final MyLearningRepository _repository = MyLearningRepositoryImpl();

  List<EnrollmentModel> _inProgress = [];
  List<EnrollmentModel> _completed = [];
  EnrollmentModel? _activeCourse;
  int _certificatesCount = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    final inProgressRes = await _repository.getEnrolledCourses();
    inProgressRes.fold((_) {}, (list) => _inProgress = list);

    final completedRes = await _repository.getCompletedCourses();
    completedRes.fold((_) {}, (list) => _completed = list);

    final activeRes = await _repository.getContinueLearningCourse();
    activeRes.fold((_) {}, (course) => _activeCourse = course);

    final certRes = await _repository.getCertificatesCount();
    certRes.fold((_) {}, (count) => _certificatesCount = count);

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final allJoinedCourses = [..._inProgress, ..._completed];

    return Scaffold(
      backgroundColor: isDark ? UCColors.backgroundDark : UCColors.backgroundLight,
      appBar: const _MyLearningAppBar(),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadData,
          color: UCColors.primary,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            children: [
              // 1. Stats Banner
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      UCColors.primary,
                      Color(0xFF0072BD),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: UCColors.primary.withValues(alpha: 0.35),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _StatCol(
                      number: '${_inProgress.length}',
                      label: 'my_learning.in_progress'.tr(),
                      icon: IconsaxPlusBold.clock,
                    ),
                    Container(
                      height: 38,
                      width: 1,
                      color: Colors.white.withValues(alpha: 0.25),
                    ),
                    _StatCol(
                      number: '${_completed.length}',
                      label: 'my_learning.completed'.tr(),
                      icon: IconsaxPlusBold.tick_circle,
                    ),
                    Container(
                      height: 38,
                      width: 1,
                      color: Colors.white.withValues(alpha: 0.25),
                    ),
                    _StatCol(
                      number: '$_certificatesCount',
                      label: 'my_learning.certificates'.tr(),
                      icon: IconsaxPlusBold.award,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 2. Continue Learning Card
              if (_activeCourse != null) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'my_learning.continue_learning'.tr(),
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      '${_activeCourse!.progressPercentage}% Done',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: UCColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                _ContinueLearningCard(
                  course: _activeCourse!,
                  isDark: isDark,
                  colorScheme: colorScheme,
                ),

                const SizedBox(height: 22),
              ],

              // 3. Courses You Joined (Not "Enrolled Courses")
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'my_learning.joined_courses'.tr(),
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: UCColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${allJoinedCourses.length} Courses',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: UCColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              if (_isLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(40),
                    child: CircularProgressIndicator(color: UCColors.primary),
                  ),
                )
              else if (allJoinedCourses.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        Icon(
                          IconsaxPlusBold.book_1,
                          size: 48,
                          color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'No courses joined yet.',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                ...allJoinedCourses.map(
                  (enrollment) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _JoinedCourseCard(
                      enrollment: enrollment,
                      isDark: isDark,
                      colorScheme: colorScheme,
                    ),
                  ),
                ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

/// Perfect custom AppBar for My Learning page
class _MyLearningAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _MyLearningAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(66);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final backgroundColor = isDark ? UCColors.surfaceDark : Colors.white;
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
              // Logo
              Image.asset(
                'assets/icons/uc_icon_transparent.png',
                height: 32,
                width: 32,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: UCColors.primary,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Center(
                    child: Text(
                      'UC',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),

              // Title and Subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'my_learning.title'.tr(),
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: colorScheme.onSurface,
                        letterSpacing: -0.3,
                        height: 1.2,
                      ),
                    ),
                    Text(
                      'Track your courses & progress',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: colorScheme.onSurfaceVariant,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),

              // Right Actions: Certificate shortcut
              Tooltip(
                message: 'Certificates',
                child: InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'You have earned certificates in your completed courses!',
                          style: GoogleFonts.inter(fontSize: 13),
                        ),
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: UCColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      IconsaxPlusBold.award,
                      color: UCColors.primary,
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

/// Perfect Continue Learning Card
class _ContinueLearningCard extends StatelessWidget {
  final EnrollmentModel course;
  final bool isDark;
  final ColorScheme colorScheme;

  const _ContinueLearningCard({
    required this.course,
    required this.isDark,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = isDark ? const Color(0xFF2D3748) : const Color(0xFFE2E8F0);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? UCColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category tag & Instructor
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: UCColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  course.courseCategory,
                  style: GoogleFonts.poppins(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: UCColors.primary,
                  ),
                ),
              ),
              Row(
                children: [
                  Icon(
                    IconsaxPlusLinear.teacher,
                    size: 13,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    course.instructor,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Course Title
          Text(
            course.courseTitle,
            style: GoogleFonts.poppins(
              fontSize: 15.5,
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 6),

          // Current Module
          Row(
            children: [
              const Icon(
                IconsaxPlusBold.book_1,
                size: 14,
                color: UCColors.primary,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  course.currentModuleTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Progress Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Modules (${course.completedModules}/${course.totalModules})',
                style: GoogleFonts.inter(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                '${course.progressPercentage}%',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: UCColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: course.progress,
              minHeight: 7,
              backgroundColor: isDark
                  ? const Color(0xFF1E293B)
                  : const Color(0xFFE2E8F0),
              valueColor: const AlwaysStoppedAnimation<Color>(UCColors.primary),
            ),
          ),
          const SizedBox(height: 14),

          // Resume Button
          SizedBox(
            width: double.infinity,
            height: 42,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(IconsaxPlusBold.play, size: 16),
              label: Text(
                'my_learning.resume'.tr(),
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: UCColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Perfect Joined Course Card
class _JoinedCourseCard extends StatelessWidget {
  final EnrollmentModel enrollment;
  final bool isDark;
  final ColorScheme colorScheme;

  const _JoinedCourseCard({
    required this.enrollment,
    required this.isDark,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = isDark ? const Color(0xFF2D3748) : const Color(0xFFE2E8F0);
    final isCompleted = enrollment.isCompleted;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? UCColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.18 : 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Icon + Title + Status Chip
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: isCompleted
                      ? const Color(0xFF10B981).withValues(alpha: 0.12)
                      : UCColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Icon(
                    isCompleted
                        ? IconsaxPlusBold.award
                        : IconsaxPlusBold.book_saved,
                    color: isCompleted
                        ? const Color(0xFF10B981)
                        : UCColors.primary,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      enrollment.courseTitle,
                      style: GoogleFonts.poppins(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: colorScheme.onSurface,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      enrollment.currentModuleTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              // Status Tag
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                decoration: BoxDecoration(
                  color: isCompleted
                      ? const Color(0xFF10B981).withValues(alpha: 0.12)
                      : UCColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  isCompleted ? 'Completed' : '${enrollment.progressPercentage}%',
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: isCompleted
                        ? const Color(0xFF10B981)
                        : UCColors.primary,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: enrollment.progress,
              minHeight: 6,
              backgroundColor: isDark
                  ? const Color(0xFF1E293B)
                  : const Color(0xFFE2E8F0),
              valueColor: AlwaysStoppedAnimation<Color>(
                isCompleted ? const Color(0xFF10B981) : UCColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Bottom Meta
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${enrollment.completedModules}/${enrollment.totalModules} Modules completed',
                style: GoogleFonts.inter(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                enrollment.courseCategory,
                style: GoogleFonts.inter(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatCol extends StatelessWidget {
  final String number;
  final String label;
  final IconData icon;

  const _StatCol({
    required this.number,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.white.withValues(alpha: 0.85),
              size: 15,
            ),
            const SizedBox(width: 5),
            Text(
              number,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.white.withValues(alpha: 0.85),
            fontSize: 11.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
