// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swahili (`sw`).
class AppLocalizationsSw extends AppLocalizations {
  AppLocalizationsSw([String locale = 'sw']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Panga nyumbani. Fanya ununuzi kama ulivyopanga.';

  @override
  String get listsTitle => 'Orodha';

  @override
  String get listsTabActive => 'Inatumika';

  @override
  String get listsTabCompleted => 'Imekamilika';

  @override
  String get listsTabArchived => 'Imehifadhiwa';

  @override
  String get newListButton => 'Orodha mpya';

  @override
  String get listTitleHint => 'Kichwa (si lazima)';

  @override
  String get saveButton => 'Hifadhi';

  @override
  String get cancelButton => 'Ghairi';

  @override
  String get deleteButton => 'Futa';

  @override
  String get editAction => 'Hariri';

  @override
  String get listDeleted => 'Orodha imefutwa';

  @override
  String get invalidAmountError => 'Kiasi si sahihi';

  @override
  String get duplicateAction => 'Nakili';

  @override
  String get archiveAction => 'Hifadhi';

  @override
  String get unarchiveAction => 'Toa kwenye hifadhi';

  @override
  String get deleteListConfirm =>
      'Unataka kufuta orodha hii? Vitu vilivyopangwa pia vitafutwa.';

  @override
  String get undoButton => 'Rudisha';

  @override
  String get searchListHint => 'Tafuta orodha';

  @override
  String get currencyLabel => 'Fedha';

  @override
  String get budgetLabel => 'Bajeti (si lazima)';

  @override
  String get noteLabel => 'Kumbukumbu (si lazima)';

  @override
  String get storeLabel => 'Duka';

  @override
  String get keepAmountsAction => 'Weka kiasi vilevile';

  @override
  String get resetAmountsAction => 'Weka upya kiasi';

  @override
  String get currencyChangeWarning =>
      'Fedha inabadilika. Kiasi kilicho wapi sasa?';

  @override
  String get listsEmpty =>
      'Hakuna orodha bado. Tengeneza mpango wako wa kwanza wa kununua.';

  @override
  String get statusDraft => 'Rasimu';

  @override
  String get statusPlanned => 'Imepangwa';

  @override
  String get statusShopping => 'Inanunuliwa';

  @override
  String get statusCompleted => 'Imekamilika';

  @override
  String get statusArchived => 'Imehifadhiwa';

  @override
  String autoListTitle(String date) {
    return 'Ununuzi wa $date';
  }

  @override
  String get itemFormTitle => 'Ongeza kitu';

  @override
  String get itemNameLabel => 'Jina la kitu';

  @override
  String get brandLabel => 'Chapa / aina (si lazima)';

  @override
  String get categoryLabel => 'Kategoria';

  @override
  String get quantityLabel => 'Kiasi';

  @override
  String get unitLabel => 'Kitengo';

  @override
  String get pricingModeLabel => 'Namna ya kuingiza bei';

  @override
  String get pricingModeUnitPrice => 'Bei kwa kitengo';

  @override
  String get pricingModeLineTotal => 'Jumla ya mstari';

  @override
  String get plannedPriceLabel => 'Bei iliyopangwa';

  @override
  String lineTotalCalculated(String value) {
    return 'Jumla ya mstari: $value';
  }

  @override
  String get requiredItemToggle => 'Kitu kinachohitajika';

  @override
  String get maxPriceLabel => 'Bei ya juu inayokubalika (si lazima)';

  @override
  String get itemNoteLabel => 'Kumbukumbu (si lazima)';

  @override
  String get categoryProduce => 'Matunda na mboga';

  @override
  String get categoryDairy => 'Bidhaa za maziwa';

  @override
  String get categoryMeat => 'Nyama';

  @override
  String get categoryBakery => 'Vitaaji';

  @override
  String get categoryDrinks => 'Vyovyote';

  @override
  String get categoryCleaning => 'Usafi';

  @override
  String get categoryPersonalCare => 'Ulinzi wa kibinafsi';

  @override
  String get categoryHome => 'Nyumba';

  @override
  String get categoryOther => 'Nyingine';

  @override
  String get invalidQuantityError => 'Kiasi si sahihi';

  @override
  String get invalidPriceError => 'Bei si sahihi';

  @override
  String get invalidNameError => 'Ingiza jina';

  @override
  String unitPriceCalculated(String value) {
    return 'Bei ya kitengo: $value';
  }

  @override
  String get shoppingTitle => 'Hali ya kununua';

  @override
  String get summaryPlannedTotal => 'Ilipangwa';

  @override
  String get summaryInCart => 'Kwenye kikapu';

  @override
  String get summaryRemainingPlan => 'Mpango uliobaki';

  @override
  String get summaryProjected => 'Makadirio ya malipo';

  @override
  String get summaryBudgetRemaining => 'Bajeti iliyobaki';

  @override
  String get summaryBudgetOver => 'Zaidi ya bajeti';

  @override
  String itemsProgress(String done, String total) {
    return '$done kati ya $total vitu';
  }

  @override
  String get filterAll => 'Vyote';

  @override
  String get filterToBuy => 'Vya kununua';

  @override
  String get filterInCart => 'Kwenye kikapu';

  @override
  String get filterNotFound => 'Haimepatikana';

  @override
  String get filterRequired => 'Vinahitajika';

  @override
  String get quickEntryTitle => 'Bei halisi';

  @override
  String get actualQuantityLabel => 'Kiasi halisi';

  @override
  String get actualPriceLabel => 'Bei halisi';

  @override
  String get discountLabel => 'Punguzo (si lazima)';

  @override
  String get alternativeNameLabel => 'Jina la bidhaa mbadala (si lazima)';

  @override
  String get savePurchaseButton => 'Ongeza kwenye kikapu';

  @override
  String get unplannedAddButton => 'Ongeza bidhaa isiyo na mpango';

  @override
  String get statusPending => 'Haijachukuliwa';

  @override
  String get statusInCart => 'Kwenye kikapu';

  @override
  String get statusNotFound => 'Haimepatikana';

  @override
  String get statusGaveUp => 'Imekata tamaa';

  @override
  String get statusAlternative => 'Mbadala ununuliwa';

  @override
  String get keepScreenAwake => 'Eyesha skrini';

  @override
  String get finishShopping => 'Maliza kununua';

  @override
  String get completionWarning =>
      'Kuna rekodi zilizopotea au ambazo hazijathibitishwa. Bado unaweza kumaliza; matokeo yataziba hali hiyo.';

  @override
  String get continueShoppingButton => 'Endelea kununua';

  @override
  String get resultTitle => 'Matokeo';

  @override
  String get summarySection => 'Muhtasari';

  @override
  String get plannedTotalLabel => 'Jumla iliyopangwa';

  @override
  String get actualTotalLabel => 'Jumla halisi';

  @override
  String get varianceLabel => 'Tofauti';

  @override
  String get varianceNotComputable => 'Haiwezi kuhesabiwa';

  @override
  String get budgetStatusLabel => 'Bajeti';

  @override
  String get savingsLabel => 'Chini ya mpango';

  @override
  String get overspendLabel => 'Zaidi ya mpango';

  @override
  String get unplannedTotalLabel => 'Jumla ya bila mpango';

  @override
  String get unpurchasedLabel => 'Iliyopangwa lakini haimeununuliwa';

  @override
  String get totalDiscountLabel => 'Jumla ya punguzo';

  @override
  String get accuracyLabel => 'Usahihi wa makadirio';

  @override
  String get groupsSection => 'Vitu';

  @override
  String get groupPricier => 'Ghali kuliko ilivyopangwa';

  @override
  String get groupCheaper => 'Nafuu kuliko ilivyopangwa';

  @override
  String get groupClose => 'Karibu na makadirio';

  @override
  String get groupNotTaken => 'Iliyopangwa, haimeununuliwa';

  @override
  String get groupUnplanned => 'Imenunuliwa bila mpango';

  @override
  String get groupQuantityChanged => 'Kiasi kimebadilika';

  @override
  String get groupUnverified => 'Haijathibitishwa';

  @override
  String get plannedQtyLabel => 'Kiasi kilichopangwa';

  @override
  String get actualQtyLabel => 'Kiasi halisi';

  @override
  String get plannedUnitPriceLabel => 'Bei ya kitengo kilichopangwa';

  @override
  String get actualUnitPriceLabel => 'Bei ya kitengo halisi';

  @override
  String get lineVarianceLabel => 'Tofauti ya mstari';

  @override
  String get discountEffectLabel => 'Athari ya punguzo';

  @override
  String get notBoughtMark => 'haimeununuliwa';

  @override
  String get noPurchasesNote => 'Hakuna manunuzi yaliorekodiwa.';

  @override
  String get navHome => 'Nyumbani';

  @override
  String get navLists => 'Orodha';

  @override
  String get navHistory => 'Historia';

  @override
  String get navSettings => 'Mipangilio';

  @override
  String get homeEmptyTitle => 'Panga ununuzi wako';

  @override
  String get homeEmptyBody =>
      'Unda orodha yako ya kwanza na ulinganishe gharama zilizopangwa na halisi.';

  @override
  String get homeActiveSection => 'Orodha zinazofanya kazi';

  @override
  String get homeCompletedSection => 'Zilizokamilishwa hivi karibuni';

  @override
  String get homeMonthlySection => 'Mwezi huu';

  @override
  String get monthPlannedLabel => 'Imepangwa';

  @override
  String get monthActualLabel => 'Halisi';

  @override
  String get monthVarianceLabel => 'Tofauti';

  @override
  String get continueShoppingLabel => 'Endelea kununua';

  @override
  String get historyEmpty =>
      'Hakuna ununuzi uliokamilishwa bado. Historia na uchambuzi wako utaonekana hapa.';

  @override
  String get aboutTabTitle => 'Kuhusu NShoptor';

  @override
  String get aboutBody =>
      'NShoptor na Crazy Penguin. Mpangaji wa ununuzi unaofanya kazi nje ya mtandao. Imelindwa chini ya GPL-3.0.';

  @override
  String get startShoppingLabel => 'Anza kununua';

  @override
  String get finishAndSeeResult => 'Maliza na uone matokeo';

  @override
  String get settingsTitle => 'Mipangilio';

  @override
  String get languageLabel => 'Lugha';

  @override
  String get languageSystem => 'Mfumo';

  @override
  String get languageTr => 'Kituruki';

  @override
  String get languageEn => 'Kiingereza';

  @override
  String get themeLabel => 'Muonekano';

  @override
  String get themeSystem => 'Mfumo';

  @override
  String get themeLight => 'Nuru';

  @override
  String get themeDark => 'Giza';

  @override
  String get defaultCurrencyLabel => 'Sarufi ya kawaida';

  @override
  String get defaultUnitLabel => 'Kitengo cha kawaida';

  @override
  String get keepAwakeLabel => 'Weka skrini ikiwazi wakati wa kununua';

  @override
  String get backupSection => 'Hifadhi ya salama';

  @override
  String get exportBackupLabel => 'Toa hifadhi ya salama';

  @override
  String get importBackupLabel => 'Ingiza hifadhi ya salama';

  @override
  String get mergeImportLabel => 'Unganisha kwenye data ya sasa';

  @override
  String get separateImportLabel => 'Ingiza kama nakala tofauti';

  @override
  String get importCancelled => 'Uingizaji ulighairiwa.';

  @override
  String get backupExported => 'Hifadhi ya salama imepatikana kwa mafanikio.';

  @override
  String get backupSizeWarning =>
      'Hifadhi kubwa: faili inaweza kuwa kubwa. Je, unataka kujumuisha picha pia?';

  @override
  String get deleteAllSection => 'Eneo la hatari';

  @override
  String get deleteAllLabel => 'Futa data yote';

  @override
  String get deleteAllConfirm =>
      'Hii itaondoa orodha zote, historia, picha za risiti na bei. Faili ulizotoa zitabaki kwenye disk yako. Unaendelea?';

  @override
  String get deleteAllConfirm2 =>
      'Je, una uhakika kabisa? Hatua hii haiwezi kurejeshwa.';

  @override
  String get cancelAction => 'Ghairi';

  @override
  String get confirmDelete => 'Futa kabisa';

  @override
  String get dataDeleted => 'Data yote ya ndani ilifutwa.';

  @override
  String get privacyInfoLabel => 'Faragha';

  @override
  String get privacyInfoBody =>
      'Orodha zako, bei, risiti na picha zinaendelea kuwa kwenye kifaa chako. Picha na sauti haziondoki kamwe. Wakati msaada wa AI umewashwa, tu maandishi (kwa mfano mistari ya risiti au uliyosema) hutumwa kwenye seva yetu kuchakatwa na hayahifadhiwa.';

  @override
  String get aboutSection => 'Kuhusu';

  @override
  String get aboutPublisher => 'Mchapishaji: Crazy Penguin';

  @override
  String get aboutLicenses => 'Leseni (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Ingizo la sauti';

  @override
  String get voiceStatusUnknown => 'Huduma: haimeangaliwa';

  @override
  String get permissionsLabel => 'Ruhusa';

  @override
  String get permissionsBody =>
      'Kamera, mikrofonu na arifa zinatakiwa tu wakati unatumia vipengele hivyo.';

  @override
  String get unitsSection => 'Chaguomsingi';

  @override
  String get roundingNote =>
      'Kuzungusha pesa kunafuata sheria moja: nusu huzungushwa mbali na sifuri, kutumika mara moja katika ubadilishaji wa Pesha.';

  @override
  String get voiceInputTitle => 'Ingizo la sauti';

  @override
  String get voiceStartListening => 'Anza kusikiliza';

  @override
  String get voiceTranscriptLabel => 'Maandishi';

  @override
  String get parseAction => 'Changanua';

  @override
  String get receiptReviewTitle => 'Angalia risiti';

  @override
  String get receiptTotal => 'Jumla ya risiti';

  @override
  String get receiptTotalUnknown => 'Jumla haimeonekana';

  @override
  String get receiptDiff => 'Tofauti';

  @override
  String get acceptLine => 'Kubali mstari';

  @override
  String get ignoreLine => 'Puuza mstari';

  @override
  String get receiptLineActions => 'Unganisha na bidhaa, gawanya au puuza';

  @override
  String get receiptCommit => 'Kubali yote';

  @override
  String get receiptCommitted => 'Risiti imetumika.';

  @override
  String get priceHistoryTitle => 'Historia ya bei';

  @override
  String get noObservations => 'Hakuna uchunguzi wa bei bado';

  @override
  String get templatesSection => 'Mifano';

  @override
  String get templateHint =>
      'Unda mpango mpya kutoka kwa safari ya mapagazi iliyopita';

  @override
  String get scanReceiptAction => 'Skeni risiti';

  @override
  String get shelfLabelAction => 'Bei kutoka kwenye lebo ya rafu';

  @override
  String get priceCandidatesTitle => 'Wadaiwa wa bei';

  @override
  String get noPriceCandidates => 'Bei haitapatikana; weka kwa mkono.';

  @override
  String get voiceUnavailable =>
      'Utambuzi wa sauti haupatikani; weka kwa mkono.';

  @override
  String get linkToItem => 'Unganisha na bidhaa';

  @override
  String get splitLine => 'Gawanya kuwa mbili';

  @override
  String get mergeWithNext => 'Kuunganisha na inayofuata';

  @override
  String get ocrNoText => 'Hakuna maandishi yaliyosomwa; jaribu tena.';

  @override
  String get priceHistoryAction => 'Historia ya bei';

  @override
  String get itemsEmptyTitle => 'Hakuna bidhaa bado';

  @override
  String get itemsEmptyBody =>
      'Ongeza bidhaa yako ya kwanza — utaweka bei halisi hapa duka.';

  @override
  String get addItemTooltip => 'Ongeza bidhaa';

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
  String get unitCustom => 'Ya kawaida';

  @override
  String get setReminderAction => 'Weka kukumbusho';

  @override
  String get reminderPermissionDenied =>
      'Ruhusa ya arifa inahitajika kwa kukumbusho. Unaweza kuwezesha katika mipangilio ya mfumo.';

  @override
  String get reminderScheduled => 'Kukumbusho kumewekwa.';

  @override
  String get reminderCancelled => 'Kukumbusho kumeondolewa.';

  @override
  String get reminderTitle => 'Kukumbusho kwa mapagazi';

  @override
  String reminderBody(Object title) {
    return 'Ni wakati wa kuangalia orodha yako: $title';
  }

  @override
  String get reminderPickDate => 'Chagua tarehe';

  @override
  String get reminderPickTime => 'Chagua saa';

  @override
  String get itemDetailsSection => 'Maelezo';

  @override
  String get priceOptionalHint => 'Hiari — utaweka bei halisi duka';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Ilipangwa: $total · Bidhaa $count';
  }

