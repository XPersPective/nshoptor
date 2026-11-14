import 'dart:async';
import 'dart:typed_data';

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
import 'receipt_dedup.dart';
import 'receipt_document.dart'
    show
        ReceiptAppended,
        ReceiptDocument,
        ReceiptDocumentState,
        ReceiptHeaderField;
import 'receipt_draft_repository.dart';
import 'receipt_image_store.dart';
import 'receipt_queue_service.dart';
import 'review/receipt_review_controller.dart';
import 'review/receipt_review_screen.dart';

/// Optional global hook invoked immediately when a capture-first receipt
/// session is queued so background scheduling/draining wakes without UI delay.
void Function(int receiptId)? onReceiptEnqueued;

/// One acquisition/recovery path for new and existing shopping lists.
///
/// Standalone capture (`listId == null && resumeDraftId == null`) uses the
/// capture-first batch session flow: snap 1+ pages (`Aynı fişe devam` /
/// `Tamam`), compress immediately, persist an independent `queued` row, and
/// close right away without waiting for OCR or Server AI.
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
  void Function(int receiptId)? onEnqueued,
  @visibleForTesting Future<String?> Function(String path)? encodeAiImage,
  @visibleForTesting Future<Uint8List?> Function(String path)? compressImage,
}) async {
  final l10n = AppLocalizations.of(context);
  final messenger = ScaffoldMessenger.of(context);
  messenger.clearSnackBars();
  messenger.removeCurrentSnackBar();
  final drafts = ReceiptDraftRepository(db);
  final images = imageStore ?? ReceiptImageStore();

  if (listId == null && resumeDraftId == null) {
    await _runCaptureFirstBatchFlow(
      context,
      drafts: drafts,
      images: images,
      currencyCode: currencyCode,
      pickImage: pickImage,
      onEnqueued: onEnqueued ?? onReceiptEnqueued,
      compressImage: compressImage,
    );
    return null;
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
  // "Review and fix" handed back by the AI loop; consumed at the while loop
  // where openReview() is already defined (PB-207).
  var pendingReview = false;
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
        :final openReview,
        listId: final owned,
      ):
        activeListId = owned ?? activeListId;
        ownedByFlow = owned != null;
        document = doc;
        draftId = id;
        imagePaths = paths;
        pendingReview = openReview && doc != null;
    }
  }

  _CaptureAction? action;
  var rejected = false;
  // The review screen is reachable both by a perfect reading and by the
  // user's explicit "review and fix" choice on an imperfect one (PB-207).
  Future<int?> openReview(ReceiptDocument doc) => _presentReceiptReviewScreen(
    context,
    db: db,
    listId: activeListId,
    title:
        title ??
        (doc.metadata.store == null
            ? null
            : cleanStoreName(doc.metadata.store!)),
    currencyCode: activeListId == null || ownedByFlow
        ? doc.metadata.currencyCode ?? currencyCode
        : currencyCode,
    document: doc,
    draftId: draftId,
    ai: ai,
  );

  while (context.mounted) {
    if (pendingReview) {
      pendingReview = false;
      final doc = document;
      if (doc != null && doc.productLines.isNotEmpty) {
        return await openReview(doc);
      }
    }
    if (document != null &&
        document.state == ReceiptDocumentState.complete &&
        document.toParseResult().withinReconciliationTolerance) {
      return await openReview(document);
    }
    final doc = document;
    if (doc != null) {
      if (!context.mounted) return null;
      String messageFor(ReceiptDocument doc) {
        if (rejected) return l10n.receiptContinuationRejected;
        if (doc.state == ReceiptDocumentState.incompleteHeader) {
          // Say WHICH header fields stayed unread instead of a generic tip.
          final fieldLabels = [
            for (final field in doc.metadata.missingHeaderFields)
              switch (field) {
                ReceiptHeaderField.store => l10n.storeLabel,
                ReceiptHeaderField.dateTime => l10n.receiptDateTimeLabel,
                ReceiptHeaderField.documentNumber => l10n.reportReceiptNumber,
                ReceiptHeaderField.currency => l10n.currencyLabel,
              },
          ].join(', ');
          return '${l10n.receiptIncompleteHeader}\n${l10n.receiptMissingFields(fieldLabels)}';
        }
        return doc.state == ReceiptDocumentState.incompleteTail
            ? l10n.receiptIncompleteTail
            : l10n.receiptTotalMismatch;
      }
      final canReview = doc.productLines.isNotEmpty;
      action = await showModalBottomSheet<_CaptureAction>(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (_) => _ContinuationSheet(
          message: messageFor(doc),
          canContinue: doc.fragments.length < 25,
          canReview: canReview,
        ),
      );
      if (!context.mounted) return null;
      if (action == _CaptureAction.review && canReview) {
        return await openReview(doc);
      }
      if (action == null || action == _CaptureAction.later) {
        // A receipt whose store and date are known gets its list now, so it
        // can be continued from inside that list (F12-F13); otherwise
        // nothing identifies it and it is not kept outside a list.
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
    if (!context.mounted) return null;
    if (capture is CaptureCancelled) {
      // The user closed the camera; earlier evidence stays durable (F13).
      return null;
    }
    if (capture is! CapturedImage) {
      // An unreadable photo is not a dead end when evidence already exists:
      // show the continuation sheet (retake/gallery/review) instead (PB-207).
      if (document != null) {
        rejected = true;
        continue;
      }
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
    rejected = false;
  }
  return null;
}

enum _CaptureAction { review, camera, gallery, restart, later }

class _ContinuationSheet extends StatefulWidget {
  const _ContinuationSheet({
    required this.message,
    required this.canContinue,
    this.canReview = false,
  });
  final String message;
  final bool canContinue;

  /// At least one product row is readable: the user can review and fix the
  /// reading now instead of retaking photos (PB-207).
  final bool canReview;

  @override
  State<_ContinuationSheet> createState() => _ContinuationSheetState();
}

class _ContinuationSheetState extends State<_ContinuationSheet> {
  void _finish(_CaptureAction action) {
    Navigator.pop(context, action);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final showTip = widget.canContinue && AppDefaults.captureTipsEnabled();
    Widget action(
      _CaptureAction action,
      String label,
      IconData icon, {
      bool primary = false,
    }) => primary
        ? FilledButton.icon(
            key: Key('receipt_capture_${action.name}'),
            onPressed: () => _finish(action),
            style: FilledButton.styleFrom(minimumSize: const Size(48, 56)),
            icon: Icon(icon),
            label: Text(label),
          )
        : FilledButton.tonalIcon(
            key: Key('receipt_capture_${action.name}'),
            onPressed: () => _finish(action),
            style: FilledButton.styleFrom(minimumSize: const Size(48, 56)),
            icon: Icon(icon),
            label: Text(label),
          );
    return PopScope(
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
              if (showTip) ...[
                const SizedBox(height: 12),
                Container(
                  key: const Key('capture_tip_continue'),
                  padding: const EdgeInsets.fromLTRB(12, 10, 8, 4),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.captureTipContinue,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: TextButton(
                          key: const Key('capture_tip_never'),
                          onPressed: () {
                            AppDefaults.setCaptureTipsEnabled(false);
                            setState(() {});
                          },
                          child: Text(l10n.captureTipNeverShow),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 16),
              if (widget.canReview) ...[
                action(
                  _CaptureAction.review,
                  l10n.receiptReviewNowAction,
                  Icons.fact_check_outlined,
                  primary: true,
                ),
                const SizedBox(height: 8),
              ],
              if (widget.canContinue) ...[
                action(
                  _CaptureAction.camera,
                  l10n.imageCameraAction,
                  Icons.photo_camera_outlined,
                  primary: !widget.canReview,
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
    this.listId,
    this.openReview = false,
  });
  final ReceiptDocument? doc;
  final int? id;
  final List<String> paths;
  final int? listId;

  /// The user chose "review and fix" inside an AI-loop sheet: open the review
  /// screen with whatever was read so far (PB-207).
  final bool openReview;
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
  ImageSource? source;
  var needCapture = paths.isEmpty;
  var prepend = false;
  var replaceLast = false;
  Future<AiReceiptRead>? inFlightJob;
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
      if (pickImage != null) {
        await _captureTip(context, first: paths.isEmpty || prepend);
        if (!context.mounted) return stop();
      }
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
      if (!context.mounted) return stop();
      if (capture is! CapturedImage) {
        if (inFlightJob != null) {
          needCapture = false;
        } else {
          return stop();
        }
      } else {
        inFlightJob = null;
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
    }
    if (!context.mounted) return stop();

    final job =
        inFlightJob ??= reader.read([...paths], currencyCode: currencyCode);
    final step = await _readingProgress(
      context,
      job,
      canAddPhoto: paths.length < AiReceiptReader.maxPhotos,
    );
    final AiReceiptRead read;
    switch (step) {
      case _ReadingAddPhoto():
        needCapture = true;
        prepend = false;
        replaceLast = false;
        continue;
      case _ReadingBackgrounded():
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
      case _ReadingCompleted(read: final completed):
        inFlightJob = null;
        read = completed;
    }
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
        // Offline/quota handoff: read EVERY saved photo on the device, in
        // order, using the shared offline fallback helper (PB-207 / PB-213).
        final offlineDoc = await scanReceiptOfflineFallback(
          photoPaths: paths,
          currencyCode: currencyCode,
          ocrFallback: ocrSource,
        );
        if (offlineDoc != null) {
          // The draft still holds the pre-dropout stub: persist the
          // device-built document so approval compares against it (PB-207).
          await persist(offlineDoc);
        }
        return _AiProgress(
          doc: offlineDoc ?? doc,
          id: id,
          paths: paths,
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
          canContinue: !full,
          canReview: doc?.productLines.isNotEmpty ?? false,
        );
        if (!context.mounted) return stop();
        if (action == null || action == _CaptureAction.later) {
          _draftNotice(context);
          return stop();
        }
        if (action == _CaptureAction.review) {
          return _AiProgress(
            doc: doc,
            id: id,
            paths: paths,
            listId: ownedListId,
            openReview: true,
          );
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
          canContinue: paths.isNotEmpty,
          canReview: (doc?.productLines.isNotEmpty ?? false) || paths.isNotEmpty,
        );
        if (!context.mounted) return stop();
        if (action == null || action == _CaptureAction.later) {
          _draftNotice(context);
          return stop();
        }
        if (action == _CaptureAction.review) {
          return _AiProgress(
            doc: doc,
            id: id,
            paths: paths,
            listId: ownedListId,
            openReview: true,
          );
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
  required bool canContinue,
  bool canReview = false,
}) => showModalBottomSheet<_CaptureAction>(
  context: context,
  showDragHandle: true,
  isScrollControlled: true,
  builder: (_) => _ContinuationSheet(
    message: message,
    canContinue: canContinue,
    canReview: canReview,
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

sealed class _ReadingStep {
  const _ReadingStep();
}

final class _ReadingCompleted extends _ReadingStep {
  const _ReadingCompleted(this.read);
  final AiReceiptRead read;
}

final class _ReadingBackgrounded extends _ReadingStep {
  const _ReadingBackgrounded();
}

final class _ReadingAddPhoto extends _ReadingStep {
  const _ReadingAddPhoto();
}

/// Progress while the model reads. Returns the reading, background handoff, or
/// immediate next-photo capture (F07/F08).
Future<_ReadingStep> _readingProgress(
  BuildContext context,
  Future<AiReceiptRead> work, {
  required bool canAddPhoto,
}) async {
  final l10n = AppLocalizations.of(context);
  final navigator = Navigator.of(context, rootNavigator: true);
  final done = Completer<_ReadingStep>();
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
            if (canAddPhoto)
              TextButton.icon(
                key: const Key('receipt_capture_next_now'),
                onPressed: () {
                  if (!done.isCompleted) {
                    done.complete(const _ReadingAddPhoto());
                  }
                },
                icon: const Icon(Icons.add_a_photo_outlined),
                label: Text(l10n.receiptContinueAction),
              ),
            TextButton(
              key: const Key('receipt_read_in_background'),
              onPressed: () {
                if (!done.isCompleted) {
                  done.complete(const _ReadingBackgrounded());
                }
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
        if (!done.isCompleted) done.complete(_ReadingCompleted(value));
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

enum _BatchSessionChoice { continueSame, done }

Future<void> _runCaptureFirstBatchFlow(
  BuildContext context, {
  required ReceiptDraftRepository drafts,
  required ReceiptImageStore images,
  required String currencyCode,
  Future<String?> Function()? pickImage,
  void Function(int receiptId)? onEnqueued,
  Future<Uint8List?> Function(String path)? compressImage,
}) async {
  final l10n = AppLocalizations.of(context);
  final paths = <String>[];
  var captureNext = true;

  Future<void> cleanupUnqueued() async {
    for (final path in paths) {
      try {
        await images.removeOwned(path);
      } catch (_) {}
    }
  }

  while (true) {
    if (!context.mounted) {
      await cleanupUnqueued();
      return;
    }
    if (captureNext) {
      final capture = await captureImageText(
        context,
        title: l10n.scanReceiptAction,
        pickImage: pickImage,
        // Capture-first: never run device ML Kit while snapping photos.
        ocrSource: const _NoOcr(),
        requireText: false,
      );
      if (!context.mounted) {
        await cleanupUnqueued();
        return;
      }
      if (capture is CapturedImage) {
        try {
          final stored = await _withPhotoPreparingDialog(
            context,
            l10n,
            () async =>
                await images.keepCompressed(
                  capture.path,
                  compress: compressImage,
                ) ??
                capture.path,
          );
          paths.add(stored);
        } catch (_) {
          if (paths.isEmpty) return;
        }
      } else if (paths.isEmpty) {
        return;
      }
    }

    if (!context.mounted) {
      await cleanupUnqueued();
      return;
    }

    final choice = await showModalBottomSheet<_BatchSessionChoice>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (_) => ReceiptBatchSessionSheet(
        pageCount: paths.length,
        maxPages: AiReceiptReader.maxPhotos,
      ),
    );
    if (!context.mounted) {
      await cleanupUnqueued();
      return;
    }
    switch (choice) {
      case _BatchSessionChoice.continueSame:
        captureNext = true;
      case _BatchSessionChoice.done:
        final receiptId = await drafts.enqueueCaptured(
          imagePaths: paths,
          currencyCode: currencyCode,
        );
        onEnqueued?.call(receiptId);
        if (context.mounted) {
          final theme = Theme.of(context);
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              SnackBar(
                key: const Key('receipt_queued_snackbar'),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                duration: const Duration(seconds: 4),
                showCloseIcon: true,
                content: Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.inversePrimary.withValues(
                          alpha: 0.18,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.hourglass_top_rounded,
                        size: 18,
                        color: theme.colorScheme.inversePrimary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(child: Text(l10n.receiptQueuedNotice)),
                  ],
                ),
              ),
            );
        }
        return;
      case null:
        await cleanupUnqueued();
        return;
    }
  }
}

Future<T> _withPhotoPreparingDialog<T>(
  BuildContext context,
  AppLocalizations l10n,
  Future<T> Function() task,
) async {
  final navigator = Navigator.of(context, rootNavigator: true);
  final route = DialogRoute<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) => PopScope(
      canPop: false,
      child: _ReceiptPhotoPreparingDialog(label: l10n.receiptPhotoPreparing),
    ),
  );
  navigator.push(route);
  try {
    return await task();
  } finally {
    if (route.isActive) {
      navigator.removeRoute(route);
    }
  }
}

class _ReceiptPhotoPreparingDialog extends StatelessWidget {
  const _ReceiptPhotoPreparingDialog({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Dialog(
      key: const Key('receipt_photo_preparing'),
      insetPadding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 280),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(
                      child: CircularProgressIndicator(
                        strokeWidth: 3.5,
                        color: colors.primary,
                      ),
                    ),
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: colors.primaryContainer,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.document_scanner_outlined,
                        size: 22,
                        color: colors.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Semantics(
                liveRegion: true,
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleSmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Streamlined post-snap continuation sheet offering ONLY "Continue same
/// receipt" (`Aynı fişe devam`) or "Done" (`Tamam`) so multiple receipts never
/// mix inside one capture session.
class ReceiptBatchSessionSheet extends StatelessWidget {
  const ReceiptBatchSessionSheet({
    super.key,
    required this.pageCount,
    required this.maxPages,
  });

  final int pageCount;
  final int maxPages;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final canAddMore = pageCount < maxPages;
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: Column(
          key: const Key('receipt_batch_sheet'),
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(
                  Icons.receipt_long_outlined,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Semantics(
                    liveRegion: true,
                    child: Text(
                      l10n.receiptSessionPagesCount(pageCount),
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                ),
              ],
            ),
            if (!canAddMore) ...[
              const SizedBox(height: 8),
              Text(
                l10n.receiptMaxPagesNote(maxPages),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
            const SizedBox(height: 16),
            FilledButton.tonalIcon(
              key: const Key('receipt_capture_continue_same'),
              onPressed: canAddMore
                  ? () => Navigator.pop(
                      context,
                      _BatchSessionChoice.continueSame,
                    )
                  : null,
              style: FilledButton.styleFrom(
                minimumSize: const Size(48, 52),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
              icon: const Icon(Icons.add_a_photo_outlined),
              label: Text(l10n.receiptContinueSame),
            ),
            const SizedBox(height: 10),
            FilledButton.icon(
              key: const Key('receipt_capture_done'),
              onPressed: () =>
                  Navigator.pop(context, _BatchSessionChoice.done),
              style: FilledButton.styleFrom(
                minimumSize: const Size(48, 52),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
              icon: const Icon(Icons.check_circle_outline),
              label: Text(l10n.receiptCaptureDone),
            ),
          ],
        ),
      ),
    );
  }
}

enum _DuplicateReviewAction { cancel, deleteDraft, addAnyway }

Future<int?> _presentReceiptReviewScreen(
  BuildContext context, {
  required AppDatabase db,
  required int? listId,
  required String? title,
  required String currencyCode,
  required ReceiptDocument document,
  required int? draftId,
  AiClient? ai,
}) async {
  if (!context.mounted) return null;
  final controller = ReceiptReviewController(
    db: db,
    listId: listId,
    title: title,
    currencyCode: currencyCode,
    document: document,
    draftId: draftId,
    parseResult: document.toParseResult(),
    ai: ai,
    localeCode: Localizations.localeOf(context).languageCode,
  );
  var committed = false;
  try {
    committed = (await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (_) => ReceiptReviewScreen(
          controller: controller,
          currency: currencyCode,
          plannedItems: listId == null
              ? Future.value(const [])
              : ItemRepository(db).getItems(listId),
        ),
      ),
    )) ?? false;
  } finally {
    controller.dispose();
  }
  return committed ? controller.listId : null;
}

/// Opens [ReceiptReviewScreen] for a background-prepared receipt [draft] from
/// `Fişlerim (N)` or a notification tap, showing a duplicate confirmation
/// dialog (*"Bu fiş zaten girilmiş olabilir"*) when an existing shopping list
/// matches the store and timestamp (`C-004`, `PB-214`).
Future<int?> openQueuedReceiptForReview(
  BuildContext context, {
  required AppDatabase db,
  required Receipt draft,
  AiClient? ai,
  Future<void> Function(int draftId)? deleteDraft,
}) async {
  final encoded = draft.captureDataJson;
  if (encoded == null || !context.mounted) return null;
  final ReceiptDocument doc;
  try {
    doc = ReceiptDocument.decode(encoded);
  } catch (_) {
    return null;
  }
  final duplicate = await findDuplicateReceipt(
    db: db,
    storeName: doc.metadata.store ?? draft.detectedStore,
    purchaseAt: doc.metadata.dateTime ?? draft.detectedAt,
    identityKey: doc.metadata.identity,
    excludeReceiptId: draft.id,
  );
  if (!context.mounted) return null;
  if (duplicate != null) {
    final l10n = AppLocalizations.of(context);
    final action = await showDialog<_DuplicateReviewAction>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        key: const Key('receipt_duplicate_warning_dialog'),
        title: Text(l10n.receiptDuplicateTitle),
        content: Text(l10n.receiptDuplicateBody(duplicate.listTitle)),
        actions: [
          TextButton(
            key: const Key('receipt_duplicate_cancel'),
            onPressed: () =>
                Navigator.pop(dialogContext, _DuplicateReviewAction.cancel),
            child: Text(l10n.cancelButton),
          ),
          OutlinedButton(
            key: const Key('receipt_duplicate_delete'),
            onPressed: () =>
                Navigator.pop(dialogContext, _DuplicateReviewAction.deleteDraft),
            child: Text(l10n.receiptDuplicateDelete),
          ),
          FilledButton(
            key: const Key('receipt_duplicate_proceed'),
            onPressed: () =>
                Navigator.pop(dialogContext, _DuplicateReviewAction.addAnyway),
            child: Text(l10n.receiptDuplicateAddAnyway),
          ),
        ],
      ),
    );
    if (!context.mounted) return null;
    switch (action) {
      case _DuplicateReviewAction.deleteDraft:
        final remove =
            deleteDraft ?? (id) => ReceiptQueueService(db: db).deleteTrayReceipt(id);
        await remove(draft.id);
        return null;
      case _DuplicateReviewAction.addAnyway:
        break;
      case _DuplicateReviewAction.cancel:
      case null:
        return null;
    }
  }
  if (!context.mounted) return null;
  final store = doc.metadata.store ?? draft.detectedStore;
  final currency = doc.metadata.currencyCode ?? draft.detectedCurrency ?? 'TRY';
  return _presentReceiptReviewScreen(
    context,
    db: db,
    listId: null,
    title: store == null ? null : cleanStoreName(store),
    currencyCode: currency,
    document: doc,
    draftId: draft.id,
    ai: ai,
  );
}
