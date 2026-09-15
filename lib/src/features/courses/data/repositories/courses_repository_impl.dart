import 'package:fpdart/fpdart.dart';
import 'package:upskill_consultancy/src/utils/failure.dart';
import 'package:upskill_consultancy/src/utils/typedefs.dart';
import 'package:upskill_consultancy/src/features/courses/data/models/course_model.dart';
import 'package:upskill_consultancy/src/features/courses/domain/repositories/courses_repository.dart';

/// Wix API-ready Courses Repository Implementation.
/// Returns structured mock data matching the Wix CMS collection schema.
/// When the Wix API is integrated, replace the internal list retrieval with Wix REST calls.
class CoursesRepositoryImpl implements CoursesRepository {
  static const List<CourseModel> _mockCourses = [
    CourseModel(
      id: 'course_wix_001',
      title: 'Full Stack Web & Mobile App Development',
      category: 'Software Engineering',
      description:
          'Master modern cross-platform mobile apps with Flutter, along with enterprise REST APIs, database design, and cloud deployments.',
      instructor: 'Md Rasel Ahmed',
      rating: 4.9,
      reviewsCount: 1240,
      duration: '24 Weeks',
      level: 'Beginner to Advanced',
      price: 499,
      originalPrice: 799,
      isFeatured: true,
      isTopCourse: true,
      modulesCount: 24,
      thumbnailUrl:
          'https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=600&auto=format&fit=crop&q=80',
      tags: ['Flutter', 'Dart', 'Node.js', 'PostgreSQL', 'Docker'],
    ),
    CourseModel(
      id: 'course_wix_002',
      title: 'DevOps & Cloud Architecture (AWS / GCP)',
      category: 'Cloud & DevOps',
      description:
          'Learn CI/CD automation pipelines, infrastructure as code with Terraform, Docker containers, and Kubernetes orchestration in cloud environments.',
      instructor: 'Md Rasel Ahmed',
      rating: 4.8,
      reviewsCount: 890,
      duration: '16 Weeks',
      level: 'Intermediate',
      price: 399,
      originalPrice: 599,
      isFeatured: true,
      isTopCourse: true,
      modulesCount: 16,
      thumbnailUrl:
          'https://images.unsplash.com/photo-1667372393119-3d4c48d07fc9?w=600&auto=format&fit=crop&q=80',
      tags: ['AWS', 'GCP', 'Kubernetes', 'Terraform', 'CI/CD'],
    ),
    CourseModel(
      id: 'course_wix_003',
      title: 'QA Automation & SDET Specialization',
      category: 'QA Automation',
      description:
          'Comprehensive quality assurance engineering covering Selenium, Appium, Playwright, API test automation, and performance testing with JMeter.',
      instructor: 'Md Rasel Ahmed',
      rating: 4.9,
      reviewsCount: 980,
      duration: '14 Weeks',
      level: 'Beginner to Advanced',
      price: 349,
      originalPrice: 499,
      isFeatured: false,
      isTopCourse: true,
      modulesCount: 14,
      thumbnailUrl:
          'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=600&auto=format&fit=crop&q=80',
      tags: ['Selenium', 'Playwright', 'API Testing', 'Java', 'JMeter'],
    ),
    CourseModel(
      id: 'course_wix_004',
      title: 'Data Engineering, Big Data & Applied AI',
      category: 'Data & AI',
      description:
          'Build scalable data pipelines with Apache Spark, Kafka, Python, data warehousing with Snowflake, and LLM-powered enterprise integrations.',
      instructor: 'Md Rasel Ahmed',
      rating: 4.9,
      reviewsCount: 650,
      duration: '20 Weeks',
      level: 'Intermediate',
      price: 549,
      originalPrice: 850,
      isFeatured: true,
      isTopCourse: false,
      modulesCount: 20,
      thumbnailUrl:
          'https://images.unsplash.com/photo-1555949963-aa79dcee981c?w=600&auto=format&fit=crop&q=80',
      tags: ['Python', 'Apache Spark', 'Kafka', 'Snowflake', 'LLMs'],
    ),
    CourseModel(
      id: 'course_wix_005',
      title: 'Cybersecurity Fundamentals & SOC Analyst',
      category: 'Cyber Security',
      description:
          'Learn network defense, ethical penetration testing, SIEM monitoring, threat detection, and incident response for modern enterprise infrastructure.',
      instructor: 'Md Rasel Ahmed',
      rating: 4.8,
      reviewsCount: 520,
      duration: '18 Weeks',
      level: 'Beginner to Intermediate',
      price: 449,
      originalPrice: 650,
      isFeatured: false,
      isTopCourse: false,
      modulesCount: 18,
      thumbnailUrl:
          'https://images.unsplash.com/photo-1550751827-4bd374c3f58b?w=600&auto=format&fit=crop&q=80',
      tags: ['Network Security', 'SOC', 'SIEM', 'Threat Analysis'],
    ),
  ];

  static const List<String> _categories = [
    'All',
    'Software Engineering',
    'Cloud & DevOps',
    'QA Automation',
    'Data & AI',
    'Cyber Security',
  ];

  @override
  FutureEither<List<CourseModel>> getCourses({
    String? category,
    String? searchQuery,
  }) async {
    // Simulated async network delay for realistic UX testing
    await Future<void>.delayed(const Duration(milliseconds: 150));

    var list = _mockCourses;

    if (category != null && category.isNotEmpty && category != 'All') {
      list = list
          .where((c) => c.category.toLowerCase() == category.toLowerCase())
          .toList();
    }

    if (searchQuery != null && searchQuery.trim().isNotEmpty) {
      final query = searchQuery.trim().toLowerCase();
      list = list.where((c) {
        return c.title.toLowerCase().contains(query) ||
            c.description.toLowerCase().contains(query) ||
            c.tags.any((t) => t.toLowerCase().contains(query));
      }).toList();
    }

    return right(list);
  }

  @override
  FutureEither<List<CourseModel>> getTopCourses() async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    final list = _mockCourses.where((c) => c.isTopCourse).toList();
    return right(list);
  }

  @override
  FutureEither<List<CourseModel>> getFeaturedCourses() async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    final list = _mockCourses.where((c) => c.isFeatured).toList();
    return right(list);
  }

  @override
  FutureEither<CourseModel> getCourseById(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    final found = _mockCourses.where((c) => c.id == id).firstOrNull;
    if (found != null) {
      return right(found);
    }
    return left(const ServerFailure('Course not found'));
  }

  @override
  FutureEither<List<String>> getCategories() async {
    return right(_categories);
  }
}
