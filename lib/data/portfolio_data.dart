import '../models/portfolio_models.dart';

/// PLACEHOLDER DATA
/// Replace title/description/fileUrl values with your real content.
/// fileUrl can point to a PDF in your GitHub repo (assets/docs/...)
/// or an external Google Drive link.

const String yourName = "Husna Javed";
const String yourTagline = "Computer Science Educator & Aspiring Data Analyst";
const String yourIntro =
    "As a Computer Science teacher with nearly 4 years of experience and a Software Engineering background, I put students at the center of every lesson, encouraging them to build, explore, and problem-solve rather than just memorize. I design hands-on, project-based learning that makes programming and computational thinking practical and relatable, especially in multicultural, English-medium classrooms. I'm enthusiastic about creating an environment where every student feels supported to grow, and I'm excited to bring that student-centered approach to Saudi Arabia's international school community.";

const List<TeachingItem> teachingItems = [
  TeachingItem(
    title: "Algorithms & Flowcharts - Lesson Plan",
    gradeLevel: "Grade 7",
    category: "Lesson Plan",
    description:
        "Builds algorithmic thinking through flowchart design and logic tasks.",
    fileUrl:
        "https://drive.google.com/file/d/1cRbXWThrlkxtaGU2I2dfGTSHxNZoHXiJ/view?usp=sharing",
  ),
  TeachingItem(
    title: "Computer Networks - Lesson Presentation",
    gradeLevel: "Grade 7",
    category: "Presentation",
    description:
        "Explains how networks connect devices and transmit data reliably.",
    fileUrl:
        "https://docs.google.com/presentation/d/1aAPDn2mz0H-RM58OBhvwW1LkYfUFhcIo/edit?usp=sharing&ouid=110983877131614103523&rtpof=true&sd=true",
  ),
  TeachingItem(
    title: "Data Representation - Lesson Presentation",
    gradeLevel: "Grade 6",
    category: "Presentation",
    description:
        "Shows how computers store and represent data using binary code.",
    fileUrl:
        "https://docs.google.com/presentation/d/1jrsJH9kCQG3SW-OptkNqhEkSLtWUYgZy/edit?slide=id.p1#slide=id.p1",
  ),
  TeachingItem(
    title: "Data Representation - Chapter End Worksheet",
    gradeLevel: "Grade 6",
    category: "Worksheet",
    description:
        "Reinforces binary and data representation concepts with practice.",
    fileUrl:
        "https://drive.google.com/file/d/1NDecQYAa1mdI6zK7uNK7thy55N-nVvWy/view?usp=sharing",
  ),
  TeachingItem(
    title: "Human Network Message Passing - Activity",
    gradeLevel: "Grade 8",
    category: "Activity",
    description:
        "Simulates how messages travel across a network through role-play.",
    fileUrl:
        "https://docs.google.com/presentation/d/1XjNqlDAu7hfr_d0KpIwobexxDTGdDwvQ/edit?slide=id.p1#slide=id.p1",
  ),
  TeachingItem(
    title: "Parts of Computer - Activity Worksheet",
    gradeLevel: "Grade 3",
    category: "Activity",
    description:
        "Helps young learners identify and label core computer hardware.",
    fileUrl:
        "https://drive.google.com/file/d/1RGJ8MC8E_V9UVLWdq5bHg6oENs1dsU03/view?usp=sharing",
  ),
  TeachingItem(
    title: "RAM/ROM - Quiz Presentation",
    gradeLevel: "Grade 6",
    category: "Presentation",
    description:
        "Tests understanding of memory types through an interactive quiz.",
    fileUrl:
        "https://docs.google.com/presentation/d/1zDrJLtsUMn8sTksXX9iFj8VHq8MEoLAf/edit?slide=id.p1#slide=id.p1",
  ),
];

