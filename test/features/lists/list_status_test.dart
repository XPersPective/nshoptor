import 'package:flutter_test/flutter_test.dart';

import 'package:nshoptor/features/lists/list_status.dart';

void main() {
  group('ListStatus geçiş kuralları', () {
    test('taslak → planlandı → alışverişte → tamamlandı ana yolu', () {
      expect(ListStatus.draft.canTransitionTo(ListStatus.planned), isTrue);
      expect(ListStatus.planned.canTransitionTo(ListStatus.shopping), isTrue);
      expect(ListStatus.shopping.canTransitionTo(ListStatus.completed), isTrue);
    });

    test('aktif durumdan arşive geçilebilir; arşivden taslağa dönülür', () {
      expect(ListStatus.draft.canTransitionTo(ListStatus.archived), isTrue);
      expect(ListStatus.planned.canTransitionTo(ListStatus.archived), isTrue);
      expect(ListStatus.shopping.canTransitionTo(ListStatus.archived), isTrue);
      expect(ListStatus.completed.canTransitionTo(ListStatus.archived), isTrue);
      expect(ListStatus.archived.canTransitionTo(ListStatus.draft), isTrue);
    });

    test('kural dışı geçişler reddedilir', () {
      expect(ListStatus.draft.canTransitionTo(ListStatus.completed), isFalse);
      expect(ListStatus.draft.canTransitionTo(ListStatus.shopping), isFalse);
      expect(ListStatus.completed.canTransitionTo(ListStatus.shopping), isFalse);
      expect(ListStatus.archived.canTransitionTo(ListStatus.completed), isFalse);
      expect(ListStatus.planned.canTransitionTo(ListStatus.completed), isFalse);
    });

    test('aynı duruma geçiş nötr kabul edilir', () {
      for (final s in ListStatus.values) {
        expect(s.canTransitionTo(s), isTrue);
      }
    });

    test('db kodu gidiş-dönüşü; bilinmeyen kod reddedilir', () {
      for (final s in ListStatus.values) {
        expect(ListStatus.tryFromDb(s.name), s);
      }
      expect(() => ListStatus.fromDb('deleted'), throwsArgumentError);
      expect(ListStatus.tryFromDb('deleted'), isNull);
    });
  });
}
