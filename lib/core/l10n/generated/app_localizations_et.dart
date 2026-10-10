// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Estonian (`et`).
class AppLocalizationsEt extends AppLocalizations {
  AppLocalizationsEt([String locale = 'et']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Planeeri kodus. Osta plaanipäraselt.';

  @override
  String get listsTitle => 'Loendid';

  @override
  String get listsTabActive => 'Aktiivsed';

  @override
  String get listsTabCompleted => 'Valminud';

  @override
  String get listsTabArchived => 'Arhiiv';

  @override
  String get newListButton => 'Uus loend';

  @override
  String get listTitleHint => 'Pealkiri (valikuline)';

  @override
  String get saveButton => 'Salvesta';

  @override
  String get cancelButton => 'Tühista';

  @override
  String get deleteButton => 'Kustuta';

  @override
  String get editAction => 'Muuda';

  @override
  String get listDeleted => 'Loend kustutatud';

  @override
  String get invalidAmountError => 'Vigane summa';

  @override
  String get duplicateAction => 'Klooni';

  @override
  String get archiveAction => 'Arhiveeri';

  @override
  String get unarchiveAction => 'Eemalda arhiivist';

  @override
  String get deleteListConfirm =>
      'Kas kustutad selle loendi? Ka planeeritud kaubad eemaldatakse.';

  @override
  String get undoButton => 'Võta tagasi';

  @override
  String get searchListHint => 'Otsi loendeid';

  @override
  String get currencyLabel => 'Valuuta';

  @override
  String get budgetLabel => 'Eelarve (valikuline)';

  @override
  String get noteLabel => 'Märkus (valikuline)';

  @override
  String get storeLabel => 'Pood';

  @override
  String get keepAmountsAction => 'Säilita kogused';

  @override
  String get resetAmountsAction => 'Lähtesta kogused';

  @override
  String get currencyChangeWarning =>
      'Valuuta muutub. Mis juhtub olemasolevate kogustega?';

  @override
  String get listsEmpty => 'Loendeid pole veel. Loo oma esimene ostuplaan.';

  @override
  String get statusDraft => 'Mustand';

  @override
  String get statusPlanned => 'Planeeritud';

  @override
  String get statusShopping => 'Ostetav';

  @override
  String get statusCompleted => 'Valmis';

  @override
  String get statusArchived => 'Arhiivis';

  @override
  String autoListTitle(String date) {
    return '$date ostud';
  }

  @override
  String get itemFormTitle => 'Lisa toode';

  @override
  String get itemNameLabel => 'Toote nimi';

  @override
  String get brandLabel => 'Bränd / variant (valikuline)';

  @override
  String get categoryLabel => 'Kategooria';

  @override
  String get quantityLabel => 'Kogus';

  @override
  String get unitLabel => 'Ühik';

  @override
  String get pricingModeLabel => 'Hinna sisestamine';

  @override
  String get pricingModeUnitPrice => 'Ühiku hind';

  @override
  String get pricingModeLineTotal => 'Rida kokku';

  @override
  String get plannedPriceLabel => 'Planeeritud hind';

  @override
  String lineTotalCalculated(String value) {
    return 'Rida kokku: $value';
  }

  @override
  String get requiredItemToggle => 'Nõutav toode';

  @override
  String get maxPriceLabel => 'Maksimaalne aktsepteeritav hind (valikuline)';

  @override
  String get itemNoteLabel => 'Märkus (valikuline)';

  @override
  String get categoryProduce => 'Puuviljad ja köögiviljad';

  @override
  String get categoryDairy => 'Piimatooted';

  @override
  String get categoryMeat => 'Liha';

  @override
  String get categoryBakery => 'Pagari';

  @override
  String get categoryDrinks => 'Joogid';

  @override
  String get categoryCleaning => 'Puhastusvahendid';

  @override
  String get categoryPersonalCare => 'Isiklik hügieen';

  @override
  String get categoryHome => 'Kodu';

  @override
  String get categoryOther => 'Muu';

  @override
  String get invalidQuantityError => 'Vigane kogus';

  @override
  String get invalidPriceError => 'Vigane hind';

  @override
  String get invalidNameError => 'Sisesta nimi';

  @override
  String unitPriceCalculated(String value) {
    return 'Ühikhind: $value';
  }

  @override
  String get shoppingTitle => 'Osturežiim';

  @override
  String get summaryPlannedTotal => 'Planeeritud';

  @override
  String get summaryInCart => 'Korvis';

  @override
  String get summaryRemainingPlan => 'Järelejäänud plaan';

  @override
  String get summaryProjected => 'Eeldatav kassa';

  @override
  String get summaryBudgetRemaining => 'Eelarve järele';

  @override
  String get summaryBudgetOver => 'Eelarve ületatud';

  @override
  String itemsProgress(String done, String total) {
    return '$done / $total toodet';
  }

  @override
  String get filterAll => 'Kõik';

  @override
  String get filterToBuy => 'Ostetavad';

  @override
  String get filterInCart => 'Korvis';

  @override
  String get filterNotFound => 'Pole leitud';

  @override
  String get filterRequired => 'Vajalikud';

  @override
  String get quickEntryTitle => 'Tegelik hind';

  @override
  String get actualQuantityLabel => 'Tegelik kogus';

  @override
  String get actualPriceLabel => 'Tegelik hind';

  @override
  String get discountLabel => 'Soodustus (valikuline)';

  @override
  String get alternativeNameLabel => 'Alternatiivse toote nimi (valikuline)';

  @override
  String get savePurchaseButton => 'Lisa korvi';

  @override
  String get unplannedAddButton => 'Lisa planeerimata toode';

  @override
  String get statusPending => 'Märkamata';

  @override
  String get statusInCart => 'Korvis';

  @override
  String get statusNotFound => 'Pole leitud';

  @override
  String get statusGaveUp => 'Loobuti';

  @override
  String get statusAlternative => 'Ostetud alternatiiv';

  @override
  String get keepScreenAwake => 'Hoia ekraani sees';

  @override
  String get finishShopping => 'Lõpeta ostlemine';

  @override
  String get completionWarning =>
      'Puudub või on kinnitamata kirjeid. Saad siiski lõpetada; tulemuses märgitakse need.';

  @override
  String get continueShoppingButton => 'Jätka ostlemist';

  @override
  String get resultTitle => 'Tulemus';

  @override
  String get summarySection => 'Kokkuvõte';

  @override
  String get plannedTotalLabel => 'Planeeritud kogusumma';

  @override
  String get actualTotalLabel => 'Tegelik kogusumma';

  @override
  String get varianceLabel => 'Vahe';

  @override
  String get varianceNotComputable => 'Ei ole arvutatav';

  @override
  String get budgetStatusLabel => 'Eelarve';

  @override
  String get savingsLabel => 'Plaani all';

  @override
  String get overspendLabel => 'Plaani ületanud';

  @override
  String get unplannedTotalLabel => 'Planeerimata kogusumma';

  @override
  String get unpurchasedLabel => 'Planeeritud, kuid ostmata';

  @override
  String get totalDiscountLabel => 'Soodustuste summa';

  @override
  String get accuracyLabel => 'Hinde täpsus';

  @override
  String get groupsSection => 'Tooted';

  @override
  String get groupPricier => ' kallim kui planeeritud';

  @override
  String get groupCheaper => ' odavam kui planeeritud';

  @override
  String get groupClose => 'Hinnanguga sarnane';

  @override
  String get groupNotTaken => 'Planeeritud, ostmata';

  @override
  String get groupUnplanned => 'Ostetud ilma plaanita';

  @override
  String get groupQuantityChanged => 'Kogus muutunud';

  @override
  String get groupUnverified => 'Kinnitamata';

  @override
  String get plannedQtyLabel => 'Planeeritud kogus';

  @override
  String get actualQtyLabel => 'Tegelik kogus';

  @override
  String get plannedUnitPriceLabel => 'Planeeritud ühikhind';

  @override
  String get actualUnitPriceLabel => 'Tegelik ühikhind';

  @override
  String get lineVarianceLabel => 'Rea vahe';

  @override
  String get discountEffectLabel => 'Soodustuse mõju';

  @override
  String get notBoughtMark => 'ostmata';

  @override
  String get noPurchasesNote => 'Ostude andmeid ei salvestatud.';

  @override
  String get navHome => 'Avaleht';

  @override
  String get navLists => 'Nimekirjad';

  @override
  String get navHistory => 'Ajalugu';

  @override
  String get navSettings => 'Seaded';

  @override
  String get homeEmptyTitle => 'Planeeri ostud';

  @override
  String get homeEmptyBody =>
      'Loo oma esimene nimekiri ja võrdle planeeritud tegelike kuludega.';

  @override
  String get homeActiveSection => 'Aktiivsed nimekirjad';

  @override
  String get homeCompletedSection => 'Hiljuni valminud';

  @override
  String get homeMonthlySection => 'Sellel kuul';

  @override
  String get monthPlannedLabel => 'Planeeritud';

  @override
  String get monthActualLabel => 'Tegelik';

  @override
  String get monthVarianceLabel => 'Vahe';

  @override
  String get continueShoppingLabel => 'Jätka ostlemist';

  @override
  String get historyEmpty =>
      'Veel pole ühtegi valmis ostetud. Sinu ajalugu ja analüütika ilmuvad siia.';

  @override
  String get aboutTabTitle => 'NShoptorist';

  @override
  String get aboutBody =>
      'NShoptor autorilt Crazy Penguin. Offline-keskne ostuplaneerija. Litsents: GPL-3.0.';

  @override
  String get startShoppingLabel => 'Alusta ostlemist';

  @override
  String get finishAndSeeResult => 'Valmista & vaata tulemust';

  @override
  String get settingsTitle => 'Seaded';

  @override
  String get languageLabel => 'Keel';

  @override
  String get languageSystem => 'Süsteem';

  @override
  String get languageTr => 'Türgi';

  @override
  String get languageEn => 'Inglise';

  @override
  String get themeLabel => 'Teema';

  @override
  String get themeSystem => 'Süsteem';

  @override
  String get themeLight => 'Hele';

  @override
  String get themeDark => 'Tume';

  @override
  String get defaultCurrencyLabel => 'Vaikimisi valuuta';

  @override
  String get defaultUnitLabel => 'Vaikimisi ühik';

  @override
  String get keepAwakeLabel => 'Hoia ekraan ostlemise ajal sisselülitatuna';

  @override
  String get backupSection => 'Varundamine';

  @override
  String get exportBackupLabel => 'Ekspordi varukoopia';

  @override
  String get importBackupLabel => 'Impordi varukoopia';

  @override
  String get mergeImportLabel => 'Liida olemasolevate andmetega';

  @override
  String get separateImportLabel => 'Impordi eraldi koopiana';

  @override
  String get importCancelled => 'Import tühistatud.';

  @override
  String get backupExported => 'Varukoopia edukalt eksporditud.';

  @override
  String get backupSizeWarning =>
      'Suur varukoopia: fail võib olla suur. Kas soovid lisada ka pilte?';

  @override
  String get deleteAllSection => 'Ohtlik tsoon';

  @override
  String get deleteAllLabel => 'Kustuta kõik andmed';

  @override
  String get deleteAllConfirm =>
      'See eemaldab kõik nimekirjad, ajaloost, kviitungipildid ja hinnad. Sinu poolt eksporditud failid jäävad sinu draivi. Jätkad?';

  @override
  String get deleteAllConfirm2 =>
      'Kas sa oled täiesti kindel? Seda tegevust ei saa tagasi pöörata.';

  @override
  String get cancelAction => 'Tühista';

  @override
  String get confirmDelete => 'Kustuta lõplikult';

  @override
  String get dataDeleted => 'Kõik kohalikud andmed kustutati.';

  @override
  String get privacyInfoLabel => 'Privaatsus';

  @override
  String get privacyInfoBody =>
      'Sinu nimekirjad, hinnad, kviitungid ja pildid jäävad sinu seadmesse. Pildid ja hääl ei lahkunud kunagi seadmest. Kui AI abi on sees, saadetakse meie serverisse ainult tekst (näiteks kviitingu read või mida sa dikteersid) töötlemiseks ja seda ei säilitata.';

  @override
  String get aboutSection => 'Teave';

  @override
  String get aboutPublisher => 'Väljaandja: Crazy Penguin';

  @override
  String get aboutLicenses => 'Load (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Häälsisend';

  @override
  String get voiceStatusUnknown => 'Teenindaja: kontrollimata';

  @override
  String get permissionsLabel => 'Õigused';

  @override
  String get permissionsBody =>
      'Kaamera, mikrofon ja teavitused küsitakse ainult siis, kui neid funktsioone tegelikult kasutad.';

  @override
  String get unitsSection => 'Vaikimisi väärtused';

  @override
  String get roundingNote =>
      'Raha ümardamisel järgitakse ühte reeglit: pooled ümarend nullist eemale, rakendatakse üks kord Money konversioonil.';

  @override
  String get voiceInputTitle => 'Häälsisend';

  @override
  String get voiceStartListening => 'Alusta kuulamist';

  @override
  String get voiceTranscriptLabel => 'Tekst';

  @override
  String get parseAction => 'Töötle';

  @override
  String get receiptReviewTitle => 'Kontrolli kviitungit';

  @override
  String get receiptTotal => 'Kviitungi kogusumma';

  @override
  String get receiptTotalUnknown => 'Kogusumma ei tuvastatud';

  @override
  String get receiptDiff => 'Vahe';

  @override
  String get acceptLine => 'Kinnita rida';

  @override
  String get ignoreLine => 'Jäta rida ignoreerimata';

  @override
  String get receiptLineActions =>
      'Lingi loomine tootele, jagamine või ignoreerimine';

  @override
  String get receiptCommit => 'Kinnita kõik';

  @override
  String get receiptCommitted => 'Kviitung on rakendatud.';

  @override
  String get priceHistoryTitle => 'Hindade ajalugu';

  @override
  String get noObservations => 'Hindade vaatlusi pole veel tehtud';

  @override
  String get templatesSection => 'Mallid';

  @override
  String get templateHint => 'Loo uus nimekiri eelmisest ostureisist';

  @override
  String get scanReceiptAction => 'Skaneeri kviitung';

  @override
  String get shelfLabelAction => 'Hind riiuli sildilt';

  @override
  String get priceCandidatesTitle => 'Hindade kandidaadid';

  @override
  String get noPriceCandidates => 'Hinda ei leitud; sisesta see käsitsi.';

  @override
  String get voiceUnavailable =>
      'Häältuvastus ei ole saadaval; sisesta käsitsi.';

  @override
  String get linkToItem => 'Lingi loomine tootele';

  @override
  String get splitLine => 'Jaga kaheks';

  @override
  String get mergeWithNext => 'Liida järgmisega';

  @override
  String get ocrNoText => 'Teksti ei lugenud; proovi uuesti.';

  @override
  String get priceHistoryAction => 'Hindade ajalugu';

  @override
  String get itemsEmptyTitle => 'Tooteid pole veel lisatud';

  @override
  String get itemsEmptyBody =>
      'Lisa oma esimene toode — poes sisestad siia tegelikud hinnad.';

  @override
  String get addItemTooltip => 'Lisa toode';

  @override
  String get unitAdet => 'tk';

  @override
  String get unitKilogram => 'kg';

  @override
  String get unitGram => 'g';

  @override
  String get unitLitre => 'L';

  @override
  String get unitMililitre => 'ml';

  @override
  String get unitPaket => 'pakett';

  @override
  String get unitKutu => 'kast';

  @override
  String get unitSise => 'pudel';

  @override
  String get unitKavanoz => 'purk';

  @override
  String get unitDemet => 'sidrun';

  @override
  String get unitDuzine => 'dutsin';

  @override
  String get unitMetre => 'm';

  @override
  String get unitCustom => 'Muu';

  @override
  String get setReminderAction => 'Määra meeldetuletus';

  @override
  String get reminderPermissionDenied =>
      'Meeldetuletuste jaoks on vaja teavituste luba. Saate selle süsteemi seadetes lubada.';

  @override
  String get reminderScheduled => 'Meeldetuletus määratud.';

  @override
  String get reminderCancelled => 'Meeldetuletus eemaldatud.';

  @override
  String get reminderTitle => 'Ostumeeldetuletus';

  @override
  String reminderBody(Object title) {
    return 'Aeg kontrollida oma nimekirja: $title';
  }

  @override
  String get reminderPickDate => 'Vali kuupäev';

  @override
  String get reminderPickTime => 'Vali kellaaeg';

  @override
  String get itemDetailsSection => 'Üksikasjad';

  @override
  String get priceOptionalHint => 'Valikuline — tegeliku hinna sisestate poes';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Planeeritud: $total · $count toodet';
  }

