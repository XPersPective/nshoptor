// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kannada (`kn`).
class AppLocalizationsKn extends AppLocalizations {
  AppLocalizationsKn([String locale = 'kn']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'ಮನೆಯಲ್ಲಿ ಯೋಜಿಸಿ. ಯೋಜಿತಂತೆ ಖರೀದಿಸಿ.';

  @override
  String get listsTitle => 'ಪಟ್ಟಿಗಳು';

  @override
  String get listsTabActive => 'ಸಕ್ರಿಯ';

  @override
  String get listsTabCompleted => 'ಪೂರ್ಣಗೊಂಡಿದೆ';

  @override
  String get listsTabArchived => 'ಆರ್ಕೈವ್ ಮಾಡಲಾಗಿದೆ';

  @override
  String get newListButton => 'ಹೊಸ ಪಟ್ಟಿ';

  @override
  String get listTitleHint => 'ಶೀರ್ಷಿಕೆ (ಐಚ್ಛಿಕ)';

  @override
  String get saveButton => 'ಉಳಿಸಿ';

  @override
  String get cancelButton => 'ರದ್ದುಗೊಳಿಸಿ';

  @override
  String get deleteButton => 'ಅಳಿಸಿ';

  @override
  String get editAction => 'ಸಂಪಾದಿಸಿ';

  @override
  String get listDeleted => 'ಪಟ್ಟಿ ಅಳಿಸಲಾಗಿದೆ';

  @override
  String get invalidAmountError => 'ಅಮಾನ್ಯ ಮೊತ್ತ';

  @override
  String get duplicateAction => 'ಪ್ರತಿಕೃತಿ ರಚಿಸಿ';

  @override
  String get archiveAction => 'ಆರ್ಕೈವ್ ಮಾಡಿ';

  @override
  String get unarchiveAction => 'ಆರ್ಕೈವ್ ನಿಂದ ತೆಗೆಯಿರಿ';

  @override
  String get deleteListConfirm =>
      'ಈ ಪಟ್ಟಿಯನ್ನು ಅಳಿಸಬೇಕೇ? ಇದರ ಯೋಜಿತ ವಸ್ತುಗಳೂ ಕೂಡಾ ಅಳಿಸಲ್ಪಡುತ್ತವೆ.';

  @override
  String get undoButton => 'ಮರುಪಡೆಯಿರಿ';

  @override
  String get searchListHint => 'ಪಟ್ಟಿಗಳನ್ನು ಹುಡುಕಿ';

  @override
  String get currencyLabel => 'ಮುದ್ರೆ';

  @override
  String get budgetLabel => 'ಬಜೆಟ್ (ಐಚ್ಛಿಕ)';

  @override
  String get noteLabel => 'ಟಿಪ್ಪಣಿ (ಐಚ್ಛಿಕ)';

  @override
  String get storeLabel => 'ಕಡಾಯಿ/ಕಡೆ';

  @override
  String get keepAmountsAction => 'ಮೊತ್ತಗಳನ್ನು ಉಳಿಸಿ';

  @override
  String get resetAmountsAction => 'ಮೊತ್ತಗಳನ್ನು ಮರುಹೊಂದಿಸಿ';

  @override
  String get currencyChangeWarning =>
      'ಮುದ್ರೆ ಬದಲಾಗುತ್ತಿದೆ. ಇರುವ ಮೊತ್ತಗಳಿಗೆ ಏನು ಮಾಡಬೇಕು?';

  @override
  String get listsEmpty =>
      'ಇನ್ನೂ ಯಾವುದೇ ಪಟ್ಟಿಗಳಿಲ್ಲ. ನಿಮ್ಮ ಮೊದಲ ಖರೀದಿ ಯೋಜನೆಯನ್ನು ರಚಿಸಿ.';

  @override
  String get statusDraft => 'ಡ್ರಾಫ್ಟ್';

  @override
  String get statusPlanned => 'ಯೋಜಿತ';

  @override
  String get statusShopping => 'ಖರೀದಿ ಮಾಡುತ್ತಿದ್ದಾರೆ';

  @override
  String get statusCompleted => 'ಪೂರ್ಣಗೊಂಡಿದೆ';

  @override
  String get statusArchived => 'ಆರ್ಕೈವ್ ಮಾಡಲಾಗಿದೆ';

  @override
  String autoListTitle(String date) {
    return '$date ಖರೀದಿ';
  }

  @override
  String get itemFormTitle => 'ವಸ್ತುವನ್ನು ಸೇರಿಸಿ';

  @override
  String get itemNameLabel => 'ವಸ್ತುವಿನ ಹೆಸರು';

  @override
  String get brandLabel => 'ಬ್ರಾಂಡ್ / ರೂಪಾಂತರ (ಐಚ್ಛಿಕ)';

  @override
  String get categoryLabel => 'ವರ್ಗ';

  @override
  String get quantityLabel => 'ಪರಿಮಾಣ';

  @override
  String get unitLabel => 'ಘಟಕ';

  @override
  String get pricingModeLabel => 'ಬೆಲೆ ನಮೂದು';

  @override
  String get pricingModeUnitPrice => 'ಘಟಕ ಬೆಲೆ';

  @override
  String get pricingModeLineTotal => 'ಲೈನ್ ಒಟ್ಟು';

  @override
  String get plannedPriceLabel => 'ಯೋಜಿತ ಬೆಲೆ';

  @override
  String lineTotalCalculated(String value) {
    return 'ಲೈನ್ ಒಟ್ಟು: $value';
  }

  @override
  String get requiredItemToggle => 'ಅಗತ್ಯ ವಸ್ತು';

  @override
  String get maxPriceLabel => 'ಗರಿಷ್ಠ ಸ್ವೀಕಾರಾರ್ಹ ಬೆಲೆ (ಐಚ್ಛಿಕ)';

  @override
  String get itemNoteLabel => 'ಟಿಪ್ಪಣಿ (ಐಚ್ಛಿಕ)';

  @override
  String get categoryProduce => 'ಹಣ್ಣು & ತರಕಾರಿಗಳು';

  @override
  String get categoryDairy => 'ಡೇರಿ';

  @override
  String get categoryMeat => 'ಮಾಂಸ';

  @override
  String get categoryBakery => 'ಬೇಕರಿ';

  @override
  String get categoryDrinks => 'ಪಾನೀಯಗಳು';

  @override
  String get categoryCleaning => 'ಶುಚಿಗೊಳಿಸುವಿಕೆ';

  @override
  String get categoryPersonalCare => 'ವೈಯಕ್ತಿಕ ಪಾಲನೆ';

  @override
  String get categoryHome => 'ಮನೆ';

  @override
  String get categoryOther => 'ಇತರೆ';

  @override
  String get invalidQuantityError => 'ಅಮಾನ್ಯ ಪರಿಮಾಣ';

  @override
  String get invalidPriceError => 'ಅಮಾನ್ಯ ಬೆಲೆ';

  @override
  String get invalidNameError => 'ಹೆಸರನ್ನು ನಮೂದಿಸಿ';

  @override
  String unitPriceCalculated(String value) {
    return 'ಏಕಮಾನ ಬೆಲೆ: $value';
  }

  @override
  String get shoppingTitle => 'ಖರೀದಿ ಮೋಡ್';

  @override
  String get summaryPlannedTotal => 'ಯೋಜಿತ';

  @override
  String get summaryInCart => 'ಕಾರ್ಟ್‌ನಲ್ಲಿ';

  @override
  String get summaryRemainingPlan => 'ಬಾಕಿ ಯೋಜನೆ';

  @override
  String get summaryProjected => 'ಅಂದಾಜು ಚೆಕ್‌ಔಟ್';

  @override
  String get summaryBudgetRemaining => 'ಬಜೆಟ್ ಉಳಿದಿದೆ';

  @override
  String get summaryBudgetOver => 'ಬಜೆಟ್ ಮೀರಿದೆ';

  @override
  String itemsProgress(String done, String total) {
    return '$total ವಸ್ತುಗಳಲ್ಲಿ $done';
  }

  @override
  String get filterAll => 'ಎಲ್ಲವೂ';

  @override
  String get filterToBuy => 'ಖರೀದಿಸಬೇಕಾದವು';

  @override
  String get filterInCart => 'ಕಾರ್ಟ್‌ನಲ್ಲಿ';

  @override
  String get filterNotFound => 'ಸಿಗಲಿಲ್ಲ';

  @override
  String get filterRequired => 'ಅಗತ್ಯ';

  @override
  String get quickEntryTitle => 'ನೈಜ ಬೆಲೆ';

  @override
  String get actualQuantityLabel => 'ನೈಜ ಪ್ರಮಾಣ';

  @override
  String get actualPriceLabel => 'ನೈಜ ಬೆಲೆ';

  @override
  String get discountLabel => 'ತಗ್ಗು (ಐಚ್ಛಿಕ)';

  @override
  String get alternativeNameLabel => 'ಪರ್ಯಾಯ ಉತ್ಪನ್ನದ ಹೆಸರು (ಐಚ್ಛಿಕ)';

  @override
  String get savePurchaseButton => 'ಕಾರ್ಟ್‌ಗೆ ಸೇರಿಸಿ';

  @override
  String get unplannedAddButton => 'ಯೋಜಿತವಲ್ಲದ ವಸ್ತುವನ್ನು ಸೇರಿಸಿ';

  @override
  String get statusPending => 'ತೆಗೆದುಕೊಂಡಿಲ್ಲ';

  @override
  String get statusInCart => 'ಕಾರ್ಟ್‌ನಲ್ಲಿ';

  @override
  String get statusNotFound => 'ಸಿಗಲಿಲ್ಲ';

  @override
  String get statusGaveUp => 'ಬಿಟ್ಟಿದ್ದೇವೆ';

  @override
  String get statusAlternative => 'ಪರ್ಯಾಯ ಖರೀದಿಸಲಾಗಿದೆ';

  @override
  String get keepScreenAwake => 'ತೆರೆ ಆನ್ ಇರಿಸಿ';

  @override
  String get finishShopping => 'ಖರೀದಿ ಮುಗಿಸಿ';

  @override
  String get completionWarning =>
      'ಕೆಲವು ದಾಖಲೆಗಳು ಕೊರತೆಯಿವೆ ಅಥವಾ ಪರಿಶೀಲಿಸಲ್ಪಡಲಾಗಿಲ್ಲ. ನೀವು ಮುಂದುವರಿಯಬಹುದು; ಫಲಿತಾಂಶದಲ್ಲಿ ಅವುಗಳನ್ನು ಗಮನಿಸಲಾಗುತ್ತದೆ.';

  @override
  String get continueShoppingButton => 'ಖರೀದಿ ಮುಂದುವರಿಸಿ';

  @override
  String get resultTitle => 'ಫಲಿತಾಂಶ';

  @override
  String get summarySection => 'ಸಾರಾಂಶ';

  @override
  String get plannedTotalLabel => 'ಯೋಜಿತ ಒಟ್ಟು';

  @override
  String get actualTotalLabel => 'ನೈಜ ಒಟ್ಟು';

  @override
  String get varianceLabel => 'ವ್ಯತ್ಯಾಸ';

  @override
  String get varianceNotComputable => 'ಲೆಕ್ಕಾಚಾರ ಮಾಡಲು ಸಾಧ್ಯವಿಲ್ಲ';

  @override
  String get budgetStatusLabel => 'ಬಜೆಟ್';

  @override
  String get savingsLabel => 'ಯೋಜನೆಗಿಂತ ಕಡಿಮೆ';

  @override
  String get overspendLabel => 'ಯೋಜನೆಗಿಂತ ಹೆಚ್ಚು';

  @override
  String get unplannedTotalLabel => 'ಯೋಜಿತವಲ್ಲದ ಒಟ್ಟು';

  @override
  String get unpurchasedLabel => 'ಯೋಜಿಸಲಾಗಿದೆ ಆದರೆ ಖರೀದಿಸಿಲ್ಲ';

  @override
  String get totalDiscountLabel => 'ಒಟ್ಟು ತಗ್ಗುಗಳು';

  @override
  String get accuracyLabel => 'ಅಂದಾಜಿನ ನಿಖರತೆ';

  @override
  String get groupsSection => 'ವಸ್ತುಗಳು';

  @override
  String get groupPricier => 'ಯೋಜಿತಕ್ಕಿಂತ ದುಬಾರಿ';

  @override
  String get groupCheaper => 'ಯೋಜಿತಕ್ಕಿಂತ ಕಡಿಮೆ ಬೆಲೆ';

  @override
  String get groupClose => 'ಅಂದಾಜಿಗೆ ಹತ್ತಿರ';

  @override
  String get groupNotTaken => 'ಯೋಜಿಸಲಾಗಿದೆ, ಖರೀದಿಸಿಲ್ಲ';

  @override
  String get groupUnplanned => 'ಯೋಜನೆ ಇಲ್ಲದೆ ಖರೀದಿಸಲಾಗಿದೆ';

  @override
  String get groupQuantityChanged => 'ಪ್ರಮಾಣ ಬದಲಾಗಿದೆ';

  @override
  String get groupUnverified => 'ಪರಿಶೀಲಿಸಲಾಗಿಲ್ಲ';

  @override
  String get plannedQtyLabel => 'ಯೋಜಿತ ಪ್ರಮಾಣ';

  @override
  String get actualQtyLabel => 'ನೈಜ ಪ್ರಮಾಣ';

  @override
  String get plannedUnitPriceLabel => 'ಯೋಜಿತ ಏಕಮಾನ ಬೆಲೆ';

  @override
  String get actualUnitPriceLabel => 'ನೈಜ ಏಕಮಾನ ಬೆಲೆ';

  @override
  String get lineVarianceLabel => 'ಲೈನ್ ವ್ಯತ್ಯಾಸ';

  @override
  String get discountEffectLabel => 'ತಗ್ಗಿನ ಪರಿಣಾಮ';

  @override
  String get notBoughtMark => 'ಖರೀದಿಸಿಲ್ಲ';

  @override
  String get noPurchasesNote => 'ಯಾವುದೇ ಖರೀದಿ ದಾಖಲಿಸಲಾಗಿಲ್ಲ.';

  @override
  String get navHome => 'ಮುಖಪುಟ';

  @override
  String get navLists => 'ಪಟ್ಟಿಗಳು';

  @override
  String get navHistory => 'ಇತಿಹಾಸ';

  @override
  String get navSettings => 'ಸೆಟ್ಟಿಂಗ್‌ಗಳು';

  @override
  String get homeEmptyTitle => 'ನಿಮ್ಮ ಖರೀದಿಯನ್ನು ಯೋಜಿಸಿ';

  @override
  String get homeEmptyBody =>
      'ನಿಮ್ಮ ಮೊದಲ ಪಟ್ಟಿಯನ್ನು ರಚಿಸಿ ಮತ್ತು ನಿಗದಿತ vs ನೈಜ ವೆಚ್ಚಗಳನ್ನು ಹೋಲಿಕೆ ಮಾಡಿ.';

  @override
  String get homeActiveSection => 'ಸಕ್ರಿಯ ಪಟ್ಟಿಗಳು';

  @override
  String get homeCompletedSection => 'ಇತ್ತೀಚೆಗೆ ಪೂರ್ಣಗೊಂಡವು';

  @override
  String get homeMonthlySection => 'ಈ ತಿಂಗಳು';

  @override
  String get monthPlannedLabel => 'ಯೋಜಿತ';

  @override
  String get monthActualLabel => 'ನೈಜ';

  @override
  String get monthVarianceLabel => 'ವ್ಯತ್ಯಾಸ';

  @override
  String get continueShoppingLabel => 'ಖರೀದಿ ಮುಂದುವರಿಸಿ';

  @override
  String get historyEmpty =>
      'ಇನ್ನೂ ಯಾವುದೇ ಪೂರ್ಣಗೊಂಡ ಖರೀದಿ ಇಲ್ಲ. ನಿಮ್ಮ ಇತಿಹಾಸ ಮತ್ತು ಅಂತರ್ದೃಷ್ಟಿ ಇಲ್ಲಿ ಕಾಣಿಸುತ್ತದೆ.';

  @override
  String get aboutTabTitle => 'NShoptor ಬಗ್ಗೆ';

  @override
  String get aboutBody =>
      'Crazy Penguin ನಿಂದ NShoptor. ಆಫ್‌ಲೈನ್-ಮೊದಲು ಖರೀದಿ ಯೋಜಕ. GPL-3.0 ಅಡಿಯಲ್ಲಿ لایسنسد.';

  @override
  String get startShoppingLabel => 'ಖರೀದಿ ಪ್ರಾರಂಭಿಸಿ';

  @override
  String get finishAndSeeResult => 'ಅಂತ್ಯಗೊಳಿಸಿ & ಫಲಿತಾಂಶ ನೋಡಿ';

  @override
  String get settingsTitle => 'ಸೆಟ್ಟಿಂಗ್‌ಗಳು';

  @override
  String get languageLabel => 'ಭಾಷೆ';

  @override
  String get languageSystem => 'ಸಿಸ್ಟಮ್';

  @override
  String get languageTr => 'ಟರ್ಕಿಶ್';

  @override
  String get languageEn => 'ಇಂಗ್ಲಿಷ್';

  @override
  String get themeLabel => 'ಥೀಮ್';

  @override
  String get themeSystem => 'ಸಿಸ್ಟಮ್';

  @override
  String get themeLight => 'ಬೆಳಕು';

  @override
  String get themeDark => 'ಕತ್ತಲು';

  @override
  String get defaultCurrencyLabel => 'ಡಿಫಾಲ್ಟ್ ಮುದ್ರೆ';

  @override
  String get defaultUnitLabel => 'ಡಿಫಾಲ್ಟ್ ಏಕಮಾನ';

  @override
  String get keepAwakeLabel => 'ಖರೀದಿ ಮಾಡುವಾಗ ಸ್ಕ್ರೀನ್ ಆನ್ ಇರಿಸಿ';

  @override
  String get backupSection => 'ಬ್ಯಾಕಪ್';

  @override
  String get exportBackupLabel => 'ಬ್ಯಾಕಪ್ ಎಕ್ಸ್‌ಪೋರ್ಟ್ ಮಾಡಿ';

  @override
  String get importBackupLabel => 'ಬ್ಯಾಕಪ್ ಇಂಪೋರ್ಟ್ ಮಾಡಿ';

  @override
  String get mergeImportLabel => 'ಪ್ರಸ್ತುತ ಡೇಟಾದೊಂದಿಗೆ ವಿಲೀನಗೊಳಿಸಿ';

  @override
  String get separateImportLabel => 'ಪृಥಕ್ ಪ್ರತಿಯಾಗಿ ಇಂಪೋರ್ಟ್ ಮಾಡಿ';

  @override
  String get importCancelled => 'ಇಂಪೋರ್ಟ್ ರದ್ದುಗೊಂಡಿದೆ.';

  @override
  String get backupExported => 'ಬ್ಯಾಕಪ್ ಯಶಸ್ವಿಯಾಗಿ ಎಕ್ಸ್‌ಪೋರ್ಟ್ ಆಗಿದೆ.';

  @override
  String get backupSizeWarning =>
      'ದೊಡ್ಡ ಬ್ಯಾಕಪ್: ಫೈಲ್ ದೊಡ್ಡದಾಗಿರಬಹುದು. ಫೋಟೋಗಳನ್ನೂ ಸೇರಿಸಬೇಕೇ?';

  @override
  String get deleteAllSection => 'ಅಪಾಯಕಾರಿ ವಲಯ';

  @override
  String get deleteAllLabel => 'ಎಲ್ಲಾ ಡೇಟಾ ಅಳಿಸಿ';

  @override
  String get deleteAllConfirm =>
      'ಇದು ಎಲ್ಲಾ ಪಟ್ಟಿಗಳು, ಇತಿಹಾಸ, ರಿಸೀಪ್ಟ್ ಫೋಟೋಗಳು ಮತ್ತು ಬೆಲೆಗಳನ್ನು ತೆಗೆದುಹಾಕುತ್ತದೆ. ನೀವು ಎಕ್ಸ್‌ಪೋರ್ಟ್ ಮಾಡಿದ ಫೈಲ್‌ಗಳು ನಿಮ್ಮ ಡ್ರೈವ್‌ನಲ್ಲಿ ಉಳಿಯುತ್ತವೆ. ಮುಂದುವರೆಯುವುದೇ?';

  @override
  String get deleteAllConfirm2 =>
      'ನಿಮಗೆ ಸಂಪೂರ್ಣವಾಗಿ ಖಚಿತವೇ? ಈ ಕ್ರಿಯೆಯನ್ನು ಹಿಂತೆಗೆದುಕೊಳ್ಳಲು ಸಾಧ್ಯವಿಲ್ಲ.';

  @override
  String get cancelAction => 'ರದ್ದುಗೊಳಿಸಿ';

  @override
  String get confirmDelete => 'ಸ್ಥಾಯಿಯಾಗಿ ಅಳಿಸಿ';

  @override
  String get dataDeleted => 'ಎಲ್ಲಾ ಸ್ಥಳೀಯ ಡೇಟಾ ಅಳಿಸಲಾಗಿದೆ.';

  @override
  String get privacyInfoLabel => 'ಗೌಪ್ಯತೆ';

  @override
  String get privacyInfoBody =>
      'ನಿಮ್ಮ ಪಟ್ಟಿಗಳು, ಬೆಲೆಗಳು, ರಿಸೀಪ್ಟ್‌ಗಳು ಮತ್ತು ಫೋಟೋಗಳು ನಿಮ್ಮ ಸಾಧನದಲ್ಲಿಯೇ ಉಳಿಯುತ್ತವೆ. ಫೋಟೋಗಳು ಮತ್ತು ಧ್ವನಿ ಅವುಗಳಿಂದ ಎಂದಿಗೂ ಹೊರಹೋಗುವುದಿಲ್ಲ. AI ಸಹಾಯ ಸಕ್ರಿಯವಾಗಿದ್ದಾಗ, ಪಠ್ಯ ಮಾತ್ರ (ಉದಾಹರಣೆಗೆ ರಿಸೀಪ್ಟ್‌ನ ಸಾಲುಗಳು ಅಥವಾ ನೀವು ಹೇಳಿದ ವಿಷಯ) ಪ್ರಕ್ರಿಯೆಗಾಗಿ ನಮ್ಮ ಸರ್ವರ್‌ಗೆ ಕಳುಹಿಸಲಾಗುತ್ತದೆ ಮತ್ತು ಸಂಗ್ರಹಿಸಲಾಗುವುದಿಲ್ಲ.';

  @override
  String get aboutSection => 'ಬಗ್ಗೆ';

  @override
  String get aboutPublisher => 'ಪಬ್ಲಿಷರ್: Crazy Penguin';

  @override
  String get aboutLicenses => 'ಲೈಸೆನ್ಸ್‌ಗಳು (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'ಧ್ವನಿ ಇನ್‌ಪುಟ್';

  @override
  String get voiceStatusUnknown => 'ಸೇವೆ: ಪರಿಶೀಲಿಸಿಲ್ಲ';

  @override
  String get permissionsLabel => 'ಅನುಮತಿಗಳು';

  @override
  String get permissionsBody =>
      'ಕ್ಯಾಮೆರಾ, ಮೈಕ್ರೋಫೋನ್ ಮತ್ತು ಅಧಿಸೂಚನೆಗಳು ನಿಜವಾಗಿ ಆ ಫೀಚರ್‌ಗಳನ್ನು ಬಳಸುವಾಗ ಮಾತ್ರ ಕೇಳಲಾಗುತ್ತದೆ.';

  @override
  String get unitsSection => 'ಡಿಫಾಲ್ಟ್‌ಗಳು';

  @override
  String get roundingNote =>
      'ಹಣದ ರೌಂಡಿಂಗ್ ಒಂದೇ ನಿಯಮವನ್ನು ಅನುಸರಿಸುತ್ತದೆ: ಶೂನ್ಯದಿಂದ ದೂರಕ್ಕೆ ಅರ್ಧಗಳು ರೌಂಡ್ ಆಗುತ್ತವೆ, Money ಪರಿವರ್ತನೆಯಲ್ಲಿ ಒಮ್ಮೆ ಮಾತ್ರ ಅನ್ವಯಿಸಲಾಗುತ್ತದೆ.';

  @override
  String get voiceInputTitle => 'ಧ್ವನಿ ಇನ್‌ಪುಟ್';

  @override
  String get voiceStartListening => 'ಕೇಳಲು ಪ್ರಾರಂಭಿಸಿ';

  @override
  String get voiceTranscriptLabel => 'ಟ್ರಾನ್ಸ್ಕ್ರಿಪ್ಟ್';

  @override
  String get parseAction => 'ವಿಶ್ಲೇಷಿಸಿ';

  @override
  String get receiptReviewTitle => 'ರಿಸೀಪ್ಟ್ ಪರಿಶೀಲಿಸಿ';

  @override
  String get receiptTotal => 'ರಿಸೀಪ್ಟ್ ಒಟ್ಟು';

  @override
  String get receiptTotalUnknown => 'ಒಟ್ಟು ಪತ್ತೆಯಾಗಿಲ್ಲ';

  @override
  String get receiptDiff => 'ವ್ಯತ್ಯಾಸ';

  @override
  String get acceptLine => 'ಲೈನ್ ಅಂಗೀಕರಿಸಿ';

  @override
  String get ignoreLine => 'ಲೈನ್ ನಿರ್ಲಕ್ಷಿಸಿ';

  @override
  String get receiptLineActions =>
      'ಆಯತಕ್ಕೆ ಸಂಪರ್ಕಿಸಿ, ವಿಭಜಿಸಿ ಅಥವಾ ನಿರ್ಲಕ್ಷಿಸಿ';

  @override
  String get receiptCommit => 'ಎಲ್ಲವನ್ನೂ ಅಂಗೀಕರಿಸಿ';

  @override
  String get receiptCommitted => 'ರಿಸೀಪ್ಟ್ ಅನ್ವಯಿಸಲಾಗಿದೆ.';

  @override
  String get priceHistoryTitle => 'ಬೆಲೆ ಇತಿಹಾಸ';

  @override
  String get noObservations => 'ಇನ್ನೂ ಯಾವುದೇ ಬೆಲೆ ವೀಕ್ಷಣೆಗಳಿಲ್ಲ';

  @override
  String get templatesSection => 'ಟೆಂಪ್ಲೇಟ್‌ಗಳು';

  @override
  String get templateHint => 'ಹಿಂದಿನ ಶಾಪಿಂಗ್ ಪ್ರಯಾಣದಿಂದ ಹೊಸ ಯೋಜನೆಯನ್ನು ರಚಿಸಿ';

  @override
  String get scanReceiptAction => 'ರಿಸೀಪ್ಟ್ ಸ್ಕ್ಯಾನ್ ಮಾಡಿ';

  @override
  String get shelfLabelAction => 'ಶೆಲ್ಫ್ ಲೇಬಲ್‌ನಿಂದ ಬೆಲೆ';

  @override
  String get priceCandidatesTitle => 'ಬೆಲೆ ಅಭ್ಯರ್ಥಿಗಳು';

  @override
  String get noPriceCandidates => 'ಯಾವುದೇ ಬೆಲೆ ಕಂಡುಬಂದಿಲ್ಲ; ಕೈಯಾರೆ ನಮೂದಿಸಿ.';

  @override
  String get voiceUnavailable => 'ಮಾತು ಗುರುತಿಸುವಿಕೆ ಲಭ್ಯವಿಲ್ಲ; ಕೈಯಾರೆ ನಮೂದಿಸಿ.';

  @override
  String get linkToItem => 'ಆಯತಕ್ಕೆ ಸಂಪರ್ಕಿಸಿ';

  @override
  String get splitLine => 'ಎರಡಾಗಿ ವಿಭಜಿಸಿ';

  @override
  String get mergeWithNext => 'ಮುಂದಿನದರೊಂದಿಗೆ ವಿಲೀನಗೊಳಿಸಿ';

  @override
  String get ocrNoText => 'ಯಾವುದೇ ಪಠಣೆ ಓದಲಾಗಿಲ್ಲ; ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get priceHistoryAction => 'ಬೆಲೆ ಇತಿಹಾಸ';

  @override
  String get itemsEmptyTitle => 'ಇನ್ನೂ ಯಾವುದೇ ಆಯತಗಳಿಲ್ಲ';

  @override
  String get itemsEmptyBody =>
      'ನಿಮ್ಮ ಮೊದಲ ಆಯತವನ್ನು ಸೇರಿಸಿ — ದುಕಾನದಲ್ಲಿ ನೀವು ನಿಜವಾದ ಬೆಲೆಗಳನ್ನು ಇಲ್ಲಿ ನಮೂದಿಸುತ್ತೀರಿ.';

  @override
  String get addItemTooltip => 'ಆಯತ ಸೇರಿಸಿ';

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
  String get unitCustom => 'ಕಸ್ಟಮ್';

  @override
  String get setReminderAction => 'ಅನುಸ್ಮರಣೆ ಸೆಟ್ ಮಾಡಿ';

  @override
  String get reminderPermissionDenied =>
      'ಅನುಸ್ಮರಣೆಗಳಿಗೆ ಸೂಚನೆ ಅನುಮತಿ ಬೇಕಾಗುತ್ತದೆ. ನೀವು ವ್ಯವಸ್ಥೆ ಸೆಟ್ಟಿಂಗ್‌ಗಳಲ್ಲಿ ಇದನ್ನು ಸಕ್ರಿಯಗೊಳಿಸಬಹುದು.';

  @override
  String get reminderScheduled => 'ಅನುಸ್ಮರಣೆ ಸೆಟ್ ಆಗಿದೆ.';

  @override
  String get reminderCancelled => 'ಅನುಸ್ಮರಣೆ ತೆಗೆದುಹಾಕಲಾಗಿದೆ.';

  @override
  String get reminderTitle => 'ಶಾಪಿಂಗ್ ಅನುಸ್ಮರಣೆ';

  @override
  String reminderBody(Object title) {
    return 'ನಿಮ್ಮ ಪಟ್ಟಿ ಪರಿಶೀಲಿಸಲು ಸಮಯ: $title';
  }

  @override
  String get reminderPickDate => 'ದಿನಾಂಕ ಆಯ್ಕೆ ಮಾಡಿ';

  @override
  String get reminderPickTime => 'ಸಮಯ ಆಯ್ಕೆ ಮಾಡಿ';

  @override
  String get itemDetailsSection => 'ವಿವರಗಳು';

  @override
  String get priceOptionalHint =>
      'ಐಚ್ಛಿಕ — ದುಕಾನದಲ್ಲಿ ನೀವು ನಿಜವಾದ ಬೆಲೆಯನ್ನು ನಮೂದಿಸುತ್ತೀರಿ';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'ಯೋಜಿತ: $total · $count ಆಯತಗಳು';
  }

