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
  String get slogan => 'Plan at home, match at checkout.';

  @override
  String get listsTitle => 'Lists';

  @override
  String get listsTabActive => 'List';

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
      'Your lists, prices, receipts and photos are stored on your device. Voice never leaves it. When AI help is on, receipt and price-label photos (reduced in size) and text such as dictated items are sent to our server only to be read; they are processed immediately and never stored.';

  @override
  String get aboutSection => 'About';

  @override
  String get aboutPublisher => 'Publisher: Crazy Penguin';

  @override
  String get aboutLicenses => 'Licenses (GPL-3.0)';

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
  String get fromReceiptListButton => 'From receipt';

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
  String get priceOptionalHint => 'Market price (optional)';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Planned: $total · $count items';
  }

  @override
  String get proActiveLabel => 'Pro active — thank you!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine => 'No ads · Backup export and import · Yearly';

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

  @override
  String get voiceAddItemAction => 'Add by voice';

  @override
  String get formatLocaleLabel => 'Number & currency format';

  @override
  String get formatLocaleSystem =>
      'Device format (Latin digits; otherwise English)';

  @override
  String get formatLocaleTr => 'Turkish (1.234,56)';

  @override
  String get formatLocaleEn => 'English (1,234.56)';

  @override
  String get aiToggleTitle => 'AI help';

  @override
  String get aiToggleSubtitle =>
      'Reads receipts and price labels from photos, matches receipts and turns sentences into lists. Photos are sent only to be read and are never stored.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'You have used this month\'s AI requests ($used/$limit). Upgrade for more, or continue without AI.';
  }

  @override
  String get aiOffline => 'No connection — continuing without AI.';

  @override
  String get aiFailed => 'AI is unavailable right now — continuing without it.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'Device';

  @override
  String get quickListAction => 'Add from a sentence';

  @override
  String get quickListTitle => 'Quick list';

  @override
  String get quickListHint =>
      'e.g. 1 kg apples 20, 2 breads, half a kilo of cheese';

  @override
  String get quickListConvert => 'Turn into a list';

  @override
  String quickListAdd(int count) {
    return 'Add $count items';
  }

  @override
  String get quickListEmpty =>
      'No items found. Try listing them separated by commas.';

  @override
  String get receiptAiMatched =>
      'AI matched the receipt to your list. Check the links and confirm.';

  @override
  String get receiptNeedsCheck => 'Check this match';

  @override
  String get receiptDiscountLine => 'Discount';

  @override
  String get compareItem => 'Item';

  @override
  String get compareEstimated => 'Home price';

  @override
  String get compareActual => 'Store price';

  @override
  String get compareDiff => 'Difference';

  @override
  String get compareTotal => 'Total';

  @override
  String get compareBudget => 'Budget';

  @override
  String get compareNotBought => 'not bought';

  @override
  String get compareUnplanned => 'not planned';

  @override
  String get pricierItems => 'Cost more';

  @override
  String get cheaperItems => 'Cost less';

  @override
  String get compareAction => 'Compare';

  @override
  String get detailsSection => 'Details';

  @override
  String get spendingTitle => 'Spending';

  @override
  String get spendingAction => 'Spending';

  @override
  String get spendingMonthTotal => 'This month';

  @override
  String get spendingWeekly => 'Weekly spending';

  @override
  String get spendingMonthly => 'Monthly spending';

  @override
  String get monthlyLimitTitle => 'Monthly limit';

  @override
  String get monthlyLimitHelp =>
      'How much do you want to spend on shopping per month?';

  @override
  String get monthlyLimitRemove => 'Remove';

  @override
  String get monthlyLimitSet => 'Set';

  @override
  String get monthlyLimitChange => 'Change';

  @override
  String get monthlyLimitNone =>
      'Set a monthly limit to see how much you have left.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount over the limit';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return '$amount left this month';
  }

  @override
  String get plansTitle => 'Plans';

  @override
  String get plansHeadline => 'Shop smarter with AI';

  @override
  String get plansSubhead =>
      'Receipt matching, price labels and lists from a sentence. Cancel any time.';

  @override
  String get plansMonthly => 'Monthly';

  @override
  String get plansYearly => 'Yearly';

  @override
  String get planFree => 'Free';

  @override
  String get planFreePrice => 'Free forever';

  @override
  String get planFreeAi => '10 AI requests a month';

  @override
  String get planFreeAds => 'Small banner ads (none in your first 7 days)';

  @override
  String get planCoreFeatures => 'Lists, prices, receipts, spending charts';

  @override
  String get plansPerYear => '/ year';

  @override
  String get plansPerMonth => '/ month';

  @override
  String get planTrial => 'Free trial';

  @override
  String get planProAi => '100 AI requests a month';

  @override
  String get planNoAds => 'No ads';

  @override
  String get planBackup => 'Backup export and import';

  @override
  String get planMaxAi => '300 AI requests a month';

  @override
  String get planMaxFamily => 'For big family shopping';

  @override
  String get plansStoreUnavailable => 'The store is not reachable right now.';

  @override
  String get retryAction => 'Retry';

  @override
  String get plansPurchaseFailed =>
      'The purchase did not go through. Please try again.';

  @override
  String get plansRestore => 'Restore purchases';

  @override
  String get plansLegal =>
      'Pro renews automatically every year until cancelled and includes 100 AI requests each month. The base price is USD 1/year before applicable taxes; check the final local price and taxes in the store before confirming purchase. Manage or cancel in Google Play.';

  @override
  String get planCurrent => 'Current';

  @override
  String get planStartTrial => 'Start free trial';

  @override
  String get planChoose => 'Choose';

  @override
  String get plansAction => 'Plans: Pro';

  @override
  String get assistantTitle => 'Assistant';

  @override
  String get assistantGreeting => 'Hi! What would you like to do?';

  @override
  String get assistantNewList => 'New list';

  @override
  String get assistantVoiceList => 'List by voice';

  @override
  String get assistantTextList => 'List from a sentence';

  @override
  String get assistantScanReceipt => 'Scan a receipt';

  @override
  String get assistantSpending => 'My spending';

  @override
  String get assistantReceiptHint =>
      'Open your list and tap the receipt icon to scan it.';

  @override
  String get assistantToggleTitle => 'Show assistant';

  @override
  String get assistantToggleSubtitle => 'The little helper at the bottom right';

  @override
  String get scanPriceLabel => 'Scan price label';

  @override
  String get saveFailed =>
      'Could not save. Your changes are still here. Please try again.';

  @override
  String get deleteItemConfirm =>
      'Delete this item and its recorded purchases?';

  @override
  String get clearPurchaseConfirm =>
      'Uncheck this item and remove its recorded purchases?';

  @override
  String get reportPdfAction => 'Save PDF report';

  @override
  String get reportNotInvoice =>
      'Shopping summary, not a tax invoice. Tax rates are unknown.';

  @override
  String get purchaseVisits => 'Shopping visits';

  @override
  String get purchaseInterval => 'Average days between purchases';

  @override
  String get purchasedQuantity => 'Purchased quantity';

  @override
  String get purchaseAnalyticsHint =>
      'Purchases do not measure consumption. Currencies and units are shown separately.';

  @override
  String get receiptReplaces =>
      'Unpriced items are filled in. Items that already have a market price are added as separate purchases.';

  @override
  String get receiptIncompleteHeader =>
      'Include the store, date, time and receipt number in the next photo.';

  @override
  String get receiptIncompleteTail =>
      'Photograph the next section with a few overlapping items and the final total.';

  @override
  String get receiptContinuationRejected =>
      'This photo could not be joined. Retake it with overlapping items from the same receipt.';

  @override
  String get receiptDraftSaved =>
      'Receipt saved as a draft. You can continue later.';

  @override
  String get receiptContinueAction => 'Continue receipt';

  @override
  String get receiptDraftsTitle => 'Unfinished receipts';

  @override
  String get receiptDuplicate => 'This receipt has already been added.';

  @override
  String get receiptTotalMismatch =>
      'The items do not match the receipt total. Check that the whole receipt is visible.';

  @override
  String get receiptSaveDraftAction => 'Save for later';

  @override
  String get receiptResolveLines =>
      'Accept or ignore every item before saving.';

  @override
  String get receiptPartialConfirm =>
      'Only the selected items will be added. This receipt will be marked as imported. Continue?';

  @override
  String get voiceUnsupportedLanguage =>
      'This language is not available for voice input on this device. You can type instead.';

  @override
  String get voiceStopListening => 'Stop listening';

  @override
  String get keepAwakeFailed =>
      'Could not keep the screen awake. Please try again.';

  @override
  String get purchaseHistoryHint =>
      'All completed shopping. Returns reduce totals. Dates refer to shopping completion. One visit is not enough to calculate an average interval.';

  @override
  String get planLegacyRights =>
      'Existing Pro and Max subscriptions keep their original monthly AI allowance.';

  @override
  String get csvExportAction => 'Export CSV';

  @override
  String get reportSharePdf => 'Share as PDF';

  @override
  String get reportShareCsv => 'Share as CSV';

  @override
  String get reportPrintAction => 'Print';

  @override
  String get backupSizeWarning =>
      'JSON includes records, not photo files. Import limit: 16 MB.';

  @override
  String get backupImportFailed =>
      'Could not import this backup. Your data was not changed.';

  @override
  String get backupImported => 'Backup imported successfully.';

  @override
  String backupPreviewCounts(Object entries, Object items, Object lists) {
    return '$lists lists · $items items · $entries purchases';
  }

  @override
  String get voiceModelDownloading =>
      'Downloading the voice model for this language. Try again in a minute.';

  @override
  String get historyThisWeek => 'This week';

  @override
  String get historyProductsSection => 'Products bought';

  @override
  String get tipReceiptScan =>
      'Scan a receipt to match its prices with your list';

  @override
  String get tipVoiceAdd =>
      'Speak one or more items, then review them before adding';

  @override
  String get tipShelfCamera =>
      'Read the price from a shelf label with the camera';

  @override
  String get tipPlan => 'Your plan: see details, subscribe or upgrade';

  @override
  String get guideAddBody =>
      'Tap + to add an item. Enter the planned price now and the market price at checkout.';

  @override
  String get guideVoiceBody =>
      'Tap the microphone and say your items, for example: \'1 kilo apples, 1 bread\'.';

  @override
  String get guideReceiptBody =>
      'Scan a receipt to match its prices with the items on your list.';

  @override
  String get guidePlanBody =>
      'Tap the plan icon to see your plan, subscribe or upgrade.';

  @override
  String get guideNext => 'OK';

  @override
  String get guideDone => 'Start';

  @override
  String get paletteLabel => 'Color theme';

  @override
  String get paletteForest => 'Forest';

  @override
  String get paletteOcean => 'Ocean';

  @override
  String get paletteSunset => 'Sunset';

  @override
  String get paletteLavender => 'Lavender';

  @override
  String get darkBlackLabel => 'Pure black in dark theme';

  @override
  String get spendingOverview => 'Overview';

  @override
  String get spendingThisYear => 'This year';

  @override
  String get spendingYearly => 'Yearly spending';

  @override
  String get productSpending => 'Spending by product';

  @override
  String get spanWeek => 'Week';

  @override
  String get spanMonth => 'Month';

  @override
  String get spanYear => 'Year';

  @override
  String get weeklyLimitTitle => 'Weekly limit';

  @override
  String get weeklyLimitHelp =>
      'How much do you want to spend on shopping per week?';

  @override
  String get weeklyLimitNone => 'Set a weekly limit to see how much is left.';

  @override
  String weeklyLimitLeft(String amount) {
    return '$amount left this week';
  }

  @override
  String get shoppingLimitTitle => 'Limit per shopping';

  @override
  String get shoppingLimitHelp => 'New lists start with this budget.';

  @override
  String get shoppingLimitNone => 'Set a default budget for each new shopping.';

  @override
  String get monthlyReportAction => 'Monthly report';

  @override
  String get reportShoppingColumn => 'Shopping';

  @override
  String get reportDateColumn => 'Date';

  @override
  String get planUnavailable => 'Not available in the store right now';

  @override
  String get demoDataTitle => 'Sample data';

  @override
  String get demoDataLoad => 'Try with sample data';

  @override
  String get demoDataLoadHelp =>
      'Adds 12 months of sample shopping so you can see history, charts and price history.';

  @override
  String get demoDataRemove => 'Remove sample data';

  @override
  String get demoDataAdded => 'Sample data added';

  @override
  String get demoDataRemoved => 'Sample data removed';

  @override
  String get demoProductApple => 'Apples';

  @override
  String get demoProductBread => 'Bread';

  @override
  String get demoProductMilk => 'Milk';

  @override
  String get demoProductCheese => 'Cheese';

  @override
  String get demoProductTomato => 'Tomatoes';

  @override
  String get demoProductEggs => 'Eggs';

  @override
  String get demoProductCoffee => 'Coffee';

  @override
  String get demoProductDetergent => 'Detergent';

  @override
  String get sendAction => 'Send';

  @override
  String get previousMonthAction => 'Previous month';

  @override
  String get nextMonthAction => 'Next month';

  @override
  String get helpSection => 'Help and support';

  @override
  String get howToUseLabel => 'How to use';

  @override
  String get guidePricesBody =>
      'A market price marks the item purchased; 0 counts too. The home price is optional. Clear the market price to uncheck the item.';

  @override
  String get shoppingDateLabel => 'Shopping date';

  @override
  String get shoppingDateNone => 'No date selected';

  @override
  String get clearShoppingDateAction => 'Clear date';

  @override
  String get listSortLabel => 'List order';

  @override
  String get listSortDate => 'Shopping date';

  @override
  String get listSortAz => 'Name (A–Z)';

  @override
  String get listSortManual => 'Manual order';

  @override
  String get imageCameraAction => 'Take photo';

  @override
  String get imageGalleryAction => 'Choose from photos';

  @override
  String get imageCaptureFailed =>
      'Could not open the camera or photos. Check access and try again.';

  @override
  String get imageRecognitionFailed =>
      'The photo could not be processed. Try another photo.';

  @override
  String get receiptNoProducts =>
      'Text was read, but no receipt items were found. Include the items and total in the photo.';

  @override
  String get keepAwakeOn => 'Screen stays on';

  @override
  String get keepAwakeOff => 'Screen can turn off';

  @override
  String get spanDay => 'Day';

  @override
  String get spanCustom => 'Date range';

  @override
  String get reportTotalSpent => 'Total spent';

  @override
  String get reportAddedAt => 'Added';

  @override
  String get reportReceiptNumber => 'Receipt number';

  @override
  String get reportPreview => 'Preview';

  @override
  String get reportShareAction => 'Share';

  @override
  String get previousPeriodAction => 'Previous period';

  @override
  String get nextPeriodAction => 'Next period';

  @override
  String get reportSaved => 'Report saved.';

  @override
  String get reportZoom => 'Zoom';

  @override
  String planTrialDaysLeft(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days days left',
      one: '$days day left',
    );
    return '$_temp0';
  }

  @override
  String planTrialHoursLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours hours left',
      one: '$hours hour left',
    );
    return '$_temp0';
  }

  @override
  String get planTrialEndedTitle => 'Your Pro trial has ended';

  @override
  String get planTrialEndedBody =>
      'You can keep using lists, manual entry and on-device voice for free. Free includes 10 AI requests per calendar month. Choose annual Pro for 100 AI requests per month, no ads and backups. Your existing data stays with you.';

  @override
  String get planContinueFree => 'Continue with Free';

  @override
  String get supportIdLabel => 'Support ID';

  @override
  String get supportEmailLabel => 'Email support';

  @override
  String get captureTipFirst =>
      'Start at the very top: the store name and date must be visible. Fit as many items as you can; the rest goes in the next photo.';

  @override
  String get captureTipContinue =>
      'Same receipt: include the last item of the previous photo.';

  @override
  String get captureTipNeverShow => 'Don\'t show again';

  @override
  String get captureTipOk => 'Got it';

  @override
  String get captureTipsSetting => 'Show receipt capture tips';

  @override
  String get receiptReadingProgress => 'Reading the receipt…';

  @override
  String get receiptReadInBackground => 'Continue in background';

  @override
  String get receiptReadDoneTitle => 'Receipt read';

  @override
  String get receiptReadDoneBody => 'Tap to review and save it.';

  @override
  String get receiptReadMoreTitle => 'Photograph the rest of the receipt';

  @override
  String get receiptReadFailedTitle => 'The receipt could not be read';

  @override
  String get listReceiptsSection => 'Receipts';

  @override
  String get receiptStateComplete => 'Complete';

  @override
  String get receiptStateIncomplete => 'Incomplete';

  @override
  String get receiptStateFailed => 'Failed';

  @override
  String get receiptStoreUnknown => 'Store not read';

  @override
  String get receiptDeleteAction => 'Delete receipt';

  @override
  String get receiptDeleteConfirm =>
      'Delete this receipt and the items it added? You can import it again later.';

  @override
  String get receiptDeleted => 'Receipt deleted.';

  @override
  String listReceiptsShowAll(int count) {
    return 'Show all ($count)';
  }

  @override
  String get listReceiptsShowLess => 'Show less';

  @override
  String receiptDateLabel(String date) {
    return 'Receipt date: $date';
  }
}
