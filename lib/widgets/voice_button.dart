import 'package:flutter/material.dart';

/// 노란색 마이크 버튼 컴포넌트
class VoiceButton extends StatelessWidget {
  final VoidCallback onPressed; // 버튼을 눌렀을 때 실행할 함수
  final bool isListening; // 현재 음성 인식 중인지 여부

  const VoiceButton({
    super.key,
    required this.onPressed,
    this.isListening = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48, // 버튼 크기
      height: 48,
      decoration: BoxDecoration(
        color: Colors.amber, // 노란색 배경
        borderRadius: BorderRadius.circular(8), // 둥근 모서리
      ),
      child: IconButton(
        icon: Icon(
          isListening ? Icons.mic : Icons.mic_none,
          color: const Color(0xFF001F3F), // 어두운 파란색
          size: 24,
        ),
        onPressed: onPressed,
      ),
    );
  }
}

