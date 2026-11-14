import 'dart:async';
import 'dart:ui';

import 'package:flutter/services.dart'
    show MethodChannel, MissingPluginException, PlatformException;
import 'package:flutter/widgets.dart';
import 'package:napp_core/napp_core.dart';

import '../../app/language_controller.dart';
import '../../core/config/env_config.dart';
import '../../core/l10n/generated/app_localizations.dart';
import '../../data/db/app_database.dart';
import '../../data/db/app_database_opener.dart';
import '../ai/ai_client.dart';
import '../lists/reminders/local_notifications_scheduler.dart';
import '../subscription/subscription_service.dart';
import 'ai_receipt_reader.dart';
import 'ocr_text_source.dart';
import 'receipt_dedup.dart';
import 'receipt_document.dart';
import 'receipt_draft_repository.dart';
import 'receipt_image_store.dart';
import 'receipt_repository.dart';

/// Builds the application's [AiClient] identically for foreground UI and
/// headless background workers without duplicating credential wiring.
AiClient buildAppAiClient({
  required SettingsStore store,
  required SubscriptionService subscriptions,
}) => AiClient(
  store: store,
  baseUrl: EnvConfig.aiBaseUrl,
  credential: () => subscriptions.credential,
  appleTransaction: () => subscriptions.appleTransaction,
  trialFirstOpenedAt: () => subscriptions.trialFirstOpenedAt,
  onTrialWindow: (window) => subscriptions.observeTrialServer(
    endsAt: window.endsAt,
    serverNow: window.serverNow,
  ),
);

typedef QueueImageParser =
    Future<ReceiptParseOutcome> Function(
      List<String> photoPaths, {
      required String currencyCode,
      required String localeCode,
    });

typedef ReadyNotificationSender =
    Future<void> Function({
      required int receiptId,
      String? storeName,
      int? totalMinorUnits,
      String? currencyCode,
      bool isDuplicate,
    });

/// Sequential background receipt-queue drainer shared by foreground app launch,
/// resume lifecycle, and native OS WorkManager / BGTaskScheduler wakeups.
class ReceiptQueueService {
  ReceiptQueueService({
    required this.db,
    this.ai,
    this.ocrFallback,
    this.localeCode = 'en',
    this.notifications,
    this.parseImages,
    this.sendReadyNotification,
    this.scheduleBackgroundHook,
    ReceiptImageStore? imageStore,
    this.removeOwnedImage,
    this.notifyDrainFinished = true,
  }) : _drafts = ReceiptDraftRepository(db),
       _images = imageStore ?? ReceiptImageStore();

  static const MethodChannel channel = MethodChannel(
    'nshoptor/background_queue',
  );

  /// Registered active service when the foreground FlutterEngine handles
  /// background wakeups directly without opening a duplicate DB connection.
  static ReceiptQueueService? activeInstance;

  final AppDatabase db;
  final AiClient? ai;
  final OcrTextSource? ocrFallback;
  String localeCode;
  final LocalNotificationsScheduler? notifications;
  final QueueImageParser? parseImages;
  final ReadyNotificationSender? sendReadyNotification;
  final Future<void> Function()? scheduleBackgroundHook;
  final bool notifyDrainFinished;
  final ReceiptImageStore _images;
  final Future<bool> Function(String path)? removeOwnedImage;

  final ReceiptDraftRepository _drafts;
  Future<void>? _activeDrain;
  bool _drainRequested = false;

  /// Enqueues native OS background work (Android WorkManager / iOS
  /// BGProcessingTask) and starts draining sequentially right away.
  Future<void> onEnqueued() async {
    await scheduleBackgroundDrain();
    unawaited(drain());
  }

  /// Requests native OS scheduling so queued receipts continue parsing even if
  /// the user leaves or closes the app immediately after tapping Done.
  Future<void> scheduleBackgroundDrain() async {
    if (scheduleBackgroundHook != null) {
      await scheduleBackgroundHook!();
      return;
    }
    try {
      await channel.invokeMethod<void>('scheduleQueue');
    } on MissingPluginException {
      // Headless tests and non-mobile targets have no native scheduler channel.
    } on PlatformException {
      // Never block capture UI if OS scheduler rejects/throttles a request.
    }
  }

  /// Registers native -> Dart wakeup handling on [channel] so Android/iOS can
  /// ask the running main engine to drain safely before launching headless VM.
  void attachNativeWakeupHandler() {
    channel.setMethodCallHandler((call) async {
      if (call.method == 'drainQueue') {
        await reconcileAndDrain();
        return true;
      }
      return null;
    });
  }

  void detachNativeWakeupHandler() {
    channel.setMethodCallHandler(null);
  }

  /// Resets any interrupted `processing` rows (left behind if the OS terminated
  /// the app mid-request) back to `queued`, then drains every pending receipt.
  Future<void> reconcileAndDrain() async {
    await _drafts.resetInterruptedProcessing();
    await drain();
  }

  /// Re-queues a failed tray item and runs the queue again.
  Future<void> retryReceipt(int receiptId) async {
    await _drafts.requeue(receiptId);
    await scheduleBackgroundDrain();
    unawaited(drain());
  }

  /// Deletes a receipt row from `Fişlerim (N)` and cleans up app-owned JPEG files
  /// (delegating physical removal to [removeOwnedImage] when overridden in tests).
  Future<void> deleteTrayReceipt(int receiptId) async {
    await ReceiptRepository(
      db,
      images: removeOwnedImage == null
          ? _images
          : _HookImageStore(removeOwnedImage!),
    ).delete(receiptId, pendingOnly: true);
  }

