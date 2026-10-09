// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malayalam (`ml`).
class AppLocalizationsMl extends AppLocalizations {
  AppLocalizationsMl([String locale = 'ml']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'വീട്ടിൽ പ്ലാൻ ചെയ്യുക. പ്ലാൻ പ്രകാരം വാങ്ങുക.';

  @override
  String get listsTitle => 'ലിസ്റ്റുകൾ';

  @override
  String get listsTabActive => 'സജീവം';

  @override
  String get listsTabCompleted => 'പൂർത്തിയായത്';

  @override
  String get listsTabArchived => 'ആർക്കൈവ് ചെയ്തത്';

  @override
  String get newListButton => 'പുതിയ ലിസ്റ്റ്';

  @override
  String get listTitleHint => 'തലക്കെട്ട് (ഓപ്ഷണൽ)';

  @override
  String get saveButton => 'സേവ് ചെയ്യുക';

  @override
  String get cancelButton => 'റദ്ദാക്കുക';

  @override
  String get deleteButton => 'ഇല്ലാതാക്കുക';

  @override
  String get editAction => 'എഡിറ്റ് ചെയ്യുക';

  @override
  String get listDeleted => 'ലിസ്റ്റ് ഇല്ലാതാക്കി';

  @override
  String get invalidAmountError => 'അസാധുവായ തുക';

  @override
  String get duplicateAction => 'ഡുപ്ലിക്കേറ്റ് ചെയ്യുക';

  @override
  String get archiveAction => 'ആർക്കൈവ് ചെയ്യുക';

  @override
  String get unarchiveAction => 'ആർക്കൈവിൽ നിന്ന് പുറത്തെടുക്കുക';

  @override
  String get deleteListConfirm =>
      'ഈ ലിസ്റ്റ് ഇല്ലാതാക്കണോ? അതിലെ പ്ലാൻ ചെയ്ത ആവശ്യങ്ങളും നീക്കംചെയ്യപ്പെടും.';

  @override
  String get undoButton => 'മുമ്പത്തെ പോലെയാക്കുക';

  @override
  String get searchListHint => 'ലിസ്റ്റുകളിൽ തിരയുക';

  @override
  String get currencyLabel => 'നാണയം';

  @override
  String get budgetLabel => 'ബജറ്റ് (ഓപ്ഷണൽ)';

  @override
  String get noteLabel => 'കുറിപ്പ് (ഓപ്ഷണൽ)';

  @override
  String get storeLabel => 'കട';

  @override
  String get keepAmountsAction => 'തുകകൾ സംരക്ഷിക്കുക';

  @override
  String get resetAmountsAction => 'തുകകൾ റീസെറ്റ് ചെയ്യുക';

  @override
  String get currencyChangeWarning =>
      'നാണയം മാറുന്നു. ഉള്ള തുകകളെന്ത് സംഭവിക്കണം?';

  @override
  String get listsEmpty =>
      'ഇതുവരെ ലിസ്റ്റുകളില്ല. നിങ്ങളുടെ ആദ്യ ഷോപ്പിംഗ് പ്ലാൻ സൃഷ്ടിക്കുക.';

  @override
  String get statusDraft => 'ഡ്രാഫ്റ്റ്';

  @override
  String get statusPlanned => 'പ്ലാൻ ചെയ്തത്';

  @override
  String get statusShopping => 'വാങ്ങുന്ന സമയത്ത്';

  @override
  String get statusCompleted => 'പൂർത്തിയായത്';

  @override
  String get statusArchived => 'ആർക്കൈവ് ചെയ്തത്';

  @override
  String autoListTitle(String date) {
    return '$date ഷോപ്പിംഗ്';
  }

  @override
  String get itemFormTitle => 'ആവശ്യം ചേർക്കുക';

  @override
  String get itemNameLabel => 'ആവശ്യത്തിന്റെ പേര്';

  @override
  String get brandLabel => 'ബ്രാൻഡ് / വേരിയന്റ് (ഓപ്ഷണൽ)';

  @override
  String get categoryLabel => 'ക്ലാസ്';

  @override
  String get quantityLabel => 'പരിമാണം';

  @override
  String get unitLabel => 'യൂണിറ്റ്';

  @override
  String get pricingModeLabel => 'വില നൽകൽ';

  @override
  String get pricingModeUnitPrice => 'യൂണിറ്റ് വില';

  @override
  String get pricingModeLineTotal => 'ലൈൻ ആകെത്തുക';

  @override
  String get plannedPriceLabel => 'പ്ലാൻ ചെയ്ത വില';

  @override
  String lineTotalCalculated(String value) {
    return 'ലൈൻ ആകെത്തുക: $value';
  }

  @override
  String get requiredItemToggle => 'ആവശ്യമായ ആവശ്യം';

  @override
  String get maxPriceLabel => 'ഗ്രഹിക്കാവുന്ന പരമാവധി വില (ഓപ്ഷണൽ)';

  @override
  String get itemNoteLabel => 'കുറിപ്പ് (ഓപ്ഷണൽ)';

  @override
  String get categoryProduce => 'പഴങ്ങൾ & കായ്ക്കറികൾ';

  @override
  String get categoryDairy => 'ഡെയറി';

  @override
  String get categoryMeat => 'മാംസം';

  @override
  String get categoryBakery => 'ബേക്കറി';

  @override
  String get categoryDrinks => 'പാനീയങ്ങൾ';

  @override
  String get categoryCleaning => 'ശുചീകരണം';

  @override
  String get categoryPersonalCare => 'വ്യക്തിഗത പരിചരണം';

  @override
  String get categoryHome => 'വീട്';

  @override
  String get categoryOther => 'മറ്റുള്ളവ';

  @override
  String get invalidQuantityError => 'അസാധുവായ പരിമാണം';

  @override
  String get invalidPriceError => 'അസാധുവായ വില';

  @override
  String get invalidNameError => 'ഒരു പേര് നൽകുക';

  @override
  String unitPriceCalculated(String value) {
    return 'ഏകക വില: $value';
  }

  @override
  String get shoppingTitle => 'ഷോപ്പിംഗ് മോഡ്';

  @override
  String get summaryPlannedTotal => 'പദ്ധതി ചെയ്തത്';

  @override
  String get summaryInCart => 'കാർട്ടിൽ';

  @override
  String get summaryRemainingPlan => 'ബാക്കിയുള്ള പദ്ധതി';

  @override
  String get summaryProjected => 'അനുമാനിച്ച ചെക്ക്ഔട്ട്';

  @override
  String get summaryBudgetRemaining => 'ബജറ്റ് ബാക്കി';

  @override
  String get summaryBudgetOver => 'ബജറ്റിന് മുകളിൽ';

  @override
  String itemsProgress(String done, String total) {
    return '$total ആവശ്യങ്ങളിൽ $done';
  }

  @override
  String get filterAll => 'എല്ലാം';

  @override
  String get filterToBuy => 'വാങ്ങേണ്ടത്';

  @override
  String get filterInCart => 'കാർട്ടിൽ';

  @override
  String get filterNotFound => 'കണ്ടെത്തിയില്ല';

  @override
  String get filterRequired => 'ആവശ്യമായത്';

  @override
  String get quickEntryTitle => 'യഥാർത്ഥ വില';

  @override
  String get actualQuantityLabel => 'യഥാർത്ഥ അളവ്';

  @override
  String get actualPriceLabel => 'യഥാർത്ഥ വില';

  @override
  String get discountLabel => 'ഡിസ്കൗണ്ട് (ഓപ്ഷണൽ)';

  @override
  String get alternativeNameLabel => 'മറ്റൊരു ഉൽപ്പന്നത്തിന്റെ പേര് (ഓപ്ഷണൽ)';

  @override
  String get savePurchaseButton => 'കാർട്ടിലേക്ക് ചേർക്കുക';

  @override
  String get unplannedAddButton => 'പദ്ധതിയില്ലാത്ത വസ്തു ചേർക്കുക';

  @override
  String get statusPending => 'വാങ്ങിയിട്ടില്ല';

  @override
  String get statusInCart => 'കാർട്ടിൽ';

  @override
  String get statusNotFound => 'കണ്ടെത്തിയില്ല';

  @override
  String get statusGaveUp => 'വിട്ടു';

  @override
  String get statusAlternative => 'മറ്റൊന്ന് വാങ്ങി';

  @override
  String get keepScreenAwake => 'സ്ക്രീൻ ഓണായി നിലനിർത്തുക';

  @override
  String get finishShopping => 'ഷോപ്പിംഗ് പൂർത്തിയാക്കുക';

  @override
  String get completionWarning =>
      'ചില വിവരങ്ങൾ ലഭ്യമല്ല അല്ലെങ്കിൽ സ്ഥിരീകരിച്ചിട്ടില്ല. നിങ്ങൾക്ക് പൂർത്തിയാക്കാം; ഫലത്തിൽ ഇത് രേഖപ്പെടുത്തും.';

  @override
  String get continueShoppingButton => 'ഷോപ്പിംഗ് തുടരുക';

  @override
  String get resultTitle => 'ഫലം';

  @override
  String get summarySection => 'സംഗ്രഹം';

  @override
  String get plannedTotalLabel => 'പദ്ധതി ചെയ്ത ആകെത്തുക';

  @override
  String get actualTotalLabel => 'യഥാർത്ഥ ആകെത്തുക';

  @override
  String get varianceLabel => 'വ്യത്യാസം';

  @override
  String get varianceNotComputable => 'കണക്കാക്കാൻ കഴിയില്ല';

  @override
  String get budgetStatusLabel => 'ബജറ്റ്';

  @override
  String get savingsLabel => 'പദ്ധതിയേക്കാൾ കുറവ്';

  @override
  String get overspendLabel => 'പദ്ധതിയേക്കാൾ കൂടുതൽ';

  @override
  String get unplannedTotalLabel => 'പദ്ധതിയില്ലാത്ത ആകെത്തുക';

  @override
  String get unpurchasedLabel => 'പദ്ധതി ചെയ്തെങ്കിലും വാങ്ങിയില്ല';

  @override
  String get totalDiscountLabel => 'ആകെ ഡിസ്കൗണ്ടുകൾ';

  @override
  String get accuracyLabel => 'അനുമാനത്തിന്റെ കൃത്യത';

  @override
  String get groupsSection => 'ഉൽപ്പന്നങ്ങൾ';

  @override
  String get groupPricier => 'പദ്ധതിയേക്കാൾ വിലകൂടിയത്';

  @override
  String get groupCheaper => 'പദ്ധതിയേക്കാൾ വിലകുറഞ്ഞത്';

  @override
  String get groupClose => 'അനുമാനത്തിന് സമീപം';

  @override
  String get groupNotTaken => 'പദ്ധതി ചെയ്തെങ്കിലും വാങ്ങിയില്ല';

  @override
  String get groupUnplanned => 'പദ്ധതിയില്ലാതെ വാങ്ങിയത്';

  @override
  String get groupQuantityChanged => 'അളവ് മാറ്റി';

  @override
  String get groupUnverified => 'സ്ഥിരീകരിച്ചിട്ടില്ല';

  @override
  String get plannedQtyLabel => 'പദ്ധതി ചെയ്ത അളവ്';

  @override
  String get actualQtyLabel => 'യഥാർത്ഥ അളവ്';

  @override
  String get plannedUnitPriceLabel => 'പദ്ധതി ചെയ്ത ഏകക വില';

  @override
  String get actualUnitPriceLabel => 'യഥാർത്ഥ ഏകക വില';

  @override
  String get lineVarianceLabel => 'വരി വ്യത്യാസം';

  @override
  String get discountEffectLabel => 'ഡിസ്കൗണ്ടിന്റെ പ്രഭാവം';

  @override
  String get notBoughtMark => 'വാങ്ങിയിട്ടില്ല';

  @override
  String get noPurchasesNote => 'ഒരു വാങ്ങലും രേഖപ്പെടുത്തിയിട്ടില്ല.';

  @override
  String get navHome => 'ഹോം';

  @override
  String get navLists => 'ലിസ്റ്റുകൾ';

  @override
  String get navHistory => 'ചരിത്രം';

  @override
  String get navSettings => 'സെറ്റിംഗുകൾ';

  @override
  String get homeEmptyTitle => 'നിങ്ങളുടെ വാങ്ങൽ പദ്ധതിയിടുക';

  @override
  String get homeEmptyBody =>
      'ആദ്യ ലിസ്റ്റ് സൃഷ്ടിക്കുക, പദ്ധതി ചെയ്തതും യഥാർത്ഥ ചെലവും താരതമ്യം ചെയ്യുക.';

  @override
  String get homeActiveSection => 'സജീവ ലിസ്റ്റുകൾ';

  @override
  String get homeCompletedSection => 'ഇപ്പോൾ പൂർത്തിയാക്കിയവ';

  @override
  String get homeMonthlySection => 'ഈ മാസം';

  @override
  String get monthPlannedLabel => 'പദ്ധതി ചെയ്തത്';

  @override
  String get monthActualLabel => 'യഥാർത്ഥം';

  @override
  String get monthVarianceLabel => 'വ്യത്യാസം';

  @override
  String get continueShoppingLabel => 'വാങ്ങൽ തുടരുക';

  @override
  String get historyEmpty =>
      'ഇതുവരെ പൂർത്തിയാക്കിയ വാങ്ങലുകളൊന്നുമില്ല. നിങ്ങളുടെ ചരിത്രവും വിശകലനങ്ങളും ഇവിടെ കാണാം.';

  @override
  String get aboutTabTitle => 'NShoptor-നെക്കുറിച്ച്';

  @override
  String get aboutBody =>
      'Crazy Penguin-ന്റെ NShoptor. ഓഫ്‌ലൈൻ-ഫസ്റ്റ് ഷോപ്പിംഗ് പ്ലാനർ. GPL-3.0 ലൈസൻസിൽ ലഭ്യമാണ്.';

  @override
  String get startShoppingLabel => 'വാങ്ങൽ ആരംഭിക്കുക';

  @override
  String get finishAndSeeResult => 'പൂർത്തിയാക്കി ഫലം കാണുക';

  @override
  String get settingsTitle => 'സെറ്റിംഗുകൾ';

  @override
  String get languageLabel => 'ഭാഷ';

  @override
  String get languageSystem => 'സിസ്റ്റം';

  @override
  String get languageTr => 'ടർക്കിഷ്';

  @override
  String get languageEn => 'ഇംഗ്ലീഷ്';

  @override
  String get themeLabel => 'തീം';

  @override
  String get themeSystem => 'സിസ്റ്റം';

  @override
  String get themeLight => 'പ്രകാശം';

  @override
  String get themeDark => 'ഇരുട്ട്';

  @override
  String get defaultCurrencyLabel => 'ഡിഫോൾട്ട് കറൻസി';

  @override
  String get defaultUnitLabel => 'ഡിഫോൾട്ട് യൂണിറ്റ്';

  @override
  String get keepAwakeLabel => 'വാങ്ങുമ്പോൾ സ്ക്രീൻ ഓൺ നിലനിർത്തുക';

  @override
  String get backupSection => 'ബാക്ക്അപ്പ്';

  @override
  String get exportBackupLabel => 'ബാക്ക്അപ്പ് എക്സ്പോർട്ട് ചെയ്യുക';

  @override
  String get importBackupLabel => 'ബാക്ക്അപ്പ് ഇമ്പോർട്ട് ചെയ്യുക';

  @override
  String get mergeImportLabel => 'നിലവിലെ ഡാറ്റയിൽ സംയോജിപ്പിക്കുക';

  @override
  String get separateImportLabel => 'ഒരു പ്രത്യേക പകർപ്പായി ഇമ്പോർട്ട് ചെയ്യുക';

  @override
  String get importCancelled => 'ഇമ്പോർട്ട് റദ്ദാക്കി.';

  @override
  String get backupExported => 'ബാക്ക്അപ്പ് വിജയകരമായി എക്സ്പോർട്ട് ചെയ്തു.';

  @override
  String get backupSizeWarning =>
      'വലിയ ബാക്ക്അപ്പ്: ഫയൽ വലുതാകാം. ഫോട്ടോകളും ഉൾപ്പെടുത്തണോ?';

  @override
  String get deleteAllSection => 'അപകട മേഖല';

  @override
  String get deleteAllLabel => 'എല്ലാ ഡാറ്റയും ഡിലീറ്റ് ചെയ്യുക';

  @override
  String get deleteAllConfirm =>
      'ഇത് എല്ലാ ലിസ്റ്റുകളും, ചരിത്രവും, റിസീറ്റ് ഫോട്ടോകളും വിലകളും നീക്കം ചെയ്യും. നിങ്ങൾ എക്സ്പോർട്ട് ചെയ്ത ഫയലുകൾ നിങ്ങളുടെ ഡ്രൈവിൽ തുടരും. തുടരണോ?';

  @override
  String get deleteAllConfirm2 =>
      'നിങ്ങൾക്ക് പൂർണ്ണമായും ഉറപ്പുണ്ടോ? ഈ പ്രവർത്തനം പിന്നീട് റദ്ദാക്കാൻ കഴിയില്ല.';

  @override
  String get cancelAction => 'റദ്ദാക്കുക';

  @override
  String get confirmDelete => 'സ്ഥിരമായി ഡിലീറ്റ് ചെയ്യുക';

  @override
  String get dataDeleted => 'എല്ലാ ലോക്കൽ ഡാറ്റയും ഡിലീറ്റ് ചെയ്തു.';

  @override
  String get privacyInfoLabel => 'ഗോപ്യത';

  @override
  String get privacyInfoBody =>
      'നിങ്ങളുടെ ലിസ്റ്റുകൾ, വിലകൾ, റിസീറ്റുകൾ, ഫോട്ടോകൾ എന്നിവ നിങ്ങളുടെ ഉപകരണത്തിൽ തന്നെ നിലനിൽക്കുന്നു. ഫോട്ടോകളും ശബ്ദവും അവിടെ നിന്ന് പുറത്തുപോകുന്നില്ല. AI സഹായം സജീവമാകുമ്പോൾ, പ്രോസസ്സിംഗിനായി ടെക്സ്റ്റ് (ഉദാഹരണത്തിന് റിസീറ്റ് വരികൾ അല്ലെങ്കിൽ നിങ്ങൾ പറഞ്ഞത്) മാത്രം നമ്മുടെ സർവർിലേക്ക് അയക്കുന്നു, അത് സംഭരിക്കില്ല.';

  @override
  String get aboutSection => 'കുറിച്ച്';

  @override
  String get aboutPublisher => 'പ്രസാധകൻ: Crazy Penguin';

  @override
  String get aboutLicenses => 'ലൈസൻസുകൾ (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'ശബ്ദ ഇൻപുട്ട്';

  @override
  String get voiceStatusUnknown => 'സർവീസ്: പരിശോധിച്ചിട്ടില്ല';

  @override
  String get permissionsLabel => 'അനുവാദങ്ങൾ';

  @override
  String get permissionsBody =>
      'ക്യാമറ, മൈക്രോഫോൺ, നോട്ടിഫിക്കേഷനുകൾ എന്നിവ നിങ്ങൾ ആ ഫീച്ചറുകൾ ഉപയോഗിക്കുമ്പോൾ മാത്രം ആവശ്യപ്പെടുന്നു.';

  @override
  String get unitsSection => 'ഡിഫോൾട്ടുകൾ';

  @override
  String get roundingNote =>
      'പണം റൗണ്ട് ചെയ്യുന്നത് ഒരു നിയമം പിന്തുടരുന്നു: പകുതികൾ പൂജ്യത്തിൽ നിന്ന് അകലേക്ക് റൗണ്ട് ചെയ്യുന്നു, പണത്തിന്റെ രൂപാന്തരത്തിൽ ഒരിക്കൽ മാത്രം പ്രയോഗിക്കുന്നു.';

  @override
  String get voiceInputTitle => 'ശബ്ദ ഇൻപുട്ട്';

  @override
  String get voiceStartListening => 'കേൾക്കാൻ ആരംഭിക്കുക';

  @override
  String get voiceTranscriptLabel => 'ട്രാൻസ്ക്രിപ്റ്റ്';

  @override
  String get parseAction => 'പാർസ് ചെയ്യുക';

  @override
  String get receiptReviewTitle => 'റിസീറ്റ് അവലോകനം';

  @override
  String get receiptTotal => 'റീസീപ്റ്റിലെ ആകെത്തുക';

  @override
  String get receiptTotalUnknown => 'ആകെത്തുക കണ്ടെത്തിയില്ല';

  @override
  String get receiptDiff => 'വ്യത്യാസം';

  @override
  String get acceptLine => 'ലൈൻ സ്വീകരിക്കുക';

  @override
  String get ignoreLine => 'ലൈൻ ഒഴിവാക്കുക';

  @override
  String get receiptLineActions =>
      'ഉൽപ്പന്നവുമായി ബന്ധിപ്പിക്കുക, വിഭജിക്കുക അല്ലെങ്കിൽ ഒഴിവാക്കുക';

  @override
  String get receiptCommit => 'എല്ലാം സ്വീകരിക്കുക';

  @override
  String get receiptCommitted => 'റീസീപ്റ്റ് പ്രയോഗിച്ചു.';

  @override
  String get priceHistoryTitle => 'വില ചരിത്രം';

  @override
  String get noObservations => 'ഇതുവരെ വില നിരീക്ഷണങ്ങളൊന്നുമില്ല';

  @override
  String get templatesSection => 'ടെമ്പ്ലേറ്റുകൾ';

  @override
  String get templateHint =>
      'മുമ്പത്തെ ഷോപ്പിംഗ് യാത്രയിൽ നിന്ന് ഒരു പുതിയ പദ്ധതി സൃഷ്ടിക്കുക';

  @override
  String get scanReceiptAction => 'റീസീപ്റ്റ് സ്കാൻ ചെയ്യുക';

  @override
  String get shelfLabelAction => 'ഷെൽഫ് ലേബലിൽ നിന്നുള്ള വില';

  @override
  String get priceCandidatesTitle => 'വില ഉദ്ദേശ്യങ്ങൾ';

  @override
  String get noPriceCandidates => 'വില കണ്ടെത്തിയില്ല; കൈയിൽ നൽകുക.';

  @override
  String get voiceUnavailable => 'സ്പീച്ച് റെക്കഗ്നിഷൻ ലഭ്യമല്ല; കൈയിൽ നൽകുക.';

  @override
  String get linkToItem => 'ഉൽപ്പന്നവുമായി ബന്ധിപ്പിക്കുക';

  @override
  String get splitLine => 'രണ്ടായി വിഭജിക്കുക';

  @override
  String get mergeWithNext => 'അടുത്തതുമായി സംയോജിപ്പിക്കുക';

  @override
  String get ocrNoText => 'ഒരു വചനവും വായിച്ചില്ല; വീണ്ടും ശ്രമിക്കുക.';

  @override
  String get priceHistoryAction => 'വില ചരിത്രം';

  @override
  String get itemsEmptyTitle => 'ഇതുവരെ ഉൽപ്പന്നങ്ങളൊന്നുമില്ല';

  @override
  String get itemsEmptyBody =>
      'നിങ്ങളുടെ ആദ്യ ഉൽപ്പന്നം ചേർക്കുക — കടയിൽ വെച്ച് യഥാർത്ഥ വിലകൾ ഇവിടെ നൽകും.';

  @override
  String get addItemTooltip => 'ഉൽപ്പന്നം ചേർക്കുക';

  @override
  String get unitAdet => 'പീസ്';

  @override
  String get unitKilogram => 'കിലോ';

  @override
  String get unitGram => 'ഗ്രാം';

  @override
  String get unitLitre => 'ലിറ്റർ';

  @override
  String get unitMililitre => 'മില്ലി';

  @override
  String get unitPaket => 'പായ്ക്ക്';

  @override
  String get unitKutu => 'ബോക്സ്';

  @override
  String get unitSise => 'ബോട്ടിൽ';

  @override
  String get unitKavanoz => 'ജാർ';

  @override
  String get unitDemet => 'കൂട്ടം';

  @override
  String get unitDuzine => 'ഡസൻ';

  @override
  String get unitMetre => 'മീറ്റർ';

  @override
  String get unitCustom => 'കസ്റ്റം';

  @override
  String get setReminderAction => 'റിമായ്ൻഡർ സജ്ജമാക്കുക';

  @override
  String get reminderPermissionDenied =>
      'റിമായ്ൻഡറുകൾക്ക് നോട്ടിഫിക്കേഷൻ അനുമതി ആവശ്യമാണ്. സിസ്റ്റം സെറ്റിങ്ങുകളിൽ ഇത് സജ്ജമാക്കാം.';

  @override
  String get reminderScheduled => 'റിമായ്ൻഡർ സജ്ജമാക്കി.';

  @override
  String get reminderCancelled => 'റിമായ്ൻഡർ നീക്കം ചെയ്തു.';

  @override
  String get reminderTitle => 'ഷോപ്പിംഗ് റിമായ്ൻഡർ';

  @override
  String reminderBody(Object title) {
    return 'നിങ്ങളുടെ ലിസ്റ്റ് പരിശോധിക്കാനുള്ള സമയം: $title';
  }

  @override
  String get reminderPickDate => 'ഒരു തീയതി തിരഞ്ഞെടുക്കുക';

  @override
  String get reminderPickTime => 'ഒരു സമയം തിരഞ്ഞെടുക്കുക';

  @override
  String get itemDetailsSection => 'വിശദാംശങ്ങൾ';

  @override
  String get priceOptionalHint => 'ഐച്ഛികം — കടയിൽ വെച്ച് യഥാർത്ഥ വില നൽകും';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'പദ്ധതി: $total · $count ഉൽപ്പന്നങ്ങൾ';
  }

