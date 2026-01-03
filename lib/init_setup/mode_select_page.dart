import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'tutorial_page.dart'; // 🔥 새로 만들 튜토리얼 페이지

class ModeSelectPage extends StatelessWidget {
  const ModeSelectPage({super.key});

  /// 최초 실행 여부 저장
  Future<void> _saveFirstRunComplete(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstRun', false);

    // 튜토리얼 페이지로 이동
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const TutorialPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  '도움 모드를 선택하세요',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),

              /// 시각장애인 모드 (활성)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(260, 70),
                    textStyle: const TextStyle(fontSize: 22),
                  ),
                  onPressed: () {
                    _saveFirstRunComplete(context);
                  },
                  child: const Text('시각장애인 모드'),
                ),
              ),

              /// 추후 확장용 (비활성)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(260, 60),
                  ),
                  child: const Text('휠체어 이용자 모드 (추후 지원)'),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(260, 60),
                  ),
                  child: const Text('청각장애인 모드 (추후 지원)'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
