import 'package:flutter/material.dart';
import 'map_search_page.dart';
import 'mode_select_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ModeSelectPage(),
    );
  }
}
