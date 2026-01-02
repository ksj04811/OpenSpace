import 'package:flutter/material.dart';
import 'tutorial_page_last.dart'; // 마지막 페이지 import

class TutorialPage extends StatelessWidget {
  const TutorialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('앱 사용 안내'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '이 앱은 음성과 진동으로 길 안내를 제공합니다.\n'
                '화면을 두 번 탭하면 버튼이 눌립니다.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // 마지막 튜토리얼 페이지로 이동
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TutorialPageLast(),
                    ),
                  );
                },
                child: const Text('다음'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