const List<TechProject> techProjects = [
  TechProject(
    title: "This Portfolio Website",
    subtitle: "Flutter (Web + Mobile)",
    description:
        "Built and deployed this cross-platform portfolio using Flutter, showing I can design, build, and ship real software, not just talk about it.",
    techStack: ["Flutter", "Dart", "GitHub Pages", "GitHub Actions"],
    repoUrl: "https://husnajaved241.github.io/husna-portfolio/",
  ),
  TechProject(
    title: "Saudi Banking Fraud Detection Dashboard",
    subtitle: "Kaggle + MS Excel",
    description:
        "Excel-based fraud analytics on 8,000+ transactions, uncovered a 4x fraud spike during Hajj season and key risk patterns by location, time, and merchant type. 406 cases flagged, 1.1M SAR identified. Dashboard built in Excel using real data, featuring dynamic filters and drill-downs for actionable insights.",
    techStack: ["Microsoft Excel", "Data Filtering", "Data Visualization"],
    // liveUrl: "https://example.com/replace-with-your-link",
    repoUrl:
        "https://www.linkedin.com/posts/husna-javed_dataanalyst-dataanalytics-exceldashboard-activity-7414193245787787264-dOeZ?utm_source=share&utm_medium=member_desktop&rcm=ACoAADC7R38BiKfspxCSlGAqkQg814_RqRoe_zE",
  ),
  TechProject(
    title: "Saudi Tourism Growth Analysis (2018 - 2023)",
    subtitle: "PowerBI + Data Modeling",
    description:
        "Analyzed five years of Saudi tourism data to challenge the \"more visitors = success\" mindset, uncovering that Tabuk and Eastern Province residents, not Riyadh, are the top spenders per trip, leisure travel now makes up ~43% of visits, and summer 2023 saw record travel spikes. Findings support a shift toward \"High Value, Low Volume\" tourism strategies aligned with Vision 2030.",
    techStack: ["PowerBI", "Data Modeling", "DAX", "MS Excel", "Presentation"],
    repoUrl:
        "https://www.linkedin.com/posts/husna-javed_neomrevenueoptimization-activity-7425780373315436544-zmdz?utm_source=share&utm_medium=member_desktop&rcm=ACoAADC7R38BiKfspxCSlGAqkQg814_RqRoe_zE",
  ),
];

const List<Certificate> certificates = [
  Certificate(
    title: "Flutter And Dart - Completion Certificate",
    issuer: "Udemy",
    year: "2025-2026",
    fileUrl: "https://drive.google.com/file/d/1I8JiQpFwWzyoqI0wbQqp8A4SW89b3ffY/view?usp=sharing",
  ),
  Certificate(
    title: "Appreciation Certificate - Best Teacher of the Year",
    issuer: "Gulistan e Saadi Public School, Mianwali",
    year: "2025-2026",
    fileUrl: "https://example.com/replace-with-your-link",
  ),
  Certificate(
    title: "Achievement Certificate - English Speaking Competition Winner",
    issuer: "Gulistan e Saadi Public School, Mianwali",
    year: "2022",
    fileUrl: "https://example.com/replace-with-your-link",
  ),
  Certificate(
    title: "Appreciation Certificate - ICT Integration Trainer",
    issuer: "Gulistan e Saadi Public School, Mianwali",
    year: "2022",
    fileUrl: "https://example.com/replace-with-your-link",
  ),
  Certificate(
    title: "Appreciation Certificate - Microsoft Office Workshop Facilitator",
    issuer: "Gulistan e Saadi Public School, Mianwali",
    year: "2022",
    fileUrl: "https://example.com/replace-with-your-link",
  ),
];

const String linkedInUrl = "https://www.linkedin.com/in/husna-javed/";
const String githubUrl = "https://github.com/HusnaJaved241";
const String emailAddress = "husnajaved.241@gmail.com";
const String cvDownloadUrl =
    "https://drive.google.com/file/d/1SX17fXlkY-EMYTIzTaGFaw1nWvbI5zcZ/view?usp=sharing";
