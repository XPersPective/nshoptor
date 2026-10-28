// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Panjabi Punjabi (`pa`).
class AppLocalizationsPa extends AppLocalizations {
  AppLocalizationsPa([String locale = 'pa']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan =>
      'ਘਰ ਤੋਂ ਯੋਜਨਾ ਬਣਾਓ। ਜੋ ਯੋਜਨਾ ਬਣਾਈ ਹੈ, ਉਸੇ ਅਨੁਸਾਰ ਸ਼ਾਪਿੰਗ ਕਰੋ।';

  @override
  String get listsTitle => 'ਲਿਸਟਾਂ';

  @override
  String get listsTabActive => 'ਐਕਟਿਵ';

  @override
  String get listsTabCompleted => 'ਪੂਰੀਆਂ';

  @override
  String get listsTabArchived => 'ਅਰਕਾਈਵ';

  @override
  String get newListButton => 'ਨਵੀਂ ਲਿਸਟ';

  @override
  String get listTitleHint => 'ਟਾਈਟਲ (ਵਿਕਲਪਿਕ)';

  @override
  String get saveButton => 'ਸੇਵ ਕਰੋ';

  @override
  String get cancelButton => 'ਰੱਦ ਕਰੋ';

  @override
  String get deleteButton => 'ਡਿਲੀਟ ਕਰੋ';

  @override
  String get editAction => 'ਸੋਧੋ';

  @override
  String get listDeleted => 'ਲਿਸਟ ਡਿਲੀਟ ਹੋ ਗਈ';

  @override
  String get invalidAmountError => 'ਗਲਤ ਰਕਮ';

  @override
  String get duplicateAction => 'ਡੁਪਲੀਕੇਟ';

  @override
  String get archiveAction => 'ਅਰਕਾਈਵ ਕਰੋ';

  @override
  String get unarchiveAction => 'ਅਰਕਾਈਵ ਤੋਂ ਕੱਢੋ';

  @override
  String get deleteListConfirm =>
      'ਇਹ ਲਿਸਟ ਡਿਲੀਟ ਕਰਨੀ ਹੈ? ਇਸ ਦੀਆਂ ਯੋਜਨਾਬੱਧ ਵਸਤਾਂ ਵੀ ਹਟਾ ਦਿੱਤੀਆਂ ਜਾਣਗੀਆਂ।';

  @override
  String get undoButton => 'ਉਲਟਾਓ';

  @override
  String get searchListHint => 'ਲਿਸਟਾਂ ਖੋਜੋ';

  @override
  String get currencyLabel => 'ਮੁਦਰਾ';

  @override
  String get budgetLabel => 'ਬਜਟ (ਵਿਕਲਪਿਕ)';

  @override
  String get noteLabel => 'ਨੋਟ (ਵਿਕਲਪਿਕ)';

  @override
  String get storeLabel => 'ਦੁਕਾਨ';

  @override
  String get keepAmountsAction => 'ਰਕਮਾਂ ਨੂੰ ਬਰਕਰਾਰ ਰੱਖੋ';

  @override
  String get resetAmountsAction => 'ਰਕਮਾਂ ਨੂੰ ਮੁੜ ਸੈੱਟ ਕਰੋ';

  @override
  String get currencyChangeWarning =>
      'ਮੁਦਰਾ ਬਦਲ ਰਹੀ ਹੈ। ਮੌਜੂਦਾ ਰਕਮਾਂ ਨਾਲ ਕੀ ਹੋਵੇਗਾ?';

  @override
  String get listsEmpty =>
      'ਹਾਲੇ ਕੋਈ ਲਿਸਟ ਨਹੀਂ ਹੈ। ਆਪਣੀ ਪਹਿਲੀ ਸ਼ਾਪਿੰਗ ਯੋਜਨਾ ਬਣਾਓ।';

  @override
  String get statusDraft => 'ਡ੍ਰਾਫਟ';

  @override
  String get statusPlanned => 'ਯੋਜਨਾਬੱਧ';

  @override
  String get statusShopping => 'ਸ਼ਾਪਿੰਗ';

  @override
  String get statusCompleted => 'ਪੂਰੀ';

  @override
  String get statusArchived => 'ਅਰਕਾਈਵ';

  @override
  String autoListTitle(String date) {
    return '$date ਸ਼ਾਪਿੰਗ';
  }

  @override
  String get itemFormTitle => 'ਵਸਤ ਜੋੜੋ';

  @override
  String get itemNameLabel => 'ਵਸਤ ਦਾ ਨਾਮ';

  @override
  String get brandLabel => 'ਬ੍ਰਾਂਡ / ਵੇਰੀਐਂਟ (ਵਿਕਲਪਿਕ)';

  @override
  String get categoryLabel => 'ਸ਼੍ਰੇਣੀ';

  @override
  String get quantityLabel => 'ਮਾਤਰਾ';

  @override
  String get unitLabel => 'ਇਕਾਈ';

  @override
  String get pricingModeLabel => 'ਕੀਮਤ ਦਰਜ ਕਰਨ ਦਾ ਤਰੀਕਾ';

  @override
  String get pricingModeUnitPrice => 'ਇਕਾਈ ਕੀਮਤ';

  @override
  String get pricingModeLineTotal => 'ਲਾਈਨ ਕੁੱਲ';

  @override
  String get plannedPriceLabel => 'ਯੋਜਨਾਬੱਧ ਕੀਮਤ';

  @override
  String lineTotalCalculated(String value) {
    return 'ਲਾਈਨ ਕੁੱਲ: $value';
  }

  @override
  String get requiredItemToggle => 'ਜ਼ਰੂਰੀ ਵਸਤ';

  @override
  String get maxPriceLabel => 'ਸਵੀਕਾਰਯੋਗ ਵੱਧ ਤੋਂ ਵੱਧ ਕੀਮਤ (ਵਿਕਲਪਿਕ)';

  @override
  String get itemNoteLabel => 'ਨੋਟ (ਵਿਕਲਪਿਕ)';

  @override
  String get categoryProduce => 'ਸਬਜ਼ੀਆਂ ਅਤੇ ਫਲ';

  @override
  String get categoryDairy => 'ਡੇਅਰੀ';

  @override
  String get categoryMeat => 'ਮਾਸ';

  @override
  String get categoryBakery => 'ਬੇਕਰੀ';

  @override
  String get categoryDrinks => 'ਪੀਣ ਵਾਲੀਆਂ ਚੀਜ਼ਾਂ';

  @override
  String get categoryCleaning => 'ਸਫ਼ਾਈ';

  @override
  String get categoryPersonalCare => 'ਪਰਸੋਨਲ ਕੇਅਰ';

  @override
  String get categoryHome => 'ਘਰੇਲੂ';

  @override
  String get categoryOther => 'ਹੋਰ';

  @override
  String get invalidQuantityError => 'ਗਲਤ ਮਾਤਰਾ';

  @override
  String get invalidPriceError => 'ਗਲਤ ਕੀਮਤ';

  @override
  String get invalidNameError => 'ਇੱਕ ਨਾਮ ਦਰਜ ਕਰੋ';

  @override
  String unitPriceCalculated(String value) {
    return 'ਇਕਾਈ ਕੀਮਤ: $value';
  }

  @override
  String get shoppingTitle => 'ਖਰੀਦਦਾਰੀ ਮੋਡ';

  @override
  String get summaryPlannedTotal => 'ਯੋਜਨਾਬੱਧ';

  @override
  String get summaryInCart => 'ਕਾਰਟ ਵਿੱਚ';

  @override
  String get summaryRemainingPlan => 'ਬਾਕੀ ਯੋਜਨਾ';

  @override
  String get summaryProjected => 'ਅਨੁਮਾਨਿਤ ਚੈੱਕਆਉਟ';

  @override
  String get summaryBudgetRemaining => 'ਬਜਟ ਬਾਕੀ';

  @override
  String get summaryBudgetOver => 'ਬਜਟ ਤੋਂ ਵੱਧ';

  @override
  String itemsProgress(String done, String total) {
    return '$total ਵਿੱਚੋਂ $done ਆਈਟਮਾਂ';
  }

  @override
  String get filterAll => 'ਸਭ';

  @override
  String get filterToBuy => 'ਖਰੀਦਣ ਲਈ';

  @override
  String get filterInCart => 'ਕਾਰਟ ਵਿੱਚ';

  @override
  String get filterNotFound => 'ਨਹੀਂ ਮਿਲਿਆ';

  @override
  String get filterRequired => 'ਜ਼ਰੂਰੀ';

  @override
  String get quickEntryTitle => 'ਅਸਲ ਕੀਮਤ';

  @override
  String get actualQuantityLabel => 'ਅਸਲ ਮਾਤਰਾ';

  @override
  String get actualPriceLabel => 'ਅਸਲ ਕੀਮਤ';

  @override
  String get discountLabel => 'ਛੋਟ (ਵਿਕਲਪਿਕ)';

  @override
  String get alternativeNameLabel => 'ਵਿਕਲਪਿਕ ਉਤਪਾਦ ਦਾ ਨਾਮ (ਵਿਕਲਪਿਕ)';

  @override
  String get savePurchaseButton => 'ਕਾਰਟ ਵਿੱਚ ਜੋੜੋ';

  @override
  String get unplannedAddButton => 'ਬਿਨਾਂ ਯੋਜਨਾ ਦੇ ਆਈਟਮ ਜੋੜੋ';

  @override
  String get statusPending => 'ਨਹੀਂ ਲਿਆ ਗਿਆ';

  @override
  String get statusInCart => 'ਕਾਰਟ ਵਿੱਚ';

  @override
  String get statusNotFound => 'ਨਹੀਂ ਮਿਲਿਆ';

  @override
  String get statusGaveUp => 'ਛੱਡ ਦਿੱਤਾ';

  @override
  String get statusAlternative => 'ਵਿਕਲਪਿਕ ਖਰੀਦਿਆ';

  @override
  String get keepScreenAwake => 'ਸਕ੍ਰੀਨ ਚਾਲੂ ਰੱਖੋ';

  @override
  String get finishShopping => 'ਖਰੀਦਦਾਰੀ ਪੂਰੀ ਕਰੋ';

  @override
  String get completionWarning =>
      'ਕੁਝ ਰਿਕਾਰਡ ਗੁੰਮ ਹਨ ਜਾਂ ਉਨ੍ਹਾਂ ਦੀ ਪੁਸ਼ਟੀ ਨਹੀਂ ਹੋਈ ਹੈ। ਤੁਸੀਂ ਫਿਰ ਵੀ ਪੂਰਾ ਕਰ ਸਕਦੇ ਹੋ; ਨਤੀਜੇ ਵਿੱਚ ਉਨ੍ਹਾਂ ਦਾ ਜ਼ਿਕਰ ਹੋਵੇਗਾ।';

  @override
  String get continueShoppingButton => 'ਖਰੀਦਦਾਰੀ ਜਾਰੀ ਰੱਖੋ';

  @override
  String get resultTitle => 'ਨਤੀਜਾ';

  @override
  String get summarySection => 'ਸਾਰ';

  @override
  String get plannedTotalLabel => 'ਯੋਜਨਾਬੱਧ ਕੁੱਲ';

  @override
  String get actualTotalLabel => 'ਅਸਲ ਕੁੱਲ';

  @override
  String get varianceLabel => 'ਅੰਤਰ';

  @override
  String get varianceNotComputable => 'ਗਣਨਾ ਨਹੀਂ ਕੀਤੀ ਜਾ ਸਕਦੀ';

  @override
  String get budgetStatusLabel => 'ਬਜਟ';

  @override
  String get savingsLabel => 'ਯੋਜਨਾ ਤੋਂ ਘੱਟ';

  @override
  String get overspendLabel => 'ਯੋਜਨਾ ਤੋਂ ਵੱਧ';

  @override
  String get unplannedTotalLabel => 'ਬਿਨਾਂ ਯੋਜਨਾ ਦੇ ਕੁੱਲ';

  @override
  String get unpurchasedLabel => 'ਯੋਜਨਾਬੱਧ ਪਰ ਨਹੀਂ ਖਰੀਦਿਆ';

  @override
  String get totalDiscountLabel => 'ਕੁੱਲ ਛੋਟ';

  @override
  String get accuracyLabel => 'ਅਨੁਮਾਨ ਦੀ ਸ਼ੁੱਧਤਾ';

  @override
  String get groupsSection => 'ਆਈਟਮਾਂ';

  @override
  String get groupPricier => 'ਯੋਜਨਾ ਨਾਲੋਂ ਮਹਿੰਗਾ';

  @override
  String get groupCheaper => 'ਯੋਜਨਾ ਨਾਲੋਂ ਸਸਤਾ';

  @override
  String get groupClose => 'ਅਨੁਮਾਨ ਦੇ ਨੇੜੇ';

  @override
  String get groupNotTaken => 'ਯੋਜਨਾਬੱਧ, ਪਰ ਨਹੀਂ ਲਿਆ';

  @override
  String get groupUnplanned => 'ਬਿਨਾਂ ਯੋਜਨਾ ਦੇ ਖਰੀਦਿਆ';

  @override
  String get groupQuantityChanged => 'ਮਾਤਰਾ ਬਦਲੀ';

  @override
  String get groupUnverified => 'ਪੁਸ਼ਟੀ ਨਹੀਂ ਹੋਈ';

  @override
  String get plannedQtyLabel => 'ਯੋਜਨਾਬੱਧ ਮਾਤਰਾ';

  @override
  String get actualQtyLabel => 'ਅਸਲ ਮਾਤਰਾ';

  @override
  String get plannedUnitPriceLabel => 'ਯੋਜਨਾਬੱਧ ਇਕਾਈ ਕੀਮਤ';

  @override
  String get actualUnitPriceLabel => 'ਅਸਲ ਇਕਾਈ ਕੀਮਤ';

  @override
  String get lineVarianceLabel => 'ਲਾਈਨ ਅੰਤਰ';

  @override
  String get discountEffectLabel => 'ਛੋਟ ਦਾ ਪ੍ਰਭਾਵ';

  @override
  String get notBoughtMark => 'ਨਹੀਂ ਖਰੀਦਿਆ';

  @override
  String get noPurchasesNote => 'ਕੋਈ ਖਰੀਦਾਰੀ ਰਿਕਾਰਡ ਨਹੀਂ ਕੀਤੀ ਗਈ।';

  @override
  String get navHome => 'ਹੋਮ';

  @override
  String get navLists => 'ਲਿਸਟਾਂ';

  @override
  String get navHistory => 'ਇਤਿਹਾਸ';

  @override
  String get navSettings => 'ਸੈਟਿੰਗਾਂ';

  @override
  String get homeEmptyTitle => 'ਆਪਣੀ ਸ਼ਾਪਿੰਗ ਦੀ ਯੋਜਨਾ ਬਣਾਓ';

  @override
  String get homeEmptyBody =>
      'ਆਪਣੀ ਪਹਿਲੀ ਲਿਸਟ ਬਣਾਓ ਅਤੇ ਯੋਜਨਾਬੱਧ ਤੇ ਅਸਲੀ ਖਰਚਿਆਂ ਦੀ ਤੁਲਨਾ ਕਰੋ।';

  @override
  String get homeActiveSection => 'ਸਰਗਰਮ ਲਿਸਟਾਂ';

  @override
  String get homeCompletedSection => 'ਤਾਜ਼ਾ ਪੂਰੀਆਂ ਹੋਈਆਂ';

  @override
  String get homeMonthlySection => 'ਇਸ ਮਹੀਨੇ';

  @override
  String get monthPlannedLabel => 'ਯੋਜਨਾਬੱਧ';

  @override
  String get monthActualLabel => 'ਅਸਲੀ';

  @override
  String get monthVarianceLabel => 'ਅੰਤਰ';

  @override
  String get continueShoppingLabel => 'ਸ਼ਾਪਿੰਗ ਜਾਰੀ ਰੱਖੋ';

  @override
  String get historyEmpty =>
      'ਹਾਲੇ ਤੱਕ ਕੋਈ ਪੂਰੀ ਸ਼ਾਪਿੰਗ ਨਹੀਂ ਹੈ। ਤੁਹਾਡਾ ਇਤਿਹਾਸ ਅਤੇ ਵਿਸ਼ਲੇਸ਼ਣ ਇੱਥੇ ਦਿਖਾਈ ਦੇਣਗੇ।';

  @override
  String get aboutTabTitle => 'NShoptor ਬਾਰੇ';

  @override
  String get aboutBody =>
      'Crazy Penguin ਵੱਲੋਂ NShoptor। ਆਫ਼ਲਾਈਨ-ਪਹਿਲਾਂ ਸ਼ਾਪਿੰਗ ਪਲੈਨਰ। GPL-3.0 ਲਾਇਸੈਂਸ ਹੇਠ।';

  @override
  String get startShoppingLabel => 'ਸ਼ਾਪਿੰਗ ਸ਼ੁਰੂ ਕਰੋ';

  @override
  String get finishAndSeeResult => 'ਸਮਾਪਤ ਕਰੋ ਅਤੇ ਨਤੀਜਾ ਦੇਖੋ';

  @override
  String get settingsTitle => 'ਸੈਟਿੰਗਾਂ';

  @override
  String get languageLabel => 'ਭਾਸ਼ਾ';

  @override
  String get languageSystem => 'ਸਿਸਟਮ';

  @override
  String get languageTr => 'ਤੁਰਕੀ';

  @override
  String get languageEn => 'ਅੰਗਰੇਜ਼ੀ';

  @override
  String get themeLabel => 'ਥੀਮ';

  @override
  String get themeSystem => 'ਸਿਸਟਮ';

  @override
  String get themeLight => 'ਹਲਕਾ';

  @override
  String get themeDark => 'ਗੂੜ੍ਹਾ';

  @override
  String get defaultCurrencyLabel => 'ਮੂਲ ਮੁਦਰਾ';

  @override
  String get defaultUnitLabel => 'ਮੂਲ ਇਕਾਈ';

  @override
  String get keepAwakeLabel => 'ਸ਼ਾਪਿੰਗ ਦੌਰਾਨ ਸਕ੍ਰੀਨ ਚਾਲੂ ਰੱਖੋ';

  @override
  String get backupSection => 'ਬੈਕਅਪ';

  @override
  String get exportBackupLabel => 'ਬੈਕਅਪ ਨਿਰਯਾਤ ਕਰੋ';

  @override
  String get importBackupLabel => 'ਬੈਕਅਪ ਆਯਾਤ ਕਰੋ';

  @override
  String get mergeImportLabel => 'ਮੌਜੂਦਾ ਡੇਟਾ ਵਿੱਚ ਮਿਲਾਓ';

  @override
  String get separateImportLabel => 'ਵੱਖਰੀ ਕਾਪੀ ਵਜੋਂ ਆਯਾਤ ਕਰੋ';

  @override
  String get importCancelled => 'ਆਯਾਤ ਰੱਦ ਕੀਤਾ ਗਿਆ।';

  @override
  String get backupExported => 'ਬੈਕਅਪ ਸਫਲਤਾ ਨਾਲ ਨਿਰਯਾਤ ਹੋ ਗਿਆ।';

  @override
  String get deleteAllSection => 'ਖ਼ਤਰਨਾਕ ਖੇਤਰ';

  @override
  String get deleteAllLabel => 'ਸਾਰਾ ਡੇਟਾ ਮਿਟਾਓ';

  @override
  String get deleteAllConfirm =>
      'ਇਸ ਨਾਲ ਸਾਰੀਆਂ ਲਿਸਟਾਂ, ਇਤਿਹਾਸ, ਰਸੀਦ ਫ਼ੋਟੋਆਂ ਅਤੇ ਕੀਮਤਾਂ ਹਟਾ ਦਿੱਤੀਆਂ ਜਾਣਗੀਆਂ। ਤੁਹਾਡੇ ਦੁਆਰਾ ਨਿਰਯਾਤ ਕੀਤੀਆਂ ਫ਼ਾਈਲਾਂ ਤੁਹਾਡੇ ਡਰਾਈਵ \'ਤੇ ਰਹਿਣਗੀਆਂ। ਜਾਰੀ ਰੱਖੋ?';

  @override
  String get deleteAllConfirm2 =>
      'ਕੀ ਤੁਸੀਂ ਪੂਰੀ ਤਰ੍ਹਾਂ ਯਕੀਨੀ ਹੋ? ਇਹ ਕਾਰਵਾਈ ਵਾਪਸ ਨਹੀਂ ਕੀਤੀ ਜਾ ਸਕਦੀ।';

  @override
  String get cancelAction => 'ਰੱਦ ਕਰੋ';

  @override
  String get confirmDelete => 'ਸਦਾ ਲਈ ਮਿਟਾਓ';

  @override
  String get dataDeleted => 'ਸਾਰਾ ਸਥਾਨਕ ਡੇਟਾ ਮਿਟਾ ਦਿੱਤਾ ਗਿਆ ਹੈ।';

  @override
  String get privacyInfoLabel => 'ਪਰਾਈਵੇਸੀ';

  @override
  String get privacyInfoBody =>
      'ਤੁਹਾਡੀਆਂ ਲਿਸਟਾਂ, ਕੀਮਤਾਂ, ਰਸੀਦਾਂ ਅਤੇ ਫ਼ੋਟੋਆਂ ਤੁਹਾਡੇ ਡਿਵਾਈਸ \'ਤੇ ਸਟੋਰ ਰਹਿੰਦੀਆਂ ਹਨ। ਆਵਾਜ਼ ਕਦੇ ਵੀ ਇਸ ਤੋਂ ਬਾਹਰ ਨਹੀਂ ਜਾਂਦੀ। AI ਮਦਦ ਚਾਲੂ ਹੋਣ \'ਤੇ ਰਸੀਦਾਂ ਅਤੇ ਕੀਮਤ ਲੇਬਲਾਂ ਦੀਆਂ ਫ਼ੋਟੋਆਂ (ਛੋਟੇ ਆਕਾਰ ਵਿੱਚ) ਅਤੇ ਬੋਲ ਕੇ ਲਿਖਵਾਈਆਂ ਚੀਜ਼ਾਂ ਵਰਗਾ ਟੈਕਸਟ ਸਿਰਫ਼ ਪੜ੍ਹਨ ਲਈ ਸਾਡੇ ਸਰਵਰ \'ਤੇ ਭੇਜਿਆ ਜਾਂਦਾ ਹੈ; ਇਹਨਾਂ ਦੀ ਤੁਰੰਤ ਪ੍ਰਕਿਰਿਆ ਕੀਤੀ ਜਾਂਦੀ ਹੈ ਅਤੇ ਇਹਨਾਂ ਨੂੰ ਕਦੇ ਸਟੋਰ ਨਹੀਂ ਕੀਤਾ ਜਾਂਦਾ।';

  @override
  String get aboutSection => 'ਬਾਰੇ';

  @override
  String get aboutPublisher => 'ਪਬਲਿਸ਼ਰ: Crazy Penguin';

  @override
  String get aboutLicenses => 'ਲਾਇਸੈਂਸ (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'ਆਵਾਜ਼ ਇਨਪੁਟ';

  @override
  String get voiceStatusUnknown => 'ਸਰਵਿਸ: ਜਾਂਚ ਨਹੀਂ ਕੀਤੀ ਗਈ';

  @override
  String get permissionsLabel => 'ਅਨੁਮਤੀਆਂ';

  @override
  String get permissionsBody =>
      'ਕੈਮਰਾ, ਮਾਈਕ੍ਰੋਫ਼ੋਨ ਅਤੇ ਨੋਟੀਫ਼ਿਕੇਸ਼ਨ ਸਿਰਫ਼ ਉਦੋਂ ਮੰਗੇ ਜਾਂਦੇ ਹਨ ਜਦੋਂ ਤੁਸੀਂ ਅਸਲ ਵਿੱਚ ਉਹਨਾਂ ਫ਼ੀਚਰਾਂ ਦੀ ਵਰਤੋਂ ਕਰਦੇ ਹੋ।';

  @override
  String get unitsSection => 'ਮੂਲ';

  @override
  String get roundingNote =>
      'ਪੈਸੇ ਦੇ ਗੋਲ ਕਰਨ ਦਾ ਇੱਕ ਹੀ ਨਿਯਮ ਹੈ: ਅੱਧੇ ਜ਼ੀਰੋ ਤੋਂ ਦੂਰ ਗੋਲ ਹੁੰਦੇ ਹਨ, ਇਹ ਸਿਰਫ਼ ਪੈਸੇ ਦੇ ਰੂਪਾਂਤਰਣ \'ਤੇ ਲਾਗੂ ਹੁੰਦਾ ਹੈ।';

  @override
  String get voiceInputTitle => 'ਆਵਾਜ਼ ਇਨਪੁਟ';

  @override
  String get voiceStartListening => 'ਸੁਣਨਾ ਸ਼ੁਰੂ ਕਰੋ';

  @override
  String get voiceTranscriptLabel => 'ਟ੍ਰਾਂਸਕ੍ਰਿਪਟ';

  @override
  String get parseAction => 'ਪਾਰਸ ਕਰੋ';

  @override
  String get receiptReviewTitle => 'ਰਸੀਦ ਦੀ ਸਮੀਖਿਆ';

  @override
  String get receiptTotal => 'ਰਸੀਦ ਦਾ ਕੁੱਲ';

  @override
  String get receiptTotalUnknown => 'ਕੁੱਲ ਪਤਾ ਨਹੀਂ ਲੱਗਿਆ';

  @override
  String get receiptDiff => 'ਅੰਤਰ';

  @override
  String get acceptLine => 'ਲਾਈਨ ਮਨਜ਼ੂਰ ਕਰੋ';

  @override
  String get ignoreLine => 'ਲਾਈਨ ਨੂੰ ਨਜ਼ਰਅੰਦਾਜ਼ ਕਰੋ';

  @override
  String get receiptLineActions => 'ਆਈਟਮ ਨਾਲ ਜੋੜੋ, ਵੰਡੋ ਜਾਂ ਨਜ਼ਰਅੰਦਾਜ਼ ਕਰੋ';

  @override
  String get receiptCommit => 'ਸਭ ਮਨਜ਼ੂਰ ਕਰੋ';

  @override
  String get receiptCommitted => 'ਰਸੀਦ ਲਾਗੂ ਹੋ ਗਈ।';

  @override
  String get priceHistoryTitle => 'ਕੀਮਤ ਦਾ ਇਤਿਹਾਸ';

  @override
  String get noObservations => 'ਹਾਲੇ ਤੱਕ ਕੋਈ ਕੀਮਤ ਦੇਖੀ ਨਹੀਂ ਗਈ';

  @override
  String get templatesSection => 'ਟੈਂਪਲੇਟ';

  @override
  String get templateHint => 'ਪਿਛਲੀ ਸ਼ਾਪਿੰਗ ਯਾਤਰਾ ਤੋਂ ਨਵਾਂ ਪਲਾਨ ਬਣਾਓ';

  @override
  String get scanReceiptAction => 'ਰਸੀਦ ਸਕੈਨ ਕਰੋ';

  @override
  String get fromReceiptListButton => 'ਰਸੀਦ ਤੋਂ ਸੂਚੀ';

  @override
  String get shelfLabelAction => 'ਸ਼ੈਲਫ ਲੇਬਲ ਤੋਂ ਕੀਮਤ';

  @override
  String get priceCandidatesTitle => 'ਕੀਮਤ ਉਮੀਦਵਾਰ';

  @override
  String get noPriceCandidates => 'ਕੋਈ ਕੀਮਤ ਨਹੀਂ ਮਿਲੀ; ਮੈਨੁਅਲੀ ਦਰਜ ਕਰੋ।';

  @override
  String get voiceUnavailable => 'ਬੋਲ ਕੇ ਪਛਾਣ ਅਸਮਰੱਥ ਹੈ; ਮੈਨੁਅਲੀ ਦਰਜ ਕਰੋ।';

  @override
  String get linkToItem => 'ਆਈਟਮ ਨਾਲ ਜੋੜੋ';

  @override
  String get splitLine => 'ਦੋ ਹਿੱਸਿਆਂ ਵਿੱਚ ਵੰਡੋ';

  @override
  String get mergeWithNext => 'ਅਗਲੇ ਨਾਲ ਮਿਲਾਓ';

  @override
  String get ocrNoText => 'ਕੋਈ ਟੈਕਸਟ ਪੜ੍ਹਿਆ ਨਹੀਂ ਗਿਆ; ਦੁਬਾਰਾ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get priceHistoryAction => 'ਕੀਮਤ ਦਾ ਇਤਿਹਾਸ';

  @override
  String get itemsEmptyTitle => 'ਹਾਲੇ ਤੱਕ ਕੋਈ ਆਈਟਮ ਨਹੀਂ';

  @override
  String get itemsEmptyBody =>
      'ਆਪਣੀ ਪਹਿਲੀ ਆਈਟਮ ਜੋੜੋ — ਦੁਕਾਨ \'ਤੇ ਅਸਲ ਕੀਮਤ ਇੱਥੇ ਦਰਜ ਕਰੋਗੇ।';

  @override
  String get addItemTooltip => 'ਆਈਟਮ ਜੋੜੋ';

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
  String get unitCustom => 'ਕਸਟਮ';

  @override
  String get setReminderAction => 'ਰਿਮਾਈਂਡਰ ਸੈੱਟ ਕਰੋ';

  @override
  String get reminderPermissionDenied =>
      'ਰਿਮਾਈਂਡਰਾਂ ਲਈ ਨੋਟੀਫਿਕੇਸ਼ਨ ਦੀ ਆਗਿਆ ਦੀ ਲੋੜ ਹੈ। ਤੁਸੀਂ ਸਿਸਟਮ ਸੈਟਿੰਗਾਂ ਵਿੱਚ ਇਸਨੂੰ ਚਾਲੂ ਕਰ ਸਕਦੇ ਹੋ।';

  @override
  String get reminderScheduled => 'ਰਿਮਾਈਂਡਰ ਸੈੱਟ ਹੋ ਗਿਆ।';

  @override
  String get reminderCancelled => 'ਰਿਮਾਈਂਡਰ ਹਟਾ ਦਿੱਤਾ ਗਿਆ।';

  @override
  String get reminderTitle => 'ਸ਼ਾਪਿੰਗ ਰਿਮਾਈਂਡਰ';

  @override
  String reminderBody(Object title) {
    return 'ਆਪਣੀ ਸੂਚੀ ਦੀ ਜਾਂਚ ਕਰਨ ਦਾ ਸਮਾਂ: $title';
  }

  @override
  String get reminderPickDate => 'ਇੱਕ ਤਾਰੀਖ ਚੁਣੋ';

  @override
  String get reminderPickTime => 'ਇੱਕ ਸਮਾਂ ਚੁਣੋ';

  @override
  String get itemDetailsSection => 'ਵੇਰਵੇ';

  @override
  String get priceOptionalHint =>
      'ਵਿਕਲਪਿਕ — ਤੁਸੀਂ ਦੁਕਾਨ \'ਤੇ ਅਸਲ ਕੀਮਤ ਦਰਜ ਕਰੋਗੇ';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'ਪਲਾਨ ਕੀਤਾ: $total · $count ਆਈਟਮਾਂ';
  }

