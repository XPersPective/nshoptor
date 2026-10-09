// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Telugu (`te`).
class AppLocalizationsTe extends AppLocalizations {
  AppLocalizationsTe([String locale = 'te']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan =>
      'ఇంటి నుండి ప్రణాళిక చేయండి. ప్రణాళిక ప్రకారం షాపింగ్ చేయండి.';

  @override
  String get listsTitle => 'జాబితాలు';

  @override
  String get listsTabActive => 'క్రియాశీలకం';

  @override
  String get listsTabCompleted => 'పూర్తయినవి';

  @override
  String get listsTabArchived => 'ఆర్కైవ్ చేసినవి';

  @override
  String get newListButton => 'కొత్త జాబితా';

  @override
  String get listTitleHint => 'శీర్షిక (ఐచ్ఛికం)';

  @override
  String get saveButton => 'సేవ్ చేయి';

  @override
  String get cancelButton => 'రద్దు చేయి';

  @override
  String get deleteButton => 'తొలగించు';

  @override
  String get editAction => 'సవరించు';

  @override
  String get listDeleted => 'జాబితా తొలగించబడింది';

  @override
  String get invalidAmountError => 'అమాంతం చెల్లదు';

  @override
  String get duplicateAction => 'ప్రతికృతి';

  @override
  String get archiveAction => 'ఆర్కైవ్ చేయి';

  @override
  String get unarchiveAction => 'ఆర్కైవ్ నుండి తీసివేయి';

  @override
  String get deleteListConfirm =>
      'ఈ జాబితాను తొలగించాలా? దాని ప్రణాళిక వస్తువులు కూడా తొలగించబడతాయి.';

  @override
  String get undoButton => 'వాపసు';

  @override
  String get searchListHint => 'జాబితాలను వెతకండి';

  @override
  String get currencyLabel => 'నాణెం';

  @override
  String get budgetLabel => 'బడ్జెట్ (ఐచ్ఛికం)';

  @override
  String get noteLabel => 'గమనిక (ఐచ్ఛికం)';

  @override
  String get storeLabel => 'దোকान';

  @override
  String get keepAmountsAction => 'రాశులు ఉంచు';

  @override
  String get resetAmountsAction => 'రాశులను రీసెట్ చేయి';

  @override
  String get currencyChangeWarning =>
      'నాణెం మారుతోంది. ఉన్న రాశులతో ఏమి చేయాలి?';

  @override
  String get listsEmpty =>
      'ఇంకా జాబితాలు లేవు. మీ మొదటి షాపింగ్ ప్రణాళికను సృష్టించండి.';

  @override
  String get statusDraft => 'ఖాకా';

  @override
  String get statusPlanned => 'ప్రణాళిక';

  @override
  String get statusShopping => 'షాపింగ్';

  @override
  String get statusCompleted => 'పూర్తయింది';

  @override
  String get statusArchived => 'ఆర్కైవ్ చేయబడింది';

  @override
  String autoListTitle(String date) {
    return '$date షాపింగ్';
  }

  @override
  String get itemFormTitle => 'వస్తువును జోడించండి';

  @override
  String get itemNameLabel => 'వస్తువు పేరు';

  @override
  String get brandLabel => 'బ్రాండ్ / రకం (ఐచ్ఛికం)';

  @override
  String get categoryLabel => 'వర్గం';

  @override
  String get quantityLabel => 'రాశి';

  @override
  String get unitLabel => 'ఏకకం';

  @override
  String get pricingModeLabel => 'ధర నమోదు';

  @override
  String get pricingModeUnitPrice => 'ఏకక ధర';

  @override
  String get pricingModeLineTotal => 'మొత్తం';

  @override
  String get plannedPriceLabel => 'ప్రణాళిక ధర';

  @override
  String lineTotalCalculated(String value) {
    return 'మొత్తం: $value';
  }

  @override
  String get requiredItemToggle => 'అవసరమైన వస్తువు';

  @override
  String get maxPriceLabel => 'గరిష్ట అంగీకరించదగిన ధర (ఐచ్ఛికం)';

  @override
  String get itemNoteLabel => 'గమనిక (ఐచ్ఛికం)';

  @override
  String get categoryProduce => 'పండ్లు & కూరగాయలు';

  @override
  String get categoryDairy => 'డైరీ ఉత్పత్తులు';

  @override
  String get categoryMeat => 'మాంసం';

  @override
  String get categoryBakery => 'బేకరీ';

  @override
  String get categoryDrinks => 'పానీయాలు';

  @override
  String get categoryCleaning => 'శుభ్రపరచడం';

  @override
  String get categoryPersonalCare => 'వ్యక్తిగత సంరక్షణ';

  @override
  String get categoryHome => 'ఇల్లు';

  @override
  String get categoryOther => 'ఇతరాలు';

  @override
  String get invalidQuantityError => 'రాశి చెల్లదు';

  @override
  String get invalidPriceError => 'ధర చెల్లదు';

  @override
  String get invalidNameError => 'పేరు నమోదు చేయండి';

  @override
  String unitPriceCalculated(String value) {
    return 'యూనిట్ ధర: $value';
  }

  @override
  String get shoppingTitle => 'షాపింగ్ మోడ్';

  @override
  String get summaryPlannedTotal => 'ప్లాన్ చేసిన మొత్తం';

  @override
  String get summaryInCart => 'కార్ట్‌లో ఉంది';

  @override
  String get summaryRemainingPlan => 'మిగిలిన ప్లాన్';

  @override
  String get summaryProjected => 'అంచనా చెక్‌అవుట్';

  @override
  String get summaryBudgetRemaining => 'బడ్జెట్ మిగిలింది';

  @override
  String get summaryBudgetOver => 'బడ్జెట్ దాటింది';

  @override
  String itemsProgress(String done, String total) {
    return '$total వస్తువుల్లో $done';
  }

  @override
  String get filterAll => 'అన్నీ';

  @override
  String get filterToBuy => 'కొనాలి';

  @override
  String get filterInCart => 'కార్ట్‌లో ఉంది';

  @override
  String get filterNotFound => 'దొరకలేదు';

  @override
  String get filterRequired => 'అవసరం';

  @override
  String get quickEntryTitle => 'వాస్తవ ధర';

  @override
  String get actualQuantityLabel => 'వాస్తవ పరిమాణం';

  @override
  String get actualPriceLabel => 'వాస్తవ ధర';

  @override
  String get discountLabel => 'డిస్కౌంట్ (ఐచ్ఛికం)';

  @override
  String get alternativeNameLabel => 'ప్రత్యామ్నాయ ఉత్పత్తి పేరు (ఐచ్ఛికం)';

  @override
  String get savePurchaseButton => 'కార్ట్‌లో కలుపు';

  @override
  String get unplannedAddButton => 'ప్లాన్ చేయని వస్తువును జోడించు';

  @override
  String get statusPending => 'తీసుకోలేదు';

  @override
  String get statusInCart => 'కార్ట్‌లో ఉంది';

  @override
  String get statusNotFound => 'దొరకలేదు';

  @override
  String get statusGaveUp => 'విడిచిపెట్టారు';

  @override
  String get statusAlternative => 'ప్రత్యామ్నాయం కొన్నారు';

  @override
  String get keepScreenAwake => 'స్క్రీన్ ఆన్‌గా ఉంచు';

  @override
  String get finishShopping => 'షాపింగ్ ముగించు';

  @override
  String get completionWarning =>
      'కొన్ని రికార్డులు లేవు లేదా సరిచూడలేదు. మీరు ఇంకా ముగించవచ్చు; ఫలితంలో వాటి గురించి నోట్ చేయబడుతుంది.';

  @override
  String get continueShoppingButton => 'షాపింగ్ కొనసాగించు';

  @override
  String get resultTitle => 'ఫలితం';

  @override
  String get summarySection => 'సారాంశం';

  @override
  String get plannedTotalLabel => 'ప్లాన్ చేసిన మొత్తం';

  @override
  String get actualTotalLabel => 'వాస్తవ మొత్తం';

  @override
  String get varianceLabel => 'వ్యత్యాసం';

  @override
  String get varianceNotComputable => 'లెక్కించలేము';

  @override
  String get budgetStatusLabel => 'బడ్జెట్';

  @override
  String get savingsLabel => 'ప్లాన్ కంటే తక్కువ';

  @override
  String get overspendLabel => 'ప్లాన్ కంటే ఎక్కువ';

  @override
  String get unplannedTotalLabel => 'ప్లాన్ చేయని మొత్తం';

  @override
  String get unpurchasedLabel => 'ప్లాన్ చేశారు కానీ కొనలేదు';

  @override
  String get totalDiscountLabel => 'మొత్తం డిస్కౌంట్లు';

  @override
  String get accuracyLabel => 'అంచనా ఖచ్చితత్వం';

  @override
  String get groupsSection => 'వస్తువులు';

  @override
  String get groupPricier => 'ప్లాన్ కంటే ఖరీదైనది';

  @override
  String get groupCheaper => 'ప్లాన్ కంటే చౌకైనది';

  @override
  String get groupClose => 'అంచనాకు దగ్గరగా';

  @override
  String get groupNotTaken => 'ప్లాన్ చేశారు, కొనలేదు';

  @override
  String get groupUnplanned => 'ప్లాన్ లేకుండా కొన్నారు';

  @override
  String get groupQuantityChanged => 'పరిమాణం మారింది';

  @override
  String get groupUnverified => 'సరిచూడలేదు';

  @override
  String get plannedQtyLabel => 'ప్లాన్ చేసిన పరిమాణం';

  @override
  String get actualQtyLabel => 'వాస్తవ పరిమాణం';

  @override
  String get plannedUnitPriceLabel => 'ప్లాన్ చేసిన యూనిట్ ధర';

  @override
  String get actualUnitPriceLabel => 'వాస్తవ యూనిట్ ధర';

  @override
  String get lineVarianceLabel => 'లైన్ వ్యత్యాసం';

  @override
  String get discountEffectLabel => 'డిస్కౌంట్ ప్రభావం';

  @override
  String get notBoughtMark => 'కొనలేదు';

  @override
  String get noPurchasesNote => 'ఏ కొనుగోళ్ళూ రికార్డ్ చేయలేదు.';

  @override
  String get navHome => 'హోమ్';

  @override
  String get navLists => 'జాబితాలు';

  @override
  String get navHistory => 'చరిత్ర';

  @override
  String get navSettings => 'సెట్టింగ్లు';

  @override
  String get homeEmptyTitle => 'మీ షాపింగ్‌ను ప్రణాళిక చేయండి';

  @override
  String get homeEmptyBody =>
      'మీ మొదటి జాబితాను సృష్టించండి, అంచనా వేసిన మరియు నిజమైన ఖర్చులను పోల్చండి.';

  @override
  String get homeActiveSection => 'క్రియాశీలక జాబితాలు';

  @override
  String get homeCompletedSection => 'ఇటీవల పూర్తి చేసినవి';

  @override
  String get homeMonthlySection => 'ఈ నెల';

  @override
  String get monthPlannedLabel => 'ప్రణాళిక';

  @override
  String get monthActualLabel => 'నిజం';

  @override
  String get monthVarianceLabel => 'వ్యత్యాసం';

  @override
  String get continueShoppingLabel => 'షాపింగ్ కొనసాగించండి';

  @override
  String get historyEmpty =>
      'ఇంకా పూర్తి చేసిన షాపింగ్ లేదు. మీ చరిత్ర మరియు విశ్లేషణలు ఇక్కడ కనిపిస్తాయి.';

  @override
  String get aboutTabTitle => 'NShoptor గురించి';

  @override
  String get aboutBody =>
      'Crazy Penguin ద్వారా NShoptor. ఆఫ్‌లైన్-ఫస్ట్ షాపింగ్ ప్లానర్. GPL-3.0 లైసెన్సుతో.';

  @override
  String get startShoppingLabel => 'షాపింగ్ ప్రారంభించండి';

  @override
  String get finishAndSeeResult => 'ముగించండి & ఫలితం చూడండి';

  @override
  String get settingsTitle => 'సెట్టింగ్లు';

  @override
  String get languageLabel => 'భాష';

  @override
  String get languageSystem => 'సిస్టమ్';

  @override
  String get languageTr => 'తుర్కిష్';

  @override
  String get languageEn => 'ఆంగ్లం';

  @override
  String get themeLabel => 'థీమ్';

  @override
  String get themeSystem => 'సిస్టమ్';

  @override
  String get themeLight => 'ప్రకాశవంతమైనది';

  @override
  String get themeDark => 'కొండలు';

  @override
  String get defaultCurrencyLabel => 'డిఫాల్ట్ కరెన్సీ';

  @override
  String get defaultUnitLabel => 'డిఫాల్ట్ యూనిట్';

  @override
  String get keepAwakeLabel => 'షాపింగ్ చేస్తున్నప్పుడు స్క్రీన్ ఆన్‌గా ఉంచు';

  @override
  String get backupSection => 'బ్యాకప్';

  @override
  String get exportBackupLabel => 'బ్యాకప్ ఎగుమతి చేయి';

  @override
  String get importBackupLabel => 'బ్యాకప్ దిగుమతి చేయి';

  @override
  String get mergeImportLabel => 'ప్రస్తుత డేటాలో కలపండి';

  @override
  String get separateImportLabel => 'แยกสำเนาเป็นสำเนาใหม่';

  @override
  String get importCancelled => 'దిగుమతి రద్దు చేయబడింది.';

  @override
  String get backupExported => 'బ్యాకప్ విజయవంతంగా ఎగుమతి చేయబడింది.';

  @override
  String get backupSizeWarning =>
      'పెద్ద బ్యాకప్: ఫైల్ పెద్దదిగా ఉండవచ్చు. ఫోటోలను కూడా చేర్చాలా?';

  @override
  String get deleteAllSection => 'అపాయ ప్రాంతం';

  @override
  String get deleteAllLabel => 'అన్ని డేటాను తొలగించండి';

  @override
  String get deleteAllConfirm =>
      'ఇది అన్ని జాబితాలు, చరిత్ర, రసీదు ఫోటోలు మరియు ధరలను తొలగిస్తుంది. మీరు ఎగుమతి చేసిన ఫైల్స్ మీ డ్రైవ్‌లోనే ఉంటాయి. కొనసాగిస్తారా?';

  @override
  String get deleteAllConfirm2 =>
      'మీకు పూర్తిగా ఖచ్చితమైన భరోసా ఉందా? ఈ చర్యను వెనక్కి తీసుకోలేము.';

  @override
  String get cancelAction => 'రద్దు చేయి';

  @override
  String get confirmDelete => 'స్థిరంగా తొలగించండి';

  @override
  String get dataDeleted => 'అన్ని స్థానిక డేటా తొలగించబడింది.';

  @override
  String get privacyInfoLabel => 'గోప్యత';

  @override
  String get privacyInfoBody =>
      'మీ జాబితాలు, ధరలు, రసీదులు మరియు ఫోటోలు మీ పరికరంలోనే ఉంటాయి. ఫోటోలు మరియు వాయిస్ ఎప్పటికీ బయటకు వెళ్లవు. AI సహాయం ఆన్‌లో ఉన్నప్పుడు, కేవలం పాఠ్యం (ఉదాహరణకు రసీదు పంక్తులు లేదా మీరు చెప్పిన విషయాలు) మాత్రమే ప్రాసెసింగ్ కోసం మా సర్వర్‌కు పంపబడుతుంది మరియు నిల్వ చేయబడదు.';

  @override
  String get aboutSection => 'గురించి';

  @override
  String get aboutPublisher => 'ప్రచురణదారు: Crazy Penguin';

  @override
  String get aboutLicenses => 'లైసెన్సులు (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'వాయిస్ ఇన్‌పుట్';

  @override
  String get voiceStatusUnknown => 'సేవ: తనిఖీ చేయబడలేదు';

  @override
  String get permissionsLabel => 'అనుమతులు';

  @override
  String get permissionsBody =>
      'క్యামెరా, మైక్రోఫోన్ మరియు నోటిఫికేషన్లు మీరు ఆ ఫీచర్లను వాడేటప్పుడు మాత్రమే అడిగి పొందబడతాయి.';

  @override
  String get unitsSection => 'డిఫాల్ట్లు';

  @override
  String get roundingNote =>
      'ధనం రౌండింగ్ ఒక నియమాన్ని అనుసరిస్తుంది: సగం విలువలు సున్నా నుండి దూరంగా రౌండ్ అవుతాయి, ధనం మార్పిడి వద్ద ఒకసారి మాత్రమే వర్తింపజేయబడుతుంది.';

  @override
  String get voiceInputTitle => 'వాయిస్ ఇన్‌పుట్';

  @override
  String get voiceStartListening => 'వింటున్నాను';

  @override
  String get voiceTranscriptLabel => 'ట్రాన్స్క్రిప్ట్';

  @override
  String get parseAction => 'పార్స్ చేయి';

  @override
  String get receiptReviewTitle => 'రసీదును సమీక్షించండి';

  @override
  String get receiptTotal => 'రసీదు మొత్తం';

  @override
  String get receiptTotalUnknown => 'మొత్తం గుర్తించబడలేదు';

  @override
  String get receiptDiff => 'వ్యత్యాసం';

  @override
  String get acceptLine => 'ఈ వరుసను అంగీకరించండి';

  @override
  String get ignoreLine => 'ఈ వరుసను విస్మరించండి';

  @override
  String get receiptLineActions =>
      'ఆइटెమ్‌కు లింక్ చేయండి, విభజించండి లేదా విస్మరించండి';

  @override
  String get receiptCommit => 'అన్నీ అంగీకరించండి';

  @override
  String get receiptCommitted => 'రసీదు అన్వయించబడింది.';

  @override
  String get priceHistoryTitle => 'ధర చరిత్ర';

  @override
  String get noObservations => 'ఇంకా ధర పరిశీలనలు లేవు';

  @override
  String get templatesSection => 'టెంప్లేట్‌లు';

  @override
  String get templateHint =>
      'ముந்தరి షాపింగ్ ప్రయాణం నుండి కొత్త ప్రణాళికను సృష్టించండి';

  @override
  String get scanReceiptAction => 'రసీదు స్కాన్ చేయండి';

  @override
  String get shelfLabelAction => 'షెల్ఫ్ లేబుల్ నుండి ధర';

  @override
  String get priceCandidatesTitle => 'ధర అభ్యర్థులు';

  @override
  String get noPriceCandidates =>
      'ధర కనుగొనబడలేదు; దయచేసి మాన్యువల్‌గా నమోదు చేయండి.';

  @override
  String get voiceUnavailable =>
      'వాయిస్ రికగ్నిషన్ అందుబాటులో లేదు; మాన్యువల్‌గా నమోదు చేయండి.';

  @override
  String get linkToItem => 'ఆइटెమ్‌కు లింక్ చేయండి';

  @override
  String get splitLine => 'రెండుగా విభజించండి';

  @override
  String get mergeWithNext => 'తదుపరితో కలపండి';

  @override
  String get ocrNoText => 'ఏదీ చదవబడలేదు; మళ్ళీ ప్రయత్నించండి.';

  @override
  String get priceHistoryAction => 'ధర చరిత్ర';

  @override
  String get itemsEmptyTitle => 'ఇంకా ఆइटెమ్‌లు లేవు';

  @override
  String get itemsEmptyBody =>
      'మీ మొదటి ఆइटెమ్‌ను జోడించండి — దుకాణంలో నిజమైన ధరలను ఇక్కడ నమోదు చేస్తారు.';

  @override
  String get addItemTooltip => 'ఆइटెమ్‌ను జోడించండి';

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
  String get unitCustom => 'కస్టమ్';

  @override
  String get setReminderAction => 'రీమైండర్ సెట్ చేయండి';

  @override
  String get reminderPermissionDenied =>
      'రీమైండర్‌ల కోసం నోటిఫికేషన్ అనుమతి అవసరం. మీరు సిస్టమ్ సెట్టింగ్‌లలో దీన్ని ఎనేబుల్ చేయవచ్చు.';

  @override
  String get reminderScheduled => 'రీమైండర్ సెట్ చేయబడింది.';

  @override
  String get reminderCancelled => 'రీమైండర్ తొలగించబడింది.';

  @override
  String get reminderTitle => 'షాపింగ్ రీమైండర్';

  @override
  String reminderBody(Object title) {
    return 'మీ లిస్ట్‌ను తనిఖీ చేసే సమయం: $title';
  }

  @override
  String get reminderPickDate => 'ఒక తేదీని ఎంచుకోండి';

  @override
  String get reminderPickTime => 'ఒక సమయాన్ని ఎంచుకోండి';

  @override
  String get itemDetailsSection => 'వివరాలు';

  @override
  String get priceOptionalHint =>
      'ఐచ్ఛికం — దుకాణంలో నిజమైన ధరను నమోదు చేస్తారు';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'ప్లాన్ చేయబడినది: $total · $count ఆइटెమ్‌లు';
  }

