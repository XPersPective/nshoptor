// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Sinhala Sinhalese (`si`).
class AppLocalizationsSi extends AppLocalizations {
  AppLocalizationsSi([String locale = 'si']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'නිවසේ සැලසුම් කරන්න. සැලසුම පරිදි ගමන් කරන්න.';

  @override
  String get listsTitle => 'පැහැදිලි කිරීම්';

  @override
  String get listsTabActive => 'ක්‍රියාකාරී';

  @override
  String get listsTabCompleted => 'සම්පූර්ණයි';

  @override
  String get listsTabArchived => 'ගබඩා කර ඇත';

  @override
  String get newListButton => 'නව ලැයිස්තුව';

  @override
  String get listTitleHint => 'මාතෘකාව (අභිමතය)';

  @override
  String get saveButton => 'ආරක්ෂා කරන්න';

  @override
  String get cancelButton => 'අවලංගු කරන්න';

  @override
  String get deleteButton => 'මකන්න';

  @override
  String get editAction => 'සංස්කරණය';

  @override
  String get listDeleted => 'ලැයිස්තුව මකා දමන ලදී';

  @override
  String get invalidAmountError => 'අවලංගු මුදල';

  @override
  String get duplicateAction => 'පිටපත් කරන්න';

  @override
  String get archiveAction => 'ගබඩා කරන්න';

  @override
  String get unarchiveAction => 'ගබඩාවෙන් ඉවත් කරන්න';

  @override
  String get deleteListConfirm =>
      'මෙම ලැයිස්තුව මකා දමන්නද? එහි සැලසුම් කරන ලද අයිතම ද ඉවත් වේ.';

  @override
  String get undoButton => 'පසුපසට';

  @override
  String get searchListHint => 'ලැයිස්තු සොයන්න';

  @override
  String get currencyLabel => 'මුදල්';

  @override
  String get budgetLabel => 'බජට් (අභිමතය)';

  @override
  String get noteLabel => 'සටහන (අභිමතය)';

  @override
  String get storeLabel => 'සාප්පුව';

  @override
  String get keepAmountsAction => 'මුදල් තබා ගන්න';

  @override
  String get resetAmountsAction => 'මුදල් නැවත සකසන්න';

  @override
  String get currencyChangeWarning =>
      'මුදල් වෙනස් වෙමින් පවතී. පවතින මුදල් සමඟ කුමක් කළ යුතුද?';

  @override
  String get listsEmpty => 'තවම ලැයිස්තු නැත. ඔබේ පළමු ගමන් සැලසුම සාදන්න.';

  @override
  String get statusDraft => 'කෙටුම්පත';

  @override
  String get statusPlanned => 'සැලසුම් කර ඇත';

  @override
  String get statusShopping => 'ගමන් කරමින්';

  @override
  String get statusCompleted => 'සම්පූර්ණයි';

  @override
  String get statusArchived => 'ගබඩා කර ඇත';

  @override
  String autoListTitle(String date) {
    return '$date ගමන්';
  }

  @override
  String get itemFormTitle => 'අයිතමයක් එක් කරන්න';

  @override
  String get itemNameLabel => 'අයිතමයේ නම';

  @override
  String get brandLabel => 'වෙළඳ නාමය / විශේෂාංගය (අභිමතය)';

  @override
  String get categoryLabel => 'වර්ගය';

  @override
  String get quantityLabel => 'ප්‍රමාණය';

  @override
  String get unitLabel => 'ඒකකය';

  @override
  String get pricingModeLabel => 'මිල ඇතුළත් කිරීම';

  @override
  String get pricingModeUnitPrice => 'ඒකක මිල';

  @override
  String get pricingModeLineTotal => 'පේළි මුළු';

  @override
  String get plannedPriceLabel => 'සැලසුම් කරන ලද මිල';

  @override
  String lineTotalCalculated(String value) {
    return 'පේළි මුළු: $value';
  }

  @override
  String get requiredItemToggle => 'අවශ්‍ය අයිතමය';

  @override
  String get maxPriceLabel => 'උපරිම පිළිගත හැකි මිල (අභිමතය)';

  @override
  String get itemNoteLabel => 'සටහන (අභිමතය)';

  @override
  String get categoryProduce => 'පලතුරු & එළවළු';

  @override
  String get categoryDairy => 'කිරි නිෂ්පාදන';

  @override
  String get categoryMeat => 'මස්';

  @override
  String get categoryBakery => 'බේකරි';

  @override
  String get categoryDrinks => 'පාන';

  @override
  String get categoryCleaning => 'පිරිසිදු කිරීම';

  @override
  String get categoryPersonalCare => 'පෞද්ගලික සත්කාර';

  @override
  String get categoryHome => 'නිවස';

  @override
  String get categoryOther => 'වෙනත්';

  @override
  String get invalidQuantityError => 'අවලංගු ප්‍රමාණය';

  @override
  String get invalidPriceError => 'අවලංගු මිල';

  @override
  String get invalidNameError => 'නමක් ඇතුළත් කරන්න';

  @override
  String unitPriceCalculated(String value) {
    return 'ඒකක මිල: $value';
  }

  @override
  String get shoppingTitle => 'සාප්පු සංචාරය';

  @override
  String get summaryPlannedTotal => 'නියමිත';

  @override
  String get summaryInCart => 'කොටුවේ ඇති';

  @override
  String get summaryRemainingPlan => 'ඉතිරි නියමිත';

  @override
  String get summaryProjected => 'අනුමිත ගෙවීම';

  @override
  String get summaryBudgetRemaining => 'බජැට් ඉතිරි';

  @override
  String get summaryBudgetOver => 'බජැට් ඉක්මවා';

  @override
  String itemsProgress(String done, String total) {
    return '$total අයිතම වලින් $done';
  }

  @override
  String get filterAll => 'සියල්ල';

  @override
  String get filterToBuy => 'ගැනීමට';

  @override
  String get filterInCart => 'කොටුවේ ඇති';

  @override
  String get filterNotFound => 'සොයාගත නොහැක';

  @override
  String get filterRequired => 'අවශ්‍ය';

  @override
  String get quickEntryTitle => 'සැබෑ මිල';

  @override
  String get actualQuantityLabel => 'සැබෑ ප්‍රමාණය';

  @override
  String get actualPriceLabel => 'සැබෑ මිල';

  @override
  String get discountLabel => 'හිස්කඩ (විකල්ප)';

  @override
  String get alternativeNameLabel => 'විකල්ප නිෂ්පාදන නාමය (විකල්ප)';

  @override
  String get savePurchaseButton => 'කොටුවට එක් කරන්න';

  @override
  String get unplannedAddButton => 'නියමිත නොවන අයිතමයක් එක් කරන්න';

  @override
  String get statusPending => 'ගෙන නැත';

  @override
  String get statusInCart => 'කොටුවේ ඇත';

  @override
  String get statusNotFound => 'සොයාගත නොහැක';

  @override
  String get statusGaveUp => 'අත් හැරියා';

  @override
  String get statusAlternative => 'විකල්පය ගත්තා';

  @override
  String get keepScreenAwake => 'තිරය ක්‍රියාත්මකව තබන්න';

  @override
  String get finishShopping => 'සාප්පු සංචාරය අවසන් කරන්න';

  @override
  String get completionWarning =>
      'අසම්පූර්ණ හෝ තහවුරු නොකළ වාර්තා ඇත. ඔබට අවසන් කළ හැක; ප්‍රතිඵලයේ ඒවා සටහන් වේ.';

  @override
  String get continueShoppingButton => 'සාප්පු සංචාරය කරගෙන යන්න';

  @override
  String get resultTitle => 'ප්‍රතිඵලය';

  @override
  String get summarySection => 'සාරාංශය';

  @override
  String get plannedTotalLabel => 'නියමිත මුළු මිල';

  @override
  String get actualTotalLabel => 'සැබෑ මුළු මිල';

  @override
  String get varianceLabel => 'වෙනස';

  @override
  String get varianceNotComputable => 'ගණනය කළ නොහැක';

  @override
  String get budgetStatusLabel => 'බජැට්';

  @override
  String get savingsLabel => 'නියමිතයට වඩා අඩු';

  @override
  String get overspendLabel => 'නියමිතයට වඩා වැඩි';

  @override
  String get unplannedTotalLabel => 'නියමිත නොවන මුළු මිල';

  @override
  String get unpurchasedLabel => 'නියමිත නමුත් ගත් නැත';

  @override
  String get totalDiscountLabel => 'මුළු හිස්කඩ';

  @override
  String get accuracyLabel => 'අනුමිත නිරවද්‍යතාව';

  @override
  String get groupsSection => 'අයිතම';

  @override
  String get groupPricier => 'නියමිතයට වඩා මිල වැඩි';

  @override
  String get groupCheaper => 'නියමිතයට වඩා මිල අඩු';

  @override
  String get groupClose => 'අනුමිතයට ආසන්න';

  @override
  String get groupNotTaken => 'නියමිත, නමුත් ගත් නැත';

  @override
  String get groupUnplanned => 'නියමිත නොවී ගත්';

  @override
  String get groupQuantityChanged => 'ප්‍රමාණය වෙනස් විය';

  @override
  String get groupUnverified => 'තහවුරු නොකළ';

  @override
  String get plannedQtyLabel => 'නියමිත ප්‍රමාණය';

  @override
  String get actualQtyLabel => 'සැබෑ ප්‍රමාණය';

  @override
  String get plannedUnitPriceLabel => 'නියමිත ඒකක මිල';

  @override
  String get actualUnitPriceLabel => 'සැබෑ ඒකක මිල';

  @override
  String get lineVarianceLabel => 'පේළි වෙනස';

  @override
  String get discountEffectLabel => 'හිස්කඩ බලපෑම';

  @override
  String get notBoughtMark => 'ගත් නැත';

  @override
  String get noPurchasesNote => 'මිලදී ගැනීම් වාර්තා වී නැත.';

  @override
  String get navHome => 'මුල් පිටුව';

  @override
  String get navLists => 'ලිස්ට්';

  @override
  String get navHistory => 'ඉතිහාසය';

  @override
  String get navSettings => 'සැකසුම්';

  @override
  String get homeEmptyTitle => 'ඔබේ ගමනාගමනය සැලසුම් කරන්න';

  @override
  String get homeEmptyBody =>
      'ඔබේ පළමු ලිස්ට් එක නිර්මාණය කර සැලසුම් කළ මිල සහ වියදම් සංසන්දනය කරන්න.';

  @override
  String get homeActiveSection => 'ක්‍රියාකාරී ලිස්ට්';

  @override
  String get homeCompletedSection => 'ඉතා ආසන්නයේ අවසන් වූ';

  @override
  String get homeMonthlySection => 'මෙම මාසය';

  @override
  String get monthPlannedLabel => 'සැලසුම් කළ';

  @override
  String get monthActualLabel => 'ඇත්ත වශයෙන්ම';

  @override
  String get monthVarianceLabel => 'වෙනස';

  @override
  String get continueShoppingLabel => 'ගමනාගමනය කරගෙන යන්න';

  @override
  String get historyEmpty =>
      'තවම අවසන් වූ ගමනාගමනයක් නැත. ඔබේ ඉතිහාසය සහ විශ්ලේෂණ මෙහි දිස්වේ.';

  @override
  String get aboutTabTitle => 'NShoptor ගැන';

  @override
  String get aboutBody =>
      'Crazy Penguin විසින් නිර්මාණය කරන ලද NShoptor. Offline-first ගමනාගමන සැලසුම්කරු. GPL-3.0 බලපත්‍රය යටතේ.';

  @override
  String get startShoppingLabel => 'ගමනාගමනය ආරම්භ කරන්න';

  @override
  String get finishAndSeeResult => 'අවසන් කර ප්‍රතිඵල බලන්න';

  @override
  String get settingsTitle => 'සැකසුම්';

  @override
  String get languageLabel => 'භාෂාව';

  @override
  String get languageSystem => 'පද්ධතිය';

  @override
  String get languageTr => 'තුර්කි';

  @override
  String get languageEn => 'ඉංග්‍රීසි';

  @override
  String get themeLabel => 'තේමාව';

  @override
  String get themeSystem => 'පද්ධතිය';

  @override
  String get themeLight => 'ආලෝක';

  @override
  String get themeDark => 'අඳුරු';

  @override
  String get defaultCurrencyLabel => 'පෙරනිමි මුදල්';

  @override
  String get defaultUnitLabel => 'පෙරනිමි ඒකකය';

  @override
  String get keepAwakeLabel => 'ගමනාගමනය කරන විට තිරය සජීවීව තබන්න';

  @override
  String get backupSection => 'බැකප්';

  @override
  String get exportBackupLabel => 'බැකප් අපනයනය කරන්න';

  @override
  String get importBackupLabel => 'බැකප් ආනයනය කරන්න';

  @override
  String get mergeImportLabel => 'වත්මන් දත්තවලට එකතු කරන්න';

  @override
  String get separateImportLabel => 'වෙන් වූ පිටපතක් ලෙස ආනයනය කරන්න';

  @override
  String get importCancelled => 'ආනයනය අවලංගු කරන ලදී.';

  @override
  String get backupExported => 'බැකප් සාර්ථකව අපනයනය කරන ලදී.';

  @override
  String get backupSizeWarning =>
      'විශාල බැකප්: ගොනුව විශාල විය හැක. ඡායාරූප ද ඇතුළත් කිරීමට අවශ්‍යද?';

  @override
  String get deleteAllSection => 'ඛේදවාචක කලාපය';

  @override
  String get deleteAllLabel => 'සියලු දත්ත මකන්න';

  @override
  String get deleteAllConfirm =>
      'මෙය ලිස්ට්, ඉතිහාසය, රිසිට්පත් ඡායාරූප සහ මිල ගණන් සියල්ල ඉවත් කරයි. ඔබ විසින් අපනයනය කරන ලද ගොනු ඔබේ ධාවකයේ පවතී. ඉදිරියට යන්නද?';

  @override
  String get deleteAllConfirm2 =>
      'ඔබට සම්පූර්ණයෙන්ම විශ්වාසද? මෙම ක්‍රියාව ආපසු හැරවිය නොහැක.';

  @override
  String get cancelAction => 'අවලංගු කරන්න';

  @override
  String get confirmDelete => 'සදාකාලිකව මකන්න';

  @override
  String get dataDeleted => 'සියලුම දේශීය දත්ත මකන ලදී.';

  @override
  String get privacyInfoLabel => 'පෞද්ගලිකත්වය';

  @override
  String get privacyInfoBody =>
      'ඔබේ ලිස්ට්, මිල, රිසිට්පත් සහ ඡායාරූප ඔබේ උපාංගයේම පවතී. ඡායාරූප සහ හඬ කිසිවිටෙක එයින් පිටවන්නේ නැත. AI ආධාරය සක්‍රිය වූ විට, පමණක් පාඨය (උදා: රිසිට්පත් පේළි හෝ ඔබ කතා කළ දේ) සැකසීම සඳහා අපගේ සර්වරයට යවන අතර එය ගබඩා නොකෙරේ.';

  @override
  String get aboutSection => 'ගැන';

  @override
  String get aboutPublisher => 'ප්‍රකාශකයා: Crazy Penguin';

  @override
  String get aboutLicenses => 'බලපත්‍ර (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'හඳුන්වාදීම';

  @override
  String get voiceStatusUnknown => 'සේවය: පරීක්ෂා කර නැත';

  @override
  String get permissionsLabel => 'අවසර';

  @override
  String get permissionsBody =>
      'කැමරාව, මයික්‍රොෆෝනය සහ දැනුම්දීම් ඔබ එම විශේෂාංග භාවිතා කරන විට පමණක් ඉල්ලා සිටී.';

  @override
  String get unitsSection => 'පෙරනිමි';

  @override
  String get roundingNote =>
      'මුදල් වටකුරු කිරීම එක් නීතියක් අනුගමනය කරයි: ශතකයන් ශුන්‍යයෙන් ඈත් වන පරිදි වටකුරු කරන අතර, මුදල් පරිවර්තනයේදී එක් වරක් පමණක් යොදයි.';

  @override
  String get voiceInputTitle => 'හඳුන්වාදීම';

  @override
  String get voiceStartListening => 'සවන් දීම ආරම්භ කරන්න';

  @override
  String get voiceTranscriptLabel => 'පිටපත';

  @override
  String get parseAction => 'විශ්ලේෂණය කරන්න';

  @override
  String get receiptReviewTitle => 'රිසිට්පත සමාලෝචනය කරන්න';

  @override
  String get receiptTotal => 'රිසිට් එකේ මුළු මිල';

  @override
  String get receiptTotalUnknown => 'මුළු මිල හඳුනාගත නොහැක';

  @override
  String get receiptDiff => 'වෙනස';

  @override
  String get acceptLine => 'අදාළ පේළිය අනුමත කරන්න';

  @override
  String get ignoreLine => 'පේළිය නොසලකා හරින්න';

  @override
  String get receiptLineActions =>
      'භාණ්ඩය සමඟ සම්බන්ධ කරන්න, කොටස් දෙකකට බෙදන්න හෝ නොසලකා හරින්න';

  @override
  String get receiptCommit => 'සියල්ල අනුමත කරන්න';

  @override
  String get receiptCommitted => 'රිසිට් එක යොදා ඇත.';

  @override
  String get priceHistoryTitle => 'මිල ඉතිහාසය';

  @override
  String get noObservations => 'තවම මිල නිරීක්ෂණ නැත';

  @override
  String get templatesSection => 'ආකෘති';

  @override
  String get templateHint => 'පෙර ගමනාන්තයකින් නව සැලැස්මක් සාදන්න';

  @override
  String get scanReceiptAction => 'රිසිට් එක ස්කෑන් කරන්න';

  @override
  String get shelfLabelAction => 'තට්ටු ලේබලයේ මිල';

  @override
  String get priceCandidatesTitle => 'මිල අපේක්ෂක';

  @override
  String get noPriceCandidates => 'මිලක් හමු නොවීය; අතින් ඇතුළත් කරන්න.';

  @override
  String get voiceUnavailable => 'හඬ හඳුනාගැනීම අලබ්ධයි; අතින් ඇතුළත් කරන්න.';

  @override
  String get linkToItem => 'භාණ්ඩයට සම්බන්ධ කරන්න';

  @override
  String get splitLine => 'කොටස් දෙකකට බෙදන්න';

  @override
  String get mergeWithNext => 'ඊළඟ සමඟ ඒකාබද්ධ කරන්න';

  @override
  String get ocrNoText => 'පාඨය කියවා නැත; නැවත උත්සාහ කරන්න.';

  @override
  String get priceHistoryAction => 'මිල ඉතිහාසය';

  @override
  String get itemsEmptyTitle => 'තවම භාණ්ඩ නැත';

  @override
  String get itemsEmptyBody =>
      'ඔබේ පළමු භාණ්ඩය එකතු කරන්න — වෙළඳසැලේදී සැබෑ මිල මෙහි ඇතුළත් කරනු ලැබේ.';

  @override
  String get addItemTooltip => 'භාණ්ඩය එකතු කරන්න';

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
  String get unitCustom => 'අභිරුචි';

  @override
  String get setReminderAction => 'සිහිපත් කිරීම සකසන්න';

  @override
  String get reminderPermissionDenied =>
      'සිහිපත් කිරීම් සඳහා දැනුම්දීම් අවසරය අවශ්‍ය වේ. ඔබට පද්ධති සැකසුම්වලින් එය සක්‍රිය කළ හැක.';

  @override
  String get reminderScheduled => 'සිහිපත් කිරීම සකසා ඇත.';

  @override
  String get reminderCancelled => 'සිහිපත් කිරීම ඉවත් කර ඇත.';

  @override
  String get reminderTitle => 'ගමනාන්ත සිහිපත් කිරීම';

  @override
  String reminderBody(Object title) {
    return 'ඔබේ ලැයිස්තුව පරීක්ෂා කිරීමට කාලයයි: $title';
  }

  @override
  String get reminderPickDate => 'දිනයක් තෝරන්න';

  @override
  String get reminderPickTime => 'වේලාවක් තෝරන්න';

  @override
  String get itemDetailsSection => 'විස්තර';

  @override
  String get priceOptionalHint =>
      'විකල්පයි — වෙළඳසැලේදී සැබෑ මිල ඔබ ඇතුළත් කරනු ලැබේ';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'සැලසුම්ගත: $total · $count භාණ්ඩ';
  }

