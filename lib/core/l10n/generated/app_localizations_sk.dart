// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovak (`sk`).
class AppLocalizationsSk extends AppLocalizations {
  AppLocalizationsSk([String locale = 'sk']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Plánujte doma. Nakupujte podľa plánu.';

  @override
  String get listsTitle => 'Zoznamy';

  @override
  String get listsTabActive => 'Aktívne';

  @override
  String get listsTabCompleted => 'Dokončené';

  @override
  String get listsTabArchived => 'Archivované';

  @override
  String get newListButton => 'Nový zoznam';

  @override
  String get listTitleHint => 'Názov (voliteľné)';

  @override
  String get saveButton => 'Uložiť';

  @override
  String get cancelButton => 'Zrušiť';

  @override
  String get deleteButton => 'Odstrániť';

  @override
  String get editAction => 'Upraviť';

  @override
  String get listDeleted => 'Zoznam odstránený';

  @override
  String get invalidAmountError => 'Neplatná suma';

  @override
  String get duplicateAction => 'Duplikovať';

  @override
  String get archiveAction => 'Archivovať';

  @override
  String get unarchiveAction => 'Odz archivovať';

  @override
  String get deleteListConfirm =>
      'Odstrániť tento zoznam? Plánované položky budú tiež odstránené.';

  @override
  String get undoButton => 'Späť';

  @override
  String get searchListHint => 'Hľadať v zoznamoch';

  @override
  String get currencyLabel => 'Mena';

  @override
  String get budgetLabel => 'Rozpočet (voliteľné)';

  @override
  String get noteLabel => 'Poznámka (voliteľné)';

  @override
  String get storeLabel => 'Obchod';

  @override
  String get keepAmountsAction => 'Ponechať sumy';

  @override
  String get resetAmountsAction => 'Resetovať sumy';

  @override
  String get currencyChangeWarning =>
      'Mení sa mena. Čo sa má stať s existujúcimi sumami?';

  @override
  String get listsEmpty =>
      'Zatiaľ žiadne zoznamy. Vytvorte svoj prvý nákupný plán.';

  @override
  String get statusDraft => 'Koncept';

  @override
  String get statusPlanned => 'Plánované';

  @override
  String get statusShopping => 'Nákup';

  @override
  String get statusCompleted => 'Dokončené';

  @override
  String get statusArchived => 'Archivované';

  @override
  String autoListTitle(String date) {
    return 'Nákup $date';
  }

  @override
  String get itemFormTitle => 'Pridať položku';

  @override
  String get itemNameLabel => 'Názov položky';

  @override
  String get brandLabel => 'Značka / varianta (voliteľné)';

  @override
  String get categoryLabel => 'Kategória';

  @override
  String get quantityLabel => 'Množstvo';

  @override
  String get unitLabel => 'Jednotka';

  @override
  String get pricingModeLabel => 'Režim zadania ceny';

  @override
  String get pricingModeUnitPrice => 'Cena za jednotku';

  @override
  String get pricingModeLineTotal => 'Celková cena riadku';

  @override
  String get plannedPriceLabel => 'Plánovaná cena';

  @override
  String lineTotalCalculated(String value) {
    return 'Celková cena riadku: $value';
  }

  @override
  String get requiredItemToggle => 'Povinná položka';

  @override
  String get maxPriceLabel => 'Maximálna prijateľná cena (voliteľné)';

  @override
  String get itemNoteLabel => 'Poznámka (voliteľné)';

  @override
  String get categoryProduce => 'Ovocie a zelenina';

  @override
  String get categoryDairy => 'Mliečne výrobky';

  @override
  String get categoryMeat => 'Mäso';

  @override
  String get categoryBakery => 'Pečivo';

  @override
  String get categoryDrinks => 'Nápoje';

  @override
  String get categoryCleaning => 'Čistiace prostriedky';

  @override
  String get categoryPersonalCare => 'Osobná hygiena';

  @override
  String get categoryHome => 'Domácnosť';

  @override
  String get categoryOther => 'Iné';

  @override
  String get invalidQuantityError => 'Neplatné množstvo';

  @override
  String get invalidPriceError => 'Neplatná cena';

  @override
  String get invalidNameError => 'Zadajte názov';

  @override
  String unitPriceCalculated(String value) {
    return 'Jednotková cena: $value';
  }

  @override
  String get shoppingTitle => 'Režim nákupu';

  @override
  String get summaryPlannedTotal => 'Naplánované';

  @override
  String get summaryInCart => 'V košíku';

  @override
  String get summaryRemainingPlan => 'Zostávajúci plán';

  @override
  String get summaryProjected => 'Odhadovaný súčet';

  @override
  String get summaryBudgetRemaining => 'Zostatok rozpočtu';

  @override
  String get summaryBudgetOver => 'Prekročenie rozpočtu';

  @override
  String itemsProgress(String done, String total) {
    return '$done z $total položiek';
  }

  @override
  String get filterAll => 'Všetko';

  @override
  String get filterToBuy => 'Na kúpu';

  @override
  String get filterInCart => 'V košíku';

  @override
  String get filterNotFound => 'Nenájdené';

  @override
  String get filterRequired => 'Povinné';

  @override
  String get quickEntryTitle => 'Skutočná cena';

  @override
  String get actualQuantityLabel => 'Skutočné množstvo';

  @override
  String get actualPriceLabel => 'Skutočná cena';

  @override
  String get discountLabel => 'Zľava (voliteľné)';

  @override
  String get alternativeNameLabel =>
      'Názov alternatívneho produktu (voliteľné)';

  @override
  String get savePurchaseButton => 'Pridať do košíka';

  @override
  String get unplannedAddButton => 'Pridať neplánovanú položku';

  @override
  String get statusPending => 'Nezískané';

  @override
  String get statusInCart => 'V košíku';

  @override
  String get statusNotFound => 'Nenájdené';

  @override
  String get statusGaveUp => 'Vzdali sme sa';

  @override
  String get statusAlternative => 'Kúpená alternatíva';

  @override
  String get keepScreenAwake => 'Udržovať obrazovku zapnutú';

  @override
  String get finishShopping => 'Dokončiť nákup';

  @override
  String get completionWarning =>
      'Chýbajú alebo nie sú overené záznamy. Nákup môžete dokončiť; výsledok ich bude uvádzať.';

  @override
  String get continueShoppingButton => 'Pokračovať v nákupe';

  @override
  String get resultTitle => 'Výsledok';

  @override
  String get summarySection => 'Súhrn';

  @override
  String get plannedTotalLabel => 'Celkom naplánované';

  @override
  String get actualTotalLabel => 'Celkom skutočné';

  @override
  String get varianceLabel => 'Rozdiel';

  @override
  String get varianceNotComputable => 'Nie je možné vypočítať';

  @override
  String get budgetStatusLabel => 'Rozpočet';

  @override
  String get savingsLabel => 'Pod plánom';

  @override
  String get overspendLabel => 'Nad plánom';

  @override
  String get unplannedTotalLabel => 'Celkom neplánovaných';

  @override
  String get unpurchasedLabel => 'Naplánované, ale nekúpené';

  @override
  String get totalDiscountLabel => 'Celkové zľavy';

  @override
  String get accuracyLabel => 'Presnosť odhadu';

  @override
  String get groupsSection => 'Položky';

  @override
  String get groupPricier => 'Drahšie ako naplánované';

  @override
  String get groupCheaper => 'Lacnejšie ako naplánované';

  @override
  String get groupClose => 'Blízko odhadu';

  @override
  String get groupNotTaken => 'Naplánované, nekúpené';

  @override
  String get groupUnplanned => 'Kúpené bez plánu';

  @override
  String get groupQuantityChanged => 'Zmenené množstvo';

  @override
  String get groupUnverified => 'Neoverené';

  @override
  String get plannedQtyLabel => 'Naplanované množstvo';

  @override
  String get actualQtyLabel => 'Skutočné množstvo';

  @override
  String get plannedUnitPriceLabel => 'Naplanovaná jednotková cena';

  @override
  String get actualUnitPriceLabel => 'Skutočná jednotková cena';

  @override
  String get lineVarianceLabel => 'Rozdiel riadku';

  @override
  String get discountEffectLabel => 'Efekt zľavy';

  @override
  String get notBoughtMark => 'nekúpené';

  @override
  String get noPurchasesNote => 'Žiadne nákupy neboli zaznamenané.';

  @override
  String get navHome => 'Domov';

  @override
  String get navLists => 'Zoznamy';

  @override
  String get navHistory => 'História';

  @override
  String get navSettings => 'Nastavenia';

  @override
  String get homeEmptyTitle => 'Plánujte nákupy';

  @override
  String get homeEmptyBody =>
      'Vytvorte svoj prvý zoznam a porovnajte plánované vs. skutočné náklady.';

  @override
  String get homeActiveSection => 'Aktívne zoznamy';

  @override
  String get homeCompletedSection => 'Nedávno dokončené';

  @override
  String get homeMonthlySection => 'Tento mesiac';

  @override
  String get monthPlannedLabel => 'Plánované';

  @override
  String get monthActualLabel => 'Skutočné';

  @override
  String get monthVarianceLabel => 'Rozdiel';

  @override
  String get continueShoppingLabel => 'Pokračovať v nákupe';

  @override
  String get historyEmpty =>
      'Zatiaľ žiadne dokončené nákupy. Vaša história a štatistiky sa zobrazia tu.';

  @override
  String get aboutTabTitle => 'O aplikácii NShoptor';

  @override
  String get aboutBody =>
      'NShoptor od Crazy Penguin. Offline plánovač nákupov. Licencovaný pod GPL-3.0.';

  @override
  String get startShoppingLabel => 'Začať nakupovať';

  @override
  String get finishAndSeeResult => 'Dokončiť a zobraziť výsledok';

  @override
  String get settingsTitle => 'Nastavenia';

  @override
  String get languageLabel => 'Jazyk';

  @override
  String get languageSystem => 'Systém';

  @override
  String get languageTr => 'Turečtina';

  @override
  String get languageEn => 'Angličtina';

  @override
  String get themeLabel => 'Téma';

  @override
  String get themeSystem => 'Systém';

  @override
  String get themeLight => 'Svetlá';

  @override
  String get themeDark => 'Tmavá';

  @override
  String get defaultCurrencyLabel => 'Predvolena mena';

  @override
  String get defaultUnitLabel => 'Predvolená jednotka';

  @override
  String get keepAwakeLabel => 'Udržovať obrazovku zapnutú počas nákupu';

  @override
  String get backupSection => 'Záloha';

  @override
  String get exportBackupLabel => 'Exportovať zálohu';

  @override
  String get importBackupLabel => 'Importovať zálohu';

  @override
  String get mergeImportLabel => 'Zlúčiť s aktuálnymi dátami';

  @override
  String get separateImportLabel => 'Importovať ako samostatnú kópiu';

  @override
  String get importCancelled => 'Import zrušený.';

  @override
  String get backupExported => 'Záloha bola úspešne exportovaná.';

  @override
  String get backupSizeWarning =>
      'Veľká záloha: súbor môže byť veľký. Chcete zahrnúť aj fotografie?';

  @override
  String get deleteAllSection => 'Nebezpečná zóna';

  @override
  String get deleteAllLabel => 'Vymazať všetky dáta';

  @override
  String get deleteAllConfirm =>
      'Toto odstráni všetky zoznamy, históriu, fotky účteniek a ceny. Súbory exportované vami zostanú na vašom disku. Pokračovať?';

  @override
  String get deleteAllConfirm2 =>
      'Ste si úplne istí? Túto akciu nie je možné vrátiť späť.';

  @override
  String get cancelAction => 'Zrušiť';

  @override
  String get confirmDelete => 'Trvalo vymazať';

  @override
  String get dataDeleted => 'Všetky lokálne dáta boli vymazané.';

  @override
  String get privacyInfoLabel => 'Ochrana súkromia';

  @override
  String get privacyInfoBody =>
      'Vaše zoznamy, ceny, účtenky a fotografie zostávajú vo vašom zariadení. Fotografie a hlas nikdy neopustia vaše zariadenie. Keď je pomoc AI aktívna, na náš server sa posiela iba text (napríklad riadky z účtenky alebo to, čo ste diktovali) na spracovanie a nie je ukladaný.';

  @override
  String get aboutSection => 'O aplikácii';

  @override
  String get aboutPublisher => 'Vydavateľ: Crazy Penguin';

  @override
  String get aboutLicenses => 'Licencie (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Hlasový vstup';

  @override
  String get voiceStatusUnknown => 'Služba: neoverená';

  @override
  String get permissionsLabel => 'Oprávnenia';

  @override
  String get permissionsBody =>
      'Kamera, mikrofón a notifikácie sú vyžadované len vtedy, keď tieto funkcie skutočne používate.';

  @override
  String get unitsSection => 'Predvolené hodnoty';

  @override
  String get roundingNote =>
      'Zaokrúhľovanie peňazí sa riadi jedným pravidlom: polovice sa zaokrúhľujú smerom od nuly, uplatní sa raz pri prevode na peniaze.';

  @override
  String get voiceInputTitle => 'Hlasový vstup';

  @override
  String get voiceStartListening => 'Spustiť počúvanie';

  @override
  String get voiceTranscriptLabel => 'Prepis';

  @override
  String get parseAction => 'Parsovať';

  @override
  String get receiptReviewTitle => 'Skontrolovať účtenku';

  @override
  String get receiptTotal => 'Celková suma účtenky';

  @override
  String get receiptTotalUnknown => 'Suma nebola zistená';

  @override
  String get receiptDiff => 'Rozdiel';

  @override
  String get acceptLine => 'Potvrdiť riadok';

  @override
  String get ignoreLine => 'Ignorovať riadok';

  @override
  String get receiptLineActions =>
      'Prepojiť s položkou, rozdeliť alebo ignorovať';

  @override
  String get receiptCommit => 'Potvrdiť všetko';

  @override
  String get receiptCommitted => 'Účtenka bola spracovaná.';

  @override
  String get priceHistoryTitle => 'História cien';

  @override
  String get noObservations => 'Zatiaľ žiadne záznamy o cenách';

  @override
  String get templatesSection => 'Šablóny';

  @override
  String get templateHint =>
      'Vytvorte nový zoznam na základe predchádzajúceho nákupu';

  @override
  String get scanReceiptAction => 'Naskenovať účtenku';

  @override
  String get shelfLabelAction => 'Cena z štítku na poličke';

  @override
  String get priceCandidatesTitle => 'Kandidáti na cenu';

  @override
  String get noPriceCandidates => 'Cena sa nenašla; zadajte ju manuálne.';

  @override
  String get voiceUnavailable =>
      'Hlasové rozpoznávanie nie je k dispozícii; zadajte manuálne.';

  @override
  String get linkToItem => 'Prepojiť s položkou';

  @override
  String get splitLine => 'Rozdeliť na dve';

  @override
  String get mergeWithNext => 'Spojiť s ďalším';

  @override
  String get ocrNoText => 'Žiadny text nebol prečítaný; skúste to znova.';

  @override
  String get priceHistoryAction => 'História cien';

  @override
  String get itemsEmptyTitle => 'Zatiaľ žiadne položky';

  @override
  String get itemsEmptyBody =>
      'Pridajte svoju prvú položku — reálnu cenu zadáte priamo v obchode.';

  @override
  String get addItemTooltip => 'Pridať položku';

  @override
  String get unitAdet => 'ks';

  @override
  String get unitKilogram => 'kg';

  @override
  String get unitGram => 'g';

  @override
  String get unitLitre => 'l';

  @override
  String get unitMililitre => 'ml';

  @override
  String get unitPaket => 'bal.';

  @override
  String get unitKutu => 'krabica';

  @override
  String get unitSise => 'fľaša';

  @override
  String get unitKavanoz => 'sklenica';

  @override
  String get unitDemet => 'väzka';

  @override
  String get unitDuzine => 'dvestovka';

  @override
  String get unitMetre => 'm';

  @override
  String get unitCustom => 'Vlastné';

  @override
  String get setReminderAction => 'Nastaviť upozornenie';

  @override
  String get reminderPermissionDenied =>
      'Na upozornenia je potrebné povolenie notifikácií. Môžete ho zapnúť v nastaveniach systému.';

  @override
  String get reminderScheduled => 'Upozornenie nastavené.';

  @override
  String get reminderCancelled => 'Upozornenie odstránené.';

  @override
  String get reminderTitle => 'Upozornenie na nákup';

  @override
  String reminderBody(Object title) {
    return 'Čas pozrieť si váš zoznam: $title';
  }

  @override
  String get reminderPickDate => 'Vyberte dátum';

  @override
  String get reminderPickTime => 'Vyberte čas';

  @override
  String get itemDetailsSection => 'Detaily';

  @override
  String get priceOptionalHint => 'Voliteľné — reálnu cenu zadáte v obchode';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Plánované: $total · $count položiek';
  }

