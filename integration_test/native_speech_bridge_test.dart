// Native availability/lifecycle smoke, no recording or model downloads.
// flutter test integration_test/native_speech_bridge_test.dart -d emulator-5554
// Grant RECORD_AUDIO to the installed test app before running if the device has a recognizer.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:nshoptor/features/voice_input/stt_speech_service.dart';
import 'package:nshoptor/features/voice_input/voice_input_service.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('real native bridge can initialize, cancel and reopen without discarding text', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: Text('On-device speech bridge audit'))));
    await tester.pumpAndSettle();
    final firstService = SttSpeechService();
    final first = VoiceInputController(service: firstService)..transcript = 'manual sample';
    // Direct native call ensures an absent MethodChannel fails this test, rather than posing as unsupported hardware.
    final available = await firstService.init();
    final locales = available ? await firstService.availableLocales() : <String>[];
    final secondService = SttSpeechService();
    final second = VoiceInputController(service: secondService)..transcript = 'second manual sample';
    final reopened = await second.initialize();
    first.dispose();
    if (reopened) {
      expect(await secondService.availableLocales(), isA<List<String>>());
    } else {
      expect(second.shouldFallbackToManual, isTrue);
    }
    expect(second.transcript, 'second manual sample');
    second.dispose();
    binding.reportData = {'onDeviceAvailable': available, 'installedLocaleCount': locales.length, 'reopened': reopened};
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
