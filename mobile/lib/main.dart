import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:printing/printing.dart';
import 'package:url_launcher/url_launcher.dart';

import 'document_factory.dart';
import 'portrait_data.dart';

void main() => runApp(const ProfessionalHubApp());

class C {
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
        scaffoldBackgroundColor: C.navy,
        colorScheme: ColorScheme.fromSeed(seedColor: C.gold, brightness: Brightness.dark),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(backgroundColor: C.navy, foregroundColor: C.text),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: C.navy2,
          indicatorColor: C.gold.withValues(alpha: .2),
          labelTextStyle: const WidgetStatePropertyAll(TextStyle(fontWeight: FontWeight.w800, fontSize: 11)),
        ),
      ),
      home: const ExecutiveShell(),
    );
  }
}

Future<void> openExternal(String url) async {
  await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
}

void push(BuildContext context, Widget page) {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
}

class ExecutiveShell extends StatefulWidget {
  const ExecutiveShell({super.key});

  @override
  State<ExecutiveShell> createState() => _ExecutiveShellState();
}

class _ExecutiveShellState extends State<ExecutiveShell> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomePage(),
      const ProjectsPage(),
      const DocumentLibraryPage(),
      const ContactPage(),
    ];
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (v) => setState(() => index = v),
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

  Uint8List? _portrait() {
    try {
      return base64Decode(kPortraitJpegBase64);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final portrait = _portrait();
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF0A2940), C.navy],
                ),
              ),
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 22),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const _BrandRow(),
                const SizedBox(height: 22),
                _Hero(portrait: portrait),
                const SizedBox(height: 16),
                const Row(children: [
                  Expanded(child: _Metric('25+', 'Years R&D')),
                  SizedBox(width: 8),
                  Expanded(child: _Metric('5', 'Patents')),
                  SizedBox(width: 8),
                  Expanded(child: _Metric('9', 'Case Studies')),
                ]),
              ]),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
            sliver: SliverList.list(children: [
              const _Kicker('EXECUTIVE DASHBOARD'),
              const SizedBox(height: 10),
              _Action(Icons.dashboard_customize_rounded, 'Executive Portfolio', 'Leadership positioning, innovation and consulting value', () => push(context, const ExecutivePage())),
              _Action(Icons.description_rounded, 'Career & Executive CV', 'Experience, education, certifications and professional record', () => push(context, const CareerPage())),
              _Action(Icons.memory_rounded, 'Skills & Expertise', 'Embedded, IoT, FPGA, industrial, power and safety-critical capabilities', () => push(context, const SkillsPage())),
              _Action(Icons.workspace_premium_rounded, 'Recognition & Patents', 'Granted patents, IIFME recognition and medical R&D status', () => push(context, const RecognitionPage())),
              _Action(Icons.picture_as_pdf_rounded, 'Executive Document Center', 'Open, zoom, scroll, share or save PDFs inside the app', () => push(context, const DocumentLibraryPage(showBack: true))),
            ]),
          ),
        ],
      ),
    );
  }
}

class _BrandRow extends StatelessWidget {
  const _BrandRow();
  @override
  Widget build(BuildContext context) => const Row(children: [
        _Seal(48, 20),
        SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Mohammed Elghanam', style: TextStyle(color: C.gold2, fontWeight: FontWeight.w900, fontSize: 18)),
          Text('R&D CTO · Flutter Executive Edition', style: TextStyle(color: C.muted, fontSize: 11)),
        ])),
        _Version(),
      ]);
}

class _Version extends StatelessWidget {
  const _Version();
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
        decoration: BoxDecoration(color: C.panel2, borderRadius: BorderRadius.circular(99), border: Border.all(color: C.cyan.withValues(alpha: .35))),
        child: const Text('V3.1', style: TextStyle(color: C.cyan, fontSize: 10, fontWeight: FontWeight.w900)),
      );
}

class _Seal extends StatelessWidget {
  final double size;
  final double fontSize;
  const _Seal(this.size, this.fontSize);
  @override
  Widget build(BuildContext context) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: C.gold, width: 1.5)),
        alignment: Alignment.center,
        child: Text('ME', style: TextStyle(fontFamily: 'serif', color: C.gold2, fontWeight: FontWeight.bold, fontSize: fontSize)),
      );
}