  @override
  String get proActiveLabel => 'Pro aktívne — ďakujeme!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Bez reklám, viac AI, záloha · za malý mesačný poplatok';

  @override
  String get proBenefitNoAds => 'Zážitok bez reklám';

  @override
  String get proBenefitBackup => 'Záloha (export/import)';

  @override
  String aboutVersion(Object version) {
    return 'Verzia $version';
  }

  @override
  String get navDiscover => 'Objavovať';

  @override
  String get shareAction => 'Zdieľať aplikáciu';

  @override
  String get rateAction => 'Ohodnotiť nás';

  @override
  String get aboutOpenRow => 'O aplikácii & open source';

  @override
  String get voiceAddItemAction => 'Pridať hlasom';

  @override
  String get formatLocaleLabel => 'Formát čísel a meny';

  @override
  String get formatLocaleSystem => 'Systém (sleduje jazyk aplikácie)';

  @override
  String get formatLocaleTr => 'Turečtina (1.234,56)';

  @override
  String get formatLocaleEn => 'Angličtina (1,234.56)';

  @override
  String get aiToggleTitle => 'Pomoc AI';

  @override
  String get aiToggleSubtitle =>
      'Porovnáva účty, číta cenovky a mení vety na zoznamy. Fotky a hlas zostávajú vo vašom zariadení; spracováva sa len text.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Vyčerpali ste mesačný limit požiadaviek AI ($used/$limit). Vylepšite si plán pre viac možností alebo pokračujte bez AI.';
  }

  @override
  String get aiOffline => 'Žiadne pripojenie — pokračujeme bez AI.';

  @override
  String get aiFailed => 'AI je momentálne nedostupná — pokračujeme bez nej.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'Zariadenie';

  @override
  String get quickListAction => 'Pridať z vety';

  @override
  String get quickListTitle => 'Rýchly zoznam';

  @override
  String get quickListHint => 'napr. 1 kg jabĺk 20, 2 chleby, pol kila syra';

  @override
  String get quickListConvert => 'Vytvoriť zoznam';

  @override
  String quickListAdd(int count) {
    return 'Pridať $count položiek';
  }

  @override
  String get quickListEmpty =>
      'Nenašli sa žiadne položky. Skúste ich vypísať oddelené čiarkami.';

  @override
  String get receiptAiMatched =>
      'AI spárovala účet s vaším zoznamom. Skontrolujte odkazy a potvrďte.';

  @override
  String get receiptNeedsCheck => 'Skontrolovať toto spárovanie';

  @override
  String get receiptDiscountLine => 'Zľava';

  @override
  String get compareItem => 'Položka';

  @override
  String get compareEstimated => 'Odhad';

  @override
  String get compareActual => 'Skutočná cena';

  @override
  String get compareDiff => 'Rozdiel';

  @override
  String get compareTotal => 'Celkom';

  @override
  String get compareBudget => 'Rozpočet';

  @override
  String get compareNotBought => 'nekúpené';

  @override
  String get compareUnplanned => 'neplánované';

  @override
  String get pricierItems => 'Stáli viac';

  @override
  String get cheaperItems => 'Stáli menej';

  @override
  String get compareAction => 'Porovnať';

  @override
  String get detailsSection => 'Detaily';

  @override
  String get spendingTitle => 'Výdavky';

  @override
  String get spendingAction => 'Výdavky';

  @override
  String get spendingMonthTotal => 'Tento mesiac';

  @override
  String get spendingWeekly => 'Týždenné výdavky';

  @override
  String get spendingMonthly => 'Mesačné výdavky';

  @override
  String get monthlyLimitTitle => 'Mesačný limit';

  @override
  String get monthlyLimitHelp => 'Koľko chcete minúť na nákupy za mesiac?';

  @override
  String get monthlyLimitRemove => 'Odstrániť';

  @override
  String get monthlyLimitSet => 'Nastaviť';

  @override
  String get monthlyLimitChange => 'Zmeniť';

  @override
  String get monthlyLimitNone =>
      'Nastavte si mesačný limit a uvidíte, koľko vám ešte zostáva.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount nad limitom';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return '$amount zostáva tento mesiac';
  }

  @override
  String get plansTitle => 'Plány';

  @override
  String get plansHeadline => 'Nakupujte múdrejšie s AI';

  @override
  String get plansSubhead =>
      'Spárovanie účtov, cenovky a zoznamy z vety. Zrušte kedykoľvek.';

  @override
  String get plansMonthly => 'Mesačne';

  @override
  String get plansYearly => 'Ročne';

  @override
  String get planFree => 'Zdarma';

  @override
  String get planFreePrice => 'Navždy zdarma';

  @override
  String get planFreeAi => '15 požiadaviek AI za mesiac';

  @override
  String get planFreeAds =>
      'Malé bannerové reklamy (žiadne počas prvých 7 dní)';

  @override
  String get planCoreFeatures => 'Zoznamy, ceny, účty, grafy výdavkov';

  @override
  String get plansPerYear => '/ rok';

  @override
  String get plansPerMonth => '/ mesiac';

  @override
  String get planTrial => '7 dní zdarma';

  @override
  String get planProAi => '200 požiadaviek AI za mesiac';

  @override
  String get planNoAds => 'Žiadne reklamy';

  @override
  String get planBackup => 'Export a import záloh';

  @override
  String get planMaxAi => '1000 AI požiadaviek mesačne';

  @override
  String get planMaxFamily => 'Pre nákupy veľkej rodiny';

  @override
  String get plansStoreUnavailable => 'Obchod je momentálne nedostupný.';

  @override
  String get retryAction => 'Skúsiť znova';

  @override
  String get plansPurchaseFailed =>
      'Nákup sa nepodaril. Skúste to prosím znova.';

  @override
  String get planLifetimeTitle => 'Bez reklám navždy';

  @override
  String get planLifetimeSubtitle =>
      'Jednorazová platba: žiadne reklamy, zálohy; AI zostáva na bezplatnom limite';

  @override
  String get plansRestore => 'Obnoviť nákupy';

  @override
  String get plansLegal =>
      'Predplatné sa obnovujú automaticky, až kým ich nezrušíte. Zrušiť môžete kedykoľvek v Google Play › Platby a predplatné. Ceny zahŕňajú dane zobrazené v Google Play.';

  @override
  String get planCurrent => 'Aktuálne';

  @override
  String get planStartTrial => 'Spustiť 7-dňovú bezplatnú skúšobnú verziu';

  @override
  String get planChoose => 'Vybrať';

  @override
  String get plansAction => 'Plány: Pro a Max';

  @override
  String get assistantTitle => 'Asistent';

  @override
  String get assistantGreeting => 'Ahoj! Čo by si chcel robiť?';

  @override
  String get assistantNewList => 'Nový zoznam';

  @override
  String get assistantVoiceList => 'Zoznam hlasom';

  @override
  String get assistantTextList => 'Zoznam zo vety';

  @override
  String get assistantScanReceipt => 'Naskenovať účtenku';

  @override
  String get assistantSpending => 'Moje výdavky';

  @override
  String get assistantReceiptHint =>
      'Otvorte svoj zoznam a klepnutím na ikonu účtenky ju naskenujte.';

  @override
  String get assistantToggleTitle => 'Zobraziť asistenta';

  @override
  String get assistantToggleSubtitle => 'Malý pomocník v pravom dolnom rohu';
}
