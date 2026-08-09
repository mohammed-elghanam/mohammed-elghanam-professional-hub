import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const ProfessionalHubApp());

class ProfessionalHubApp extends StatelessWidget {
  const ProfessionalHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    const navy = Color(0xFF03101D);
    const gold = Color(0xFFF2B642);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mohammed Elghanam | Professional Hub',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: navy,
        colorScheme: ColorScheme.fromSeed(seedColor: gold, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const gold = Color(0xFFF2B642);
  static const cyan = Color(0xFF20D9E9);
  static const panel = Color(0xFF071D2F);

  Future<void> open(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Widget card(IconData icon, String title, String subtitle, {VoidCallback? onTap}) {
    return Card(
      color: panel,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
        side: BorderSide(color: cyan.withValues(alpha: .24)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: gold.withValues(alpha: .8)),
              ),
              child: Icon(icon, color: gold),
            ),
            const SizedBox(width: 16),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white)),
              const SizedBox(height: 5),
              Text(subtitle, style: const TextStyle(color: Color(0xFFB7C5D0), height: 1.35)),
            ])),
            const Icon(Icons.chevron_right_rounded, color: cyan),
          ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(22, 22, 22, 10),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: gold, width: 1.6)),
                      alignment: Alignment.center,
                      child: const Text('ME', style: TextStyle(fontFamily: 'serif', color: Color(0xFFFFD775), fontSize: 24, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('Mohammed Elghanam', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFFFFD775))),
                      Text('Professional Hub · Mobile Executive Edition', style: TextStyle(fontSize: 12, color: Color(0xFF9FB2C1))),
                    ])),
                  ]),
                  const SizedBox(height: 34),
                  const Text('R&D CTO', style: TextStyle(color: cyan, letterSpacing: 2.0, fontSize: 12, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  const Text('Embedded & IoT\nProduct Development', style: TextStyle(fontFamily: 'serif', fontSize: 42, height: 1.0, color: Color(0xFFFFD775), fontWeight: FontWeight.w700)),
                  const SizedBox(height: 15),
                  const Text('Smart Metering · LPWAN · FPGA · Industrial Automation · Safety-Critical Systems', style: TextStyle(fontSize: 16, color: Colors.white, height: 1.5)),
                  const SizedBox(height: 24),
                  Wrap(spacing: 10, runSpacing: 10, children: const [
                    _Pill('25+ Years Experience'),
                    _Pill('5 Granted Patents'),
                    _Pill('9 Case Studies'),
                  ]),
                ]),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 30),
              sliver: SliverList.list(children: [
                card(Icons.dashboard_customize_rounded, 'Executive Portfolio', 'Open the online executive hub and document center', onTap: () => open('https://mohammed-elghanam-professional-hub.vercel.app/')),
                card(Icons.engineering_rounded, 'Engineering Projects', 'Smart utilities, LPWAN, RTU, power protection, medical R&D and more', onTap: () => open('https://mohammed-elghanam-professional-hub.vercel.app/#editions')),
                card(Icons.description_rounded, 'Executive CV & Portfolios', 'Access CV, project portfolio and executive positioning materials', onTap: () => open('https://mohammed-elghanam-professional-hub.vercel.app/')),
                card(Icons.workspace_premium_rounded, 'Recognition & Patents', 'Granted patents, international recognition and certifications', onTap: () => open('https://mohammed-elghanam-professional-hub.vercel.app/')),
                card(Icons.link_rounded, 'LinkedIn', 'Connect with Mohammed Elghanam professionally', onTap: () => open('https://www.linkedin.com/in/mohammed-elghanam')),
                card(Icons.mail_rounded, 'Contact', 'Email for consulting, partnerships and technology collaboration', onTap: () => open('mailto:Mohammed.elghanam@gmail.com')),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String text;
  const _Pill(this.text);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
    decoration: BoxDecoration(
      color: const Color(0xFF08253A),
      borderRadius: BorderRadius.circular(999),
      border: Border.all(color: const Color(0xFF20D9E9).withValues(alpha: .35)),
    ),
    child: Text(text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFFEAF4FA))),
  );
}
