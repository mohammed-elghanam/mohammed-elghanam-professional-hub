import 'package:flutter/material.dart';

import 'app_v4.dart';

const _privacyPolicyUrl =
    'https://mohammed-elghanam-professional-hub.vercel.app/privacy-policy.html';

void main() => runApp(const GooglePlayReadyApp());

class GooglePlayReadyApp extends StatelessWidget {
  const GooglePlayReadyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mohammed Elghanam | Executive Hub',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: C.navy,
        colorScheme: ColorScheme.fromSeed(
          seedColor: C.gold,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: C.navy,
          foregroundColor: C.text,
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: C.navy2,
          indicatorColor: C.gold.withValues(alpha: .2),
          labelTextStyle: const WidgetStatePropertyAll(
            TextStyle(fontWeight: FontWeight.w800, fontSize: 11),
          ),
        ),
      ),
      home: const GooglePlayReadyShell(),
    );
  }
}

class GooglePlayReadyShell extends StatefulWidget {
  const GooglePlayReadyShell({super.key});

  @override
  State<GooglePlayReadyShell> createState() => _GooglePlayReadyShellState();
}

class _GooglePlayReadyShellState extends State<GooglePlayReadyShell> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomePage(),
      const ProjectsPage(),
      const DocumentLibraryPage(),
      const GooglePlayContactPage(),
    ];

    return Scaffold(
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (v) => setState(() => index = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_rounded), label: 'Home'),
          NavigationDestination(
            icon: Icon(Icons.engineering_rounded),
            label: 'Projects',
          ),
          NavigationDestination(
            icon: Icon(Icons.picture_as_pdf_rounded),
            label: 'Documents',
          ),
          NavigationDestination(
            icon: Icon(Icons.contact_mail_rounded),
            label: 'Contact',
          ),
        ],
      ),
    );
  }
}

class GooglePlayContactPage extends StatelessWidget {
  const GooglePlayContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 30),
          children: [
            const Text(
              'CONTACT & LINKS',
              style: TextStyle(
                color: C.cyan,
                letterSpacing: 1.8,
                fontSize: 11,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Connect & Collaborate',
              style: TextStyle(
                fontFamily: 'serif',
                color: C.gold2,
                fontSize: 34,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'External actions are limited to genuine communication, professional links and the app privacy policy.',
              style: TextStyle(color: C.muted, height: 1.5),
            ),
            const SizedBox(height: 18),
            _ContactAction(
              Icons.mail_rounded,
              'Email',
              'Mohammed.elghanam@gmail.com',
              () => openExternal('mailto:Mohammed.elghanam@gmail.com'),
            ),
            _ContactAction(
              Icons.phone_rounded,
              'Mobile',
              '+20 01147778583',
              () => openExternal('tel:+201147778583'),
            ),
            _ContactAction(
              Icons.link_rounded,
              'LinkedIn',
              'linkedin.com/in/mohammed-elghanam',
              () => openExternal(
                'https://www.linkedin.com/in/mohammed-elghanam',
              ),
            ),
            _ContactAction(
              Icons.public_rounded,
              'Universal Hub',
              'mohammed-elghanam-professional-hub.vercel.app',
              () => openExternal(
                'https://mohammed-elghanam-professional-hub.vercel.app/',
              ),
            ),
            _ContactAction(
              Icons.photo_library_rounded,
              'Recognition Gallery',
              'Awards, events and certifications',
              () => push(context, const RecognitionGalleryPage()),
            ),
            _ContactAction(
              Icons.privacy_tip_rounded,
              'Privacy Policy',
              'Google Play privacy & data-handling information',
              () => openExternal(_privacyPolicyUrl),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactAction extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback onTap;

  const _ContactAction(this.icon, this.title, this.value, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: FilledButton.tonal(
        onPressed: onTap,
        style: FilledButton.styleFrom(
          backgroundColor: C.panel2,
          foregroundColor: C.text,
          padding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: C.gold),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 3),
                  Text(value, style: const TextStyle(color: C.muted)),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: C.cyan,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
