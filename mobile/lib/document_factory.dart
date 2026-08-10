import 'dart:convert';
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'portrait_data.dart';

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

const _navy = PdfColor.fromInt(0xFF071D2F);
const _navy2 = PdfColor.fromInt(0xFF03101D);
const _gold = PdfColor.fromInt(0xFFF2B642);
const _gold2 = PdfColor.fromInt(0xFFFFD775);
const _cyan = PdfColor.fromInt(0xFF20D9E9);
const _muted = PdfColor.fromInt(0xFFB7C5D0);
const _white = PdfColors.white;

pw.Widget _pageBackground(pw.Widget child) => pw.Container(
      color: _navy2,
      padding: const pw.EdgeInsets.all(28),
      child: child,
    );

pw.Widget _header(String label, String title, {pw.ImageProvider? portrait}) {
  return pw.Row(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Expanded(
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(label.toUpperCase(),
                style: pw.TextStyle(
                  color: _cyan,
                  fontSize: 9,
                  letterSpacing: 2.2,
                  fontWeight: pw.FontWeight.bold,
                )),
            pw.SizedBox(height: 7),
            pw.Text(title,
                style: pw.TextStyle(
                  color: _gold2,
                  fontSize: 29,
                  fontWeight: pw.FontWeight.bold,
                )),
            pw.SizedBox(height: 8),
            pw.Container(width: 90, height: 2, color: _gold),
          ],
        ),
      ),
      if (portrait != null) ...[
        pw.SizedBox(width: 18),
        pw.Container(
          width: 90,
          height: 112,
          decoration: pw.BoxDecoration(
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(12)),
            border: pw.Border.all(color: _gold, width: 1.2),
          ),
          child: pw.ClipRRect(
            horizontalRadius: 12,
            verticalRadius: 12,
            child: pw.Image(portrait, fit: pw.BoxFit.cover),
          ),
        ),
      ],
    ],
  );
}

pw.Widget _section(String title, String body, {String? kicker}) {
  return pw.Container(
    margin: const pw.EdgeInsets.only(bottom: 12),
    padding: const pw.EdgeInsets.all(14),
    decoration: pw.BoxDecoration(
      color: _navy,
      borderRadius: const pw.BorderRadius.all(pw.Radius.circular(12)),
      border: pw.Border.all(color: const PdfColor.fromInt(0xFF24506A), width: .7),
    ),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        if (kicker != null) ...[
          pw.Text(kicker.toUpperCase(),
              style: pw.TextStyle(
                color: _cyan,
                fontSize: 7.5,
                letterSpacing: 1.5,
                fontWeight: pw.FontWeight.bold,
              )),
          pw.SizedBox(height: 4),
        ],
        pw.Text(title,
            style: pw.TextStyle(
              color: _gold2,
              fontSize: 13.5,
              fontWeight: pw.FontWeight.bold,
            )),
        pw.SizedBox(height: 6),
        pw.Text(body,
            style: const pw.TextStyle(
              color: _muted,
              fontSize: 9.2,
              lineSpacing: 3,
            )),
      ],
    ),
  );
}

pw.Widget _metric(String value, String label) => pw.Expanded(
      child: pw.Container(
        padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 9),
        decoration: pw.BoxDecoration(
          color: _navy,
          borderRadius: const pw.BorderRadius.all(pw.Radius.circular(10)),
          border: pw.Border.all(color: const PdfColor.fromInt(0xFF24506A), width: .7),
        ),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(value,
                style: pw.TextStyle(
                  color: _gold2,
                  fontSize: 17,
                  fontWeight: pw.FontWeight.bold,
                )),
            pw.SizedBox(height: 2),
            pw.Text(label,
                style: const pw.TextStyle(color: _muted, fontSize: 7.5)),
          ],
        ),
      ),
    );

