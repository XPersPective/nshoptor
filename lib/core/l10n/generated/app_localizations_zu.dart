// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Zulu (`zu`).
class AppLocalizationsZu extends AppLocalizations {
  AppLocalizationsZu([String locale = 'zu']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Hlela ekhaya. Thenga njengoba uhlelile.';

  @override
  String get listsTitle => 'Izinhlu';

  @override
  String get listsTabActive => 'Eyasebenza';

  @override
  String get listsTabCompleted => 'Ephelile';

  @override
  String get listsTabArchived => 'Elondoloziwe';

  @override
  String get newListButton => 'Uhlu olusha';

  @override
  String get listTitleHint => 'Isihloko (okukhethwa)';

  @override
  String get saveButton => 'Londoloza';

  @override
  String get cancelButton => 'Khansela';

  @override
  String get deleteButton => 'Susa';

  @override
  String get editAction => 'Hlela';

  @override
  String get listDeleted => 'Uhlu lususiwe';

  @override
  String get invalidAmountError => 'Inani alivumelekile';

  @override
  String get duplicateAction => 'Phinda kabusha';

  @override
  String get archiveAction => 'Londoloza';

  @override
  String get unarchiveAction => 'Vula ukulondolozwa';

  @override
  String get deleteListConfirm =>
      'Ufuna ususe lo nhlu? Izinto ezihleliwe nazo zizosuswa.';

  @override
  String get undoButton => 'Buyisela emuva';

  @override
  String get searchListHint => 'Sesha izinhlu';

  @override
  String get currencyLabel => 'Imali';

  @override
  String get budgetLabel => 'Ubudlethi (okukhethwa)';

  @override
  String get noteLabel => 'Umlayezo (okukhethwa)';

  @override
  String get storeLabel => 'Umnyuziyamu';

  @override
  String get keepAmountsAction => 'Gcina amanani';

  @override
  String get resetAmountsAction => 'Qala kabusha amanani';

  @override
  String get currencyChangeWarning =>
      'Imali iyashintsha. Kufanele kwenzekani ngamanani akhona?';

  @override
  String get listsEmpty =>
      'Akukho zinhlu okwamanje. Yakha uhlu lwakho lokuqulu lokuthenga.';

  @override
  String get statusDraft => 'Isithombe';

  @override
  String get statusPlanned => 'Kuhleliwe';

  @override
  String get statusShopping => 'Kuthengwa';

  @override
  String get statusCompleted => 'Kuphelile';

  @override
  String get statusArchived => 'Kulondoloziwe';

  @override
  String autoListTitle(String date) {
    return 'Thenga $date';
  }

  @override
  String get itemFormTitle => 'Engeza into';

  @override
  String get itemNameLabel => 'Igama lento';

  @override
  String get brandLabel => 'Umklamo / ingxenye (okukhethwa)';

  @override
  String get categoryLabel => 'Iqembu';

  @override
  String get quantityLabel => 'Inani';

  @override
  String get unitLabel => 'Yunithi';

  @override
  String get pricingModeLabel => 'Indlela yokubeka inani';

  @override
  String get pricingModeUnitPrice => 'Inani yeyunithi';

  @override
  String get pricingModeLineTotal => 'Isamba sesiqephu';

  @override
  String get plannedPriceLabel => 'Inani elihleliwe';

  @override
  String lineTotalCalculated(String value) {
    return 'Isamba sesiqephu: $value';
  }

  @override
  String get requiredItemToggle => 'Into ebalulekile';

  @override
  String get maxPriceLabel => 'Inani eliphezulu elivumelekile (okukhethwa)';

  @override
  String get itemNoteLabel => 'Umlayezo (okukhethwa)';

  @override
  String get categoryProduce => 'Imifino nemifino';

  @override
  String get categoryDairy => 'Imilk';

  @override
  String get categoryMeat => 'Inyama';

  @override
  String get categoryBakery => 'Ibhakhi';

  @override
  String get categoryDrinks => 'Amatshe';

  @override
  String get categoryCleaning => 'Ukuhlambula';

  @override
  String get categoryPersonalCare => 'Ukunakekelwa komuntu';

  @override
  String get categoryHome => 'Indlu';

  @override
  String get categoryOther => 'Okunye';

  @override
  String get invalidQuantityError => 'Inani alivumelekile';

  @override
  String get invalidPriceError => 'Inani alivumelekile';

  @override
  String get invalidNameError => 'Faka igama';

  @override
  String unitPriceCalculated(String value) {
    return 'Ibhili yeyunithi: $value';
  }

  @override
  String get shoppingTitle => 'Imodi yokuthenga';

  @override
  String get summaryPlannedTotal => 'Okuhleliwe';

  @override
  String get summaryInCart => 'Ekhasini lokuthenga';

  @override
  String get summaryRemainingPlan => 'Okusele ohlelweni';

  @override
  String get summaryProjected => 'Ukukhokha okulindelekile';

  @override
  String get summaryBudgetRemaining => 'Isabelomali esisele';

  @override
  String get summaryBudgetOver => 'Kuphele isabelomali';

  @override
  String itemsProgress(String done, String total) {
    return '$done kwezinto eziyi-$total';
  }

  @override
  String get filterAll => 'Konke';

  @override
  String get filterToBuy => 'Okufanele kuthengwe';

  @override
  String get filterInCart => 'Ekhasini lokuthenga';

  @override
  String get filterNotFound => 'Akutholiwe';

  @override
  String get filterRequired => 'Okudingekayo';

  @override
  String get quickEntryTitle => 'Ixabiso langempela';

  @override
  String get actualQuantityLabel => 'Ubuningi bangempela';

  @override
  String get actualPriceLabel => 'Ixabiso langempela';

  @override
  String get discountLabel => 'Ukuhluliswa kwemali (okungenzeka)';

  @override
  String get alternativeNameLabel =>
      'Igama lomkhiqizo ongakhetha (okungenzeka)';

  @override
  String get savePurchaseButton => 'Engeza ekhasini lokuthenga';

  @override
  String get unplannedAddButton => 'Engeza into engahleliwe';

  @override
  String get statusPending => 'Akathathwa';

  @override
  String get statusInCart => 'Ekhasini lokuthenga';

  @override
  String get statusNotFound => 'Akutholiwe';

  @override
  String get statusGaveUp => 'Kushiyeke';

  @override
  String get statusAlternative => 'Kuthengwe okungakhetha';

  @override
  String get keepScreenAwake => 'Gcina isikrini sivuliwe';

  @override
  String get finishShopping => 'Phetha ukuthenga';

  @override
  String get completionWarning =>
      'Kunezinsuku ezilahlekile noma ezingaqinisekiswanga. Ungaphetha; umphumuzi uzozibala.';

  @override
  String get continueShoppingButton => 'Qhubeka nokuthenga';

  @override
  String get resultTitle => 'Umphumela';

  @override
  String get summarySection => 'Isifinyezo';

  @override
  String get plannedTotalLabel => 'Isamba esihleliwe';

  @override
  String get actualTotalLabel => 'Isamba sangempela';

  @override
  String get varianceLabel => 'Umehluko';

  @override
  String get varianceNotComputable => 'Ayikwazi ukubalwa';

  @override
  String get budgetStatusLabel => 'Isabelomali';

  @override
  String get savingsLabel => 'Ngaphansi kohlelo';

  @override
  String get overspendLabel => 'Ngaphezulu kohlelo';

  @override
  String get unplannedTotalLabel => 'Isamba sezinto ezingahleliwe';

  @override
  String get unpurchasedLabel => 'Kuhlelwe kodwa akuthengwa';

  @override
  String get totalDiscountLabel => 'Isamba sokuhluliswa kwemali';

  @override
  String get accuracyLabel => 'Ukunemba kokulinganisa';

  @override
  String get groupsSection => 'Izinto';

  @override
  String get groupPricier => 'Yabiza kunohlelo';

  @override
  String get groupCheaper => 'Yabiha kunohlelo';

  @override
  String get groupClose => 'Sondelene nokulinganisa';

  @override
  String get groupNotTaken => 'Kuhlelwe, akuthengwa';

  @override
  String get groupUnplanned => 'Kuthengwe ngaphandle kohlelo';

  @override
  String get groupQuantityChanged => 'Ubuningi butshintshiwe';

  @override
  String get groupUnverified => 'Akukhulunywe';

  @override
  String get plannedQtyLabel => 'Ubuningi obuhleliwe';

  @override
  String get actualQtyLabel => 'Ubuningi bangempela';

  @override
  String get plannedUnitPriceLabel => 'Ixabiso leyunithi elihleliwe';

  @override
  String get actualUnitPriceLabel => 'Ixabiso leyunithi langempela';

  @override
  String get lineVarianceLabel => 'Umehluko womugqa';

  @override
  String get discountEffectLabel => 'Umthelela wokuhluliswa kwemali';

  @override
  String get notBoughtMark => 'akuthengwa';

  @override
  String get noPurchasesNote => 'Akukho ukuthenga okurekhodiwe.';

  @override
  String get navHome => 'Ekhaya';

  @override
  String get navLists => 'Amalisti';

  @override
  String get navHistory => 'Umlando';

  @override
  String get navSettings => 'Izilungiselelo';

  @override
  String get homeEmptyTitle => 'Hlela ukuthenga kwakho';

  @override
  String get homeEmptyBody =>
      'Dala ulisti lwakho lokuqala bese uqhathanisa izindleko ezicwangciwe nezangempela.';

  @override
  String get homeActiveSection => 'Amalisti asebenzayo';

  @override
  String get homeCompletedSection => 'Aqedwe ncamashi';

  @override
  String get homeMonthlySection => 'Linyanga';

  @override
  String get monthPlannedLabel => 'Kucwangcisiwe';

  @override
  String get monthActualLabel => 'Kwenziwe';

  @override
  String get monthVarianceLabel => 'Umehluko';

  @override
  String get continueShoppingLabel => 'Qhubeka ukuthenga';

  @override
  String get historyEmpty =>
      'Akukho ukuthenga okuphelile okwamanje. Umlando wakho nolwazi luzovela lapha.';

  @override
  String get aboutTabTitle => 'Mayelana noNShoptor';

  @override
  String get aboutBody =>
      'NShoptor nguCrazy Penguin. Uhlelo lokuhlela ukuthenga olusekelwe ku-offline. Luvinjiwe ngaphansi kwe-GPL-3.0.';

  @override
  String get startShoppingLabel => 'Qala ukuthenga';

  @override
  String get finishAndSeeResult => 'Gcina & bona umphumela';

  @override
  String get settingsTitle => 'Izilungiselelo';

  @override
  String get languageLabel => 'Ulimi';

  @override
  String get languageSystem => 'Uhlelo';

  @override
  String get languageTr => 'IsiTurkish';

  @override
  String get languageEn => 'IsiNgisi';

  @override
  String get themeLabel => 'Imboniselo';

  @override
  String get themeSystem => 'Uhlelo';

  @override
  String get themeLight => 'Okukhanyayo';

  @override
  String get themeDark => 'Okumnyama';

  @override
  String get defaultCurrencyLabel => 'Iyini elingokwesiko';

  @override
  String get defaultUnitLabel => 'Yunithi elingokwesiko';

  @override
  String get keepAwakeLabel =>
      'Gcina isikrini sivulekile ngesikhathi sokuthenga';

  @override
  String get backupSection => 'Isiphambano';

  @override
  String get exportBackupLabel => 'Thumela isiphambano';

  @override
  String get importBackupLabel => 'Faka isiphambano';

  @override
  String get mergeImportLabel => 'Hlanganisa kudatha yangoku';

  @override
  String get separateImportLabel => 'Faka njengesiphiwo esihlukene';

  @override
  String get importCancelled => 'Ukufakwa kwephazamisekile.';

  @override
  String get backupExported => 'Isiphambano sithunyelwe ngempumelelo.';

  @override
  String get backupSizeWarning =>
      'Isiphambano esikhulu: ifayili ingaba nkulu. Ingabe ufuna ukufaka namafoto?';

  @override
  String get deleteAllSection => 'Indawo engozini';

  @override
  String get deleteAllLabel => 'Sula yonke idatha';

  @override
  String get deleteAllConfirm =>
      'Lokhu kususa wonke amalisti, umlando, amafoto emiphumela nezinto ezithengwayo. Amafayili owakhhipha ahlala endaweni yakho yokugcina. Uyaqhubeka?';

  @override
  String get deleteAllConfirm2 =>
      'Uqinisekile ngokuphelele? Lesi senzo asikwazi ukubuyiselwa.';

  @override
  String get cancelAction => 'Khansela';

  @override
  String get confirmDelete => 'Sula unomphela';

  @override
  String get dataDeleted => 'Yonke idatha yasendaweni isusiwe.';

  @override
  String get privacyInfoLabel => 'Ubumfihlo';

  @override
  String get privacyInfoBody =>
      'Amalisti akho, izinto ezithengwayo, imiphumela namafoto ahlala kwidivayisi yakho. Amafoto nezwi azikaze zidlule kuyo. Uma usizo lwe-AI lulungisiwe, kuphela umbhalo (isibonelo imigqa yemiphumela noma lokho okushiwo) lithunyelwa eseva yethu ukuze luprosesiwe futhi alugcinwe.';

  @override
  String get aboutSection => 'Mayelana';

  @override
  String get aboutPublisher => 'Umshicileli: Crazy Penguin';

  @override
  String get aboutLicenses => 'Amalaysensi (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Ukufaka ngezwi';

  @override
  String get voiceStatusUnknown => 'Isevisi: ayikahloliwe';

  @override
  String get permissionsLabel => 'Ivume';

  @override
  String get permissionsBody =>
      'Ikhamela, imayikrofoni nemiyalezo icelwa kuphela uma usebenzisa lezi zincomo.';

  @override
  String get unitsSection => 'Okungokwesiko';

  @override
  String get roundingNote =>
      'Ukuzungeza imali kulandela umthetho omunye: izinombolo ezingaphezulu kwezinguquko ziyazungeziswa, kusetshenziswa kanye ekuguquleni imali.';

  @override
  String get voiceInputTitle => 'Ukufaka ngezwi';

  @override
  String get voiceStartListening => 'Qala ukulalela';

  @override
  String get voiceTranscriptLabel => 'Umbhalo';

  @override
  String get parseAction => 'Phosa';

  @override
  String get receiptReviewTitle => 'Buka umphumela';

  @override
  String get receiptTotal => 'Isamba sesiphawu';

  @override
  String get receiptTotalUnknown => 'Isamba asikwazanga ukusithola';

  @override
  String get receiptDiff => 'Umehluko';

  @override
  String get acceptLine => 'Yamukela umugqa';

  @override
  String get ignoreLine => 'Ingaba umugqa';

  @override
  String get receiptLineActions => 'Hlanganisa kwinto, hlukanisa noma ingaba';

  @override
  String get receiptCommit => 'Yamukela konke';

  @override
  String get receiptCommitted => 'Isiphawu sisebenzisiwe.';

  @override
  String get priceHistoryTitle => 'Umlando wamanani';

  @override
  String get noObservations => 'Akukho amanani abhalwe kakhulu';

  @override
  String get templatesSection => 'Amathemplatesi';

  @override
  String get templateHint =>
      'Dala uhlelo olusha kusuka ekuhambeni lokuthenga okudlule';

  @override
  String get scanReceiptAction => 'Skana isiphawu';

  @override
  String get shelfLabelAction => 'Inani lesikhwama esisibonakalayo';

  @override
  String get priceCandidatesTitle => 'Ochazayo bamanani';

  @override
  String get noPriceCandidates =>
      'Akukho inani litholakele; faka ngokwezandla.';

  @override
  String get voiceUnavailable =>
      'Ukuqonda ulimi akusebenzi; faka ngokwezandla.';

  @override
  String get linkToItem => 'Hlanganisa kwinto';

  @override
  String get splitLine => 'Hlukanisa kube kabili';

  @override
  String get mergeWithNext => 'Hlanganisa nesilandelayo';

  @override
  String get ocrNoText => 'Akukho umbhalo ofunywe; zama futhi.';

  @override
  String get priceHistoryAction => 'Umlando wamanani';

  @override
  String get itemsEmptyTitle => 'Akukho into manje';

  @override
  String get itemsEmptyBody =>
      'Faka into yakho yokuqala — uzofaka amanani angempela lapha esitolo.';

  @override
  String get addItemTooltip => 'Faka into';

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
  String get unitCustom => 'Okukhethekile';

  @override
  String get setReminderAction => 'Setha isikhumbuzi';

  @override
  String get reminderPermissionDenied =>
      'Kudingeka imvume yokwazisa ukuze usebenzise izikhumbuzi. Ungayivula emiyalelweni yesistimu.';

  @override
  String get reminderScheduled => 'Isikhumbuzi sisethiwe.';

  @override
  String get reminderCancelled => 'Isikhumbuzi sisusiwe.';

  @override
  String get reminderTitle => 'Isikhumbuzi sokuthenga';

  @override
  String reminderBody(Object title) {
    return 'Isikhathi sokubheka uhlu lwakho: $title';
  }

  @override
  String get reminderPickDate => 'Khetha usuku';

  @override
  String get reminderPickTime => 'Khetha isikhathi';

  @override
  String get itemDetailsSection => 'Imininingwane';

  @override
  String get priceOptionalHint =>
      'Okungabizi — uzofaka inani langempela esitolo';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Okucwangciswe: $total · $count izinto';
  }

