import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:audioplayers/audioplayers.dart';

/// 음성 인식 버튼: 텍스트 전달만 담당
class VoiceButton extends StatefulWidget {
  final Function(String recognizedWords)? onResult;
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
  final AudioPlayer _player = AudioPlayer();

  bool _isListening = false;

  void _onPressed() async {
    await _player.play(AssetSource('sounds/Notification4.wav'));

    if (_isListening) {
      await _speech.stop();
      setState(() => _isListening = false);
      return;
    }

    bool available = await _speech.initialize(
      onStatus: (status) => debugPrint("Speech Status: $status"),
      onError: (error) => debugPrint("Speech Error: ${error.errorMsg}"),
    );

    if (!available) return;

    setState(() => _isListening = true);

    await _speech.listen(
      localeId: widget.localeId,
      pauseFor: const Duration(seconds: 3),
      listenFor: const Duration(minutes: 1),
      onResult: (result) {
        if (widget.onResult != null) {
          widget.onResult!(result.recognizedWords);
        }
      },
      partialResults: false,
    );

    _speech.statusListener = (status) {
      if (status == "notListening" && _isListening) {
        setState(() => _isListening = false);
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
