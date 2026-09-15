import 'package:fpdart/fpdart.dart';
import 'package:upskill_consultancy/src/utils/typedefs.dart';
import 'package:upskill_consultancy/src/features/home/data/models/announcement_model.dart';

abstract class AnnouncementsRepository {
  FutureEither<List<AnnouncementModel>> getAnnouncements();
  FutureEither<AnnouncementModel?> getLatestAnnouncement();
}

class AnnouncementsRepositoryImpl implements AnnouncementsRepository {
  static final List<AnnouncementModel> _mockAnnouncements = [
    AnnouncementModel(
      id: 'announcement_wix_001',
      title: 'New Courses Now Available',
      summary:
          'Explore newly launched courses in AI Engineering, Cloud Architecture, and QA Automation.',
      content:
          'We have released brand new courses in our catalog: AI Engineering & Applied LLMs, Advanced Cloud Architecture with Kubernetes & Terraform, and Full Stack SDET Test Automation. All courses are fully included in your student membership plan.',
      tag: 'New Courses',
      date: DateTime.now().subtract(const Duration(days: 1)),
      actionText: 'Explore Courses',
      isImportant: true,
    ),
    AnnouncementModel(
      id: 'announcement_wix_002',
      title: 'Free Live Workshop: AI In Test Automation',
      summary:
          'Learn how Generative AI and automated testing tools work together to speed up delivery cycles.',
      content:
          'Upcoming Saturday webinar hosted by UpSkill industry leads. Covering Selenium, Playwright, AI-driven test script generation, and CI/CD pipelines. Free for all registered students.',
      tag: 'Free Webinar',
      date: DateTime.now().subtract(const Duration(days: 3)),
      actionText: 'Register Now',
      isImportant: false,
    ),
  ];

  @override
  FutureEither<List<AnnouncementModel>> getAnnouncements() async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    return right(_mockAnnouncements);
  }

  @override
  FutureEither<AnnouncementModel?> getLatestAnnouncement() async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    return right(_mockAnnouncements.firstOrNull);
  }
}
