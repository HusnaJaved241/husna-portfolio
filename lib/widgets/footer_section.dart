import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../data/portfolio_data.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

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
          horizontal: isMobile ? 18 : 80, vertical: isMobile ? 44 : 60),
      decoration: const BoxDecoration(gradient: AppColors.heroGradient),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Let's work together",
                style: AppTextStyles.sectionTitle
                    .copyWith(fontSize: isMobile ? 26 : 32),
              ),
              const SizedBox(height: 12),
              const Text(
                "Open to CS teaching and data analytics roles across Saudi Arabia.",
                style: TextStyle(color: Colors.white70, fontSize: 15),
              ),
              const SizedBox(height: 28),
              Wrap(
                spacing: 14,
                runSpacing: 14,
                children: [
                  _FooterLink(
                      icon: Icons.email_rounded,
                      label: emailAddress,
                      onTap: () => _launch("mailto:$emailAddress")),
                  _FooterLink(
                      icon: Icons.link_rounded,
                      label: "LinkedIn",
                      onTap: () => _launch(linkedInUrl)),
                  _FooterLink(
                      icon: Icons.code_rounded,
                      label: "GitHub",
                      onTap: () => _launch(githubUrl)),
                ],
              ),
              const SizedBox(height: 36),
              const Divider(color: Colors.white24),
              const SizedBox(height: 16),
              Text(
                "© ${DateTime.now().year} $yourName - Built with Flutter",
                style: const TextStyle(color: Colors.white54, fontSize: 12.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _FooterLink(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: Colors.white),
            const SizedBox(width: 8),
            Text(label,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 13.5)),
          ],
        ),
      ),
    );
  }
}
