/// Which part of a receipt the model says is missing.
enum AiReceiptGap { top, bottom, middle }

/// The single action that resolves a failed receipt reading.
enum ReceiptReadNextStep {
  /// The receipt is incomplete: photograph the missing part and add it to the
  /// same receipt session.
  addMore,

  /// The photos are wrong (blur, glare, wrong subject): take new ones.
  retake,

  /// The same photos may work again (service hiccup, transient rejection).
  retry,
}

/// Canonical, stable reason codes for a receipt that could not be read.
///
/// The `receipt.v2` protocol answers with one fixed status string. That
/// status is mapped here exactly once, the mapped [code] is stored on the
/// receipt row, and the tray turns the code into a short label plus one
/// concrete next step. A free-text reason is never shown to the user and
/// never stored, so the model can never answer with nonsense the user has to
/// make sense of.
enum ReceiptReadFailure {
  /// The merchant identity or the first product rows are not visible.
  missingTop('missing_top', ReceiptReadNextStep.addMore),

  /// The payable total is not visible.
  missingBottom('missing_bottom', ReceiptReadNextStep.addMore),

  /// Consecutive photos do not overlap, so rows may be missing between them.
  missingMiddle('missing_middle', ReceiptReadNextStep.addMore),

  /// The picture is not a receipt at all.
  notReceipt('not_receipt', ReceiptReadNextStep.retake),

  /// Glare, blur, folds or darkness hide the amounts.
  unreadable('unreadable', ReceiptReadNextStep.retake),

  /// The product rows do not reconcile with the printed total.
  totalMismatch('mismatch', ReceiptReadNextStep.retake),

  /// The model answered, but the answer could not be validated.
  rejected('rejected', ReceiptReadNextStep.retry),

  /// The reading service was unreachable, offline or busy.
  serviceUnavailable('service_unavailable', ReceiptReadNextStep.retry),

  /// Monthly AI quota was exhausted.
  quotaExceeded('quota_reached', ReceiptReadNextStep.retry),

  /// The queued receipt has no photo to read.
  noImages('no_images', ReceiptReadNextStep.retake),

  /// Anything the protocol does not name. Never guessed from free text.
  unknown('unknown', ReceiptReadNextStep.retry);

  const ReceiptReadFailure(this.code, this.nextStep);

  /// Stable storage/wire code. Never localized, never shown to the user.
  final String code;

  /// The one action that resolves this failure.
  final ReceiptReadNextStep nextStep;

  /// The missing part of the receipt, when the model named one.
  AiReceiptGap? get gap => switch (this) {
    ReceiptReadFailure.missingTop => AiReceiptGap.top,
    ReceiptReadFailure.missingBottom => AiReceiptGap.bottom,
    ReceiptReadFailure.missingMiddle => AiReceiptGap.middle,
    _ => null,
  };

  /// Whether the failure is fixed by photographing more of the same receipt.
  bool get needsMorePhotos => nextStep == ReceiptReadNextStep.addMore;

  /// Resolves a stored reason code.
  ///
  /// Client-side reasons that the protocol does not name are folded into the
  /// closest user-facing entry; anything unknown stays [unknown] instead of
  /// leaking an arbitrary string into the UI.
  static ReceiptReadFailure fromCode(String? code) => switch (code) {
    'missing_top' => ReceiptReadFailure.missingTop,
    'missing_bottom' => ReceiptReadFailure.missingBottom,
    'missing_middle' => ReceiptReadFailure.missingMiddle,
    'not_receipt' => ReceiptReadFailure.notReceipt,
    'unreadable' => ReceiptReadFailure.unreadable,
    'mismatch' => ReceiptReadFailure.totalMismatch,
    'rejected' => ReceiptReadFailure.rejected,
    'service_unavailable' => ReceiptReadFailure.serviceUnavailable,
    'quota_reached' => ReceiptReadFailure.quotaExceeded,
    'no_images' => ReceiptReadFailure.noImages,
    // The photo itself could not be encoded or the session had a bad photo
    // count: new photos fix it.
    'image' || 'photo_count' => ReceiptReadFailure.unreadable,
    // The answer did not follow the protocol: the same photos may work.
    'schema' => ReceiptReadFailure.rejected,
    // An unknown currency is a data problem the user cannot photograph away.
    'currency' => ReceiptReadFailure.unknown,
    _ => ReceiptReadFailure.unknown,
  };

  /// Maps one `receipt.v2` status string onto the taxonomy.
  ///
  /// The protocol allows exactly six statuses. Any other status is
  /// [unknown], so an unexpected model answer can never become user-facing
  /// text.
  static ReceiptReadFailure fromAiStatus(String? status) => switch (status) {
    'top_missing' => ReceiptReadFailure.missingTop,
    'bottom_missing' => ReceiptReadFailure.missingBottom,
    'middle_gap' => ReceiptReadFailure.missingMiddle,
    'not_receipt' => ReceiptReadFailure.notReceipt,
    'unreadable' => ReceiptReadFailure.unreadable,
    _ => ReceiptReadFailure.unknown,
  };

  /// Maps the missing part named by the model.
  static ReceiptReadFailure fromGap(AiReceiptGap gap) => switch (gap) {
    AiReceiptGap.top => ReceiptReadFailure.missingTop,
    AiReceiptGap.bottom => ReceiptReadFailure.missingBottom,
    AiReceiptGap.middle => ReceiptReadFailure.missingMiddle,
  };
}
