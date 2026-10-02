import 'package:flutter/material.dart';

import 'assets_media.dart';
import 'detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Assets & Media',

      initialRoute: '/',

      routes: {
        '/': (context) => const AssetsMediaPage(),
        '/detail': (context) => const DetailPage(),
      },
    );
  }
}
