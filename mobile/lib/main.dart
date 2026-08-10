import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:url_launcher/url_launcher.dart';

import 'document_factory.dart';
import 'portrait_data.dart';

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
      title: 'Mohammed Elghanam | Executive Hub',
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
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: AppColors.navy2,
          indicatorColor: AppColors.gold.withValues(alpha: .18),
          labelTextStyle: const WidgetStatePropertyAll(
            TextStyle(fontWeight: FontWeight.w700, fontSize: 11),
          ),
        ),
      ),
      home: const ExecutiveShell(),
    );
  }
}

Future<void> openExternal(String url) async {
  final uri = Uri.parse(url);
  await launchUrl(uri, mode: LaunchMode.externalApplication);
}

void pushPage(BuildContext context, Widget page) {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
}

class ExecutiveShell extends StatefulWidget {
  const ExecutiveShell({super.key});

  @override
  State<ExecutiveShell> createState() => _ExecutiveShellState();
}

class _ExecutiveShellState extends State<ExecutiveShell> {
  int index = 0;

  final pages = const [
    HomePage(),
    ProjectsPage(),
    DocumentLibraryPage(),
    ContactPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: index, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) => setState(() => index = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_rounded), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.engineering_rounded), label: 'Projects'),
          NavigationDestination(icon: Icon(Icons.picture_as_pdf_rounded), label: 'Documents'),
          NavigationDestination(icon: Icon(Icons.contact_mail_rounded), label: 'Contact'),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final portrait = base64Decode(kPortraitJpegBase64);
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF0A2940), AppColors.navy],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _TopBrand(),
                    const SizedBox(height: 24),
                    _ExecutiveHero(portrait: portrait),
                    const SizedBox(height: 20),
                    const Row(
                      children: [
                        Expanded(child: _Metric(value: '25+', label: 'Years R&D')),
                        SizedBox(width: 8),
                        Expanded(child: _Metric(value: '5', label: 'Patents')),
                        SizedBox(width: 8),
                        Expanded(child: _Metric(value: '9', label: 'Case Studies')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
            sliver: SliverList.list(
              children: [
                const _SectionLabel('EXECUTIVE DASHBOARD'),
                const SizedBox(height: 10),
                _ActionCard(
                  icon: Icons.dashboard_customize_rounded,
                  title: 'Executive Portfolio',
                  subtitle: 'Leadership positioning, strategy, innovation and consulting value',
                  onTap: () => pushPage(context, const ExecutivePortfolioPage()),
                ),
                _ActionCard(
                  icon: Icons.description_rounded,
                  title: 'Career & Executive CV',
                  subtitle: 'Experience, education, certifications and professional record',
                  onTap: () => pushPage(context, const CareerPage()),
                ),
                _ActionCard(
                  icon: Icons.memory_rounded,
                  title: 'Skills & Expertise',
                  subtitle: 'Embedded, IoT, FPGA, industrial, power and safety-critical capability map',
                  onTap: () => pushPage(context, const SkillsPage()),
                ),
                _ActionCard(
                  icon: Icons.workspace_premium_rounded,
                  title: 'Recognition & Patents',
                  subtitle: 'Granted patents, IIFME recognition and regulated engineering status',
                  onTap: () => pushPage(context, const RecognitionPage()),
                ),
                _ActionCard(
                  icon: Icons.picture_as_pdf_rounded,
                  title: 'Executive Document Center',
                  subtitle: 'Open professional PDFs inside the app with zoom and scrolling',
                  onTap: () => pushPage(context, const DocumentLibraryPage(showBack: true)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TopBrand extends StatelessWidget {
  const _TopBrand();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        _MeSeal(size: 48, fontSize: 20),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mohammed Elghanam',
                style: TextStyle(color: AppColors.gold2, fontWeight: FontWeight.w800, fontSize: 18),
              ),
              Text(
                'R&D CTO · Mobile Executive Edition',
                style: TextStyle(color: AppColors.muted, fontSize: 11),
              ),
            ],
          ),
        ),
        _VersionChip(),
      ],
    );
  }
}

class _VersionChip extends StatelessWidget {
  const _VersionChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.panel2,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.cyan.withValues(alpha: .3)),
      ),
      child: const Text('V3', style: TextStyle(color: AppColors.cyan, fontSize: 10, fontWeight: FontWeight.w900)),
    );
  }
}

