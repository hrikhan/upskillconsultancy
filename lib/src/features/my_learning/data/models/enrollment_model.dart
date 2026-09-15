import 'package:equatable/equatable.dart';

/// Wix API-compatible Enrollment / My Learning Model.
class EnrollmentModel extends Equatable {
  final String id;
  final String courseId;
  final String courseTitle;
  final String courseCategory;
  final String instructor;
  final double progress; // 0.0 to 1.0
  final String currentModuleTitle;
  final int completedModules;
  final int totalModules;
  final bool isCompleted;
  final bool certificateEarned;
  final String? certificateUrl;
  final DateTime? lastAccessedAt;

  const EnrollmentModel({
    required this.id,
    required this.courseId,
    required this.courseTitle,
    required this.courseCategory,
    required this.instructor,
    required this.progress,
    required this.currentModuleTitle,
    required this.completedModules,
    required this.totalModules,
    this.isCompleted = false,
    this.certificateEarned = false,
    this.certificateUrl,
    this.lastAccessedAt,
  });

  int get progressPercentage => (progress * 100).round();

  factory EnrollmentModel.fromJson(Map<String, dynamic> json) {
    return EnrollmentModel(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      courseId: json['courseId'] as String? ?? '',
      courseTitle: json['courseTitle'] as String? ?? '',
      courseCategory: json['courseCategory'] as String? ?? 'Engineering',
      instructor: json['instructor'] as String? ?? 'UpSkill Instructor',
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
      currentModuleTitle: json['currentModuleTitle'] as String? ?? '',
      completedModules: (json['completedModules'] as num?)?.toInt() ?? 0,
      totalModules: (json['totalModules'] as num?)?.toInt() ?? 10,
      isCompleted: json['isCompleted'] as bool? ?? false,
      certificateEarned: json['certificateEarned'] as bool? ?? false,
      certificateUrl: json['certificateUrl'] as String?,
      lastAccessedAt: json['lastAccessedAt'] != null
          ? DateTime.tryParse(json['lastAccessedAt'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'courseId': courseId,
      'courseTitle': courseTitle,
      'courseCategory': courseCategory,
      'instructor': instructor,
      'progress': progress,
      'currentModuleTitle': currentModuleTitle,
      'completedModules': completedModules,
      'totalModules': totalModules,
      'isCompleted': isCompleted,
      'certificateEarned': certificateEarned,
      'certificateUrl': certificateUrl,
      'lastAccessedAt': lastAccessedAt?.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        courseId,
        courseTitle,
        progress,
        isCompleted,
        certificateEarned,
      ];
}