  @override
  String get proActiveLabel => 'Pro සක්‍රියයි — ස්තූතියි!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'විज्ञापन නැත, වැඩි AI, බැක්අප් · කුඩා මාසික මිලකින්';

  @override
  String get proBenefitNoAds => 'විज्ञापන රහිත අත්දැකීම';

  @override
  String get proBenefitBackup => 'බැක්අප් (නිර්ගත/ආයාත)';

  @override
  String aboutVersion(Object version) {
    return 'අනුවාදය $version';
  }

  @override
  String get navDiscover => 'සොයා ගන්න';

  @override
  String get shareAction => 'ඇප් එක බෙදා ගන්න';

  @override
  String get rateAction => 'අපට අගය කරන්න';

  @override
  String get aboutOpenRow => 'පිළිබඳව සහ විවෘත මූලාශ්‍ර';

  @override
  String get voiceAddItemAction => 'හඬ මගින් එකතු කරන්න';

  @override
  String get formatLocaleLabel => 'අංක සහ මුදල් ආකෘතිය';

  @override
  String get formatLocaleSystem =>
      'උපාංග ආකෘතිය (ලතින් අංක; වෙනත් ස්ථානවල ඉංග්‍රීසි)';

  @override
  String get formatLocaleTr => 'තුර්කි (1.234,56)';

