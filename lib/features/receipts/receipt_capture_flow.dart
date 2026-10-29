import 'dart:async';

import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../app/app_defaults.dart';
import '../../core/l10n/generated/app_localizations.dart';
import '../../core/text/store_name.dart';
import '../../core/util/normalize_name.dart';
import '../../core/quantity/unit_code.dart';
import '../../core/money/decimal_fixed.dart';
import '../../data/db/app_database.dart';
import '../ai/ai_client.dart';
import '../lists/item_repository.dart';
import '../lists/list_repository.dart';
import '../lists/reminders/local_notifications_scheduler.dart';
import '../shopping_mode/shopping_repository.dart';
import 'ai_image.dart';
import 'ai_receipt_reader.dart';
import 'image_capture_service.dart';
import 'image_capture_sheet.dart';
import 'ocr_text_source.dart';
import 'receipt_document.dart';
import 'shelf_label/mlkit_text_source.dart';
import 'receipt_draft_repository.dart';
import 'receipt_image_store.dart';
import 'review/receipt_review_controller.dart';
import 'review/receipt_review_screen.dart';

/// One acquisition/recovery path for new and existing shopping lists.
Future<int?> openReceiptCaptureFlow(
  BuildContext context, {
  required AppDatabase db,
  required String currencyCode,
  int? listId,
  String? title,
  AiClient? ai,
  Future<String?> Function()? pickImage,
  OcrTextSource? ocrSource,
  ReceiptImageStore? imageStore,
  int? resumeDraftId,
  @visibleForTesting Future<String?> Function(String path)? encodeAiImage,
}) async {
  final l10n = AppLocalizations.of(context);
  final messenger = ScaffoldMessenger.of(context);
  messenger.clearSnackBars();
  messenger.removeCurrentSnackBar();
  final drafts = ReceiptDraftRepository(db);
  final images = imageStore ?? ReceiptImageStore();
  // Unfinished receipts belong to their list (F13). Outside a list only
  // header-less leftovers can exist; they identify nothing and are dropped.
  if (listId == null) {
    for (final stale in await drafts.pending()) {
      await drafts.discard(stale.id);
      for (final path in stale.imagePaths) {
        try {
          await images.removeOwned(path);
        } catch (_) {}
      }
    }
  }
  final pending = listId == null
      ? const <ReceiptDraft>[]
      : await drafts.pending(listId: listId);
  if (!context.mounted) return null;
  var activeListId = listId;
  var ownedByFlow = false;
  ReceiptDocument? document;
  int? draftId;
  var imagePaths = <String>[];
  // A receipt chosen in the list's Receipts section continues directly.
  final resume = resumeDraftId == null
      ? null
      : pending.where((d) => d.id == resumeDraftId).firstOrNull;
  if (resume != null) {
    document = resume.document;
    draftId = resume.id;
    imagePaths = [...resume.imagePaths];
  } else if (pending.isNotEmpty) {
    final selection = await showDialog<int>(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: Text(l10n.receiptDraftsTitle),
        children: [
          for (final draft in pending)
            SimpleDialogOption(
              key: Key('receipt_resume_${draft.id}'),
              onPressed: () => Navigator.pop(dialogContext, draft.id),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  [
                    draft.document.metadata.store == null
                        ? l10n.receiptContinueAction
                        : cleanStoreName(draft.document.metadata.store!),
                    if (draft.document.metadata.dateTime != null)
                      MaterialLocalizations.of(dialogContext)
                          .formatShortDate(draft.document.metadata.dateTime!),
                    if (draft.document.metadata.documentNumber != null)
                      draft.document.metadata.documentNumber!,
                  ].join(' · '),
                ),
              ),
            ),
          SimpleDialogOption(
            key: const Key('receipt_new_capture'),
            onPressed: () => Navigator.pop(dialogContext, -1),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(l10n.scanReceiptAction),
            ),
          ),
        ],
      ),
    );
    if (selection == null || !context.mounted) return null;
    if (selection != -1) {
      final draft = pending.singleWhere((d) => d.id == selection);
      document = draft.document;
      draftId = draft.id;
      imagePaths = [...draft.imagePaths];
    }
  }

  // The image model is the primary reader for every language and layout. The
  // on-device OCR path below remains for offline use, exhausted quota or a
  // disabled AI, continuing from whatever the AI path already saved.
  CaptureOutcome? handoff;
  final aiClient = ai ?? AiService.client;
  final alreadyReady =
      document != null &&
      document.state == ReceiptDocumentState.complete &&
      document.toParseResult().withinReconciliationTolerance;
  if (aiClient != null && aiClient.enabled && !alreadyReady) {
    final outcome = await _readWithAi(
      context,
      reader: AiReceiptReader(
        aiClient,
        encode: encodeAiImage ?? encodeImageForAi,
        localeCode: Localizations.localeOf(context).languageCode,
      ),
      db: db,
      drafts: drafts,
      images: images,
      listId: listId,
      currencyCode: currencyCode,
      draftId: draftId,
      photos: imagePaths,
      document: document,
      pickImage: pickImage,
      ocrSource: ocrSource,
    );
    if (!context.mounted) return null;
    switch (outcome) {
      case _AiStopped(:final listId):
        return listId;
      case _AiProgress(
        :final doc,
        :final id,
        :final paths,
        :final capture,
        listId: final owned,
      ):
        activeListId = owned ?? activeListId;
        ownedByFlow = owned != null;
        document = doc;
        draftId = id;
        imagePaths = paths;
        handoff = capture;
    }
  }

  _CaptureAction? action;
  var automatic = pickImage == null;
  var rejected = false;
  while (context.mounted) {
    if (document != null &&
        document.state == ReceiptDocumentState.complete &&
        document.toParseResult().withinReconciliationTolerance) {
      if (!context.mounted) return null;
      final reviewCurrency = activeListId == null || ownedByFlow
          ? document.metadata.currencyCode ?? currencyCode
          : currencyCode;
      final controller = ReceiptReviewController(
        db: db,
        listId: activeListId,
        title:
            title ??
            (document.metadata.store == null
                ? null
                : cleanStoreName(document.metadata.store!)),
        currencyCode: reviewCurrency,
        document: document,
        draftId: draftId,
        parseResult: document.toParseResult(),
        ai: ai,
        localeCode: Localizations.localeOf(context).languageCode,
      );
      try {
        await Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => ReceiptReviewScreen(
              controller: controller,
              currency: reviewCurrency,
              plannedItems: activeListId == null
                  ? Future.value(const [])
                  : ItemRepository(db).getItems(activeListId),
            ),
          ),
        );
      } finally {
        controller.dispose();
      }
      return controller.listId;
    }
    if (document != null) {
      if (!context.mounted) return null;
      final message = rejected
          ? l10n.receiptContinuationRejected
          : switch (document.state) {
              ReceiptDocumentState.incompleteHeader =>
                l10n.receiptIncompleteHeader,
              ReceiptDocumentState.incompleteTail => l10n.receiptIncompleteTail,
              ReceiptDocumentState.complete => l10n.receiptTotalMismatch,
            };
      action = await showModalBottomSheet<_CaptureAction>(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (_) => _ContinuationSheet(
          message: message,
          automatic:
              automatic &&
              !rejected &&
              document!.fragments.length < 25 &&
              !MediaQuery.accessibleNavigationOf(context) &&
              MediaQuery.textScalerOf(context).scale(1) <= 1.5,
          canContinue: document!.fragments.length < 25,
        ),
      );
      if (!context.mounted) return null;
      if (action == null || action == _CaptureAction.later) {
        // A receipt whose store and date are known gets its list now, so it
        // can be continued from inside that list (F12-F13); otherwise
        // nothing identifies it and it is not kept outside a list.
        final doc = document;
        if (activeListId == null &&
            draftId != null &&
            doc.metadata.store != null &&
            doc.metadata.dateTime != null) {
          final created = await ListRepository(db).createList(
            title: cleanStoreName(doc.metadata.store!),
            currencyCode: doc.metadata.currencyCode ?? currencyCode,
            plannedAt: doc.metadata.dateTime,
          );
          await ShoppingRepository(db).startShopping(created);
          draftId = await drafts.save(
            document: doc,
            listId: created,
            draftId: draftId,
            imagePaths: imagePaths,
          );
          activeListId = created;
        }
        if (!context.mounted) return activeListId;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.receiptDraftSaved), showCloseIcon: true),
        );
        return activeListId;
      }
    }
    if (!context.mounted) return null;
    final capture =
        handoff ??
        await captureImageText(
          context,
          title: l10n.scanReceiptAction,
          pickImage: pickImage,
          ocrSource: ocrSource,
          preferredSource: switch (action) {
            _CaptureAction.camera ||
            _CaptureAction.restart => ImageSource.camera,
            _CaptureAction.gallery => ImageSource.gallery,
            _ => null,
          },
        );
    handoff = null;
    if (!context.mounted) return null;
    if (capture is! CapturedImage) {
      // Cancel/permission failure exits without a forced reopening loop. Any
      // earlier evidence is already durable and offered on the next entry.
      return null;
    }
    ReceiptDocument next;
    // Only an explicit retake authorizes replacing previously saved evidence.
    final retake = action == _CaptureAction.restart;
    final prepending =
        !retake && document?.state == ReceiptDocumentState.incompleteHeader;
    if (document == null || retake) {
      next = ReceiptDocument.fromScan(capture.scan, currencyCode: currencyCode);
    } else {
      final joined = document.state == ReceiptDocumentState.incompleteHeader
          ? document.prepend(capture.scan)
          : document.append(capture.scan);
      if (joined is! ReceiptAppended) {
        rejected = true;
        automatic = false;
        continue;
      }
      next = joined.document;
    }
    final keptImage = await images.keep(capture.path);
    final nextPaths = retake ? <String>[] : [...imagePaths];
    if (keptImage != null) {
      if (prepending) {
        nextPaths.insert(0, keptImage);
      } else {
        nextPaths.add(keptImage);
      }
    }
    try {
      draftId = await drafts.save(
        document: next,
        listId: activeListId,
        draftId: draftId,
        imagePaths: nextPaths,
      );
    } catch (_) {
      if (keptImage != null) {
        try {
          await images.removeOwned(keptImage);
        } catch (_) {}
      }
      rethrow;
    }
    if (retake && imagePaths.isNotEmpty) {
      // The database replacement has succeeded. Remove only superseded owned
      // originals which no receipt (including another draft) still references.
      final referenced = await drafts.referencedImages();
      for (final path in imagePaths.where((p) => !referenced.contains(p))) {
        try {
          await images.removeOwned(path);
        } catch (_) {}
      }
    }
    document = next;
    imagePaths = nextPaths;
    automatic = pickImage == null;
    rejected = false;
  }
  return null;
}

