import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mode_select_page.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  /// 최초 실행 처리 완료
  Future<void> _completeFirstLaunch(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstLaunch', false);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const ModeSelectPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '처음 오셨군요 👋',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 24),

                const Text(
                  '도움이 필요한 방식을\n설정해 주세요.',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(240, 60),
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () => _completeFirstLaunch(context),
                  child: const Text('설정 시작'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
