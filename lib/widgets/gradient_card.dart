import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// A card with a subtle gradient background, border, and hover-lift effect.
/// Used across teaching items, projects, and certificates for a consistent
/// "bold & modern" feel.
class GradientCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double width;

  const GradientCard({
    super.key,
    required this.child,
    this.onTap,
    this.width = 340,
  });

  @override
  State<GradientCard> createState() => _GradientCardState();
}

class _GradientCardState extends State<GradientCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // On narrow screens, cap the card at (screen width - outer padding)
    // instead of a fixed pixel value, so it never overflows horizontally.
    final effectiveWidth =
        screenWidth < widget.width + 40 ? screenWidth - 40 : widget.width;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: effectiveWidth,
          transform: Matrix4.translationValues(0, _hovering ? -6 : 0, 0),
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: AppColors.cardGradient,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: _hovering ? AppColors.accent : AppColors.cardBorder,
              width: 1.2,
            ),
            boxShadow: _hovering
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.25),
                      blurRadius: 24,
                      offset: const Offset(0, 10),
                    ),
                  ]
                : [],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

class TagChip extends StatelessWidget {
  final String label;
  final bool accent;

  const TagChip({super.key, required this.label, this.accent = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: accent
            ? AppColors.accent.withValues(alpha: 0.15)
            : AppColors.primary.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
          color: accent ? AppColors.accent : AppColors.primary,
        ),
      ),
    );
  }
}
