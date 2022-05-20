
    import 'package:flutter_tts/flutter_tts.dart';

FlutterTts flutterTts = FlutterTts();

    speak(String str) async {
      await flutterTts.setLanguage('en-US');
      await flutterTts.setPitch(1);
      await flutterTts.setSpeechRate(0.32);
      if (str != Null) {
        flutterTts.speak(str);
      }
    }