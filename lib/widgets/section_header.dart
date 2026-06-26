import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SectionHeader extends StatelessWidget {
  final String tag;
  final String title;
  final String? subtitle;

  const SectionHeader({
    super.key,
    required this.tag,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
          ),
          child: Text(tag.toUpperCase(), style: AppTextStyles.tag),
        ),
        const SizedBox(height: 14),
        Text(title, style: AppTextStyles.sectionTitle),
        if (subtitle != null) ...[
          const SizedBox(height: 10),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(subtitle!, style: AppTextStyles.body),
          ),
        ],
      ],
    );
  }
}
