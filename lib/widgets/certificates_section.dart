import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../data/portfolio_data.dart';
import 'section_header.dart';
import 'gradient_card.dart';

class CertificatesSection extends StatelessWidget {
  const CertificatesSection({super.key});

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
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 18 : 80, vertical: isMobile ? 50 : 70),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            tag: "Recognition",
            title: "Certificates & Appreciation Letters",
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: certificates
                .map((c) => GradientCard(
                      width: 300,
                      onTap: c.fileUrl != null ? () => _launch(c.fileUrl!) : null,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.workspace_premium_rounded,
                              color: AppColors.accentSecondary, size: 28),
                          const SizedBox(height: 14),
                          Text(c.title, style: AppTextStyles.cardTitle),
                          const SizedBox(height: 8),
                          Text("${c.issuer} · ${c.year}",
                              style: AppTextStyles.body.copyWith(fontSize: 13)),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ],
          ),
        ),
      ),
    );
  }
}
