import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/features/voice_input/voice_input_service.dart';

void main() {
  late FakeSpeechService service;
  late VoiceInputController controller;

  setUp(() {
    service = FakeSpeechService();
    controller = VoiceInputController(service: service);
  });

  tearDown(() => controller.dispose());

  group('başlatma ve dinleme (spec §6.7)', () {
    test('servis hazır: init true, start dinleme durumuna geçer', () async {
      expect(await controller.initialize(), isTrue);
      await controller.start(locale: 'tr_TR');
      expect(controller.state, VoiceInputState.listening);
      expect(service.isListening, isTrue);
    });

    test('kısmi sonuç transcript günceller; nihai sonuç kapatır', () async {
      await controller.initialize();
      await controller.start();
      service.emitPartial('Bir buçuk kilo domates');
      await Future<void>.delayed(Duration.zero);
      expect(controller.transcript, 'Bir buçuk kilo domates');
      expect(controller.state, VoiceInputState.listening);

      service.emitFinal('Bir buçuk kilo domates, kilosu kırk beş lira');
      await Future<void>.delayed(Duration.zero);
      expect(controller.state, VoiceInputState.idle);
      expect(controller.transcript, contains('kırk beş lira'));
    });

    test('stop dinlemeyi bitirir', () async {
      await controller.initialize();
      await controller.start();
      await controller.stop();
      expect(controller.state, VoiceInputState.idle);
      expect(service.isListening, isFalse);
    });
  });

  group('hata yolları ve manuel fallback (spec §6.7)', () {
    test('servis yoksa init false + manuel fallback sinyali', () async {
      service.available = false;
      expect(await controller.initialize(), isFalse);
      expect(controller.shouldFallbackToManual, isTrue);
    });

    test('izin reddi: manuel fallback sinyali, uygulama çalışır', () async {
      service.permissionDenied = true;
      await controller.initialize();
      await controller.start();
      // start hata akışıyla serviceUnavailable bildirir
      await Future<void>.delayed(Duration.zero);
      expect(controller.state, VoiceInputState.error);
      expect(controller.shouldFallbackToManual, isTrue);
    });

    test('tanıma hatası: hata durumu, veri kaybı yok (metin korunur)',
        () async {
      await controller.initialize();
      await controller.start();
      service.emitPartial('yarım kilo elma');
      await Future<void>.delayed(Duration.zero);
      service.emitError('network');
      await Future<void>.delayed(Duration.zero);
      expect(controller.state, VoiceInputState.error);
      expect(controller.transcript, 'yarım kilo elma'); // metin korunur
      expect(controller.shouldFallbackToManual, isFalse); // farklı hata türü
    });

    test('desteklenen locale listesi sağlanır', () async {
      await controller.initialize();
      final locales = await service.availableLocales();
      expect(locales, contains('tr_TR'));
    });
  });
}
