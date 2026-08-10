import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ExecutiveDocument {
  final String title;
  final String subtitle;
  final String fileName;
  final Future<Uint8List> Function() build;

  const ExecutiveDocument({
    required this.title,
    required this.subtitle,
    required this.fileName,
    required this.build,
  });
}

const _navy = PdfColor.fromInt(0xFF03101D);
const _panel = PdfColor.fromInt(0xFF071D2F);
const _gold = PdfColor.fromInt(0xFFF2B642);
const _gold2 = PdfColor.fromInt(0xFFFFD775);
const _cyan = PdfColor.fromInt(0xFF20D9E9);
const _muted = PdfColor.fromInt(0xFFB7C5D0);
const _white = PdfColors.white;

pw.TextStyle _titleStyle(double size) => pw.TextStyle(
      color: _gold2,
      fontSize: size,
      fontWeight: pw.FontWeight.bold,
    );

pw.Widget _header(String kicker, String title, String subtitle) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        kicker.toUpperCase(),
        style: pw.TextStyle(
          color: _cyan,
          fontSize: 8,
          letterSpacing: 2,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
      pw.SizedBox(height: 7),
      pw.Text(title, style: _titleStyle(25)),
      pw.SizedBox(height: 6),
      pw.Text(
        subtitle,
        style: const pw.TextStyle(color: _muted, fontSize: 9.2, lineSpacing: 2),
      ),
      pw.SizedBox(height: 9),
      pw.Container(width: 88, height: 2, color: _gold),
    ],
  );
}

pw.Widget _section(String title, String body, {String? label}) {
  return pw.Container(
    margin: const pw.EdgeInsets.only(bottom: 9),
    padding: const pw.EdgeInsets.all(11),
    decoration: pw.BoxDecoration(
      color: _panel,
      borderRadius: const pw.BorderRadius.all(pw.Radius.circular(9)),
      border: pw.Border.all(color: const PdfColor.fromInt(0xFF24506A), width: .6),
    ),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          pw.Text(
            label.toUpperCase(),
            style: pw.TextStyle(
              color: _cyan,
              fontSize: 6.5,
              letterSpacing: 1.4,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 3),
        ],
        pw.Text(
          title,
          style: pw.TextStyle(
            color: _gold2,
            fontSize: 11.5,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          body,
          style: const pw.TextStyle(
            color: _muted,
            fontSize: 8.2,
            lineSpacing: 2.4,
          ),
        ),
      ],
    ),
  );
}

pw.Widget _metric(String value, String label) {
  return pw.Expanded(
    child: pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 9, vertical: 8),
      decoration: pw.BoxDecoration(
        color: _panel,
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(9)),
        border: pw.Border.all(color: const PdfColor.fromInt(0xFF24506A), width: .6),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(value, style: _titleStyle(16)),
          pw.SizedBox(height: 2),
          pw.Text(label, style: const pw.TextStyle(color: _muted, fontSize: 7)),
        ],
      ),
    ),
  );
}

pw.Page _page(List<pw.Widget> children, {String? footer}) {
  return pw.Page(
    pageFormat: PdfPageFormat.a4,
    margin: pw.EdgeInsets.zero,
    build: (_) => pw.Container(
      width: double.infinity,
      height: double.infinity,
      color: _navy,
      padding: const pw.EdgeInsets.fromLTRB(27, 25, 27, 22),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          ...children,
          pw.Spacer(),
          pw.Container(height: .7, color: const PdfColor.fromInt(0xFF24506A)),
          pw.SizedBox(height: 6),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                'Mohammed Elghanam | R&D CTO | Embedded & IoT Product Development',
                style: const pw.TextStyle(color: _muted, fontSize: 6.6),
              ),
              if (footer != null)
                pw.Text(
                  footer,
                  style: pw.TextStyle(
                    color: _gold,
                    fontSize: 6.6,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
            ],
          ),
        ],
      ),
    ),
  );
}