class _Hero extends StatelessWidget {
  final Uint8List? portrait;
  const _Hero({required this.portrait});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: C.panel,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: C.gold.withValues(alpha: .52)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: .3), blurRadius: 22, offset: const Offset(0, 9))],
      ),
      child: Column(children: [
        SizedBox(
          width: double.infinity,
          height: 265,
          child: portrait == null
              ? Container(color: C.panel2, child: const Center(child: _Seal(120, 44)))
              : Image.memory(
                  portrait!,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  filterQuality: FilterQuality.high,
                  errorBuilder: (_, __, ___) => Container(color: C.panel2, child: const Center(child: _Seal(120, 44))),
                ),
        ),
        const Padding(
          padding: EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('EXECUTIVE PROFESSIONAL PROFILE', style: TextStyle(color: C.cyan, letterSpacing: 1.7, fontSize: 10, fontWeight: FontWeight.w900)),
            SizedBox(height: 7),
            Text('Mohammed Elghanam', style: TextStyle(fontFamily: 'serif', color: C.gold2, fontSize: 34, fontWeight: FontWeight.w700)),
            SizedBox(height: 9),
            Text('R&D CTO · Solution Architect · Engineering Consultant', style: TextStyle(color: C.text, fontSize: 14, height: 1.4, fontWeight: FontWeight.w700)),
            SizedBox(height: 7),
            Text('Embedded & IoT Product Development · Smart Metering · LPWAN · FPGA · Industrial Automation · Safety-Critical Systems', style: TextStyle(color: C.muted, fontSize: 13, height: 1.45)),
          ]),
        ),
      ]),
    );
  }
}

class _Metric extends StatelessWidget {
  final String value;
  final String label;
  const _Metric(this.value, this.label);
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 13),
        decoration: BoxDecoration(color: C.panel, borderRadius: BorderRadius.circular(16), border: Border.all(color: C.cyan.withValues(alpha: .18))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(value, style: const TextStyle(fontFamily: 'serif', color: C.gold2, fontSize: 23, fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(color: C.muted, fontSize: 9.5, fontWeight: FontWeight.w700)),
        ]),
      );
}

class _Kicker extends StatelessWidget {
  final String text;
  const _Kicker(this.text);
  @override
  Widget build(BuildContext context) => Text(text, style: const TextStyle(color: C.cyan, letterSpacing: 1.8, fontSize: 11, fontWeight: FontWeight.w900));
}

class _Action extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const _Action(this.icon, this.title, this.subtitle, this.onTap);
  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.only(bottom: 12),
        color: C.panel,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: C.cyan.withValues(alpha: .18))),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(17),
            child: Row(children: [
              Container(width: 52, height: 52, decoration: BoxDecoration(color: C.navy2, borderRadius: BorderRadius.circular(15), border: Border.all(color: C.gold.withValues(alpha: .72))), child: Icon(icon, color: C.gold, size: 27)),
              const SizedBox(width: 14),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: const TextStyle(color: C.text, fontSize: 16.5, fontWeight: FontWeight.w900)),
                const SizedBox(height: 5),
                Text(subtitle, style: const TextStyle(color: C.muted, fontSize: 12.5, height: 1.38)),
              ])),
              const Icon(Icons.chevron_right_rounded, color: C.cyan),
            ]),
          ),
        ),
      );
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
            const _Kicker('IN-APP PDF LIBRARY'),
            const SizedBox(height: 8),
            const Text('Executive Document Center', style: TextStyle(fontFamily: 'serif', color: C.gold2, fontSize: 34, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            const Text('Open each PDF inside the app. Use pinch-to-zoom and scrolling, then use Share / Save from the document screen.', style: TextStyle(color: C.muted, height: 1.5)),
            const SizedBox(height: 20),
            for (final d in executiveDocuments) _DocumentCard(d),
          ],
        ),
      ),
    );
  }
}

