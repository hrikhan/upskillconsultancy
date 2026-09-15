import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class PracticeToolModel {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final Color accentColor;
  final String tag;

  const PracticeToolModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.accentColor,
    required this.tag,
  });

  static const List<PracticeToolModel> defaultTools = [
    PracticeToolModel(
      id: 'tool_automation',
      title: 'Automation Sandbox',
      subtitle: 'Selenium & Playwright Lab',
      description:
          'Interactive browser playground to test automated scripts, locate dynamic web elements, and inspect live DOM trees.',
      icon: IconsaxPlusBold.code_circle,
      accentColor: Color(0xFF019BFE), // UC Blue
      tag: 'QA Lab',
    ),
    PracticeToolModel(
      id: 'tool_coding',
      title: 'Coding Exercise',
      subtitle: 'Java, Python & Dart IDE',
      description:
          'In-browser sandbox with automated unit tests for data structures, algorithms, and object-oriented exercises.',
      icon: IconsaxPlusBold.programming_arrows,
      accentColor: Color(0xFF10B981), // Emerald
      tag: 'Coding',
    ),
    PracticeToolModel(
      id: 'tool_xpath',
      title: 'XPath Brainteaser',
      subtitle: 'Selector Challenge Engine',
      description:
          'Sharpen your locator strategies with real-world tricky HTML snippets, shadow DOMs, and nested iframes.',
      icon: IconsaxPlusBold.hierarchy,
      accentColor: Color(0xFFF59E0B), // Amber
      tag: 'Selectors',
    ),
    PracticeToolModel(
      id: 'tool_sql',
      title: 'SQL Studio',
      subtitle: 'Live Relational DB Sandbox',
      description:
          'Run queries, join tables, and test complex queries against realistic schema datasets directly on mobile.',
      icon: IconsaxPlusBold.data,
      accentColor: Color(0xFF8B5CF6), // Purple
      tag: 'Database',
    ),
  ];
}
