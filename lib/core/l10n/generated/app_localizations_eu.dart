// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Basque (`eu`).
class AppLocalizationsEu extends AppLocalizations {
  AppLocalizationsEu([String locale = 'eu']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Planifikatu etxean. Erosi planifikatutako bezala.';

  @override
  String get listsTitle => 'Zerrendak';

  @override
  String get listsTabActive => 'Aktiboak';

  @override
  String get listsTabCompleted => 'Osatuak';

  @override
  String get listsTabArchived => 'Artxibatuta';

  @override
  String get newListButton => 'Zerrenda berria';

  @override
  String get listTitleHint => 'Izenburua (aukerazkoa)';

  @override
  String get saveButton => 'Gorde';

  @override
  String get cancelButton => 'Utzi';

  @override
  String get deleteButton => 'Ezabatu';

  @override
  String get editAction => 'Editatu';

  @override
  String get listDeleted => 'Zerrenda ezabatuta';

  @override
  String get invalidAmountError => 'Baliozko ez den zenbatekoa';

  @override
  String get duplicateAction => 'Bikoiztu';

  @override
  String get archiveAction => 'Artxibatu';

  @override
  String get unarchiveAction => 'Kendu artxibotik';

  @override
  String get deleteListConfirm =>
      'Zerrenda hau ezabatu nahi duzu? Bere planifikatutako elementuak ere kenduko dira.';

  @override
  String get undoButton => 'Desegin';

  @override
  String get searchListHint => 'Bilatu zerrendak';

  @override
  String get currencyLabel => 'Moneta';

  @override
  String get budgetLabel => 'Aurrekontua (aukerazkoa)';

  @override
  String get noteLabel => 'Oharra (aukerazkoa)';

  @override
  String get storeLabel => 'Denda';

  @override
  String get keepAmountsAction => 'Mantendu kantitateak';

  @override
  String get resetAmountsAction => 'Berrezarri kantitateak';

  @override
  String get currencyChangeWarning =>
      'Moneta aldatzen ari da. Zer gertatu behar da dauden kantitateekin?';

  @override
  String get listsEmpty =>
      'Oraindik ez dago zerrendarik. Sortu zure lehen erosketa-plana.';

  @override
  String get statusDraft => 'Zirriborroa';

  @override
  String get statusPlanned => 'Planifikatua';

  @override
  String get statusShopping => 'Erosketan';

  @override
  String get statusCompleted => 'Osatua';

  @override
  String get statusArchived => 'Artxibatuta';

  @override
  String autoListTitle(String date) {
    return '$date -ko erosketa';
  }

  @override
  String get itemFormTitle => 'Gehitu elementua';

  @override
  String get itemNameLabel => 'Elementuaren izena';

  @override
  String get brandLabel => 'Marka / bariantza (aukerazkoa)';

  @override
  String get categoryLabel => 'Kategoria';

  @override
  String get quantityLabel => 'Kantitatea';

  @override
  String get unitLabel => 'Unitatea';

  @override
  String get pricingModeLabel => 'Prezio-sarrera modua';

  @override
  String get pricingModeUnitPrice => 'Unitate-prezioa';

  @override
  String get pricingModeLineTotal => 'Lerroko guztira';

  @override
  String get plannedPriceLabel => 'Planifikatutako prezioa';

  @override
  String lineTotalCalculated(String value) {
    return 'Lerroko guztira: $value';
  }

  @override
  String get requiredItemToggle => 'Beharrezko elementua';

  @override
  String get maxPriceLabel => 'Onartzen den gehienezko prezioa (aukerazkoa)';

  @override
  String get itemNoteLabel => 'Oharra (aukerazkoa)';

  @override
  String get categoryProduce => 'Fruitak eta barazkiak';

  @override
  String get categoryDairy => 'Onddoak';

  @override
  String get categoryMeat => 'Haragia';

  @override
  String get categoryBakery => 'Ogiola';

  @override
  String get categoryDrinks => 'Edariak';

  @override
  String get categoryCleaning => 'Garbiketa';

  @override
  String get categoryPersonalCare => 'Pertsonal arreta';

  @override
  String get categoryHome => 'Etxea';

  @override
  String get categoryOther => 'Besteak';

  @override
  String get invalidQuantityError => 'Baliozko ez den kantitatea';

  @override
  String get invalidPriceError => 'Baliozko ez den prezioa';

  @override
  String get invalidNameError => 'Sartu izen bat';

  @override
  String unitPriceCalculated(String value) {
    return 'Unitate-prezioa: $value';
  }

  @override
  String get shoppingTitle => 'Erosteko modua';

  @override
  String get summaryPlannedTotal => 'Planifikatua';

  @override
  String get summaryInCart => 'Saskian';

  @override
  String get summaryRemainingPlan => 'Geratzen den plana';

  @override
  String get summaryProjected => 'Kobrantza estimatua';

  @override
  String get summaryBudgetRemaining => 'Aurrekontu geratzea';

  @override
  String get summaryBudgetOver => 'Aurrekontua gaindituta';

  @override
  String itemsProgress(String done, String total) {
    return '$done / $total elementu';
  }

  @override
  String get filterAll => 'Denak';

  @override
  String get filterToBuy => 'Erosi beharrekoak';

  @override
  String get filterInCart => 'Saskian';

  @override
  String get filterNotFound => 'Ez da aurkitu';

  @override
  String get filterRequired => 'Beharrezkoa';

  @override
  String get quickEntryTitle => 'Benetako prezioa';

  @override
  String get actualQuantityLabel => 'Benetako kantitatea';

  @override
  String get actualPriceLabel => 'Benetako prezioa';

  @override
  String get discountLabel => 'Deskontua (aukerazkoa)';

  @override
  String get alternativeNameLabel => 'Alternatiba izena (aukerazkoa)';

  @override
  String get savePurchaseButton => 'Gehitu saskira';

  @override
  String get unplannedAddButton => 'Gehitu planifikatu gabeko elementua';

  @override
  String get statusPending => 'Ez da hartu';

  @override
  String get statusInCart => 'Saskian';

  @override
  String get statusNotFound => 'Ez da aurkitu';

  @override
  String get statusGaveUp => 'Uko egin zaio';

  @override
  String get statusAlternative => 'Alternatiba erosi da';

  @override
  String get keepScreenAwake => 'Mantendu pantaila piztuta';

  @override
  String get finishShopping => 'Amaitu erosketak';

  @override
  String get completionWarning =>
      'Datu falta edo egiaztatu gabe daude. Oraindik amaitu dezakezu; emaitzak horiek kontuan hartuko ditu.';

  @override
  String get continueShoppingButton => 'Jarraitu erosketan';

  @override
  String get resultTitle => 'Emaitza';

  @override
  String get summarySection => 'Laburpena';

  @override
  String get plannedTotalLabel => 'Guztizko planifikatua';

  @override
  String get actualTotalLabel => 'Guztizko benetakoa';

  @override
  String get varianceLabel => 'Desberdintasuna';

  @override
  String get varianceNotComputable => 'Ezin da kalkulatua';

  @override
  String get budgetStatusLabel => 'Aurrekontua';

  @override
  String get savingsLabel => 'Plana baino gutxiago';

  @override
  String get overspendLabel => 'Plana gaindituta';

  @override
  String get unplannedTotalLabel => 'Planifikatu gabeko guztira';

  @override
  String get unpurchasedLabel => 'Planifikatua baina ez erositakoak';

  @override
  String get totalDiscountLabel => 'Deskontu guztira';

  @override
  String get accuracyLabel => 'Estimazio zehaztasuna';

  @override
  String get groupsSection => 'Elementuak';

  @override
  String get groupPricier => 'Planifikatua baino garestiagoa';

  @override
  String get groupCheaper => 'Planifikatua baino merkeagoa';

  @override
  String get groupClose => 'Estimazioaren inguruan';

  @override
  String get groupNotTaken => 'Planifikatua, baina ez erositakoak';

  @override
  String get groupUnplanned => 'Planifikatu gabe erositakoak';

  @override
  String get groupQuantityChanged => 'Kantitatea aldatu da';

  @override
  String get groupUnverified => 'Egiaztatu gabe';

  @override
  String get plannedQtyLabel => 'Planifikatutako kantitatea';

  @override
  String get actualQtyLabel => 'Benetako kantitatea';

  @override
  String get plannedUnitPriceLabel => 'Planifikatutako unitate-prezioa';

  @override
  String get actualUnitPriceLabel => 'Benetako unitate-prezioa';

  @override
  String get lineVarianceLabel => 'Lerroko desberdintasuna';

  @override
  String get discountEffectLabel => 'Deskontuaren eragina';

  @override
  String get notBoughtMark => 'ez da erosi';

  @override
  String get noPurchasesNote => 'Ez da erostearik erregistratu.';

  @override
  String get navHome => 'Hasiera';

  @override
  String get navLists => 'Zerrendak';

  @override
  String get navHistory => 'Historia';

  @override
  String get navSettings => 'Ezarpenak';

  @override
  String get homeEmptyTitle => 'Antolatu zure erosketa';

  @override
  String get homeEmptyBody =>
      'Sortu zure lehen zerrenda eta alderatu aurreikusitako kostua benetakoaarekin.';

  @override
  String get homeActiveSection => 'Zerrendak aktiboak';

  @override
  String get homeCompletedSection => 'Duela gutxi osatutakoak';

  @override
  String get homeMonthlySection => 'Hilabete honetan';

  @override
  String get monthPlannedLabel => 'Aurreikusia';

  @override
  String get monthActualLabel => 'Benetakoa';

  @override
  String get monthVarianceLabel => 'Desberdina';

  @override
  String get continueShoppingLabel => 'Jarraitu erosketan';

  @override
  String get historyEmpty =>
      'Oraindik ez dago osatutako erosketarik. Zure historia eta ikuspegiak hemen agertuko dira.';

  @override
  String get aboutTabTitle => 'NShoptorri buruz';

  @override
  String get aboutBody =>
      'Crazy Penguin-en NShoptor. Erosketa-plangintza offline lehentasunez. GPL-3.0 lizentziapean.';

  @override
  String get startShoppingLabel => 'Hasi erosketan';

  @override
  String get finishAndSeeResult => 'Amaitu eta ikusi emaitza';

  @override
  String get settingsTitle => 'Ezarpenak';

  @override
  String get languageLabel => 'Hizkuntza';

  @override
  String get languageSystem => 'Sistema';

  @override
  String get languageTr => 'Turkiera';

  @override
  String get languageEn => 'Ingelesa';

  @override
  String get themeLabel => 'Gaia';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Argia';

  @override
  String get themeDark => 'Iluna';

  @override
  String get defaultCurrencyLabel => 'Balore monetario lehenetsia';

  @override
  String get defaultUnitLabel => 'Unitate lehenetsia';

  @override
  String get keepAwakeLabel => 'Pantaila piztuta mantendu erosketan zehar';

  @override
  String get backupSection => 'Backup-a';

  @override
  String get exportBackupLabel => 'Esportatu backup-a';

  @override
  String get importBackupLabel => 'Inportatu backup-a';

  @override
  String get mergeImportLabel => 'Bateratu uneko datuekin';

  @override
  String get separateImportLabel => 'Inportatu kopia bereizi gisa';

  @override
  String get importCancelled => 'Inportazioa bertan behera utzi da.';

  @override
  String get backupExported => 'Backup-a ondo esportatu da.';

  @override
  String get backupSizeWarning =>
      'Backup handia: fitxategia handia izan daiteke. Argazkiak ere sartu nahi dituzu?';

  @override
  String get deleteAllSection => 'Arriskuko eremua';

  @override
  String get deleteAllLabel => 'Ezabatu datu guztiak';

  @override
  String get deleteAllConfirm =>
      'Honek zerrenda, historia, jasoeren argazkiak eta prezio guztiak kenduko ditu. Zuk esportatutako fitxategiak zure diskoan geratzen dira. Jarraitu?';

  @override
  String get deleteAllConfirm2 => 'Ziur zaude? Ekintza hau ezin da desegitu.';

  @override
  String get cancelAction => 'Utzi';

  @override
  String get confirmDelete => 'Betirako ezabatu';

  @override
  String get dataDeleted => 'Lokaleko datu guztiak ezabatu dira.';

  @override
  String get privacyInfoLabel => 'Pribatutasuna';

  @override
  String get privacyInfoBody =>
      'Zure zerrendak, prezioak, jasoen eta argazkiak zure gailuan geratzen dira. Argazkiak eta ahotsa inoiz ez dira kanpora ateratzen. AI laguntza aktibatuta badago, testua bakarrik (adibidez, jasoko lerroak edo diktatutakoa) bidaltzen da gure zerbitzura prozesatzeko eta ez da gordetzen.';

  @override
  String get aboutSection => 'Buruz';

  @override
  String get aboutPublisher => 'Argitaratzailea: Crazy Penguin';

  @override
  String get aboutLicenses => 'Lizentziak (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Ahots sarrera';

  @override
  String get voiceStatusUnknown => 'Zerbitzua: ez da egiaztatu';

  @override
  String get permissionsLabel => 'Baimenak';

  @override
  String get permissionsBody =>
      'Kamera, mikrofonoa eta jakinarazpenak eskatzen dira soilik funtzionamendu horiek erabiltzen dituzunean.';

  @override
  String get unitsSection => 'Lehenetsitakoak';

  @override
  String get roundingNote =>
      'Diruaren biribitze arau bat jarraitzen du: erdiak zero-tik urruti biribiltzen dira, Money bihurketa batean bakarrik aplikatzen da.';

  @override
  String get voiceInputTitle => 'Ahots sarrera';

  @override
  String get voiceStartListening => 'Entzuten hasi';

  @override
  String get voiceTranscriptLabel => 'Transkripzioa';

  @override
  String get parseAction => 'Aztertu';

  @override
  String get receiptReviewTitle => 'Berrikusi jasoa';

  @override
  String get receiptTotal => 'Jasoeren totala';

  @override
  String get receiptTotalUnknown => 'Ezin izan da totala detektatu';

  @override
  String get receiptDiff => 'Diferentzia';

  @override
  String get acceptLine => 'Onartu lerroa';

  @override
  String get ignoreLine => 'Baztertu lerroa';

  @override
  String get receiptLineActions => 'Lotu produktuari, banatu edo baztertu';

  @override
  String get receiptCommit => 'Onartu dena';

  @override
  String get receiptCommitted => 'Jasoera aplikatu da.';

  @override
  String get priceHistoryTitle => 'Prezioen historia';

  @override
  String get noObservations => 'Oraindik ez dago prezio behaketarik';

  @override
  String get templatesSection => 'Txantiloiak';

  @override
  String get templateHint =>
      'Sortu plan berri bat aurreko erosketa-bidaia batean oinarrituta';

  @override
  String get scanReceiptAction => 'Eskaneatu jasoera';

  @override
  String get shelfLabelAction => 'Prezioa etiketatik';

  @override
  String get priceCandidatesTitle => 'Prezio hautagaiak';

  @override
  String get noPriceCandidates => 'Ez da preziorik aurkitu; sartu eskuz.';

  @override
  String get voiceUnavailable =>
      'Ahots-ezagutzea ez dago erabilgarri; sartu eskuz.';

  @override
  String get linkToItem => 'Lotu produktuari';

  @override
  String get splitLine => 'Banatu bi zatitan';

  @override
  String get mergeWithNext => 'Batu hurrengoarekin';

  @override
  String get ocrNoText => 'Ez da testurik irakurri; saiatu berriz.';

  @override
  String get priceHistoryAction => 'Prezioen historia';

  @override
  String get itemsEmptyTitle => 'Oraindik ez dago produktuak';

  @override
  String get itemsEmptyBody =>
      'Gehitu zure lehen produktua — dendetan benetako prezioak hemen sartuko dituzu.';

  @override
  String get addItemTooltip => 'Gehitu produktua';

  @override
  String get unitAdet => 'zt';

  @override
  String get unitKilogram => 'kg';

  @override
  String get unitGram => 'g';

  @override
  String get unitLitre => 'L';

  @override
  String get unitMililitre => 'ml';

  @override
  String get unitPaket => 'paka';

  @override
  String get unitKutu => 'kartoi';

  @override
  String get unitSise => 'botila';

  @override
  String get unitKavanoz => 'botika';

  @override
  String get unitDemet => 'sorgin';

  @override
  String get unitDuzine => 'hamabi';

  @override
  String get unitMetre => 'm';

  @override
  String get unitCustom => 'Pertsonalizatua';

  @override
  String get setReminderAction => 'Ezarri gogorarazlea';

  @override
  String get reminderPermissionDenied =>
      'Gogorarazleentzat jakinarazpen baimena behar da. Sistemaren ezarpenetan aktiba dezakezu.';

  @override
  String get reminderScheduled => 'Gogorarazlea ezarrita.';

  @override
  String get reminderCancelled => 'Gogorarazlea kenduta.';

  @override
  String get reminderTitle => 'Erosketa-gogorarazlea';

  @override
  String reminderBody(Object title) {
    return 'Zerrenda egiaztatzeko ordua: $title';
  }

  @override
  String get reminderPickDate => 'Aukeratu data';

  @override
  String get reminderPickTime => 'Aukeratu ordua';

  @override
  String get itemDetailsSection => 'Xehetasunak';

  @override
  String get priceOptionalHint =>
      'Aukerakoa — dendan benetako prezioa sartuko duzu';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Planoa: $total · $count produktu';
  }

