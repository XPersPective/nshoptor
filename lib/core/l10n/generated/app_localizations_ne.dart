// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Nepali (`ne`).
class AppLocalizationsNe extends AppLocalizations {
  AppLocalizationsNe([String locale = 'ne']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'घरमा योजना बनाउनुहोस्। योजना अनुसार किन्नुहोस्।';

  @override
  String get listsTitle => 'सूचीहरू';

  @override
  String get listsTabActive => 'सक्रिय';

  @override
  String get listsTabCompleted => 'पूर्ण';

  @override
  String get listsTabArchived => 'अर्काइभ गरिएका';

  @override
  String get newListButton => 'नयाँ सूची';

  @override
  String get listTitleHint => 'शीर्षक (वैकल्पिक)';

  @override
  String get saveButton => 'सहेको';

  @override
  String get cancelButton => 'रद्द गर्नुहोस्';

  @override
  String get deleteButton => 'मेट्नुहोस्';

  @override
  String get editAction => 'सम्पादन';

  @override
  String get listDeleted => 'सूची मेटियो';

  @override
  String get invalidAmountError => 'गलत रकम';

  @override
  String get duplicateAction => 'प्रतिलिपि';

  @override
  String get archiveAction => 'अर्काइभ गर्नुहोस्';

  @override
  String get unarchiveAction => 'अर्काइभ हटाउनुहोस्';

  @override
  String get deleteListConfirm =>
      'यो सूची मेट्ने हो? यसका योजनाबद्ध वस्तुहरू पनि हटाइनेछन्।';

  @override
  String get undoButton => 'पूर्ववत् पार्नुहोस्';

  @override
  String get searchListHint => 'सूची खोज्नुहोस्';

  @override
  String get currencyLabel => 'करन्सी';

  @override
  String get budgetLabel => 'बजेट (वैकल्पिक)';

  @override
  String get noteLabel => 'टिप्पणी (वैकल्पिक)';

  @override
  String get storeLabel => 'दुकान';

  @override
  String get keepAmountsAction => 'रकमहरू राख्नुहोस्';

  @override
  String get resetAmountsAction => 'रकमहरू रिसेट गर्नुहोस्';

  @override
  String get currencyChangeWarning =>
      'करन्सी परिवर्तन हुँदैछ। मौजूदा रकमहरूसँग के गर्ने?';

  @override
  String get listsEmpty =>
      'अझै कुनै सूची छैन। आफ्नो पहिलो शॉपिङ योजना बनाउनुहोस्।';

  @override
  String get statusDraft => 'ड्राफ्ट';

  @override
  String get statusPlanned => 'योजनाबद्ध';

  @override
  String get statusShopping => 'किन्न जाँदै';

  @override
  String get statusCompleted => 'पूर्ण';

  @override
  String get statusArchived => 'अर्काइभ गरिएको';

  @override
  String autoListTitle(String date) {
    return '$date को शॉपिङ';
  }

  @override
  String get itemFormTitle => 'वस्तु थप्नुहोस्';

  @override
  String get itemNameLabel => 'वस्तुको नाम';

  @override
  String get brandLabel => 'ब्रान्ड / भेरियन्ट (वैकल्पिक)';

  @override
  String get categoryLabel => 'श्रेणी';

  @override
  String get quantityLabel => 'परिमाण';

  @override
  String get unitLabel => 'एकाइ';

  @override
  String get pricingModeLabel => 'मूल्य प्रविष्टि';

  @override
  String get pricingModeUnitPrice => 'एकाइ मूल्य';

  @override
  String get pricingModeLineTotal => 'लाइन जम्मा';

  @override
  String get plannedPriceLabel => 'योजनाबद्ध मूल्य';

  @override
  String lineTotalCalculated(String value) {
    return 'लाइन जम्मा: $value';
  }

  @override
  String get requiredItemToggle => 'आवश्यक वस्तु';

  @override
  String get maxPriceLabel => 'स्वीकार्य अधिकतम मूल्य (वैकल्पिक)';

  @override
  String get itemNoteLabel => 'टिप्पणी (वैकल्पिक)';

  @override
  String get categoryProduce => 'फलफूल & तरकारी';

  @override
  String get categoryDairy => 'डेरी उत्पादन';

  @override
  String get categoryMeat => 'मासु';

  @override
  String get categoryBakery => 'बेकरी';

  @override
  String get categoryDrinks => 'पानी/प्याकेज ड्रिंक';

  @override
  String get categoryCleaning => 'सफाई सामग्री';

  @override
  String get categoryPersonalCare => 'व्यक्तिगत हेरचाह';

  @override
  String get categoryHome => 'घरेलु';

  @override
  String get categoryOther => 'अन्य';

  @override
  String get invalidQuantityError => 'गलत परिमाण';

  @override
  String get invalidPriceError => 'गलत मूल्य';

  @override
  String get invalidNameError => 'नाम प्रविष्ट गर्नुहोस्';

  @override
  String unitPriceCalculated(String value) {
    return 'एकाइ मूल्य: $value';
  }

  @override
  String get shoppingTitle => 'खरिद मोड';

  @override
  String get summaryPlannedTotal => 'योजना गरिएको';

  @override
  String get summaryInCart => 'कार्टमा छ';

  @override
  String get summaryRemainingPlan => 'बाँकी योजना';

  @override
  String get summaryProjected => 'अनुमानित चेकआउट';

  @override
  String get summaryBudgetRemaining => 'बजेट बाँकी';

  @override
  String get summaryBudgetOver => 'बजेटभन्दा बढी';

  @override
  String itemsProgress(String done, String total) {
    return '$total वटा मध्ये $done वटा';
  }

  @override
  String get filterAll => 'सबै';

  @override
  String get filterToBuy => 'खरिद गर्नुपर्ने';

  @override
  String get filterInCart => 'कार्टमा छ';

  @override
  String get filterNotFound => 'फेला परेन';

  @override
  String get filterRequired => 'आवश्यक';

  @override
  String get quickEntryTitle => 'वास्तविक मूल्य';

  @override
  String get actualQuantityLabel => 'वास्तविक मात्रा';

  @override
  String get actualPriceLabel => 'वास्तविक मूल्य';

  @override
  String get discountLabel => 'छुट (वैकल्पिक)';

  @override
  String get alternativeNameLabel => 'वैकल्पिक उत्पादनको नाम (वैकल्पिक)';

  @override
  String get savePurchaseButton => 'कार्टमा थप्नुहोस्';

  @override
  String get unplannedAddButton => 'योजना नगरिएको सामान थप्नुहोस्';

  @override
  String get statusPending => 'लिइएको छैन';

  @override
  String get statusInCart => 'कार्टमा छ';

  @override
  String get statusNotFound => 'फेला परेन';

  @override
  String get statusGaveUp => 'परित्याग गरियो';

  @override
  String get statusAlternative => 'वैकल्पिक किनियो';

  @override
  String get keepScreenAwake => 'स्क्रीन चालू राख्नुहोस्';

  @override
  String get finishShopping => 'खरिद सकियो';

  @override
  String get completionWarning =>
      'केही रेकर्डहरू गुमिएका वा अविश्वासनीय छन्। तपाईंले अझै पनि समाप्त गर्न सक्नुहुन्छ; परिणाममा तिनीहरू उल्लेख हुनेछन्।';

  @override
  String get continueShoppingButton => 'खरिद जारी राख्नुहोस्';

  @override
  String get resultTitle => 'परिणाम';

  @override
  String get summarySection => 'सारांश';

  @override
  String get plannedTotalLabel => 'योजना गरिएको कुल';

  @override
  String get actualTotalLabel => 'वास्तविक कुल';

  @override
  String get varianceLabel => 'अन्तर';

  @override
  String get varianceNotComputable => 'गणना गर्न सकिँदैन';

  @override
  String get budgetStatusLabel => 'बजेट';

  @override
  String get savingsLabel => 'योजनाभन्दा कम खर्च';

  @override
  String get overspendLabel => 'योजनाभन्दा बढी खर्च';

  @override
  String get unplannedTotalLabel => 'योजना नगरिएको कुल';

  @override
  String get unpurchasedLabel => 'योजना गरियो तर किनिएन';

  @override
  String get totalDiscountLabel => 'कुल छुट';

  @override
  String get accuracyLabel => 'अनुमानको शुद्धता';

  @override
  String get groupsSection => 'सामानहरू';

  @override
  String get groupPricier => 'योजनाभन्दा महँगो';

  @override
  String get groupCheaper => 'योजनाभन्दा सस्तो';

  @override
  String get groupClose => 'अनुमानसँग नजिक';

  @override
  String get groupNotTaken => 'योजना गरियो, किनिएन';

  @override
  String get groupUnplanned => 'योजना बिना किनियो';

  @override
  String get groupQuantityChanged => 'मात्रा परिवर्तन भयो';

  @override
  String get groupUnverified => 'पुष्टि गरिएन';

  @override
  String get plannedQtyLabel => 'योजना गरिएको मात्रा';

  @override
  String get actualQtyLabel => 'वास्तविक मात्रा';

  @override
  String get plannedUnitPriceLabel => 'योजना गरिएको एकाइ मूल्य';

  @override
  String get actualUnitPriceLabel => 'वास्तविक एकाइ मूल्य';

  @override
  String get lineVarianceLabel => 'पङ्क्तिक अन्तर';

  @override
  String get discountEffectLabel => 'छुटको प्रभाव';

  @override
  String get notBoughtMark => 'किनिएन';

  @override
  String get noPurchasesNote => 'कुनै खरिद रेकर्ड गरिएन।';

  @override
  String get navHome => 'गृह';

  @override
  String get navLists => 'सूचीहरू';

  @override
  String get navHistory => 'इतिहास';

  @override
  String get navSettings => 'सेटिङहरू';

  @override
  String get homeEmptyTitle => 'खरिद योजना बनाउनुहोस्';

  @override
  String get homeEmptyBody =>
      'आफ्नो पहिलो सूची सिर्जना गर्नुहोस् र योजनाबद्ध खर्च वास्तविक खर्चसँग तुलना गर्नुहोस्।';

  @override
  String get homeActiveSection => 'सक्रिय सूचीहरू';

  @override
  String get homeCompletedSection => 'हालै पूरा भएका';

  @override
  String get homeMonthlySection => 'यो महिना';

  @override
  String get monthPlannedLabel => 'योजनाबद्ध';

  @override
  String get monthActualLabel => 'वास्तविक';

  @override
  String get monthVarianceLabel => 'अन्तर';

  @override
  String get continueShoppingLabel => 'खरिद जारी राख्नुहोस्';

  @override
  String get historyEmpty =>
      'अझसम्म कुनै पूरा खरिद छैन। तपाईंको इतिहास र अन्तर्दृष्टि यहाँ देखिनेछ।';

  @override
  String get aboutTabTitle => 'NShoptor बारेमा';

  @override
  String get aboutBody =>
      'Crazy Penguin द्वारा NShoptor। अप-लाइन पहिले खरिद योजनाकार। GPL-3.0 लाइसेन्स अन्तर्गत।';

  @override
  String get startShoppingLabel => 'खरिद सुरु गर्नुहोस्';

  @override
  String get finishAndSeeResult => 'समाप्त गर्नुहोस् र नतिजा हेर्नुहोस्';

  @override
  String get settingsTitle => 'सेटिङहरू';

  @override
  String get languageLabel => 'भाषा';

  @override
  String get languageSystem => 'सिस्टम';

  @override
  String get languageTr => 'Turkish';

  @override
  String get languageEn => 'English';

  @override
  String get themeLabel => 'थिम';

  @override
  String get themeSystem => 'सिस्टम';

  @override
  String get themeLight => 'हल्का';

  @override
  String get themeDark => 'गहिरो';

  @override
  String get defaultCurrencyLabel => 'डिफल्ट मुद्रा';

  @override
  String get defaultUnitLabel => 'डिफल्ट एकाइ';

  @override
  String get keepAwakeLabel => 'खरिद गर्दा स्क्रिन चालु राख्नुहोस्';

  @override
  String get backupSection => 'ब्याकअप';

  @override
  String get exportBackupLabel => 'ब्याकअप निर्यात गर्नुहोस्';

  @override
  String get importBackupLabel => 'ब्याकअप आयात गर्नुहोस्';

  @override
  String get mergeImportLabel => 'वर्तमान डाटासँग मिलाउनुहोस्';

  @override
  String get separateImportLabel =>
      'एक छुट्टै प्रतिलिपि को रूपमा आयात गर्नुहोस्';

  @override
  String get importCancelled => 'आयात रद्द गरियो।';

  @override
  String get backupExported => 'ब्याकअप सफलतापूर्वक निर्यात गरियो।';

  @override
  String get deleteAllSection => 'खतरनाक क्षेत्र';

  @override
  String get deleteAllLabel => 'सबै डाटा हटाउनुहोस्';

  @override
  String get deleteAllConfirm =>
      'यसले सबै सूचीहरू, इतिहास, रेसिप्ट तस्बिरहरू र मूल्यहरू हटाउनेछ। तपाईंले निर्यात गरेका फाइलहरू तपाईंको ड्राइभमा रहनेछन्। जारी राख्नुहोस्?';

  @override
  String get deleteAllConfirm2 =>
      'के तपाईं पूर्ण रूपमा निश्चित हुनुहुन्छ? यो कार्य पछि फिर्ता लिन सकिँदैन।';

  @override
  String get cancelAction => 'रद्द गर्नुहोस्';

  @override
  String get confirmDelete => 'स्थायी रूपमा हटाउनुहोस्';

  @override
  String get dataDeleted => 'सबै स्थानीय डाटा हटाइयो।';

  @override
  String get privacyInfoLabel => 'गोपनीयता';

  @override
  String get privacyInfoBody =>
      'तपाईंका सूचीहरू, मूल्यहरू, रसिदहरू र तस्बिरहरू तपाईंको उपकरणमा भण्डारण गरिन्छन्। आवाज कहिल्यै उपकरणबाट बाहिर जाँदैन। AI सहायता सक्रिय हुँदा रसिद र मूल्य लेबलका तस्बिरहरू (आकार घटाइएका) तथा बोलेर लेखाइएका वस्तुजस्ता पाठ पढ्नका लागि मात्र हाम्रो सर्भरमा पठाइन्छन्; ती तुरुन्तै प्रशोधन गरिन्छन् र कहिल्यै भण्डारण गरिँदैनन्।';

  @override
  String get aboutSection => 'बारेमा';

  @override
  String get aboutPublisher => 'प्रकाशक: Crazy Penguin';

  @override
  String get aboutLicenses => 'लाइसेन्सहरू (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'आवाज इनपुट';

  @override
  String get voiceStatusUnknown => 'सेवा: जाँच गरिएको छैन';

  @override
  String get permissionsLabel => 'अनुमतिहरू';

  @override
  String get permissionsBody =>
      'क्यामेरा, माइक्रोफोन र सूचनाहरू केवल तपाईंले वास्तवमा ती सुविधाहरू प्रयोग गर्दा अनुरोध गरिन्छ।';

  @override
  String get unitsSection => 'डिफल्टहरू';

  @override
  String get roundingNote =>
      'धन राउन्डिङ एक नियम पालना गर्छ: आधा शून्यबाट टाढा राउन्ड हुन्छ, Money conversion मा एक पटक लागू हुन्छ।';

  @override
  String get voiceInputTitle => 'आवाज इनपुट';

  @override
  String get voiceStartListening => 'सुन्न सुरु गर्नुहोस्';

  @override
  String get voiceTranscriptLabel => 'लिखित';

  @override
  String get parseAction => 'विश्लेषण गर्नुहोस्';

  @override
  String get receiptReviewTitle => 'रेसिप्ट समीक्षा गर्नुहोस्';

  @override
  String get receiptTotal => 'रेसिप्टको कुल';

  @override
  String get receiptTotalUnknown => 'कुल पहिचान भएन';

  @override
  String get receiptDiff => 'फरक';

  @override
  String get acceptLine => 'लाइन स्वीकार गर्नुहोस्';

  @override
  String get ignoreLine => 'लाइन बेवास्ता गर्नुहोस्';

  @override
  String get receiptLineActions =>
      'वस्तुसँग लिंक गर्नुहोस्, विभाजन गर्नुहोस् वा बेवास्ता गर्नुहोस्';

  @override
  String get receiptCommit => 'सबै स्वीकार गर्नुहोस्';

  @override
  String get receiptCommitted => 'रेसिप्ट लागू गरियो।';

  @override
  String get priceHistoryTitle => 'मूल्य इतिहास';

  @override
  String get noObservations => 'अझै मूल्य अवलोकन छैन';

  @override
  String get templatesSection => 'टेम्पलेटहरू';

  @override
  String get templateHint => 'अघिल्लो किनेका वस्तुहरूबाट नयाँ योजना बनाउनुहोस्';

  @override
  String get scanReceiptAction => 'रेसिप्ट स्क्यान गर्नुहोस्';

  @override
  String get fromReceiptListButton => 'रसिदबाट सूची';

  @override
  String get shelfLabelAction => 'शेल्फ लेबलबाट मूल्य';

  @override
  String get priceCandidatesTitle => 'मूल्य उम्मेदवारहरू';

  @override
  String get noPriceCandidates =>
      'कुनै मूल्य भेटिएन; म्यानुअली प्रविष्ट गर्नुहोस्।';

  @override
  String get voiceUnavailable =>
      'वाक् पहिचान उपलब्ध छैन; म्यानुअली प्रविष्ट गर्नुहोस्।';

  @override
  String get linkToItem => 'वस्तुसँग लिंक गर्नुहोस्';

  @override
  String get splitLine => 'दुई भागमा विभाजन गर्नुहोस्';

  @override
  String get mergeWithNext => 'अर्कोसँग एकीकृत गर्नुहोस्';

  @override
  String get ocrNoText => 'कुनै पाठ पढिएन; फेरि प्रयास गर्नुहोस्।';

  @override
  String get priceHistoryAction => 'मूल्य इतिहास';

  @override
  String get itemsEmptyTitle => 'अझै कुनै वस्तु छैन';

  @override
  String get itemsEmptyBody =>
      'तपाईंको पहिलो वस्तु थप्नुहोस् — होटेलमा यहाँ तपाईंले वास्तविक मूल्य प्रविष्ट गर्नुहुन्छ।';

  @override
  String get addItemTooltip => 'वस्तु थप्नुहोस्';

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
  String get unitCustom => 'कस्टम';

  @override
  String get setReminderAction => 'रिमाइन्डर सेट गर्नुहोस्';

  @override
  String get reminderPermissionDenied =>
      'रिमाइन्डरका लागि सूचना अनुमति आवश्यक छ। तपाईंले सिस्टम सेटिङ्समा यसलाई सक्षम गर्न सक्नुहुन्छ।';

  @override
  String get reminderScheduled => 'रिमाइन्डर सेट गरियो।';

  @override
  String get reminderCancelled => 'रिमाइन्डर हटाइयो।';

  @override
  String get reminderTitle => 'किनेका वस्तुहरूको रिमाइन्डर';

  @override
  String reminderBody(Object title) {
    return 'तपाईंको सूची जाँच गर्ने समय: $title';
  }

  @override
  String get reminderPickDate => 'मिति छान्नुहोस्';

  @override
  String get reminderPickTime => 'समय छान्नुहोस्';

  @override
  String get itemDetailsSection => 'विवरण';

  @override
  String get priceOptionalHint =>
      'वैकल्पिक — तपाईंले होटेलमा वास्तविक मूल्य प्रविष्ट गर्नुहुन्छ';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'योजनाबद्ध: $total · $count वस्तुहरू';
  }

