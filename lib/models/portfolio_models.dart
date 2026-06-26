/// Represents a single teaching resource: lesson plan, worksheet,
/// activity, or presentation.
class TeachingItem {
  final String title;
  final String gradeLevel;
  final String category; // Lesson Plan, Worksheet, Activity, Presentation
  final String description;
  final String? fileUrl; // link to PDF/PPT hosted on Drive or repo
  final String? thumbnailAsset;

  const TeachingItem({
    required this.title,
    required this.gradeLevel,
    required this.category,
    required this.description,
    this.fileUrl,
    this.thumbnailAsset,
  });
}

/// Represents a tech/data project (dashboard, app, website).
class TechProject {
  final String title;
  final String subtitle;
  final String description;
  final List<String> techStack;
  final String? liveUrl;
  final String? repoUrl;
  final String? thumbnailAsset;

  const TechProject({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.techStack,
    this.liveUrl,
    this.repoUrl,
    this.thumbnailAsset,
  });
}

/// Represents a certificate or appreciation letter.
class Certificate {
  final String title;
  final String issuer;
  final String year;
  final String? fileUrl;
  final String? thumbnailAsset;

  const Certificate({
    required this.title,
    required this.issuer,
    required this.year,
    this.fileUrl,
    this.thumbnailAsset,
  });
}
