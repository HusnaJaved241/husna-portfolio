import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../models/portfolio_models.dart';
import '../data/portfolio_data.dart';
import 'section_header.dart';
import 'gradient_card.dart';

class TeachingSection extends StatefulWidget {
  const TeachingSection({super.key});

  @override
  State<TeachingSection> createState() => _TeachingSectionState();
}

class _TeachingSectionState extends State<TeachingSection> {
  String _filter = "All";

  static const List<String> _categories = [
    "All",
    "Lesson Plan",
    "Worksheet",
    "Activity",
    "Presentation",
  ];

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    final filtered = _filter == "All"
        ? teachingItems
        : teachingItems.where((t) => t.category == _filter).toList();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 18 : 80, vertical: isMobile ? 50 : 70),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            tag: "Classroom Practice",
            title: "Teaching Portfolio",
            subtitle:
                "A sample of lesson plans, worksheets, activities, and presentations from the Cambridge Lower Secondary Computing curriculum.",
          ),
          const SizedBox(height: 28),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _categories.map((c) {
              final selected = c == _filter;
              return GestureDetector(
                onTap: () => setState(() => _filter = c),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: selected ? AppColors.accentGradient : null,
                    color: selected ? null : AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    c,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: selected ? const Color(0xFF0B0D17) : AppColors.textSecondary,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: filtered.map((item) => _TeachingCard(item: item, onTap: _launch)).toList(),
          ),
        ],
          ),
        ),
      ),
    );
  }
}

class _TeachingCard extends StatelessWidget {
  final TeachingItem item;
  final Future<void> Function(String) onTap;

  const _TeachingCard({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GradientCard(
      onTap: item.fileUrl != null ? () => onTap(item.fileUrl!) : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TagChip(label: item.category),
              const SizedBox(width: 8),
              TagChip(label: item.gradeLevel, accent: true),
            ],
          ),
          const SizedBox(height: 14),
          Text(item.title, style: AppTextStyles.cardTitle),
          const SizedBox(height: 8),
          Text(
            item.description,
            style: AppTextStyles.body.copyWith(fontSize: 13.5),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          if (item.fileUrl != null) ...[
            const SizedBox(height: 14),
            const Row(
              children: [
                Icon(Icons.open_in_new_rounded, size: 14, color: AppColors.accent),
                SizedBox(width: 6),
                Text(
                  "View document",
                  style: TextStyle(fontSize: 12.5, color: AppColors.accent, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
