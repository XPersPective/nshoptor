// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Albanian (`sq`).
class AppLocalizationsSq extends AppLocalizations {
  AppLocalizationsSq([String locale = 'sq']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan =>
      'Planifikoni në shtëpi. Bëni blerjet siç keni planifikuar.';

  @override
  String get listsTitle => 'Listat';

  @override
  String get listsTabActive => 'Aktive';

  @override
  String get listsTabCompleted => 'Të përfunduara';

  @override
  String get listsTabArchived => 'Të arkivuara';

  @override
  String get newListButton => 'Listë e re';

  @override
  String get listTitleHint => 'Titulli (opsional)';

  @override
  String get saveButton => 'Ruaj';

  @override
  String get cancelButton => 'Anulo';

  @override
  String get deleteButton => 'Fshij';

  @override
  String get editAction => 'Redakto';

  @override
  String get listDeleted => 'Lista u fshi';

  @override
  String get invalidAmountError => 'Sasi e pavlefshme';

  @override
  String get duplicateAction => 'Kopjo';

  @override
  String get archiveAction => 'Arkivo';

  @override
  String get unarchiveAction => 'Sharkivo';

  @override
  String get deleteListConfirm =>
      'Dëshironi të fshini këtë listë? Artikujt e planifikuar do të hiqen gjithashtu.';

  @override
  String get undoButton => 'Zhbëj';

  @override
  String get searchListHint => 'Kërko lista';

  @override
  String get currencyLabel => 'Monedha';

  @override
  String get budgetLabel => 'Buxheti (opsional)';

  @override
  String get noteLabel => 'Shënim (opsional)';

  @override
  String get storeLabel => ' dyqani';

  @override
  String get keepAmountsAction => 'Mbaj sasi';

  @override
  String get resetAmountsAction => 'Rivendos sasi';

  @override
  String get currencyChangeWarning =>
      'Monedha po ndryshon. Çfarë duhet t\'ju ndodhë sasive ekzistuese?';

  @override
  String get listsEmpty =>
      'Ende nuk ka lista. Krijoni planin tuaj të parë të blerjeve.';

  @override
  String get statusDraft => 'Koncept';

  @override
  String get statusPlanned => 'I planifikuar';

  @override
  String get statusShopping => 'Në blerje';

  @override
  String get statusCompleted => 'I përfunduar';

  @override
  String get statusArchived => 'I arkivuar';

  @override
  String autoListTitle(String date) {
    return 'blerje $date';
  }

  @override
  String get itemFormTitle => 'Shto artikull';

  @override
  String get itemNameLabel => 'Emri i artikullit';

  @override
  String get brandLabel => 'Marka / varianti (opsional)';

  @override
  String get categoryLabel => 'Kategoria';

  @override
  String get quantityLabel => 'Sasia';

  @override
  String get unitLabel => 'Njësia';

  @override
  String get pricingModeLabel => 'Modaliteti i çmimit';

  @override
  String get pricingModeUnitPrice => 'Çmimi njësi';

  @override
  String get pricingModeLineTotal => 'Totali i rreshtit';

  @override
  String get plannedPriceLabel => 'Çmimi i planifikuar';

  @override
  String lineTotalCalculated(String value) {
    return 'Totali i rreshtit: $value';
  }

  @override
  String get requiredItemToggle => 'Artikull i detyrueshëm';

  @override
  String get maxPriceLabel => 'Çmimi maksimal i pranueshëm (opsional)';

  @override
  String get itemNoteLabel => 'Shënim (opsional)';

  @override
  String get categoryProduce => 'Fruta & perime';

  @override
  String get categoryDairy => 'Produkte qumështi';

  @override
  String get categoryMeat => 'Mish';

  @override
  String get categoryBakery => 'Bukë';

  @override
  String get categoryDrinks => 'Pije';

  @override
  String get categoryCleaning => 'Pastrim';

  @override
  String get categoryPersonalCare => 'Kujdes personal';

  @override
  String get categoryHome => 'Shtëpi';

  @override
  String get categoryOther => 'Të tjera';

  @override
  String get invalidQuantityError => 'Sasi e pavlefshme';

  @override
  String get invalidPriceError => 'Çmim i pavlefshëm';

  @override
  String get invalidNameError => 'Jepni një emër';

  @override
  String unitPriceCalculated(String value) {
    return 'Çmimi njësi: $value';
  }

  @override
  String get shoppingTitle => 'Modaliteti i blerjes';

  @override
  String get summaryPlannedTotal => 'I planifikuar';

  @override
  String get summaryInCart => 'Në shportë';

  @override
  String get summaryRemainingPlan => 'Plan i mbetur';

  @override
  String get summaryProjected => 'Shpenzimi i parashikuar';

  @override
  String get summaryBudgetRemaining => 'Buxheti i mbetur';

  @override
  String get summaryBudgetOver => 'Mbi buxhet';

  @override
  String itemsProgress(String done, String total) {
    return '$done nga $total artikuj';
  }

  @override
  String get filterAll => 'Të gjitha';

  @override
  String get filterToBuy => 'Për t\'u blerë';

  @override
  String get filterInCart => 'Në shportë';

  @override
  String get filterNotFound => 'Nuk u gjet';

  @override
  String get filterRequired => 'I detyrueshëm';

  @override
  String get quickEntryTitle => 'Çmimi aktual';

  @override
  String get actualQuantityLabel => 'Sasia aktuale';

  @override
  String get actualPriceLabel => 'Çmimi aktual';

  @override
  String get discountLabel => 'Zbritje (opsionale)';

  @override
  String get alternativeNameLabel => 'Emri i produktit alternativ (opsional)';

  @override
  String get savePurchaseButton => 'Shto në shportë';

  @override
  String get unplannedAddButton => 'Shto artikull të paplanifikuar';

  @override
  String get statusPending => 'Nuk është marrë';

  @override
  String get statusInCart => 'Në shportë';

  @override
  String get statusNotFound => 'Nuk u gjet';

  @override
  String get statusGaveUp => 'U heq dorë';

  @override
  String get statusAlternative => 'U ble alternativë';

  @override
  String get keepScreenAwake => 'Mbaj ekranin aktiv';

  @override
  String get finishShopping => 'Përfundo blerjen';

  @override
  String get completionWarning =>
      'Ka regjistrime të humbura ose të paverifikuara. Mund ta përfundoni; rezultati do t\'i shënojë ato.';

  @override
  String get continueShoppingButton => 'Vazhdo blerjen';

  @override
  String get resultTitle => 'Rezultati';

  @override
  String get summarySection => 'Përmbledhje';

  @override
  String get plannedTotalLabel => 'Totali i planifikuar';

  @override
  String get actualTotalLabel => 'Totali aktual';

  @override
  String get varianceLabel => 'Dallimi';

  @override
  String get varianceNotComputable => 'Nuk mund të llogaritet';

  @override
  String get budgetStatusLabel => 'Buxheti';

  @override
  String get savingsLabel => 'Nën plan';

  @override
  String get overspendLabel => 'Mbi plan';

  @override
  String get unplannedTotalLabel => 'Totali i paplanifikuar';

  @override
  String get unpurchasedLabel => 'I planifikuar, por jo i blerë';

  @override
  String get totalDiscountLabel => 'Zbritjet totale';

  @override
  String get accuracyLabel => 'Saktësia e vlerësimit';

  @override
  String get groupsSection => 'Artikujt';

  @override
  String get groupPricier => 'Më i shtrenjtë se sa u planifikua';

  @override
  String get groupCheaper => 'Më i lirë se sa u planifikua';

  @override
  String get groupClose => 'Afër vlerësimit';

  @override
  String get groupNotTaken => 'I planifikuar, nuk u ble';

  @override
  String get groupUnplanned => 'U ble pa qenë i planifikuar';

  @override
  String get groupQuantityChanged => 'Sasia ndryshoi';

  @override
  String get groupUnverified => 'I paverifikuar';

  @override
  String get plannedQtyLabel => 'Sasia e planifikuar';

  @override
  String get actualQtyLabel => 'Sasia aktuale';

  @override
  String get plannedUnitPriceLabel => 'Çmimi njësi i planifikuar';

  @override
  String get actualUnitPriceLabel => 'Çmimi njësi aktual';

  @override
  String get lineVarianceLabel => 'Dallimi i linjës';

  @override
  String get discountEffectLabel => 'Efekti i zbritjes';

  @override
  String get notBoughtMark => 'nuk u ble';

  @override
  String get noPurchasesNote => 'Nuk u regjistruan blerje.';

  @override
  String get navHome => 'Kryefaqja';

  @override
  String get navLists => 'Listat';

  @override
  String get navHistory => 'Historia';

  @override
  String get navSettings => 'Cilësimet';

  @override
  String get homeEmptyTitle => 'Planifikoni blerjet tuaja';

  @override
  String get homeEmptyBody =>
      'Krijoni listën tuaj të parë dhe krahasoni kostot e planifikuara me ato reale.';

  @override
  String get homeActiveSection => 'Listat aktive';

  @override
  String get homeCompletedSection => 'Përfunduar së fundmi';

  @override
  String get homeMonthlySection => 'Ky muaj';

  @override
  String get monthPlannedLabel => 'E planifikuar';

  @override
  String get monthActualLabel => 'E vërtetë';

  @override
  String get monthVarianceLabel => 'Dallimi';

  @override
  String get continueShoppingLabel => 'Vazhdo blerjen';

  @override
  String get historyEmpty =>
      'Nuk ka ende blerje të përfunduara. Historia dhe analizat tuaja do të shfaqen këtu.';

  @override
  String get aboutTabTitle => 'Rreth NShoptor';

  @override
  String get aboutBody =>
      'NShoptor nga Crazy Penguin. Planifikues blerjesh offline. I licencuar sipas GPL-3.0.';

  @override
  String get startShoppingLabel => 'Fillo blerjen';

  @override
  String get finishAndSeeResult => 'Përfundo & shiko rezultatin';

  @override
  String get settingsTitle => 'Cilësimet';

  @override
  String get languageLabel => 'Gjuha';

  @override
  String get languageSystem => 'Sistemi';

  @override
  String get languageTr => 'Turqisht';

  @override
  String get languageEn => 'Anglisht';

  @override
  String get themeLabel => 'Tema';

  @override
  String get themeSystem => 'Sistemi';

  @override
  String get themeLight => 'Dritë';

  @override
  String get themeDark => 'Errët';

  @override
  String get defaultCurrencyLabel => 'Monedha bazë';

  @override
  String get defaultUnitLabel => 'Njësia bazë';

  @override
  String get keepAwakeLabel => 'Mbaje ekranin aktiv gjatë blerjes';

  @override
  String get backupSection => 'Backup';

  @override
  String get exportBackupLabel => 'Eksporto backup';

  @override
  String get importBackupLabel => 'Importo backup';

  @override
  String get mergeImportLabel => 'Mbledhe në të dhënat aktuale';

  @override
  String get separateImportLabel => 'Importo si kopje të veçantë';

  @override
  String get importCancelled => 'Importi u anulua.';

  @override
  String get backupExported => 'Backup u eksportua me sukses.';

  @override
  String get deleteAllSection => 'Zona e rrezikshme';

  @override
  String get deleteAllLabel => 'Fshi të gjitha të dhënat';

  @override
  String get deleteAllConfirm =>
      'Kjo do të heqë të gjitha listat, historinë, fotografitë e faturave dhe çmimet. Skedarët e eksportuar nga ju mbeten në diskun tuaj. Vazhdon?';

  @override
  String get deleteAllConfirm2 =>
      'A jeni plotësisht i sigurt? Ky veprim nuk mund të zhbëhet.';

  @override
  String get cancelAction => 'Anulo';

  @override
  String get confirmDelete => 'Fshi përgjithmonë';

  @override
  String get dataDeleted => 'Të gjitha të dhënat lokale u fshinë.';

  @override
  String get privacyInfoLabel => 'Privatësia';

  @override
  String get privacyInfoBody =>
      'Listat, çmimet, faturat dhe fotografitë tuaja ruhen në pajisjen tuaj. Zëri nuk e braktis asnjëherë. Kur ndihma AI është e aktivizuar, fotografitë e faturave dhe të etiketave të çmimeve (të zvogëluara) dhe teksti, si artikujt e diktuar, dërgohen te serveri ynë vetëm për t\'u lexuar; përpunohen menjëherë dhe nuk ruhen kurrë.';

  @override
  String get aboutSection => 'Rreth';

  @override
  String get aboutPublisher => 'Botuesi: Crazy Penguin';

  @override
  String get aboutLicenses => 'Licencat (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Hyrja zanore';

  @override
  String get voiceStatusUnknown => 'Shërbimi: nuk është kontrolluar';

  @override
  String get permissionsLabel => 'Lejet';

  @override
  String get permissionsBody =>
      'Kamera, mikrofoni dhe njoftimet kërkohen vetëm kur përdorni këto funksione.';

  @override
  String get unitsSection => 'Bazat';

  @override
  String get roundingNote =>
      'Rrumbullakimi i parave ndjek një rregull: gjysmat rrumbullakosen larg nga zero, aplikohet një herë tek konvertimi i Parave.';

  @override
  String get voiceInputTitle => 'Hyrja zanore';

  @override
  String get voiceStartListening => 'Fillo dëgjimin';

  @override
  String get voiceTranscriptLabel => 'Transkriptimi';

  @override
  String get parseAction => 'Analizo';

  @override
  String get receiptReviewTitle => 'Rishikim fature';

  @override
  String get receiptTotal => 'Shuma e faturës';

  @override
  String get receiptTotalUnknown => 'Shuma nuk u zbulua';

  @override
  String get receiptDiff => 'Dallimi';

  @override
  String get acceptLine => 'Prano rreshtin';

  @override
  String get ignoreLine => 'Injoro rreshtin';

  @override
  String get receiptLineActions => 'Lidh me artikull, ndaj ose injoro';

  @override
  String get receiptCommit => 'Prano të gjitha';

  @override
  String get receiptCommitted => 'Fatura u aplikua.';

  @override
  String get priceHistoryTitle => 'Historiku i çmimeve';

  @override
  String get noObservations => 'Nuk ka ende vëzhgime çmimesh';

  @override
  String get templatesSection => 'Templatat';

  @override
  String get templateHint =>
      'Krijo një plan të ri nga një udhëtim i mëparshëm blerjesh';

  @override
  String get scanReceiptAction => 'Skano faturën';

  @override
  String get fromReceiptListButton => 'Nga kuponi';

  @override
  String get shelfLabelAction => 'Çmimi nga etiketa në raft';

  @override
  String get priceCandidatesTitle => 'Kandidatët për çmim';

  @override
  String get noPriceCandidates => 'Nuk u gjet çmim; futeni manualisht.';

  @override
  String get voiceUnavailable =>
      'Rikohja zanore është e padisponueshme; futeni manualisht.';

  @override
  String get linkToItem => 'Lidh me artikullin';

  @override
  String get splitLine => 'Ndaje në dy';

  @override
  String get mergeWithNext => 'Mbledhe me tjetrin';

  @override
  String get ocrNoText => 'Nuk u lexua tekst; provo përsëri.';

  @override
  String get priceHistoryAction => 'Historiku i çmimeve';

  @override
  String get itemsEmptyTitle => 'Ende nuk ka artikuj';

  @override
  String get itemsEmptyBody =>
      'Shto artikulin tënd të parë — këtu do të fusësh çmimet reale te dyqani.';

  @override
  String get addItemTooltip => 'Shto artikull';

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
  String get unitCustom => 'Të personalizuar';

  @override
  String get setReminderAction => 'Cakto kujtesë';

  @override
  String get reminderPermissionDenied =>
      'Është e nevojshme leja për njoftimet për kujtesat. Mund ta aktivizosh te cilësimet e sistemit.';

  @override
  String get reminderScheduled => 'Kujtesa u caktua.';

  @override
  String get reminderCancelled => 'Kujtesa u hoq.';

  @override
  String get reminderTitle => 'Kujtesë për blerje';

  @override
  String reminderBody(Object title) {
    return 'Koha të kontrollosh listën: $title';
  }

  @override
  String get reminderPickDate => 'Zgjidh një datë';

  @override
  String get reminderPickTime => 'Zgjidh një orë';

  @override
  String get itemDetailsSection => 'Detajet';

  @override
  String get priceOptionalHint =>
      'Opsionale — çmimin real do ta fusësh te dyqani';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'I planifikuar: $total · $count artikuj';
  }

