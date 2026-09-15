import 'package:equatable/equatable.dart';

/// Wix API-compatible Subscription / Membership Plan Model.
/// In UpSkill Consultancy, student course access is subscription-based across 3 membership tiers.
class MembershipPlanModel extends Equatable {
  final String id;
  final String name;
  final String price;
  final String period;
  final String description;
  final List<String> features;
  final bool isPopular;
  final String? badge;

  const MembershipPlanModel({
    required this.id,
    required this.name,
    required this.price,
    this.period = '/month',
    required this.description,
    required this.features,
    this.isPopular = false,
    this.badge,
  });

  static const List<MembershipPlanModel> defaultPlans = [
    MembershipPlanModel(
      id: 'plan_basic',
      name: 'Basic',
      price: r'$29',
      period: '/mo',
      description: 'Access core foundation courses & daily practice sandboxes.',
      features: [
        'Access to 2 Foundation Courses',
        'Interactive Practice Tools',
        'Community Forum Support',
        'Standard Mobile Access',
      ],
      isPopular: false,
      badge: 'Starter',
    ),
    MembershipPlanModel(
      id: 'plan_standard',
      name: 'Standard Pro',
      price: r'$59',
      period: '/mo',
      description: 'Unlimited catalog access with verified course certificates.',
      features: [
        'All IT Courses Unlocked',
        'Full Practice & XPath Tools',
        'Verified Course Certificates',
        'Weekly Live Q&A Sessions',
      ],
      isPopular: true,
      badge: 'Most Popular',
    ),
    MembershipPlanModel(
      id: 'plan_premium',
      name: 'All-Access Elite',
      price: r'$99',
      period: '/mo',
      description: 'Full training catalog + 1-on-1 career coaching & code reviews.',
      features: [
        'Everything in Standard Pro',
        '1-on-1 Mentor Code Reviews',
        'USA Job Placement Guidance',
        'Mock Technical Interviews',
      ],
      isPopular: false,
      badge: 'Best Value',
    ),
  ];

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        period,
        description,
        features,
        isPopular,
        badge,
      ];
}