  @override
  String get proActiveLabel => 'Pro active — siyabonga!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Ama-ads awakhona, AI eningi, backup · kusuka kunani elincane nyakenye';

  @override
  String get proBenefitNoAds => 'Ukusetshenziswa ngaphandle kwamapromoshini';

  @override
  String get proBenefitBackup => 'Backup (ukukhipha/faka)';

  @override
  String aboutVersion(Object version) {
    return 'Uhlelo $version';
  }

  @override
  String get navDiscover => 'Thola';

  @override
  String get shareAction => 'Wabelana ngesicelo';

  @override
  String get rateAction => 'Sihlonze';

  @override
  String get aboutOpenRow => 'Mayelana & ivulekile';

  @override
  String get voiceAddItemAction => 'Faka ngezwi';

  @override
  String get formatLocaleLabel => 'Inombolo nendlela yokubala imali';

  @override
  String get formatLocaleSystem => 'Uhlelo (kulandela ulwimi lwesebe)';

  @override
  String get formatLocaleTr => 'IsiTuthuki (1.234,56)';

  @override
  String get formatLocaleEn => 'IsiNgisi (1,234.56)';

  @override
  String get aiToggleTitle => 'Usizo lwe-AI';

  @override
  String get aiToggleSubtitle =>
      'Luhambanisa amarekhodi, lufunda izitika zamanani futhi luguqule izitatimende zibe yizinhlu. Izithombe nezwi kuhlala kwidivayisi yakho; kuphela umbhalo uyaphrosesiwa.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Usebenzise inombolo yemicelo ye-AI yalo nyanga ($used/$limit). Hlenga ukuze uthole okuningi, noma qhubeka ngaphandle kwe-AI.';
  }

  @override
  String get aiOffline => 'Akukho uxhumano — kuqhubeka ngaphandle kwe-AI.';

  @override
  String get aiFailed => 'AI ayitholakali manje — kuqhubeka ngaphandle kwayo.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'Idivayisi';

  @override
  String get quickListAction => 'Engeza kusuka esitatimendeni';

  @override
  String get quickListTitle => 'Uhlu olusheshayo';

  @override
  String get quickListHint =>
      'isib. 1 kg amasangozi 20, ubhuti obungu-2, ikhilogramma engu-hhafu yekhasi';

  @override
  String get quickListConvert => 'Guqule ube yihlu';

  @override
  String quickListAdd(int count) {
    return 'Engeza $count izinto';
  }

  @override
  String get quickListEmpty =>
      'Azikho izinto ezitholiwe. Zama ukuzilista ngokuhlukanisa ngezinkomba.';

  @override
  String get receiptAiMatched =>
      'AI luhambanise irekhodi nohlu lwakho. Hlola amakhonkco futhi uqinisekise.';

  @override
  String get receiptNeedsCheck => 'Hlola lokhu kuhambisana';

  @override
  String get receiptDiscountLine => 'Ukuncipha';

  @override
  String get compareItem => 'Into';

  @override
  String get compareEstimated => 'Bacabange';

  @override
  String get compareActual => 'Kwenziwe';

  @override
  String get compareDiff => 'Umehluko';

  @override
  String get compareTotal => 'Isamba';

  @override
  String get compareBudget => 'Budji';

  @override
  String get compareNotBought => 'akathengwa';

  @override
  String get compareUnplanned => 'akucwangciswanga';

  @override
  String get pricierItems => 'Kudla kabi';

  @override
  String get cheaperItems => 'Kudla kahle';

  @override
  String get compareAction => 'Thelekisa';

  @override
  String get detailsSection => 'Imininingwane';

  @override
  String get spendingTitle => 'Ukusetshenziswa';

  @override
  String get spendingAction => 'Ukusetshenziswa';

  @override
  String get spendingMonthTotal => 'Lo nyaka';

  @override
  String get spendingWeekly => 'Ukusetshenziswa nsuku zonke';

  @override
  String get spendingMonthly => 'Ukusetshenziswa inyanga zonke';

  @override
  String get monthlyLimitTitle => 'Umthetho wenyanga';

  @override
  String get monthlyLimitHelp =>
      'Ufuna ukusebenzisa malini ekuthengeni inyanga zonke?';

  @override
  String get monthlyLimitRemove => 'Susa';

  @override
  String get monthlyLimitSet => 'Setha';

  @override
  String get monthlyLimitChange => 'Shintsha';

  @override
  String get monthlyLimitNone =>
      'Setha umthetho wenyanga ukuze ubone ukuthi ushiye kangakanani.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount ngaphezu komthetho';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return '$amount ushiye lo nyaka';
  }

  @override
  String get plansTitle => 'Amaphrojekthi';

  @override
  String get plansHeadline => 'Thenga ngobuchopho ne-AI';

  @override
  String get plansSubhead =>
      'Ukuhambisana kwamarekhodi, izitika zamanani nezinhlu kusuka esitatimendeni. Khansela noma nini.';

  @override
  String get plansMonthly => 'Ngenyanga';

  @override
  String get plansYearly => 'Nyakenye';

  @override
  String get planFree => 'Mahhala';

  @override
  String get planFreePrice => 'Mahhala unomphela';

  @override
  String get planFreeAi => 'Imicelo ye-AI engu-15 ngenyanga';

  @override
  String get planFreeAds =>
      'Izikhangiso ezincane (azikho ezinsukwini zakho zokuqala ezi-7)';

  @override
  String get planCoreFeatures =>
      'Izinhlu, amanani, amarekhodi, amachati okusetshenziswa';

  @override
  String get plansPerYear => '/ unyaka';

  @override
  String get plansPerMonth => '/ inyanga';

  @override
  String get planTrial => 'Izinsuku ezi-7 mahhala';

  @override
  String get planProAi => 'Imicelo ye-AI engu-200 ngenyanga';

  @override
  String get planNoAds => 'Azikho izikhangiso';

  @override
  String get planBackup => 'Thumela bese ufaka imidwebo';

  @override
  String get planMaxAi => 'Izicelo ze-AI eziyi-1000 ngenyanga';

  @override
  String get planMaxFamily => 'Kokuthenga kwesizini esikhulu';

  @override
  String get plansStoreUnavailable => 'Umbukiso awufinyeleleki manje.';

  @override
  String get retryAction => 'Zama futhi';

  @override
  String get plansPurchaseFailed =>
      'Ukuthengiswa akuphumelelanga. Sicela uzame futhi.';

  @override
  String get planLifetimeTitle =>
      'Ngaphandle kwezibonakaliso kuze kube phakade';

  @override
  String get planLifetimeSubtitle =>
      'Ukukhokha okukodwa: azikho izibonakaliso, ukubuyisa; AI ihlala emkhawulweni wamahhala';

  @override
  String get plansRestore => 'Buyisela ukuthenga';

  @override
  String get plansLegal =>
      'Amabhalo avuselela ngokuzenzakalelayo kuze kuyekiswe. Yeka noma yini ngesikhathi ku-Google Play › Imali nezinkokhelo. Amanani afaka amahlandla aboniswa yi-Google Play.';

  @override
  String get planCurrent => 'Okwamanje';

  @override
  String get planStartTrial => 'Qala isivivinyo samahhala sezinsuku ezingu-7';

  @override
  String get planChoose => 'Khetha';

  @override
  String get plansAction => 'Amabhuku: Pro ne-Max';

  @override
  String get assistantTitle => 'Usizo';

  @override
  String get assistantGreeting => 'Sawubona! Ufuna ukwenzeni?';

  @override
  String get assistantNewList => 'Uhlu olusha';

  @override
  String get assistantVoiceList => 'Uhlu ngezwi';

  @override
  String get assistantTextList => 'Uhlu kusuka esitatimendeni';

  @override
  String get assistantScanReceipt => 'Skana ireceipt';

  @override
  String get assistantSpending => 'Ukusetshenziswa kwami';

  @override
  String get assistantReceiptHint =>
      'Vula uhlu lwakho bese ucinca ikhono le-receipt ukuze usikane.';

  @override
  String get assistantToggleTitle => 'Bonisa usizo';

  @override
  String get assistantToggleSubtitle =>
      'Umncintisana omncane ohlangothini lwasekunene';

  @override
  String get scanPriceLabel => 'Skana isikhwama somanani';
}