  @override
  String get proActiveLabel => 'Pro ਐਕਟਿਵ — ਧੰਨਵਾਦ!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'ਕੋਈ ਵਿਗਿਆਪਨ ਨਹੀਂ · ਬੈਕਅਪ ਐਕਸਪੋਰਟ ਅਤੇ ਇੰਪੋਰਟ · ਸਾਲਾਨਾ';

  @override
  String get proBenefitNoAds => 'ਵਿਗਿਆਪਨ-ਮੁਕਤ ਤਜਰਬਾ';

  @override
  String get proBenefitBackup => 'ਬੈਕਅਪ (ਨਿਰਯਾਤ/ਆਯਾਤ)';

  @override
  String aboutVersion(Object version) {
    return 'ਵਰਜ਼ਨ $version';
  }

  @override
  String get navDiscover => 'ਖੋਜੋ';

  @override
  String get shareAction => 'ਐਪ ਸਾਂਝੀ ਕਰੋ';

  @override
  String get rateAction => 'ਸਾਨੂੰ ਰੇਟ ਕਰੋ';

  @override
  String get aboutOpenRow => 'ਬਾਰੇ ਅਤੇ ਓਪਨ ਸੋਰਸ';

  @override
  String get voiceAddItemAction => 'ਬੋਲ ਕੇ ਜੋੜੋ';

