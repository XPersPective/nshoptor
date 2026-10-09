// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'घर पर प्लान करें। योजना के अनुसार शॉपिंग करें।';

  @override
  String get listsTitle => 'सूचियाँ';

  @override
  String get listsTabActive => 'सक्रिय';

  @override
  String get listsTabCompleted => 'पूर्ण';

  @override
  String get listsTabArchived => 'आर्काइव';

  @override
  String get newListButton => 'नई सूची';

  @override
  String get listTitleHint => 'शीर्षक (वैकल्पिक)';

  @override
  String get saveButton => 'सेव करें';

  @override
  String get cancelButton => 'रद्द करें';

  @override
  String get deleteButton => 'हटाएँ';

  @override
  String get editAction => 'संपादित करें';

  @override
  String get listDeleted => 'सूची हटा दी गई';

  @override
  String get invalidAmountError => 'अमान्य राशि';

  @override
  String get duplicateAction => 'प्रतिलिपि बनाएँ';

  @override
  String get archiveAction => 'आर्काइव करें';

  @override
  String get unarchiveAction => 'आर्काइव से निकालें';

  @override
  String get deleteListConfirm =>
      'यह सूची हटाएँ? इसकी प्लान की गई वस्तुएँ भी हटा दी जाएँगी।';

  @override
  String get undoButton => 'पूर्ववत् करें';

  @override
  String get searchListHint => 'सूचियों में खोजें';

  @override
  String get currencyLabel => 'मुद्रा';

  @override
  String get budgetLabel => 'बजट (वैकल्पिक)';

  @override
  String get noteLabel => 'नोट (वैकल्पिक)';

  @override
  String get storeLabel => 'स्टोर';

  @override
  String get keepAmountsAction => 'राशियाँ रखें';

  @override
  String get resetAmountsAction => 'राशियाँ रीसेट करें';

  @override
  String get currencyChangeWarning =>
      'मुद्रा बदली जा रही है। मौजूदा राशियों के साथ क्या किया जाए?';

  @override
  String get listsEmpty =>
      'अभी तक कोई सूची नहीं है। अपनी पहली शॉपिंग योजना बनाएँ।';

  @override
  String get statusDraft => 'ड्राफ़्ट';

  @override
  String get statusPlanned => 'प्लान की गई';

  @override
  String get statusShopping => 'शॉपिंग';

  @override
  String get statusCompleted => 'पूर्ण';

  @override
  String get statusArchived => 'आर्काइव';

  @override
  String autoListTitle(String date) {
    return '$date शॉपिंग';
  }

  @override
  String get itemFormTitle => 'वस्तु जोड़ें';

  @override
  String get itemNameLabel => 'वस्तु का नाम';

  @override
  String get brandLabel => 'ब्रांड / वेरिएंट (वैकल्पिक)';

  @override
  String get categoryLabel => 'श्रेणी';

  @override
  String get quantityLabel => 'मात्रा';

  @override
  String get unitLabel => 'इकाई';

  @override
  String get pricingModeLabel => 'मूल्य प्रविष्टि';

  @override
  String get pricingModeUnitPrice => 'प्रति इकाई मूल्य';

  @override
  String get pricingModeLineTotal => 'कुल लाइन मूल्य';

  @override
  String get plannedPriceLabel => 'प्लान किया गया मूल्य';

  @override
  String lineTotalCalculated(String value) {
    return 'कुल लाइन मूल्य: $value';
  }

  @override
  String get requiredItemToggle => 'आवश्यक वस्तु';

  @override
  String get maxPriceLabel => 'स्वीकार्य अधिकतम मूल्य (वैकल्पिक)';

  @override
  String get itemNoteLabel => 'नोट (वैकल्पिक)';

  @override
  String get categoryProduce => 'फल और सब्जियाँ';

  @override
  String get categoryDairy => 'डेयरी उत्पाद';

  @override
  String get categoryMeat => 'मांस';

  @override
  String get categoryBakery => 'बेकरी';

  @override
  String get categoryDrinks => 'पेय';

  @override
  String get categoryCleaning => 'सफाई सामग्री';

  @override
  String get categoryPersonalCare => 'व्यक्तिगत देखभाल';

  @override
  String get categoryHome => 'गृह उपयोग';

  @override
  String get categoryOther => 'अन्य';

  @override
  String get invalidQuantityError => 'अमान्य मात्रा';

  @override
  String get invalidPriceError => 'अमान्य मूल्य';

  @override
  String get invalidNameError => 'एक नाम दर्ज करें';

  @override
  String unitPriceCalculated(String value) {
    return 'इकाई की कीमत: $value';
  }

  @override
  String get shoppingTitle => 'शॉपिंग मोड';

  @override
  String get summaryPlannedTotal => 'योजनाबद्ध कुल';

  @override
  String get summaryInCart => 'कार्ट में';

  @override
  String get summaryRemainingPlan => 'बाकी योजना';

  @override
  String get summaryProjected => 'अनुमानित चेकआउट';

  @override
  String get summaryBudgetRemaining => 'बजट शेष';

  @override
  String get summaryBudgetOver => 'बजट से अधिक';

  @override
  String itemsProgress(String done, String total) {
    return '$total आइटमों में से $done';
  }

  @override
  String get filterAll => 'सभी';

  @override
  String get filterToBuy => 'खरीदने के लिए';

  @override
  String get filterInCart => 'कार्ट में';

  @override
  String get filterNotFound => 'नहीं मिला';

  @override
  String get filterRequired => 'जरूरी';

  @override
  String get quickEntryTitle => 'वास्तविक कीमत';

  @override
  String get actualQuantityLabel => 'वास्तविक मात्रा';

  @override
  String get actualPriceLabel => 'वास्तविक कीमत';

  @override
  String get discountLabel => 'छूट (वैकल्पिक)';

  @override
  String get alternativeNameLabel => 'वैकल्पिक उत्पाद का नाम (वैकल्पिक)';

  @override
  String get savePurchaseButton => 'कार्ट में जोड़ें';

  @override
  String get unplannedAddButton => 'बिना योजना वाले आइटम को जोड़ें';

  @override
  String get statusPending => 'लेने बाकी';

  @override
  String get statusInCart => 'कार्ट में';

  @override
  String get statusNotFound => 'नहीं मिला';

  @override
  String get statusGaveUp => 'छोड़ दिया';

  @override
  String get statusAlternative => 'वैकल्पिक खरीदा गया';

  @override
  String get keepScreenAwake => 'स्क्रीन चालू रखें';

  @override
  String get finishShopping => 'शॉपिंग पूरी करें';

  @override
  String get completionWarning =>
      'कुम रिकॉर्ड या अस्वीकृत रिकॉर्ड मौजूद हैं। आप अभी भी समाप्त कर सकते हैं; परिणाम उनका उल्लेख करेगा।';

  @override
  String get continueShoppingButton => 'शॉपिंग जारी रखें';

  @override
  String get resultTitle => 'परिणाम';

  @override
  String get summarySection => 'सारांश';

  @override
  String get plannedTotalLabel => 'योजनाबद्ध कुल';

  @override
  String get actualTotalLabel => 'वास्तविक कुल';

  @override
  String get varianceLabel => 'अंतर';

  @override
  String get varianceNotComputable => 'गणना नहीं की जा सकती';

  @override
  String get budgetStatusLabel => 'बजट';

  @override
  String get savingsLabel => 'योजना से कम';

  @override
  String get overspendLabel => 'योजना से अधिक';

  @override
  String get unplannedTotalLabel => 'बिना योजना वाले कुल';

  @override
  String get unpurchasedLabel => 'योजनाबद्ध लेकिन नहीं खरीदा';

  @override
  String get totalDiscountLabel => 'कुल छूट';

  @override
  String get accuracyLabel => 'अनुमान की सटीकता';

  @override
  String get groupsSection => 'आइटम';

  @override
  String get groupPricier => 'योजना से महंगा';

  @override
  String get groupCheaper => 'योजना से सस्ता';

  @override
  String get groupClose => 'अनुमान के करीब';

  @override
  String get groupNotTaken => 'योजनाबद्ध, नहीं लिया गया';

  @override
  String get groupUnplanned => 'योजना के बिना खरीदा गया';

  @override
  String get groupQuantityChanged => 'मात्रा बदली गई';

  @override
  String get groupUnverified => 'सत्यापित नहीं';

  @override
  String get plannedQtyLabel => 'योजनाबद्ध मात्रा';

  @override
  String get actualQtyLabel => 'वास्तविक मात्रा';

  @override
  String get plannedUnitPriceLabel => 'योजनाबद्ध इकाई कीमत';

  @override
  String get actualUnitPriceLabel => 'वास्तविक इकाई कीमत';

  @override
  String get lineVarianceLabel => 'लाइन अंतर';

  @override
  String get discountEffectLabel => 'छूट प्रभाव';

  @override
  String get notBoughtMark => 'नहीं खरीदा गया';

  @override
  String get noPurchasesNote => 'कोई खरीदारी दर्ज नहीं की गई।';

  @override
  String get navHome => 'होम';

  @override
  String get navLists => 'लिस्टें';

  @override
  String get navHistory => 'इतिहास';

  @override
  String get navSettings => 'सेटिंग्स';

  @override
  String get homeEmptyTitle => 'अपनी शॉपिंग की योजना बनाएं';

  @override
  String get homeEmptyBody =>
      'अपनी पहली लिस्ट बनाएं और अनुमानित लागत vs वास्तविक लागत की तुलना करें।';

  @override
  String get homeActiveSection => 'सक्रिय लिस्टें';

  @override
  String get homeCompletedSection => 'हाल ही में पूर्ण';

  @override
  String get homeMonthlySection => 'इस महीने';

  @override
  String get monthPlannedLabel => 'योजनाबद्ध';

  @override
  String get monthActualLabel => 'वास्तविक';

  @override
  String get monthVarianceLabel => 'अंतर';

  @override
  String get continueShoppingLabel => 'शॉपिंग जारी रखें';

  @override
  String get historyEmpty =>
      'अभी तक कोई पूर्ण शॉपिंग नहीं है। आपका इतिहास और अंतर्दृष्टि यहाँ दिखाई देंगी।';

  @override
  String get aboutTabTitle => 'NShoptor के बारे में';

  @override
  String get aboutBody =>
      'Crazy Penguin द्वारा NShoptor। ऑफ़लाइन-फ़र्स्ट शॉपिंग प्लानर। GPL-3.0 के तहत लाइसेंस प्राप्त।';

  @override
  String get startShoppingLabel => 'शॉपिंग शुरू करें';

  @override
  String get finishAndSeeResult => 'पूर्ण करें और परिणाम देखें';

  @override
  String get settingsTitle => 'सेटिंग्स';

  @override
  String get languageLabel => 'भाषा';

  @override
  String get languageSystem => 'सिस्टम';

  @override
  String get languageTr => 'तुर्की';

  @override
  String get languageEn => 'अंग्रेज़ी';

  @override
  String get themeLabel => 'थीम';

  @override
  String get themeSystem => 'सिस्टम';

  @override
  String get themeLight => 'हल्का';

  @override
  String get themeDark => 'गहरा';

  @override
  String get defaultCurrencyLabel => 'डिफ़ॉल्ट मुद्रा';

  @override
  String get defaultUnitLabel => 'डिफ़ॉल्ट इकाई';

  @override
  String get keepAwakeLabel => 'शॉपिंग करते समय स्क्रीन चालू रखें';

  @override
  String get backupSection => 'बैकअप';

  @override
  String get exportBackupLabel => 'बैकअप निर्यात करें';

  @override
  String get importBackupLabel => 'बैकअप आयात करें';

  @override
  String get mergeImportLabel => 'वर्तमान डेटा में विलीन करें';

  @override
  String get separateImportLabel => 'अलग कॉपी के रूप में आयात करें';

  @override
  String get importCancelled => 'आयात रद्द किया गया।';

  @override
  String get backupExported => 'बैकअप सफलतापूर्वक निर्यात किया गया।';

  @override
  String get backupSizeWarning =>
      'बड़ा बैकअप: फ़ाइल बड़ी हो सकती है। क्या आप फ़ोटो भी शामिल करना चाहते हैं?';

  @override
  String get deleteAllSection => 'खतरनाक क्षेत्र';

  @override
  String get deleteAllLabel => 'सभी डेटा हटाएं';

  @override
  String get deleteAllConfirm =>
      'इससे सभी लिस्टें, इतिहास, रसीद फ़ोटो और कीमतें हटा दी जाएंगी। आपके द्वारा निर्यात की गई फ़ाइलें आपके ड्राइव पर रहेंगी। जारी रखें?';

  @override
  String get deleteAllConfirm2 =>
      'क्या आप पूरी तरह से सुनिश्चित हैं? यह क्रिया पूर्ववत नहीं की जा सकती।';

  @override
  String get cancelAction => 'रद्द करें';

  @override
  String get confirmDelete => 'स्थायी रूप से हटाएं';

  @override
  String get dataDeleted => 'सभी स्थानीय डेटा हटा दिया गया था।';

  @override
  String get privacyInfoLabel => 'गोपनीयता';

  @override
  String get privacyInfoBody =>
      'आपकी लिस्टें, कीमतें, रसीदें और फ़ोटो आपके डिवाइस पर ही रहती हैं। फ़ोटो और आवाज़ कभी बाहर नहीं जातीं। जब AI सहायता सक्रिय होती है, तो केवल पाठ (उदाहरण के लिए रसीद की पंक्तियाँ या आपने जो बोला) प्रसंस्करण के लिए हमारे सर्वर पर भेजा जाता है और उसे संग्रहीत नहीं किया जाता है।';

  @override
  String get aboutSection => 'परिचय';

  @override
  String get aboutPublisher => 'प्रकाशक: Crazy Penguin';

  @override
  String get aboutLicenses => 'लाइसेंस (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'वॉइस इनपुट';

  @override
  String get voiceStatusUnknown => 'सेवा: जांच नहीं की गई';

  @override
  String get permissionsLabel => 'अनुमतियाँ';

  @override
  String get permissionsBody =>
      'कैमरा, माइक्रोफ़ोन और सूचनाएँ केवल तभी अनुरोध की जाती हैं जब आप वास्तव में उन सुविधाओं का उपयोग करते हैं।';

  @override
  String get unitsSection => 'डिफ़ॉल्ट';

  @override
  String get roundingNote =>
      'पैसे का राउंडिंग एक नियम का पालन करता है: शून्य से दूर अर्धे राउंड होते हैं, यह केवल Money कन्वर्ट करने पर एक बार लागू होता है।';

  @override
  String get voiceInputTitle => 'वॉइस इनपुट';

  @override
  String get voiceStartListening => 'सुनना शुरू करें';

  @override
  String get voiceTranscriptLabel => 'ट्रांसक्रिप्ट';

  @override
  String get parseAction => 'पार्स करें';

  @override
  String get receiptReviewTitle => 'रसीद की समीक्षा करें';

  @override
  String get receiptTotal => 'रसीद का कुल';

  @override
  String get receiptTotalUnknown => 'कुल नहीं मिला';

  @override
  String get receiptDiff => 'अंतर';

  @override
  String get acceptLine => 'लाइन स्वीकार करें';

  @override
  String get ignoreLine => 'लाइन नज़रअंदाज़ करें';

  @override
  String get receiptLineActions =>
      'आइटम से लिंक करें, दो भागों में बाँटें या नज़रअंदाज़ करें';

  @override
  String get receiptCommit => 'सभी स्वीकार करें';

  @override
  String get receiptCommitted => 'रसीद लागू हो गई।';

  @override
  String get priceHistoryTitle => 'कीमत का इतिहास';

  @override
  String get noObservations => 'अभी तक कोई कीमत रिकॉर्ड नहीं है';

  @override
  String get templatesSection => 'टेम्पलेट्स';

  @override
  String get templateHint => 'पिछली शॉपिंग ट्रिप से एक नई प्लान बनाएं';

  @override
  String get scanReceiptAction => 'रसीद स्कैन करें';

  @override
  String get shelfLabelAction => 'शेल्फ लेबल से कीमत';

  @override
  String get priceCandidatesTitle => 'कीमत के उम्मीदवार';

  @override
  String get noPriceCandidates =>
      'कोई कीमत नहीं मिली; इसे मैन्युअल रूप से दर्ज करें।';

  @override
  String get voiceUnavailable =>
      'वॉइस रिकग्निशन उपलब्ध नहीं है; मैन्युअल रूप से दर्ज करें।';

  @override
  String get linkToItem => 'आइटम से लिंक करें';

  @override
  String get splitLine => 'दो भागों में बाँटें';

  @override
  String get mergeWithNext => 'अगली के साथ मर्ज करें';

  @override
  String get ocrNoText => 'कोई टेक्स्ट नहीं पढ़ा गया; फिर से कोशिश करें।';

  @override
  String get priceHistoryAction => 'कीमत का इतिहास';

  @override
  String get itemsEmptyTitle => 'अभी तक कोई आइटम नहीं';

  @override
  String get itemsEmptyBody =>
      'अपना पहला आइटम जोड़ें — दुकान पर असली कीमत यहाँ दर्ज करेंगे।';

  @override
  String get addItemTooltip => 'आइटम जोड़ें';

  @override
  String get unitAdet => 'पीसी';

  @override
  String get unitKilogram => 'किग्रा';

  @override
  String get unitGram => 'ग्राम';

  @override
  String get unitLitre => 'लीटर';

  @override
  String get unitMililitre => 'मिलीलीटर';

  @override
  String get unitPaket => 'पैक';

  @override
  String get unitKutu => 'बॉक्स';

  @override
  String get unitSise => 'बोतल';

  @override
  String get unitKavanoz => 'जार';

  @override
  String get unitDemet => 'गुच्छा';

  @override
  String get unitDuzine => 'डजन';

  @override
  String get unitMetre => 'मीटर';

  @override
  String get unitCustom => 'कस्टम';

  @override
  String get setReminderAction => 'रिमाइंडर सेट करें';

  @override
  String get reminderPermissionDenied =>
      'रिमाइंडर्स के लिए नोटिफिकेशन अनुमति की आवश्यकता है। आप इसे सिस्टम सेटिंग्स में चालू कर सकते हैं।';

  @override
  String get reminderScheduled => 'रिमाइंडर सेट हो गया।';

  @override
  String get reminderCancelled => 'रिमाइंडर हटा दिया गया।';

  @override
  String get reminderTitle => 'शॉपिंग रिमाइंडर';

  @override
  String reminderBody(Object title) {
    return 'अपनी लिस्ट चेक करने का समय: $title';
  }

  @override
  String get reminderPickDate => 'एक तारीख चुनें';

  @override
  String get reminderPickTime => 'एक समय चुनें';

  @override
  String get itemDetailsSection => 'विवरण';

  @override
  String get priceOptionalHint =>
      'वैकल्पिक — आप दुकान पर असली कीमत दर्ज करेंगे';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'योजनाबद्ध: $total · $count आइटम';
  }

  @override
  String get proActiveLabel => 'Pro सक्रिय — धन्यवाद!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'कोई विज्ञापन नहीं, अधिक AI, बैकअप · एक छोटी मासिक कीमत से';

  @override
  String get proBenefitNoAds => 'विज्ञापन-मुक्त अनुभव';

  @override
  String get proBenefitBackup => 'बैकअप (एक्सपोर्ट/इम्पोर्ट)';

  @override
  String aboutVersion(Object version) {
    return 'संस्करण $version';
  }

  @override
  String get navDiscover => 'खोजें';

  @override
  String get shareAction => 'ऐप शेयर करें';

  @override
  String get rateAction => 'हमें रेट करें';

  @override
  String get aboutOpenRow => 'बारे में और ओपन सोर्स';

  @override
  String get voiceAddItemAction => 'वॉइस से जोड़ें';

  @override
  String get formatLocaleLabel => 'संख्या और मुद्रा प्रारूप';

  @override
  String get formatLocaleSystem =>
      'डिवाइस फॉर्मेट (लैटिन अंक; अन्यथा अंग्रेजी)';

  @override
  String get formatLocaleTr => 'तुर्की (1.234,56)';

  @override
  String get formatLocaleEn => 'अंग्रेज़ी (1,234.56)';

  @override
  String get aiToggleTitle => 'AI सहायता';

  @override
  String get aiToggleSubtitle =>
      'रसीदों को मिलाता है, कीमत के लेबल पढ़ता है और वाक्यों को सूचियों में बदलता है। फोटो और आवाज़ आपके डिवाइस पर ही रहती हैं; केवल टेक्स्ट प्रोसेस किया जाता है।';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'आपने इस महीने की AI रिक्वेस्ट ($used/$limit) उपयोग कर ली हैं। अधिक के लिए अपग्रेड करें, या बिना AI के जारी रखें।';
  }

  @override
  String get aiOffline => 'कोई कनेक्शन नहीं — बिना AI के जारी रखा जा रहा है।';

  @override
  String get aiFailed =>
      'AI अभी उपलब्ध नहीं है — इसके बिना जारी रखा जा रहा है।';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'डिवाइस';

  @override
  String get quickListAction => 'एक वाक्य से जोड़ें';

  @override
  String get quickListTitle => 'त्वरित सूची';

  @override
  String get quickListHint => 'जैसे: 1 kg सेब 20, 2 ब्रेड, आधा किलो पनीर';

  @override
  String get quickListConvert => 'सूची में बदलें';

  @override
  String quickListAdd(int count) {
    return '$count आइटम जोड़ें';
  }

  @override
  String get quickListEmpty =>
      'कोई आइटम नहीं मिला। उन्हें अल्पविराम से अलग करके लिखने का प्रयास करें।';

  @override
  String get receiptAiMatched =>
      'AI ने रसीद को आपकी सूची से मिला दिया है। लिंक देखें और पुष्टि करें।';

  @override
  String get receiptNeedsCheck => 'इस मिलान की जाँच करें';

  @override
  String get receiptDiscountLine => 'छूट';

  @override
  String get compareItem => 'आइटम';

  @override
  String get compareEstimated => 'अनुमानित';

  @override
  String get compareActual => 'वास्तविक';

  @override
  String get compareDiff => 'अंतर';

  @override
  String get compareTotal => 'कुल';

  @override
  String get compareBudget => 'बजट';

  @override
  String get compareNotBought => 'खरीदा नहीं';

  @override
  String get compareUnplanned => 'योजनाबद्ध नहीं';

  @override
  String get pricierItems => 'और महंगा';

  @override
  String get cheaperItems => 'सस्ता';

  @override
  String get compareAction => 'तुलना करें';

  @override
  String get detailsSection => 'विवरण';

  @override
  String get spendingTitle => 'खर्च';

  @override
  String get spendingAction => 'खर्च';

  @override
  String get spendingMonthTotal => 'इस महीने';

  @override
  String get spendingWeekly => 'साप्ताहिक खर्च';

  @override
  String get spendingMonthly => 'मासिक खर्च';

  @override
  String get monthlyLimitTitle => 'मासिक सीमा';

  @override
  String get monthlyLimitHelp =>
      'आप मासिक रूप से शॉपिंग पर कितना खर्च करना चाहते हैं?';

  @override
  String get monthlyLimitRemove => 'हटाएं';

  @override
  String get monthlyLimitSet => 'सेट करें';

  @override
  String get monthlyLimitChange => 'बदलें';

  @override
  String get monthlyLimitNone =>
      'देखने के लिए कि आपको कितना बचा है, एक मासिक सीमा निर्धारित करें।';

  @override
  String monthlyLimitOver(String amount) {
    return 'सीमा से $amount अधिक';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return 'इस महीने $amount बचा है';
  }

  @override
  String get plansTitle => 'योजनाएं';

  @override
  String get plansHeadline => 'AI के साथ स्मार्ट शॉपिंग करें';

  @override
  String get plansSubhead =>
      'रसीद मिलान, कीमत के लेबल और वाक्य से सूचियां। किसी भी समय रद्द करें।';

  @override
  String get plansMonthly => 'मासिक';

  @override
  String get plansYearly => 'वार्षिक';

  @override
  String get planFree => 'मुफ्त';

  @override
  String get planFreePrice => 'हमेशा मुफ्त';

  @override
  String get planFreeAi => 'प्रति माह 15 AI रिक्वेस्ट';

  @override
  String get planFreeAds => 'छोटी बैनर विज्ञापन (पहले 7 दिनों में कोई नहीं)';

  @override
  String get planCoreFeatures => 'सूचियां, कीमतें, रसीदें, खर्च चार्ट';

  @override
  String get plansPerYear => '/ वर्ष';

  @override
  String get plansPerMonth => '/ माह';

  @override
  String get planTrial => '7 दिन मुफ्त';

  @override
  String get planProAi => 'प्रति माह 200 AI रिक्वेस्ट';

  @override
  String get planNoAds => 'कोई विज्ञापन नहीं';

  @override
  String get planBackup => 'बैकअप निर्यात और आयात';

  @override
  String get planMaxAi => 'प्रति माह 1000 AI अनुरोध';

  @override
  String get planMaxFamily => 'बड़ी परिवार की शॉपिंग के लिए';

  @override
  String get plansStoreUnavailable => 'दुकान अभी उपलब्ध नहीं है।';

  @override
  String get retryAction => 'फिर से कोशिश करें';

  @override
  String get plansPurchaseFailed =>
      'खरीदारी पूरी नहीं हुई। कृपया फिर से प्रयास करें।';

  @override
  String get planLifetimeTitle => 'जीवन भर विज्ञापन-मुक्त';

  @override
  String get planLifetimeSubtitle =>
      'एक बार भुगतान: कोई विज्ञापन नहीं, बैकअप; AI मुफ्त सुविधा पर ही रहेगा';

  @override
  String get plansRestore => 'खरीदारी पुनर्स्थापित करें';

  @override
  String get plansLegal =>
      'सदस्यता रद्द करने तक स्वचालित रूप से नवीनीकृत होती रहती हैं। किसी भी समय Google Play › भुगतान और सदस्यता में रद्द करें। मूल्यों में Google Play द्वारा दिखाए गए कर शामिल हैं।';

  @override
  String get planCurrent => 'वर्तमान';

  @override
  String get planStartTrial => '7 दिन का निःशुल्क ट्रायल शुरू करें';

  @override
  String get planChoose => 'चुनें';

  @override
  String get plansAction => 'योजनाएं: Pro और Max';

  @override
  String get assistantTitle => 'सहायक';

  @override
  String get assistantGreeting => 'नमस्ते! आप क्या करना चाहेंगे?';

  @override
  String get assistantNewList => 'नई सूची';

  @override
  String get assistantVoiceList => 'आवाज़ से सूची बनाएं';

  @override
  String get assistantTextList => 'वाक्य से सूची बनाएं';

  @override
  String get assistantScanReceipt => 'रसीद स्कैन करें';

  @override
  String get assistantSpending => 'मेरा खर्च';

  @override
  String get assistantReceiptHint =>
      'अपनी सूची खोलें और उसे स्कैन करने के लिए रसीद आइकन पर टैप करें।';

  @override
  String get assistantToggleTitle => 'सहायक दिखाएं';

  @override
  String get assistantToggleSubtitle => 'दाहिनी ओर नीचे छोटा सहायक';

  @override
  String get scanPriceLabel => 'कीमत लेबल स्कैन करें';

  @override
  String get saveFailed =>
      'सेव नहीं हो सका। आपकी बदलाव अभी भी हैं। कृपया पुनः प्रयास करें।';

  @override
  String get deleteItemConfirm =>
      'इस आइटम और इसके रिकॉर्ड किए गए खरीदों को हटाएं?';

  @override
  String get clearPurchaseConfirm =>
      'इस आइटम को अनचेक करें और इसके रिकॉर्ड किए गए खरीदों को हटाएं?';

  @override
  String get reportPdfAction => 'PDF रिपोर्ट सेव करें';

  @override
  String get reportNotInvoice =>
      'शॉपिंग सारांश, कर इनवॉइस नहीं। कर दरें अज्ञात हैं।';

  @override
  String get purchaseVisits => 'खरीद की यात्राएँ';

  @override
  String get purchaseInterval => 'खरीद के बीच औसत दिन';

  @override
  String get purchasedQuantity => 'खरीदी गई मात्रा';

  @override
  String get purchaseAnalyticsHint =>
      'खरीद उपभोग को मापते नहीं हैं। मुद्राएँ और इकाइयों को अलग दिखाया जाता है।';

  @override
  String get receiptReplaces =>
      'लिंक किए गए रसीद पंक्तियाँ मौजूदा खरीदों को प्रतिस्थापित करती हैं; अनलिंक पंक्तियाँ जोड़ी जाती हैं।';

  @override
  String get voiceUnsupportedLanguage =>
      'इस डिवाइस पर इस भाषा के लिए वॉइस इनपुट उपलब्ध नहीं है। आप टाइप कर सकते हैं।';

  @override
  String get voiceStopListening => 'सुनना बंद करें';

  @override
  String get keepAwakeFailed =>
      'स्क्रीन को जगाए रखने में विफल रहा। कृपया पुनः प्रयास करें।';
}