  @override
  String get proActiveLabel => 'Pro सक्रिय — धन्यवाद!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'विज्ञापन छैन · ब्याकअप एक्सपोर्ट र इम्पोर्ट · वार्षिक';

  @override
  String get proBenefitNoAds => 'विज्ञापन रहित अनुभव';

  @override
  String get proBenefitBackup => 'ब्याकअप (निर्यात/आयात)';

  @override
  String aboutVersion(Object version) {
    return 'संस्करण $version';
  }

  @override
  String get navDiscover => 'खोज्नुहोस्';

  @override
  String get shareAction => 'एप साझा गर्नुहोस्';

  @override
  String get rateAction => 'हामीलाई रेट गर्नुहोस्';

  @override
  String get aboutOpenRow => 'बारेमा & ओपन सोर्स';

  @override
  String get voiceAddItemAction => 'वाक्द्वारा थप्नुहोस्';

  @override
  String get formatLocaleLabel => 'संख्या र मुद्रा प्रारूप';

  @override
  String get formatLocaleSystem => 'डिभाइस फरमेट (लिन अंक; अन्यथा इंग्लिश)';

  @override
  String get formatLocaleTr => 'टर्किश (1.234,56)';

  @override
  String get formatLocaleEn => 'अंग्रेजी (1,234.56)';