Future<Uint8List> buildExecutiveCvPdf() async {
  final pdf = pw.Document();

  pdf.addPage(
    _page([
      _header(
        'Executive CV',
        'Mohammed Elghanam',
        'R&D CTO | Solution Architect | Engineering Consultant\nEmbedded & IoT Product Development | Smart Metering | LPWAN | FPGA | Safety-Critical Systems',
      ),
      pw.SizedBox(height: 13),
      pw.Row(children: [
        _metric('25+', 'Years R&D Leadership'),
        pw.SizedBox(width: 7),
        _metric('5', 'Granted Patents'),
        pw.SizedBox(width: 7),
        _metric('Global', 'Egypt | GCC | Remote'),
      ]),
      pw.SizedBox(height: 12),
      _section(
        'Executive Profile',
        'R&D CTO and Engineering Consultant with 25+ years of experience leading embedded systems, IoT product development, smart utilities, industrial automation, FPGA-based systems, hardware/firmware integration, and safety-critical technology development. Proven track record across utilities, industrial control, telecommunications, smart infrastructure, medical device R&D, and mission-critical communication platforms.',
      ),
      _section(
        'Strategic Value Proposition',
        'Transforms technical ideas into practical, scalable, and market-aligned engineering solutions by combining technology strategy, system architecture, embedded hardware, firmware, FPGA, validation, and cross-functional leadership.',
      ),
      _section(
        'Core Expertise',
        'Embedded Systems Architecture | IoT & LPWAN Product Development | Smart Metering & AMI | FPGA-Based System Design | Hardware/Firmware Integration | RTU & Industrial Automation | Power Grid Protection | Safety-Critical Systems | Medical Device R&D | Technology Strategy & R&D Leadership.',
      ),
    ], footer: 'PAGE 1 / 2'),
  );

  pdf.addPage(
    _page([
      _header('Executive CV', 'Career & Professional Record', 'Selected leadership, education and training highlights.'),
      pw.SizedBox(height: 13),
      _section('Solution Architect — Sanabil Solutions', 'R&D as a Service | Apr 2026–Jun 2026.', label: 'Experience'),
      _section('R&D CTO — EOIP / DLECS Lab R&D', '2018–Oct 2025 | Technical leadership across embedded systems, IoT product development, smart metering, industrial platforms and innovation programs.', label: 'Experience'),
      _section('R&D / Embedded Systems Engineering Leader — EOIP', 'Aug 2000–Dec 2017 | Embedded hardware, firmware, control, communication and product-development leadership.', label: 'Experience'),
      _section('Earlier Technical & Academic Roles', 'Technical Engineer / Reserve Officer — Feb 1998–Jul 2000. Teaching & Research Assistant — Faculty of Engineering, Banha University — Sep 1998–Aug 1999.', label: 'Experience'),
      _section('Education', 'B.Sc. Automatic Control & Instrumentation Engineering — Faculty of Engineering, Banha University — 1992–1997 — Very Good with Honors.'),
      _section('Selected Training', 'Foundations of CENELEC — TÜV SÜD Rail GmbH (2015) | PMP Exam Preparation Course (2013) | VHDL Coding | PCB Design According to Digital Constraints.'),
      _section('Contact', 'Cairo, Egypt | Mohammed.elghanam@gmail.com | +20 01147778583 | linkedin.com/in/mohammed-elghanam'),
    ], footer: 'PAGE 2 / 2'),
  );

  return pdf.save();
}

Future<Uint8List> buildExecutivePortfolioPdf() async {
  final pdf = pw.Document();

  pdf.addPage(
    _page([
      _header(
        'Executive R&D CTO Portfolio',
        'R&D Leadership Built Around Products',
        'Executive positioning, architecture leadership, innovation and product-development value.',
      ),
      pw.SizedBox(height: 13),
      _section('Leadership Positioning', 'Senior R&D CTO, Solution Architect and Engineering Consultant focused on embedded systems, connected products, smart utilities, FPGA platforms, industrial automation and safety-critical engineering.', label: 'Positioning'),
      _section('Technology Strategy & Architecture', 'System architecture, product definition, technology strategy, hardware/firmware integration, validation planning, technical due diligence and cross-functional R&D leadership.', label: 'Executive Value'),
      _section('Innovation & Intellectual Property', 'Holder of 5 granted patents related to embedded systems, IoT and smart metering innovation. International recognition at IIFME Kuwait for “Upgrading of Traditional Meters into Smart Meters”.', label: 'Innovation'),
      _section('Consulting Focus', 'Senior technical leadership | Solution architecture | Engineering consulting | Technical advisory | Embedded/IoT product development | R&D strategy | Technology collaboration.', label: 'Global Focus'),
    ], footer: 'PAGE 1 / 2'),
  );

  pdf.addPage(
    _page([
      _header('Executive R&D CTO Portfolio', 'Selected Engineering Domains', 'Representative technical domains and regulated-engineering status.'),
      pw.SizedBox(height: 13),
      _section('Smart Utilities & Smart Metering', 'Electricity, water and gas metering solutions covering embedded hardware, prepaid concepts, AMI, LPWAN, RS485, cellular, Wi-Fi, PLC communication, data platforms and billing integration.'),
      _section('LPWAN IoT & Industrial Platforms', 'Patented LPWAN platform spanning field devices, gateways, embedded software, cloud connectivity and mobile applications. RTU and embedded EMS development covering monitoring, control, validation and industrial protocols.'),
      _section('FPGA & Mission-Critical Platforms', 'FPGA-based implementation, high-speed processing, hardware review, MMI integration, software-defined radio hardware assessment and system validation.'),
      _section('Power Grid Protection', 'Digital overcurrent and earth-fault relay systems for 11kV networks, including testing, commissioning and Foxboro DCS integration.'),
      _section('Medical Device R&D Status', 'Ventilator and oxygen concentrator control systems received calibration and safety certification from Cairo University Medical Calibration and Safety Center. Egyptian Drug Authority licensing procedures are in progress.'),
    ], footer: 'PAGE 2 / 2'),
  );

  return pdf.save();
}