class _DocumentCard extends StatelessWidget {
  final ExecutiveDocument d;
  const _DocumentCard(this.d);
  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.only(bottom: 14),
        color: C.panel,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: C.gold.withValues(alpha: .36))),
        child: InkWell(
          onTap: () => push(context, PdfPage(document: d)),
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(children: [
              Container(width: 58, height: 70, decoration: BoxDecoration(color: C.navy2, borderRadius: BorderRadius.circular(13), border: Border.all(color: C.gold.withValues(alpha: .7))), child: const Icon(Icons.picture_as_pdf_rounded, color: C.gold, size: 30)),
              const SizedBox(width: 15),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(d.title, style: const TextStyle(color: C.text, fontSize: 17, fontWeight: FontWeight.w900)),
                const SizedBox(height: 6),
                Text(d.subtitle, style: const TextStyle(color: C.muted, height: 1.4)),
                const SizedBox(height: 9),
                const Text('Open · Zoom · Share / Save', style: TextStyle(color: C.cyan, fontSize: 12, fontWeight: FontWeight.w800)),
              ])),
            ]),
          ),
        ),
      );
}

class PdfPage extends StatefulWidget {
  final ExecutiveDocument document;
  const PdfPage({super.key, required this.document});

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  late final Future<Uint8List> future = widget.document.build();

  Future<void> _share(Uint8List bytes) async {
    await Printing.sharePdf(bytes: bytes, filename: widget.document.fileName);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: future,
      builder: (context, snap) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.document.title, overflow: TextOverflow.ellipsis),
            actions: [
              if (snap.hasData)
                IconButton(
                  tooltip: 'Share / Save PDF',
                  onPressed: () => _share(snap.data!),
                  icon: const Icon(Icons.ios_share_rounded, color: C.gold),
                ),
            ],
          ),
          body: _pdfBody(snap),
        );
      },
    );
  }

  Widget _pdfBody(AsyncSnapshot<Uint8List> snap) {
    if (snap.hasError) {
      return Center(child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.error_outline_rounded, color: C.gold, size: 44),
          const SizedBox(height: 14),
          const Text('Unable to open this PDF', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
          const SizedBox(height: 8),
          Text('${snap.error}', textAlign: TextAlign.center, style: const TextStyle(color: C.muted)),
        ]),
      ));
    }
    if (!snap.hasData) return const Center(child: CircularProgressIndicator(color: C.gold));
    return Container(
      color: C.navy,
      child: PdfViewer.data(
        snap.data!,
        sourceName: widget.document.fileName,
        params: const PdfViewerParams(backgroundColor: C.navy, margin: 6),
      ),
    );
  }
}

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});
  static const p = [
    ('Smart Utilities & Smart Metering Solutions', 'Electricity, water and gas metering solutions covering embedded hardware, prepaid concepts, AMI, RS485, cellular, Wi-Fi, PLC communication, data platforms and billing integration.'),
    ('Patented LPWAN IoT Platform', 'End-to-end LPWAN platform covering field devices, gateways, embedded software, cloud connectivity and mobile applications.'),
    ('Advanced RTU / Embedded EMS Platforms', 'RTU, embedded EMS, industrial monitoring and control-system development with architecture definition, hardware/firmware integration, validation and industrial communication protocols.'),
    ('Power Grid Protection & Control Systems', 'Digital overcurrent and earth-fault relay systems for 11kV networks, testing, commissioning and Foxboro DCS integration.'),
    ('Medical Device R&D Systems', 'Ventilator and oxygen concentrator control-system R&D. Calibration and safety certification completed through Cairo University Medical Calibration and Safety Center; Egyptian Drug Authority licensing procedures are in progress.'),
    ('Unified Azan System', 'Integrated embedded and communication architecture for coordinated, centralized Azan operation.'),
    ('Mission-Critical Communication Platforms', 'FPGA-based implementation, high-speed processing, hardware review, MMI integration and system validation.'),
    ('SDR Hardware Review', 'Engineering assessment of software-defined radio hardware, digital processing and high-speed design considerations.'),
    ('Railway Level-Crossing System', 'Safety-focused control and communication engineering for railway level-crossing applications.'),
  ];
  @override
  Widget build(BuildContext context) => _ListScreen(
        kicker: 'ENGINEERING PROJECTS',
        title: 'Selected Case Studies',
        intro: 'Nine representative engineering programs spanning smart utilities, IoT, industrial automation, power, medical R&D and safety-critical systems.',
        children: [for (var i = 0; i < p.length; i++) _Info('${(i + 1).toString().padLeft(2, '0')} · ${p[i].$1}', p[i].$2, Icons.engineering_rounded)],
      );
}