enum _CaptureAction { camera, gallery, restart, later }

class _ContinuationSheet extends StatefulWidget {
  const _ContinuationSheet({
    required this.message,
    required this.automatic,
    required this.canContinue,
  });
  final String message;
  final bool automatic;
  final bool canContinue;

  @override
  State<_ContinuationSheet> createState() => _ContinuationSheetState();
}

class _ContinuationSheetState extends State<_ContinuationSheet> {
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    if (widget.automatic) {
      _timer = Timer(const Duration(seconds: 3), () {
        if (mounted && ModalRoute.of(context)?.isCurrent == true) {
          _finish(_CaptureAction.camera);
        }
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _finish(_CaptureAction action) {
    _timer?.cancel();
    Navigator.pop(context, action);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    Widget action(_CaptureAction action, String label, IconData icon) =>
        FilledButton.tonalIcon(
          key: Key('receipt_capture_${action.name}'),
          onPressed: () => _finish(action),
          style: FilledButton.styleFrom(minimumSize: const Size(48, 56)),
          icon: Icon(icon),
          label: Text(label),
        );
    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) _timer?.cancel();
      },
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.receiptContinueAction,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              Semantics(liveRegion: true, child: Text(widget.message)),
              const SizedBox(height: 16),
              if (widget.canContinue) ...[
                action(
                  _CaptureAction.camera,
                  l10n.imageCameraAction,
                  Icons.photo_camera_outlined,
                ),
                const SizedBox(height: 8),
                action(
                  _CaptureAction.gallery,
                  l10n.imageGalleryAction,
                  Icons.photo_library_outlined,
                ),
                const SizedBox(height: 8),
              ],
              action(
                _CaptureAction.restart,
                l10n.retryAction,
                Icons.restart_alt,
              ),
              const SizedBox(height: 8),
              action(
                _CaptureAction.later,
                l10n.receiptSaveDraftAction,
                Icons.save_outlined,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

sealed class _AiOutcome {
  const _AiOutcome();
}

/// The user closed the flow; anything captured is already a saved draft.
final class _AiStopped extends _AiOutcome {
  const _AiStopped({this.listId});

  /// The list created for this receipt (F12), opened by the caller.
  final int? listId;
}

/// Verified document (ready for review) or the state handed to the on-device
/// path when AI is unavailable.
final class _AiProgress extends _AiOutcome {
  const _AiProgress({
    required this.doc,
    required this.id,
    required this.paths,
    this.capture,
    this.listId,
  });
  final ReceiptDocument? doc;
  final int? id;
  final List<String> paths;
  final CapturedImage? capture;
  final int? listId;
}

/// Image-model loop. Every request carries all photos of this receipt, so the
/// stateless model never loses an earlier part; the phone persists each photo
/// as a draft before asking. The model's status drives the guidance: missing
/// top or bottom asks for that part, gaps and unreadable photos ask for a
/// retake, and only a doubly verified reading reaches review.
Future<_AiOutcome> _readWithAi(
  BuildContext context, {
  required AppDatabase db,
  required AiReceiptReader reader,
  required ReceiptDraftRepository drafts,
  required ReceiptImageStore images,
  required int? listId,
  required String currencyCode,
  required int? draftId,
  required List<String> photos,
  required ReceiptDocument? document,
  Future<String?> Function()? pickImage,
  OcrTextSource? ocrSource,
}) async {
  final l10n = AppLocalizations.of(context);
  final paths = [...photos];
  var id = draftId;
  var doc = document;
  CapturedImage? lastCapture;
  ImageSource? source;
  var needCapture = paths.isEmpty;
  var prepend = false;
  var replaceLast = false;
  // Standalone captures get their list as soon as the header is read (F12).
  int? ownedListId;
  _AiStopped stop() => _AiStopped(listId: ownedListId);

  Future<void> persist(ReceiptDocument value) async {
    id = await drafts.save(
      document: value,
      listId: listId ?? ownedListId,
      draftId: id,
      imagePaths: paths,
    );
  }

  Future<void> forgetAll() async {
    if (id != null) await drafts.discard(id!);
    for (final path in paths) {
      try {
        await images.removeOwned(path);
      } catch (_) {}
    }
    id = null;
    doc = null;
    paths.clear();
  }

  while (context.mounted) {
    if (!context.mounted) return stop();
    if (needCapture) {
      await _captureTip(context, first: paths.isEmpty || prepend);
      if (!context.mounted) return stop();
      final capture = await captureImageText(
        context,
        title: l10n.scanReceiptAction,
        pickImage: pickImage,
        // The image model reads the photo; device OCR runs only if the model
        // is unreachable (it took minutes on slow devices before the request).
        ocrSource: const _NoOcr(),
        preferredSource: source,
        requireText: false,
      );
      if (!context.mounted || capture is! CapturedImage) {
        return stop();
      }
      lastCapture = capture;
      final kept = await images.keep(capture.path) ?? capture.path;
      if (replaceLast && paths.isNotEmpty) {
        final old = prepend ? paths.removeAt(0) : paths.removeLast();
        try {
          await images.removeOwned(old);
        } catch (_) {}
      }
      if (prepend) {
        paths.insert(0, kept);
      } else {
        paths.add(kept);
      }
      // Raw OCR (possibly empty for scripts the device cannot read) keeps the
      // draft restorable; the photos are the evidence the model rereads.
      final current = doc ??= ReceiptDocument.fromScan(
        capture.scan,
        currencyCode: currencyCode,
      );
      await persist(current);
      if (!context.mounted) return stop();
    }
    if (!context.mounted) return stop();

    final job = reader.read([...paths], currencyCode: currencyCode);
    final waited = await _readingProgress(context, job);
    if (waited == null) {
      // The user left; the reading finishes in the background and reports
      // with a notification that opens the list (F08).
      unawaited(
        _finishInBackground(
          job,
          db: db,
          drafts: drafts,
          l10n: l10n,
          draftId: id,
          listId: listId ?? ownedListId,
          photos: [...paths],
          currencyCode: currencyCode,
        ),
      );
      return stop();
    }
    final read = waited;
    if (!context.mounted) return stop();

    switch (read) {
      case AiReceiptVerified(:final document):
        final printed = document.metadata.currencyCode;
        if (ownedListId != null && printed != null) {
          // The list was opened before the currency was visible; it is still
          // this receipt's own empty list, so it takes the receipt currency.
          await (db.update(db.shoppingLists)
                ..where((t) => t.id.equals(ownedListId!)))
              .write(ShoppingListsCompanion(currencyCode: Value(printed)));
        }
        await persist(document);
        return _AiProgress(
          doc: document,
          id: id,
          paths: paths,
          listId: ownedListId,
        );
      case AiReceiptUnavailable(:final result):
        final notice = switch (result) {
          AiQuota(:final used, :final limit) => l10n.aiQuotaReached(
            used,
            limit,
          ),
          AiOffline() => l10n.aiOffline,
          AiFailed() => l10n.aiFailed,
          _ => null,
        };
        if (notice != null) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              SnackBar(content: Text(notice), showCloseIcon: true),
            );
        }
        CapturedImage? offline;
        if (paths.length == 1 && lastCapture != null) {
          final owned = ocrSource == null ? MlKitTextSource() : null;
          try {
            final scan = await (ocrSource ?? owned!).scan(lastCapture.path);
            if (scan.lines.any((l) => l.text.trim().isNotEmpty)) {
              offline = CapturedImage(path: lastCapture.path, scan: scan);
            }
          } catch (_) {
          } finally {
            try {
              await owned?.dispose();
            } catch (_) {}
          }
        }
        return _AiProgress(
          doc: offline != null ? null : doc,
          id: id,
          paths: paths,
          capture: offline,
          listId: ownedListId,
        );
      case AiReceiptNeedsMore(:final gap)
          when listId == null && ownedListId == null && !read.hasHeader:
        // Nothing identifies this receipt yet: keep nothing and ask for the
        // top with store and date (F11).
        await forgetAll();
        if (!context.mounted) return stop();
        final action = await _askNext(
          context,
          message: l10n.receiptIncompleteHeader,
          automatic: false,
          canContinue: true,
        );
        if (!context.mounted ||
            action == null ||
            action == _CaptureAction.later) {
          return stop();
        }
        prepend = false;
        replaceLast = false;
        source = action == _CaptureAction.gallery
            ? ImageSource.gallery
            : ImageSource.camera;
        needCapture = true;
        if (gap == AiReceiptGap.top) continue;
      case AiReceiptNeedsMore(
        :final gap,
        :final store,
        :final date,
        :final currency,
        :final visibleItems,
      ):
        if (listId == null && ownedListId == null && store != null) {
          // Header known: the list exists from now on and owns the receipt.
          ownedListId = await ListRepository(db).createList(
            title: cleanStoreName(store),
            currencyCode: currency ?? currencyCode,
            plannedAt: date,
          );
          await ShoppingRepository(db).startShopping(ownedListId);
          await persist(doc!);
          if (!context.mounted) return stop();
        }
        final owner = listId ?? ownedListId;
        if (owner != null) {
          await _addVisibleItems(db, owner, id!, visibleItems);
          if (!context.mounted) return stop();
        }
        final full = paths.length >= AiReceiptReader.maxPhotos;
        final action = await _askNext(
          context,
          message: full
              ? l10n.receiptContinuationRejected
              : switch (gap) {
                  AiReceiptGap.top => l10n.receiptIncompleteHeader,
                  AiReceiptGap.bottom => l10n.receiptIncompleteTail,
                  AiReceiptGap.middle => l10n.receiptContinuationRejected,
                },
          // No timed auto-camera: the user picks camera or photos.
          automatic: false,
          canContinue: !full,
        );
        if (!context.mounted) return stop();
        if (action == null || action == _CaptureAction.later) {
          _draftNotice(context);
          return stop();
        }
        if (action == _CaptureAction.restart) {
          paths.clear();
          doc = null;
          prepend = false;
          replaceLast = false;
        } else {
          // A gap means the last photo does not overlap: retake it.
          prepend = gap == AiReceiptGap.top;
          replaceLast = gap == AiReceiptGap.middle;
        }
        source = action == _CaptureAction.gallery
            ? ImageSource.gallery
            : ImageSource.camera;
        needCapture = true;
      case AiReceiptRetake(:final reason):
        final action = await _askNext(
          context,
          message: reason == 'mismatch' || reason == 'rejected'
              ? l10n.receiptTotalMismatch
              : l10n.imageRecognitionFailed,
          automatic: false,
          canContinue: paths.isNotEmpty,
        );
        if (!context.mounted) return stop();
        if (action == null || action == _CaptureAction.later) {
          _draftNotice(context);
          return stop();
        }
        if (action == _CaptureAction.restart) {
          paths.clear();
          doc = null;
          replaceLast = false;
        } else {
          replaceLast = paths.isNotEmpty;
        }
        prepend = false;
        source = action == _CaptureAction.gallery
            ? ImageSource.gallery
            : ImageSource.camera;
        needCapture = true;
    }
  }
  return stop();
}

Future<_CaptureAction?> _askNext(
  BuildContext context, {
  required String message,
  required bool automatic,
  required bool canContinue,
}) => showModalBottomSheet<_CaptureAction>(
  context: context,
  showDragHandle: true,
  isScrollControlled: true,
  builder: (_) => _ContinuationSheet(
    message: message,
    automatic:
        automatic &&
        !MediaQuery.accessibleNavigationOf(context) &&
        MediaQuery.textScalerOf(context).scale(1) <= 1.5,
    canContinue: canContinue,
  ),
);

void _draftNotice(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(AppLocalizations.of(context).receiptDraftSaved),
      showCloseIcon: true,
    ),
  );
}