  @override
  String get proActiveLabel => 'Pro സജീവം — നന്ദി!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'അഡ്‌സ് ഇല്ല, കൂടുതൽ AI, ബാക്ക്‌അപ്പ് · കുറഞ്ഞ മാസിക വിലയിൽ';

  @override
  String get proBenefitNoAds => 'അഡ്‌സ് ഇല്ലാത്ത അനുഭവം';

  @override
  String get proBenefitBackup => 'ബാക്ക്‌അപ്പ് (എക്സ്പോർട്ട്/ഇംപോർട്ട്)';

  @override
  String aboutVersion(Object version) {
    return 'വേർഷൻ $version';
  }

  @override
  String get navDiscover => 'കണ്ടെത്തുക';

  @override
  String get shareAction => 'ആപ്പ് പങ്കിടുക';

  @override
  String get rateAction => 'ഞങ്ങളെ മൂല്യനിർണ്ണയം ചെയ്യുക';

  @override
  String get aboutOpenRow => 'എപ്പോൾ & اوپن സോഴ്സ്';

  @override
  String get voiceAddItemAction => 'വോയ്‌സ് വഴി ചേർക്കുക';

  @override
  String get formatLocaleLabel => 'സംഖ്യയും നാണയ ഫോമാറ്റും';

  @override
  String get formatLocaleSystem =>
      'ഡിവൈസ് ഫോർമാറ്റ് (ലാറ്റിൻ അക്കങ്ങൾ; മറ്റുള്ളവ ഇംഗ്ലീഷ്)';