class _ExecutiveHero extends StatelessWidget {
  final Uint8List portrait;
  const _ExecutiveHero({required this.portrait});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.panel.withValues(alpha: .92),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: AppColors.gold.withValues(alpha: .52)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: .35), blurRadius: 24, offset: const Offset(0, 10)),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: LayoutBuilder(
        builder: (context, c) {
          return c.maxWidth < 500
              ? Column(
                  children: [
                    SizedBox(
                      height: 280,
                      width: double.infinity,
                      child: Image.memory(
                        portrait,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                        filterQuality: FilterQuality.high,
                        gaplessPlayback: true,
                      ),
                    ),
                    const _HeroCopy(),
                  ],
                )
              : Row(
                  children: [
                    SizedBox(
                      width: c.maxWidth * .38,
                      height: 330,
                      child: Image.memory(
                        portrait,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                        filterQuality: FilterQuality.high,
                        gaplessPlayback: true,
                      ),
                    ),
                    const Expanded(child: _HeroCopy()),
                  ],
                );
        },
      ),
    );
  }
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('EXECUTIVE PROFESSIONAL PROFILE',
              style: TextStyle(color: AppColors.cyan, letterSpacing: 1.7, fontSize: 10, fontWeight: FontWeight.w900)),
          SizedBox(height: 8),
          Text('Mohammed\nElghanam',
              style: TextStyle(fontFamily: 'serif', color: AppColors.gold2, fontSize: 38, height: .95, fontWeight: FontWeight.w700)),
          SizedBox(height: 12),
          Text('R&D CTO · Solution Architect · Engineering Consultant',
              style: TextStyle(color: AppColors.text, fontSize: 14, height: 1.4, fontWeight: FontWeight.w700)),
          SizedBox(height: 8),
          Text('Embedded & IoT Product Development · Smart Metering · LPWAN · FPGA · Industrial Automation · Safety-Critical Systems',
              style: TextStyle(color: AppColors.muted, fontSize: 13, height: 1.45)),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  final String value;
  final String label;
  const _Metric({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.panel,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: AppColors.cyan.withValues(alpha: .18)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(value, style: const TextStyle(fontFamily: 'serif', color: AppColors.gold2, fontSize: 24, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: AppColors.muted, fontSize: 10, fontWeight: FontWeight.w700)),
      ]),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: const TextStyle(color: AppColors.cyan, letterSpacing: 1.8, fontSize: 11, fontWeight: FontWeight.w900),
      );
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
      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.gold, width: 1.5)),
      alignment: Alignment.center,
      child: Text('ME',
          style: TextStyle(fontFamily: 'serif', color: AppColors.gold2, fontSize: fontSize, fontWeight: FontWeight.bold)),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionCard({required this.icon, required this.title, required this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: AppColors.panel,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: AppColors.cyan.withValues(alpha: .18)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(17),
          child: Row(children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColors.gold.withValues(alpha: .75)),
                color: AppColors.navy2,
              ),
              child: Icon(icon, color: AppColors.gold, size: 27),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: const TextStyle(color: AppColors.text, fontSize: 17, fontWeight: FontWeight.w800)),
                const SizedBox(height: 5),
                Text(subtitle, style: const TextStyle(color: AppColors.muted, height: 1.35, fontSize: 13)),
              ]),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColors.cyan),
          ]),
        ),
      ),
    );
  }
}

class DocumentLibraryPage extends StatelessWidget {
  final bool showBack;
  const DocumentLibraryPage({super.key, this.showBack = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showBack ? AppBar(title: const Text('Executive Document Center')) : null,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 28),
          children: [
            const _SectionLabel('IN-APP PDF LIBRARY'),
            const SizedBox(height: 8),
            const Text('Executive Document Center',
                style: TextStyle(fontFamily: 'serif', color: AppColors.gold2, fontSize: 34, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            const Text(
              'These documents are generated and displayed entirely inside the Flutter app. Pinch to zoom and scroll through pages without being redirected to the download website.',
              style: TextStyle(color: AppColors.muted, height: 1.5),
            ),
            const SizedBox(height: 20),
            for (final doc in executiveDocuments)
              _DocumentCard(document: doc),
          ],
        ),
      ),
    );
  }
}