Future<Uint8List> buildProjectPortfolioPdf() async {
  final pdf = pw.Document();

  final projects = <(String, String)>[
    ('Smart Utilities & Smart Metering Solutions', 'Electricity, water and gas metering solutions covering embedded hardware, prepaid concepts, AMI, RS485, cellular, Wi-Fi, PLC communication, data platforms and billing integration.'),
    ('Patented LPWAN IoT Platform', 'End-to-end LPWAN platform covering field devices, gateways, embedded software, cloud connectivity and mobile applications.'),
    ('Advanced RTU / Embedded EMS Platforms', 'RTU, embedded EMS, industrial monitoring and control-system development with architecture definition, hardware/firmware integration, validation and industrial communication protocols.'),
    ('Power Grid Protection & Control Systems', 'Digital overcurrent and earth-fault relay systems for 11kV networks, including testing, commissioning and Foxboro DCS integration.'),
    ('Medical Device R&D Systems', 'Ventilator and oxygen concentrator control-system R&D with calibration and safety certification from Cairo University Medical Calibration and Safety Center; EDA licensing procedures remain in progress.'),
    ('Unified Azan System', 'Integrated embedded and communication architecture for coordinated, centralized Azan operation.'),
    ('Mission-Critical Communication Platforms', 'FPGA-based implementation, high-speed processing, hardware review, MMI integration and system validation.'),
    ('SDR Hardware Review', 'Engineering assessment of software-defined radio hardware, digital processing, high-speed design and hardware readiness.'),
    ('Railway Level-Crossing System', 'Safety-focused control and communication engineering for railway level-crossing applications.'),
  ];

  pdf.addPage(
    _page([
      _header('Global Project Portfolio', 'Selected Engineering Case Studies', 'Embedded Systems | Smart Utilities | LPWAN IoT | FPGA | RTU | Power Protection | Medical Control Systems | Safety-Critical Platforms'),
      pw.SizedBox(height: 12),
      for (var i = 0; i < 5; i++)
        _section('${(i + 1).toString().padLeft(2, '0')} · ${projects[i].$1}', projects[i].$2, label: 'Case Study'),
    ], footer: 'PAGE 1 / 2'),
  );

  pdf.addPage(
    _page([
      _header('Global Project Portfolio', 'Selected Engineering Case Studies', 'Continuation of the selected engineering portfolio.'),
      pw.SizedBox(height: 12),
      for (var i = 5; i < projects.length; i++)
        _section('${(i + 1).toString().padLeft(2, '0')} · ${projects[i].$1}', projects[i].$2, label: 'Case Study'),
    ], footer: 'PAGE 2 / 2'),
  );

  return pdf.save();
}

final executiveDocuments = <ExecutiveDocument>[
  ExecutiveDocument(
    title: 'Executive CV',
    subtitle: 'Career, executive positioning, expertise and contact',
    fileName: 'Mohammed_Elghanam_Executive_CV.pdf',
    build: buildExecutiveCvPdf,
  ),
  ExecutiveDocument(
    title: 'Executive R&D CTO Portfolio',
    subtitle: 'Leadership positioning, innovation and consulting value',
    fileName: 'Mohammed_Elghanam_Executive_Portfolio.pdf',
    build: buildExecutivePortfolioPdf,
  ),
  ExecutiveDocument(
    title: 'Global Project Portfolio',
    subtitle: 'Nine selected engineering case-study summaries',
    fileName: 'Mohammed_Elghanam_Global_Project_Portfolio.pdf',
    build: buildProjectPortfolioPdf,
  ),
];