  @override
  String get proActiveLabel => 'Pro ಸಕ್ರಿಯ — ಧನ್ಯವಾದಗಳು!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'ಯಾವುದೇ ವಿಜ್ಞಾಪನೆಗಳು, ಹೆಚ್ಚಿನ AI, ಬ್ಯಾಕಪ್ · ಚಿಕ್ಕ ತಿಂಗಳ ಬೆಲೆಯಿಂದ';

  @override
  String get proBenefitNoAds => 'ವಿಜ್ಞಾಪನೆ-ರಹಿತ ಅನುಭವ';

  @override
  String get proBenefitBackup => 'ಬ್ಯಾಕಪ್ (ಎಕ್ಸ್‌ಪೋರ್ಟ್/ಇಂಪೋರ್ಟ್)';

  @override
  String aboutVersion(Object version) {
    return 'ವರ್ಷನ್ $version';
  }

  @override
  String get navDiscover => 'ಕಂಡುಹಿಡಿಯಿರಿ';

  @override
  String get shareAction => 'ಆ್ಯಪ್ ಅನ್ನು ಹಂಚಿಕೊಳ್ಳಿ';

  @override
  String get rateAction => 'ನಮಗೆ ರೇಟ್ ಮಾಡಿ';

  @override
  String get aboutOpenRow => 'ಬಗ್ಗೆ ಮತ್ತು ಓಪನ್ ಸೋರ್ಸ್';