  @override
  String get proActiveLabel => 'Pro యాక్టివ్ — ధన్యవాదాలు!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'విజ్ఞప్తులు లేవు, మరింత AI, బ్యాకప్ · చిన్న నెలవారీ ధర నుండి';

  @override
  String get proBenefitNoAds => 'విజ్ఞప్తులు లేని అనుభవం';

  @override
  String get proBenefitBackup => 'బ్యాకప్ (ఎగుమతి/దిగుమతి)';

  @override
  String aboutVersion(Object version) {
    return 'వర్షన్ $version';
  }

  @override
  String get navDiscover => 'డిస్కవర్';

  @override
  String get shareAction => 'యాప్‌ను షేర్ చేయండి';

  @override
  String get rateAction => 'మమ్మల్ని రేట్ చేయండి';

  @override
  String get aboutOpenRow => 'గూర్చి & ఓపెన్ సోర్స్';

  @override
  String get voiceAddItemAction => 'వాయిస్ ద్వారా జోడించండి';

  @override
  String get formatLocaleLabel => 'సంఖ్య & కరెన్సి ఫార్మాట్';

  @override
  String get formatLocaleSystem =>
      'డివైస్ ఫార్మాట్ (లాటిన్ అంకెలు; ఇతరత్రా ఇంగ్లీష్)';