Future<Uint8List> buildExecutiveCvPdf() async {
  final pdf = pw.Document();
  final portrait = pw.MemoryImage(base64Decode(kPortraitJpegBase64));

  pdf.addPage(
    pw.MultiPage(
      pageTheme: const pw.PageTheme(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.zero,
        theme: pw.ThemeData.withFont(),
      ),
      build: (_) => [
        _pageBackground(
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _header('Executive CV', 'Mohammed Elghanam', portrait: portrait),
              pw.SizedBox(height: 14),
              pw.Text('R&D CTO | Solution Architect | Engineering Consultant',
                  style: pw.TextStyle(
                    color: _white,
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  )),
              pw.SizedBox(height: 5),
              pw.Text(
                'Embedded & IoT Product Development | Smart Metering | LPWAN | FPGA | Safety-Critical Systems',
                style: const pw.TextStyle(color: _muted, fontSize: 9),
              ),
              pw.SizedBox(height: 14),
              pw.Row(children: [
                _metric('25+', 'Years R&D Leadership'),
                pw.SizedBox(width: 8),
                _metric('5', 'Granted Patents'),
                pw.SizedBox(width: 8),
                _metric('Global', 'Egypt | GCC | Remote'),
              ]),
              pw.SizedBox(height: 14),
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
              _section(
                'Professional Experience',
                'Solution Architect — Sanabil Solutions, Apr 2026–Jun 2026\nR&D CTO — EOIP / DLECS Lab R&D, 2018–Oct 2025\nR&D / Embedded Systems Engineering Leader — EOIP, Aug 2000–Dec 2017\nTechnical Engineer / Reserve Officer — Feb 1998–Jul 2000\nTeaching & Research Assistant — Faculty of Engineering, Banha University, Sep 1998–Aug 1999.',
              ),
              _section(
                'Education & Training',
                'B.Sc. Automatic Control & Instrumentation Engineering — Faculty of Engineering, Banha University, 1992–1997 — Very Good with Honors.\nSelected training: Foundations of CENELEC — TÜV SÜD Rail GmbH (2015); PMP Exam Preparation Course (2013); VHDL Coding; PCB Design According to Digital Constraints.',
              ),
              _section(
                'Contact',
                'Cairo, Egypt | Mohammed.elghanam@gmail.com | +20 01147778583 | linkedin.com/in/mohammed-elghanam',
              ),
            ],
          ),
        ),
      ],
    ),
  );
  return pdf.save();
}

Future<Uint8List> buildExecutivePortfolioPdf() async {
  final pdf = pw.Document();
  final portrait = pw.MemoryImage(base64Decode(kPortraitJpegBase64));

  pdf.addPage(
    pw.MultiPage(
      pageTheme: const pw.PageTheme(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.zero,
      ),
      build: (_) => [
        _pageBackground(
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _header('Executive Portfolio', 'R&D Leadership Built Around Products', portrait: portrait),
              pw.SizedBox(height: 14),
              _section(
                'Leadership Positioning',
                'Senior R&D CTO, Solution Architect and Engineering Consultant focused on embedded systems, connected products, smart utilities, FPGA platforms, industrial automation and safety-critical engineering.',
                kicker: 'Positioning',
              ),
              _section(
                'Technology Strategy & Architecture',
                'System architecture, product definition, technology strategy, hardware/firmware integration, validation planning, technical due diligence and cross-functional R&D leadership.',
                kicker: 'Executive Value',
              ),
              _section(
                'Innovation & Intellectual Property',
                'Holder of 5 granted patents related to embedded systems, IoT and smart metering innovation. International recognition at IIFME Kuwait for “Upgrading of Traditional Meters into Smart Meters”.',
                kicker: 'Innovation',
              ),
              _section(
                'Selected Domains',
                'Smart Utilities & Smart Metering | Patented LPWAN IoT Platform | Advanced RTU / Embedded EMS | Power Grid Protection | Medical Device R&D | Mission-Critical Communication Platforms | Software-Defined Radio Hardware Review | Railway Level-Crossing Systems.',
                kicker: 'Engineering Portfolio',
              ),
              _section(
                'Medical Device R&D Status',
                'Ventilator and oxygen concentrator control systems received calibration and safety certification from Cairo University Medical Calibration and Safety Center. Egyptian Drug Authority licensing procedures are in progress.',
                kicker: 'Regulated Engineering',
              ),
              _section(
                'Consulting & Collaboration',
                'Open to senior technical leadership, solution architecture, engineering consulting, technical advisory, embedded/IoT product development, R&D strategy and technology collaboration across Egypt, GCC and remote global markets.',
                kicker: 'Global Focus',
              ),
            ],
          ),
        ),
      ],
    ),
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
    pw.MultiPage(
      pageTheme: const pw.PageTheme(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.zero,
      ),
      build: (_) => [
        _pageBackground(
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _header('Global Project Portfolio', 'Selected Engineering Case Studies'),
              pw.SizedBox(height: 8),
              pw.Text(
                'Embedded Systems | Smart Utilities | LPWAN IoT | FPGA | RTU | Power Protection | Medical Control Systems | Safety-Critical Platforms',
                style: const pw.TextStyle(color: _muted, fontSize: 9),
              ),
              pw.SizedBox(height: 14),
              for (var i = 0; i < projects.length; i++)
                _section(
                  '${(i + 1).toString().padLeft(2, '0')} · ${projects[i].$1}',
                  projects[i].$2,
                  kicker: 'Case Study',
                ),
            ],
          ),
        ),
      ],
    ),
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
