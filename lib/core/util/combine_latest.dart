import 'dart:async';

/// Üç akışı birleştirir: üçünün de en az bir değeri olduktan sonra, herhangi
/// biri güncellendiğinde en son değerlerle [combiner] çalıştırır. Ek
/// bağımlılık (rxdart) gerektirmeden alışveriş özeti gibi birleşik
/// akışlarda kullanılır.
Stream<R> combineLatest3<A, B, C, R>(
  Stream<A> streamA,
  Stream<B> streamB,
  Stream<C> streamC,
  R Function(A, B, C) combiner,
) {
  late StreamController<R> controller;
  A? lastA;
  B? lastB;
  C? lastC;
  var hasA = false, hasB = false, hasC = false;

  void emit() {
    if (hasA && hasB && hasC) {
      controller.add(combiner(lastA as A, lastB as B, lastC as C));
    }
  }

  final subscriptions = <StreamSubscription<dynamic>>[];

  controller = StreamController<R>(
    onListen: () {
      subscriptions
        ..add(streamA.listen((a) {
          lastA = a;
          hasA = true;
          emit();
        }, onError: controller.addError))
        ..add(streamB.listen((b) {
          lastB = b;
          hasB = true;
          emit();
        }, onError: controller.addError))
        ..add(streamC.listen((c) {
          lastC = c;
          hasC = true;
          emit();
        }, onError: controller.addError));
    },
    onPause: () {
      for (final s in subscriptions) {
        s.pause();
      }
    },
    onResume: () {
      for (final s in subscriptions) {
        s.resume();
      }
    },
    onCancel: () async {
      for (final s in subscriptions) {
        await s.cancel();
      }
    },
  );
  return controller.stream;
}
