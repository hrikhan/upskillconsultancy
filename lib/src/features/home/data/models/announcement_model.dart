import 'package:equatable/equatable.dart';

/// Wix API-compatible Announcement Model.
/// Matches Wix CMS Collection schema (`_id`, `title`, `summary`, etc.).
class AnnouncementModel extends Equatable {
  final String id;
  final String title;
  final String summary;
  final String content;
  final String tag;
  final DateTime date;
  final String? actionText;
  final String? actionUrl;
  final bool isImportant;

  const AnnouncementModel({
    required this.id,
    required this.title,
    required this.summary,
    required this.content,
    required this.tag,
    required this.date,
    this.actionText,
    this.actionUrl,
    this.isImportant = false,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementModel(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      title: json['title'] as String? ?? '',
      summary: json['summary'] as String? ?? '',
      content: json['content'] as String? ?? '',
      tag: json['tag'] as String? ?? 'Notice',
      date: json['date'] != null
          ? DateTime.tryParse(json['date'] as String) ?? DateTime.now()
          : DateTime.now(),
      actionText: json['actionText'] as String?,
      actionUrl: json['actionUrl'] as String?,
      isImportant: json['isImportant'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'summary': summary,
      'content': content,
      'tag': tag,
      'date': date.toIso8601String(),
      'actionText': actionText,
      'actionUrl': actionUrl,
      'isImportant': isImportant,
    };
  }

  @override
  List<Object?> get props => [
        id,
        title,
        summary,
        content,
        tag,
        date,
        actionText,
        actionUrl,
        isImportant,
      ];
}
