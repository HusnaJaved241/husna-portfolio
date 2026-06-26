import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/hero_section.dart';
import '../widgets/teaching_section.dart';
import '../widgets/tech_projects_section.dart';
import '../widgets/certificates_section.dart';
import '../widgets/footer_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _teachingKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            HeroSection(
              onExploreTeaching: () => _scrollTo(_teachingKey),
              onExploreProjects: () => _scrollTo(_projectsKey),
            ),
            KeyedSubtree(key: _teachingKey, child: const TeachingSection()),
            KeyedSubtree(key: _projectsKey, child: const TechProjectsSection()),
            const CertificatesSection(),
            const FooterSection(),
          ],
        ),
      ),
    );
  }
}
