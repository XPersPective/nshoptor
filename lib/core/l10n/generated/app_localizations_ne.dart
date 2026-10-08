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
  String get backupSizeWarning =>
      'ठूलो ब्याकअप: फाइल ठूलो हुन सक्छ। के तपाईंले तस्बिरहरू पनि समावेश गर्न चाहनुहुन्छ?';

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
      'तपाईंका सूचीहरू, मूल्यहरू, रेसिप्टहरू र तस्बिरहरू तपाईंको उपकरणमा नै रहन्छन्। तस्बिरहरू र आवाज कहिल्यै त्यहाँबाट बाहिर जाँदैनन्। जब AI सहयोग सक्रिय हुन्छ, केवल पाठ (जस्तै रेसिप्ट पङ्क्तिहरू वा तपाईंले भनाएको कुरा) प्रशोधनको लागि हाम्रो सर्भरमा पठाइन्छ र संग्रह गरिँदैन।';

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
      'विज्ञापन रहित, बढी AI, ब्याकअप · सानो मासिक मूल्यबाट';

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
  String get formatLocaleSystem => 'सिस्टम (एप भाषा अनुसार)';

  @override
  String get formatLocaleTr => 'टर्किश (1.234,56)';

  @override
  String get formatLocaleEn => 'अंग्रेजी (1,234.56)';

  @override
  String get aiToggleTitle => 'AI सहायता';

  @override
  String get aiToggleSubtitle =>
      'रेसेट मिलाउँछ, मूल्य लेबल पढ्छ र वाक्यलाई सूचीमा परिणत गर्छ। फोटो र आवाज तपाईंको डिभाइसमै रहन्छन्; केवल पाठ प्रक्रिया गरिन्छ।';

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
  String get planFreeAi => 'प्रति महिना १५ AI अनुरोध';

  @override
  String get planFreeAds => 'साना ब्यानर विज्ञापन (पहिलो ७ दिनमा कुनै छैन)';

  @override
  String get planCoreFeatures => 'सूची, मूल्य, रेसेट, खर्च चार्ट';

  @override
  String get plansPerYear => '/ वर्ष';

  @override
  String get plansPerMonth => '/ महिना';

  @override
  String get planTrial => '७ दिन निःशुल्क';

  @override
  String get planProAi => 'प्रति महिना २०० AI अनुरोध';

  @override
  String get planNoAds => 'विज्ञापन छैन';

  @override
  String get planBackup => 'ब्याकअप एक्सपोर्ट र इम्पोर्ट';

  @override
  String get planMaxAi => 'प्रति महिना १००० AI अनुरोधहरू';

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
  String get planLifetimeTitle => 'जीवनभर विज्ञापन-मुक्त';

  @override
  String get planLifetimeSubtitle =>
      'एकपटक भुक्तानी: विज्ञापन छैन, ब्याकअप; AI निःशुल्क सुविधा सीमामा रहन्छ';

  @override
  String get plansRestore => 'खरिदहरू पुनर्स्थापना गर्नुहोस्';

  @override
  String get plansLegal =>
      'सब्सक्रिप्शन रद्द नभएसम्म स्वचालित रूपमा नवीकरण हुन्छ। Google Play › भुक्तानी र सब्सक्रिप्सनमा कुनै पनि समय रद्द गर्न सकिन्छ। मूल्यहरूमा Google Play द्वारा देखाइएका करहरू समावेश छन्।';

  @override
  String get planCurrent => 'वर्तमान';

  @override
  String get planStartTrial => '७ दिनको निःशुल्क ट्रायल सुरु गर्नुहोस्';

  @override
  String get planChoose => 'चयन गर्नुहोस्';

  @override
  String get plansAction => 'योजनाहरू: Pro र Max';

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
}
