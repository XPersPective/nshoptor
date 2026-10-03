// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Plan at home. Shop as planned.';

  @override
  String get listsTitle => 'Lists';

  @override
  String get listsTabActive => 'Active';

  @override
  String get listsTabCompleted => 'Completed';

  @override
  String get listsTabArchived => 'Archived';

  @override
  String get newListButton => 'New list';

  @override
  String get listTitleHint => 'Title (optional)';

  @override
  String get saveButton => 'Save';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get deleteButton => 'Delete';

  @override
  String get editAction => 'Edit';

  @override
  String get listDeleted => 'List deleted';

  @override
  String get invalidAmountError => 'Invalid amount';

  @override
  String get duplicateAction => 'Duplicate';

  @override
  String get archiveAction => 'Archive';

  @override
  String get unarchiveAction => 'Unarchive';

  @override
  String get deleteListConfirm =>
      'Delete this list? Its planned items will also be removed.';

  @override
  String get undoButton => 'Undo';

  @override
  String get searchListHint => 'Search lists';

  @override
  String get currencyLabel => 'Currency';

  @override
  String get budgetLabel => 'Budget (optional)';

  @override
  String get noteLabel => 'Note (optional)';

  @override
  String get storeLabel => 'Store';

  @override
  String get keepAmountsAction => 'Keep amounts';

  @override
  String get resetAmountsAction => 'Reset amounts';

  @override
  String get currencyChangeWarning =>
      'The currency is changing. What should happen to the existing amounts?';

  @override
  String get listsEmpty => 'No lists yet. Create your first shopping plan.';

  @override
  String get statusDraft => 'Draft';

  @override
  String get statusPlanned => 'Planned';

  @override
  String get statusShopping => 'Shopping';

  @override
  String get statusCompleted => 'Completed';

  @override
  String get statusArchived => 'Archived';

  @override
  String autoListTitle(String date) {
    return '$date shopping';
  }

  @override
  String get itemFormTitle => 'Add item';

  @override
  String get itemNameLabel => 'Item name';

  @override
  String get brandLabel => 'Brand / variant (optional)';

  @override
  String get categoryLabel => 'Category';

  @override
  String get quantityLabel => 'Quantity';

  @override
  String get unitLabel => 'Unit';

  @override
  String get pricingModeLabel => 'Price entry';

  @override
  String get pricingModeUnitPrice => 'Unit price';

  @override
  String get pricingModeLineTotal => 'Line total';

  @override
  String get plannedPriceLabel => 'Planned price';

  @override
  String lineTotalCalculated(String value) {
    return 'Line total: $value';
  }

  @override
  String get requiredItemToggle => 'Required item';

  @override
  String get maxPriceLabel => 'Maximum acceptable price (optional)';

  @override
  String get itemNoteLabel => 'Note (optional)';

  @override
  String get categoryProduce => 'Fruit & vegetables';

  @override
  String get categoryDairy => 'Dairy';

  @override
  String get categoryMeat => 'Meat';

  @override
  String get categoryBakery => 'Bakery';

  @override
  String get categoryDrinks => 'Drinks';

  @override
  String get categoryCleaning => 'Cleaning';

  @override
  String get categoryPersonalCare => 'Personal care';

  @override
  String get categoryHome => 'Home';

  @override
  String get categoryOther => 'Other';

  @override
  String get invalidQuantityError => 'Invalid quantity';

  @override
  String get invalidPriceError => 'Invalid price';

  @override
  String get invalidNameError => 'Enter a name';

  @override
  String unitPriceCalculated(String value) {
    return 'Unit price: $value';
  }

  @override
  String get shoppingTitle => 'Shopping mode';

  @override
  String get summaryPlannedTotal => 'Planned';

  @override
  String get summaryInCart => 'In cart';

  @override
  String get summaryRemainingPlan => 'Remaining plan';

  @override
  String get summaryProjected => 'Estimated checkout';

  @override
  String get summaryBudgetRemaining => 'Budget left';

  @override
  String get summaryBudgetOver => 'Over budget';

  @override
  String itemsProgress(String done, String total) {
    return '$done of $total items';
  }

  @override
  String get filterAll => 'All';

  @override
  String get filterToBuy => 'To buy';

  @override
  String get filterInCart => 'In cart';

  @override
  String get filterNotFound => 'Not found';

  @override
  String get filterRequired => 'Required';

  @override
  String get quickEntryTitle => 'Actual price';

  @override
  String get actualQuantityLabel => 'Actual quantity';

  @override
  String get actualPriceLabel => 'Actual price';

  @override
  String get discountLabel => 'Discount (optional)';

  @override
  String get alternativeNameLabel => 'Alternative product name (optional)';

  @override
  String get savePurchaseButton => 'Add to cart';

  @override
  String get unplannedAddButton => 'Add unplanned item';

  @override
  String get statusPending => 'Not taken';

  @override
  String get statusInCart => 'In cart';

  @override
  String get statusNotFound => 'Not found';

  @override
  String get statusGaveUp => 'Gave up';

  @override
  String get statusAlternative => 'Alternative bought';

  @override
  String get keepScreenAwake => 'Keep screen on';

  @override
  String get finishShopping => 'Finish shopping';

  @override
  String get completionWarning =>
      'There are missing or unverified records. You can still finish; the result will note them.';

  @override
  String get continueShoppingButton => 'Keep shopping';

  @override
  String get resultTitle => 'Result';

  @override
  String get summarySection => 'Summary';

  @override
  String get plannedTotalLabel => 'Planned total';

  @override
  String get actualTotalLabel => 'Actual total';

  @override
  String get varianceLabel => 'Difference';

  @override
  String get varianceNotComputable => 'Cannot be computed';

  @override
  String get budgetStatusLabel => 'Budget';

  @override
  String get savingsLabel => 'Under plan';

  @override
  String get overspendLabel => 'Over plan';

  @override
  String get unplannedTotalLabel => 'Unplanned total';

  @override
  String get unpurchasedLabel => 'Planned but not bought';

  @override
  String get totalDiscountLabel => 'Total discounts';

  @override
  String get accuracyLabel => 'Estimate accuracy';

  @override
  String get groupsSection => 'Items';

  @override
  String get groupPricier => 'Pricier than planned';

  @override
  String get groupCheaper => 'Cheaper than planned';

  @override
  String get groupClose => 'Close to estimate';

  @override
  String get groupNotTaken => 'Planned, not bought';

  @override
  String get groupUnplanned => 'Bought without plan';

  @override
  String get groupQuantityChanged => 'Quantity changed';

  @override
  String get groupUnverified => 'Not verified';

  @override
  String get plannedQtyLabel => 'Planned quantity';

  @override
  String get actualQtyLabel => 'Actual quantity';

  @override
  String get plannedUnitPriceLabel => 'Planned unit price';

  @override
  String get actualUnitPriceLabel => 'Actual unit price';

  @override
  String get lineVarianceLabel => 'Line difference';

  @override
  String get discountEffectLabel => 'Discount effect';

  @override
  String get notBoughtMark => 'not bought';

  @override
  String get noPurchasesNote => 'No purchases were recorded.';

  @override
  String get navHome => 'Home';

  @override
  String get navLists => 'Lists';

  @override
  String get navHistory => 'History';

  @override
  String get navSettings => 'Settings';

  @override
  String get homeEmptyTitle => 'Plan your shopping';

  @override
  String get homeEmptyBody =>
      'Create your first list and compare planned vs actual costs.';

  @override
  String get homeActiveSection => 'Active lists';

  @override
  String get homeCompletedSection => 'Recently completed';

  @override
  String get homeMonthlySection => 'This month';

  @override
  String get monthPlannedLabel => 'Planned';

  @override
  String get monthActualLabel => 'Actual';

  @override
  String get monthVarianceLabel => 'Difference';

  @override
  String get continueShoppingLabel => 'Continue shopping';

  @override
  String get historyEmpty =>
      'No completed shopping yet. Your history and insights will appear here.';

  @override
  String get aboutTabTitle => 'About NShoptor';

  @override
  String get aboutBody =>
      'NShoptor by Crazy Penguin. Offline-first shopping planner. Licensed under GPL-3.0.';

  @override
  String get startShoppingLabel => 'Start shopping';

  @override
  String get finishAndSeeResult => 'Finish & see result';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get languageLabel => 'Language';

  @override
  String get languageSystem => 'System';

  @override
  String get languageTr => 'Turkish';

  @override
  String get languageEn => 'English';

  @override
  String get themeLabel => 'Theme';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get defaultCurrencyLabel => 'Default currency';

  @override
  String get defaultUnitLabel => 'Default unit';

  @override
  String get keepAwakeLabel => 'Keep screen on while shopping';

  @override
  String get backupSection => 'Backup';

  @override
  String get exportBackupLabel => 'Export backup';

  @override
  String get importBackupLabel => 'Import backup';

  @override
  String get mergeImportLabel => 'Merge into current data';

  @override
  String get separateImportLabel => 'Import as a separate copy';

  @override
  String get importCancelled => 'Import cancelled.';

  @override
  String get backupExported => 'Backup exported successfully.';

  @override
  String get backupSizeWarning =>
      'Large backup: the file may be big. Do you want to include photos too?';

  @override
  String get deleteAllSection => 'Danger zone';

  @override
  String get deleteAllLabel => 'Delete all data';

  @override
  String get deleteAllConfirm =>
      'This will remove all lists, history, receipt photos and prices. Files exported by you stay on your drive. Continue?';

  @override
  String get deleteAllConfirm2 =>
      'Are you completely sure? This action cannot be undone.';

  @override
  String get cancelAction => 'Cancel';

  @override
  String get confirmDelete => 'Delete permanently';

  @override
  String get dataDeleted => 'All local data was deleted.';

  @override
  String get privacyInfoLabel => 'Privacy';

  @override
  String get privacyInfoBody =>
      'NShoptor runs offline-first. Receipts and photos stay on your device by default and are never sent to the internet.';

  @override
  String get aboutSection => 'About';

  @override
  String get aboutPublisher => 'Publisher: Crazy Penguin';

  @override
  String get aboutLicenses => 'License: MIT';

  @override
  String get voiceSettingsLabel => 'Voice input';

  @override
  String get voiceStatusUnknown => 'Service: not checked';

  @override
  String get permissionsLabel => 'Permissions';

  @override
  String get permissionsBody =>
      'Camera, microphone and notifications are requested only when you actually use those features.';

  @override
  String get unitsSection => 'Defaults';

  @override
  String get roundingNote =>
      'Money rounding follows one rule: halves round away from zero, applied once at Money conversion.';

  @override
  String get voiceInputTitle => 'Voice input';

  @override
  String get voiceStartListening => 'Start listening';

  @override
  String get voiceTranscriptLabel => 'Transcript';

  @override
  String get parseAction => 'Parse';

  @override
  String get receiptReviewTitle => 'Review receipt';

  @override
  String get receiptTotal => 'Receipt total';

  @override
  String get receiptTotalUnknown => 'Total not detected';

  @override
  String get receiptDiff => 'Difference';

  @override
  String get acceptLine => 'Accept line';

  @override
  String get ignoreLine => 'Ignore line';

  @override
  String get receiptLineActions => 'Link to item, split or ignore';

  @override
  String get receiptCommit => 'Accept all';

  @override
  String get receiptCommitted => 'Receipt applied.';

  @override
  String get priceHistoryTitle => 'Price history';

  @override
  String get noObservations => 'No price observations yet';

  @override
  String get templatesSection => 'Templates';

  @override
  String get templateHint => 'Create a new plan from a previous shopping trip';

  @override
  String get scanReceiptAction => 'Scan receipt';

  @override
  String get shelfLabelAction => 'Price from shelf label';

  @override
  String get priceCandidatesTitle => 'Price candidates';

  @override
  String get noPriceCandidates => 'No price found; enter it manually.';

  @override
  String get voiceUnavailable =>
      'Speech recognition unavailable; enter manually.';

  @override
  String get linkToItem => 'Link to item';

  @override
  String get splitLine => 'Split in two';

  @override
  String get mergeWithNext => 'Merge with next';

  @override
  String get ocrNoText => 'No text read; try again.';

  @override
  String get priceHistoryAction => 'Price history';

  @override
  String get itemsEmptyTitle => 'No items yet';

  @override
  String get itemsEmptyBody =>
      'Add your first item — you\'ll enter real prices here in the store.';

  @override
  String get addItemTooltip => 'Add item';

  @override
  String get unitAdet => 'pc';

  @override
  String get unitKilogram => 'kg';

  @override
  String get unitGram => 'g';

  @override
  String get unitLitre => 'L';

  @override
  String get unitMililitre => 'ml';

  @override
  String get unitPaket => 'pack';

  @override
  String get unitKutu => 'box';

  @override
  String get unitSise => 'bottle';

  @override
  String get unitKavanoz => 'jar';

  @override
  String get unitDemet => 'bunch';

  @override
  String get unitDuzine => 'dozen';

  @override
  String get unitMetre => 'm';

  @override
  String get unitCustom => 'Custom';

  @override
  String get setReminderAction => 'Set reminder';

  @override
  String get reminderPermissionDenied =>
      'Notification permission is needed for reminders. You can enable it in system settings.';

  @override
  String get reminderScheduled => 'Reminder set.';

  @override
  String get reminderCancelled => 'Reminder removed.';

  @override
  String get reminderTitle => 'Shopping reminder';

  @override
  String reminderBody(Object title) {
    return 'Time to check your list: $title';
  }

  @override
  String get reminderPickDate => 'Pick a date';

  @override
  String get reminderPickTime => 'Pick a time';

  @override
  String get itemDetailsSection => 'Details';

  @override
  String get priceOptionalHint =>
      'Optional — you\'ll enter the real price in the store';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Planned: $total · $count items';
  }

  @override
  String get proActiveLabel => 'Pro active — thank you!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Ad-free + backup · one-time payment, no subscription';

  @override
  String get proBenefitNoAds => 'Ad-free experience';

  @override
  String get proBenefitBackup => 'Backup (export/import)';

  @override
  String aboutVersion(Object version) {
    return 'Version $version';
  }

  @override
  String get navDiscover => 'Discover';

  @override
  String get shareAction => 'Share the app';

  @override
  String get rateAction => 'Rate us';

  @override
  String get aboutOpenRow => 'About & open source';
}
