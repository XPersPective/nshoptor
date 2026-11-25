import '../../core/l10n/generated/app_localizations.dart';
import 'receipt_read_failure.dart';

/// Turns a [ReceiptReadFailure] into the short label, the guidance and the
/// one action the user needs.
///
/// The label stays short so the tray card reads like a status, not like an
/// explanation. The guidance is one sentence that says what to do next. The
/// action is the single button the sheet offers: the user never has to
/// choose between several near-identical options.
extension ReceiptReadFailureText on ReceiptReadFailure {
  /// The short label shown on the tray card.
  String label(AppLocalizations l10n) => switch (this) {
    ReceiptReadFailure.missingTop => l10n.receiptFailureMissingTop,
    ReceiptReadFailure.missingBottom => l10n.receiptFailureMissingBottom,
    ReceiptReadFailure.missingMiddle => l10n.receiptFailureMissingMiddle,
    ReceiptReadFailure.notReceipt => l10n.receiptFailureNotReceipt,
    ReceiptReadFailure.unreadable => l10n.receiptFailureUnreadable,
    ReceiptReadFailure.totalMismatch => l10n.receiptFailureMismatch,
    ReceiptReadFailure.rejected => l10n.receiptFailureRejected,
    ReceiptReadFailure.serviceUnavailable => l10n.receiptFailureService,
    ReceiptReadFailure.quotaExceeded => l10n.monthlyLimitTitle,
    ReceiptReadFailure.noImages => l10n.receiptFailureUnreadable,
    ReceiptReadFailure.unknown => l10n.receiptFailureUnknown,
  };

  /// One sentence that tells the user what to do about it.
  String guidance(AppLocalizations l10n) => switch (this) {
    ReceiptReadFailure.missingTop => l10n.receiptIncompleteHeader,
    ReceiptReadFailure.missingBottom => l10n.receiptIncompleteTail,
    ReceiptReadFailure.missingMiddle => l10n.receiptContinuationRejected,
    ReceiptReadFailure.notReceipt => l10n.imageRecognitionFailed,
    ReceiptReadFailure.unreadable => l10n.ocrNoText,
    ReceiptReadFailure.totalMismatch => l10n.receiptTotalMismatch,
    ReceiptReadFailure.rejected => l10n.imageRecognitionFailed,
    ReceiptReadFailure.serviceUnavailable => l10n.aiFailed,
    ReceiptReadFailure.quotaExceeded => l10n.plansSubhead,
    ReceiptReadFailure.noImages => l10n.ocrNoText,
    ReceiptReadFailure.unknown => l10n.ocrNoText,
  };

  /// The label of the single action that resolves this failure.
  String actionLabel(AppLocalizations l10n) => switch (nextStep) {
    ReceiptReadNextStep.addMore => l10n.receiptFailureAddMoreAction,
    ReceiptReadNextStep.retake => l10n.receiptFailureRetakeAction,
    ReceiptReadNextStep.retry => l10n.receiptRetryReadAction,
  };
}
