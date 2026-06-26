import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../data/portfolio_data.dart';
import 'animated_text.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onExploreTeaching;
  final VoidCallback onExploreProjects;

  const HeroSection({
    super.key,
    required this.onExploreTeaching,
    required this.onExploreProjects,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  // Each stage waits for the previous one to genuinely finish, then adds
  // its own pause, so the hero reveals like a sequence of small beats
  // rather than everything firing on a shared timer.
  bool _startTagline = false;
  bool _showIntro = false;
  bool _showButtons = false;

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _onNameRevealed() {
    // Small pause after the name lands before the tagline starts typing.
    Future.delayed(const Duration(milliseconds: 250), () {
      if (mounted) setState(() => _startTagline = true);
    });
  }

  void _onTaglineComplete() {
    // Deliberate breath after typing finishes before the intro fades in —
    // this is the pause that was missing before.
    Future.delayed(const Duration(milliseconds: 450), () {
      if (mounted) setState(() => _showIntro = true);
    });
    Future.delayed(const Duration(milliseconds: 750), () {
      if (mounted) setState(() => _showButtons = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;

    final crossAlign =
        isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final textAlign = isMobile ? TextAlign.center : TextAlign.left;
    final wrapAlign = isMobile ? WrapAlignment.center : WrapAlignment.start;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: isMobile ? 56 : 100,
      ),
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0.7, -0.6),
          radius: 1.4,
          colors: [Color(0xFF2A2470), AppColors.background],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: isMobile ? double.infinity : 900),
          child: Column(
            crossAxisAlignment: crossAlign,
            children: [
              RevealOnDelay(
                delay: Duration.zero,
                duration: const Duration(milliseconds: 450),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: AppColors.accentGradient,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Text(
                    "AVAILABLE FOR OPPORTUNITIES IN KSA",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0B0D17),
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              GradientRevealText(
                text: yourName,
                textAlign: textAlign,
                style: AppTextStyles.heroTitle.copyWith(
                  fontSize: isMobile ? 34 : 56,
                ),
                gradientColors: const [
                  AppColors.primary,
                  AppColors.accent,
                  AppColors.accentSecondary,
                ],
                delay: const Duration(milliseconds: 300),
                wordStagger: const Duration(milliseconds: 160),
                wordDuration: const Duration(milliseconds: 600),
                onComplete: _onNameRevealed,
              ),
              const SizedBox(height: 16),
              if (_startTagline)
                TypewriterText(
                  text: yourTagline,
                  textAlign: textAlign,
                  style: TextStyle(
                    fontSize: isMobile ? 15.5 : 20,
                    color: AppColors.accentSecondary,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                  charDuration: const Duration(milliseconds: 28),
                  onComplete: _onTaglineComplete,
                )
              else
                // Reserves the same height so layout doesn't jump when
                // the typewriter widget mounts.
                SizedBox(
                  height: isMobile ? 22 : 28,
                ),
              const SizedBox(height: 20),
              if (_showIntro)
                RevealOnDelay(
                  delay: Duration.zero,
                  child: Text(
                    yourIntro,
                    textAlign: textAlign,
                    style: AppTextStyles.body.copyWith(
                      fontSize: isMobile ? 14 : 15,
                    ),
                  ),
                ),
              const SizedBox(height: 36),
              if (_showButtons)
                RevealOnDelay(
                  delay: Duration.zero,
                  child: Wrap(
                    alignment: wrapAlign,
                    spacing: 14,
                    runSpacing: 12,
                    children: [
                      _PrimaryButton(
                        label: "View Teaching Portfolio",
                        onTap: widget.onExploreTeaching,
                        compact: isMobile,
                      ),
                      _SecondaryButton(
                        label: "View Tech Projects",
                        onTap: widget.onExploreProjects,
                        compact: isMobile,
                      ),
                      _IconButton(
                        label: "Download CV",
                        onTap: () => _launch(cvDownloadUrl),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool compact;
  const _PrimaryButton({
    required this.label,
    required this.onTap,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 18 : 26,
          vertical: compact ? 14 : 18,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: compact ? 13.5 : 15,
        ),
      ),
      child: Text(label),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool compact;
  const _SecondaryButton({
    required this.label,
    required this.onTap,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.textPrimary,
        side: const BorderSide(color: AppColors.cardBorder, width: 1.4),
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 18 : 26,
          vertical: compact ? 14 : 18,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: compact ? 13.5 : 15,
        ),
      ),
      child: Text(label),
    );
  }
}

class _IconButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _IconButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onTap,
      icon: const Icon(Icons.download_rounded, size: 18, color: AppColors.accentSecondary),
      label: Text(
        label,
        style: const TextStyle(color: AppColors.accentSecondary, fontWeight: FontWeight.w600),
      ),
    );
  }
}