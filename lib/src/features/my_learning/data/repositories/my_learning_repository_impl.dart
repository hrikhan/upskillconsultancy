import 'package:fpdart/fpdart.dart';
import 'package:upskill_consultancy/src/utils/typedefs.dart';
import 'package:upskill_consultancy/src/features/my_learning/data/models/enrollment_model.dart';
import 'package:upskill_consultancy/src/features/my_learning/domain/repositories/my_learning_repository.dart';

/// Wix API-ready MyLearning Repository Implementation.
class MyLearningRepositoryImpl implements MyLearningRepository {
  static final List<EnrollmentModel> _mockEnrollments = [
    EnrollmentModel(
      id: 'enroll_wix_001',
      courseId: 'course_wix_001',
      courseTitle: 'Full Stack Web & Mobile App Development',
      courseCategory: 'Software Engineering',
      instructor: 'Dr. Michael Vance & Team',
      progress: 0.68,
      currentModuleTitle: 'Module 4 • State Management with Bloc & GoRouter',
      completedModules: 16,
      totalModules: 24,
      isCompleted: false,
      certificateEarned: false,
      lastAccessedAt: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    EnrollmentModel(
      id: 'enroll_wix_002',
      courseId: 'course_wix_002',
      courseTitle: 'DevOps & Cloud Architecture (AWS / GCP)',
      courseCategory: 'Cloud & DevOps',
      instructor: 'Sarah Jenkins',
      progress: 0.32,
      currentModuleTitle: 'Module 2 • Docker & Kubernetes Orchestration',
      completedModules: 5,
      totalModules: 16,
      isCompleted: false,
      certificateEarned: false,
      lastAccessedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    EnrollmentModel(
      id: 'enroll_wix_003',
      courseId: 'course_wix_003',
      courseTitle: 'QA Automation & SDET Specialization',
      courseCategory: 'QA Automation',
      instructor: 'Alex Rivera',
      progress: 1,
      currentModuleTitle: 'Course Completed • Final Capstone Review',
      completedModules: 14,
      totalModules: 14,
      isCompleted: true,
      certificateEarned: true,
      certificateUrl: 'https://upskillconsultancy.com/certificates/uc-sdet-cert-9821',
      lastAccessedAt: DateTime.now().subtract(const Duration(days: 14)),
    ),
  ];

  @override
  FutureEither<List<EnrollmentModel>> getEnrolledCourses() async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    final inProgress = _mockEnrollments.where((e) => !e.isCompleted).toList();
    return right(inProgress);
  }

  @override
  FutureEither<List<EnrollmentModel>> getCompletedCourses() async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    final completed = _mockEnrollments.where((e) => e.isCompleted).toList();
    return right(completed);
  }

  @override
  FutureEither<EnrollmentModel?> getContinueLearningCourse() async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    final active = _mockEnrollments.where((e) => !e.isCompleted).firstOrNull;
    return right(active);
  }

  @override
  FutureEither<int> getCertificatesCount() async {
    final count = _mockEnrollments.where((e) => e.certificateEarned).length;
    return right(count);
  }
}
