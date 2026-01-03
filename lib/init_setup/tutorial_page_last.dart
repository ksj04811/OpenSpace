import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../map_search_page.dart';

class TutorialPageLast extends StatelessWidget {
  const TutorialPageLast({super.key});

  Future<void> _finishTutorial(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstLaunch', false); // ✅ 최초 실행 종료

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MapSearchPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('튜토리얼 마지막')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _finishTutorial(context),
          child: const Text('튜토리얼 완료'),
        ),
      ),
    );
  }
}
