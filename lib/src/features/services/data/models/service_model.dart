import 'package:equatable/equatable.dart';

/// Wix API-compatible Service Model.
class ServiceModel extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String category;
  final String iconName;
  final String badge;
  final List<String> features;
  final bool isAvailable;

  const ServiceModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.iconName,
    required this.badge,
    this.features = const [],
    this.isAvailable = true,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      category: json['category'] as String? ?? 'Consultancy',
      iconName: json['iconName'] as String? ?? 'code',
      badge: json['badge'] as String? ?? '',
      features: (json['features'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      isAvailable: json['isAvailable'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'subtitle': subtitle,
      'category': category,
      'iconName': iconName,
      'badge': badge,
      'features': features,
      'isAvailable': isAvailable,
    };
  }

  @override
  List<Object?> get props => [
        id,
        title,
        category,
        badge,
        isAvailable,
      ];
}