  @override
  String get formatLocaleTr => 'ടർക്കിഷ് (1.234,56)';

  @override
  String get formatLocaleEn => 'ഇംഗ്ലീഷ് (1,234.56)';

  @override
  String get aiToggleTitle => 'AI സഹായം';

  @override
  String get aiToggleSubtitle =>
      'റീസീറ്റുകൾ മെച്ചപ്പെടുത്തുന്നു, വില ലേബലുകൾ വായിക്കുന്നു, വാചകങ്ങളെ പട്ടികയാക്കുന്നു. ഫോട്ടോകളും ശബ്ദവും നിങ്ങളുടെ ഉപകരണത്തിൽ തന്നെ; വരികൾ മാത്രം പ്രോസസ്സ് ചെയ്യുന്നു.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'ഈ മാസത്തെ AI അഭ്യർത്ഥനകൾ ($used/$limit) നിങ്ങൾ ഉപയോഗിച്ചു. കൂടുതൽ ആവശ്യമെങ്കിൽ അപ്‌ഗ്രേഡ് ചെയ്യുക, അല്ലെങ്കിൽ AI ഇല്ലാതെ തുടരുക.';
  }

  @override
  String get aiOffline => 'കണക്ഷൻ ഇല്ല — AI ഇല്ലാതെ തുടരുന്നു.';

  @override
  String get aiFailed => 'AI ഇപ്പോൾ ലഭ്യമല്ല — അത് ഇല്ലാതെ തുടരുന്നു.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'ഉപകരണം';

  @override
  String get quickListAction => 'വാചകത്തിൽ നിന്ന് ചേർക്കുക';

  @override
  String get quickListTitle => 'ക്വിക്ക് ലിസ്റ്റ്';

  @override
  String get quickListHint => 'ഉദാ: 1 kg ആപ്പിൾ 20, 2 ബ്രെഡ്, പകുതി കിലോ ചീസ്';

  @override
  String get quickListConvert => 'പട്ടികയാക്കുക';

  @override
  String quickListAdd(int count) {
    return '$count വസ്തുക്കൾ ചേർക്കുക';
  }

  @override
  String get quickListEmpty =>
      'ഒരു വസ്തുവും കണ്ടെത്തിയില്ല. കോമ ഉപയോഗിച്ച് വേർതിരിച്ച് എഴുതുക.';

  @override
  String get receiptAiMatched =>
      'AI നിങ്ങളുടെ ലിസ്റ്റുമായി റീസീറ്റ് മെച്ചപ്പെടുത്തി. ലിങ്കുകൾ പരിശോധിക്കുകയും സ്ഥിരീകരിക്കുകയും ചെയ്യുക.';

  @override
  String get receiptNeedsCheck => 'ഈ മെച്ചപ്പെടുത്തൽ പരിശോധിക്കുക';

  @override
  String get receiptDiscountLine => 'ഡിസ്കൗണ്ട്';

  @override
  String get compareItem => 'വസ്തു';

  @override
  String get compareEstimated => 'അനുമാനം';

  @override
  String get compareActual => 'യഥാർത്ഥം';

  @override
  String get compareDiff => 'വ്യത്യാസം';

  @override
  String get compareTotal => 'ആകെ';

  @override
  String get compareBudget => 'ബജറ്റ്';

  @override
  String get compareNotBought => 'വാങ്ങിയില്ല';

  @override
  String get compareUnplanned => 'പദ്ധതിയിട്ടതല്ല';

  @override
  String get pricierItems => 'കൂടുതൽ ചെലവ്';

  @override
  String get cheaperItems => 'കുറഞ്ഞ ചെലവ്';

  @override
  String get compareAction => 'താരതമ്യം ചെയ്യുക';

  @override
  String get detailsSection => 'വിശദാംശങ്ങൾ';

  @override
  String get spendingTitle => 'ചെലവ്';

  @override
  String get spendingAction => 'ചെലവ്';

  @override
  String get spendingMonthTotal => 'ഈ മാസം';

  @override
  String get spendingWeekly => 'ആഴ്ചവారی ചെലവ്';

  @override
  String get spendingMonthly => 'മാസവാരী ചെലവ്';

  @override
  String get monthlyLimitTitle => 'മാസ പരിധി';

  @override
  String get monthlyLimitHelp =>
      'മാസത്തിൽ ഷോപ്പിങ്ങിന് എത്ര ചെലവ് ചെയ്യാൻ ആഗ്രഹിക്കുന്നു?';

  @override
  String get monthlyLimitRemove => 'നീക്കം ചെയ്യുക';

  @override
  String get monthlyLimitSet => 'സജ്ജമാക്കുക';

  @override
  String get monthlyLimitChange => 'മാറ്റുക';

  @override
  String get monthlyLimitNone =>
      'എത്ര അവശേഷിക്കുന്നു എന്ന് കാണാൻ ഒരു മാസ പരിധി സജ്ജമാക്കുക.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount പരിധി കവിഞ്ഞു';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return 'ഈ മാസം $amount അവശേഷിക്കുന്നു';
  }

  @override
  String get plansTitle => 'പ്ലാനുകൾ';

  @override
  String get plansHeadline => 'AI ഉപയോഗിച്ച് ബുദ്ധിശാലിയായി ഷോപ്പ് ചെയ്യുക';

  @override
  String get plansSubhead =>
      'റീസീറ്റ് മെച്ചപ്പെടുത്തൽ, വില ലേബലുകൾ, വാചകത്തിൽ നിന്നുള്ള പട്ടികകൾ. ഏത് സമയത്തും റദ്ദാക്കാം.';

  @override
  String get plansMonthly => 'മാസം';

  @override
  String get plansYearly => 'വർഷം';

  @override
  String get planFree => 'നിർമ്മാണം';

  @override
  String get planFreePrice => 'എപ്പോഴും സൗജന്യം';

  @override
  String get planFreeAi => 'മാസത്തിൽ 15 AI അഭ്യർത്ഥനകൾ';

  @override
  String get planFreeAds => 'ചെറിയ ബാനർ വിജ്ഞാപനങ്ങൾ (ആദ്യ 7 ദിവസങ്ങളിൽ ഇല്ല)';

  @override
  String get planCoreFeatures => 'പട്ടികകൾ, വിലകൾ, റീസീറ്റുകൾ, ചെലവ് ഗ്രാഫുകൾ';

  @override
  String get plansPerYear => '/ വർഷം';

  @override
  String get plansPerMonth => '/ മാസം';

  @override
  String get planTrial => '7 ദിവസം സൗജന്യം';

  @override
  String get planProAi => 'മാസത്തിൽ 200 AI അഭ്യർത്ഥനകൾ';

  @override
  String get planNoAds => 'വിജ്ഞാപനങ്ങളില്ല';

  @override
  String get planBackup => 'ബാക്ക്‌അപ്പ് എക്സ്പോർട്ടും ഇംപോർട്ടും';

  @override
  String get planMaxAi => 'മാസത്തിൽ 1000 AI അഭ്യർത്ഥനകൾ';

  @override
  String get planMaxFamily => 'വലിയ കുടുംബങ്ങളുടെ ഷോപ്പിംഗിന്';

  @override
  String get plansStoreUnavailable => 'ഇപ്പോൾ സ്റ്റോറിൽ എത്താൻ കഴിയില്ല.';

  @override
  String get retryAction => 'മറുപടി നൽകുക';

  @override
  String get plansPurchaseFailed =>
      'വാങ്ങൽ പൂർത്തിയാകുന്നില്ല. ദയവായി വീണ്ടും ശ്രമിക്കുക.';

  @override
  String get planLifetimeTitle => 'ജീവിതകാലം മുഴുവൻ അഡ്-ഫ്രീ';

  @override
  String get planLifetimeSubtitle =>
      'ഒരിക്കൽ മാത്രം പേയ്‌മെന്റ്: അഡ്‌സ് ഇല്ല, ബാക്ക്‌അപ്പ്; AI സൗജന്യ ലൈംസിറ്റിയിൽ തുടരുന്നു';

  @override
  String get plansRestore => 'വാങ്ങലുകൾ പുനഃസ്ഥാപിക്കുക';

  @override
  String get plansLegal =>
      'റദ്ദാക്കുന്നത് വരെ സബ്‌സ്ക്രിപ്ഷനുകൾ സ്വയം പുതുക്കുന്നു. Google Play › Payments & subscriptions-ൽ എപ്പോൾ വേണമെങ്കിലും റദ്ദാക്കാം. വിലകളിൽ Google Play കാണിക്കുന്ന നികുതികൾ ഉൾപ്പെടുന്നു.';

  @override
  String get planCurrent => 'നിലവിലുള്ളത്';

  @override
  String get planStartTrial => '7-ദിവസത്തെ സൗജന്യ ട്രയൽ ആരംഭിക്കുക';

  @override
  String get planChoose => 'തിരഞ്ഞെടുക്കുക';

  @override
  String get plansAction => 'പ്ലാനുകൾ: Pro and Max';

  @override
  String get assistantTitle => 'അസിസ്റ്റന്റ്';

  @override
  String get assistantGreeting => 'ഹായ്! എന്ത് ചെയ്യാൻ ആഗ്രഹിക്കുന്നു?';

  @override
  String get assistantNewList => 'പുതിയ ലിസ്റ്റ്';

  @override
  String get assistantVoiceList => 'വോയിസ് വഴി ലിസ്റ്റ്';

  @override
  String get assistantTextList => 'ഒരു വാചകത്തിൽ നിന്ന് ലിസ്റ്റ്';

  @override
  String get assistantScanReceipt => 'റീസീറ്റ് സ്കാൻ ചെയ്യുക';

  @override
  String get assistantSpending => 'എന്റെ ചെലവുകൾ';

  @override
  String get assistantReceiptHint =>
      'നിങ്ങളുടെ ലിസ്റ്റ് തുറന്ന് സ്കാൻ ചെയ്യാൻ റീസീറ്റ് آیکон ടാപ്പ് ചെയ്യുക.';

  @override
  String get assistantToggleTitle => 'അസിസ്റ്റന്റ് കാണിക്കുക';

  @override
  String get assistantToggleSubtitle => 'വലതുവശത്ത് താഴെയുള്ള ചെറിയ സഹായി';

  @override
  String get scanPriceLabel => 'വില ലേബൽ സ്കാൻ ചെയ്യുക';

  @override
  String get saveFailed =>
      'സേവ് ചെയ്യാൻ കഴിഞ്ഞില്ല. നിങ്ങളുടെ മാറ്റങ്ങൾ ഇപ്പോഴും ഉണ്ട്. ദയവായി വീണ്ടും ശ്രമിക്കുക.';

  @override
  String get deleteItemConfirm =>
      'ഈ ആइटം及其 രേഖപ്പെടുത്തിയ വാങ്ങലുകൾ ഡിലീറ്റ് ചെയ്യണോ?';

  @override
  String get clearPurchaseConfirm =>
      'ഈ ആइटം അൺചെക്ക് ചെയ്ത് its രേഖപ്പെടുത്തിയ വാങ്ങലുകൾ നീക്കം ചെയ്യണോ?';

  @override
  String get reportPdfAction => 'PDF റിപ്പോർട്ട് സേവ് ചെയ്യുക';

  @override
  String get reportNotInvoice =>
      'ഷോപ്പിംഗ് സംഗ്രഹം, ടാക്സ് ഇൻവോയിസ് അല്ല. ടാക്സ് നിരക്കുകൾ അജ്ഞാതമാണ്.';

  @override
  String get purchaseVisits => 'ഷോപ്പിംഗ് സന്ദർശനങ്ങൾ';

  @override
  String get purchaseInterval => 'വാങ്ങലുകൾ തമ്മിലുള്ള ശരാശരി ദിവസങ്ങൾ';

  @override
  String get purchasedQuantity => 'വാങ്ങിയ അളവ്';

  @override
  String get purchaseAnalyticsHint =>
      'വാങ്ങലുകൾ ഉപഭോഗത്തെ അളക്കുന്നില്ല. കറൻസികളും യൂണിറ്റുകളും പ്രത്യേകമായി കാണിക്കുന്നു.';

  @override
  String get receiptReplaces =>
      'ലിങ്ക് ചെയ്ത റിസീറ്റ് ലൈനുകൾ existing വാങ്ങലുകൾ മാറ്റിസ്ഥാപിക്കുന്നു; ലിങ്ക് ചെയ്യാത്ത ലൈനുകൾ ചേർക്കുന്നു.';

  @override
  String get voiceUnsupportedLanguage =>
      'ഈ ഭാഷ ഈ ഉപകരണത്തിൽ വോയ്സ് ഇൻപുട്ടിന് ലഭ്യമല്ല. പകരം ടൈപ്പ് ചെയ്യാം.';

  @override
  String get voiceStopListening => 'കേൾക്കൽ നിർത്തുക';
}
