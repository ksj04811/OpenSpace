import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:audioplayers/audioplayers.dart';

/// 음성 인식 버튼: 텍스트 전달 + 음성 인식 상태 알림
class VoiceButton extends StatefulWidget {
  final Function(String recognizedWords)? onResult;
  final ValueChanged<bool>? onListeningChanged; // 🔹 추가
  final String localeId;

  const VoiceButton({
    super.key,
    this.onResult,
    this.onListeningChanged,
    this.localeId = "ko_KR",
  });

  @override
  State<VoiceButton> createState() => _VoiceButtonState();
}

class _VoiceButtonState extends State<VoiceButton> {
  final SpeechToText _speech = SpeechToText();
  final AudioPlayer _player = AudioPlayer();

  bool _isListening = false;

  Future<void> _onPressed() async {
    await _player.play(AssetSource('sounds/Notification4.wav'));

    // 🔹 이미 듣고 있으면 중지
    if (_isListening) {
      await _speech.stop();
      setState(() => _isListening = false);
      widget.onListeningChanged?.call(false); // 🔔 알림
      return;
    }

    bool available = await _speech.initialize(
      onStatus: (status) => debugPrint("Speech Status: $status"),
      onError: (error) => debugPrint("Speech Error: ${error.errorMsg}"),
    );

    if (!available) return;

    setState(() => _isListening = true);
    widget.onListeningChanged?.call(true); // 🔔 알림

    await _speech.listen(
      localeId: widget.localeId,
      pauseFor: const Duration(seconds: 3),
      listenFor: const Duration(minutes: 1),
      partialResults: false,
      onResult: (result) {
        widget.onResult?.call(result.recognizedWords);
      },
    );

    _speech.statusListener = (status) {
      if (status == "notListening" && _isListening) {
        setState(() => _isListening = false);
        widget.onListeningChanged?.call(false); // 🔔 알림
      }
    };
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