  @override
  String get proActiveLabel => 'Pro aktibo — eskerrik asko!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Iragarkirik ez, AI gehiago, backup · hilabetero prezio txiki batetik';

  @override
  String get proBenefitNoAds => 'Iragarkirik gabeko esperientzia';

  @override
  String get proBenefitBackup => 'Backup (esportazio/esportazio)';

  @override
  String aboutVersion(Object version) {
    return '$version bertsioa';
  }

  @override
  String get navDiscover => 'Aurkitu';

  @override
  String get shareAction => 'Partekatu aplikazioa';

  @override
  String get rateAction => 'Baloratu gaitzazu';

  @override
  String get aboutOpenRow => 'Honi buruz eta kode irekia';

  @override
  String get voiceAddItemAction => 'Gehitu ahots bidez';

  @override
  String get formatLocaleLabel => 'Zenbaki eta moneta-formatua';

  @override
  String get formatLocaleSystem =>
      'Sistema (aplikazioaren hizkuntza jarraitzen du)';

  @override
  String get formatLocaleTr => 'Turkiera (1.234,56)';

  @override
  String get formatLocaleEn => 'Ingelesa (1,234.56)';

  @override
  String get aiToggleTitle => 'AI laguntza';

  @override
  String get aiToggleSubtitle =>
      'Errezeptuak bat datoz, prezio-etiketak irakurtzen ditu eta esaldiak zerrendetan bihurtzen ditu. Argazkiak eta ahotsa zure gailuan geratzen dira; testua bakarrik prozesatzen da.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Hilabete honetako AI eskariak erabili dituzu ($used/$limit). Egunitu gehiago lortzeko, edo jarraitu AI gabe.';
  }

  @override
  String get aiOffline => 'Konexiorik ez — AI gabe jarraitzen da.';

  @override
  String get aiFailed =>
      'AI ez dago erabilgarri orain — AI gabe jarraitzen da.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'Gailua';

  @override
  String get quickListAction => 'Gehitu esaldi batetik';

  @override
  String get quickListTitle => 'Zerrenda azkarra';

  @override
  String get quickListHint => 'adib. 1 kg sagar 20, 2 ogi, gazta erdi kilo';

  @override
  String get quickListConvert => 'Zerrenda bihurtu';

  @override
  String quickListAdd(int count) {
    return 'Gehitu $count elementu';
  }

  @override
  String get quickListEmpty =>
      'Ez da elementurik aurkitu. Saiatu komaz bereizita zerrendatzen.';

  @override
  String get receiptAiMatched =>
      'AI-k errezeptua zure zerrendarekin bat etorri du. Egiaztatu estekak eta baieztatu.';

  @override
  String get receiptNeedsCheck => 'Egiaztatu batzea';

  @override
  String get receiptDiscountLine => 'Deskontua';

  @override
  String get compareItem => 'Elementua';

  @override
  String get compareEstimated => 'Estimazioa';

  @override
  String get compareActual => 'Benetakoa';

  @override
  String get compareDiff => 'Diferentzia';

  @override
  String get compareTotal => 'Guztira';

  @override
  String get compareBudget => 'Aurrekontua';

  @override
  String get compareNotBought => 'ez da erosi';

  @override
  String get compareUnplanned => 'ez da planifikatu';

  @override
  String get pricierItems => 'Garestiagoa';

  @override
  String get cheaperItems => 'Merkeagoa';

  @override
  String get compareAction => 'Konparatu';

  @override
  String get detailsSection => 'Xehetasunak';

  @override
  String get spendingTitle => 'Kostua';

  @override
  String get spendingAction => 'Kostua';

  @override
  String get spendingMonthTotal => 'Hilabete honetan';

  @override
  String get spendingWeekly => 'Asteko kostua';

  @override
  String get spendingMonthly => 'Hilabeteko kostua';

  @override
  String get monthlyLimitTitle => 'Hilabeteko muga';

  @override
  String get monthlyLimitHelp =>
      'Zenbat gastatu nahi duzu erosketetan hilabetero?';

  @override
  String get monthlyLimitRemove => 'Kendu';

  @override
  String get monthlyLimitSet => 'Ezarri';

  @override
  String get monthlyLimitChange => 'Aldatu';

  @override
  String get monthlyLimitNone =>
      'Ezarri hilabeteko muga ikusteko zenbat gelditzen zaizun.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount mugatik haratago';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return '$amount geratzen da hilabete honetan';
  }

  @override
  String get plansTitle => 'Planoak';

  @override
  String get plansHeadline => 'Erosi adimentsuki AI-rekin';

  @override
  String get plansSubhead =>
      'Errezeptuen parekatzea, prezio-etiketak eta esaldietatik zerrendak. Utz dezakezu edozein unetan.';

  @override
  String get plansMonthly => 'Hilabetekoa';

  @override
  String get plansYearly => 'Urteko';

  @override
  String get planFree => 'Doakoa';

  @override
  String get planFreePrice => 'Betiko doakoa';

  @override
  String get planFreeAi => '15 AI eskari hilabetero';

  @override
  String get planFreeAds =>
      'Irrati-iragarki txikiak (ez dago lehenengo 7 egunetan)';

  @override
  String get planCoreFeatures =>
      'Zerrendak, prezioak, errezeptuak, kostu-grafikoak';

  @override
  String get plansPerYear => '/ urte';

  @override
  String get plansPerMonth => '/ hilabete';

  @override
  String get planTrial => '7 egun doan';

  @override
  String get planProAi => '200 AI eskari hilabetero';

  @override
  String get planNoAds => 'Iragarkirik ez';

  @override
  String get planBackup => 'Atxapen esportazioa eta inportazioa';

  @override
  String get planMaxAi => 'Hilabetero AI eskariak 1000';

  @override
  String get planMaxFamily => 'Familia handietarako erosketak';

  @override
  String get plansStoreUnavailable => 'Denda ez dago erabilgarri une honetan.';

  @override
  String get retryAction => 'Saiatu berriro';

  @override
  String get plansPurchaseFailed =>
      'Erosketa ez da burutu. Mesedez, saiatu berriro.';

  @override
  String get planLifetimeTitle => 'Iragarkirik gabe betirako';

  @override
  String get planLifetimeSubtitle =>
      'Ordainketa bakarra: iragarkirik gabe, atxapena; AI doan mantenduko da';

  @override
  String get plansRestore => 'Berrezarri erosketak';

  @override
  String get plansLegal =>
      'Harpidetzak automatikoki berritzen dira bertan behera utzi arte. Edozein unetan bertan behera uzten da Google Play › Ordaintzea eta harpidetzak atalean. Prezioek Google Play-k erakusten dituen zergak barne hartzen dituzte.';

  @override
  String get planCurrent => 'Uneko';

  @override
  String get planStartTrial => 'Hasteko 7 eguneko proba doan';

  @override
  String get planChoose => 'Aukeratu';

  @override
  String get plansAction => 'Planoak: Pro eta Max';

  @override
  String get assistantTitle => 'Laguntzailea';

  @override
  String get assistantGreeting => 'Kaixo! Zer egin nahi duzu?';

  @override
  String get assistantNewList => 'Zerrenda berria';

  @override
  String get assistantVoiceList => 'Zerrenda ahotsarekin';

  @override
  String get assistantTextList => 'Zerrenda esaldi batetik';

  @override
  String get assistantScanReceipt => 'Errezeptu bat eskaneatu';

  @override
  String get assistantSpending => 'Nire gastua';

  @override
  String get assistantReceiptHint =>
      'Ireki zure zerrenda eta sakatu errezeptuaren ikonoa eskaneatzeko.';

  @override
  String get assistantToggleTitle => 'Erakutsi laguntzailea';

  @override
  String get assistantToggleSubtitle => 'Laguntzaile txikia behe-eskuinean';

  @override
  String get scanPriceLabel => 'Eskaneatu prezio etiketa';
}
