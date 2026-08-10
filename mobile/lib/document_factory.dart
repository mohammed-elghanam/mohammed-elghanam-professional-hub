import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;

class ExecutiveDocument {
  final String title;
  final String subtitle;
  final String fileName;
  final String assetPath;

  const ExecutiveDocument({
    required this.title,
    required this.subtitle,
    required this.fileName,
    required this.assetPath,
  });

  Future<Uint8List> build() async {
    final data = await rootBundle.load(assetPath);
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }
}

final executiveDocuments = <ExecutiveDocument>[
  const ExecutiveDocument(
    title: 'Executive CV',
    subtitle: 'Full original Executive CV · complete uploaded PDF',
    fileName: 'Mohammed_Elghanam_Executive_CV_Super_Premium_Updated.pdf',
    assetPath: 'Mohammed_Elghanam_Executive_CV_Super_Premium_Updated.pdf',
  ),
  const ExecutiveDocument(
    title: 'Executive R&D CTO Portfolio',
    subtitle: 'Full original Executive Engineering Portfolio · complete uploaded PDF',
    fileName: 'Mohammed_Elghanam_Executive_Engineering_Portfolio_FINAL.pdf',
    assetPath: 'Mohammed_Elghanam_Executive_Engineering_Portfolio_FINAL.pdf',
  ),
  const ExecutiveDocument(
    title: 'Global Project Portfolio',
    subtitle: 'Full original Global Project Portfolio · complete multi-page PDF',
    fileName: 'Mohammed_Elghanam_Global_Project_Portfolio.pdf',
    assetPath: 'Mohammed_Elghanam_Global_Project_Portfolio.pdf',
  ),
];