  @override
  String get formatLocaleTr => 'తుర్కీ (1.234,56)';

  @override
  String get formatLocaleEn => 'ఇంగ్లీష్ (1,234.56)';

  @override
  String get aiToggleTitle => 'AI సహాయం';

  @override
  String get aiToggleSubtitle =>
      'రసీదులను మ్యాచ్ చేస్తుంది, ధర లేబుల్‌లను చదువుతుంది మరియు వాక్యాలను జాబితాలుగా మారుస్తుంది. ఫోటోలు మరియు వాయిస్ మీ పరికరంలోనే ఉంటాయి; కేవలం టెక్స్ట్ మాత్రమే ప్రాసెస్ అవుతుంది.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'మీరు ఈ నెల AI రిక్వెస్ట్‌లను ($used/$limit) ఉపయోగించారు. మరిన్ని కోసం అప్‌గ్రేడ్ చేయండి లేదా AI లేకుండా కొనసాగండి.';
  }

  @override
  String get aiOffline => 'కనెక్షన్ లేదు — AI లేకుండా కొనసాగుతోంది.';

  @override
  String get aiFailed =>
      'AI ప్రస్తుతం అందుబాటులో లేదు — దాని లేకుండా కొనసాగుతోంది.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'పరికరం';

  @override
  String get quickListAction => 'వాక్యం నుండి జోడించండి';

  @override
  String get quickListTitle => 'త్వరిత జాబితా';

  @override
  String get quickListHint => 'ఉదా: 1 kg ఆపిల్స్ 20, 2 బ్రెడ్‌లు, అర కిలో చీజ్';

  @override
  String get quickListConvert => 'జాబితాగా మార్చండి';

  @override
  String quickListAdd(int count) {
    return '$count వస్తువులను జోడించండి';
  }

  @override
  String get quickListEmpty =>
      'ఏ వస్తువులు కూడా కనుగొనలేదు. వాటిని కామాతో వేరు చేసి ప్రయత్నించండి.';

  @override
  String get receiptAiMatched =>
      'AI రసీదును మీ జాబితాకు మ్యాచ్ చేసింది. లింకులను తనిఖీ చేసి నిర్ధారించండి.';

  @override
  String get receiptNeedsCheck => 'ఈ మ్యాచ్‌ను తనిఖీ చేయండి';

  @override
  String get receiptDiscountLine => 'డైస్కౌంట్';

  @override
  String get compareItem => 'వస్తువు';

  @override
  String get compareEstimated => 'అంచనా';

  @override
  String get compareActual => 'వాస్తవం';

  @override
  String get compareDiff => 'వ్యత్యాసం';

  @override
  String get compareTotal => 'మొత్తం';

  @override
  String get compareBudget => 'బడ్జెట్';

  @override
  String get compareNotBought => 'خریداری نہیں کی گئی';

  @override
  String get compareUnplanned => 'plan చేయబడలేదు';

  @override
  String get pricierItems => 'ఎక్కువ ఖర్చు అవుతుంది';

  @override
  String get cheaperItems => 'తక్కువ ఖర్చు అవుతుంది';

  @override
  String get compareAction => 'పోలిక';

  @override
  String get detailsSection => 'వివరాలు';

  @override
  String get spendingTitle => 'ఖర్చు';

  @override
  String get spendingAction => 'ఖర్చు';

  @override
  String get spendingMonthTotal => 'ఈ నెల';

  @override
  String get spendingWeekly => 'వారంవారీ ఖర్చు';

  @override
  String get spendingMonthly => 'నెలవారీ ఖర్చు';

  @override
  String get monthlyLimitTitle => 'నెలవారీ పరిమితి';

  @override
  String get monthlyLimitHelp =>
      'మీరు నెలకు గ్రోసరీ షాపింగ్‌కి ఎంత ఖర్చు చేయాలనుకుంటున్నారు?';

  @override
  String get monthlyLimitRemove => 'తొలగించండి';

  @override
  String get monthlyLimitSet => 'సెట్ చేయండి';

  @override
  String get monthlyLimitChange => 'మార్చండి';

  @override
  String get monthlyLimitNone =>
      'మీకు ఎంత మిగిలి ఉందో చూడటానికి నెలవారీ పరిమితిని సెట్ చేయండి.';

  @override
  String monthlyLimitOver(String amount) {
    return 'పరిమితి కంటే $amount ఎక్కువ';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return 'ఈ నెల $amount మిగిలి ఉంది';
  }

  @override
  String get plansTitle => 'ప్లాన్‌లు';

  @override
  String get plansHeadline => 'AI తో స్మార్ట్‌గా షాపు చేయండి';

  @override
  String get plansSubhead =>
      'రసీదు మ్యాచింగ్, ధర లేబుల్‌లు మరియు వాక్యం నుండి జాబితాలు. ఏ సమయంలోనైనా రద్దు చేయవచ్చు.';

  @override
  String get plansMonthly => 'నెలవారీ';

  @override
  String get plansYearly => 'సంవత్సరానికి';

  @override
  String get planFree => 'ఉచితం';

  @override
  String get planFreePrice => 'శాశ్వతంగా ఉచితం';

  @override
  String get planFreeAi => 'నెలకు 15 AI రిక్వెస్ట్‌లు';

  @override
  String get planFreeAds =>
      'చిన్న బ్యానర్ విజ్ఞাপనాలు (మీ మొదటి 7 రోజుల్లో ఏవి లేవు)';

  @override
  String get planCoreFeatures => 'జాబితాలు, ధరలు, రసీదులు, ఖర్చు చార్ట్‌లు';

  @override
  String get plansPerYear => '/ సంవత్సరం';

  @override
  String get plansPerMonth => '/ నెల';

  @override
  String get planTrial => '7 రోజులు ఉచితం';

  @override
  String get planProAi => 'నెలకు 200 AI రిక్వెస్ట్‌లు';

  @override
  String get planNoAds => 'విజ్ఞاپనాలు లేవు';

  @override
  String get planBackup => 'బ్యాకప్ ఎగుమతి మరియు దిగుమతి';

  @override
  String get planMaxAi => 'నెలకు 1000 AI అభ్యర్థనలు';

  @override
  String get planMaxFamily => 'పెద్ద కుటుంబ షాపింగ్‌కు';

  @override
  String get plansStoreUnavailable =>
      'అమ్మకాల మండలి ప్రస్తుతం అందుబాటులో లేదు.';

  @override
  String get retryAction => 'పునఃప్రయత్నించండి';

  @override
  String get plansPurchaseFailed =>
      'క్రయ విక్రయాలు పూర్తి కాలేదు. దయచేసి మళ్ళీ ప్రయత్నించండి.';

  @override
  String get planLifetimeTitle => 'జీవితకాలం పాటు అడ్స్ లేకుండా';

  @override
  String get planLifetimeSubtitle =>
      'ఒకసారి చెల్లింపు: అడ్స్ లేవు, బ్యాకప్; AI ఉచిత అనుమతిపైనే ఉంటుంది';

  @override
  String get plansRestore => 'క్రయ విక్రయాలను పునరుద్ధరించండి';

  @override
  String get plansLegal =>
      'సబ్స్క్రిప్షన్లు రద్దు చేయడం వరకు స్వయంచాలకంగా నవీకరించబడతాయి. Google Play › Payments & subscriptions లో ఏ సమయంలోనైనా రద్దు చేయవచ్చు. ధరలు Google Play చూపించే పన్నులతో కూడి ఉంటాయి.';

  @override
  String get planCurrent => 'ప్రస్తుతం';

  @override
  String get planStartTrial => '7-రోజుల ఉచిత ట్రయల్ ప్రారంభించండి';

  @override
  String get planChoose => 'ఎంచుకోండి';

  @override
  String get plansAction => 'ప్లాన్‌లు: Pro మరియు Max';

  @override
  String get assistantTitle => 'సహాయకుడు';

  @override
  String get assistantGreeting => 'హాయ్! మీరు ఏమి చేయాలనుకుంటున్నారు?';

  @override
  String get assistantNewList => 'కొత్త జాబితా';

  @override
  String get assistantVoiceList => 'వాయిస్ ద్వారా జాబితా';

  @override
  String get assistantTextList => 'వాక్యం నుండి జాబితా';

  @override
  String get assistantScanReceipt => 'రసీదును స్కాన్ చేయండి';

  @override
  String get assistantSpending => 'నా ఖర్చులు';

  @override
  String get assistantReceiptHint =>
      'మీ జాబితా తెరవండి మరియు దాన్ని స్కాన్ చేయడానికి రసీదు ఐకాన్‌ను ట్యాప్ చేయండి.';

  @override
  String get assistantToggleTitle => 'సహాయకుడిని చూపించండి';

  @override
  String get assistantToggleSubtitle => 'కుడి కింద ఉన్న చిన్న సహాయకుడు';

  @override
  String get scanPriceLabel => 'ధర లేబుల్ స్కాన్ చేయండి';

  @override
  String get saveFailed =>
      'సేవ్ చేయలేకపోయాము. మీ మార్పులు ఇంకా ఉన్నాయి. దయచేసి మళ్ళీ ప్రయత్నించండి.';

  @override
  String get deleteItemConfirm =>
      'ఈ ఆइटెమ్ మరియు దాని రికార్డ్ చేయబడిన కొనుగోళ్లను తొలగించాలా?';

  @override
  String get clearPurchaseConfirm =>
      'ఈ ఆइटెమ్ నుండి టిక్ తీసి, దాని రికార్డ్ చేయబడిన కొనుగోళ్లను తొలగించాలా?';

  @override
  String get reportPdfAction => 'PDF రిపోర్ట్ సేవ్ చేయి';

  @override
  String get reportNotInvoice =>
      'షాపింగ్ సారాంశం, ట్యాక్స్ ఇన్‌వాయిస్ కాదు. ట్యాక్స్ రేట్లు తెలియవు.';

  @override
  String get purchaseVisits => 'షాపింగ్ సందర్శనలు';

  @override
  String get purchaseInterval => 'కొనుగోళ్ల మధ్య సగటు రోజులు';

  @override
  String get purchasedQuantity => 'కొనుగోలు చేసిన పరిమాణం';

  @override
  String get purchaseAnalyticsHint =>
      'కొనుగోళ్లు వినియోగాన్ని కొలవవు. కరెన్సీలు మరియు యూనిట్లు వేరుగా చూపబడతాయి.';

  @override
  String get receiptReplaces =>
      'లింక్ చేయబడిన రసీదు లైన్లు existing కొనుగోళ్లను భర్తీ చేస్తాయి; లింక్ లేని లైన్లు జోడించబడతాయి.';

  @override
  String get voiceUnsupportedLanguage =>
      'ఈ భాష ఈ డివైజ్‌లో వాయిస్ ఇన్‌పుట్ కోసం అందుబాటులో లేదు. మీరు టైప్ చేయవచ్చు.';
}