class ExecutivePage extends StatelessWidget {
  const ExecutivePage({super.key});
  @override
  Widget build(BuildContext context) => const _ListScreen(
        back: true,
        kicker: 'EXECUTIVE PORTFOLIO',
        title: 'R&D Leadership Built Around Products',
        intro: 'R&D CTO, Solution Architect and Engineering Consultant transforming complex embedded and connected-system ideas into practical, scalable engineering solutions.',
        children: [
          _Info('Leadership Positioning', '25+ years across R&D leadership, embedded systems, IoT product development, smart utilities, FPGA-based systems, industrial automation and safety-critical technology development.', Icons.leaderboard_rounded),
          _Info('Technology Strategy & Architecture', 'System architecture, technology strategy, hardware/firmware integration, product development, validation and cross-functional technical leadership.', Icons.account_tree_rounded),
          _Info('Innovation & IP', 'Holder of 5 granted patents related to embedded systems, IoT and smart metering innovation.', Icons.lightbulb_rounded),
          _Info('Consulting Focus', 'Senior technical leadership, solution architecture, engineering consulting, technical advisory, R&D strategy and technology collaboration across Egypt, GCC and remote global markets.', Icons.public_rounded),
        ],
      );
}

class CareerPage extends StatelessWidget {
  const CareerPage({super.key});
  @override
  Widget build(BuildContext context) => const _ListScreen(
        back: true,
        kicker: 'CAREER & EXECUTIVE CV',
        title: 'Professional Record',
        intro: 'Executive summary of experience, education and selected professional training.',
        children: [
          _Info('Solution Architect · Sanabil Solutions', 'R&D as a Service · Apr 2026–Jun 2026.', Icons.architecture_rounded),
          _Info('R&D CTO · EOIP / DLECS Lab R&D', '2018–Oct 2025 · R&D leadership across embedded systems, IoT, smart metering, industrial platforms and innovation programs.', Icons.business_center_rounded),
          _Info('R&D / Embedded Systems Engineering Leader · EOIP', 'Aug 2000–Dec 2017 · Embedded hardware, firmware, control, communication and product-development leadership.', Icons.memory_rounded),
          _Info('Education', 'B.Sc. Automatic Control & Instrumentation Engineering · Faculty of Engineering, Banha University · 1992–1997 · Very Good with Honors.', Icons.school_rounded),
          _Info('Selected Training', 'Foundations of CENELEC · TÜV SÜD Rail GmbH (2015) · PMP Exam Preparation Course (2013) · VHDL Coding · PCB Design According to Digital Constraints.', Icons.workspace_premium_rounded),
        ],
      );
}

class SkillsPage extends StatelessWidget {
  const SkillsPage({super.key});
  @override
  Widget build(BuildContext context) => const _ListScreen(
        back: true,
        kicker: 'SKILLS & EXPERTISE',
        title: 'Engineering Capability Map',
        intro: 'Core technical and leadership domains represented in the professional skill index.',
        children: [
          _Info('R&D Leadership & Product Strategy', 'R&D Leadership · R&D Management · Technology Strategy · Product Development · Solution Architecture · Engineering Consulting · Technical Advisory · Project Management.', Icons.stars_rounded),
          _Info('Embedded & Hardware', 'Embedded Systems · Hardware Design · Firmware Development · Hardware/Firmware Integration · PCB Design · High-Speed Digital Design · Signal Integrity · EMC Considerations.', Icons.memory_rounded),
          _Info('IoT, Smart Metering & Connectivity', 'IoT Product Development · Smart Metering · Smart Utilities · AMI · Prepaid Metering · LPWAN · RS485 · PLC · Cellular IoT · Wi-Fi Integration.', Icons.sensors_rounded),
          _Info('FPGA & Digital Systems', 'FPGA · VHDL · Digital Design · FPGA-Based Systems · Signal Processing · Software-Defined Radio.', Icons.developer_board_rounded),
          _Info('Industrial, Control & Power', 'Industrial Automation · RTU · Embedded EMS · Control Systems · Instrumentation · Power Grid Protection · Digital Relay Systems · Overcurrent & Earth-Fault Protection.', Icons.electrical_services_rounded),
        ],
      );
}