class _DocumentCard extends StatelessWidget {
  final ExecutiveDocument document;
  const _DocumentCard({required this.document});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      color: AppColors.panel,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: AppColors.gold.withValues(alpha: .34)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => pushPage(context, PdfLoadingPage(document: document)),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(children: [
            Container(
              width: 58,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.navy2,
                borderRadius: BorderRadius.circular(13),
                border: Border.all(color: AppColors.gold.withValues(alpha: .7)),
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.picture_as_pdf_rounded, color: AppColors.gold, size: 30),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(document.title, style: const TextStyle(color: AppColors.text, fontSize: 17, fontWeight: FontWeight.w900)),
                const SizedBox(height: 6),
                Text(document.subtitle, style: const TextStyle(color: AppColors.muted, height: 1.4)),
                const SizedBox(height: 10),
                const Row(children: [
                  Icon(Icons.open_in_full_rounded, color: AppColors.cyan, size: 16),
                  SizedBox(width: 5),
                  Text('Open inside app', style: TextStyle(color: AppColors.cyan, fontSize: 12, fontWeight: FontWeight.w800)),
                ]),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}

class PdfLoadingPage extends StatefulWidget {
  final ExecutiveDocument document;
  const PdfLoadingPage({super.key, required this.document});

  @override
  State<PdfLoadingPage> createState() => _PdfLoadingPageState();
}

class _PdfLoadingPageState extends State<PdfLoadingPage> {
  late final Future<Uint8List> future = widget.document.build();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.document.title)),
      body: FutureBuilder<Uint8List>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text('Unable to generate this document: ${snapshot.error}', textAlign: TextAlign.center),
              ),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator(color: AppColors.gold));
          }
          return PdfViewer.data(
            snapshot.data!,
            sourceName: widget.document.fileName,
            params: const PdfViewerParams(
              backgroundColor: AppColors.navy2,
              margin: 8,
            ),
          );
        },
      ),
    );
  }
}

class _NativePage extends StatelessWidget {
  final String kicker;
  final String title;
  final String intro;
  final List<Widget> children;

  const _NativePage({required this.kicker, required this.title, required this.intro, required this.children});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mohammed Elghanam')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 34),
          children: [
            _SectionLabel(kicker),
            const SizedBox(height: 9),
            Text(title,
                style: const TextStyle(fontFamily: 'serif', fontSize: 36, height: 1.05, color: AppColors.gold2, fontWeight: FontWeight.w700)),
            const SizedBox(height: 13),
            Text(intro, style: const TextStyle(color: AppColors.muted, fontSize: 15, height: 1.5)),
            const SizedBox(height: 20),
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
  final IconData icon;
  const _InfoPanel(this.title, this.text, {required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: AppColors.panel,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.cyan.withValues(alpha: .18)),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(icon, color: AppColors.gold, size: 25),
        const SizedBox(width: 13),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(color: AppColors.text, fontSize: 16, fontWeight: FontWeight.w800)),
            const SizedBox(height: 6),
            Text(text, style: const TextStyle(color: AppColors.muted, height: 1.48)),
          ]),
        ),
      ]),
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
      intro: 'R&D CTO, Solution Architect and Engineering Consultant transforming complex embedded and connected-system ideas into practical, scalable engineering solutions.',
      children: [
        _InfoPanel('Leadership Positioning', '25+ years across R&D leadership, embedded systems, IoT product development, smart utilities, FPGA-based systems, industrial automation and safety-critical technology development.', icon: Icons.leaderboard_rounded),
        _InfoPanel('Technology Strategy & Architecture', 'System architecture, technology strategy, hardware/firmware integration, product development, validation and cross-functional technical leadership.', icon: Icons.account_tree_rounded),
        _InfoPanel('Innovation & IP', 'Holder of 5 granted patents related to embedded systems, IoT and smart metering innovation.', icon: Icons.lightbulb_rounded),
        _InfoPanel('Consulting Focus', 'Senior technical leadership, solution architecture, engineering consulting, technical advisory, R&D strategy and technology collaboration across Egypt, GCC and remote global markets.', icon: Icons.public_rounded),
      ],
    );
  }
}

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  static const projects = [
    ('Smart Utilities & Smart Metering Solutions', 'Electricity, water and gas metering solutions covering embedded hardware, prepaid concepts, AMI, RS485, cellular, Wi-Fi, PLC communication, data platforms and billing integration.'),
    ('Patented LPWAN IoT Platform', 'End-to-end LPWAN platform covering field devices, gateways, embedded software, cloud connectivity and mobile applications.'),
    ('Advanced RTU / Embedded EMS Platforms', 'RTU, embedded EMS, industrial monitoring and control-system development with architecture definition, hardware/firmware integration, validation and industrial communication protocols.'),
    ('Power Grid Protection & Control Systems', 'Digital overcurrent and earth-fault relay systems for 11kV networks, including testing, commissioning and Foxboro DCS integration.'),
    ('Medical Device R&D Systems', 'Ventilator and oxygen concentrator control-system R&D. Calibration and safety certification were completed through Cairo University Medical Calibration and Safety Center; Egyptian Drug Authority licensing procedures are in progress.'),
    ('Unified Azan System', 'Integrated embedded and communication architecture for coordinated, centralized Azan operation.'),
    ('Mission-Critical Communication Platforms', 'FPGA-based implementation, high-speed processing, hardware review, MMI integration and system validation.'),
    ('SDR Hardware Review', 'Engineering assessment of software-defined radio hardware, digital processing and high-speed design considerations.'),
    ('Railway Level-Crossing System', 'Safety-focused control and communication engineering for railway level-crossing applications.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 28),
          children: [
            const _SectionLabel('ENGINEERING PROJECTS'),
            const SizedBox(height: 8),
            const Text('Selected Case Studies',
                style: TextStyle(fontFamily: 'serif', color: AppColors.gold2, fontSize: 34, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            const Text('Nine representative engineering programs spanning smart utilities, IoT, industrial automation, power systems, medical R&D and safety-critical technology.',
                style: TextStyle(color: AppColors.muted, height: 1.5)),
            const SizedBox(height: 18),
            for (var i = 0; i < projects.length; i++)
              _InfoPanel('${(i + 1).toString().padLeft(2, '0')} · ${projects[i].$1}', projects[i].$2, icon: Icons.engineering_rounded),
          ],
        ),
      ),
    );
  }
}

