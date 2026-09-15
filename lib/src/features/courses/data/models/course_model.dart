import 'package:equatable/equatable.dart';

/// Wix API-compatible Course Model.
/// Supports both Wix CMS Collection schema (`_id`) and standard REST JSON.
class CourseModel extends Equatable {
  final String id;
  final String title;
  final String category;
  final String description;
  final String instructor;
  final double rating;
  final int reviewsCount;
  final String duration;
  final String level;
  final double price;
  final double? originalPrice;
  final bool isFeatured;
  final bool isTopCourse;
  final int modulesCount;
  final String? thumbnailUrl;
  final List<String> tags;

  const CourseModel({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.instructor,
    required this.rating,
    required this.reviewsCount,
    required this.duration,
    required this.level,
    required this.price,
    this.originalPrice,
    this.isFeatured = false,
    this.isTopCourse = false,
    this.modulesCount = 12,
    this.thumbnailUrl,
    this.tags = const [],
  });

  String get formattedPrice => '\$${price.toStringAsFixed(0)}';
  String? get formattedOriginalPrice =>
      originalPrice != null ? '\$${originalPrice!.toStringAsFixed(0)}' : null;

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      // Support Wix `_id` or standard `id`
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      title: json['title'] as String? ?? '',
      category: json['category'] as String? ?? 'General',
      description: json['description'] as String? ?? '',
      instructor: json['instructor'] as String? ?? 'Md Rasel Ahmed',
      rating: (json['rating'] as num?)?.toDouble() ?? 4.8,
      reviewsCount: (json['reviewsCount'] as num?)?.toInt() ?? 100,
      duration: json['duration'] as String? ?? '12 Weeks',
      level: json['level'] as String? ?? 'All Levels',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      originalPrice: (json['originalPrice'] as num?)?.toDouble(),
      isFeatured: json['isFeatured'] as bool? ?? false,
      isTopCourse: json['isTopCourse'] as bool? ?? false,
      modulesCount: (json['modulesCount'] as num?)?.toInt() ?? 10,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      tags: (json['tags'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'category': category,
      'description': description,
      'instructor': instructor,
      'rating': rating,
      'reviewsCount': reviewsCount,
      'duration': duration,
      'level': level,
      'price': price,
      'originalPrice': originalPrice,
      'isFeatured': isFeatured,
      'isTopCourse': isTopCourse,
      'modulesCount': modulesCount,
      'thumbnailUrl': thumbnailUrl,
      'tags': tags,
    };
  }

  @override
  List<Object?> get props => [
        id,
        title,
        category,
        price,
        rating,
        isFeatured,
        isTopCourse,
      ];
}