class RecognitionPage extends StatelessWidget {
  const RecognitionPage({super.key});
  @override
  Widget build(BuildContext context) => const _ListScreen(
        back: true,
        kicker: 'RECOGNITION & IP',
        title: 'Innovation, Patents & Recognition',
        intro: 'Professional recognition and intellectual-property highlights.',
        children: [
          _Info('5 Granted Patents', 'Five granted patents associated with embedded systems, IoT and smart metering innovation.', Icons.verified_rounded),
          _Info('International Recognition · IIFME Kuwait', 'Recognition for “Upgrading of Traditional Meters into Smart Meters” at the International Invention Fair of the Middle East, Kuwait, 2018.', Icons.emoji_events_rounded),
          _Info('Medical R&D Certification Status', 'Ventilator and oxygen concentrator systems received calibration and safety certification from Cairo University Medical Calibration and Safety Center. Egyptian Drug Authority licensing procedures remain in progress.', Icons.medical_services_rounded),
        ],
      );
}

class _ListScreen extends StatelessWidget {
  final String kicker;
  final String title;
  final String intro;
  final List<Widget> children;
  final bool back;
  const _ListScreen({required this.kicker, required this.title, required this.intro, required this.children, this.back = false});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: back ? AppBar(title: const Text('Mohammed Elghanam')) : null,
        body: SafeArea(child: ListView(padding: const EdgeInsets.fromLTRB(16, 20, 16, 30), children: [
          _Kicker(kicker),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontFamily: 'serif', color: C.gold2, fontSize: 34, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text(intro, style: const TextStyle(color: C.muted, height: 1.5)),
          const SizedBox(height: 18),
          ...children,
        ])),
      );
}

class _Info extends StatelessWidget {
  final String title;
  final String body;
  final IconData icon;
  const _Info(this.title, this.body, this.icon);
  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(color: C.panel, borderRadius: BorderRadius.circular(18), border: Border.all(color: C.cyan.withValues(alpha: .18))),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(icon, color: C.gold, size: 25),
          const SizedBox(width: 13),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(color: C.text, fontSize: 16, fontWeight: FontWeight.w900)),
            const SizedBox(height: 6),
            Text(body, style: const TextStyle(color: C.muted, height: 1.48)),
          ])),
        ]),
      );
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});
  @override
  Widget build(BuildContext context) => _ListScreen(
        kicker: 'CONTACT & LINKS',
        title: 'Connect & Collaborate',
        intro: 'External actions are limited to genuine communication and social links.',
        children: [
          _Contact(Icons.mail_rounded, 'Email', 'Mohammed.elghanam@gmail.com', () => openExternal('mailto:Mohammed.elghanam@gmail.com')),
          _Contact(Icons.phone_rounded, 'Mobile', '+20 01147778583', () => openExternal('tel:+201147778583')),
          _Contact(Icons.link_rounded, 'LinkedIn', 'linkedin.com/in/mohammed-elghanam', () => openExternal('https://www.linkedin.com/in/mohammed-elghanam')),
          _Contact(Icons.public_rounded, 'Universal Hub', 'mohammed-elghanam-professional-hub.vercel.app', () => openExternal('https://mohammed-elghanam-professional-hub.vercel.app/')),
        ],
      );
}

class _Contact extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback tap;
  const _Contact(this.icon, this.title, this.value, this.tap);
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: FilledButton.tonal(
          onPressed: tap,
          style: FilledButton.styleFrom(backgroundColor: C.panel2, foregroundColor: C.text, padding: const EdgeInsets.all(16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
          child: Row(children: [
            Icon(icon, color: C.gold),
            const SizedBox(width: 14),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w900)),
              const SizedBox(height: 3),
              Text(value, style: const TextStyle(color: C.muted)),
            ])),
            const Icon(Icons.open_in_new_rounded, color: C.cyan, size: 18),
          ]),
        ),
      );
}
