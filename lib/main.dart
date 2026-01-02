import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firstpage.dart';
import 'map_search_page.dart';

void main() {
  runApp(const MyApp());
}

/// 최초 실행 여부 확인
Future<bool> isFirstLaunch() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isFirstLaunch') ?? true;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AppEntry(),
    );
  }
}

/// 앱 시작 시 진입 위젯 (분기 담당)
class AppEntry extends StatelessWidget {
  const AppEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isFirstLaunch(),
      builder: (context, snapshot) {
        // 아직 로딩 중
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // 최초 실행
        if (snapshot.data == true) {
          return const FirstPage();
        }

        // 두 번째 실행부터
        return const MapSearchPage();
      },
    );
  }
}