  @override
  String get formatLocaleEn => 'ඉංග්‍රීසි (1,234.56)';

  @override
  String get aiToggleTitle => 'AI උදව්';

  @override
  String get aiToggleSubtitle =>
      'ලැබුම් පත් ගැළපේ, මිල ලේබල් කියවේ සහ වාක්‍ය ලැයිස්තු බවට පත් කරයි. ඡායාරූප සහ ශබ්ද ඔබේ උපාංගයේ පවතී; පාඨය පමණක් සැකසේ.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'මෙම මාසයේ AI ඉල්ලීම් ($used/$limit) ඔබ භාවිතා කර ඇත. වැඩිපුර ලබා ගැනීමට නැග්ග්‍රේඩ් කරන්න හෝ AI නොමැතිව සිටින්න.';
  }

  @override
  String get aiOffline => 'සම්බන්ධතාවයක් නැත — AI නොමැතිව සිටී.';

  @override
  String get aiFailed => 'AI දැනට නොලබා ගත හැකිය — එය නොමැතිව සිටී.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'උපාංගය';

  @override
  String get quickListAction => 'වාක්‍යයකින් එකතු කරන්න';

  @override
  String get quickListTitle => 'ඉක්මන් ලැයිස්තුව';

  @override
  String get quickListHint => 'උදා: 1 kg සෙව් 20, රුක්ක 2, කිරි 1/2 kg';

  @override
  String get quickListConvert => 'ලැයිස්තුවක් බවට පත් කරන්න';

  @override
  String quickListAdd(int count) {
    return '$count අයිතම එකතු කරන්න';
  }

  @override
  String get quickListEmpty =>
      'අයිතම හමු නොවීය. ඒවා අවධානම් වෙන් කර ලැයිස්තුගත කරන්න.';

  @override
  String get receiptAiMatched =>
      'AI ලැබුම් පත ඔබේ ලැයිස්තුවට ගැළපී ඇත. සබැඳි පරීක්ෂා කර තහවුරු කරන්න.';

  @override
  String get receiptNeedsCheck => 'මෙම ගැළපීම පරීක්ෂා කරන්න';

  @override
  String get receiptDiscountLine => 'හැඳින්වීම';

  @override
  String get compareItem => 'අයිතමය';

  @override
  String get compareEstimated => 'ඇස්තමේන්තු';

  @override
  String get compareActual => 'සැබෑ';

  @override
  String get compareDiff => 'වෙනස';

  @override
  String get compareTotal => 'එකතුව';

  @override
  String get compareBudget => 'බජට්';

  @override
  String get compareNotBought => 'මිලදී ගත්තේ නැත';

  @override
  String get compareUnplanned => 'ප්‍රතිපාදනය කර නැත';

  @override
  String get pricierItems => 'වැඩි මිලක් ගෙවීය';

  @override
  String get cheaperItems => 'අඩු මිලක් ගෙවීය';

  @override
  String get compareAction => 'සසඳන්න';

  @override
  String get detailsSection => 'විස්තර';

  @override
  String get spendingTitle => 'ආදායම';

  @override
  String get spendingAction => 'ආදායම';

  @override
  String get spendingMonthTotal => 'මෙම මාසය';

  @override
  String get spendingWeekly => 'සතිපතා ආදායම';

  @override
  String get spendingMonthly => 'මාසික ආදායම';

  @override
  String get monthlyLimitTitle => 'මාසික සීමාව';

  @override
  String get monthlyLimitHelp => 'ඔබ මාසයකට ගෙවීමට කොපමණ මුදලක් කැමතිද?';

  @override
  String get monthlyLimitRemove => 'ඉවත් කරන්න';

  @override
  String get monthlyLimitSet => 'සකසන්න';

  @override
  String get monthlyLimitChange => 'වෙනස් කරන්න';

  @override
  String get monthlyLimitNone =>
      'ඔබට කොපමණ මුදලක් ඉතිරිව ඇත්දැයි බැලීමට මාසික සීමාවක් සකසන්න.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount සීමාව ඉක්මවා ඇත';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return 'මෙම මාසයේ $amount ඉතිරිව ඇත';
  }

  @override
  String get plansTitle => 'ප්‍රතිපාදන';

  @override
  String get plansHeadline => 'AI සමඟ බුද්ධිමත්ව ගමන් කරන්න';

  @override
  String get plansSubhead =>
      'ලැබුම් පත් ගැළපීම, මිල ලේබල් සහ වාක්‍යයකින් ලැයිස්තු. ඕනෑම වේලාවක අවලංගු කරන්න.';

  @override
  String get plansMonthly => 'මාසික';

  @override
  String get plansYearly => 'වාර්ෂික';

  @override
  String get planFree => 'නිදහස්';

  @override
  String get planFreePrice => 'සදාකාලිකව නිදහස්';

  @override
  String get planFreeAi => 'මාසයකට AI ඉල්ලීම් 10';

  @override
  String get planFreeAds =>
      'කුඩා බැනර් විज्ञापन (ඔබේ පළමු දින 7 තුළ කිසිවක් නැත)';

  @override
  String get planCoreFeatures => 'ලැයිස්තු, මිල, ලැබුම් පත්, ආදායම චාට්';

  @override
  String get plansPerYear => '/ වසර';

  @override
  String get plansPerMonth => '/ මාසය';

  @override
  String get planTrial => 'දින 7 නිදහස්';

  @override
  String get planProAi => 'මාසයකට AI ඉල්ලීම් 100';

  @override
  String get planNoAds => 'විज्ञापन නැත';

  @override
  String get planBackup => 'බැකප් අපනයනය සහ ආයාතය';

  @override
  String get planMaxAi => 'මාසයට AI ඉල්ලීම් 300ක්';

  @override
  String get planMaxFamily => 'විශාල පවුල් මිලදී ගැනීම් සඳහා';

  @override
  String get plansStoreUnavailable => 'මෙම වෙළඳසැල දැනට ලබාගත නොහැක.';

  @override
  String get retryAction => 'නැවත උත්සාහ කරන්න';

  @override
  String get plansPurchaseFailed =>
      'මිලදී ගැනීම සාර්ථක නොවීය. කරුණාකර නැවත උත්සාහ කරන්න.';

  @override
  String get planLifetimeTitle => 'ජීවිත කාලයක් තිරසාරව විज्ञापन රහිතව';

  @override
  String get planLifetimeSubtitle =>
      'එක් වරක් ගෙවීම: විज्ञापන නැත, බැකප්; AI නොමිලේ ලබා දෙන ප්‍රමාණය තුළ පවතී';

  @override
  String get plansRestore => 'මිලදී ගැනීම් යළි පිහිටුවන්න';

  @override
  String get plansLegal =>
      'අදාළ ගිණුම් කල් ඉකුත් වන තෙක් ස්වයංක්‍රීයව නවීකරණය වේ. Google Play › ගෙවීම් සහ අදාළ ගිණුම් හරහා ඕනෑම වේලාවක අවලංගු කළ හැක. මිල ගණන් වලට Google Play මගින් පෙන්වන බදු ඇතුළත් වේ.';

  @override
  String get planCurrent => 'වත්මන්';

  @override
  String get planStartTrial => 'දින 7ක නොමිලේ පරීක්ෂණය ආරම්භ කරන්න';

  @override
  String get planChoose => 'තෝරන්න';

  @override
  String get plansAction => 'ප්ලැන්: Pro සහ Max';

  @override
  String get assistantTitle => 'සහායක';

  @override
  String get assistantGreeting => 'හෙලෝ! ඔබට කුමක් කිරීමට අවශ්‍යද?';

  @override
  String get assistantNewList => 'නව ලැයිස්තුව';

  @override
  String get assistantVoiceList => 'හඬ මගින් ලැයිස්තුව';

  @override
  String get assistantTextList => 'වාක්‍යයකින් ලැයිස්තුව';

  @override
  String get assistantScanReceipt => 'බිල්පතක් ස්කෑන් කරන්න';

  @override
  String get assistantSpending => 'මගේ වියදම්';

  @override
  String get assistantReceiptHint =>
      'ඔබේ ලැයිස්තුව විවෘත කර ස්කෑන් කිරීම සඳහා බිල්පත අයිකනය ටැප් කරන්න.';

  @override
  String get assistantToggleTitle => 'සහායක පෙන්වන්න';

  @override
  String get assistantToggleSubtitle => 'දකුණු පස පහළ ඇති කුඩා සහායකයා';

  @override
  String get scanPriceLabel => 'මිල ලේබලය ස්කෑන් කරන්න';

  @override
  String get saveFailed =>
      'සුරැකීමට නොහැක. ඔබේ වෙනස්කම් තවමත් ඇත. කරුණාකර නැවත උත්සාහ කරන්න.';

  @override
  String get deleteItemConfirm =>
      'මෙම අයිතමය සහ එහි ලියාපදිංචි කළ මිලදී ගැනීම් ඉවත් කරන්නද?';

  @override
  String get clearPurchaseConfirm =>
      'මෙම අයිතමයේ තෝරාගැනීම ඉවත් කර එහි ලියාපදිංචි කළ මිලදී ගැනීම් ඉවත් කරන්නද?';

  @override
  String get reportPdfAction => 'PDF වාර්තාව සුරැකන්න';

  @override
  String get reportNotInvoice =>
      'සාප්පු සෑදීමේ සාරාංශය, බදු විකුණුම් බිල්පතක් නොවේ. බදු අනුපාත නොදනී.';

  @override
  String get purchaseVisits => 'සාප්පු සෑදීමේ පිටවීම්';

  @override
  String get purchaseInterval => 'මිලදී ගැනීම් අතර සාමාන්‍ය දින';

  @override
  String get purchasedQuantity => 'මිලදී ගත් ප්‍රමාණය';

  @override
  String get purchaseAnalyticsHint =>
      'මිලදී ගැනීම් පරිභෝජනය මනින්නේ නැත. මුදල් ඒකක සහ ඒකක වෙන්ව පෙන්වයි.';

  @override
  String get receiptReplaces =>
      'සම්බන්ධිත රිසිට් පේළි පවතින මිලදී ගැනීම් වෙනුවට ගනී; අසම්බන්ධිත පේළි එකතු කෙරේ.';

  @override
  String get voiceUnsupportedLanguage =>
      'මෙම භාෂාව මෙම උපාංගයේ හඬ ඇතුළත් කිරීම සඳහා ලබා දී නැත. ඔබට ටයිප් කළ හැක.';

  @override
  String get voiceStopListening => 'අසන්න නතර කරන්න';

  @override
  String get keepAwakeFailed =>
      'තිරය අවදි තත්ත්වයෙන් තබා ගත නොහැක. කරුණාකර නැවත උත්සාහ කරන්න.';

  @override
  String get purchaseHistoryHint =>
      'සියලුම සම්පූර්ණ කරන ලද ගැනුම්. ආපසු ගෙවීම් මුළු වටිනාකම් අඩු කරයි. දිනා ගැනීමේ දින පෙන්වයි. එක් වරක් පමණක් මධ්‍යන්‍ය කාලය ගණනය කිරීමට ප්‍රමාණවත් නොවේ.';

  @override
  String get planLegacyRights =>
      'පවතින Pro සහ Max ගාස්තුදායක සඳුදාලිත මාසික AI ඉඩකඩ පවත්වා ගනී. නව වට්ටම් 100 සහ 300 ඉල්ලීම් ඇතුළත් වේ.';

  @override
  String get csvExportAction => 'CSV අපනයනය කරන්න';
}