class CareerPage extends StatelessWidget {
  const CareerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _NativePage(
      kicker: 'Career & Executive CV',
      title: 'Professional\nRecord',
      intro: 'A native executive summary of experience, education and selected professional training.',
      children: [
        _InfoPanel('Solution Architect · Sanabil Solutions', 'R&D as a Service · Apr 2026–Jun 2026.', icon: Icons.architecture_rounded),
        _InfoPanel('R&D CTO · EOIP / DLECS Lab R&D', '2018–Oct 2025 · R&D leadership across embedded systems, IoT, smart metering, industrial platforms and innovation programs.', icon: Icons.business_center_rounded),
        _InfoPanel('R&D / Embedded Systems Engineering Leader · EOIP', 'Aug 2000–Dec 2017 · Embedded hardware, firmware, control, communication and product-development leadership.', icon: Icons.memory_rounded),
        _InfoPanel('Technical Engineer / Reserve Officer', 'Feb 1998–Jul 2000 · Technical engineering responsibilities in mission-critical environments.', icon: Icons.settings_input_antenna_rounded),
        _InfoPanel('Teaching & Research Assistant · Banha University', 'Sep 1998–Aug 1999 · Faculty of Engineering.', icon: Icons.school_rounded),
        _InfoPanel('Education', 'B.Sc. Automatic Control & Instrumentation Engineering · Faculty of Engineering, Banha University · 1992–1997 · Very Good with Honors.', icon: Icons.school_outlined),
        _InfoPanel('Selected Training', 'Foundations of CENELEC · TÜV SÜD Rail GmbH (2015) · PMP Exam Preparation Course (2013) · VHDL Coding · PCB Design According to Digital Constraints.', icon: Icons.workspace_premium_outlined),
      ],
    );
  }
}