  @override
  String get proActiveLabel => 'Pro imeamilishwa — asante!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Bila matangazo, AI zaidi, nakala · kutoka bei ndogo ya kila mwezi';

  @override
  String get proBenefitNoAds => 'Uzoefu bila matangazo';

  @override
  String get proBenefitBackup => 'Nakala (eksport/import)';

  @override
  String aboutVersion(Object version) {
    return 'Toleo $version';
  }

  @override
  String get navDiscover => 'Gundua';

  @override
  String get shareAction => 'Shiriki programu';

  @override
  String get rateAction => 'Tupatie tathmini';

  @override
  String get aboutOpenRow => 'Kuhusu & chanzo wazi';

  @override
  String get voiceAddItemAction => 'Ongeza kwa sauti';

  @override
  String get formatLocaleLabel => 'Namba na muundo wa sarafu';

  @override
  String get formatLocaleSystem => 'Mfumo (ufuatie lugha ya programu)';

  @override
  String get formatLocaleTr => 'Kituruki (1.234,56)';

  @override
  String get formatLocaleEn => 'Kiingereza (1,234.56)';

  @override
  String get aiToggleTitle => 'Msaada wa AI';

  @override
  String get aiToggleSubtitle =>
      'Inalinganisha risiti, inasoma lebo za bei na kubadilisha sentensi kuwa orodha. Picha na sauti zinaendelea kwenye kifaa chako; tu maandishi yanachakatwa.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Umekitumia kipindi cha mwezi huu cha maombi ya AI ($used/$limit). Ongeza mpango ili kupata zaidi, au endelea bila AI.';
  }

  @override
  String get aiOffline => 'Hakuna muunganisho — inaendelea bila AI.';

  @override
  String get aiFailed => 'AI haipatikani sasa — inaendelea bila yake.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'Kifaa';

  @override
  String get quickListAction => 'Ongeza kutoka sentensi';

  @override
  String get quickListTitle => 'Orodha ya haraka';

  @override
  String get quickListHint =>
      'k.m. 1 kg matunda 20, 2 mkate, nusu kilo ya jibini';

  @override
  String get quickListConvert => 'Badilisha kuwa orodha';

  @override
  String quickListAdd(int count) {
    return 'Ongeza vitu $count';
  }

  @override
  String get quickListEmpty =>
      'Hakuna vitu vilivyopatikana. Jaribu kuorodhesha kwa kutumia komma.';

  @override
  String get receiptAiMatched =>
      'AI ililinganisha risiti na orodha yako. Angalia viungo na thibitisha.';

  @override
  String get receiptNeedsCheck => 'Angalia ulinganishaji huu';

  @override
  String get receiptDiscountLine => 'Punguzo';

  @override
  String get compareItem => 'Bidhaa';

  @override
  String get compareEstimated => 'Tathmini';

  @override
  String get compareActual => 'Halisi';

  @override
  String get compareDiff => 'Tofauti';

  @override
  String get compareTotal => 'Jumla';

  @override
  String get compareBudget => 'Bajeti';

  @override
  String get compareNotBought => 'haukununuliwa';

  @override
  String get compareUnplanned => 'hapangwiwahi';

  @override
  String get pricierItems => 'Zimegharimu zaidi';

  @override
  String get cheaperItems => 'Zimegharimu kidogo';

  @override
  String get compareAction => 'Linganisha';

  @override
  String get detailsSection => 'Maelezo';

  @override
  String get spendingTitle => 'Matumizi';

  @override
  String get spendingAction => 'Matumizi';

  @override
  String get spendingMonthTotal => 'Mwezi huu';

  @override
  String get spendingWeekly => 'Matumizi ya wiki';

  @override
  String get spendingMonthly => 'Matumizi ya mwezi';

  @override
  String get monthlyLimitTitle => 'Kikomo cha mwezi';

  @override
  String get monthlyLimitHelp =>
      'Unataka kutumia kiasi gani kwa malazi ya kununua kwa mwezi?';

  @override
  String get monthlyLimitRemove => 'Ondoa';

  @override
  String get monthlyLimitSet => 'Weka';

  @override
  String get monthlyLimitChange => 'Badilisha';

  @override
  String get monthlyLimitNone =>
      'Weka kikomo cha mwezi ili kuona kiasi kilichobaki.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount zaidi ya kikomo';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return '$amount zimesalia mwezi huu';
  }

  @override
  String get plansTitle => 'Mpango';

  @override
  String get plansHeadline => 'Nunua kwa akili na AI';

  @override
  String get plansSubhead =>
      'Ulinganishaji wa risiti, lebo za bei na orodha kutoka sentensi. Ghairi wakati wowote.';

  @override
  String get plansMonthly => 'Mwezi';

  @override
  String get plansYearly => 'Mwaka';

  @override
  String get planFree => 'Bure';

  @override
  String get planFreePrice => 'Bure milele';

  @override
  String get planFreeAi => 'Maombi 15 ya AI kwa mwezi';

  @override
  String get planFreeAds =>
      'Matamko madogo ya bango (hakuna katika siku zako za kwanza 7)';

  @override
  String get planCoreFeatures => 'Orodha, bei, risiti, michoro ya matumizi';

  @override
  String get plansPerYear => '/ mwaka';

  @override
  String get plansPerMonth => '/ mwezi';

  @override
  String get planTrial => 'Siku 7 bure';

  @override
  String get planProAi => 'Maombi 200 ya AI kwa mwezi';

  @override
  String get planNoAds => 'Hakuna matamko';

  @override
  String get planBackup => 'Hifadhi na uingize nje';

  @override
  String get planMaxAi => 'Maombi 1000 ya AI kwa mwezi';

  @override
  String get planMaxFamily => 'Kwa ununuzi wa familia kubwa';

  @override
  String get plansStoreUnavailable => 'Duka halipatikani sasa hivi.';

  @override
  String get retryAction => 'Jaribu tena';

  @override
  String get plansPurchaseFailed =>
      'Ununuzi haukumalizika. Tafadhali jaribu tena.';

  @override
  String get planLifetimeTitle => 'Bila matangazo maishani yote';

  @override
  String get planLifetimeSubtitle =>
      'Malipo ya mara moja: bila matangazo, hifadhi; AI inaendelea na idhini ya bure';

  @override
  String get plansRestore => 'Rudisha ununuzi';

  @override
  String get plansLegal =>
      'Usajili unajiuzia kiotomatiki hadi utughushe. Ghushi wakati wowote katika Google Play › Malipo na usajili. Bei zinajumuisha kodi zilizonyeshwa na Google Play.';

  @override
  String get planCurrent => 'Sasa';

  @override
  String get planStartTrial => 'Anza majaribio ya bure ya siku 7';

  @override
  String get planChoose => 'Chagua';

  @override
  String get plansAction => 'Mpango: Pro na Max';

  @override
  String get assistantTitle => 'Msaidizi';

  @override
  String get assistantGreeting => 'Habari! Unataka kufanya nini?';

  @override
  String get assistantNewList => 'Orodha mpya';

  @override
  String get assistantVoiceList => 'Orodha kwa sauti';

  @override
  String get assistantTextList => 'Orodha kutoka sentensi';

  @override
  String get assistantScanReceipt => 'Piga picha ya risiti';

  @override
  String get assistantSpending => 'Matumizi yangu';

  @override
  String get assistantReceiptHint =>
      'Fungua orodha yako na bonyeza ikoni ya risiti ili kupiga picha.';

  @override
  String get assistantToggleTitle => 'Onyesha msaidizi';

  @override
  String get assistantToggleSubtitle => 'Msisitizo mdogo upande wa chini kulia';
}