  /// Sequential single-flight queue drain. Concurrent callers coalesce onto the
  /// in-progress future and trigger one extra pass when newly queued rows exist.
  Future<void> drain() {
    if (_activeDrain != null) {
      _drainRequested = true;
      return _activeDrain!;
    }
    final completer = Completer<void>();
    _activeDrain = completer.future;
    () async {
      try {
        do {
          _drainRequested = false;
          final pending = await _drafts.pendingQueueItems();
          for (final item in pending) {
            await _processOne(item);
          }
        } while (_drainRequested);
        if (notifyDrainFinished) {
          try {
            await channel.invokeMethod<void>(
              'backgroundDrainFinished',
              const <String, Object>{'ok': true},
            );
          } catch (_) {
            // Native channel may be unavailable in test/non-mobile runtimes.
          }
        }
        completer.complete();
      } catch (error, stack) {
        completer.completeError(error, stack);
      } finally {
        _activeDrain = null;
      }
    }();
    return _activeDrain!;
  }

  Future<void> _processOne(Receipt item) async {
    if (item.imagePaths.isEmpty) {
      await _drafts.markFailed(item.id, 'no_images');
      return;
    }
    try {
      await _drafts.markProcessing(item.id);
      final currencyCode = item.detectedCurrency ?? 'TRY';
      final outcome = await (parseImages != null
          ? parseImages!(
              item.imagePaths,
              currencyCode: currencyCode,
              localeCode: localeCode,
            )
          : parseReceiptImages(
              photoPaths: item.imagePaths,
              currencyCode: currencyCode,
              ai: ai,
              localeCode: localeCode,
              ocrFallback: ocrFallback,
            ));

      switch (outcome) {
        case ReceiptParsedDocument(:final document):
          await _completeParsed(item, document);
        case ReceiptParseNeedsMoreOrRetake(:final read):
          final reason = read is AiReceiptRetake ? read.reason : 'needs_more';
          await _drafts.markFailed(item.id, reason);
        case ReceiptParseFailed():
          await _drafts.markFailed(item.id, 'unreadable');
      }
    } catch (_) {
      try {
        await _drafts.markFailed(item.id, 'error');
      } catch (_) {}
    }
  }

  Future<void> _completeParsed(Receipt item, ReceiptDocument document) async {
    final dup = await findDuplicateReceipt(
      db: db,
      storeName: document.metadata.store,
      purchaseAt: document.metadata.dateTime,
      identityKey: document.metadata.identity,
      excludeReceiptId: item.id,
    );
    final rawText = document.fragments
        .map((f) => f.lines.map((l) => l.text).join('\n'))
        .join('\n\n')
        .trim();
    await _drafts.markReady(
      item.id,
      document: document,
      duplicateOfListId: dup?.listId,
      rawOcrText: rawText.isEmpty ? null : rawText,
    );
    await _notifyReady(
      receiptId: item.id,
      storeName: document.metadata.store,
      totalMinorUnits: document.metadata.totalMinor,
      currencyCode: document.metadata.currencyCode,
      isDuplicate: dup != null,
    );
  }

  Future<void> _notifyReady({
    required int receiptId,
    String? storeName,
    int? totalMinorUnits,
    String? currencyCode,
    required bool isDuplicate,
  }) async {
    if (sendReadyNotification != null) {
      await sendReadyNotification!(
        receiptId: receiptId,
        storeName: storeName,
        totalMinorUnits: totalMinorUnits,
        currencyCode: currencyCode,
        isDuplicate: isDuplicate,
      );
      return;
    }
    final scheduler = notifications;
    if (scheduler == null) return;
    final tag = localeCode.split(RegExp(r'[_-]')).first.toLowerCase();
    final l10n = lookupAppLocalizations(
      AppLocalizations.supportedLocales.any((l) => l.languageCode == tag)
          ? Locale(tag)
          : const Locale('en'),
    );
    try {
      await scheduler.showReceiptDraftReady(
        draftId: receiptId,
        title: l10n.receiptReadyNotificationTitle,
        body: l10n.receiptReadyNotificationBody,
      );
    } catch (_) {
      // Permission or platform notification unavailability must never fail queue.
    }
  }
}

/// Headless VM entrypoint launched by Android WorkManager (`ReceiptQueueWorker`)
/// or iOS `BGProcessingTask` when no live main FlutterEngine is attached.
@pragma('vm:entry-point')
Future<void> receiptQueueBackgroundMain() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  final store = await SettingsStore.load();
  final subscriptions = SubscriptionService(store: store)
    ..load()
    ..initializeTrial();
  final ai = buildAppAiClient(store: store, subscriptions: subscriptions);
  final language = LanguageController(store: store)..load();
  final localeTag =
      language.locale?.languageCode ??
      PlatformDispatcher.instance.locale.languageCode;
  final db = AppDatabase(openAppDatabase());
  var ok = false;
  try {
    final service = ReceiptQueueService(
      db: db,
      ai: ai,
      localeCode: localeTag,
      notifications: LocalNotificationsScheduler(),
      notifyDrainFinished: false,
    );
    await service.reconcileAndDrain();
    ok = true;
  } finally {
    await db.close();
    try {
      await ReceiptQueueService.channel.invokeMethod<void>(
        'backgroundDrainFinished',
        <String, Object>{'ok': ok},
      );
    } catch (_) {}
  }
}

class _HookImageStore extends ReceiptImageStore {
  _HookImageStore(this._remove);

  final Future<bool> Function(String path) _remove;

  @override
  Future<bool> removeOwned(String path) => _remove(path);
}
