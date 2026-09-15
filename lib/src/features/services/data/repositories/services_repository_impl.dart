import 'package:fpdart/fpdart.dart';
import 'package:upskill_consultancy/src/utils/failure.dart';
import 'package:upskill_consultancy/src/utils/typedefs.dart';
import 'package:upskill_consultancy/src/features/services/data/models/service_model.dart';
import 'package:upskill_consultancy/src/features/services/domain/repositories/services_repository.dart';

/// Wix API-ready Services Repository Implementation.
class ServicesRepositoryImpl implements ServicesRepository {
  static const List<ServiceModel> _mockServices = [
    ServiceModel(
      id: 'service_wix_001',
      title: 'Custom Software & Cloud Solutions',
      subtitle:
          'End-to-end enterprise mobile, web, and microservices architecture engineered for high availability and scalability.',
      category: 'Software Engineering',
      iconName: 'code',
      badge: '100+ Solutions Delivered',
      features: [
        'Mobile & Web Application Development',
        'Cloud Infrastructure & CI/CD Pipelines',
        'Enterprise API & Microservices Integration',
      ],
    ),
    ServiceModel(
      id: 'service_wix_002',
      title: 'USA & Global IT Staffing',
      subtitle:
          'Placing top-tier software engineers, DevOps experts, QA automation engineers, and data specialists across USA enterprises.',
      category: 'Recruitment & Placement',
      iconName: 'briefcase',
      badge: '2500+ Placed in USA',
      features: [
        'Direct Hire & Contract-to-Hire Placement',
        'Resume Tailoring & Technical Screening',
        'US Visa & Remote Onboarding Guidance',
      ],
    ),
    ServiceModel(
      id: 'service_wix_003',
      title: 'Corporate IT Training & Bootcamps',
      subtitle:
          'Hands-on, project-based technical upskilling programs taught by industry practitioners to prepare candidates for high-paying roles.',
      category: 'Training',
      iconName: 'teacher',
      badge: '10,000+ Trained',
      features: [
        'Live Mentorship & 1-on-1 Code Reviews',
        'Real-world Production Projects',
        'Mock Technical & Behavioral Interviews',
      ],
    ),
    ServiceModel(
      id: 'service_wix_004',
      title: '1-on-1 Career Consultation',
      subtitle:
          'Strategic career guidance, resume review, salary negotiation coaching, and technology roadmap customized for your goals.',
      category: 'Consultancy',
      iconName: 'profile_2user',
      badge: '1-on-1 Mentorship',
      features: [
        'Comprehensive Skill Gap Assessment',
        'Job Market Strategy & LinkedIn Optimization',
        'Offer Evaluation & Salary Negotiation',
      ],
    ),
  ];

  @override
  FutureEither<List<ServiceModel>> getServices() async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    return right(_mockServices);
  }

  @override
  FutureEither<ServiceModel> getServiceById(String id) async {
    final found = _mockServices.where((s) => s.id == id).firstOrNull;
    if (found != null) {
      return right(found);
    }
    return left(const ServerFailure('Service not found'));
  }
}
