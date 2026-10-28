import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/l10n/generated/app_localizations.dart';
import '../../data/db/app_database.dart';
import '../ai/ai_client.dart';
import '../lists/item_repository.dart';
import 'ai_image.dart';
import 'ai_receipt_reader.dart';
import 'image_capture_service.dart';
import 'image_capture_sheet.dart';
import 'ocr_text_source.dart';
import 'receipt_document.dart';
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
  @visibleForTesting Future<String?> Function(String path)? encodeAiImage,
}) async {
  final l10n = AppLocalizations.of(context);
  final messenger = ScaffoldMessenger.of(context);
  messenger.clearSnackBars();
  messenger.removeCurrentSnackBar();
  final drafts = ReceiptDraftRepository(db);
  final images = imageStore ?? ReceiptImageStore();
  final pending = await drafts.pending(listId: listId);
  if (!context.mounted) return null;
  ReceiptDocument? document;
  int? draftId;
  var imagePaths = <String>[];
  if (pending.isNotEmpty) {
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
                    draft.document.metadata.store ?? l10n.receiptContinueAction,
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
      case _AiStopped():
        return null;
      case _AiProgress(:final doc, :final id, :final paths, :final capture):
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
      final reviewCurrency = listId == null
          ? document.metadata.currencyCode ?? currencyCode
          : currencyCode;
      final controller = ReceiptReviewController(
        db: db,
        listId: listId,
        title: title ?? document.metadata.store,
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
              plannedItems: listId == null
                  ? Future.value(const [])
                  : ItemRepository(db).getItems(listId),
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.receiptDraftSaved), showCloseIcon: true),
        );
        return null;
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
        listId: listId,
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
  const _AiStopped();
}

/// Verified document (ready for review) or the state handed to the on-device
/// path when AI is unavailable.
final class _AiProgress extends _AiOutcome {
  const _AiProgress({
    required this.doc,
    required this.id,
    required this.paths,
    this.capture,
  });
  final ReceiptDocument? doc;
  final int? id;
  final List<String> paths;
  final CapturedImage? capture;
}

/// Image-model loop. Every request carries all photos of this receipt, so the
/// stateless model never loses an earlier part; the phone persists each photo
/// as a draft before asking. The model's status drives the guidance: missing
/// top or bottom asks for that part, gaps and unreadable photos ask for a
/// retake, and only a doubly verified reading reaches review.
Future<_AiOutcome> _readWithAi(
  BuildContext context, {
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
  final automatic = pickImage == null;

  Future<void> persist(ReceiptDocument value) async {
    id = await drafts.save(
      document: value,
      listId: listId,
      draftId: id,
      imagePaths: paths,
    );
  }

  while (context.mounted) {
    if (!context.mounted) return const _AiStopped();
    if (needCapture) {
      final capture = await captureImageText(
        context,
        title: l10n.scanReceiptAction,
        pickImage: pickImage,
        ocrSource: ocrSource,
        preferredSource: source,
        requireText: false,
      );
      if (!context.mounted || capture is! CapturedImage) {
        return const _AiStopped();
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
      doc ??= ReceiptDocument.fromScan(
        capture.scan,
        currencyCode: currencyCode,
      );
      await persist(doc);
      if (!context.mounted) return const _AiStopped();
    }
    if (!context.mounted) return const _AiStopped();

    final read = await _withProgress(
      context,
      reader.read(paths, currencyCode: currencyCode),
    );
    if (!context.mounted) return const _AiStopped();

    switch (read) {
      case AiReceiptVerified(:final document):
        await persist(document);
        return _AiProgress(doc: document, id: id, paths: paths);
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
        final single =
            paths.length == 1 &&
            lastCapture != null &&
            lastCapture.scan.lines.any((l) => l.text.trim().isNotEmpty);
        return _AiProgress(
          doc: single ? null : doc,
          id: id,
          paths: paths,
          capture: single ? lastCapture : null,
        );
      case AiReceiptNeedsMore(:final gap):
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
          automatic: automatic && !full && gap != AiReceiptGap.middle,
          canContinue: !full,
        );
        if (!context.mounted) return const _AiStopped();
        if (action == null || action == _CaptureAction.later) {
          _draftNotice(context);
          return const _AiStopped();
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
        if (!context.mounted) return const _AiStopped();
        if (action == null || action == _CaptureAction.later) {
          _draftNotice(context);
          return const _AiStopped();
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
  return const _AiStopped();
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

/// Blocks input while the model reads; the request itself has a timeout.
Future<T> _withProgress<T>(BuildContext context, Future<T> work) async {
  final navigator = Navigator.of(context, rootNavigator: true);
  var open = true;
  unawaited(
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const PopScope(
        canPop: false,
        child: Center(child: CircularProgressIndicator()),
      ),
    ).whenComplete(() => open = false),
  );
  try {
    return await work;
  } finally {
    if (open && navigator.mounted) navigator.pop();
  }
}
