// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Marathi (`mr`).
class AppLocalizationsMr extends AppLocalizations {
  AppLocalizationsMr([String locale = 'mr']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'घरी योजना करा. नियोजनानुसार खरेदी करा.';

  @override
  String get listsTitle => 'याद्या';

  @override
  String get listsTabActive => 'सक्रिय';

  @override
  String get listsTabCompleted => 'पूर्ण';

  @override
  String get listsTabArchived => 'आर्काइव्ह';

  @override
  String get newListButton => 'नवीन यादी';

  @override
  String get listTitleHint => 'शीर्षक (ऐच्छिक)';

  @override
  String get saveButton => 'जतन करा';

  @override
  String get cancelButton => 'रद्द करा';

  @override
  String get deleteButton => 'हटवा';

  @override
  String get editAction => 'संपादन';

  @override
  String get listDeleted => 'यादी हटवली';

  @override
  String get invalidAmountError => 'अवैध रक्कम';

  @override
  String get duplicateAction => 'प्रत तयार करा';

  @override
  String get archiveAction => 'आर्काइव्ह करा';

  @override
  String get unarchiveAction => 'आर्काइव्ह काढा';

  @override
  String get deleteListConfirm =>
      'ही यादी हटवायची आहे का? त्यातील नियोजित वस्तू देखील काढल्या जातील.';

  @override
  String get undoButton => 'पूर्ववत करा';

  @override
  String get searchListHint => 'याद्या शोधा';

  @override
  String get currencyLabel => 'मुद्रा';

  @override
  String get budgetLabel => 'बजेट (ऐच्छिक)';

  @override
  String get noteLabel => 'टीप (ऐच्छिक)';

  @override
  String get storeLabel => 'दुकान';

  @override
  String get keepAmountsAction => 'रक्कम जतन करा';

  @override
  String get resetAmountsAction => 'रक्कम रीसेट करा';

  @override
  String get currencyChangeWarning =>
      'मुद्रा बदलत आहे. सध्याच्या रक्कमींवर काय होईल?';

  @override
  String get listsEmpty =>
      'अजून कोणतीही यादी नाही. तुमची पहिली खरेदी योजना तयार करा.';

  @override
  String get statusDraft => 'मसुदा';

  @override
  String get statusPlanned => 'नियोजित';

  @override
  String get statusShopping => 'खरेदी करताना';

  @override
  String get statusCompleted => 'पूर्ण';

  @override
  String get statusArchived => 'आर्काइव्ह';

  @override
  String autoListTitle(String date) {
    return '$date ची खरेदी';
  }

  @override
  String get itemFormTitle => 'वस्तू जोडा';

  @override
  String get itemNameLabel => 'वस्तूचे नाव';

  @override
  String get brandLabel => 'ब्रँड / प्रकार (ऐच्छिक)';

  @override
  String get categoryLabel => 'श्रेणी';

  @override
  String get quantityLabel => 'प्रमाण';

  @override
  String get unitLabel => 'एकक';

  @override
  String get pricingModeLabel => 'किंमत नोंदणी';

  @override
  String get pricingModeUnitPrice => 'प्रति एकक किंमत';

  @override
  String get pricingModeLineTotal => 'एकूण रक्कम';

  @override
  String get plannedPriceLabel => 'नियोजित किंमत';

  @override
  String lineTotalCalculated(String value) {
    return 'एकूण रक्कम: $value';
  }

  @override
  String get requiredItemToggle => 'लागू असलेली वस्तू';

  @override
  String get maxPriceLabel => 'स्वीकारार्ह कमाल किंमत (ऐच्छिक)';

  @override
  String get itemNoteLabel => 'टीप (ऐच्छिक)';

  @override
  String get categoryProduce => 'फळे आणि भाजीपाला';

  @override
  String get categoryDairy => 'डेअरी उत्पादने';

  @override
  String get categoryMeat => 'मांस';

  @override
  String get categoryBakery => 'बेकरी';

  @override
  String get categoryDrinks => 'पेय';

  @override
  String get categoryCleaning => 'साफसफाई';

  @override
  String get categoryPersonalCare => 'वैयक्तिक देखभाल';

  @override
  String get categoryHome => 'घर';

  @override
  String get categoryOther => 'इतर';

  @override
  String get invalidQuantityError => 'अवैध प्रमाण';

  @override
  String get invalidPriceError => 'अवैध किंमत';

  @override
  String get invalidNameError => 'नाव टाका';

  @override
  String unitPriceCalculated(String value) {
    return 'एकक किंमत: $value';
  }

  @override
  String get shoppingTitle => 'खरेदी मोड';

  @override
  String get summaryPlannedTotal => 'योजित';

  @override
  String get summaryInCart => 'कार्टमध्ये';

  @override
  String get summaryRemainingPlan => 'शिल्लक योजना';

  @override
  String get summaryProjected => 'अंदाजित चेकआउट';

  @override
  String get summaryBudgetRemaining => 'बजेट शिल्लक';

  @override
  String get summaryBudgetOver => 'बजेट ओलांडले';

  @override
  String itemsProgress(String done, String total) {
    return '$total पैकी $done वस्तू';
  }

  @override
  String get filterAll => 'सर्व';

  @override
  String get filterToBuy => 'खरेदी करण्यासाठी';

  @override
  String get filterInCart => 'कार्टमध्ये';

  @override
  String get filterNotFound => 'सापडले नाही';

  @override
  String get filterRequired => 'आवश्यक';

  @override
  String get quickEntryTitle => 'प्रत्यक्ष किंमत';

  @override
  String get actualQuantityLabel => 'प्रत्यक्ष प्रमाण';

  @override
  String get actualPriceLabel => 'प्रत्यक्ष किंमत';

  @override
  String get discountLabel => 'सवलत (पर्यायी)';

  @override
  String get alternativeNameLabel => 'पर्यायी उत्पादनाचे नाव (पर्यायी)';

  @override
  String get savePurchaseButton => 'कार्टमध्ये जोडा';

  @override
  String get unplannedAddButton => 'योजना नसलेली वस्तू जोडा';

  @override
  String get statusPending => 'घेतलेले नाही';

  @override
  String get statusInCart => 'कार्टमध्ये';

  @override
  String get statusNotFound => 'सापडले नाही';

  @override
  String get statusGaveUp => 'हात झटकले';

  @override
  String get statusAlternative => 'पर्यायी खरेदी केले';

  @override
  String get keepScreenAwake => 'स्क्रीन चालू ठेवा';

  @override
  String get finishShopping => 'खरेदी पूर्ण करा';

  @override
  String get completionWarning =>
      'काही रिकॉर्ड्स चुकले आहेत किंवा पडताळणी झालेली नाही. तुम्ही अजूनही पूर्ण करू शकता; निकालात त्यांचा उल्लेख असेल.';

  @override
  String get continueShoppingButton => 'खरेदी सुरू ठेवा';

  @override
  String get resultTitle => 'निकाल';

  @override
  String get summarySection => 'सारांश';

  @override
  String get plannedTotalLabel => 'योजित एकूण';

  @override
  String get actualTotalLabel => 'प्रत्यक्ष एकूण';

  @override
  String get varianceLabel => 'फरक';

  @override
  String get varianceNotComputable => 'गणना करता येत नाही';

  @override
  String get budgetStatusLabel => 'बजेट';

  @override
  String get savingsLabel => 'योजनेपेक्षा कमी';

  @override
  String get overspendLabel => 'योजनेपेक्षा जास्त';

  @override
  String get unplannedTotalLabel => 'योजना नसलेले एकूण';

  @override
  String get unpurchasedLabel => 'योजित पण खरेदी केलेले नाही';

  @override
  String get totalDiscountLabel => 'एकूण सवलती';

  @override
  String get accuracyLabel => 'अंदाजाची अचूकता';

  @override
  String get groupsSection => 'वस्तू';

  @override
  String get groupPricier => 'योजनेपेक्षा महाग';

  @override
  String get groupCheaper => 'योजनेपेक्षा स्वस्त';

  @override
  String get groupClose => 'अंदाजाजवळ';

  @override
  String get groupNotTaken => 'योजित, खरेदी केलेले नाही';

  @override
  String get groupUnplanned => 'योजना नसताना खरेदी केले';

  @override
  String get groupQuantityChanged => 'प्रमाण बदलले';

  @override
  String get groupUnverified => 'पडताळणी झालेली नाही';

  @override
  String get plannedQtyLabel => 'योजित प्रमाण';

  @override
  String get actualQtyLabel => 'प्रत्यक्ष प्रमाण';

  @override
  String get plannedUnitPriceLabel => 'योजित एकक किंमत';

  @override
  String get actualUnitPriceLabel => 'प्रत्यक्ष एकक किंमत';

  @override
  String get lineVarianceLabel => 'ओळीतील फरक';

  @override
  String get discountEffectLabel => 'सवलतीचा परिणाम';

  @override
  String get notBoughtMark => 'खरेदी केलेले नाही';

  @override
  String get noPurchasesNote => 'कोणतीही खरेदी नोंदवली गेली नाही.';

  @override
  String get navHome => 'मुख्यपृष्ठ';

  @override
  String get navLists => 'यादी';

  @override
  String get navHistory => 'इतिहास';

  @override
  String get navSettings => 'सेटिंग्ज';

  @override
  String get homeEmptyTitle => 'आपल्या शॉपिंगची योजना आखा';

  @override
  String get homeEmptyBody =>
      'तुमची पहिली यादी तयार करा आणि अपेक्षित खर्च व प्रत्यक्ष खर्च यांची तुलना करा.';

  @override
  String get homeActiveSection => 'सक्रिय याद्या';

  @override
  String get homeCompletedSection => 'अलीकडे पूर्ण झालेल्या';

  @override
  String get homeMonthlySection => 'या महिन्यात';

  @override
  String get monthPlannedLabel => 'योजित';

  @override
  String get monthActualLabel => 'प्रत्यक्ष';

  @override
  String get monthVarianceLabel => 'फरक';

  @override
  String get continueShoppingLabel => 'खरेदी सुरू ठेवा';

  @override
  String get historyEmpty =>
      'अद्याप कोणतीही पूर्ण केलेली खरेदी नाही. तुमचा इतिहास आणि विश्लेषणे येथे दिसेल.';

  @override
  String get aboutTabTitle => 'NShoptor बद्दल';

  @override
  String get aboutBody =>
      'Crazy Penguin द्वारे NShoptor. ऑफलाइन-फर्स्ट शॉपिंग प्लॅनर. GPL-3.0 अंतर्गत लायसन्स प्राप्त.';

  @override
  String get startShoppingLabel => 'खरेदी सुरू करा';

  @override
  String get finishAndSeeResult => 'संपवून निकाल पहा';

  @override
  String get settingsTitle => 'सेटिंग्ज';

  @override
  String get languageLabel => 'भाषा';

  @override
  String get languageSystem => 'सिस्टम';

  @override
  String get languageTr => 'तुर्की';

  @override
  String get languageEn => 'इंग्रजी';

  @override
  String get themeLabel => 'थीम';

  @override
  String get themeSystem => 'सिस्टम';

  @override
  String get themeLight => 'हलका';

  @override
  String get themeDark => 'गडद';

  @override
  String get defaultCurrencyLabel => 'डीफॉल्ट चलन';

  @override
  String get defaultUnitLabel => 'डीफॉल्ट एकक';

  @override
  String get keepAwakeLabel => 'खरेदी करताना स्क्रीन चालू ठेवा';

  @override
  String get backupSection => 'बॅकअप';

  @override
  String get exportBackupLabel => 'बॅकअप एक्सपोर्ट करा';

  @override
  String get importBackupLabel => 'बॅकअप इम्पोर्ट करा';

  @override
  String get mergeImportLabel => 'सध्याच्या डेटामध्ये मिलावा';

  @override
  String get separateImportLabel => 'वेगळ्या कॉपी म्हणून इम्पोर्ट करा';

  @override
  String get importCancelled => 'इम्पोर्ट रद्द केले.';

  @override
  String get backupExported => 'बॅकअप यशस्वीरित्या एक्सपोर्ट केले.';

  @override
  String get backupSizeWarning =>
      'मोठा बॅकअप: फाइल मोठी असू शकते. तुम्हाला छायाचित्रे देखील समाविष्ट करायची आहेत का?';

  @override
  String get deleteAllSection => 'धोक्याची जागा';

  @override
  String get deleteAllLabel => 'सर्व डेटा हटवा';

  @override
  String get deleteAllConfirm =>
      'यामुळे सर्व याद्या, इतिहास, रिसेटचे फोटो आणि किंमती काढून टाकल्या जातील. तुम्ही एक्सपोर्ट केलेल्या फाइल्स तुमच्या ड्राइव्हवर राहतील. पुढे जायचे का?';

  @override
  String get deleteAllConfirm2 =>
      'तुम्हाला पूर्णपणे खात्री आहे का? ही कृता परत करता येणार नाही.';

  @override
  String get cancelAction => 'रद्द करा';

  @override
  String get confirmDelete => 'कायमस्वरूपी हटवा';

  @override
  String get dataDeleted => 'सर्व स्थानिक डेटा हटवला गेला.';

  @override
  String get privacyInfoLabel => 'गोपनीयता';

  @override
  String get privacyInfoBody =>
      'तुमच्या याद्या, किंमती, रिसेट्स आणि फोटो तुमच्या उपकरणावरच राहतात. फोटो आणि आवाज कधीही बाहेर जात नाहीत. जेव्हा AI मदत सक्रिय असते, तेव्हा फक्त मजकूर (उदा. रिसेट ओळी किंवा तुम्ही सांगितलेला मजकूर) प्रक्रियेसाठी आमच्या सर्व्हरवर पाठवला जातो आणि तो साठवला जात नाही.';

  @override
  String get aboutSection => 'बद्दल';

  @override
  String get aboutPublisher => 'प्रकाशक: Crazy Penguin';

  @override
  String get aboutLicenses => 'लायसन्सेस (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'आवाزی इनपुट';

  @override
  String get voiceStatusUnknown => 'सेवा: तपासले नाही';

  @override
  String get permissionsLabel => 'परवानग्या';

  @override
  String get permissionsBody =>
      'कॅमेरा, मायक्रोफोन आणि सूचना फक्त जेव्हा तुम्ही त्या वैशिष्ट्ये वापरता तेव्हाच विचारली जातात.';

  @override
  String get unitsSection => 'डीफॉल्ट्स';

  @override
  String get roundingNote =>
      'पैशांचे राऊंडिंग एका नियमानुसार होते: अर्धे शून्यापासून दूर राऊंड होतात, हे फक्त Money कन्व्हर्जनच्या वेळी एकदा लागू होते.';

  @override
  String get voiceInputTitle => 'आवाزی इनपुट';

  @override
  String get voiceStartListening => 'ऐकणे सुरू करा';

  @override
  String get voiceTranscriptLabel => 'ट्रान्सक्रिप्ट';

  @override
  String get parseAction => 'पार्स करा';

  @override
  String get receiptReviewTitle => 'रिसेट तपासा';

  @override
  String get receiptTotal => 'रसीद एकूण';

  @override
  String get receiptTotalUnknown => 'एकूण शोधला नाही';

  @override
  String get receiptDiff => 'फरक';

  @override
  String get acceptLine => 'ओळ स्वीकारा';

  @override
  String get ignoreLine => 'ओळ दुर्लक्षित करा';

  @override
  String get receiptLineActions =>
      'वस्तूसोबत लिंक करा, विभाजित करा किंवा दुर्लक्षित करा';

  @override
  String get receiptCommit => 'सर्व स्वीकारा';

  @override
  String get receiptCommitted => 'रसीद लागू केली.';

  @override
  String get priceHistoryTitle => 'किमतीचा इतिहास';

  @override
  String get noObservations => 'अद्याप कोणतेही किमतीचे निरीक्षण नाही';

  @override
  String get templatesSection => 'साचे';

  @override
  String get templateHint => 'मागील खरेदी प्रवासावरून नवीन यादी तयार करा';

  @override
  String get scanReceiptAction => 'रसीद स्कॅन करा';

  @override
  String get shelfLabelAction => 'शेल्फ लेबलवरील किंमत';

  @override
  String get priceCandidatesTitle => 'किंमत उमेदवार';

  @override
  String get noPriceCandidates => 'कोणतीही किंमत सापडली नाही; मॅन्युअली टाका.';

  @override
  String get voiceUnavailable =>
      'व्हॉइस रिकग्निशन उपलब्ध नाही; मॅन्युअली टाका.';

  @override
  String get linkToItem => 'वस्तूसोबत लिंक करा';

  @override
  String get splitLine => 'दोन भागांत विभाजित करा';

  @override
  String get mergeWithNext => 'पुढच्या ओळीसोबत विलीन करा';

  @override
  String get ocrNoText => 'कोणताही मजकूर वाचला नाही; पुन्हा प्रयत्न करा.';

  @override
  String get priceHistoryAction => 'किमतीचा इतिहास';

  @override
  String get itemsEmptyTitle => 'अद्याप कोणत्याही वस्तू नाहीत';

  @override
  String get itemsEmptyBody =>
      'तुमची पहिली वस्तू जोडा — दुकानात तुम्ही येथे खऱ्या किमती टाकाल.';

  @override
  String get addItemTooltip => 'वस्तू जोडा';

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
  String get setReminderAction => 'आठवण सेट करा';

  @override
  String get reminderPermissionDenied =>
      'आठवणींसाठी सूचना परवानगी आवश्यक आहे. तुम्ही सिस्टम सेटिंग्जमध्ये ती सक्षम करू शकता.';

  @override
  String get reminderScheduled => 'आठवण सेट झाली.';

  @override
  String get reminderCancelled => 'आठवण काढून टाकली.';

  @override
  String get reminderTitle => 'खरेदी आठवण';

  @override
  String reminderBody(Object title) {
    return 'तुमची यादी तपासण्याची वेळ आली: $title';
  }

  @override
  String get reminderPickDate => 'तारीख निवडा';

  @override
  String get reminderPickTime => 'वेळ निवडा';

  @override
  String get itemDetailsSection => 'तपशील';

  @override
  String get priceOptionalHint => 'ऐच्छिक — तुम्ही दुकानात खरी किंमत टाकाल';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'योजित: $total · $count वस्तू';
  }