  @override
  String get proActiveLabel => 'Pro aktiv — faleminderit!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Pa reklama · Eksportim dhe importim backup-i · Vjetore';

  @override
  String get proBenefitNoAds => 'Përvojë pa reklama';

  @override
  String get proBenefitBackup => 'Backup (eksport/impor)';

  @override
  String aboutVersion(Object version) {
    return 'Versioni $version';
  }

  @override
  String get navDiscover => 'Zbulo';

  @override
  String get shareAction => 'Ndaje aplikacionin';

  @override
  String get rateAction => 'Vlerësoje';

  @override
  String get aboutOpenRow => 'Rreth & open source';

  @override
  String get voiceAddItemAction => 'Shto me zë';

  @override
  String get formatLocaleLabel => 'Formati i numrave dhe valutës';

  @override
  String get formatLocaleSystem =>
      'Formati i pajisjes (shifra Latine; përndryshe Anglisht';

  @override
  String get formatLocaleTr => 'Turqisht (1.234,56)';

  @override
  String get formatLocaleEn => 'Anglisht (1,234.56)';

  @override
  String get aiToggleTitle => 'Ndihmë AI';

  @override
  String get aiToggleSubtitle =>
      'Lexon faturat dhe etiketat e çmimeve nga fotografitë, përputh faturat dhe i kthen fjalitë në lista. Fotografitë dërgohen vetëm për t\'u lexuar dhe nuk ruhen kurrë.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Ke përdorur kërkesat mujore të AI ($used/$limit). Përmirëso për më shumë, ose vazhdo pa AI.';
  }

  @override
  String get aiOffline => 'Pa lidhje — po vazhdohet pa AI.';

  @override
  String get aiFailed =>
      'AI nuk është e disponueshme tani — po vazhdohet pa të.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'Pajisja';

  @override
  String get quickListAction => 'Shto nga një fjali';

  @override
  String get quickListTitle => 'Lista e shpejtë';

  @override
  String get quickListHint => 'p.sh. 1 kg mollë 20, 2 bukë, gjysmë kilo djathë';

  @override
  String get quickListConvert => 'Ktheje në listë';

  @override
  String quickListAdd(int count) {
    return 'Shto $count artikuj';
  }

  @override
  String get quickListEmpty =>
      'Nuk u gjetën artikuj. Provo t\'i renditësh të ndarë me presje.';

  @override
  String get receiptAiMatched =>
      'AI e përputhi faturën me listën tënde. Kontrollo lidhjet dhe konfirmo.';

  @override
  String get receiptNeedsCheck => 'Kontrollo këtë përputhje';

  @override
  String get receiptDiscountLine => 'Zbritje';

  @override
  String get compareItem => 'Artikulli';

  @override
  String get compareEstimated => 'Vlerësimi';

  @override
  String get compareActual => 'Aktualja';

  @override
  String get compareDiff => 'Dallimi';

  @override
  String get compareTotal => 'Totali';

  @override
  String get compareBudget => 'Buxheti';

  @override
  String get compareNotBought => 'nuk u ble';

  @override
  String get compareUnplanned => 'nuk ishte planifikuar';

  @override
  String get pricierItems => 'Kostojnë më shumë';

  @override
  String get cheaperItems => 'Kostojnë më pak';

  @override
  String get compareAction => 'Krahaso';

  @override
  String get detailsSection => 'Detaje';

  @override
  String get spendingTitle => 'Shpenzimet';

  @override
  String get spendingAction => 'Shpenzimet';

  @override
  String get spendingMonthTotal => 'Ky muaj';

  @override
  String get spendingWeekly => 'Shpenzime javore';

  @override
  String get spendingMonthly => 'Shpenzime mujore';

  @override
  String get monthlyLimitTitle => 'Kufiri mujor';

  @override
  String get monthlyLimitHelp => 'Sa dëshiron të shpenzosh për blerje në muaj?';

  @override
  String get monthlyLimitRemove => 'Hiq';

  @override
  String get monthlyLimitSet => 'Cakto';

  @override
  String get monthlyLimitChange => 'Ndrysho';

  @override
  String get monthlyLimitNone =>
      'Cakto një kufi mujor për të parë sa ke mbetur.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount mbi kufirin';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return '$amount mbetur këtë muaj';
  }

  @override
  String get plansTitle => 'Planet';

  @override
  String get plansHeadline => 'Bli më mençur me AI';

  @override
  String get plansSubhead =>
      'Përputhje faturash, etiketa çimesh dhe lista nga një fjali. Anulo kur të duash.';

  @override
  String get plansMonthly => 'Mujore';

  @override
  String get plansYearly => 'Vjetore';

  @override
  String get planFree => 'Falas';

  @override
  String get planFreePrice => 'Falas përgjithmonë';

  @override
  String get planFreeAi => '10 kërkesa AI në muaj';

  @override
  String get planFreeAds =>
      'Reklama banner të vogla (pa asnjë në ditët e para 7)';

  @override
  String get planCoreFeatures => 'Lista, çmime, fatura, grafika shpenzimesh';

  @override
  String get plansPerYear => '/ vit';

  @override
  String get plansPerMonth => '/ muaj';

  @override
  String get planTrial => 'Provë falas';

  @override
  String get planProAi => '100 kërkesa AI në muaj';

  @override
  String get planNoAds => 'Pa reklama';

  @override
  String get planBackup => 'Eksportim dhe importim backup-i';

  @override
  String get planMaxAi => '300 kërkesa AI në muaj';

  @override
  String get planMaxFamily => 'Për blerje familjare të madhe';

  @override
  String get plansStoreUnavailable => 'Dyqani nuk është i aksesueshëm tani.';

  @override
  String get retryAction => 'Provo përsëri';

  @override
  String get plansPurchaseFailed =>
      'Blerja nuk u plotësua. Ju lutemi provoni përsëri.';

  @override
  String get plansRestore => 'Rikthe blerjet';

  @override
  String get plansLegal =>
      'Pro rinovohet automatikisht çdo vit deri në anulim dhe përfshin 100 kërkesa IA çdo muaj. Çmimi bazë është 1 dollar amerikan në vit pa taksat e zbatueshme; kontrolloni çmimin përfundimtar lokal dhe taksat në dyqan përpara se të konfirmoni blerjen. Menaxhoni ose anuloni abonimin në Google Play.';

  @override
  String get planCurrent => 'Aktuale';

  @override
  String get planStartTrial => 'Fillo provën falas';

  @override
  String get planChoose => 'Zgjidh';

  @override
  String get plansAction => 'Planet: Pro';

  @override
  String get assistantTitle => 'Asistenti';

  @override
  String get assistantGreeting => 'Përshëndetje! Çfarë dëshiron të bësh?';

  @override
  String get assistantNewList => 'Listë e re';

  @override
  String get assistantVoiceList => 'Listë me zë';

  @override
  String get assistantTextList => 'Listë nga një fjali';

  @override
  String get assistantScanReceipt => 'Skano një faturë';

  @override
  String get assistantSpending => 'Shpenzimet e mia';

  @override
  String get assistantReceiptHint =>
      'Hap listën tënde dhe prek ikonën e faturës për ta skanuar atë.';

  @override
  String get assistantToggleTitle => 'Shfaq asistentin';

  @override
  String get assistantToggleSubtitle =>
      'Ndihmësi i vogël në këndin e djathtë poshtë';

  @override
  String get scanPriceLabel => 'Skano etiketën e çmimit';

  @override
  String get saveFailed =>
      'Ruajtja dështoi. Ndryshimet tuaja janë ende këtu. Ju lutemi provoni përsëri.';

  @override
  String get deleteItemConfirm =>
      'A të fshihet ky artikull dhe blerjet e tij të regjistruara?';

  @override
  String get clearPurchaseConfirm =>
      'A të heqet shenja nga ky artikull dhe të hiqen blerjet e tij të regjistruara?';

  @override
  String get reportPdfAction => 'Ruaj raportin PDF';

  @override
  String get reportNotInvoice =>
      'Përmbledhje e blerjeve, jo fakturë tatimore. Shkallët tatimore janë të panjohura.';

  @override
  String get purchaseVisits => 'Vizitat e blerjeve';

  @override
  String get purchaseInterval => 'Ditët mesatarë midis blerjeve';

  @override
  String get purchasedQuantity => 'Sasia e blerë';

  @override
  String get purchaseAnalyticsHint =>
      'Blerjet nuk matin konsumin. Monedhat dhe njësitë shfaqen veçmas.';

  @override
  String get receiptReplaces =>
      'Plotësohen artikujt pa çmim. Artikujt me çmim tregu shtohen si blerje të veçanta.';

  @override
  String get receiptIncompleteHeader =>
      'Në foton tjetër përfshi dyqanin, datën, orën dhe numrin e faturës.';

  @override
  String get receiptIncompleteTail =>
      'Fotografo pjesën tjetër me disa artikuj të mbivendosur dhe shumën përfundimtare.';

  @override
  String get receiptContinuationRejected =>
      'Kjo foto nuk u bashkua. Bëj një foto tjetër me artikuj të mbivendosur nga e njëjta faturë.';

  @override
  String get receiptDraftSaved =>
      'Fatura u ruajt si draft. Mund të vazhdosh më vonë.';

  @override
  String get receiptContinueAction => 'Vazhdo faturën';

  @override
  String get receiptDraftsTitle => 'Fatura të papërfunduara';

  @override
  String get receiptDuplicate => 'Kjo faturë është shtuar tashmë.';

  @override
  String get receiptTotalMismatch =>
      'Shuma e artikujve nuk përputhet me totalin e faturës. Kontrollo nëse duket e gjithë fatura.';

  @override
  String get receiptSaveDraftAction => 'Ruaj për më vonë';

  @override
  String get receiptResolveLines =>
      'Prano ose ruaj, prano ose shpërfill çdo artikull.';

  @override
  String get receiptPartialConfirm =>
      'Do të shtohen vetëm artikujt e zgjedhur. Kjo faturë do të shënohet si e importuar. Të vazhdohet?';

  @override
  String get voiceUnsupportedLanguage =>
      'Ky gjuhë nuk është e disponueshme për hyrjen me zë në këtë pajisje. Mund të shkruani në vend të kësaj.';

  @override
  String get voiceStopListening => 'Ndalo dëgjimin';

  @override
  String get keepAwakeFailed =>
      'Nuk mund të mbahet e ndezur ekrani. Ju lutem, provoni përsëri.';

  @override
  String get purchaseHistoryHint =>
      'Të gjitha blerjet e përfunduara. Kthimet ulin totalin. Datat i referohen përfundimit të shitjes. Një vizitë nuk është mjaftueshme për të llogaritur një interval mesatar.';

  @override
  String get planLegacyRights =>
      'Abonimet ekzistuese Pro dhe Max ruajnë kufirin fillestar mujor të kërkesave IA.';

  @override
  String get csvExportAction => 'Eksporto CSV';

  @override
  String get backupSizeWarning =>
      'JSON përfshin regjistra, jo skedarë fotoje. Kufiri i importit: 16 MB.';

  @override
  String get backupImportFailed =>
      'Nuk u importua ky rezervë. Të dhënat tuaja nuk u ndryshuan.';

  @override
  String get backupImported => 'Backup u importua me sukses.';

  @override
  String backupPreviewCounts(Object entries, Object items, Object lists) {
    return '$lists lista · $items artikuj · $entries blerje';
  }

  @override
  String get voiceModelDownloading =>
      'Modeli zanor për këtë gjuhë po shkarkohet. Provo përsëri pas një minute.';

  @override
  String get historyThisWeek => 'Këtë javë';

  @override
  String get historyProductsSection => 'Produktet e blera';

  @override
  String get tipReceiptScan =>
      'Skanoni faturën për t\'i përputhur çmimet me listën tuaj';

  @override
  String get tipVoiceAdd =>
      'Thoni një ose më shumë artikuj dhe kontrolloni para se t\'i shtoni';

  @override
  String get tipShelfCamera => 'Lexoni çmimin nga etiketa e raftit me kamerën';

  @override
  String get tipPlan => 'Plani juaj: shihni detajet, abonohuni ose përmirësoni';

  @override
  String get guideAddBody =>
      'Prekni + për të shtuar një artikull. Shkruani çmimin e planifikuar tani dhe çmimin e tregut në arkë.';

  @override
  String get guideVoiceBody =>
      'Prekni mikrofonin dhe thoni artikujt, për shembull: \'1 kg mollë, 1 bukë\'.';

  @override
  String get guideReceiptBody =>
      'Skanoni një faturë për t\'i përputhur çmimet me artikujt në listën tuaj.';

  @override
  String get guidePlanBody =>
      'Prekni ikonën e planit për të parë planin, për t\'u abonuar ose për të përmirësuar.';

  @override
  String get guideNext => 'OK';

  @override
  String get guideDone => 'Fillo';

  @override
  String get paletteLabel => 'Tema e ngjyrave';

  @override
  String get paletteForest => 'Pyll';

  @override
  String get paletteOcean => 'Oqean';

  @override
  String get paletteSunset => 'Perëndim dielli';

  @override
  String get paletteLavender => 'Livando';

  @override
  String get darkBlackLabel => 'E zezë e plotë në temën e errët';

  @override
  String get spendingOverview => 'Përmbledhje';

  @override
  String get spendingThisYear => 'Këtë vit';

  @override
  String get spendingYearly => 'Shpenzimi vjetor';

  @override
  String get productSpending => 'Shpenzimi sipas produktit';

  @override
  String get spanWeek => 'Javë';

  @override
  String get spanMonth => 'Muaj';

  @override
  String get spanYear => 'Vit';

  @override
  String get weeklyLimitTitle => 'Kufiri javor';

  @override
  String get weeklyLimitHelp => 'Sa doni të shpenzoni për blerje në javë?';

  @override
  String get weeklyLimitNone =>
      'Vendosni një kufi javor për të parë sa ka mbetur.';

  @override
  String weeklyLimitLeft(String amount) {
    return 'Kanë mbetur $amount këtë javë';
  }

  @override
  String get shoppingLimitTitle => 'Kufiri për çdo blerje';

  @override
  String get shoppingLimitHelp => 'Listat e reja nisin me këtë buxhet.';

  @override
  String get shoppingLimitNone =>
      'Vendosni një buxhet të paracaktuar për çdo blerje të re.';

  @override
  String get monthlyReportAction => 'Raporti mujor';

  @override
  String get reportShoppingColumn => 'Blerje';

  @override
  String get reportDateColumn => 'Data';

  @override
  String get planUnavailable => 'Aktualisht nuk është në dyqan';

  @override
  String get demoDataTitle => 'Të dhëna shembull';

  @override
  String get demoDataLoad => 'Provo me të dhëna shembull';

  @override
  String get demoDataLoadHelp =>
      'Shton blerje shembull për 12 muaj që të shihni historikun, grafikët dhe historikun e çmimeve.';

  @override
  String get demoDataRemove => 'Hiq të dhënat shembull';

  @override
  String get demoDataAdded => 'Të dhënat shembull u shtuan';

  @override
  String get demoDataRemoved => 'Të dhënat shembull u hoqën';

  @override
  String get demoProductApple => 'Mollë';

  @override
  String get demoProductBread => 'Bukë';

  @override
  String get demoProductMilk => 'Qumësht';

  @override
  String get demoProductCheese => 'Djathë';

  @override
  String get demoProductTomato => 'Domate';

  @override
  String get demoProductEggs => 'Vezë';

  @override
  String get demoProductCoffee => 'Kafe';

  @override
  String get demoProductDetergent => 'Detergjent';

  @override
  String get sendAction => 'Send';

  @override
  String get previousMonthAction => 'Previous month';

  @override
  String get nextMonthAction => 'Next month';

  @override
  String get helpSection => 'Ndihmë dhe mbështetje';

  @override
  String get howToUseLabel => 'Si përdoret';

  @override
  String get guidePricesBody =>
      'Çmimi në dyqan e shënon produktin si të blerë; vlen edhe 0. Çmimi në shtëpi është fakultativ. Fshini çmimin në dyqan për të hequr shenjën.';

  @override
  String get shoppingDateLabel => 'Data e blerjeve';

  @override
  String get shoppingDateNone => 'Nuk është zgjedhur datë';

  @override
  String get clearShoppingDateAction => 'Hiq datën';

  @override
  String get listSortLabel => 'Renditja e listës';

  @override
  String get listSortDate => 'Data e blerjeve';

  @override
  String get listSortAz => 'Emri (A–Z)';

  @override
  String get listSortManual => 'Renditje manuale';

  @override
  String get imageCameraAction => 'Bëj foto';

  @override
  String get imageGalleryAction => 'Zgjidh nga fotot';

  @override
  String get imageCaptureFailed =>
      'Kamera ose fotot nuk mund të hapeshin. Kontrolloni lejen e qasjes dhe provoni përsëri.';

  @override
  String get imageRecognitionFailed =>
      'Fotoja nuk mund të përpunohej. Provoni një foto tjetër.';

  @override
  String get receiptNoProducts =>
      'Teksti u lexua, por nuk u gjetën artikujt e kuponit. Përfshini artikujt dhe shumën totale në foto.';

  @override
  String get keepAwakeOn => 'Ekrani qëndron ndezur';

  @override
  String get keepAwakeOff => 'Ekrani mund të fiket';

  @override
  String get spanDay => 'Ditë';

  @override
  String get spanCustom => 'Intervali i datave';

  @override
  String get reportTotalSpent => 'Gjithsej shpenzuar';

  @override
  String get reportAddedAt => 'U shtua';

  @override
  String get reportReceiptNumber => 'Numri i faturës';

  @override
  String get reportPreview => 'Pamja paraprake';

  @override
  String get reportShareAction => 'Ndaj';

  @override
  String get previousPeriodAction => 'Periudha e mëparshme';

  @override
  String get nextPeriodAction => 'Periudha tjetër';

  @override
  String get reportSaved => 'Raporti u ruajt.';

  @override
  String get reportZoom => 'Zmadho';

  @override
  String planTrialDaysLeft(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days ditë të mbetura',
      one: '$days ditë e mbetur',
    );
    return '$_temp0';
  }

  @override
  String planTrialHoursLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours orë të mbetura',
      one: '$hours orë e mbetur',
    );
    return '$_temp0';
  }

  @override
  String get planTrialEndedTitle => 'Periudha e provës Pro përfundoi';

  @override
  String get planTrialEndedBody =>
      'Mund të vazhdosh t’i përdorësh listat, futjen manuale dhe zërin në pajisje falas. Plani Falas përfshin 10 kërkesa AI për muaj kalendarik. Zgjidh Pro vjetor për 100 kërkesa AI në muaj, pa reklama dhe me kopje rezervë. Të dhënat ekzistuese mbeten me ty.';

  @override
  String get planContinueFree => 'Vazhdo falas';

  @override
  String get supportIdLabel => 'ID-ja e mbështetjes';

  @override
  String get supportEmailLabel => 'Mbështetje me email';

  @override
  String get captureTipFirst =>
      'Fillo që nga maja: emri i dyqanit dhe data duhet të duken. Përfshi sa më shumë artikuj; pjesa tjetër shkon në foton tjetër.';

  @override
  String get captureTipContinue =>
      'E njëjta faturë: përfshi artikullin e fundit të fotos së mëparshme.';

  @override
  String get captureTipNeverShow => 'Mos e shfaq më';

  @override
  String get captureTipOk => 'E kuptova';

  @override
  String get captureTipsSetting => 'Shfaq këshillat për fotografimin e faturës';
}