/// Progress while the model reads. Returns the reading, or null when the
/// user chose to continue in the background.
Future<AiReceiptRead?> _readingProgress(
  BuildContext context,
  Future<AiReceiptRead> work,
) async {
  final l10n = AppLocalizations.of(context);
  final navigator = Navigator.of(context, rootNavigator: true);
  final done = Completer<AiReceiptRead?>();
  var open = true;
  unawaited(
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => PopScope(
        canPop: false,
        child: AlertDialog(
          key: const Key('receipt_reading_progress'),
          content: Row(
            children: [
              const SizedBox.square(
                dimension: 32,
                child: CircularProgressIndicator(),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Semantics(
                  liveRegion: true,
                  child: Text(l10n.receiptReadingProgress),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              key: const Key('receipt_read_in_background'),
              onPressed: () {
                if (!done.isCompleted) done.complete(null);
              },
              child: Text(l10n.receiptReadInBackground),
            ),
          ],
        ),
      ),
    ).whenComplete(() => open = false),
  );
  unawaited(
    work.then(
      (value) {
        if (!done.isCompleted) done.complete(value);
      },
      onError: (Object e, StackTrace st) {
        if (!done.isCompleted) done.completeError(e, st);
      },
    ),
  );
  try {
    return await done.future;
  } finally {
    if (open && navigator.mounted) navigator.pop();
  }
}

/// Completes a reading the user sent to the background: keeps the result in
/// the list's receipt draft and tells the user with a notification whose tap
/// opens that list (F08). Notifications are best effort.
Future<void> _finishInBackground(
  Future<AiReceiptRead> job, {
  required AppDatabase db,
  required ReceiptDraftRepository drafts,
  required AppLocalizations l10n,
  required int? draftId,
  required int? listId,
  required List<String> photos,
  required String currencyCode,
}) async {
  final notifier = LocalNotificationsScheduler();
  final notificationId =
      900000000 + DateTime.now().millisecondsSinceEpoch % 99999999;
  int? owner = listId;
  try {
    final read = await job;
    Future<int> ensureList(String store, DateTime? at, String? currency) async {
      final known = owner;
      if (known != null) return known;
      final created = await ListRepository(db).createList(
        title: cleanStoreName(store),
        currencyCode: currency ?? currencyCode,
        plannedAt: at,
      );
      await ShoppingRepository(db).startShopping(created);
      owner = created;
      return created;
    }

    Future<int> keepIn(int list, ReceiptDocument document) => drafts.save(
      document: document,
      listId: list,
      draftId: draftId,
      imagePaths: photos,
    );

    Future<Receipt> currentDraft() async {
      final draft = await (db.select(
        db.receipts,
      )..where((t) => t.id.equals(draftId ?? -1))).getSingleOrNull();
      if (draft == null ||
          draft.processingStatus != 'pending' ||
          draft.identityKey != null ||
          draft.imagePaths.length != photos.length ||
          !Iterable<int>.generate(photos.length)
              .every((i) => draft.imagePaths[i] == photos[i])) {
        throw StateError('Background receipt was deleted or superseded');
      }
      return draft;
    }

    switch (read) {
      case AiReceiptVerified(:final document):
        final list = await db.transaction(() async {
          await currentDraft();
          final list = await ensureList(
            document.metadata.store ?? '?',
            document.metadata.dateTime,
            document.metadata.currencyCode,
          );
          await keepIn(list, document);
          return list;
        });
        await notifier.showReceiptResult(
          id: notificationId,
          title: l10n.receiptReadDoneTitle,
          body: l10n.receiptReadDoneBody,
          listId: list,
        );
      case AiReceiptNeedsMore(
            :final store,
            :final date,
            :final currency,
            :final visibleItems,
          )
          when store != null && date != null:
        final list = await db.transaction(() async {
          final draft = await currentDraft();
          final list = await ensureList(store, date, currency);
          final id = await keepIn(
            list,
            ReceiptDocument.decode(draft.captureDataJson!),
          );
          await _addVisibleItems(db, list, id, visibleItems);
          return list;
        });
        await notifier.showReceiptResult(
          id: notificationId,
          title: l10n.receiptReadMoreTitle,
          body: l10n.receiptIncompleteTail,
          listId: list,
        );
      default:
        await notifier.showReceiptResult(
          id: notificationId,
          title: l10n.receiptReadFailedTitle,
          body: l10n.receiptIncompleteHeader,
          listId: owner,
        );
    }
  } catch (_) {
    // The draft (if any) stays in its list; nothing else to do.
  }
}

/// One short tip before a receipt photo (F05/F06). "Don't show again" turns
/// tips off; Settings turns them back on.
Future<void> _captureTip(BuildContext context, {required bool first}) async {
  if (!AppDefaults.captureTipsEnabled()) return;
  final l10n = AppLocalizations.of(context);
  final never = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      key: Key(first ? 'capture_tip_first' : 'capture_tip_continue'),
      icon: const Icon(Icons.receipt_long_outlined),
      content: Text(first ? l10n.captureTipFirst : l10n.captureTipContinue),
      actions: [
        TextButton(
          key: const Key('capture_tip_never'),
          onPressed: () => Navigator.pop(dialogContext, true),
          child: Text(l10n.captureTipNeverShow),
        ),
        FilledButton(
          key: const Key('capture_tip_ok'),
          onPressed: () => Navigator.pop(dialogContext, false),
          child: Text(l10n.captureTipOk),
        ),
      ],
    ),
  );
  if (never == true) AppDefaults.setCaptureTipsEnabled(false);
}