  @override
  String get proActiveLabel => 'Pro aktiivne — aitäh!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Reklaamivaba, rohkem AI-d, varundamine · alates väikesest kuutasust';

  @override
  String get proBenefitNoAds => 'Reklaamivaba kogemus';

  @override
  String get proBenefitBackup => 'Varundamine (eksport/import)';

  @override
  String aboutVersion(Object version) {
    return 'Versioon $version';
  }

  @override
  String get navDiscover => 'Avasta';

  @override
  String get shareAction => 'Jaga rakendust';

  @override
  String get rateAction => 'Hinda meid';

  @override
  String get aboutOpenRow => 'Info ja avatud lähtekood';

  @override
  String get voiceAddItemAction => 'Lisa häälega';

  @override
  String get formatLocaleLabel => 'Arvude ja valuuta vorming';

  @override
  String get formatLocaleSystem =>
      'Seadme formaat (ladina numbrid; muidu inglise keeles)';

  @override
  String get formatLocaleTr => 'Türgi (1.234,56)';

  @override
  String get formatLocaleEn => 'Inglise (1,234.56)';

  @override
  String get aiToggleTitle => 'AI abi';

  @override
  String get aiToggleSubtitle =>
      'Võrdleb kvite, loeb hinnasildid ja teisendab laused nimekirjaks. Pildid ja hääl jäävad sinu seadmesse; töödeldakse ainult teksti.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Oled selle kuu AI päringud ära kasutanud ($used/$limit). Täienda rohkemateks päringuteks või jätkake ilma AI-ta.';
  }

  @override
  String get aiOffline => 'Ühendust pole — jätkame ilma AI-ta.';

  @override
  String get aiFailed => 'AI ei ole praegu saadaval — jätkame ilma selleta.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'Seade';

  @override
  String get quickListAction => 'Lisa lausest';

  @override
  String get quickListTitle => 'Kiirnimikiri';

  @override
  String get quickListHint => 'nt 1 kg õunu 20, 2 leiba, pool kilo juustu';

  @override
  String get quickListConvert => 'Teisenda nimekirjaks';

  @override
  String quickListAdd(int count) {
    return 'Lisa $count toodet';
  }

  @override
  String get quickListEmpty =>
      'Tooteid ei leitud. Proovi kirjutada need komaga eraldatult.';

  @override
  String get receiptAiMatched =>
      'AI on kviti sinu nimekirjaga ühendanud. Kontrolli lingid ja kinnita.';

  @override
  String get receiptNeedsCheck => 'Kontrolli seda ühendamist';

  @override
  String get receiptDiscountLine => 'Soodustus';

  @override
  String get compareItem => 'Toode';

  @override
  String get compareEstimated => 'Eeldatud';

  @override
  String get compareActual => 'Tegelik';

  @override
  String get compareDiff => 'Vahe';

  @override
  String get compareTotal => 'Kokku';

  @override
  String get compareBudget => 'Eelarve';

  @override
  String get compareNotBought => 'ei ostetud';

  @override
  String get compareUnplanned => 'ei planeeritud';

  @override
  String get pricierItems => 'Kallimad';

  @override
  String get cheaperItems => 'Odavamad';

  @override
  String get compareAction => 'Võrdle';

  @override
  String get detailsSection => 'Üksikasjad';

  @override
  String get spendingTitle => 'Kulud';

  @override
  String get spendingAction => 'Kulud';

  @override
  String get spendingMonthTotal => 'See kuu';

  @override
  String get spendingWeekly => 'Nädalased kulud';

  @override
  String get spendingMonthly => 'Kuised kulud';

  @override
  String get monthlyLimitTitle => 'Kuu piirmäär';

  @override
  String get monthlyLimitHelp => 'Kui palju soovid kuus toidupoes kulutada?';

  @override
  String get monthlyLimitRemove => 'Eemalda';

  @override
  String get monthlyLimitSet => 'Määra';

  @override
  String get monthlyLimitChange => 'Muuda';

  @override
  String get monthlyLimitNone =>
      'Määra kuu piirmäär, et näha, kui palju sul veel on.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount üle piirmäära';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return '$amount jäänud sellel kuul';
  }

  @override
  String get plansTitle => 'Plaani';

  @override
  String get plansHeadline => 'Osta targemalt AI-ga';

  @override
  String get plansSubhead =>
      'Kvitide ühendamine, hinnasildid ja nimekirjad lausest. Tühenda igal ajal.';

  @override
  String get plansMonthly => 'Igakuiselt';

  @override
  String get plansYearly => 'Aastaselt';

  @override
  String get planFree => 'Tasuta';

  @override
  String get planFreePrice => 'Igavesti tasuta';

  @override
  String get planFreeAi => '15 AI päringut kuus';

  @override
  String get planFreeAds =>
      'Väikesed bännerireklaamid (esimesel 7 päeval puuduvad)';

  @override
  String get planCoreFeatures =>
      'Nimekirjad, hinnad, kviidid, kulude graafikud';

  @override
  String get plansPerYear => '/ aastas';

  @override
  String get plansPerMonth => '/ kuus';

  @override
  String get planTrial => '7 päeva tasuta';

  @override
  String get planProAi => '200 AI päringut kuus';

  @override
  String get planNoAds => 'Ilma reklaamita';

  @override
  String get planBackup => 'Varundamise eksport ja import';

  @override
  String get planMaxAi => '1000 AI päringut kuus';

  @override
  String get planMaxFamily => 'Suure pere ostudeks';

  @override
  String get plansStoreUnavailable => 'Pood ei ole praegu kättesaadav.';

  @override
  String get retryAction => 'Proovi uuesti';

  @override
  String get plansPurchaseFailed => 'Ost ei õnnestunud. Palun proovi uuesti.';

  @override
  String get planLifetimeTitle => 'Reklaamivaba kogu elu';

  @override
  String get planLifetimeSubtitle =>
      'Ühekordne makse: ilma reklaamita, varundamine; AI jääb tasuta piirangusse';

  @override
  String get plansRestore => 'Taasta ostud';

  @override
  String get plansLegal =>
      'Tellimused uuenevad automaatselt, kuni need tühistatakse. Tühistada saab igal ajal Google Play › Maksmine ja tellimused. Hinnad sisaldavad Google Play poolt näidatud makse.';

  @override
  String get planCurrent => 'Praegune';

  @override
  String get planStartTrial => 'Alusta 7-päevast tasuta prooviperioodi';

  @override
  String get planChoose => 'Vali';

  @override
  String get plansAction => 'Kavad: Pro ja Max';

  @override
  String get assistantTitle => 'Assistent';

  @override
  String get assistantGreeting => 'Tere! Mida soovid teha?';

  @override
  String get assistantNewList => 'Uus nimekiri';

  @override
  String get assistantVoiceList => 'Nimekiri häälkäsu alusel';

  @override
  String get assistantTextList => 'Nimekiri lausest';

  @override
  String get assistantScanReceipt => 'Skaneeri kvitung';

  @override
  String get assistantSpending => 'Minu kulud';

  @override
  String get assistantReceiptHint =>
      'Ava oma nimekiri ja puuduta skaneerimise ikooni.';

  @override
  String get assistantToggleTitle => 'Kuva assistent';

  @override
  String get assistantToggleSubtitle => 'Väike abiline paremas nurgas';

  @override
  String get scanPriceLabel => 'Skaneeri hinnasilt';

  @override
  String get saveFailed =>
      'Salvestamine ei õnnestunud. Sinu muudatused on endiselt olemas. Palun proovi uuesti.';

  @override
  String get deleteItemConfirm =>
      'Kas kustutame selle toote ja selle salvestatud ostud?';

  @override
  String get clearPurchaseConfirm =>
      'Kas eemaldame selle toote märgistuse ja selle salvestatud ostud?';

  @override
  String get reportPdfAction => 'Salvesta PDF-aruanne';

  @override
  String get reportNotInvoice =>
      'Ostude kokkuvõte, mitte maksuarve. Maksumäärad on teadmata.';

  @override
  String get purchaseVisits => 'Ostureisid';

  @override
  String get purchaseInterval => 'Keskmine päevade arv ostude vahel';

  @override
  String get purchasedQuantity => 'Ostetud kogus';

  @override
  String get purchaseAnalyticsHint =>
      'Ostud ei mõõda tarbimist. Valuutad ja ühikud kuvatakse eraldi.';

  @override
  String get receiptReplaces =>
      'Seotud kviitungiread asendavad olemasolevad ostud; seostamata read lisatakse.';

  @override
  String get voiceUnsupportedLanguage =>
      'Seda keele varianti pole selles seadmes häälsisestamiseks saadaval. Saad selle asemel tekstina sisestada.';

  @override
  String get voiceStopListening => 'Lõpeta kuulamine';

  @override
  String get keepAwakeFailed =>
      'Ekraani hoidmine ärkvelolekus ei õnnestunud. Palun proovi uuesti.';

  @override
  String get purchaseHistoryHint =>
      'Kõik lõpetatud ostud. Tagastused vähendavad kogusummasid. Kuupäevad viitavad ostu lõpetamise ajale. Üks külastus ei ole piisav keskmise intervalli arvutamiseks.';
}
