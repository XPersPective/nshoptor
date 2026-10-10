// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class AppLocalizationsTa extends AppLocalizations {
  AppLocalizationsTa([String locale = 'ta']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'வீட்டில் திட்டமிடுங்கள். திட்டப்படி வாங்குங்கள்.';

  @override
  String get listsTitle => 'பட்டியல்கள்';

  @override
  String get listsTabActive => 'செயலில் உள்ளது';

  @override
  String get listsTabCompleted => 'முடிந்தது';

  @override
  String get listsTabArchived => 'தொகுக்கப்பட்டவை';

  @override
  String get newListButton => 'புதிய பட்டியல்';

  @override
  String get listTitleHint => 'தலைப்பு (விருப்பம்)';

  @override
  String get saveButton => 'சேமி';

  @override
  String get cancelButton => 'ரத்து செய்';

  @override
  String get deleteButton => 'அழி';

  @override
  String get editAction => 'திருத்து';

  @override
  String get listDeleted => 'பட்டியல் அழிக்கப்பட்டது';

  @override
  String get invalidAmountError => 'தவறான தொகை';

  @override
  String get duplicateAction => 'இரட்டிப்பாக்கு';

  @override
  String get archiveAction => 'தொகு';

  @override
  String get unarchiveAction => 'தொகுப்பிலிருந்து நீக்கு';

  @override
  String get deleteListConfirm =>
      'இந்த பட்டியலை அழிக்க வேண்டுமா? அதன் திட்டமிடப்பட்ட பொருட்களும் நீக்கப்படும்.';

  @override
  String get undoButton => 'மீட்டமை';

  @override
  String get searchListHint => 'பட்டியல்களைத் தேடு';

  @override
  String get currencyLabel => 'நாணயம்';

  @override
  String get budgetLabel => 'பட்ஜெட் (விருப்பம்)';

  @override
  String get noteLabel => 'குறிப்பு (விருப்பம்)';

  @override
  String get storeLabel => 'கடை';

  @override
  String get keepAmountsAction => 'தொகைகளைப் பாதுகா';

  @override
  String get resetAmountsAction => 'தொகைகளை மீட்டமை';

  @override
  String get currencyChangeWarning =>
      'நாணயம் மாற்றப்படுகிறது. ஏற்கனவே உள்ள தொகைகளுடன் என்ன நடக்க வேண்டும்?';

  @override
  String get listsEmpty =>
      'இன்னும் பட்டியல்கள் இல்லை. உங்கள் முதல் வாங்குதல் திட்டத்தை உருவாக்குங்கள்.';

  @override
  String get statusDraft => 'வரைவு';

  @override
  String get statusPlanned => 'திட்டமிடப்பட்டது';

  @override
  String get statusShopping => 'வாங்குகிறேன்';

  @override
  String get statusCompleted => 'முடிந்தது';

  @override
  String get statusArchived => 'தொகுக்கப்பட்டது';

  @override
  String autoListTitle(String date) {
    return '$date வாங்குதல்';
  }

  @override
  String get itemFormTitle => 'பொருளைச் சேர்';

  @override
  String get itemNameLabel => 'பொருள் பெயர்';

  @override
  String get brandLabel => 'பிராண்ட் / மாறுபாடு (விருப்பம்)';

  @override
  String get categoryLabel => 'வகை';

  @override
  String get quantityLabel => 'அளவு';

  @override
  String get unitLabel => 'அலகு';

  @override
  String get pricingModeLabel => 'விலை பதிவு';

  @override
  String get pricingModeUnitPrice => 'ஒரு அலகு விலை';

  @override
  String get pricingModeLineTotal => 'மொத்த வரிசை விலை';

  @override
  String get plannedPriceLabel => 'திட்டமிடப்பட்ட விலை';

  @override
  String lineTotalCalculated(String value) {
    return 'மொத்த வரிசை விலை: $value';
  }

  @override
  String get requiredItemToggle => 'தேவையான பொருள்';

  @override
  String get maxPriceLabel => 'ஏற்றுக்கொள்ளக்கூடிய அதிகபட்ச விலை (விருப்பம்)';

  @override
  String get itemNoteLabel => 'குறிப்பு (விருப்பம்)';

  @override
  String get categoryProduce => 'பழங்கள் & காய்கறிகள்';

  @override
  String get categoryDairy => 'பால் பொருட்கள்';

  @override
  String get categoryMeat => 'இறைச்சி';

  @override
  String get categoryBakery => 'பேக்கரி';

  @override
  String get categoryDrinks => 'பானங்கள்';

  @override
  String get categoryCleaning => 'சுத்தம்';

  @override
  String get categoryPersonalCare => 'தனிப்பட்ட பராமரிப்பு';

  @override
  String get categoryHome => 'வீட்டுப் பொருட்கள்';

  @override
  String get categoryOther => 'மற்றவை';

  @override
  String get invalidQuantityError => 'தவறான அளவு';

  @override
  String get invalidPriceError => 'தவறான விலை';

  @override
  String get invalidNameError => 'ஒரு பெயரை உள்ளிடவும்';

  @override
  String unitPriceCalculated(String value) {
    return 'அலகு விலை: $value';
  }

  @override
  String get shoppingTitle => 'வாங்குதல் பயன்முறை';

  @override
  String get summaryPlannedTotal => 'திட்டமிட்ட மொத்தம்';

  @override
  String get summaryInCart => 'கார்டில் உள்ளது';

  @override
  String get summaryRemainingPlan => 'மீதமுள்ள திட்டம்';

  @override
  String get summaryProjected => 'எதிர்பார்க்கப்படும் கட்டவு';

  @override
  String get summaryBudgetRemaining => 'மீதமுள்ள பட்ஜெட்';

  @override
  String get summaryBudgetOver => 'பட்ஜெட்டிற்கு மேல்';

  @override
  String itemsProgress(String done, String total) {
    return '$total பொருள்களில் $done';
  }

  @override
  String get filterAll => 'அனைத்தும்';

  @override
  String get filterToBuy => 'வாங்க வேண்டியவை';

  @override
  String get filterInCart => 'கார்டில் உள்ளது';

  @override
  String get filterNotFound => 'கிடைக்கவில்லை';

  @override
  String get filterRequired => 'தேவையானவை';

  @override
  String get quickEntryTitle => 'உண்மையான விலை';

  @override
  String get actualQuantityLabel => 'உண்மையான அளவு';

  @override
  String get actualPriceLabel => 'உண்மையான விலை';

  @override
  String get discountLabel => 'தள்ளுபடி (விருப்பம்)';

  @override
  String get alternativeNameLabel => 'மாற்றுப் பொருள் பெயர் (விருப்பம்)';

  @override
  String get savePurchaseButton => 'கார்டில் சேர்';

  @override
  String get unplannedAddButton => 'திட்டமிடாத பொருளைச் சேர்';

  @override
  String get statusPending => 'எடுக்கப்படவில்லை';

  @override
  String get statusInCart => 'கார்டில் உள்ளது';

  @override
  String get statusNotFound => 'கிடைக்கவில்லை';

  @override
  String get statusGaveUp => 'விட்டுவிடப்பட்டது';

  @override
  String get statusAlternative => 'மாற்று வாங்கப்பட்டது';

  @override
  String get keepScreenAwake => 'திரையை எழுப்பியிரு';

  @override
  String get finishShopping => 'வாங்கலை முடி';

  @override
  String get completionWarning =>
      'சில குறிப்புகள் இல்லாமல் இருக்கின்றன அல்லது உறுதிப்படுத்தப்படவில்லை. நீங்கள் தொடரலாம்; முடிவில் அவற்றைக் குறிப்பிடுவோம்.';

  @override
  String get continueShoppingButton => 'வாங்கலைத் தொடர்';

  @override
  String get resultTitle => 'முடிவு';

  @override
  String get summarySection => 'சுருக்கம்';

  @override
  String get plannedTotalLabel => 'திட்டமிட்ட மொத்தம்';

  @override
  String get actualTotalLabel => 'உண்மையான மொத்தம்';

  @override
  String get varianceLabel => 'வழக்கு வித்தியாசம்';

  @override
  String get varianceNotComputable => 'கணக்கிட முடியவில்லை';

  @override
  String get budgetStatusLabel => 'பட்ஜெட்';

  @override
  String get savingsLabel => 'திட்டத்திற்குக் கீழே';

  @override
  String get overspendLabel => 'திட்டத்திற்கு மேல்';

  @override
  String get unplannedTotalLabel => 'திட்டமிடாத மொத்தம்';

  @override
  String get unpurchasedLabel => 'திட்டமிடப்பட்டது ஆனால் வாங்கப்படவில்லை';

  @override
  String get totalDiscountLabel => 'மொத்த தள்ளுபடி';

  @override
  String get accuracyLabel => 'மதிப்பீடு துல்லியம்';

  @override
  String get groupsSection => 'பொருள்கள்';

  @override
  String get groupPricier => 'திட்டத்தை விட விலை அதிகம்';

  @override
  String get groupCheaper => 'திட்டத்தை விட விலை குறைவு';

  @override
  String get groupClose => 'மதிப்பீட்டிற்கு அருகில்';

  @override
  String get groupNotTaken => 'திட்டமிடப்பட்டது, வாங்கப்படவில்லை';

  @override
  String get groupUnplanned => 'திட்டமின்றி வாங்கப்பட்டது';

  @override
  String get groupQuantityChanged => 'அளவு மாறியது';

  @override
  String get groupUnverified => 'உறுதிப்படுத்தப்படவில்லை';

  @override
  String get plannedQtyLabel => 'திட்டமிட்ட அளவு';

  @override
  String get actualQtyLabel => 'உண்மையான அளவு';

  @override
  String get plannedUnitPriceLabel => 'திட்டமிட்ட அலகு விலை';

  @override
  String get actualUnitPriceLabel => 'உண்மையான அலகு விலை';

  @override
  String get lineVarianceLabel => 'வரி வழக்கு வித்தியாசம்';

  @override
  String get discountEffectLabel => 'தள்ளுபடி விளைவு';

  @override
  String get notBoughtMark => 'வாங்கப்படவில்லை';

  @override
  String get noPurchasesNote => 'எந்த வாங்கலும் பதிவு செய்யப்படவில்லை.';

  @override
  String get navHome => 'முகப்பு';

  @override
  String get navLists => 'பட்டியல்கள்';

  @override
  String get navHistory => 'வரலாறு';

  @override
  String get navSettings => 'அமைப்புகள்';

  @override
  String get homeEmptyTitle => 'உங்கள் வாங்கலைத் திட்டமிடுங்கள்';

  @override
  String get homeEmptyBody =>
      'உங்கள் முதல் பட்டியலை உருவாக்கி, திட்டமிடப்பட்ட மற்றும் உண்மையான செலவுகளை ஒப்பிடவும்.';

  @override
  String get homeActiveSection => 'செயலில் உள்ள பட்டியல்கள்';

  @override
  String get homeCompletedSection => 'சமீபத்தில் முடிந்தவை';

  @override
  String get homeMonthlySection => 'இந்த மாதம்';

  @override
  String get monthPlannedLabel => 'திட்டமிடப்பட்டது';

  @override
  String get monthActualLabel => 'உண்மையானது';

  @override
  String get monthVarianceLabel => 'வெவ்வேறுத்தன்மை';

  @override
  String get continueShoppingLabel => 'வாங்கலைத் தொடர்ந்து';

  @override
  String get historyEmpty =>
      'இன்னும் எந்த வாங்கலும் முடிக்கப்படவில்லை. உங்கள் வரலாறு மற்றும் கண்ணோட்டங்கள் இங்கே தெரியும்.';

  @override
  String get aboutTabTitle => 'NShoptor பற்றி';

  @override
  String get aboutBody =>
      'Crazy Penguin-இன் NShoptor. ஆஃப்லைன்-முதல் வாங்கல் திட்டமிடல். GPL-3.0 உரிமம் பெற்றது.';

  @override
  String get startShoppingLabel => 'வாங்கலைத் தொடங்கு';

  @override
  String get finishAndSeeResult => 'முடித்து முடிவைக் காணு';

  @override
  String get settingsTitle => 'அமைப்புகள்';

  @override
  String get languageLabel => 'மொழி';

  @override
  String get languageSystem => 'அமைப்பு';

  @override
  String get languageTr => 'தூரக்கீ';

  @override
  String get languageEn => 'ஆங்கிலம்';

  @override
  String get themeLabel => 'தீம்';

  @override
  String get themeSystem => 'அமைப்பு';

  @override
  String get themeLight => 'ஒளி';

  @override
  String get themeDark => 'இருண்ட';

  @override
  String get defaultCurrencyLabel => 'நிலையான நாணயம்';

  @override
  String get defaultUnitLabel => 'நிலையான அலகு';

  @override
  String get keepAwakeLabel => 'வாங்கும் போது திரையை எழுப்பியிருக்கு';

  @override
  String get backupSection => 'பின்னடைவு';

  @override
  String get exportBackupLabel => 'பின்னடைவை ஏற்றுமதி செய்';

  @override
  String get importBackupLabel => 'பின்னடைவை இறக்குமதி செய்';

  @override
  String get mergeImportLabel => 'தற்போதைய தரவுடன் இணை';

  @override
  String get separateImportLabel => 'தனி பிரதியாக இறக்குமதி செய்';

  @override
  String get importCancelled => 'இறக்குமதி ரத்து செய்யப்பட்டது.';

  @override
  String get backupExported => 'பின்னடைவு வெற்றிகரமாக ஏற்றுமதி செய்யப்பட்டது.';

  @override
  String get backupSizeWarning =>
      'பெரிய பின்னடைவு: கோப்பு பெரியதாக இருக்கலாம். படங்களையும் சேர்க்க விரும்புகிறீர்களா?';

  @override
  String get deleteAllSection => 'அபாயப் பகுதி';

  @override
  String get deleteAllLabel => 'அனைத்து தரவையும் நீக்கு';

  @override
  String get deleteAllConfirm =>
      'இது அனைத்து பட்டியல்கள், வரலாறு, ரசீது படங்கள் மற்றும் விலைகளை நீக்கும். நீங்கள் ஏற்றுமதி செய்த கோப்புகள் உங்கள் டிரைவில் இருக்கும். தொடரவா?';

  @override
  String get deleteAllConfirm2 =>
      'நீங்கள் முற்றிலும் உறுதியாக இருக்கிறீர்களா? இந்த செயலை மீள முடியாது.';

  @override
  String get cancelAction => 'ரத்து செய்';

  @override
  String get confirmDelete => 'நிரந்தரமாக நீக்கு';

  @override
  String get dataDeleted => 'அனைத்து உள்ளூர் தரவும் நீக்கப்பட்டது.';

  @override
  String get privacyInfoLabel => 'தனியுரிமை';

  @override
  String get privacyInfoBody =>
      'உங்கள் பட்டியல்கள், விலைகள், ரசீதுகள் மற்றும் படங்கள் உங்கள் சாதனத்தில் இருக்கும். படங்கள் மற்றும் குரல் அதை விட்டு வெளியேறாது. AI உதவி இயக்கப்பட்டிருக்கும்போது, செயலாக்கத்திற்காக உரை (எடுத்துக்காட்டாக ரசீது வரிகள் அல்லது நீங்கள் சொன்னது) மட்டும் எங்கள் சேவையகத்திற்கு அனுப்பப்படும் மற்றும் சேமிக்கப்படாது.';

  @override
  String get aboutSection => 'பற்றி';

  @override
  String get aboutPublisher => 'வெளியீட்டாளர்: Crazy Penguin';

  @override
  String get aboutLicenses => 'உரிமங்கள் (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'குரல் உள்ளீடு';

  @override
  String get voiceStatusUnknown => 'சேவை: சோதிக்கப்படவில்லை';

  @override
  String get permissionsLabel => 'அனுமதிகள்';

  @override
  String get permissionsBody =>
      'கேமரா, மைக்ரோஃபோன் மற்றும் அறிவிப்புகள் நீங்கள் உண்மையில் அந்த அம்சங்களைப் பயன்படுத்தும் போது மட்டுமே கேட்கப்படும்.';

  @override
  String get unitsSection => 'நிலையானவை';

  @override
  String get roundingNote =>
      'பணம் சுற்றுவது ஒரு விதியைப் பின்பற்றுகிறது: பாதி பூஜ்யத்திலிருந்து விலகி சுற்றப்படும், பண மாற்றத்தில் ஒருமுறை பயன்படுத்தப்படும்.';

  @override
  String get voiceInputTitle => 'குரல் உள்ளீடு';

  @override
  String get voiceStartListening => 'கேட்கத் தொடங்கு';

  @override
  String get voiceTranscriptLabel => 'உரைமாற்றம்';

  @override
  String get parseAction => 'பகுப்பாய்வு செய்';

  @override
  String get receiptReviewTitle => 'ரசீதை மதிப்பாய்வு செய்';

  @override
  String get receiptTotal => 'ரசீது மொத்தம்';

  @override
  String get receiptTotalUnknown => 'மொத்தம் கண்டறியப்படவில்லை';

  @override
  String get receiptDiff => 'வெளிப்பாடு';

  @override
  String get acceptLine => 'இணைகோட்டை ஏற்றுக்கொள்';

  @override
  String get ignoreLine => 'இணைகோட்டை புறக்கணி';

  @override
  String get receiptLineActions => 'பொருளுடன் இணை, பிரி அல்லது புறக்கணி';

  @override
  String get receiptCommit => 'அனைத்தையும் ஏற்றுக்கொள்';

  @override
  String get receiptCommitted => 'ரசீது பயன்படுத்தப்பட்டது.';

  @override
  String get priceHistoryTitle => 'விலை வரலாறு';

  @override
  String get noObservations => 'இன்னும் விலை குறிப்புகள் எதுவும் இல்லை';

  @override
  String get templatesSection => 'வார்ப்புருக்கள்';

  @override
  String get templateHint =>
      'முந்தைய வாங்கல் பயணத்திலிருந்து ஒரு புதிய திட்டத்தை உருவாக்கு';

  @override
  String get scanReceiptAction => 'ரசீதை ஸ்கேன் செய்';

  @override
  String get shelfLabelAction => 'தொகுப்பு லேபிலில் இருந்து விலை';

  @override
  String get priceCandidatesTitle => 'விலை வேட்பாளர்கள்';

  @override
  String get noPriceCandidates =>
      'விலை எதுவும் கிடைக்கவில்லை; கையேற்றாக உள்ளிடு.';

  @override
  String get voiceUnavailable =>
      'குரல் அங்கீகாரம் கிடைக்கவில்லை; கையேற்றாக உள்ளிடு.';

  @override
  String get linkToItem => 'பொருளுடன் இணை';

  @override
  String get splitLine => 'இரண்டாக பிரி';

  @override
  String get mergeWithNext => 'அடுத்ததோடு இணை';

  @override
  String get ocrNoText => 'உரையைப் படிக்கவில்லை; மீண்டும் முயற்சி செய்.';

  @override
  String get priceHistoryAction => 'விலை வரலாறு';

  @override
  String get itemsEmptyTitle => 'இன்னும் பொருட்கள் இல்லை';

  @override
  String get itemsEmptyBody =>
      'உங்கள் முதல் பொருளைச் சேர் — கடைகளில் உண்மையான விலைகளை இங்கே நீங்கள் உள்ளிடலாம்.';

  @override
  String get addItemTooltip => 'பொருளைச் சேர்';

  @override
  String get unitAdet => 'pcs';

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
  String get unitCustom => 'தனிப்பயன்';

  @override
  String get setReminderAction => 'நினைவூட்டலை அமை';

  @override
  String get reminderPermissionDenied =>
      'நினைவூட்டல்களுக்கு அறிவிப்பு அனுமதி தேவை. அதை அமைப்பு அமைப்புகளில் நீங்கள் இயக்கலாம்.';

  @override
  String get reminderScheduled => 'நினைவூட்டல் அமைக்கப்பட்டது.';

  @override
  String get reminderCancelled => 'நினைவூட்டல் நீக்கப்பட்டது.';

  @override
  String get reminderTitle => 'வாங்கல் நினைவூட்டல்';

  @override
  String reminderBody(Object title) {
    return 'உங்கள் பட்டியலைச் சரிபார்க்க நேரமாகிவிட்டது: $title';
  }

  @override
  String get reminderPickDate => 'ஒரு தேதியைத் தேர்வு செய்';

  @override
  String get reminderPickTime => 'ஒரு நேரத்தைத் தேர்வு செய்';

  @override
  String get itemDetailsSection => 'விவரங்கள்';

  @override
  String get priceOptionalHint =>
      'விருப்பமானது — கடைகளில் உண்மையான விலையை நீங்கள் உள்ளிடலாம்';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'திட்டமிட்டது: $total · $count பொருட்கள்';
  }

  @override
  String get proActiveLabel => 'Pro செயற்பாட்டு — நன்றி!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'விளம்பரங்கள் இல்லை, அதிக AI, பேக்அப் · சிறிய மாத விலையில் தொடங்குகிறது';

  @override
  String get proBenefitNoAds => 'விளம்பரங்களற்ற அனுபவம்';

  @override
  String get proBenefitBackup => 'பேக்அப் (ஏற்றுமதி/இறக்குமதி)';

  @override
  String aboutVersion(Object version) {
    return 'பதிப்பு $version';
  }

  @override
  String get navDiscover => 'கண்டுபிடி';

  @override
  String get shareAction => 'ஆப்ஸைப் பகிர்';

  @override
  String get rateAction => 'எங்களை மதிப்பாய்வு செய்';

  @override
  String get aboutOpenRow => 'பற்றியது & திறந்த மூலம்';

  @override
  String get voiceAddItemAction => 'குரல் மூலம் சேர்';

  @override
  String get formatLocaleLabel => 'எண் மற்றும் நாணய வடிவம்';

  @override
  String get formatLocaleSystem =>
      'சாதன வடிவம் (லத்தின் எண்கள்; மற்றபடி ஆங்கிலம்)';

  @override
  String get formatLocaleTr => 'துருக்கிய (1.234,56)';

  @override
  String get formatLocaleEn => 'ஆங்கிலம் (1,234.56)';

  @override
  String get aiToggleTitle => 'AI உதவி';

  @override
  String get aiToggleSubtitle =>
      'ரிசீட்டுகளை பொருத்துகிறது, விலை லேபிள்களை படிக்கிறது மற்றும் வாக்கியங்களை பட்டியலாக மாற்றுகிறது. புகைப்படங்கள் மற்றும் குரல் ஆகியவை உங்கள் சாதனத்தில் இருக்கும்; எழுத்து மட்டும் செயலாக்கப்படும்.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'இந்த மாதத்திற்கான AI கோரிக்கைகளை நீங்கள் பயன்படுத்திவிட்டீர்கள் ($used/$limit). மேலும் பெற புதுப்பிக்கவும் அல்லது AI இன்றி தொடரவும்.';
  }

  @override
  String get aiOffline => 'இணைப்பு இல்லை — AI இன்றி தொடர்கிறது.';

  @override
  String get aiFailed => 'AI தற்போது கிடைக்கவில்லை — அதை இன்றி தொடர்கிறது.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'சாதனம்';

  @override
  String get quickListAction => 'ஒரு வாக்கியத்திலிருந்து சேர்';

  @override
  String get quickListTitle => 'விரைவு பட்டியல்';

  @override
  String get quickListHint =>
      'உதாரணமாக 1 kg ஆப்பிள் 20, 2 ரொட்டிகள், பாதி கிலோ சீஸ்';

  @override
  String get quickListConvert => 'பட்டியலாக மாற்று';

  @override
  String quickListAdd(int count) {
    return '$count பொருட்களை சேர்';
  }

  @override
  String get quickListEmpty =>
      'பொருட்கள் எதுவும் கிடைக்கவில்லை. அவற்றைக் கமாவால் பிரித்து பட்டியலிட முயற்சிக்கவும்.';

  @override
  String get receiptAiMatched =>
      'AI உங்கள் பட்டியலுக்கு ரிசீட்டை பொருத்தியுள்ளது. இணைப்புகளை சரிபார்த்து உறுதிப்படுத்தவும்.';

  @override
  String get receiptNeedsCheck => 'இந்த பொருத்தத்தை சரிபார்';

  @override
  String get receiptDiscountLine => 'தள்ளுபடி';

  @override
  String get compareItem => 'பொருள்';

  @override
  String get compareEstimated => 'மதிப்பீடு';

  @override
  String get compareActual => 'நிகழ்வு';

  @override
  String get compareDiff => 'வெளிப்பாடு';

  @override
  String get compareTotal => 'மொத்தம்';

  @override
  String get compareBudget => 'பட்ஜெட்';

  @override
  String get compareNotBought => 'வாங்கப்படவில்லை';

  @override
  String get compareUnplanned => 'திட்டமிடப்படவில்லை';

  @override
  String get pricierItems => 'அதிக விலை';

  @override
  String get cheaperItems => 'குறைந்த விலை';

  @override
  String get compareAction => 'ஒப்பிடு';

  @override
  String get detailsSection => 'விவரங்கள்';

  @override
  String get spendingTitle => 'செலவு';

  @override
  String get spendingAction => 'செலவு';

  @override
  String get spendingMonthTotal => 'இந்த மாதம்';

  @override
  String get spendingWeekly => 'வாராந்திர செலவு';

  @override
  String get spendingMonthly => 'மாதாந்திர செலவு';

  @override
  String get monthlyLimitTitle => 'மாதாந்திர வரம்பு';

  @override
  String get monthlyLimitHelp =>
      'மாதத்திற்கு கடைகளில் எவ்வளவு செலவழிக்க விரும்புகிறீர்கள்?';

  @override
  String get monthlyLimitRemove => 'நீக்கு';

  @override
  String get monthlyLimitSet => 'அமை';

  @override
  String get monthlyLimitChange => 'மாற்று';

  @override
  String get monthlyLimitNone =>
      'மீதமுள்ள தொகையை பார்க்க மாதாந்திர வரம்பை அமைக்கவும்.';

  @override
  String monthlyLimitOver(String amount) {
    return 'வரம்பை விட $amount அதிகம்';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return 'இந்த மாதம் $amount மீதம்';
  }

  @override
  String get plansTitle => 'திட்டங்கள்';

  @override
  String get plansHeadline => 'AI உடன் நுண்ணறிவாக வாங்கு';

  @override
  String get plansSubhead =>
      'ரிசீட் பொருத்தம், விலை லேபிள்கள் மற்றும் ஒரு வாக்கியத்திலிருந்து பட்டியல்கள். எப்போது வேண்டுமானாலும் ரத்து செய்யலாம்.';

  @override
  String get plansMonthly => 'மாதாந்திர';

  @override
  String get plansYearly => 'ஆண்டு';

  @override
  String get planFree => 'இலவசம்';

  @override
  String get planFreePrice => 'எப்போதும் இலவசம்';

  @override
  String get planFreeAi => 'மாதத்திற்கு 15 AI கோரிக்கைகள்';

  @override
  String get planFreeAds =>
      'சிறிய பேனர் விளம்பரங்கள் (உங்கள் முதல் 7 நாட்களில் எதுவும் இல்லை)';

  @override
  String get planCoreFeatures =>
      'பட்டியல்கள், விலைகள், ரிசீட்டுகள், செலவு வரைபடங்கள்';

  @override
  String get plansPerYear => '/ ஆண்டு';

  @override
  String get plansPerMonth => '/ மாதம்';

  @override
  String get planTrial => '7 நாட்கள் இலவசம்';

  @override
  String get planProAi => 'மாதத்திற்கு 200 AI கோரிக்கைகள்';

  @override
  String get planNoAds => 'விளம்பரங்கள் இல்லை';

  @override
  String get planBackup => 'பின்புல ஏற்றுமதி மற்றும் இறக்குமதி';

  @override
  String get planMaxAi => 'மாதத்திற்கு 1000 AI கோரிக்கைகள்';

  @override
  String get planMaxFamily => 'பெரிய குடும்ப வாங்கல்களுக்கு';

  @override
  String get plansStoreUnavailable => 'கடை தற்போது கிடைக்கவில்லை.';

  @override
  String get retryAction => 'மீண்டும் முயற்சிக்கவும்';

  @override
  String get plansPurchaseFailed =>
      'வாங்கல் வெற்றிகரமாக நடைபெறவில்லை. மீண்டும் முயற்சிக்கவும்.';

  @override
  String get planLifetimeTitle => 'நிரந்தர விளம்பரம் இல்லாமல்';

  @override
  String get planLifetimeSubtitle =>
      'ஒருமுறை கட்டணம்: விளம்பரங்கள் இல்லை, பின்புலம்; AI இலவச வரம்பில் தொடரும்';

  @override
  String get plansRestore => 'வாங்கல்களை மீட்டமைக்கவும்';

  @override
  String get plansLegal =>
      'சந்தாக்கள் ரத்து செய்யப்படும் வரை தானாகவே புதுப்பிக்கப்படும். Google Play › கட்டணங்கள் & சந்தாக்களில் எப்போதும் ரத்து செய்யலாம். விலைகளில் Google Play காட்டுவது போன்ற வரிகள் அடங்கும்.';

  @override
  String get planCurrent => 'தற்போதையது';

  @override
  String get planStartTrial => '7 நாள் இலவச சோதனையைத் தொடங்கவும்';

  @override
  String get planChoose => 'தேர்வு செய்';

  @override
  String get plansAction => 'திட்டங்கள்: Pro மற்றும் Max';

  @override
  String get assistantTitle => 'உதவியாளர்';

  @override
  String get assistantGreeting =>
      'வணக்கம்! நீங்கள் என்ன செய்ய விரும்புகிறீர்கள்?';

  @override
  String get assistantNewList => 'புதிய பட்டியல்';

  @override
  String get assistantVoiceList => 'குரல் மூலம் பட்டியல்';

  @override
  String get assistantTextList => 'ஒரு வாக்கியத்திலிருந்து பட்டியல்';

  @override
  String get assistantScanReceipt => 'ரசீதை ஸ்கேன் செய்யுங்கள்';

  @override
  String get assistantSpending => 'என் செலவுகள்';

  @override
  String get assistantReceiptHint =>
      'உங்கள் பட்டியலைத் திறந்து ஸ்கேன் செய்ய ரசீது ஐகானைத் தட்டவும்.';

  @override
  String get assistantToggleTitle => 'உதவியாளரைக் காட்டு';

  @override
  String get assistantToggleSubtitle =>
      'வலது கீழ் மூலையில் உள்ள சிறிய உதவியாளர்';

  @override
  String get scanPriceLabel => 'விலை லேபிளை ஸ்கேன் செய்யுங்கள்';

  @override
  String get saveFailed =>
      'சேமிக்க முடியவில்லை. உங்கள் மாற்றங்கள் இன்னும் உள்ளன. மீண்டும் முயற்சிக்கவும்.';

  @override
  String get deleteItemConfirm =>
      'இந்த பொருளை மற்றும் அதன் பதிவு செய்யப்பட்ட வாங்கல்களை நீக்கவா?';

  @override
  String get clearPurchaseConfirm =>
      'இந்த பொருளின் தேர்வை நீக்கி, அதன் பதிவு செய்யப்பட்ட வாங்கல்களை அழிக்கவா?';

  @override
  String get reportPdfAction => 'PDF அறிக்கையை சேமி';

  @override
  String get reportNotInvoice =>
      'வாடகை சுருக்கம், வரி விசையம் அல்ல. வரி விகிதங்கள் தெரியவில்லை.';

  @override
  String get purchaseVisits => 'வாங்கல் பார்வைகள்';

  @override
  String get purchaseInterval => 'வாங்கல்களுக்கு இடைப்பட்ட சராசரி நாட்கள்';

  @override
  String get purchasedQuantity => 'வாங்கிய அளவு';

  @override
  String get purchaseAnalyticsHint =>
      'வாங்கல்கள் நுகர்ச்சியை அளவிடுவதில்லை. நாணயங்கள் மற்றும் அலகுகள் தனித்தனியாக காட்டப்படும்.';

  @override
  String get receiptReplaces =>
      'இணைக்கப்பட்ட ரசீது வரிகள் உள்ள வாங்கல்களை மாற்றும்; இணைக்கப்படாத வரிகள் சேர்க்கப்படும்.';

  @override
  String get voiceUnsupportedLanguage =>
      'இந்த மொழி இந்த கருவியில் குரல் உள்ளீட்டிற்கு கிடைக்கவில்லை. நீங்கள் டைப் செய்யலாம்.';

  @override
  String get voiceStopListening => 'கேட்பதை நிறுத்து';

  @override
  String get keepAwakeFailed =>
      'திரையை எழுப்பியிருக்க முடியவில்லை. மீண்டும் முயற்சிக்கவும்.';

  @override
  String get purchaseHistoryHint =>
      'முடிந்த அனைத்து வாங்கல்களும். திரும்பப் பெறுதல் மொத்தத்தைக் குறைக்கும். தேதிகள் வாங்கல் முடிவைக் குறிக்கின்றன. சராசரி இடைவெளியைக் கணக்கிட ஒரு பயணம் போதாது.';
}