/// Placeholder text source for image-model captures: no device OCR.
final class _NoOcr implements OcrTextSource {
  const _NoOcr();
  @override
  Future<OcrScanResult> scan(String imagePath) async =>
      const OcrScanResult(lines: []);
}

/// Adds the product rows readable on a cut-off receipt to its list right
/// away (F16). They carry no price yet; the saved receipt links its lines to
/// these rows. Rows already on the list are not added twice.
Future<void> _addVisibleItems(
  AppDatabase db,
  int listId,
  int receiptId,
  List<({String name, String? quantity, String? unit})> rows,
) async {
  if (rows.isEmpty) return;
  final existing = {
    for (final item in await ItemRepository(db).getItems(listId))
      if (item.createdByReceiptId == null ||
          item.createdByReceiptId == receiptId)
        normalizeName(item.name),
  };
  for (final row in rows) {
    final key = normalizeName(row.name);
    if (key.isEmpty || !existing.add(key)) continue;
    final quantity = row.quantity == null
        ? null
        : DecimalFixed.tryParse(row.quantity!);
    final unit = UnitCode.values.where((u) => u.dbCode == row.unit).firstOrNull;
    try {
      await ItemRepository(db).addItem(
        listId: listId,
        createdByReceiptId: receiptId,
        name: row.name,
        quantity: quantity != null && quantity.isPositive
            ? quantity
            : DecimalFixed.fromInt(1),
        unitCode: (unit ?? UnitCode.adet).dbCode,
        priceIsUnitPrice: false,
      );
    } catch (_) {
      // A row that cannot be stored is left for the saved receipt.
    }
  }
}