  @override
  String get aiToggleTitle => 'AI सहायता';

  @override
  String get aiToggleSubtitle =>
      'तस्बिरबाट रसिद र मूल्य लेबल पढ्छ, रसिदहरू मिलाउँछ र वाक्यहरूलाई सूचीमा बदल्छ। तस्बिरहरू पढ्नका लागि मात्र पठाइन्छन् र कहिल्यै भण्डारण गरिँदैनन्।';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'तपाईंले यो महिनाका AI अनुरोधहरू ($used/$limit) प्रयोग गरिसक्नुभयो। थप प्राप्त गर्न अपग्रेड गर्नुहोस् वा AI बिना जारी राख्नुहोस्।';
  }

  @override
  String get aiOffline => 'कनेक्सन छैन — AI बिना जारी।';

  @override
  String get aiFailed => 'AI हाल उपलब्ध छैन — त्यसैले बिना AI जारी।';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'डिभाइस';

  @override
  String get quickListAction => 'वाक्यबाट थप्नुहोस्';

  @override
  String get quickListTitle => 'त्वरित सूची';

  @override
  String get quickListHint =>
      'उदाहरण: १ किलो सेतो आलु २०, २ रोटी, अर्को किलो पनीर';

  @override
  String get quickListConvert => 'सूचीमा परिणत गर्नुहोस्';

  @override
  String quickListAdd(int count) {
    return '$count वस्तु थप्नुहोस्';
  }

  @override
  String get quickListEmpty =>
      'कुनै वस्तु भेटिएन। कमा विभाजन गरेर सूची बनाउन कोसिस गर्नुहोस्।';

  @override
  String get receiptAiMatched =>
      'AI ले रेसेटलाई तपाईंको सूचीसँग मिलाएको छ। लिङ्कहरू जाँच गर्नुहोस् र पुष्टि गर्नुहोस्।';

  @override
  String get receiptNeedsCheck => 'यो मिलान जाँच गर्नुहोस्';

  @override
  String get receiptDiscountLine => 'छुट';

  @override
  String get compareItem => 'वस्तु';

  @override
  String get compareEstimated => 'अनुमानित';

  @override
  String get compareActual => 'वास्तविक';

  @override
  String get compareDiff => 'फरक';

  @override
  String get compareTotal => 'जम्मा';

  @override
  String get compareBudget => 'बजेट';

  @override
  String get compareNotBought => 'किनिएको छैन';

  @override
  String get compareUnplanned => 'योजना गरिएको छैन';

  @override
  String get pricierItems => 'थप खर्चियो';

  @override
  String get cheaperItems => 'सस्तो भयो';

  @override
  String get compareAction => 'तुलना गर्नुहोस्';

  @override
  String get detailsSection => 'विवरण';

  @override
  String get spendingTitle => 'खर्च';

  @override
  String get spendingAction => 'खर्च';

  @override
  String get spendingMonthTotal => 'यो महिना';

  @override
  String get spendingWeekly => 'साप्ताहिक खर्च';

  @override
  String get spendingMonthly => 'मासिक खर्च';

  @override
  String get monthlyLimitTitle => 'मासिक सीमा';

  @override
  String get monthlyLimitHelp =>
      'तपाईंले हप्तामा किनमेलमा कति खर्च गर्न चाहनुहुन्छ?';

  @override
  String get monthlyLimitRemove => 'हटाउनुहोस्';

  @override
  String get monthlyLimitSet => 'सेट गर्नुहोस्';

  @override
  String get monthlyLimitChange => 'परिवर्तन गर्नुहोस्';

  @override
  String get monthlyLimitNone => 'बाँकी रकम हेर्न मासिक सीमा सेट गर्नुहोस्।';

  @override
  String monthlyLimitOver(String amount) {
    return 'सीमाभन्दा $amount बढी';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return 'यो महिना $amount बाँकी';
  }

  @override
  String get plansTitle => 'योजनाहरू';

  @override
  String get plansHeadline => 'AI संग स्मार्टर शपिंग गर्नुहोस्';

  @override
  String get plansSubhead =>
      'रेसेट मिलान, मूल्य लेबल र वाक्यबाट सूची। कुनै पनि समय क्यान्सल गर्नुहोस्।';

  @override
  String get plansMonthly => 'मासिक';

  @override
  String get plansYearly => 'वार्षिक';

  @override
  String get planFree => 'निःशुल्क';

  @override
  String get planFreePrice => 'सधैं निःशुल्क';

  @override
  String get planFreeAi => 'प्रति महिना 10 AI अनुरोध';

  @override
  String get planFreeAds => 'साना ब्यानर विज्ञापन (पहिलो ७ दिनमा कुनै छैन)';

  @override
  String get planCoreFeatures => 'सूची, मूल्य, रेसेट, खर्च चार्ट';

  @override
  String get plansPerYear => '/ वर्ष';

  @override
  String get plansPerMonth => '/ महिना';

  @override
  String get planTrial => 'निःशुल्क ट्रायल';

  @override
  String get planProAi => 'प्रति महिना 100 AI अनुरोध';

  @override
  String get planNoAds => 'विज्ञापन छैन';

  @override
  String get planBackup => 'ब्याकअप एक्सपोर्ट र इम्पोर्ट';

  @override
  String get planMaxAi => 'प्रति महिना 300 AI अनुरोधहरू';

  @override
  String get planMaxFamily => 'ठूलो परिवारको खरिदका लागि';

  @override
  String get plansStoreUnavailable => 'दुकान अहिले उपलब्ध छैन।';

  @override
  String get retryAction => 'फेरि प्रयास गर्नुहोस्';

  @override
  String get plansPurchaseFailed =>
      'खरिद सफल भएन। कृपया फेरि प्रयास गर्नुहोस्।';

  @override
  String get plansRestore => 'खरिदहरू पुनर्स्थापना गर्नुहोस्';

  @override
  String get plansLegal =>
      'रद्द नगरेसम्म Pro हरेक वर्ष स्वतः नवीकरण हुन्छ र हरेक महिना १०० AI अनुरोध समावेश हुन्छन्। लागू करबाहेक आधार मूल्य वर्षको १ अमेरिकी डलर हो; खरिद पुष्टि गर्नुअघि स्टोरमा अन्तिम स्थानीय मूल्य र कर जाँच्नुहोस्। Google Play मा सदस्यता व्यवस्थापन वा रद्द गर्नुहोस्।';

  @override
  String get planCurrent => 'वर्तमान';

  @override
  String get planStartTrial => 'निःशुल्क ट्रायल सुरु गर्नुहोस्';

  @override
  String get planChoose => 'चयन गर्नुहोस्';

  @override
  String get plansAction => 'योजनाहरू: Pro';

  @override
  String get assistantTitle => 'सहायक';

  @override
  String get assistantGreeting => 'नमस्ते! तपाईं के गर्न चाहनुहुन्छ?';

  @override
  String get assistantNewList => 'नयाँ सूची';

  @override
  String get assistantVoiceList => 'आवाजद्वारा सूची';

  @override
  String get assistantTextList => 'वाक्यबाट सूची';

  @override
  String get assistantScanReceipt => 'बिल स्क्यान गर्नुहोस्';

  @override
  String get assistantSpending => 'मेरो खर्च';

  @override
  String get assistantReceiptHint =>
      'आफ्नो सूची खोल्नुहोस् र यसलाई स्क्यान गर्न बिल आइकन ट्याप गर्नुहोस्।';

  @override
  String get assistantToggleTitle => 'सहायक देखाउनुहोस्';

  @override
  String get assistantToggleSubtitle => 'दायाँ तलको सानो सहयोगी';

  @override
  String get scanPriceLabel => 'मूल्य लेबल स्क्यान गर्नुहोस्';

  @override
  String get saveFailed =>
      'सेभ हुन सकेन। तपाईंका परिवर्तनहरू अझै पनि छन्। कृपया पुन प्रयास गर्नुहोस्।';

  @override
  String get deleteItemConfirm =>
      'यो वस्तु र यसका रेकर्ड गरिएका खरिदहरू मेट्ने हो?';

  @override
  String get clearPurchaseConfirm =>
      'यो वस्तुको चिन्ह हटाउने र यसका रेकर्ड गरिएका खरिदहरू मेट्ने हो?';

  @override
  String get reportPdfAction => 'PDF रिपोर्ट सेभ गर्नुहोस्';

  @override
  String get reportNotInvoice =>
      'खरिदको सारांश, कर इनभॉइस होइन। कर दरहरू अज्ञात छन्।';

  @override
  String get purchaseVisits => 'खरिद भ्रमणहरू';

  @override
  String get purchaseInterval => 'खरिद बीचको औसत दिनहरू';

  @override
  String get purchasedQuantity => 'खरिद मात्रा';

  @override
  String get purchaseAnalyticsHint =>
      'खरिदले उपभोग नाप्दैन। मुद्रा र एकाइहरू छुट्टाछुट्टै देखाइन्छन्।';

  @override
  String get receiptReplaces =>
      'मूल्य नभएका वस्तुको मूल्य भरिन्छ। बजार मूल्य भएका वस्तुहरू छुट्टै खरिदका रूपमा थपिन्छन्।';

  @override
  String get receiptIncompleteHeader =>
      'अर्को फोटोमा पसल, मिति, समय र रसिद नम्बर समावेश गर्नुहोस्।';

  @override
  String get receiptIncompleteTail =>
      'केही वस्तुहरू एकअर्कामाथि पर्ने र अन्तिम जम्मा देखिने गरी अर्को भागको फोटो खिच्नुहोस्।';

  @override
  String get receiptContinuationRejected =>
      'यो फोटो जोड्न सकिएन। एउटै रसिदका वस्तुहरू ओभरल्याप हुने गरी फेरि खिच्नुहोस्।';

  @override
  String get receiptDraftSaved =>
      'रसिद मस्यौदाका रूपमा सुरक्षित भयो। पछि जारी राख्न सक्नुहुन्छ।';

  @override
  String get receiptContinueAction => 'रसिद जारी राख्नुहोस्';

  @override
  String get receiptDraftsTitle => 'अधुरा रसिदहरू';

  @override
  String get receiptDuplicate => 'यो रसिद पहिले नै थपिएको छ।';

  @override
  String get receiptTotalMismatch =>
      'वस्तुहरूको जम्मा रसिदको कुल रकमसँग मिल्दैन। पूरा रसिद देखिएको छ कि जाँच्नुहोस्।';

  @override
  String get receiptSaveDraftAction => 'पछि सुरक्षित गर्नुहोस्';

  @override
  String get receiptResolveLines =>
      'सुरक्षित गर्नुअघि प्रत्येक वस्तु स्वीकार गर्नुहोस् वा बेवास्ता गर्नुहोस्।';

  @override
  String get receiptPartialConfirm =>
      'छानिएका वस्तुहरू मात्र थपिनेछन्। यो रसिद आयात गरिएको भनी चिन्ह लगाइनेछ। जारी राख्ने?';

  @override
  String get voiceUnsupportedLanguage =>
      'यो भाषा यो डिभाइसमा भoice इनपुटका लागि उपलब्ध छैन। तपाईं टाइप गर्न सक्नुहुन्छ।';

  @override
  String get voiceStopListening => 'सुन्न बन्द गर्नुहोस्';

  @override
  String get keepAwakeFailed =>
      'स्क्रीन जागे राख्न सकिएन। कृपया पुनः प्रयास गर्नुहोस्।';

  @override
  String get purchaseHistoryHint =>
      'सबै पूरा भएका खरिदहरू। रिटर्नले कुल रकम घटाउँछ। मितिहरूले खरिद सम्पन्न भएको समयलाई जनाउँछन्। औसत अन्तराल गणना गर्न एउटा भ्रमण पर्याप्त हुँदैन।';

  @override
  String get planLegacyRights =>
      'हालका Pro र Max सदस्यताहरूको मूल मासिक AI अनुरोध सीमा कायम रहन्छ।';

  @override
  String get csvExportAction => 'CSV निर्यात गर्नुहोस्';

  @override
  String get reportSharePdf => 'PDF को रूपमा सेयर गर्नुहोस्';

  @override
  String get reportShareCsv => 'CSV को रूपमा सेयर गर्नुहोस्';

  @override
  String get reportPrintAction => 'प्रिन्ट गर्नुहोस्';

  @override
  String get backupSizeWarning =>
      'JSON मा रेकर्डहरू छन्, फोटो फाइलहरू होइन। आयात सीमा: १६ एमबी।';

  @override
  String get backupImportFailed =>
      'यो ब्याकअप आयात गर्न सकिएन। तपाईंको डाटा परिवर्तन भएको छैन।';

  @override
  String get backupImported => 'ब्याकअप सफलतापूर्वक आयात गरियो।';

  @override
  String backupPreviewCounts(Object entries, Object items, Object lists) {
    return '$lists सूचीहरू · $items वस्तुहरू · $entries खरिदहरू';
  }

  @override
  String get voiceModelDownloading =>
      'यस भाषाको भ्वाइस मोडेल डाउनलोड हुँदैछ। एक मिनेटपछि फेरि प्रयास गर्नुहोस्।';

  @override
  String get historyThisWeek => 'यो हप्ता';

  @override
  String get historyProductsSection => 'किनिएका उत्पादनहरू';

  @override
  String get tipReceiptScan =>
      'रसिद स्क्यान गरेर मूल्यहरू तपाईंको सूचीसँग मिलाउनुहोस्';

  @override
  String get tipVoiceAdd =>
      'एक वा धेरै सामान भन्नुहोस्, त्यसपछि थप्नु अघि जाँच्नुहोस्';

  @override
  String get tipShelfCamera => 'क्यामेराले सेल्फ लेबलको मूल्य पढ्नुहोस्';

  @override
  String get tipPlan =>
      'तपाईंको योजना: विवरण हेर्नुहोस्, सदस्यता लिनुहोस् वा अपग्रेड गर्नुहोस्';

  @override
  String get guideAddBody =>
      'सामान थप्न + थिच्नुहोस्। योजनाबद्ध मूल्य अहिले र बजार मूल्य काउन्टरमा राख्नुहोस्।';

  @override
  String get guideVoiceBody =>
      'माइक्रोफोन थिचेर सामान भन्नुहोस्, जस्तै: \'१ केजी स्याउ, १ पाउरोटी\'।';

  @override
  String get guideReceiptBody =>
      'रसिद स्क्यान गरेर यसका मूल्यहरू तपाईंको सूचीका सामानसँग मिलाउनुहोस्।';

  @override
  String get guidePlanBody =>
      'योजना हेर्न, सदस्यता लिन वा अपग्रेड गर्न योजना आइकन थिच्नुहोस्।';

  @override
  String get guideNext => 'ठीक छ';

  @override
  String get guideDone => 'सुरु गर्नुहोस्';

  @override
  String get paletteLabel => 'रङ थिम';

  @override
  String get paletteForest => 'जङ्गल';

  @override
  String get paletteOcean => 'महासागर';

  @override
  String get paletteSunset => 'सूर्यास्त';

  @override
  String get paletteLavender => 'ल्याभेन्डर';

  @override
  String get darkBlackLabel => 'डार्क थिममा पूरा कालो';

  @override
  String get spendingOverview => 'सारांश';

  @override
  String get spendingThisYear => 'यो वर्ष';

  @override
  String get spendingYearly => 'वार्षिक खर्च';

  @override
  String get productSpending => 'सामान अनुसार खर्च';

  @override
  String get spanWeek => 'हप्ता';

  @override
  String get spanMonth => 'महिना';

  @override
  String get spanYear => 'वर्ष';

  @override
  String get weeklyLimitTitle => 'साप्ताहिक सीमा';

  @override
  String get weeklyLimitHelp => 'हप्तामा किनमेलमा कति खर्च गर्न चाहनुहुन्छ?';

  @override
  String get weeklyLimitNone => 'कति बाँकी छ हेर्न साप्ताहिक सीमा राख्नुहोस्।';

  @override
  String weeklyLimitLeft(String amount) {
    return 'यो हप्ता $amount बाँकी';
  }

  @override
  String get shoppingLimitTitle => 'प्रत्येक किनमेलको सीमा';

  @override
  String get shoppingLimitHelp => 'नयाँ सूचीहरू यही बजेटबाट सुरु हुन्छन्।';

  @override
  String get shoppingLimitNone =>
      'हरेक नयाँ किनमेलका लागि पूर्वनिर्धारित बजेट राख्नुहोस्।';

  @override
  String get monthlyReportAction => 'मासिक प्रतिवेदन';

  @override
  String get reportShoppingColumn => 'किनमेल';

  @override
  String get reportDateColumn => 'मिति';

  @override
  String get planUnavailable => 'अहिले स्टोरमा उपलब्ध छैन';

  @override
  String get demoDataTitle => 'नमुना डाटा';

  @override
  String get demoDataLoad => 'नमुना डाटासँग प्रयास गर्नुहोस्';

  @override
  String get demoDataLoadHelp =>
      'इतिहास, चार्ट र मूल्य इतिहास हेर्न १२ महिनाको नमुना किनमेल थप्छ।';

  @override
  String get demoDataRemove => 'नमुना डाटा हटाउनुहोस्';

  @override
  String get demoDataAdded => 'नमुना डाटा थपियो';

  @override
  String get demoDataRemoved => 'नमुना डाटा हटाइयो';

  @override
  String get demoProductApple => 'स्याउ';

  @override
  String get demoProductBread => 'पाउरोटी';

  @override
  String get demoProductMilk => 'दूध';

  @override
  String get demoProductCheese => 'चिज';

  @override
  String get demoProductTomato => 'गोलभेडा';

  @override
  String get demoProductEggs => 'अण्डा';

  @override
  String get demoProductCoffee => 'कफी';

  @override
  String get demoProductDetergent => 'डिटर्जेन्ट';

  @override
  String get sendAction => 'Send';

  @override
  String get previousMonthAction => 'Previous month';

  @override
  String get nextMonthAction => 'Next month';

  @override
  String get helpSection => 'मद्दत र सहयोग';

  @override
  String get howToUseLabel => 'कसरी प्रयोग गर्ने';

  @override
  String get guidePricesBody =>
      'पसलको मूल्य राखेपछि सामान किनेको चिन्ह लाग्छ; 0 पनि मान्य हुन्छ। घरको मूल्य वैकल्पिक हो। चिन्ह हटाउन पसलको मूल्य मेटाउनुहोस्।';

  @override
  String get shoppingDateLabel => 'किनमेलको मिति';

  @override
  String get shoppingDateNone => 'मिति छानिएको छैन';

  @override
  String get clearShoppingDateAction => 'मिति हटाउनुहोस्';

  @override
  String get listSortLabel => 'सूचीको क्रम';

  @override
  String get listSortDate => 'किनमेलको मिति';

  @override
  String get listSortAz => 'नाम (अ–ह)';

  @override
  String get listSortManual => 'आफैँ क्रम मिलाउनुहोस्';

  @override
  String get imageCameraAction => 'फोटो खिच्नुहोस्';

  @override
  String get imageGalleryAction => 'फोटोहरूबाट छान्नुहोस्';

  @override
  String get imageCaptureFailed =>
      'क्यामेरा वा फोटोहरू खोल्न सकिएन। पहुँच अनुमति जाँचेर फेरि प्रयास गर्नुहोस्।';

  @override
  String get imageRecognitionFailed =>
      'फोटो प्रशोधन गर्न सकिएन। अर्को फोटो प्रयोग गर्नुहोस्।';

  @override
  String get receiptNoProducts =>
      'पाठ पढियो, तर रसिदका सामानहरू फेला परेनन्। फोटोमा सामानहरू र कुल रकम समावेश गर्नुहोस्।';

  @override
  String get keepAwakeOn => 'स्क्रिन खुला रहनेछ';

  @override
  String get keepAwakeOff => 'स्क्रिन बन्द हुन सक्छ';

  @override
  String get spanDay => 'दिन';

  @override
  String get spanCustom => 'मिति दायरा';

  @override
  String get reportTotalSpent => 'कुल खर्च';

  @override
  String get reportAddedAt => 'थपिएको मिति';

  @override
  String get reportReceiptNumber => 'रसिद नम्बर';

  @override
  String get reportPreview => 'पूर्वावलोकन';

  @override
  String get reportShareAction => 'साझा गर्नुहोस्';

  @override
  String get previousPeriodAction => 'अघिल्लो अवधि';

  @override
  String get nextPeriodAction => 'अर्को अवधि';

  @override
  String get reportSaved => 'प्रतिवेदन सुरक्षित गरियो।';

  @override
  String get reportZoom => 'जुम';

  @override
  String planTrialDaysLeft(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days दिन बाँकी',
    );
    return '$_temp0';
  }

  @override
  String planTrialHoursLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours घण्टा बाँकी',
    );
    return '$_temp0';
  }

  @override
  String get planTrialEndedTitle => 'तपाईंको Pro परीक्षण अवधि सकियो';

  @override
  String get planTrialEndedBody =>
      'तपाईं सूची, म्यानुअल प्रविष्टि र उपकरणमै चल्ने आवाज सुविधा निःशुल्क प्रयोग गर्न सक्नुहुन्छ। Free मा प्रत्येक पात्रो महिनामा १० AI अनुरोध समावेश छन्। महिनामा १०० AI अनुरोध, विज्ञापनरहित प्रयोग र ब्याकअपका लागि वार्षिक Pro छान्नुहोस्। तपाईंको हालको डेटा तपाईंसँगै रहनेछ।';

  @override
  String get planContinueFree => 'Free मै जारी राख्नुहोस्';

  @override
  String get supportIdLabel => 'सहायता ID';

  @override
  String get supportEmailLabel => 'इमेल सहायता';

  @override
  String get captureTipFirst =>
      'सबैभन्दा माथिबाट सुरु गर्नुहोस्: पसलको नाम र मिति देखिनुपर्छ। सकेसम्म धेरै सामान समेट्नुहोस्; बाँकी अर्को फोटोमा जान्छ।';

  @override
  String get captureTipContinue =>
      'उही रसिद: अघिल्लो फोटोको अन्तिम सामान समावेश गर्नुहोस्।';

  @override
  String get captureTipNeverShow => 'फेरि नदेखाउनुहोस्';

  @override
  String get captureTipOk => 'बुझें';

  @override
  String get captureTipsSetting => 'रसिद खिच्ने सुझाव देखाउनुहोस्';

  @override
  String get receiptReadingProgress => 'रसिद पढ्दै…';

  @override
  String get receiptReadInBackground => 'पृष्ठभूमिमा जारी राख्नुहोस्';

  @override
  String get receiptReadDoneTitle => 'रसिद पढियो';

  @override
  String get receiptReadDoneBody => 'जाँच गरी सुरक्षित गर्न ट्याप गर्नुहोस्।';

  @override
  String get receiptReadMoreTitle => 'रसिदको बाँकी भागको फोटो खिच्नुहोस्';

  @override
  String get receiptReadFailedTitle => 'रसिद पढ्न सकिएन';

  @override
  String get listReceiptsSection => 'रसिदहरू';

  @override
  String get receiptStateComplete => 'पूरा';

  @override
  String get receiptStateIncomplete => 'अपूर्ण';

  @override
  String get receiptStateFailed => 'असफल';

  @override
  String get receiptStoreUnknown => 'पसल पढ्न सकिएन';

  @override
  String get receiptDeleteAction => 'रसिद मेटाउनुहोस्';

  @override
  String get receiptDeleteConfirm =>
      'यो रसिद र यसले थपेका सामानहरू मेटाउने? पछि फेरि आयात गर्न सक्नुहुन्छ।';

  @override
  String get receiptDeleted => 'रसिद मेटाइयो।';

  @override
  String listReceiptsShowAll(int count) {
    return 'सबै देखाउनुहोस् ($count)';
  }

  @override
  String get listReceiptsShowLess => 'कम देखाउनुहोस्';

  @override
  String receiptDateLabel(String date) {
    return 'रसिदको मिति: $date';
  }

  @override
  String get historyViewShopping => 'किनमेल अनुसार';

  @override
  String get historyViewStore => 'पसल अनुसार';

  @override
  String get historyViewProduct => 'उत्पादन अनुसार';

  @override
  String get historyShareAll => 'सबै साझा गर्नुहोस्';

  @override
  String get historyUnknownStore => 'अज्ञात पसल';

  @override
  String get historyDailySpending => 'दैनिक खर्च';

  @override
  String get historyResetPeriod => 'यो हप्तामा फर्कनुहोस्';

  @override
  String get tourSkip => 'छोड्नुहोस्';

  @override
  String get tourNewListBody =>
      'किनमेल सूची सुरु गर्नुहोस् र किन्ने कुरा थप्नुहोस्।';

  @override
  String get tourFromReceiptBody =>
      'किनमेल गरिसक्नुभयो? रसिदलाई मूल्यसहित सूचीमा बदल्नुहोस्।';

  @override
  String get tourReceiptFlowBody =>
      'रसिदको माथिबाट सुरु गर्नुहोस्: पहिले पसल र मिति लिनुहोस्, त्यसपछि बाँकी पङ्क्तिहरूसँग जारी राख्नुहोस्।';

  @override
  String get tourTabsBody =>
      'सक्रिय, सम्पन्न र संग्रहित सूचीहरूबीच बदल्नुहोस्। अन्तिम बटनले क्रम बदल्छ।';

  @override
  String get tourDiscoverBody => 'उही विकासकर्ताका थप एपहरू हेर्नुहोस्।';

  @override
  String get tourHelpBody =>
      'यो गाइड फेरि हेर्न यहाँ ट्याप गर्नुहोस्। जम्मा र सामानको व्याख्या हेर्न कुनै सूची खोल्नुहोस्।';

  @override
  String get tourTotalsBody =>
      'योजना गरिएको, वास्तविक जम्मा र फरक किनमेल गर्दा अद्यावधिक हुन्छन्।';

  @override
  String get tourItemsBody =>
      'तपाईंका सामान। यहाँ तिनको क्रम बदल्नुहोस् वा खोज्नुहोस्।';
}