  @override
  String get proActiveLabel => 'Pro सक्रिय — धन्यवाद!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'जाहिरात नाही, अधिक AI, बॅकअप · एका लहान मासिक किमतीपासून';

  @override
  String get proBenefitNoAds => 'जाहिरात-मुक्त अनुभव';

  @override
  String get proBenefitBackup => 'बॅकअप (एक्सपोर्ट/इम्पोर्ट)';

  @override
  String aboutVersion(Object version) {
    return 'व्हर्जन $version';
  }

  @override
  String get navDiscover => 'शोधा';

  @override
  String get shareAction => 'ॲप शेअर करा';

  @override
  String get rateAction => 'आम्हाला रेट करा';

  @override
  String get aboutOpenRow => 'आमच्याबद्दल आणि ओपन सोर्स';

  @override
  String get voiceAddItemAction => 'व्हॉइसद्वारे जोडा';

  @override
  String get formatLocaleLabel => 'संख्या आणि चलन स्वरूप';

  @override
  String get formatLocaleSystem =>
      'डिव्हाइस फॉरमॅट (लॅटिन अंकांसह; अन्यथा इंग्रजी)';

  @override
  String get formatLocaleTr => 'तुर्की (1.234,56)';

  @override
  String get formatLocaleEn => 'इंग्रजी (1,234.56)';