class SkillsPage extends StatelessWidget {
  const SkillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _NativePage(
      kicker: 'Skills & Expertise',
      title: 'Engineering\nCapability Map',
      intro: 'Core technical and leadership domains represented in the professional skill index.',
      children: [
        _InfoPanel('R&D Leadership & Product Strategy', 'R&D Leadership · R&D Management · Technology Strategy · Product Development · Solution Architecture · Engineering Consulting · Technical Advisory · Project Management.', icon: Icons.stars_rounded),
        _InfoPanel('Embedded & Hardware', 'Embedded Systems · Hardware Design · Firmware Development · Hardware/Firmware Integration · PCB Design · High-Speed Digital Design · Signal Integrity · EMC Considerations.', icon: Icons.memory_rounded),
        _InfoPanel('IoT, Smart Metering & Connectivity', 'IoT Product Development · Smart Metering · Smart Utilities · AMI · Prepaid Metering · LPWAN · RS485 · PLC · Cellular IoT · Wi-Fi Integration.', icon: Icons.sensors_rounded),
        _InfoPanel('FPGA & Digital Systems', 'FPGA · VHDL · Digital Design · FPGA-Based Systems · Signal Processing · Software-Defined Radio.', icon: Icons.developer_board_rounded),
        _InfoPanel('Industrial, Control & Power', 'Industrial Automation · RTU · Embedded EMS · Control Systems · Instrumentation · Power Grid Protection · Digital Relay Systems · Overcurrent & Earth-Fault Protection.', icon: Icons.electrical_services_rounded),
        _InfoPanel('Safety-Critical & Medical R&D', 'Safety-Critical Systems · Medical Device R&D · Ventilator Systems · Oxygen Concentrator Systems · validation and cybersecurity considerations for embedded systems.', icon: Icons.health_and_safety_rounded),
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
      intro: 'Professional recognition and intellectual-property highlights without inventing undocumented patent titles or numbers.',
      children: [
        _InfoPanel('5 Granted Patents', 'Five granted patents associated with embedded systems, IoT and smart metering innovation.', icon: Icons.verified_rounded),
        _InfoPanel('International Recognition · IIFME Kuwait', 'Recognition for “Upgrading of Traditional Meters into Smart Meters” at the International Invention Fair of the Middle East, Kuwait, 2018.', icon: Icons.emoji_events_rounded),
        _InfoPanel('Medical R&D Certification Status', 'Ventilator and oxygen concentrator systems received calibration and safety certification from Cairo University Medical Calibration and Safety Center. Egyptian Drug Authority licensing procedures remain in progress.', icon: Icons.medical_services_rounded),
      ],
    );
  }
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  Widget action(IconData icon, String title, String value, String url) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 11),
      child: FilledButton.tonal(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.panel,
          foregroundColor: AppColors.text,
          padding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17),
            side: BorderSide(color: AppColors.cyan.withValues(alpha: .18)),
          ),
        ),
        onPressed: () => openExternal(url),
        child: Row(children: [
          Icon(icon, color: AppColors.gold),
          const SizedBox(width: 13),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w900)),
            const SizedBox(height: 3),
            Text(value, style: const TextStyle(color: AppColors.muted, fontSize: 13)),
          ])),
          const Icon(Icons.open_in_new_rounded, color: AppColors.cyan, size: 18),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 28),
          children: [
            const _SectionLabel('CONTACT & COLLABORATION'),
            const SizedBox(height: 8),
            const Text('Connect & Collaborate',
                style: TextStyle(fontFamily: 'serif', color: AppColors.gold2, fontSize: 34, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            const Text('External actions are limited to genuine communication and professional links. Portfolio content remains inside the application.',
                style: TextStyle(color: AppColors.muted, height: 1.5)),
            const SizedBox(height: 18),
            action(Icons.mail_rounded, 'Email', 'Mohammed.elghanam@gmail.com', 'mailto:Mohammed.elghanam@gmail.com'),
            action(Icons.phone_rounded, 'Mobile', '+20 01147778583', 'tel:+201147778583'),
            action(Icons.link_rounded, 'LinkedIn', 'linkedin.com/in/mohammed-elghanam', 'https://www.linkedin.com/in/mohammed-elghanam'),
            action(Icons.public_rounded, 'Facebook', 'Mohamed Elghanam', 'https://web.facebook.com/mohamed.elghanam.40869/'),
            action(Icons.language_rounded, 'Universal Professional Hub', 'mohammed-elghanam-professional-hub.vercel.app', 'https://mohammed-elghanam-professional-hub.vercel.app/'),
          ],
        ),
      ),
    );
  }
}