  @override
  String get formatLocaleLabel => 'ਸੰਖਿਆ ਅਤੇ ਮੁਦਰਾ ਫਾਰਮੈਟ';

  @override
  String get formatLocaleSystem => 'ਡਿਵਾਈਸ ਫਾਰਮੈਟ (ਲੈਟਿਨ ਅੰਕ; ਬਾਕੀ ਅੰਗਰੇਜ਼ੀ)';

  @override
  String get formatLocaleTr => 'ਤੁਰਕੀ (1.234,56)';

  @override
  String get formatLocaleEn => 'ਅੰਗਰੇਜ਼ੀ (1,234.56)';

  @override
  String get aiToggleTitle => 'AI ਮਦਦ';

  @override
  String get aiToggleSubtitle =>
      'ਫ਼ੋਟੋਆਂ ਤੋਂ ਰਸੀਦਾਂ ਅਤੇ ਕੀਮਤ ਲੇਬਲ ਪੜ੍ਹਦਾ ਹੈ, ਰਸੀਦਾਂ ਦਾ ਮਿਲਾਨ ਕਰਦਾ ਹੈ ਅਤੇ ਵਾਕਾਂ ਨੂੰ ਲਿਸਟਾਂ ਵਿੱਚ ਬਦਲਦਾ ਹੈ। ਫ਼ੋਟੋਆਂ ਸਿਰਫ਼ ਪੜ੍ਹਨ ਲਈ ਭੇਜੀਆਂ ਜਾਂਦੀਆਂ ਹਨ ਅਤੇ ਕਦੇ ਸਟੋਰ ਨਹੀਂ ਕੀਤੀਆਂ ਜਾਂਦੀਆਂ।';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'ਤੁਸੀਂ ਇਸ ਮਹੀਨੇ ਦੀਆਂ AI ਰਿਕਵੈਸਟਾਂ ($used/$limit) ਵਰਤ ਲਈਆਂ ਹਨ। ਵਧੇਰੇ ਲਈ ਅਪਗ੍ਰੇਡ ਕਰੋ, ਜਾਂ AI ਦੇ ਬਿਨਾਂ ਜਾਰੀ ਰੱਖੋ।';
  }

  @override
  String get aiOffline => 'ਕੋਨੈਕਸ਼ਨ ਨਹੀਂ — AI ਦੇ ਬਿਨਾਂ ਜਾਰੀ ਰੱਖਿਆ ਜਾ ਰਿਹਾ ਹੈ।';

  @override
  String get aiFailed =>
      'AI ਹੁਣ ਉਪਲਬਧ ਨਹੀਂ ਹੈ — ਇਸਦੇ ਬਿਨਾਂ ਜਾਰੀ ਰੱਖਿਆ ਜਾ ਰਿਹਾ ਹੈ।';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'ਡਿਵਾਈਸ';

  @override
  String get quickListAction => 'ਇੱਕ ਵਾਕ ਤੋਂ ਜੋੜੋ';

  @override
  String get quickListTitle => 'ਤੁਰੰਤ ਸੂਚੀ';

  @override
  String get quickListHint => 'ਉਦਾਹਰਣ: 1 ਕਿਲੋ ਸੇਬ 20, 2 ਬ੍ਰੈਡ, ਅੱਧਾ ਕਿਲੋ ਪਨੀਰ';

  @override
  String get quickListConvert => 'ਸੂਚੀ ਵਿੱਚ ਬਦਲੋ';

  @override
  String quickListAdd(int count) {
    return '$count ਚੀਜ਼ਾਂ ਜੋੜੋ';
  }

  @override
  String get quickListEmpty =>
      'ਕੋਈ ਚੀਜ਼ ਨਹੀਂ ਮਿਲੀ। ਕੋਮਾ ਦੁਆਰਾ ਵੱਖ ਕਰਕੇ ਲਿਖਣ ਦੀ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get receiptAiMatched =>
      'AI ਨੇ ਰਸੀਦ ਨੂੰ ਤੁਹਾਡੀ ਸੂਚੀ ਨਾਲ ਮਿਲਾ ਦਿੱਤਾ ਹੈ। ਲਿੰਕਾਂ ਦੀ ਜਾਂਚ ਕਰੋ ਅਤੇ ਪੁਸ਼ਟੀ ਕਰੋ।';

  @override
  String get receiptNeedsCheck => 'ਇਸ ਮਿਲਾਪ ਦੀ ਜਾਂਚ ਕਰੋ';

  @override
  String get receiptDiscountLine => 'ਡਿਸਕਾਊਂਟ';

  @override
  String get compareItem => 'ਚੀਜ਼';

  @override
  String get compareEstimated => 'ਅਨੁਮਾਨਿਤ';

  @override
  String get compareActual => 'ਅਸਲ';

  @override
  String get compareDiff => 'ਅੰਤਰ';

  @override
  String get compareTotal => 'ਕੁੱਲ';

  @override
  String get compareBudget => 'ਬਜਟ';

  @override
  String get compareNotBought => 'ਨਹੀਂ ਖਰੀਦਿਆ';

  @override
  String get compareUnplanned => 'ਨਾ-ਯੋਜਨਾਬੱਧ';

  @override
  String get pricierItems => 'ਮਹਿੰਗੇ';

  @override
  String get cheaperItems => 'ਸਸਤੇ';

  @override
  String get compareAction => 'ਤੁਲਨਾ ਕਰੋ';

  @override
  String get detailsSection => 'ਵੇਰਵੇ';

  @override
  String get spendingTitle => 'ਖਰਚ';

  @override
  String get spendingAction => 'ਖਰਚ';

  @override
  String get spendingMonthTotal => 'ਇਸ ਮਹੀਨੇ';

  @override
  String get spendingWeekly => 'ਹਫ਼ਤਾਵਾਰੀ ਖਰਚ';

  @override
  String get spendingMonthly => 'ਮਹੀਨਾਵਾਰੀ ਖਰਚ';

  @override
  String get monthlyLimitTitle => 'ਮਹੀਨਾਵਾਰੀ ਸੀਮਾ';

  @override
  String get monthlyLimitHelp =>
      'ਤੁਸੀਂ ਹਰ ਮਹੀਨੇ ਸ਼ਾਪਿੰਗ \'ਤੇ ਕਿੰਨਾ ਖਰਚ ਕਰਨਾ ਚਾਹੁੰਦੇ ਹੋ?';

  @override
  String get monthlyLimitRemove => 'ਹਟਾਓ';

  @override
  String get monthlyLimitSet => 'ਸੈੱਟ ਕਰੋ';

  @override
  String get monthlyLimitChange => 'ਬਦਲੋ';

  @override
  String get monthlyLimitNone =>
      'ਦੇਖਣ ਲਈ ਕਿ ਤੁਹਾਡੇ ਕੋਲ ਕਿੰਨਾ ਬਚਿਆ ਹੈ, ਇੱਕ ਮਹੀਨਾਵਾਰੀ ਸੀਮਾ ਸੈੱਟ ਕਰੋ।';

  @override
  String monthlyLimitOver(String amount) {
    return 'ਸੀਮਾ ਤੋਂ $amount ਵੱਧ';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return 'ਇਸ ਮਹੀਨੇ $amount ਬਾਕੀ ਹੈ';
  }

  @override
  String get plansTitle => 'ਪਲਾਨ';

  @override
  String get plansHeadline => 'AI ਨਾਲ ਸਮਝਦਾਰੀ ਨਾਲ ਸ਼ਾਪਿੰਗ ਕਰੋ';

  @override
  String get plansSubhead =>
      'ਰਸੀਦ ਮਿਲਾਪ, ਕੀਮਤ ਲੇਬਲ ਅਤੇ ਇੱਕ ਵਾਕ ਤੋਂ ਸੂਚੀਆਂ। ਕਿਸੇ ਵੀ ਸਮੇਂ ਰੱਦ ਕਰੋ।';

  @override
  String get plansMonthly => 'ਮਹੀਨਾਵਾਰੀ';

  @override
  String get plansYearly => 'ਸਾਲਾਨਾ';

  @override
  String get planFree => 'ਮੁਫ਼ਤ';

  @override
  String get planFreePrice => 'ਹਮੇਸ਼ਾ ਮੁਫ਼ਤ';

  @override
  String get planFreeAi => 'ਮਹੀਨੇ ਵਿੱਚ 10 AI ਰਿਕਵੈਸਟਾਂ';

  @override
  String get planFreeAds => 'ਛੋਟੀ ਬੈਨਰ ਵਿਗਿਆਪਨ (ਪਹਿਲੇ 7 ਦਿਨਾਂ ਵਿੱਚ ਕੋਈ ਨਹੀਂ)';

  @override
  String get planCoreFeatures => 'ਸੂਚੀਆਂ, ਕੀਮਤਾਂ, ਰਸੀਦਾਂ, ਖਰਚ ਚਾਰਟ';

  @override
  String get plansPerYear => '/ ਸਾਲ';

  @override
  String get plansPerMonth => '/ ਮਹੀਨਾ';

  @override
  String get planTrial => 'ਮੁਫ਼ਤ ਟ੍ਰਾਇਲ';

  @override
  String get planProAi => 'ਮਹੀਨੇ ਵਿੱਚ 100 AI ਰਿਕਵੈਸਟਾਂ';

  @override
  String get planNoAds => 'ਕੋਈ ਵਿਗਿਆਪਨ ਨਹੀਂ';

  @override
  String get planBackup => 'ਬੈਕਅਪ ਐਕਸਪੋਰਟ ਅਤੇ ਇੰਪੋਰਟ';

  @override
  String get planMaxAi => 'ਮਹੀਨੇ ਵਿੱਚ 300 AI ਰਿਕਵੈਸਟਾਂ';

  @override
  String get planMaxFamily => 'ਵੱਡੇ ਪਰਿਵਾਰ ਲਈ ਸ਼ਾਪਿੰਗ';

  @override
  String get plansStoreUnavailable => 'ਦੁਕਾਨ ਹੁਣ ਤੱਕ ਉਪਲਬਧ ਨਹੀਂ ਹੈ।';

  @override
  String get retryAction => 'ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ';

  @override
  String get plansPurchaseFailed =>
      'ਖਰੀਦ ਪੂਰੀ ਨਹੀਂ ਹੋਈ। ਕਿਰਪਾ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get plansRestore => 'ਖਰੀਦਾਂ ਪੁਨਰਸਥਾਪਿਤ ਕਰੋ';

  @override
  String get plansLegal =>
      'ਰੱਦ ਕਰਨ ਤੱਕ Pro ਹਰ ਸਾਲ ਆਪਣੇ ਆਪ ਨਵਿਆਇਆ ਜਾਂਦਾ ਹੈ ਅਤੇ ਹਰ ਮਹੀਨੇ 100 AI ਬੇਨਤੀਆਂ ਮਿਲਦੀਆਂ ਹਨ। ਲਾਗੂ ਟੈਕਸਾਂ ਤੋਂ ਪਹਿਲਾਂ ਮੂਲ ਕੀਮਤ ਸਾਲਾਨਾ 1 ਅਮਰੀਕੀ ਡਾਲਰ ਹੈ; ਖਰੀਦ ਦੀ ਪੁਸ਼ਟੀ ਕਰਨ ਤੋਂ ਪਹਿਲਾਂ ਸਟੋਰ ਵਿੱਚ ਅੰਤਿਮ ਸਥਾਨਕ ਕੀਮਤ ਅਤੇ ਟੈਕਸ ਵੇਖੋ। Google Play ਵਿੱਚ ਗਾਹਕੀ ਦਾ ਪ੍ਰਬੰਧ ਕਰੋ ਜਾਂ ਰੱਦ ਕਰੋ।';

  @override
  String get planCurrent => 'ਮੌਜੂਦਾ';

  @override
  String get planStartTrial => 'ਮੁਫ਼ਤ ਟ੍ਰਾਇਲ ਸ਼ੁਰੂ ਕਰੋ';

  @override
  String get planChoose => 'ਚੁਣੋ';

  @override
  String get plansAction => 'ਪਲਾਨ: Pro';

  @override
  String get assistantTitle => 'ਸਹਾਇਕ';

  @override
  String get assistantGreeting => 'ਹੈਲੋ! ਤੁਸੀਂ ਕੀ ਕਰਨਾ ਚਾਹੁੰਦੇ ਹੋ?';

  @override
  String get assistantNewList => 'ਨਵੀਂ ਸੂਚੀ';

  @override
  String get assistantVoiceList => 'ਵੌਇਸ ਨਾਲ ਸੂਚੀ';

  @override
  String get assistantTextList => 'ਵਾਕ ਤੋਂ ਸੂਚੀ';

  @override
  String get assistantScanReceipt => 'ਰਸੀਦ ਸਕੈਨ ਕਰੋ';

  @override
  String get assistantSpending => 'ਮੇਰੀ ਖਰਚ';

  @override
  String get assistantReceiptHint =>
      'ਆਪਣੀ ਸੂਚੀ ਖੋਲ੍ਹੋ ਅਤੇ ਇਸਨੂੰ ਸਕੈਨ ਕਰਨ ਲਈ ਰਸੀਦ ਦੇ ਆਈਕਨ \'ਤੇ ਟੈਪ ਕਰੋ।';

  @override
  String get assistantToggleTitle => 'ਸਹਾਇਕ ਦਿਖਾਓ';

  @override
  String get assistantToggleSubtitle => 'ਹੇਠਾਂ ਸੱਜੇ ਪਾਸੇ ਛੋਟਾ ਸਹਾਇਕ';

  @override
  String get scanPriceLabel => 'ਮੁੱਲ ਲੇਬਲ ਸਕੈਨ ਕਰੋ';

  @override
  String get saveFailed =>
      'ਸੇਵ ਨਹੀਂ ਹੋ ਸਕਿਆ। ਤੁਹਾਡੇ ਬਦਲਾਅ ਅਜੇ ਵੀ ਇੱਥੇ ਹਨ। ਕਿਰਪਾ ਕਰਕੇ ਦੁਬਾਰਾ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get deleteItemConfirm =>
      'ਇਹ ਆਈਟਮ ਅਤੇ ਇਸਦੇ ਰਿਕਾਰਡ ਕੀਤੇ ਗਏ ਖਰੀਦਾਰੀਆਂ ਨੂੰ ਹਟਾਉਣਾ ਹੈ?';

  @override
  String get clearPurchaseConfirm =>
      'ਇਸ ਆਈਟਮ ਨੂੰ ਅਣਚੈੱਕ ਕਰੋ ਅਤੇ ਇਸਦੇ ਰਿਕਾਰਡ ਕੀਤੇ ਗਏ ਖਰੀਦਾਰੀਆਂ ਨੂੰ ਹਟਾਓ?';

  @override
  String get reportPdfAction => 'PDF ਰਿਪੋਰਟ ਸੇਵ ਕਰੋ';

  @override
  String get reportNotInvoice =>
      'ਖਰੀਦਾਰੀ ਦੀ ਸੰਖੇਪ ਜਾਣਕਾਰੀ, ਟੈਕਸ ਇਨਵੌਇਸ ਨਹੀਂ। ਟੈਕਸ ਦਰਾਂ ਅਣਜਾਣ ਹਨ।';

  @override
  String get purchaseVisits => 'ਖਰੀਦਾਰੀ ਦੇ ਦੌਰੇ';

  @override
  String get purchaseInterval => 'ਖਰੀਦਾਰੀਆਂ ਵਿਚਕਾਰ ਔਸਤ ਦਿਨ';

  @override
  String get purchasedQuantity => 'ਖਰੀਦੀ ਗਈ ਮਾਤਰਾ';

  @override
  String get purchaseAnalyticsHint =>
      'ਖਰੀਦਾਰੀਆਂ ਖਪਤ ਨੂੰ ਨਹੀਂ ਮਾਪਦੀਆਂ। ਕਰੰਸੀਆਂ ਅਤੇ ਇਕਾਈਆਂ ਵੱਖਰੇ ਤੌਰ \'ਤੇ ਦਿਖਾਈਆਂ ਜਾਂਦੀਆਂ ਹਨ।';

  @override
  String get receiptReplaces =>
      'ਬਿਨਾਂ ਕੀਮਤ ਵਾਲੀਆਂ ਚੀਜ਼ਾਂ ਦੀ ਕੀਮਤ ਭਰੀ ਜਾਂਦੀ ਹੈ। ਬਾਜ਼ਾਰ ਕੀਮਤ ਵਾਲੀਆਂ ਚੀਜ਼ਾਂ ਵੱਖਰੀਆਂ ਖਰੀਦਾਂ ਵਜੋਂ ਜੋੜੀਆਂ ਜਾਂਦੀਆਂ ਹਨ।';

  @override
  String get receiptIncompleteHeader =>
      'ਅਗਲੀ ਤਸਵੀਰ ਵਿੱਚ ਦੁਕਾਨ, ਮਿਤੀ, ਸਮਾਂ ਅਤੇ ਰਸੀਦ ਨੰਬਰ ਸ਼ਾਮਲ ਕਰੋ।';

  @override
  String get receiptIncompleteTail =>
      'ਅਗਲਾ ਹਿੱਸਾ ਕੁਝ ਓਵਰਲੈਪ ਕਰਦੀਆਂ ਚੀਜ਼ਾਂ ਅਤੇ ਅੰਤਿਮ ਕੁੱਲ ਸਮੇਤ ਫੋਟੋ ਕਰੋ।';

  @override
  String get receiptContinuationRejected =>
      'ਇਹ ਤਸਵੀਰ ਜੋੜੀ ਨਹੀਂ ਜਾ ਸਕੀ। ਉਸੇ ਰਸੀਦ ਦੀਆਂ ਓਵਰਲੈਪ ਕਰਦੀਆਂ ਚੀਜ਼ਾਂ ਨਾਲ ਮੁੜ ਫੋਟੋ ਖਿੱਚੋ।';

  @override
  String get receiptDraftSaved =>
      'ਰਸੀਦ ਮਸੌਦੇ ਵਜੋਂ ਸੁਰੱਖਿਅਤ ਹੋ ਗਈ। ਤੁਸੀਂ ਬਾਅਦ ਵਿੱਚ ਜਾਰੀ ਰੱਖ ਸਕਦੇ ਹੋ।';

  @override
  String get receiptContinueAction => 'ਰਸੀਦ ਜਾਰੀ ਰੱਖੋ';

  @override
  String get receiptDraftsTitle => 'ਅਧੂਰੀਆਂ ਰਸੀਦਾਂ';

  @override
  String get receiptDuplicate => 'ਇਹ ਰਸੀਦ ਪਹਿਲਾਂ ਹੀ ਜੋੜੀ ਗਈ ਹੈ।';

  @override
  String get receiptTotalMismatch =>
      'ਚੀਜ਼ਾਂ ਦਾ ਜੋੜ ਰਸੀਦ ਦੇ ਕੁੱਲ ਨਾਲ ਮੇਲ ਨਹੀਂ ਖਾਂਦਾ। ਜਾਂਚੋ ਕਿ ਪੂਰੀ ਰਸੀਦ ਦਿਖ ਰਹੀ ਹੈ।';

  @override
  String get receiptSaveDraftAction => 'ਬਾਅਦ ਲਈ ਸੁਰੱਖਿਅਤ ਕਰੋ';

  @override
  String get receiptResolveLines =>
      'ਸੰਭਾਲਣ ਤੋਂ ਪਹਿਲਾਂ ਹਰ ਚੀਜ਼ ਨੂੰ ਸਵੀਕਾਰ ਕਰੋ ਜਾਂ ਅਣਡਿੱਠਾ ਕਰੋ।';

  @override
  String get receiptPartialConfirm =>
      'ਸਿਰਫ਼ ਚੁਣੀਆਂ ਚੀਜ਼ਾਂ ਹੀ ਸ਼ਾਮਲ ਕੀਤੀਆਂ ਜਾਣਗੀਆਂ। ਇਸ ਰਸੀਦ ਨੂੰ ਆਯਾਤ ਕੀਤੀ ਹੋਈ ਵਜੋਂ ਦਰਸਾਇਆ ਜਾਵੇਗਾ। ਜਾਰੀ ਰੱਖਣਾ ਹੈ?';

  @override
  String get voiceUnsupportedLanguage =>
      'ਇਹ ਭਾਸ਼ਾ ਇਸ ਡਿਵਾਈਸ \'ਤੇ ਵੌਇਸ ਇਨਪੁਟ ਲਈ ਉਪਲਬਧ ਨਹੀਂ ਹੈ। ਤੁਸੀਂ ਟਾਈਪ ਕਰ ਸਕਦੇ ਹੋ।';

  @override
  String get voiceStopListening => 'ਸੁਣਨਾ ਬੰਦ ਕਰੋ';

  @override
  String get keepAwakeFailed =>
      'ਸਕ੍ਰੀਨ ਨੂੰ ਜਾਗਦਾ ਰੱਖਿਆ ਨਹੀਂ ਜਾ ਸਕਿਆ। ਕਿਰਪਾ ਕਰਕੇ ਦੁਬਾਰਾ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get purchaseHistoryHint =>
      'ਸਾਰੀਆਂ ਪੂਰੀਆਂ ਹੋਈਆਂ ਸ਼ਾਪਿੰਗਾਂ। ਵਾਪਸੀਆਂ ਕੁੱਲ ਜੋੜ ਨੂੰ ਘਟਾਉਂਦੀਆਂ ਹਨ। ਤਰੀਕਾਂ ਸ਼ਾਪਿੰਗ ਦੀ ਪੂਰਤੀ ਨਾਲ ਸਬੰਧਤ ਹਨ। ਇੱਕ ਦਿਨ ਦੀ ਮਿਥਾਸ ਔਸਤ ਅੰਤਰਾਲ ਦੀ ਗਣਨਾ ਲਈ ਕਾਫ਼ੀ ਨਹੀਂ ਹੈ।';

  @override
  String get planLegacyRights =>
      'ਮੌਜੂਦਾ Pro ਅਤੇ Max ਗਾਹਕੀਆਂ ਆਪਣੀ ਮੂਲ ਮਹੀਨਾਵਾਰ AI ਬੇਨਤੀ ਸੀਮਾ ਕਾਇਮ ਰੱਖਦੀਆਂ ਹਨ।';

  @override
  String get csvExportAction => 'CSV ਐਕਸਪੋਰਟ ਕਰੋ';

  @override
  String get reportSharePdf => 'PDF ਵਜੋਂ ਸਾਂਝਾ ਕਰੋ';

  @override
  String get reportShareCsv => 'CSV ਵਜੋਂ ਸਾਂਝਾ ਕਰੋ';

  @override
  String get reportPrintAction => 'ਪ੍ਰਿੰਟ ਕਰੋ';

  @override
  String get backupSizeWarning =>
      'JSON ਵਿੱਚ ਰਿਕਾਰਡ ਹਨ, ਫੋਟੋ ਫਾਈਲਾਂ ਨਹੀਂ। ਇੰਪੋਰਟ ਲਿਮਿਟ: 16 MB.';

  @override
  String get backupImportFailed =>
      'ਇਹ ਬੈਕਅਪ ਇੰਪੋਰਟ ਨਹੀਂ ਕੀਤਾ ਜਾ ਸਕਿਆ। ਤੁਹਾਡਾ ਡੇਟਾ ਨਹੀਂ ਬਦਲਿਆ ਗਿਆ।';

  @override
  String get backupImported => 'ਬੈਕਅਪ ਸਫਲਤਾ ਨਾਲ ਇੰਪੋਰਟ ਕੀਤਾ ਗਿਆ ਹੈ।';

  @override
  String backupPreviewCounts(Object entries, Object items, Object lists) {
    return '$lists ਸੂਚੀਆਂ · $items ਆਈਟਮਾਂ · $entries ਖਰੀਦ';
  }

  @override
  String get voiceModelDownloading =>
      'ਇਸ ਭਾਸ਼ਾ ਲਈ ਵੌਇਸ ਮਾਡਲ ਡਾਊਨਲੋਡ ਹੋ ਰਿਹਾ ਹੈ। ਇੱਕ ਮਿੰਟ ਬਾਅਦ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get historyThisWeek => 'ਇਸ ਹਫ਼ਤੇ';

  @override
  String get historyProductsSection => 'ਖਰੀਦੇ ਉਤਪਾਦ';

  @override
  String get tipReceiptScan => 'ਰਸੀਦ ਸਕੈਨ ਕਰਕੇ ਕੀਮਤਾਂ ਆਪਣੀ ਸੂਚੀ ਨਾਲ ਮਿਲਾਓ';

  @override
  String get tipVoiceAdd =>
      'ਇੱਕ ਜਾਂ ਵੱਧ ਚੀਜ਼ਾਂ ਬੋਲੋ, ਫਿਰ ਜੋੜਨ ਤੋਂ ਪਹਿਲਾਂ ਜਾਂਚੋ';

  @override
  String get tipShelfCamera => 'ਕੈਮਰੇ ਨਾਲ ਸ਼ੈਲਫ ਲੇਬਲ ਤੋਂ ਕੀਮਤ ਪੜ੍ਹੋ';

  @override
  String get tipPlan =>
      'ਤੁਹਾਡਾ ਪਲਾਨ: ਵੇਰਵੇ ਦੇਖੋ, ਸਬਸਕ੍ਰਾਈਬ ਕਰੋ ਜਾਂ ਅੱਪਗ੍ਰੇਡ ਕਰੋ';

  @override
  String get guideAddBody =>
      'ਚੀਜ਼ ਜੋੜਨ ਲਈ + ਦਬਾਓ। ਯੋਜਨਾ ਵਾਲੀ ਕੀਮਤ ਹੁਣ ਅਤੇ ਬਾਜ਼ਾਰ ਵਾਲੀ ਕੀਮਤ ਕਾਊਂਟਰ ’ਤੇ ਦਾਖ਼ਲ ਕਰੋ।';

  @override
  String get guideVoiceBody =>
      'ਮਾਈਕ੍ਰੋਫ਼ੋਨ ਦਬਾਓ ਅਤੇ ਚੀਜ਼ਾਂ ਬੋਲੋ, ਜਿਵੇਂ: \'1 ਕਿਲੋ ਸੇਬ, 1 ਬਰੈੱਡ\'।';

  @override
  String get guideReceiptBody =>
      'ਰਸੀਦ ਸਕੈਨ ਕਰਕੇ ਉਸ ਦੀਆਂ ਕੀਮਤਾਂ ਆਪਣੀ ਸੂਚੀ ਦੀਆਂ ਚੀਜ਼ਾਂ ਨਾਲ ਮਿਲਾਓ।';

  @override
  String get guidePlanBody =>
      'ਪਲਾਨ ਦੇਖਣ, ਸਬਸਕ੍ਰਾਈਬ ਕਰਨ ਜਾਂ ਅੱਪਗ੍ਰੇਡ ਕਰਨ ਲਈ ਪਲਾਨ ਆਈਕਨ ਦਬਾਓ।';

  @override
  String get guideNext => 'ਠੀਕ ਹੈ';

  @override
  String get guideDone => 'ਸ਼ੁਰੂ ਕਰੋ';

  @override
  String get paletteLabel => 'ਰੰਗ ਥੀਮ';

  @override
  String get paletteForest => 'ਜੰਗਲ';

  @override
  String get paletteOcean => 'ਸਮੁੰਦਰ';

  @override
  String get paletteSunset => 'ਸੂਰਜ ਡੁੱਬਣਾ';

  @override
  String get paletteLavender => 'ਲਵੈਂਡਰ';

  @override
  String get darkBlackLabel => 'ਡਾਰਕ ਥੀਮ ਵਿੱਚ ਪੂਰਾ ਕਾਲਾ';

  @override
  String get spendingOverview => 'ਝਲਕ';

  @override
  String get spendingThisYear => 'ਇਸ ਸਾਲ';

  @override
  String get spendingYearly => 'ਸਾਲਾਨਾ ਖਰਚਾ';

  @override
  String get productSpending => 'ਚੀਜ਼ ਮੁਤਾਬਕ ਖਰਚਾ';

  @override
  String get spanWeek => 'ਹਫ਼ਤਾ';

  @override
  String get spanMonth => 'ਮਹੀਨਾ';

  @override
  String get spanYear => 'ਸਾਲ';

  @override
  String get weeklyLimitTitle => 'ਹਫ਼ਤਾਵਾਰੀ ਸੀਮਾ';

  @override
  String get weeklyLimitHelp =>
      'ਹਫ਼ਤੇ ਵਿੱਚ ਖ਼ਰੀਦਦਾਰੀ ’ਤੇ ਕਿੰਨਾ ਖਰਚਣਾ ਚਾਹੁੰਦੇ ਹੋ?';

  @override
  String get weeklyLimitNone => 'ਕਿੰਨਾ ਬਾਕੀ ਹੈ ਦੇਖਣ ਲਈ ਹਫ਼ਤਾਵਾਰੀ ਸੀਮਾ ਤੈਅ ਕਰੋ।';

  @override
  String weeklyLimitLeft(String amount) {
    return 'ਇਸ ਹਫ਼ਤੇ $amount ਬਾਕੀ';
  }

  @override
  String get shoppingLimitTitle => 'ਹਰ ਖ਼ਰੀਦਦਾਰੀ ਦੀ ਸੀਮਾ';

  @override
  String get shoppingLimitHelp => 'ਨਵੀਆਂ ਸੂਚੀਆਂ ਇਸ ਬਜਟ ਨਾਲ ਸ਼ੁਰੂ ਹੁੰਦੀਆਂ ਹਨ।';

  @override
  String get shoppingLimitNone => 'ਹਰ ਨਵੀਂ ਖ਼ਰੀਦਦਾਰੀ ਲਈ ਡਿਫ਼ੌਲਟ ਬਜਟ ਤੈਅ ਕਰੋ।';

  @override
  String get monthlyReportAction => 'ਮਹੀਨਾਵਾਰ ਰਿਪੋਰਟ';

  @override
  String get reportShoppingColumn => 'ਖ਼ਰੀਦਦਾਰੀ';

  @override
  String get reportDateColumn => 'ਤਾਰੀਖ';

  @override
  String get planUnavailable => 'ਹੁਣ ਸਟੋਰ ਵਿੱਚ ਉਪਲਬਧ ਨਹੀਂ';

  @override
  String get demoDataTitle => 'ਨਮੂਨਾ ਡਾਟਾ';

  @override
  String get demoDataLoad => 'ਨਮੂਨਾ ਡਾਟਾ ਨਾਲ ਅਜ਼ਮਾਓ';

  @override
  String get demoDataLoadHelp =>
      'ਇਤਿਹਾਸ, ਚਾਰਟ ਅਤੇ ਕੀਮਤ ਇਤਿਹਾਸ ਦੇਖਣ ਲਈ 12 ਮਹੀਨਿਆਂ ਦੀ ਨਮੂਨਾ ਖ਼ਰੀਦਦਾਰੀ ਜੋੜਦਾ ਹੈ।';

  @override
  String get demoDataRemove => 'ਨਮੂਨਾ ਡਾਟਾ ਹਟਾਓ';

  @override
  String get demoDataAdded => 'ਨਮੂਨਾ ਡਾਟਾ ਜੋੜਿਆ ਗਿਆ';

  @override
  String get demoDataRemoved => 'ਨਮੂਨਾ ਡਾਟਾ ਹਟਾਇਆ ਗਿਆ';

  @override
  String get demoProductApple => 'ਸੇਬ';

  @override
  String get demoProductBread => 'ਬਰੈੱਡ';

  @override
  String get demoProductMilk => 'ਦੁੱਧ';

  @override
  String get demoProductCheese => 'ਪਨੀਰ';

  @override
  String get demoProductTomato => 'ਟਮਾਟਰ';

  @override
  String get demoProductEggs => 'ਆਂਡੇ';

  @override
  String get demoProductCoffee => 'ਕੌਫ਼ੀ';

  @override
  String get demoProductDetergent => 'ਡਿਟਰਜੈਂਟ';

  @override
  String get sendAction => 'Send';

  @override
  String get previousMonthAction => 'Previous month';

  @override
  String get nextMonthAction => 'Next month';

  @override
  String get helpSection => 'ਮਦਦ ਅਤੇ ਸਹਾਇਤਾ';

  @override
  String get howToUseLabel => 'ਕਿਵੇਂ ਵਰਤਣਾ ਹੈ';

  @override
  String get guidePricesBody =>
      'ਦੁਕਾਨ ਦੀ ਕੀਮਤ ਭਰਨ ਨਾਲ ਵਸਤੂ ਖਰੀਦੀ ਹੋਈ ਮੰਨੀ ਜਾਂਦੀ ਹੈ; 0 ਵੀ ਮੰਨਿਆ ਜਾਂਦਾ ਹੈ। ਘਰ ਦੀ ਕੀਮਤ ਚੋਣਵੀਂ ਹੈ। ਨਿਸ਼ਾਨ ਹਟਾਉਣ ਲਈ ਦੁਕਾਨ ਦੀ ਕੀਮਤ ਮਿਟਾਓ।';

  @override
  String get shoppingDateLabel => 'ਖਰੀਦਦਾਰੀ ਦੀ ਤਾਰੀਖ';

  @override
  String get shoppingDateNone => 'ਕੋਈ ਤਾਰੀਖ ਨਹੀਂ ਚੁਣੀ';

  @override
  String get clearShoppingDateAction => 'ਤਾਰੀਖ ਹਟਾਓ';

  @override
  String get listSortLabel => 'ਸੂਚੀ ਦਾ ਕ੍ਰਮ';

  @override
  String get listSortDate => 'ਖਰੀਦਦਾਰੀ ਦੀ ਤਾਰੀਖ';

  @override
  String get listSortAz => 'ਨਾਮ (ੳ–ੜ)';

  @override
  String get listSortManual => 'ਆਪ ਕ੍ਰਮ ਲਗਾਓ';

  @override
  String get imageCameraAction => 'ਫੋਟੋ ਖਿੱਚੋ';

  @override
  String get imageGalleryAction => 'ਫੋਟੋਆਂ ਵਿੱਚੋਂ ਚੁਣੋ';

  @override
  String get imageCaptureFailed =>
      'ਕੈਮਰਾ ਜਾਂ ਫੋਟੋਆਂ ਖੋਲ੍ਹੀਆਂ ਨਹੀਂ ਜਾ ਸਕੀਆਂ। ਪਹੁੰਚ ਦੀ ਇਜਾਜ਼ਤ ਜਾਂਚੋ ਅਤੇ ਦੁਬਾਰਾ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get imageRecognitionFailed =>
      'ਫੋਟੋ ਉੱਤੇ ਕਾਰਵਾਈ ਨਹੀਂ ਹੋ ਸਕੀ। ਕਿਸੇ ਹੋਰ ਫੋਟੋ ਨਾਲ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get receiptNoProducts =>
      'ਲਿਖਤ ਪੜ੍ਹੀ ਗਈ, ਪਰ ਰਸੀਦ ਦੀਆਂ ਵਸਤਾਂ ਨਹੀਂ ਮਿਲੀਆਂ। ਫੋਟੋ ਵਿੱਚ ਵਸਤਾਂ ਅਤੇ ਕੁੱਲ ਰਕਮ ਸ਼ਾਮਲ ਕਰੋ।';

  @override
  String get keepAwakeOn => 'ਸਕ੍ਰੀਨ ਚਾਲੂ ਰਹੇਗੀ';

  @override
  String get keepAwakeOff => 'ਸਕ੍ਰੀਨ ਬੰਦ ਹੋ ਸਕਦੀ ਹੈ';

  @override
  String get spanDay => 'ਦਿਨ';

  @override
  String get spanCustom => 'ਤਾਰੀਖ ਦੀ ਮਿਆਦ';

  @override
  String get reportTotalSpent => 'ਕੁੱਲ ਖਰਚ';

  @override
  String get reportAddedAt => 'ਜੋੜਨ ਦੀ ਤਾਰੀਖ';

  @override
  String get reportReceiptNumber => 'ਰਸੀਦ ਨੰਬਰ';

  @override
  String get reportPreview => 'ਝਲਕ';

  @override
  String get reportShareAction => 'ਸਾਂਝਾ ਕਰੋ';

  @override
  String get previousPeriodAction => 'ਪਿਛਲੀ ਮਿਆਦ';

  @override
  String get nextPeriodAction => 'ਅਗਲੀ ਮਿਆਦ';

  @override
  String get reportSaved => 'ਰਿਪੋਰਟ ਸੁਰੱਖਿਅਤ ਕੀਤੀ ਗਈ।';

  @override
  String get reportZoom => 'ਜ਼ੂਮ';

  @override
  String planTrialDaysLeft(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days ਦਿਨ ਬਾਕੀ',
    );
    return '$_temp0';
  }

  @override
  String planTrialHoursLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours ਘੰਟੇ ਬਾਕੀ',
    );
    return '$_temp0';
  }

  @override
  String get planTrialEndedTitle => 'ਤੁਹਾਡੀ Pro ਅਜ਼ਮਾਇਸ਼ ਖਤਮ ਹੋ ਗਈ ਹੈ';

  @override
  String get planTrialEndedBody =>
      'ਤੁਸੀਂ ਸੂਚੀਆਂ, ਹੱਥੀਂ ਦਰਜ ਕਰਨਾ ਅਤੇ ਡਿਵਾਈਸ ਉੱਤੇ ਆਵਾਜ਼ ਮੁਫ਼ਤ ਵਰਤ ਸਕਦੇ ਹੋ। Free ਵਿੱਚ ਹਰ ਕੈਲੰਡਰ ਮਹੀਨੇ 10 AI ਬੇਨਤੀਆਂ ਸ਼ਾਮਲ ਹਨ। ਹਰ ਮਹੀਨੇ 100 AI ਬੇਨਤੀਆਂ, ਵਿਗਿਆਪਨ ਰਹਿਤ ਵਰਤੋਂ ਅਤੇ ਬੈਕਅੱਪ ਲਈ ਸਾਲਾਨਾ Pro ਚੁਣੋ। ਤੁਹਾਡਾ ਮੌਜੂਦਾ ਡਾਟਾ ਤੁਹਾਡੇ ਕੋਲ ਹੀ ਰਹੇਗਾ।';

  @override
  String get planContinueFree => 'Free ਨਾਲ ਜਾਰੀ ਰੱਖੋ';

  @override
  String get supportIdLabel => 'ਸਹਾਇਤਾ ID';

  @override
  String get supportEmailLabel => 'ਈਮੇਲ ਸਹਾਇਤਾ';

  @override
  String get captureTipFirst =>
      'ਬਿਲਕੁਲ ਉੱਪਰੋਂ ਸ਼ੁਰੂ ਕਰੋ: ਦੁਕਾਨ ਦਾ ਨਾਮ ਅਤੇ ਮਿਤੀ ਦਿਸਣੀ ਚਾਹੀਦੀ ਹੈ। ਜਿੰਨੀਆਂ ਹੋ ਸਕੇ ਚੀਜ਼ਾਂ ਸ਼ਾਮਲ ਕਰੋ; ਬਾਕੀ ਅਗਲੀ ਤਸਵੀਰ ਵਿੱਚ ਆਉਣਗੀਆਂ।';

  @override
  String get captureTipContinue =>
      'ਉਹੀ ਰਸੀਦ: ਪਿਛਲੀ ਤਸਵੀਰ ਦੀ ਆਖਰੀ ਚੀਜ਼ ਸ਼ਾਮਲ ਕਰੋ।';

  @override
  String get captureTipNeverShow => 'ਦੁਬਾਰਾ ਨਾ ਦਿਖਾਓ';

  @override
  String get captureTipOk => 'ਸਮਝ ਗਿਆ';

  @override
  String get captureTipsSetting => 'ਰਸੀਦ ਕੈਪਚਰ ਸੁਝਾਅ ਦਿਖਾਓ';

  @override
  String get tourSkip => 'ਛੱਡੋ';

  @override
  String get tourNewListBody =>
      'ਖਰੀਦਦਾਰੀ ਸੂਚੀ ਸ਼ੁਰੂ ਕਰੋ ਅਤੇ ਜੋ ਖਰੀਦਣਾ ਹੈ ਉਹ ਜੋੜੋ।';

  @override
  String get tourFromReceiptBody =>
      'ਖਰੀਦਦਾਰੀ ਕਰ ਲਈ? ਰਸੀਦ ਨੂੰ ਉਸ ਦੀਆਂ ਕੀਮਤਾਂ ਸਮੇਤ ਸੂਚੀ ਵਿੱਚ ਬਦਲੋ।';

  @override
  String get tourReceiptFlowBody =>
      'ਰਸੀਦ ਦੇ ਉੱਪਰੋਂ ਸ਼ੁਰੂ ਕਰੋ: ਪਹਿਲਾਂ ਦੁਕਾਨ ਅਤੇ ਤਾਰੀਖ ਲਓ, ਫਿਰ ਬਾਕੀ ਲਾਈਨਾਂ ਨਾਲ ਜਾਰੀ ਰੱਖੋ।';

  @override
  String get tourTabsBody =>
      'ਸਰਗਰਮ, ਪੂਰੀਆਂ ਅਤੇ ਪੁਰਾਲੇਖ ਸੂਚੀਆਂ ਵਿਚਕਾਰ ਬਦਲੋ। ਅੰਤ ਵਾਲਾ ਬਟਨ ਕ੍ਰਮ ਬਦਲਦਾ ਹੈ।';

  @override
  String get tourDiscoverBody => 'ਉਸੇ ਡਿਵੈਲਪਰ ਦੀਆਂ ਹੋਰ ਐਪਾਂ ਦੇਖੋ।';

  @override
  String get tourHelpBody =>
      'ਇਹ ਗਾਈਡ ਦੁਬਾਰਾ ਦੇਖਣ ਲਈ ਇੱਥੇ ਟੈਪ ਕਰੋ। ਜੋੜ ਅਤੇ ਆਈਟਮਾਂ ਦੀ ਵਿਆਖਿਆ ਲਈ ਕੋਈ ਸੂਚੀ ਖੋਲ੍ਹੋ।';

  @override
  String get tourTotalsBody =>
      'ਯੋਜਨਾਬੱਧ, ਅਸਲ ਜੋੜ ਅਤੇ ਫਰਕ ਖਰੀਦਦਾਰੀ ਦੌਰਾਨ ਅੱਪਡੇਟ ਹੁੰਦੇ ਹਨ।';

  @override
  String get tourItemsBody =>
      'ਤੁਹਾਡੀਆਂ ਆਈਟਮਾਂ। ਇੱਥੇ ਇਹਨਾਂ ਦਾ ਕ੍ਰਮ ਬਦਲੋ ਜਾਂ ਲੱਭੋ।';
}