  @override
  String get aiToggleTitle => 'AI मदत';

  @override
  String get aiToggleSubtitle =>
      'रेसिप्ट जुळवते, किमतीच्या लेबल्स वाचते आणि वाक्ये यादीत रूपांतरित करते. फोटो आणि आवाज तुमच्या डिव्हाइसवर राहतात; फक्त मजकूर प्रक्रिया केला जातो.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'तुम्ही या महिन्याचे AI विनंत्या ($used/$limit) वापरल्या आहेत. अधिकसाठी अपग्रेड करा, किंवा AI शिवाय चालू ठेवा.';
  }

  @override
  String get aiOffline => 'कनेक्शन नाही — AI शिवाय चालू ठेवले जात आहे.';

  @override
  String get aiFailed => 'AI सध्या उपलब्ध नाही — त्याशिवाय चालू ठेवले जात आहे.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'डिव्हाइस';

  @override
  String get quickListAction => 'वाक्यातून जोडा';

  @override
  String get quickListTitle => 'जलद यादी';

  @override
  String get quickListHint => 'उदा. १ kg सफरचंद २०, २ ब्रेड्स, अर्धा किलो चीझ';

  @override
  String get quickListConvert => 'यादीत रूपांतरित करा';

  @override
  String quickListAdd(int count) {
    return '$count आयटम जोडा';
  }

  @override
  String get quickListEmpty =>
      'कोणतेही आयटम सापडले नाही. कृपया कॉमांनी वेगळे करून लिहा.';

  @override
  String get receiptAiMatched =>
      'AI ने रेसिप्ट तुमच्या यादीशी जुळवली. दुवे तपासा आणि पुष्टी करा.';

  @override
  String get receiptNeedsCheck => 'ही जुळणी तपासा';

  @override
  String get receiptDiscountLine => 'सवलत';

  @override
  String get compareItem => 'आयटम';

  @override
  String get compareEstimated => 'अंदाजित';

  @override
  String get compareActual => 'वास्तविक';

  @override
  String get compareDiff => 'फरक';

  @override
  String get compareTotal => 'एकूण';

  @override
  String get compareBudget => 'बजेट';

  @override
  String get compareNotBought => 'खरेदी केले नाही';

  @override
  String get compareUnplanned => 'योजित नाही';

  @override
  String get pricierItems => 'जास्त खर्च';

  @override
  String get cheaperItems => 'कमी खर्च';

  @override
  String get compareAction => 'तुलना करा';

  @override
  String get detailsSection => 'तपशील';

  @override
  String get spendingTitle => 'खर्च';

  @override
  String get spendingAction => 'खर्च';

  @override
  String get spendingMonthTotal => 'या महिन्यात';

  @override
  String get spendingWeekly => 'साप्ताहिक खर्च';

  @override
  String get spendingMonthly => 'मासिक खर्च';

  @override
  String get monthlyLimitTitle => 'मासिक मर्यादा';

  @override
  String get monthlyLimitHelp =>
      'तुम्ही दर महिन्याला शॉपिंगसाठी किती खर्च करायचे चाहता?';

  @override
  String get monthlyLimitRemove => 'काढा';

  @override
  String get monthlyLimitSet => 'सेट करा';

  @override
  String get monthlyLimitChange => 'बदला';

  @override
  String get monthlyLimitNone =>
      'किती उरले हे पाहण्यासाठी मासिक मर्यादा सेट करा.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount मरजेपेक्षा जास्त';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return 'या महिन्यात $amount उरले';
  }

  @override
  String get plansTitle => 'योजना';

  @override
  String get plansHeadline => 'AI सह स्मार्टपणे शॉपिंग करा';

  @override
  String get plansSubhead =>
      'रेसिप्ट जुळवणे, किमतीचे लेबल्स आणि वाक्यातून याद्या. कोणत्याही वेळी रद्द करा.';

  @override
  String get plansMonthly => 'मासिक';

  @override
  String get plansYearly => 'वार्षिक';

  @override
  String get planFree => 'मोफत';

  @override
  String get planFreePrice => 'कायमस्वरूपी मोफत';

  @override
  String get planFreeAi => 'महिनाभरात १५ AI विनंत्या';

  @override
  String get planFreeAds => 'लहान बॅनर जाहिराती (पहिल्या ७ दिवसांत नाही)';

  @override
  String get planCoreFeatures => 'याद्या, किमती, रेसिप्ट, खर्च आलेख';

  @override
  String get plansPerYear => '/ वर्ष';

  @override
  String get plansPerMonth => '/ महिना';

  @override
  String get planTrial => '७ दिवस मोफत';

  @override
  String get planProAi => 'महिनाभरात २०० AI विनंत्या';

  @override
  String get planNoAds => 'कोणतीही जाहिरात नाही';

  @override
  String get planBackup => 'बॅकअप एक्सपोर्ट आणि इम्पोर्ट';

  @override
  String get planMaxAi => 'महिन्याला १००० AI विनंत्या';

  @override
  String get planMaxFamily => 'मोठ्या कुटुंबाच्या खरेदीसाठी';

  @override
  String get plansStoreUnavailable => 'दुकान सध्या उपलब्ध नाही.';

  @override
  String get retryAction => 'पुन्हा प्रयत्न करा';

  @override
  String get plansPurchaseFailed =>
      'खरेदी पूर्ण झाली नाही. कृपया पुन्हा प्रयत्न करा.';

  @override
  String get planLifetimeTitle => 'आजीवन जाहिरात-मुक्त';

  @override
  String get planLifetimeSubtitle =>
      'एकदा भरा: जाहिरात नाही, बॅकअप; AI मोफत मर्यादेवर राहील';

  @override
  String get plansRestore => 'खरेदी रिकव्हर करा';

  @override
  String get plansLegal =>
      'सबस्क्रिप्शन्स रद्द करण्यापूर्वी स्वयंचलितपणे नूतनीकरण होतात. Google Play › पेमेंट्स अँड सबस्क्रिप्शन्स मध्ये कोणत्याही वेळी रद्द करा. किंमतींमध्ये Google Play द्वारे दर्शवलेली कर समाविष्ट आहे.';

  @override
  String get planCurrent => 'सध्याचे';

  @override
  String get planStartTrial => '७ दिवसांची मोफत ट्रायल सुरू करा';

  @override
  String get planChoose => 'निवडा';

  @override
  String get plansAction => 'प्लॅन्स: Pro आणि Max';

  @override
  String get assistantTitle => 'सहाय्यक';

  @override
  String get assistantGreeting => 'नमस्कार! तुम्हाला काय करायचे आहे?';

  @override
  String get assistantNewList => 'नवीन यादी';

  @override
  String get assistantVoiceList => 'आवाजाद्वारे यादी';

  @override
  String get assistantTextList => 'वाक्यापासून यादी';

  @override
  String get assistantScanReceipt => 'बिल स्कॅन करा';

  @override
  String get assistantSpending => 'माझा खर्च';

  @override
  String get assistantReceiptHint =>
      'आपली यादी उघडा आणि ती स्कॅन करण्यासाठी बिल आयकॉनवर टॅप करा.';

  @override
  String get assistantToggleTitle => 'सहाय्यक दाखवा';

  @override
  String get assistantToggleSubtitle => 'खाली उजव्या कोपऱ्यातील छोटा मदतनीस';

  @override
  String get scanPriceLabel => 'किंमत लेबल स्कॅन करा';

  @override
  String get saveFailed =>
      'सेव्ह करता आले नाही. तुमचे बदल अजूनही येथे आहेत. कृपया पुन्हा प्रयत्न करा.';

  @override
  String get deleteItemConfirm => 'हे आयटम आणि त्याची नोंदवलेली खरेदी हटवायची?';

  @override
  String get clearPurchaseConfirm =>
      'हे आयटम अनचेक करा आणि त्याची नोंदवलेली खरेदी काढून टाकायची?';

  @override
  String get reportPdfAction => 'PDF रिपोर्ट सेव्ह करा';

  @override
  String get reportNotInvoice =>
      'खरेदी सारांश, कर इनवॉइस नाही. कर दर अज्ञात आहेत.';

  @override
  String get purchaseVisits => 'खरेदी भेटी';

  @override
  String get purchaseInterval => 'खरेदींमधील सरासरी दिवस';

  @override
  String get purchasedQuantity => 'खरेदी केलेले प्रमाण';

  @override
  String get purchaseAnalyticsHint =>
      'खरेदी या वापराचे मापन नाही. चलने आणि एकके वेगळी दाखवली जातात.';

  @override
  String get receiptReplaces =>
      'लिंक केलेल्या रसीद ओळी अस्तित्वातील खरेदी बदलतात; लिंक नसलेल्या ओळी जोडल्या जातात.';

  @override
  String get voiceUnsupportedLanguage =>
      'या डिव्हाइसवर आवाजी इनपुटसाठी ही भाषा उपलब्ध नाही. तुम्ही टायप करू शकता.';
}
