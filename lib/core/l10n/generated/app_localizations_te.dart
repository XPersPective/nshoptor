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
  String get storeLabel => 'దుకాణం';

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
  String get separateImportLabel => 'వేరే ప్రతిగా దిగుమతి చేయండి';

  @override
  String get importCancelled => 'దిగుమతి రద్దు చేయబడింది.';

  @override
  String get backupExported => 'బ్యాకప్ విజయవంతంగా ఎగుమతి చేయబడింది.';

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
      'మీ జాబితాలు, ధరలు, రసీదులు మరియు ఫోటోలు మీ పరికరంలోనే నిల్వ ఉంటాయి. వాయిస్ ఎప్పుడూ పరికరం నుండి బయటకు వెళ్లదు. AI సహాయం ఆన్‌లో ఉన్నప్పుడు, రసీదులు మరియు ధర లేబుళ్ల ఫోటోలు (పరిమాణం తగ్గించినవి) అలాగే చెప్పి రాయించిన వస్తువుల వంటి టెక్స్ట్ చదవడానికి మాత్రమే మా సర్వర్‌కు పంపబడతాయి; వాటిని వెంటనే ప్రాసెస్ చేస్తారు, ఎప్పుడూ నిల్వ చేయరు.';

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
      'కెమెరా, మైక్రోఫోన్, నోటిఫికేషన్‌ల అనుమతులు సంబంధిత ఫీచర్లను ఉపయోగించినప్పుడు మాత్రమే అడుగుతాం.';

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
      'అంశానికి లింక్ చేయండి, విభజించండి లేదా విస్మరించండి';

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
      'గత కొనుగోలు పర్యటనను ఆధారంగా చేసుకుని కొత్త ప్రణాళికను రూపొందించండి.';

  @override
  String get scanReceiptAction => 'రసీదు స్కాన్ చేయండి';

  @override
  String get fromReceiptListButton => 'రసీదు నుండి';

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
  String get linkToItem => 'అంశానికి లింక్ చేయండి';

  @override
  String get splitLine => 'రెండుగా విభజించండి';

  @override
  String get mergeWithNext => 'తదుపరితో కలపండి';

  @override
  String get ocrNoText => 'ఏదీ చదవబడలేదు; మళ్ళీ ప్రయత్నించండి.';

  @override
  String get priceHistoryAction => 'ధర చరిత్ర';

  @override
  String get itemsEmptyTitle => 'ఇంకా అంశాలు లేవు';

  @override
  String get itemsEmptyBody =>
      'మీ మొదటి అంశాన్ని జోడించండి — దుకాణంలో నిజమైన ధరలను ఇక్కడ నమోదు చేస్తారు.';

  @override
  String get addItemTooltip => 'అంశాన్ని జోడించండి';

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
    return 'ప్లాన్ చేయబడినది: $total · $count అంశాలు';
  }

  @override
  String get proActiveLabel => 'Pro యాక్టివ్ — ధన్యవాదాలు!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'ప్రకటనలు లేవు · బ్యాకప్ ఎగుమతి మరియు దిగుమతి · సంవత్సరానికి';

  @override
  String get proBenefitNoAds => 'ప్రకటనలు లేని అనుభవం';

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
      'ఫోటోల నుండి రసీదులు మరియు ధర లేబుళ్లను చదువుతుంది, రసీదులను సరిపోల్చుతుంది, వాక్యాలను జాబితాలుగా మారుస్తుంది. ఫోటోలు చదవడానికి మాత్రమే పంపబడతాయి, ఎప్పుడూ నిల్వ చేయబడవు.';

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
  String get compareNotBought => 'ఇంకా కొనలేదు';

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
  String get planFreeAi => 'నెలకు 10 AI రిక్వెస్ట్‌లు';

  @override
  String get planFreeAds =>
      'చిన్న బ్యానర్ ప్రకటనలు (మొదటి 7 రోజుల్లో కనిపించవు)';

  @override
  String get planCoreFeatures => 'జాబితాలు, ధరలు, రసీదులు, ఖర్చు చార్ట్‌లు';

  @override
  String get plansPerYear => '/ సంవత్సరం';

  @override
  String get plansPerMonth => '/ నెల';

  @override
  String get planTrial => 'ఉచిత ట్రయల్';

  @override
  String get planProAi => 'నెలకు 100 AI రిక్వెస్ట్‌లు';

  @override
  String get planNoAds => 'ప్రకటనలు లేవు';

  @override
  String get planBackup => 'బ్యాకప్ ఎగుమతి మరియు దిగుమతి';

  @override
  String get planMaxAi => 'నెలకు 300 AI అభ్యర్థనలు';

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
  String get plansRestore => 'క్రయ విక్రయాలను పునరుద్ధరించండి';

  @override
  String get plansLegal =>
      'రద్దు చేసే వరకు Pro ప్రతి సంవత్సరం స్వయంచాలకంగా పునరుద్ధరించబడుతుంది, ప్రతి నెలా 100 AI అభ్యర్థనలు ఉంటాయి. వర్తించే పన్నులకు ముందు ప్రాథమిక ధర సంవత్సరానికి 1 అమెరికన్ డాలర్; కొనుగోలును నిర్ధారించే ముందు స్టోర్‌లో తుది స్థానిక ధర మరియు పన్నులను తనిఖీ చేయండి. Google Playలో సభ్యత్వాన్ని నిర్వహించండి లేదా రద్దు చేయండి.';

  @override
  String get planCurrent => 'ప్రస్తుతం';

  @override
  String get planStartTrial => 'ఉచిత ట్రయల్ ప్రారంభించు';

  @override
  String get planChoose => 'ఎంచుకోండి';

  @override
  String get plansAction => 'ప్లాన్‌లు: Pro';

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
      'ఈ అంశం మరియు దాని రికార్డ్ చేయబడిన కొనుగోళ్లను తొలగించాలా?';

  @override
  String get clearPurchaseConfirm =>
      'ఈ అంశం నుండి టిక్ తీసి, దాని రికార్డ్ చేయబడిన కొనుగోళ్లను తొలగించాలా?';

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
      'ధర లేని వస్తువుల ధరలు పూరించబడతాయి. మార్కెట్ ధర ఉన్నవి వేర్వేరు కొనుగోళ్లుగా జోడించబడతాయి.';

  @override
  String get receiptIncompleteHeader =>
      'తర్వాతి ఫోటోలో దుకాణం, తేదీ, సమయం, రసీదు నంబర్ ఉండేలా చూడండి.';

  @override
  String get receiptIncompleteTail =>
      'కొన్ని వస్తువులు ఒకదానిపై మరొకటి కనిపించేలా, చివరి మొత్తం కనిపించేలా తర్వాతి భాగాన్ని ఫోటో తీయండి.';

  @override
  String get receiptContinuationRejected =>
      'ఈ ఫోటోను కలపలేకపోయాం. అదే రసీదులోని వస్తువులు ఒకదానిపై మరొకటి కనిపించేలా మళ్లీ తీయండి.';

  @override
  String get receiptDraftSaved =>
      'రసీదు డ్రాఫ్ట్‌గా సేవ్ చేయబడింది. తర్వాత కొనసాగించవచ్చు.';

  @override
  String get receiptContinueAction => 'రసీదును కొనసాగించండి';

  @override
  String get receiptDraftsTitle => 'పూర్తికాని రసీదులు';

  @override
  String get receiptDuplicate => 'ఈ రసీదు ఇప్పటికే జోడించబడింది.';

  @override
  String get receiptTotalMismatch =>
      'వస్తువుల మొత్తం రసీదు మొత్తం మొత్తానికి సరిపోలడం లేదు. రసీదు మొత్తం కనిపిస్తోందో లేదో చూడండి.';

  @override
  String get receiptSaveDraftAction => 'తర్వాత కోసం సేవ్ చేయండి';

  @override
  String get receiptResolveLines =>
      'సేవ్ చేయడానికి ముందు ప్రతి వస్తువును అంగీకరించండి లేదా విస్మరించండి.';

  @override
  String get receiptPartialConfirm =>
      'ఎంచుకున్న వస్తువులు మాత్రమే జోడించబడతాయి. ఈ రసీదు దిగుమతి చేసినదిగా గుర్తించబడుతుంది. కొనసాగించాలా?';

  @override
  String get voiceUnsupportedLanguage =>
      'ఈ భాష ఈ డివైజ్‌లో వాయిస్ ఇన్‌పుట్ కోసం అందుబాటులో లేదు. మీరు టైప్ చేయవచ్చు.';

  @override
  String get voiceStopListening => 'వింటున్నాను ఆపండి';

  @override
  String get keepAwakeFailed =>
      'స్క్రీన్ ని మేల్కొని ఉంచలేకపోయింది. దయచేసి మళ్ళీ ప్రయత్నించండి.';

  @override
  String get purchaseHistoryHint =>
      'పూర్తయిన అన్ని షాపింగ్‌లు. తిరిగి ఇచ్చినవి మొత్తాలను తగ్గిస్తాయి. తేదీలు షాపింగ్ పూర్తయిన సమయాన్ని సూచిస్తాయి. ఒక సందర్శన సగటు అంతరాన్ని లెక్కించడానికి సరిపోదు.';

  @override
  String get planLegacyRights =>
      'ప్రస్తుత ప్రో మరియు మాక్స్ సబ్‌స్క్రిప్షన్లు వాటి అసలు నెలవారీ AI అనుమతిని కొనసాగిస్తాయి.';

  @override
  String get csvExportAction => 'CSV ఎగుమతి';

  @override
  String get reportSharePdf => 'PDFగా షేర్ చేయి';

  @override
  String get reportShareCsv => 'CSVగా షేర్ చేయి';

  @override
  String get reportPrintAction => 'ప్రింట్ చేయి';

  @override
  String get backupSizeWarning =>
      'JSONలో రికార్డ్స్ ఉంటాయి, ఫోటో ఫైల్స్ కాదు. ఇంపోర్ట్ పరిమితి: 16 MB.';

  @override
  String get backupImportFailed =>
      'ఈ బ్యాకప్‌ను ఇంపోర్ట్ చేయలేము. మీ డేటా మార్చబడలేదు.';

  @override
  String get backupImported => 'బ్యాకప్ విజయవంతంగా దిగుమతి చేయబడింది.';

  @override
  String backupPreviewCounts(Object entries, Object items, Object lists) {
    return '$lists జాబితాలు · $items వస్తువులు · $entries కొనుగోళ్లు';
  }

  @override
  String get voiceModelDownloading =>
      'ఈ భాష కోసం వాయిస్ మోడల్ డౌన్‌లోడ్ అవుతోంది. ఒక నిమిషం తర్వాత మళ్లీ ప్రయత్నించండి.';

  @override
  String get historyThisWeek => 'ఈ వారం';

  @override
  String get historyProductsSection => 'కొనుగోలు చేసిన ఉత్పత్తులు';

  @override
  String get tipReceiptScan =>
      'రసీదును స్కాన్ చేసి ధరలను మీ జాబితాతో సరిపోల్చండి';

  @override
  String get tipVoiceAdd =>
      'ఒకటి లేదా అంతకంటే ఎక్కువ వస్తువులు చెప్పి, జోడించే ముందు సరిచూడండి';

  @override
  String get tipShelfCamera => 'కెమెరాతో షెల్ఫ్ లేబుల్‌పై ధరను చదవండి';

  @override
  String get tipPlan =>
      'మీ ప్లాన్: వివరాలు చూడండి, సభ్యత్వం తీసుకోండి లేదా అప్‌గ్రేడ్ చేయండి';

  @override
  String get guideAddBody =>
      'వస్తువు జోడించడానికి + నొక్కండి. ప్రణాళిక ధరను ఇప్పుడు, మార్కెట్ ధరను చెక్‌అవుట్ వద్ద నమోదు చేయండి.';

  @override
  String get guideVoiceBody =>
      'మైక్రోఫోన్ నొక్కి వస్తువులు చెప్పండి, ఉదాహరణకు: \'1 కిలో ఆపిళ్లు, 1 బ్రెడ్\'.';

  @override
  String get guideReceiptBody =>
      'రసీదును స్కాన్ చేసి దాని ధరలను మీ జాబితాలోని వస్తువులతో సరిపోల్చండి.';

  @override
  String get guidePlanBody =>
      'ప్లాన్ చూడటానికి, సభ్యత్వం తీసుకోవడానికి లేదా అప్‌గ్రేడ్ చేయడానికి ప్లాన్ ఐకాన్ నొక్కండి.';

  @override
  String get guideNext => 'సరే';

  @override
  String get guideDone => 'ప్రారంభించు';

  @override
  String get paletteLabel => 'రంగు థీమ్';

  @override
  String get paletteForest => 'అడవి';

  @override
  String get paletteOcean => 'సముద్రం';

  @override
  String get paletteSunset => 'సూర్యాస్తమయం';

  @override
  String get paletteLavender => 'లావెండర్';

  @override
  String get darkBlackLabel => 'డార్క్ థీమ్‌లో పూర్తి నలుపు';

  @override
  String get spendingOverview => 'అవలోకనం';

  @override
  String get spendingThisYear => 'ఈ సంవత్సరం';

  @override
  String get spendingYearly => 'వార్షిక ఖర్చు';

  @override
  String get productSpending => 'వస్తువుల వారీ ఖర్చు';

  @override
  String get spanWeek => 'వారం';

  @override
  String get spanMonth => 'నెల';

  @override
  String get spanYear => 'సంవత్సరం';

  @override
  String get weeklyLimitTitle => 'వారపు పరిమితి';

  @override
  String get weeklyLimitHelp =>
      'వారానికి షాపింగ్‌పై ఎంత ఖర్చు చేయాలనుకుంటున్నారు?';

  @override
  String get weeklyLimitNone =>
      'ఎంత మిగిలిందో చూడటానికి వారపు పరిమితిని సెట్ చేయండి.';

  @override
  String weeklyLimitLeft(String amount) {
    return 'ఈ వారం $amount మిగిలింది';
  }

  @override
  String get shoppingLimitTitle => 'ప్రతి షాపింగ్‌కు పరిమితి';

  @override
  String get shoppingLimitHelp => 'కొత్త జాబితాలు ఈ బడ్జెట్‌తో మొదలవుతాయి.';

  @override
  String get shoppingLimitNone =>
      'ప్రతి కొత్త షాపింగ్‌కు డిఫాల్ట్ బడ్జెట్ సెట్ చేయండి.';

  @override
  String get monthlyReportAction => 'నెలవారీ నివేదిక';

  @override
  String get reportShoppingColumn => 'షాపింగ్';

  @override
  String get reportDateColumn => 'తేదీ';

  @override
  String get planUnavailable => 'ప్రస్తుతం స్టోర్‌లో అందుబాటులో లేదు';

  @override
  String get demoDataTitle => 'నమూనా డేటా';

  @override
  String get demoDataLoad => 'నమూనా డేటాతో ప్రయత్నించండి';

  @override
  String get demoDataLoadHelp =>
      'చరిత్ర, చార్ట్‌లు, ధర చరిత్ర చూడటానికి 12 నెలల నమూనా షాపింగ్‌ను జోడిస్తుంది.';

  @override
  String get demoDataRemove => 'నమూనా డేటాను తొలగించు';

  @override
  String get demoDataAdded => 'నమూనా డేటా జోడించబడింది';

  @override
  String get demoDataRemoved => 'నమూనా డేటా తొలగించబడింది';

  @override
  String get demoProductApple => 'ఆపిల్';

  @override
  String get demoProductBread => 'బ్రెడ్';

  @override
  String get demoProductMilk => 'పాలు';

  @override
  String get demoProductCheese => 'చీజ్';

  @override
  String get demoProductTomato => 'టమాటాలు';

  @override
  String get demoProductEggs => 'గుడ్లు';

  @override
  String get demoProductCoffee => 'కాఫీ';

  @override
  String get demoProductDetergent => 'డిటర్జెంట్';

  @override
  String get sendAction => 'Send';

  @override
  String get previousMonthAction => 'Previous month';

  @override
  String get nextMonthAction => 'Next month';

  @override
  String get helpSection => 'సహాయం మరియు మద్దతు';

  @override
  String get howToUseLabel => 'ఎలా ఉపయోగించాలి';

  @override
  String get guidePricesBody =>
      'దుకాణ ధర నమోదు చేస్తే వస్తువును కొనుగోలు చేసినట్లు గుర్తిస్తుంది; 0 కూడా చెల్లుతుంది. ఇంటి ధర ఐచ్ఛికం. గుర్తు తొలగించడానికి దుకాణ ధరను చెరిపివేయండి.';

  @override
  String get shoppingDateLabel => 'షాపింగ్ తేదీ';

  @override
  String get shoppingDateNone => 'తేదీ ఎంచుకోలేదు';

  @override
  String get clearShoppingDateAction => 'తేదీ తొలగించు';

  @override
  String get listSortLabel => 'జాబితా క్రమం';

  @override
  String get listSortDate => 'షాపింగ్ తేదీ';

  @override
  String get listSortAz => 'పేరు (అ–హ)';

  @override
  String get listSortManual => 'మాన్యువల్ క్రమం';

  @override
  String get imageCameraAction => 'ఫోటో తీయండి';

  @override
  String get imageGalleryAction => 'ఫోటోల నుండి ఎంచుకోండి';

  @override
  String get imageCaptureFailed =>
      'కెమెరా లేదా ఫోటోలను తెరవలేకపోయాము. యాక్సెస్ అనుమతిని తనిఖీ చేసి మళ్లీ ప్రయత్నించండి.';

  @override
  String get imageRecognitionFailed =>
      'ఫోటోను ప్రాసెస్ చేయలేకపోయాము. మరో ఫోటోతో ప్రయత్నించండి.';

  @override
  String get receiptNoProducts =>
      'వచనం చదవబడింది, కానీ రసీదులోని వస్తువులు కనుగొనబడలేదు. ఫోటోలో వస్తువులు మరియు మొత్తం ఉండేలా చూడండి.';

  @override
  String get keepAwakeOn => 'స్క్రీన్ ఆన్‌లో ఉంటుంది';

  @override
  String get keepAwakeOff => 'స్క్రీన్ ఆఫ్ కావచ్చు';

  @override
  String get spanDay => 'రోజు';

  @override
  String get spanCustom => 'తేదీ పరిధి';

  @override
  String get reportTotalSpent => 'మొత్తం ఖర్చు';

  @override
  String get reportAddedAt => 'జోడించిన తేదీ';

  @override
  String get reportReceiptNumber => 'రసీదు నంబర్';

  @override
  String get reportPreview => 'ప్రివ్యూ';

  @override
  String get reportShareAction => 'షేర్ చేయండి';

  @override
  String get previousPeriodAction => 'మునుపటి కాలం';

  @override
  String get nextPeriodAction => 'తదుపరి కాలం';

  @override
  String get reportSaved => 'నివేదిక సేవ్ చేయబడింది.';

  @override
  String get reportZoom => 'జూమ్';

  @override
  String planTrialDaysLeft(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days రోజులు మిగిలాయి',
      one: '$days రోజు మిగిలింది',
    );
    return '$_temp0';
  }

  @override
  String planTrialHoursLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours గంటలు మిగిలాయి',
      one: '$hours గంట మిగిలింది',
    );
    return '$_temp0';
  }

  @override
  String get planTrialEndedTitle => 'మీ Pro ట్రయల్ ముగిసింది';

  @override
  String get planTrialEndedBody =>
      'మీరు జాబితాలు, మాన్యువల్ ఎంట్రీ, పరికరంలోని వాయిస్‌ను ఉచితంగా కొనసాగించవచ్చు. Freeలో ప్రతి క్యాలెండర్ నెలకు 10 AI అభ్యర్థనలు ఉంటాయి. నెలకు 100 AI అభ్యర్థనలు, ప్రకటనలు లేని వినియోగం, బ్యాకప్‌ల కోసం వార్షిక Pro ఎంచుకోండి. మీ ప్రస్తుత డేటా మీ వద్దే ఉంటుంది.';

  @override
  String get planContinueFree => 'Freeతో కొనసాగండి';

  @override
  String get supportIdLabel => 'మద్దతు ID';

  @override
  String get supportEmailLabel => 'ఇమెయిల్ మద్దతు';

  @override
  String get captureTipFirst =>
      'పైభాగం నుండి మొదలుపెట్టండి: దుకాణం పేరు, తేదీ కనిపించాలి. వీలైనన్ని వస్తువులను చేర్చండి; మిగతావి తర్వాతి ఫోటోలో ఉంటాయి.';

  @override
  String get captureTipContinue =>
      'అదే రసీదు: ముందు ఫోటోలోని చివరి వస్తువును చేర్చండి.';

  @override
  String get captureTipNeverShow => 'మళ్లీ చూపవద్దు';

  @override
  String get captureTipOk => 'అర్థమైంది';

  @override
  String get captureTipsSetting => 'రసీదు తీసే చిట్కాలను చూపించు';

  @override
  String get receiptReadingProgress => 'Reading the receipt…';

  @override
  String get receiptReadInBackground => 'Continue in background';

  @override
  String get receiptReadDoneTitle => 'Receipt read';

  @override
  String get receiptReadDoneBody => 'Tap to review and save it.';

  @override
  String get receiptReadMoreTitle => 'Photograph the rest of the receipt';

  @override
  String get receiptReadFailedTitle => 'The receipt could not be read';
}
