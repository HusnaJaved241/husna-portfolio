import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../models/portfolio_models.dart';
import '../data/portfolio_data.dart';
import 'section_header.dart';

class TechProjectsSection extends StatelessWidget {
  const TechProjectsSection({super.key});

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 18 : 80,
        vertical: isMobile ? 50 : 70,
      ),
      color: AppColors.surface,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                tag: "Beyond the Classroom",
                title: "Technical Projects",
                subtitle:
                    "Real pojects I've designed and built which is a proof that I work hands-on with the subject I teach.",
              ),
              const SizedBox(height: 32),
              ...techProjects.map((p) => Padding(
                    padding: const EdgeInsets.only(bottom: 22),
                    child: _ProjectCard(
                        project: p, isMobile: isMobile, onLaunch: _launch),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final TechProject project;
  final bool isMobile;
  final Future<void> Function(String) onLaunch;

  const _ProjectCard(
      {required this.project, required this.isMobile, required this.onLaunch});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          gradient: AppColors.cardGradient,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovering ? AppColors.primary : AppColors.cardBorder,
            width: 1.4,
          ),
        ),
        // On mobile we stack vertically with a plain Column (no Expanded,
        // since there is no bounded height to expand into). On desktop we
        // use a Row where Expanded is safe because the Row gives it a
        // bounded width.
        child: widget.isMobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ProjectInfo(project: p),
                  const SizedBox(height: 20),
                  _ProjectLinks(
                      project: p, onLaunch: widget.onLaunch, fullWidth: true),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: _ProjectInfo(project: p),
                  ),
                  const SizedBox(width: 24),
                  _ProjectLinks(
                      project: p, onLaunch: widget.onLaunch, fullWidth: false),
                ],
              ),
      ),
    );
  }
}

/// Title, subtitle, description, and tech stack chips. Shared between
/// mobile and desktop layouts.
class _ProjectInfo extends StatelessWidget {
  final TechProject project;
  const _ProjectInfo({required this.project});

  @override
  Widget build(BuildContext context) {
    final p = project;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          p.subtitle.toUpperCase(),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: AppColors.accentSecondary,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 8),
        Text(p.title, style: AppTextStyles.cardTitle.copyWith(fontSize: 20)),
        const SizedBox(height: 12),
        Text(p.description, style: AppTextStyles.body),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: p.techStack
              .map((t) => Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      t,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

/// "View Live" / "View Code" buttons. Full-width stacked on mobile,
/// fixed-width side column on desktop.
class _ProjectLinks extends StatelessWidget {
  final TechProject project;
  final Future<void> Function(String) onLaunch;
  final bool fullWidth;

  const _ProjectLinks({
    required this.project,
    required this.onLaunch,
    required this.fullWidth,
  });

  @override
  Widget build(BuildContext context) {
    final p = project;
    final buttons = <Widget>[
      if (p.liveUrl != null)
        _LinkButton(
          label: "View Live",
          icon: Icons.launch_rounded,
          primary: true,
          fullWidth: fullWidth,
          onTap: () => onLaunch(p.liveUrl!),
        ),
      if (p.liveUrl != null) const SizedBox(height: 10),
      if (p.repoUrl != null)
        _LinkButton(
          label: "View",
          icon: Icons.code_rounded,
          primary: false,
          fullWidth: fullWidth,
          onTap: () => onLaunch(p.repoUrl!),
        ),
    ];

    if (fullWidth) {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: buttons);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: buttons,
    );
  }
}

class _LinkButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool primary;
  final bool fullWidth;
  final VoidCallback onTap;

  const _LinkButton({
    required this.label,
    required this.icon,
    required this.primary,
    required this.onTap,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fullWidth ? double.infinity : 160,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 16),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: primary ? AppColors.primary : AppColors.surfaceLight,
          foregroundColor: primary ? Colors.white : AppColors.textPrimary,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          elevation: 0,
        ),
      ),
    );
  }
}
