import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

/// 노란색 마이크 버튼 컴포넌트 (음성 인식 로직 포함)
class VoiceButton extends StatefulWidget {
  final Function(String recognizedWords)? onResult; // 음성 인식 결과 전달
  final String localeId;

  const VoiceButton({
    super.key,
    this.onResult,
    this.localeId = "ko_KR",
  });

  @override
  State<VoiceButton> createState() => _VoiceButtonState();
}

class _VoiceButtonState extends State<VoiceButton> {
  final SpeechToText _speech = SpeechToText();
  bool _isListening = false;

  void _onPressed() async {
    if (_isListening) {
      _speech.stop();
      setState(() => _isListening = false);
      return;
    }

    bool available = await _speech.initialize(
      onStatus: (status) {
        // 상태 표시용 로그 필요 시
        debugPrint("Speech Status: $status");
      },
      onError: (error) {
        debugPrint("Speech Error: ${error.errorMsg}");
      },
    );

    if (available) {
      setState(() => _isListening = true);

      await _speech.listen(
        localeId: widget.localeId,
        onResult: (result) {
          if (widget.onResult != null) {
            widget.onResult!(result.recognizedWords);
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        icon: Icon(
          _isListening ? Icons.mic : Icons.mic_none,
          color: const Color(0xFF001F3F),
          size: 24,
        ),
        onPressed: _onPressed,
      ),
    );
  }
}
