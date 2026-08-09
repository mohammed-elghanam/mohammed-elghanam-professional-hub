import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const ProfessionalHubApp());

class AppColors {
  static const navy = Color(0xFF03101D);
  static const navy2 = Color(0xFF061725);
  static const panel = Color(0xFF071D2F);
  static const panel2 = Color(0xFF08253A);
  static const gold = Color(0xFFF2B642);
  static const gold2 = Color(0xFFFFD775);
  static const cyan = Color(0xFF20D9E9);
  static const text = Color(0xFFF7F8FB);
  static const muted = Color(0xFFB7C5D0);
}

class ProfessionalHubApp extends StatelessWidget {
  const ProfessionalHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mohammed Elghanam | Professional Hub',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.navy,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.gold,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.navy,
          foregroundColor: AppColors.text,
          elevation: 0,
          centerTitle: false,
        ),
      ),
      home: const HomePage(),
    );
  }
}

Future<void> openExternal(String url) async {
  final uri = Uri.parse(url);
  await launchUrl(uri, mode: LaunchMode.externalApplication);
}

void openPage(BuildContext context, Widget page) {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget _navCard(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    Widget page,
  ) {
    return _HubCard(
      icon: icon,
      title: title,
      subtitle: subtitle,
      onTap: () => openPage(context, page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.navy2, AppColors.navy],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(22, 22, 22, 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _BrandHeader(),
                      const SizedBox(height: 34),
                      const Text(
                        'R&D CTO',
                        style: TextStyle(
                          color: AppColors.cyan,
                          letterSpacing: 2.0,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Embedded & IoT\nProduct Development',
                        style: TextStyle(
                          fontFamily: 'serif',
                          fontSize: 42,
                          height: 1.0,
                          color: AppColors.gold2,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Smart Metering · LPWAN · FPGA · Industrial Automation · Safety-Critical Systems',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.text,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          _Pill('25+ Years Experience'),
                          _Pill('5 Granted Patents'),
                          _Pill('9 Case Studies'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 30),
              sliver: SliverList.list(
                children: [
                  _navCard(
                    context,
                    Icons.dashboard_customize_rounded,
                    'Executive Portfolio',
                    'Executive profile, leadership positioning and core highlights',
                    const ExecutivePortfolioPage(),
                  ),
                  _navCard(
                    context,
                    Icons.engineering_rounded,
                    'Engineering Projects',
                    'Nine native project case-study summaries inside the app',
                    const ProjectsPage(),
                  ),
                  _navCard(
                    context,
                    Icons.description_rounded,
                    'Executive CV & Career',
                    'Experience, education, certifications and professional positioning',
                    const CareerPage(),
                  ),
                  _navCard(
                    context,
                    Icons.memory_rounded,
                    'Skills & Expertise',
                    'Embedded, IoT, FPGA, industrial, power and leadership expertise',
                    const SkillsPage(),
                  ),
                  _navCard(
                    context,
                    Icons.workspace_premium_rounded,
                    'Recognition & Patents',
                    'Granted patents and international smart-metering recognition',
                    const RecognitionPage(),
                  ),
                  _navCard(
                    context,
                    Icons.contact_mail_rounded,
                    'Contact & Links',
                    'Email, phone, LinkedIn, Facebook and Universal Hub',
                    const ContactPage(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BrandHeader extends StatelessWidget {
  const _BrandHeader();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        _MeSeal(size: 58, fontSize: 24),
        SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mohammed Elghanam',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.gold2,
                ),
              ),
              Text(
                'Professional Hub · Flutter Native Edition',
                style: TextStyle(fontSize: 12, color: Color(0xFF9FB2C1)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MeSeal extends StatelessWidget {
  final double size;
  final double fontSize;
  const _MeSeal({required this.size, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.gold, width: 1.6),
      ),
      alignment: Alignment.center,
      child: Text(
        'ME',
        style: TextStyle(
          fontFamily: 'serif',
          color: AppColors.gold2,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _HubCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _HubCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      color: AppColors.panel,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
        side: BorderSide(color: AppColors.cyan.withValues(alpha: .24)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17),
                  border: Border.all(
                    color: AppColors.gold.withValues(alpha: .82),
                  ),
                ),
                child: Icon(icon, color: AppColors.gold, size: 30),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: AppColors.muted,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: AppColors.cyan),
            ],
          ),
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String text;
  const _Pill(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.panel2,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: AppColors.cyan.withValues(alpha: .35),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Color(0xFFEAF4FA),
        ),
      ),
    );
  }
}

class _NativePage extends StatelessWidget {
  final String kicker;
  final String title;
  final String intro;
  final List<Widget> children;

  const _NativePage({
    required this.kicker,
    required this.title,
    required this.intro,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mohammed Elghanam')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 36),
          children: [
            Text(
              kicker.toUpperCase(),
              style: const TextStyle(
                color: AppColors.cyan,
                letterSpacing: 2.1,
                fontSize: 11,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'serif',
                fontSize: 38,
                height: 1.05,
                color: AppColors.gold2,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              intro,
              style: const TextStyle(
                color: AppColors.muted,
                fontSize: 16,
                height: 1.55,
              ),
            ),
            const SizedBox(height: 24),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _InfoPanel extends StatelessWidget {
  final String title;
  final String text;
  final IconData? icon;
  const _InfoPanel(this.title, this.text, {this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.panel,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.cyan.withValues(alpha: .20),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, color: AppColors.gold, size: 26),
            const SizedBox(width: 14),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.text,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  text,
                  style: const TextStyle(
                    color: AppColors.muted,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ExecutivePortfolioPage extends StatelessWidget {
  const ExecutivePortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _NativePage(
      kicker: 'Executive Portfolio',
      title: 'R&D Leadership\nBuilt Around Products',
      intro:
          'R&D CTO, Solution Architect and Engineering Consultant focused on transforming complex embedded and connected-system ideas into practical, scalable engineering solutions.',
      children: [
        _InfoPanel(
          'Leadership Positioning',
          '25+ years across R&D leadership, embedded systems, IoT product development, smart utilities, FPGA-based systems, industrial automation and safety-critical technology development.',
          icon: Icons.leaderboard_rounded,
        ),
        _InfoPanel(
          'Technology Strategy & Architecture',
          'System architecture, technology strategy, hardware/firmware integration, product development, validation and cross-functional technical leadership.',
          icon: Icons.account_tree_rounded,
        ),
        _InfoPanel(
          'Innovation & IP',
          'Holder of 5 granted patents related to embedded systems, IoT and smart metering innovation.',
          icon: Icons.lightbulb_rounded,
        ),
        _InfoPanel(
          'Consulting Focus',
          'Open to senior technical leadership, solution architecture, engineering consulting, technical advisory, R&D strategy and technology collaboration across Egypt, GCC and remote global markets.',
          icon: Icons.public_rounded,
        ),
      ],
    );
  }
}

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  static const projects = [
    (
      'Smart Utilities & Smart Metering Solutions',
      'Electricity, water and gas metering solutions covering embedded hardware, prepaid concepts, AMI, RS485, cellular, Wi-Fi, PLC communication, data platforms and billing integration.'
    ),
    (
      'Patented LPWAN IoT Platform',
      'End-to-end LPWAN platform covering field devices, gateways, embedded software, cloud connectivity and mobile applications.'
    ),
    (
      'Advanced RTU / Embedded EMS Platforms',
      'RTU, embedded EMS, industrial monitoring and control-system development with architecture definition, hardware/firmware integration, validation and industrial communication protocols.'
    ),
    (
      'Power Grid Protection & Control Systems',
      'Digital overcurrent and earth-fault relay systems for 11kV networks, including testing, commissioning and Foxboro DCS integration.'
    ),
    (
      'Medical Device R&D Systems',
      'Ventilator and oxygen concentrator control-system R&D. Systems received calibration and safety certification from Cairo University Medical Calibration and Safety Center; Egyptian Drug Authority licensing procedures are in progress.'
    ),
    (
      'Unified Azan System',
      'Integrated embedded and communication architecture for coordinated, centralized Azan operation.'
    ),
    (
      'Mission-Critical Communication Platforms',
      'FPGA-based implementation, high-speed processing, hardware review, MMI integration and system validation for mission-critical communication platforms.'
    ),
    (
      'SDR Hardware Review',
      'Technical review and engineering assessment of software-defined radio hardware, including digital processing and high-speed design considerations.'
    ),
    (
      'Railway Level-Crossing System',
      'Safety-focused control and communication engineering for railway level-crossing applications.'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _NativePage(
      kicker: 'Engineering Portfolio',
      title: 'Selected\nProject Case Studies',
      intro:
          'Nine representative engineering programs spanning utilities, IoT, industrial automation, power, medical R&D, communication platforms and safety-critical systems.',
      children: [
        for (var i = 0; i < projects.length; i++)
          _InfoPanel(
            '${(i + 1).toString().padLeft(2, '0')} · ${projects[i].$1}',
            projects[i].$2,
            icon: Icons.engineering_rounded,
          ),
      ],
    );
  }
}

class CareerPage extends StatelessWidget {
  const CareerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _NativePage(
      kicker: 'Executive CV',
      title: 'Career &\nProfessional Record',
      intro:
          'A concise native CV view inside the mobile application. External document downloads are intentionally kept separate from normal app navigation.',
      children: [
        _InfoPanel(
          'Solution Architect · Sanabil Solutions',
          'R&D as a Service · Apr 2026 – Jun 2026',
          icon: Icons.architecture_rounded,
        ),
        _InfoPanel(
          'R&D CTO · EOIP / DLECS Lab R&D',
          '2018 – Oct 2025 · Technical leadership across embedded systems, IoT product development, smart metering, industrial platforms and innovation programs.',
          icon: Icons.business_center_rounded,
        ),
        _InfoPanel(
          'R&D / Embedded Systems Engineering Leader · EOIP',
          'Aug 2000 – Dec 2017 · Embedded hardware, firmware, control, communication and product-development leadership.',
          icon: Icons.memory_rounded,
        ),
        _InfoPanel(
          'Technical Engineer / Reserve Officer',
          'Feb 1998 – Jul 2000 · Technical engineering responsibilities in mission-critical environments.',
          icon: Icons.settings_input_antenna_rounded,
        ),
        _InfoPanel(
          'Teaching & Research Assistant · Banha University',
          'Sep 1998 – Aug 1999 · Faculty of Engineering.',
          icon: Icons.school_rounded,
        ),
        _InfoPanel(
          'Education',
          'B.Sc. Automatic Control & Instrumentation Engineering · Faculty of Engineering, Banha University · 1992–1997 · Very Good with Honors.',
          icon: Icons.school_outlined,
        ),
        _InfoPanel(
          'Selected Training',
          'Foundations of CENELEC · TÜV SÜD Rail GmbH (2015) · PMP Exam Preparation Course (2013) · VHDL Coding · PCB Design According to Digital Constraints.',
          icon: Icons.workspace_premium_outlined,
        ),
      ],
    );
  }
}

class SkillsPage extends StatelessWidget {
  const SkillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _NativePage(
      kicker: 'Core Expertise',
      title: 'Engineering\nCapability Map',
      intro:
          'A condensed view of the technical and leadership domains represented in the full professional skill index.',
      children: [
        _InfoPanel(
          'R&D Leadership & Product Strategy',
          'R&D Leadership · R&D Management · Technology Strategy · Product Development · Solution Architecture · Engineering Consulting · Technical Advisory · Project Management.',
          icon: Icons.stars_rounded,
        ),
        _InfoPanel(
          'Embedded & Hardware',
          'Embedded Systems · Hardware Design · Firmware Development · Hardware/Firmware Integration · PCB Design · High-Speed Digital Design · Signal Integrity · EMC Considerations.',
          icon: Icons.memory_rounded,
        ),
        _InfoPanel(
          'IoT, Smart Metering & Connectivity',
          'IoT Product Development · Smart Metering · Smart Utilities · AMI · Prepaid Metering · LPWAN · RS485 · PLC · Cellular IoT · Wi-Fi Integration.',
          icon: Icons.sensors_rounded,
        ),
        _InfoPanel(
          'FPGA & Digital Systems',
          'FPGA · VHDL · Digital Design · FPGA-Based Systems · Signal Processing · Software-Defined Radio.',
          icon: Icons.developer_board_rounded,
        ),
        _InfoPanel(
          'Industrial, Control & Power',
          'Industrial Automation · RTU · Embedded EMS · Control Systems · Automatic Control · Instrumentation Engineering · Power Grid Protection · Digital Relay Systems · Overcurrent & Earth-Fault Protection.',
          icon: Icons.electrical_services_rounded,
        ),
        _InfoPanel(
          'Safety-Critical & Medical R&D',
          'Safety-Critical Systems · Medical Device R&D · Ventilator Systems · Oxygen Concentrator Systems · validation and cybersecurity considerations for embedded systems.',
          icon: Icons.health_and_safety_rounded,
        ),
      ],
    );
  }
}

class RecognitionPage extends StatelessWidget {
  const RecognitionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _NativePage(
      kicker: 'Recognition & IP',
      title: 'Innovation, Patents\n& Recognition',
      intro:
          'Professional recognition and intellectual-property highlights presented without inventing undocumented patent titles or numbers.',
      children: [
        _InfoPanel(
          '5 Granted Patents',
          'Five granted patents associated with embedded systems, IoT and smart metering innovation.',
          icon: Icons.verified_rounded,
        ),
        _InfoPanel(
          'International Recognition · IIFME Kuwait',
          'Recognition for the invention “Upgrading of Traditional Meters into Smart Meters” at the International Invention Fair of the Middle East, Kuwait, 2018.',
          icon: Icons.emoji_events_rounded,
        ),
        _InfoPanel(
          'Medical R&D Certification Status',
          'Ventilator and oxygen concentrator systems received calibration and safety certification from Cairo University Medical Calibration and Safety Center. Egyptian Drug Authority licensing procedures remain in progress.',
          icon: Icons.medical_services_rounded,
        ),
      ],
    );
  }
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  Widget _action(
    IconData icon,
    String title,
    String value,
    String url,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: FilledButton.tonal(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.panel2,
          foregroundColor: AppColors.text,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: AppColors.cyan.withValues(alpha: .20)),
          ),
        ),
        onPressed: () => openExternal(url),
        child: Row(
          children: [
            Icon(icon, color: AppColors.gold),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 3),
                  Text(value, style: const TextStyle(color: AppColors.muted)),
                ],
              ),
            ),
            const Icon(Icons.open_in_new_rounded, color: AppColors.cyan, size: 19),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _NativePage(
      kicker: 'Contact & Links',
      title: 'Connect &\nCollaborate',
      intro:
          'External actions are limited to genuine communication and social links. Normal portfolio navigation remains inside the Flutter application.',
      children: [
        _action(
          Icons.mail_rounded,
          'Email',
          'Mohammed.elghanam@gmail.com',
          'mailto:Mohammed.elghanam@gmail.com',
        ),
        _action(
          Icons.phone_rounded,
          'Mobile',
          '+20 01147778583',
          'tel:+201147778583',
        ),
        _action(
          Icons.link_rounded,
          'LinkedIn',
          'mohammed-elghanam',
          'https://www.linkedin.com/in/mohammed-elghanam',
        ),
        _action(
          Icons.public_rounded,
          'Facebook',
          'Mohamed Elghanam',
          'https://web.facebook.com/mohamed.elghanam.40869/',
        ),
        _action(
          Icons.language_rounded,
          'Universal Professional Hub',
          'mohammed-elghanam-professional-hub.vercel.app',
          'https://mohammed-elghanam-professional-hub.vercel.app/',
        ),
      ],
    );
  }
}