  @override
  String get voiceAddItemAction => 'ಮಾತಿನಿಂದ ಸೇರಿಸಿ';

  @override
  String get formatLocaleLabel => 'ಸಂಖ್ಯೆ ಮತ್ತು ನಾಣ್ಯ ರೂಪ';

  @override
  String get formatLocaleSystem =>
      'ಸಾಧನದ ರೂಪ (ಲ್ಯಾಟಿನ್ ಅಂಕಿಗಳು; ಇಲ್ಲದಿದ್ದರೆ ಇಂಗ್ಲಿಷ್)';

  @override
  String get formatLocaleTr => 'ಟರ್ಕಿಶ್ (1.234,56)';

  @override
  String get formatLocaleEn => 'ಇಂಗ್ಲಿಷ್ (1,234.56)';

  @override
  String get aiToggleTitle => 'AI ಸಹಾಯ';

  @override
  String get aiToggleSubtitle =>
      'ರಿಸೀಟ್‌ಗಳನ್ನು ಹೊಂದಿಸುತ್ತದೆ, ಬೆಲೆ ಲೇಬಲ್‌ಗಳನ್ನು padlysuttadeva and sentences into lists. Photos and voice stay on your device; only text is processed.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'ನೀವು ಈ ತಿಂಗಳ AI ವಿನಂತಿಗಳನ್ನು ($used/$limit) ಬಳಸಿದ್ದೀರಿ. ಹೆಚ್ಚಿನದಕ್ಕಾಗಿ ಅಪ್‌ಗ್ರೇಡ್ ಮಾಡಿ ಅಥವಾ AI ಇಲ್ಲದೆ ಮುಂದುವರಿಯಿರಿ.';
  }

  @override
  String get aiOffline => 'ಸಂಪರ್ಕ ಇಲ್ಲ — AI ಇಲ್ಲದೆ ಮುಂದುವರಿಯುತ್ತಿದೆ.';

  @override
  String get aiFailed => 'AI ಈಗ ಲಭ್ಯವಿಲ್ಲ — ಅದನ್ನು ಬಿಟ್ಟು ಮುಂದುವರಿಯುತ್ತಿದೆ.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'ಸಾಧನ';

  @override
  String get quickListAction => 'ಒಂದು ವಾಕ್ಯದಿಂದ ಸೇರಿಸಿ';

  @override
  String get quickListTitle => 'ತ್ವರಿತ ಪಟ್ಟಿ';

  @override
  String get quickListHint =>
      'ಉದಾ: 1 kg apples 20, 2 breads, half a kilo of cheese';

  @override
  String get quickListConvert => 'ಪಟ್ಟಿಗೆ ಪರಿವರ್ತಿಸಿ';

  @override
  String quickListAdd(int count) {
    return '$count ವಸ್ತುಗಳನ್ನು ಸೇರಿಸಿ';
  }

  @override
  String get quickListEmpty =>
      'ಯಾವುದೇ ವಸ್ತುಗಳು ಕಂಡುಬಂದಿಲ್ಲ. ಅವುಗಳನ್ನು ಕಾಮಾ ವಿಭಜನೆಗಳಿಂದ ಪಟ್ಟಿ ಮಾಡಲು ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get receiptAiMatched =>
      'AI ನಿಮ್ಮ ಪಟ್ಟಿಗೆಗೆ ರಿಸೀಟ್ ಅನ್ನು ಹೊಂದಿಸಿದೆ. ಸಂಪರ್ಕಗಳನ್ನು ಪರಿಶೀಲಿಸಿ ಮತ್ತು ದೃಢೀಕರಿಸಿ.';

  @override
  String get receiptNeedsCheck => 'ಈ ಹೊಂದಾಣಿಕೆಯನ್ನು ಪರಿಶೀಲಿಸಿ';

  @override
  String get receiptDiscountLine => 'ತಗ್ಗು';

  @override
  String get compareItem => 'ವಸ್ತು';

  @override
  String get compareEstimated => 'ಅಂದಾಜು';

  @override
  String get compareActual => 'ನೈಜ';

  @override
  String get compareDiff => 'ವ್ಯತ್ಯಾಸ';

  @override
  String get compareTotal => 'ಒಟ್ಟು';

  @override
  String get compareBudget => 'ಬಜೆಟ್';

  @override
  String get compareNotBought => 'ಖರೀದಿಸಲಾಗಿಲ್ಲ';

  @override
  String get compareUnplanned => 'ಯೋಜಿಸಲಾಗಿಲ್ಲ';

  @override
  String get pricierItems => 'ಹೆಚ್ಚು ಬೆಲೆ';

  @override
  String get cheaperItems => 'ಕಡಿಮೆ ಬೆಲೆ';

  @override
  String get compareAction => 'ಹೋಲಿಕೆ';

  @override
  String get detailsSection => 'ವಿವರಗಳು';

  @override
  String get spendingTitle => 'ಖರ್ಚು';

  @override
  String get spendingAction => 'ಖರ್ಚು';

  @override
  String get spendingMonthTotal => 'ಈ ತಿಂಗಳು';

  @override
  String get spendingWeekly => 'ವಾರದ ಖರ್ಚು';

  @override
  String get spendingMonthly => 'ತಿಂಗಳ ಖರ್ಚು';

  @override
  String get monthlyLimitTitle => 'ತಿಂಗಳ ಮಿತಿ';

  @override
  String get monthlyLimitHelp =>
      'ತಿಂಗಳಿಗೆ ಗ್ರೋಸರಿ ಖರೀದಿಗೆ ಎಷ್ಟು ಖರ್ಚು ಮಾಡಬೇಕು?';

  @override
  String get monthlyLimitRemove => 'ತೆಗೆದುಹಾಕಿ';

  @override
  String get monthlyLimitSet => 'ನಿಗದಿಪಡಿಸಿ';

  @override
  String get monthlyLimitChange => 'ಬದಲಾಯಿಸಿ';

  @override
  String get monthlyLimitNone =>
      'ಉಳಿದಿರುವುದನ್ನು ನೋಡಲು ತಿಂಗಳ ಮಿತಿಯನ್ನು ನಿಗದಿಪಡಿಸಿ.';

  @override
  String monthlyLimitOver(String amount) {
    return 'ಮಿತಿಯಿಂದ $amount ಹೆಚ್ಚು';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return 'ಈ ತಿಂಗಳು $amount ಉಳಿದಿದೆ';
  }

  @override
  String get plansTitle => 'ಯೋಜನೆಗಳು';

  @override
  String get plansHeadline => 'AI ಜೊತೆ ಬುದ್ಧಿವಂತಾಗಿ ಶಾಪಿಂಗ್ ಮಾಡಿ';

  @override
  String get plansSubhead =>
      'ರಿಸೀಟ್ ಹೊಂದಾಣಿಕೆ, ಬೆಲೆ ಲೇಬಲ್‌ಗಳು ಮತ್ತು ವಾಕ್ಯದಿಂದ ಪಟ್ಟಿಗಳು. ಯಾವಾಗಲಾದರೂ ರದ್ದು ಮಾಡಿ.';

  @override
  String get plansMonthly => 'ತಿಂಗಳಿಗೆ';

  @override
  String get plansYearly => 'ವಾರ್ಷಿಕ';

  @override
  String get planFree => 'ಮುಕ್ತ';

  @override
  String get planFreePrice => 'ಎಂದಿಗೂ ಮುಕ್ತ';

  @override
  String get planFreeAi => 'ತಿಂಗಳಿಗೆ 10 AI ವಿನಂತಿಗಳು';

  @override
  String get planFreeAds =>
      'ಚಿಕ್ಕ ಬ್ಯಾನರ್ ವಿಜ್ಞಾಪನೆಗಳು (ಮೊದಲ 7 ದಿನಗಳಲ್ಲಿ ಯಾವುದೂ ಇಲ್ಲ)';

  @override
  String get planCoreFeatures =>
      'ಪಟ್ಟಿಗಳು, ಬೆಲೆಗಳು, ರಿಸೀಟ್‌ಗಳು, ಖರ್ಚು ಚಾರ್ಟ್‌ಗಳು';

  @override
  String get plansPerYear => '/ ವರ್ಷ';

  @override
  String get plansPerMonth => '/ ತಿಂಗಳು';

  @override
  String get planTrial => '7 ದಿನಗಳು ಮುಕ್ತ';

  @override
  String get planProAi => 'ತಿಂಗಳಿಗೆ 100 AI ವಿನಂತಿಗಳು';

  @override
  String get planNoAds => 'ಯಾವುದೇ ವಿಜ್ಞಾಪನೆಗಳಿಲ್ಲ';

  @override
  String get planBackup => 'ಬ್ಯಾಕಪ್ ರಫ್ತು ಮತ್ತು ಆಮದು';

  @override
  String get planMaxAi => 'ತಿಂಗಳಿಗೆ 300 AI ಅನುರೋಧಗಳು';

  @override
  String get planMaxFamily => 'ದೊಡ್ಡ ಕುಟುಂಬದ ಖರೀದಿಗೆ';

  @override
  String get plansStoreUnavailable => 'ಸ್ಟೋರ್ ಈಗ ಪ್ರವೇಶಿಸಲು ಸಾಧ್ಯವಿಲ್ಲ.';

  @override
  String get retryAction => 'ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ';

  @override
  String get plansPurchaseFailed =>
      'ಖರೀದಿ ಯಶಸ್ವಿಯಾಗಿಲ್ಲ. ದಯವಿಟ್ಟು ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get planLifetimeTitle => 'ಜೀವಮಾನದವರೆಗೆ ವಿಜ್ಞಾಪನೆಗಳಿಲ್ಲ';

  @override
  String get planLifetimeSubtitle =>
      'ಒಮ್ಮೆ ಪಾವತಿ: ವಿಜ್ಞಾಪನೆಗಳಿಲ್ಲ, ಬ್ಯಾಕಪ್; AI ನಿಃಶುಲ್ಕ ವ್ಯಾಪ್ತಿಯಲ್ಲಿರುತ್ತದೆ';

  @override
  String get plansRestore => 'ಖರೀದಿಗಳನ್ನು ಮರುಸ್ಥಾಪಿಸಿ';

  @override
  String get plansLegal =>
      'ರದ್ದು ಮಾಡುವವರೆಗೆ ಚಂದಾದಾರಿಕೆಗಳು ಸ್ವಯಂಚಾಲಿತವಾಗಿ ನವೀಕರಿಸುತ್ತವೆ. Google Play › ಪಾವತಿಗಳು ಮತ್ತು ಚಂದಾದಾರಿಕೆಯಲ್ಲಿ ಯಾವುದೇ ಸಮಯದಲ್ಲಿ ರದ್ದು ಮಾಡಬಹುದು. ಬೆಲೆಗಳಲ್ಲಿ Google Play ತೋರಿಸಿದ ತೆರಿಗೆಗಳು ಸೇರಿವೆ.';

  @override
  String get planCurrent => 'ಪ್ರಸ್ತುತ';

  @override
  String get planStartTrial => '7-ದಿನಗಳ ನಿಃಶುಲ್ಕ ಪ್ರಯೋಗವನ್ನು ಪ್ರಾರಂಭಿಸಿ';

  @override
  String get planChoose => 'ಆಯ್ಕೆಮಾಡಿ';

  @override
  String get plansAction => 'ಯೋಜನೆಗಳು: Pro ಮತ್ತು Max';

  @override
  String get assistantTitle => 'ಸಹಾಯಕ';

  @override
  String get assistantGreeting => 'ನಮಸ್ಕಾರ! ನೀವು ಏನು ಮಾಡಲು ಬಯಸುತ್ತೀರಿ?';

  @override
  String get assistantNewList => 'ಹೊಸ ಪಟ್ಟಿ';

  @override
  String get assistantVoiceList => 'ಧ್ವನಿಯಿಂದ ಪಟ್ಟಿ';

  @override
  String get assistantTextList => 'ವಾಕ್ಯದಿಂದ ಪಟ್ಟಿ';

  @override
  String get assistantScanReceipt => 'ರಿಸಿಟ್ ಸ್ಕ್ಯಾನ್ ಮಾಡಿ';

  @override
  String get assistantSpending => 'ನನ್ನ ವೆಚ್ಚ';

  @override
  String get assistantReceiptHint =>
      'ನಿಮ್ಮ ಪಟ್ಟಿಯನ್ನು ತೆರೆಯಿರಿ ಮತ್ತು ಅದನ್ನು ಸ್ಕ್ಯಾನ್ ಮಾಡಲು ರಿಸಿಟ್ ಐಕಾನ್‌ನಲ್ಲಿ ಟ್ಯಾಪ್ ಮಾಡಿ.';

  @override
  String get assistantToggleTitle => 'ಸಹಾಯಕನನ್ನು ತೋರಿಸಿ';

  @override
  String get assistantToggleSubtitle => 'ಬಲ ಕೆಳಭಾಗದಲ್ಲಿರುವ ಸಣ್ಣ ಸಹಾಯಕ';

  @override
  String get scanPriceLabel => 'ಬೆಲೆ ಲೇಬಲ್ ಸ್ಕ್ಯಾನ್ ಮಾಡಿ';

  @override
  String get saveFailed =>
      'ಉಳಿಸಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ. ನಿಮ್ಮ ಬದಲಾವಣೆಗಳು ಇನ್ನೂ ಇವೆ. ದಯವಿಟ್ಟು ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get deleteItemConfirm =>
      'ಈ ವಸ್ತುವನ್ನು ಮತ್ತು ಅದರ ದಾಖಲಾದ ಖರೀದಿಗಳನ್ನು ತೆಗೆದುಹಾಕಬೇಕೇ?';

  @override
  String get clearPurchaseConfirm =>
      'ಈ ವಸ್ತುವಿನ ಚೆಕ್‌ಮಾರ್ಕ್ ತೆಗೆದು, ಅದರ ದಾಖಲಾದ ಖರೀದಿಗಳನ್ನು ತೆಗೆದುಹಾಕಬೇಕೇ?';

  @override
  String get reportPdfAction => 'PDF ರಿಪೋರ್ಟ್ ಉಳಿಸಿ';

  @override
  String get reportNotInvoice =>
      'ಖರೀದಿಯ ಸಾರಾಂಶ, ತೆರಿಗೆ ಇನ್ವಾಯ್ಸ್ ಅಲ್ಲ. ತೆರಿಗೆ ದರಗಳು ತಿಳಿದಿಲ್ಲ.';

  @override
  String get purchaseVisits => 'ಖರೀದಿ ಭೇಟಿಗಳು';

  @override
  String get purchaseInterval => 'ಖರೀದಿಗಳ ನಡುವಿನ ಸರಾಸರಿ ದಿನಗಳು';

  @override
  String get purchasedQuantity => 'ಖರೀದಿಸಿದ ಪ್ರಮಾಣ';

  @override
  String get purchaseAnalyticsHint =>
      'ಖರೀದಿಗಳು ಬಳಕೆಯನ್ನು ಅಳೆಯುವುದಿಲ್ಲ. ನಾಣ್ಯಗಳು ಮತ್ತು ಏಕಮಾನಗಳನ್ನು ಪ್ರತ್ಯೇಕವಾಗಿ ತೋರಿಸಲಾಗುತ್ತದೆ.';

  @override
  String get receiptReplaces =>
      'ಲಿಂಕ್ ಆಗಿರುವ ರಸೀದಿ ಪಂಕ್ತಿಗಳು ಇರುವ ಖರೀದಿಗಳನ್ನು ಬದಲಾಯಿಸುತ್ತವೆ; ಲಿಂಕ್ ಆಗಿಲ್ಲದ ಪಂಕ್ತಿಗಳನ್ನು ಸೇರಿಸಲಾಗುತ್ತದೆ.';

  @override
  String get voiceUnsupportedLanguage =>
      'ಈ ಭಾಷೆಯನ್ನು ಈ ಸಾಧನದಲ್ಲಿ ಧ್ವನಿ ಇನ್‌ಪುಟ್‌ಗೆ ಬಳಸಲಾಗುವುದಿಲ್ಲ. ನೀವು ಟೈಪ್ ಮಾಡಬಹುದು.';

  @override
  String get voiceStopListening => 'ಕೇಳುವುದನ್ನು ನಿಲ್ಲಿಸಿ';

  @override
  String get keepAwakeFailed =>
      'ಸ್ಕ್ರೀನ್ ಅನ್ನು ಜಾಗೃತವಾಗಿ ಇಡಲು ಸಾಧ್ಯವಿಲ್ಲ. ದಯವಿಟ್ಟು ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get purchaseHistoryHint =>
      'ಎಲ್ಲಾ ಪೂರ್ಣಗೊಂಡ ಖರೀದಿಗಳು. ಹಿಂದಿರುಗಿಸಿದ ವಸ್ತುಗಳಿಂದ ಒಟ್ಟು ಮೊತ್ತ ಕಡಿಮೆಯಾಗುತ್ತದೆ. ದಿನಾಂಕಗಳು ಖರೀದಿ ಪೂರ್ಣಗೊಂಡ ದಿನಗಳನ್ನು ಸೂಚಿಸುತ್ತವೆ. ಸರಾಸರಿ ಅಂತರವನ್ನು ಲೆಕ್ಕಹಾಕಲು ಒಂದು ಬಾರಿಯ ಭೇಟಿ ಸಾಕಾಗುವುದಿಲ್ಲ.';

  @override
  String get planLegacyRights =>
      'ಹಳೆಯ Pro ಮತ್ತು Max ಸದಸ್ಯತ್ವಗಳು ಅವುಗಳ ಮೂಲ ತಿಂಪಿನ AI ಅನುಮತಿಯನ್ನು ಕಾಯ್ದಿರಿಸುತ್ತವೆ. ಹೊಸ ಆಫರ್‌ಗಳು 100 ಮತ್ತು 300 ಬಾರಿಗಳನ್ನು ನೀಡುತ್ತವೆ.';

  @override
  String get csvExportAction => 'CSV ರಫ್ತು';
}
