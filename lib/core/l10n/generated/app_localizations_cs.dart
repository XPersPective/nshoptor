// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Plánujte doma. Nakupujte podle plánu.';

  @override
  String get listsTitle => 'Seznamy';

  @override
  String get listsTabActive => 'Aktivní';

  @override
  String get listsTabCompleted => 'Dokončené';

  @override
  String get listsTabArchived => 'Archivované';

  @override
  String get newListButton => 'Nový seznam';

  @override
  String get listTitleHint => 'Název (volitelné)';

  @override
  String get saveButton => 'Uložit';

  @override
  String get cancelButton => 'Zrušit';

  @override
  String get deleteButton => 'Smazat';

  @override
  String get editAction => 'Upravit';

  @override
  String get listDeleted => 'Seznam smazán';

  @override
  String get invalidAmountError => 'Neplatné množství';

  @override
  String get duplicateAction => 'Duplikovat';

  @override
  String get archiveAction => 'Archivovat';

  @override
  String get unarchiveAction => 'Obnovit z archivu';

  @override
  String get deleteListConfirm =>
      'Smazat tento seznam? Plánované položky budou také odstraněny.';

  @override
  String get undoButton => 'Zpět';

  @override
  String get searchListHint => 'Hledat seznamy';

  @override
  String get currencyLabel => 'Měna';

  @override
  String get budgetLabel => 'Rozpočet (volitelné)';

  @override
  String get noteLabel => 'Poznámka (volitelné)';

  @override
  String get storeLabel => 'Obchod';

  @override
  String get keepAmountsAction => 'Ponechat množství';

  @override
  String get resetAmountsAction => 'Resetovat množství';

  @override
  String get currencyChangeWarning =>
      'Měna se mění. Co se má stát s existujícími částkami?';

  @override
  String get listsEmpty =>
      'Zatím žádné seznamy. Vytvořte svůj první nákupní plán.';

  @override
  String get statusDraft => 'Koncept';

  @override
  String get statusPlanned => 'Plánováno';

  @override
  String get statusShopping => 'Nákup';

  @override
  String get statusCompleted => 'Dokončeno';

  @override
  String get statusArchived => 'Archivováno';

  @override
  String autoListTitle(String date) {
    return 'Nákup $date';
  }

  @override
  String get itemFormTitle => 'Přidat položku';

  @override
  String get itemNameLabel => 'Název položky';

  @override
  String get brandLabel => 'Značka / varianta (volitelné)';

  @override
  String get categoryLabel => 'Kategorie';

  @override
  String get quantityLabel => 'Množství';

  @override
  String get unitLabel => 'Jednotka';

  @override
  String get pricingModeLabel => 'Způsob zadání ceny';

  @override
  String get pricingModeUnitPrice => 'Cena za jednotku';

  @override
  String get pricingModeLineTotal => 'Celkem za řádek';

  @override
  String get plannedPriceLabel => 'Plánovaná cena';

  @override
  String lineTotalCalculated(String value) {
    return 'Celkem za řádek: $value';
  }

  @override
  String get requiredItemToggle => 'Nutná položka';

  @override
  String get maxPriceLabel => 'Maximální přijatelná cena (volitelné)';

  @override
  String get itemNoteLabel => 'Poznámka (volitelné)';

  @override
  String get categoryProduce => 'Ovoce a zelenina';

  @override
  String get categoryDairy => 'Mléčné výrobky';

  @override
  String get categoryMeat => 'Maso';

  @override
  String get categoryBakery => 'Pečivo';

  @override
  String get categoryDrinks => 'Nápoje';

  @override
  String get categoryCleaning => 'Čistící prostředky';

  @override
  String get categoryPersonalCare => 'Osobní hygiena';

  @override
  String get categoryHome => 'Domácnost';

  @override
  String get categoryOther => 'Ostatní';

  @override
  String get invalidQuantityError => 'Neplatné množství';

  @override
  String get invalidPriceError => 'Neplatná cena';

  @override
  String get invalidNameError => 'Zadejte název';

  @override
  String unitPriceCalculated(String value) {
    return 'Cena za jednotku: $value';
  }

  @override
  String get shoppingTitle => 'Režim nákupu';

  @override
  String get summaryPlannedTotal => 'Naplánováno';

  @override
  String get summaryInCart => 'V košíku';

  @override
  String get summaryRemainingPlan => 'Zbývá naplánovat';

  @override
  String get summaryProjected => 'Odhad na pokladně';

  @override
  String get summaryBudgetRemaining => 'Zbývá rozpočet';

  @override
  String get summaryBudgetOver => 'Překročen rozpočet';

  @override
  String itemsProgress(String done, String total) {
    return '$done z $total položek';
  }

  @override
  String get filterAll => 'Vše';

  @override
  String get filterToBuy => 'Koupit';

  @override
  String get filterInCart => 'V košíku';

  @override
  String get filterNotFound => 'Nenalezeno';

  @override
  String get filterRequired => 'Nutné';

  @override
  String get quickEntryTitle => 'Skutečná cena';

  @override
  String get actualQuantityLabel => 'Skutečné množství';

  @override
  String get actualPriceLabel => 'Skutečná cena';

  @override
  String get discountLabel => 'Sleva (volitelné)';

  @override
  String get alternativeNameLabel =>
      'Název alternativního produktu (volitelné)';

  @override
  String get savePurchaseButton => 'Přidat do košíku';

  @override
  String get unplannedAddButton => 'Přidat nepůvodní položku';

  @override
  String get statusPending => 'Nevybráno';

  @override
  String get statusInCart => 'V košíku';

  @override
  String get statusNotFound => 'Nenalezeno';

  @override
  String get statusGaveUp => 'Vzdáno';

  @override
  String get statusAlternative => 'Koupena alternativa';

  @override
  String get keepScreenAwake => 'Udržet obrazovku zapnutou';

  @override
  String get finishShopping => 'Dokončit nákup';

  @override
  String get completionWarning =>
      'Chybí nebo jsou neověřené záznamy. Nákup můžete dokončit; výsledek je zaznamená.';

  @override
  String get continueShoppingButton => 'Pokračovat v nákupu';

  @override
  String get resultTitle => 'Výsledek';

  @override
  String get summarySection => 'Shrnutí';

  @override
  String get plannedTotalLabel => 'Celkem naplánováno';

  @override
  String get actualTotalLabel => 'Celkem skutečně';

  @override
  String get varianceLabel => 'Rozdíl';

  @override
  String get varianceNotComputable => 'Nelze vypočítat';

  @override
  String get budgetStatusLabel => 'Rozpočet';

  @override
  String get savingsLabel => 'Pod plánem';

  @override
  String get overspendLabel => 'Nad plánem';

  @override
  String get unplannedTotalLabel => 'Celkem nepůvodních položek';

  @override
  String get unpurchasedLabel => 'Naplanováno, ale nekoupeno';

  @override
  String get totalDiscountLabel => 'Celkové slevy';

  @override
  String get accuracyLabel => 'Přesnost odhadu';

  @override
  String get groupsSection => 'Položky';

  @override
  String get groupPricier => 'Dražší než naplánováno';

  @override
  String get groupCheaper => 'Levnější než naplánováno';

  @override
  String get groupClose => 'Blízko odhadu';

  @override
  String get groupNotTaken => 'Naplanováno, nekoupeno';

  @override
  String get groupUnplanned => 'Koupeno bez plánu';

  @override
  String get groupQuantityChanged => 'Změněné množství';

  @override
  String get groupUnverified => 'Neověřeno';

  @override
  String get plannedQtyLabel => 'Naplanované množství';

  @override
  String get actualQtyLabel => 'Skutečné množství';

  @override
  String get plannedUnitPriceLabel => 'Naplanovaná cena za jednotku';

  @override
  String get actualUnitPriceLabel => 'Skutečná cena za jednotku';

  @override
  String get lineVarianceLabel => 'Rozdíl řádku';

  @override
  String get discountEffectLabel => 'Efekt slevy';

  @override
  String get notBoughtMark => 'nekoupeno';

  @override
  String get noPurchasesNote => 'Nebyly zaznamenány žádné nákupy.';

  @override
  String get navHome => 'Domů';

  @override
  String get navLists => 'Seznamy';

  @override
  String get navHistory => 'Historie';

  @override
  String get navSettings => 'Nastavení';

  @override
  String get homeEmptyTitle => 'Plánujte nákupy';

  @override
  String get homeEmptyBody =>
      'Vytvořte svůj první seznam a porovnejte plánované a skutečné náklady.';

  @override
  String get homeActiveSection => 'Aktivní seznamy';

  @override
  String get homeCompletedSection => 'Dokončené nedávno';

  @override
  String get homeMonthlySection => 'Tento měsíc';

  @override
  String get monthPlannedLabel => 'Plánováno';

  @override
  String get monthActualLabel => 'Skutečně';

  @override
  String get monthVarianceLabel => 'Rozdíl';

  @override
  String get continueShoppingLabel => 'Pokračovat v nákupu';

  @override
  String get historyEmpty =>
      'Zatím žádné dokončené nákupy. Historie a přehledy se zobrazí zde.';

  @override
  String get aboutTabTitle => 'O aplikaci NShoptor';

  @override
  String get aboutBody =>
      'NShoptor od Crazy Penguin. Plánovač nákupů s offline přístupem. Licencováno pod GPL-3.0.';

  @override
  String get startShoppingLabel => 'Začít nakupovat';

  @override
  String get finishAndSeeResult => 'Dokončit a zobrazit výsledek';

  @override
  String get settingsTitle => 'Nastavení';

  @override
  String get languageLabel => 'Jazyk';

  @override
  String get languageSystem => 'Systém';

  @override
  String get languageTr => 'Turečtina';

  @override
  String get languageEn => 'Angličtina';

  @override
  String get themeLabel => 'Motiv';

  @override
  String get themeSystem => 'Systém';

  @override
  String get themeLight => 'Světlý';

  @override
  String get themeDark => 'Tmavý';

  @override
  String get defaultCurrencyLabel => 'Výchozí měna';

  @override
  String get defaultUnitLabel => 'Výchozí jednotka';

  @override
  String get keepAwakeLabel => 'Ponechat obrazovku zapnutou během nákupu';

  @override
  String get backupSection => 'Záloha';

  @override
  String get exportBackupLabel => 'Exportovat zálohu';

  @override
  String get importBackupLabel => 'Importovat zálohu';

  @override
  String get mergeImportLabel => 'Sloučit do aktuálních dat';

  @override
  String get separateImportLabel => 'Importovat jako samostatnou kopii';

  @override
  String get importCancelled => 'Import zrušen.';

  @override
  String get backupExported => 'Záloha úspěšně exportována.';

  @override
  String get deleteAllSection => 'Nebezpečná zóna';

  @override
  String get deleteAllLabel => 'Smazat všechna data';

  @override
  String get deleteAllConfirm =>
      'Tímto odstraníte všechny seznamy, historii, fotografie účtenek a ceny. Soubory exportované vámi zůstanou na vašem disku. Pokračovat?';

  @override
  String get deleteAllConfirm2 =>
      'Jste si opravdu jistí? Tato akce je nevratná.';

  @override
  String get cancelAction => 'Zrušit';

  @override
  String get confirmDelete => 'Trvale smazat';

  @override
  String get dataDeleted => 'Všechna lokální data byla smazána.';

  @override
  String get privacyInfoLabel => 'Ochrana soukromí';

  @override
  String get privacyInfoBody =>
      'Vaše seznamy, ceny, účtenky a fotografie zůstávají ve vašem zařízení. Fotografie a hlas nikdy neopustí vaše zařízení. Když je AI nápověda zapnutá, na náš server se odesílá pouze text (například řádky z účtenky nebo to, co jste diktovali) k zpracování a není ukládán.';

  @override
  String get aboutSection => 'O aplikaci';

  @override
  String get aboutPublisher => 'Vydavatel: Crazy Penguin';

  @override
  String get aboutLicenses => 'Licence (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Hlasový vstup';

  @override
  String get voiceStatusUnknown => 'Služba: neověřeno';

  @override
  String get permissionsLabel => 'Oprávnění';

  @override
  String get permissionsBody =>
      'Kamera, mikrofon a oznámení jsou vyžadována pouze tehdy, když tyto funkce skutečně používáte.';

  @override
  String get unitsSection => 'Výchozí hodnoty';

  @override
  String get roundingNote =>
      'Zaokrouhlování peněz se řídí jedním pravidlem: půlky se zaokrouhlují směrem od nuly, uplatní se jednou při převodu na peníze.';

  @override
  String get voiceInputTitle => 'Hlasový vstup';

  @override
  String get voiceStartListening => 'Začít poslouchat';

  @override
  String get voiceTranscriptLabel => 'Text';

  @override
  String get parseAction => 'Zpracovat';

  @override
  String get receiptReviewTitle => 'Zkontrolovat účtenku';

  @override
  String get receiptTotal => 'Celkem za účtenku';

  @override
  String get receiptTotalUnknown => 'Celková částka nebyla zjištěna';

  @override
  String get receiptDiff => 'Rozdíl';

  @override
  String get acceptLine => 'Přijmout řádek';

  @override
  String get ignoreLine => 'Ignorovat řádek';

  @override
  String get receiptLineActions => 'Odkaz na položku, rozdělit nebo ignorovat';

  @override
  String get receiptCommit => 'Přijmout vše';

  @override
  String get receiptCommitted => 'Účtenka byla aplikována.';

  @override
  String get priceHistoryTitle => 'Historie cen';

  @override
  String get noObservations => 'Zatím žádné pozorování cen';

  @override
  String get templatesSection => 'Šablony';

  @override
  String get templateHint => 'Vytvořit nový plán z předchozího nákupu';

  @override
  String get scanReceiptAction => 'Skenovat účtenku';

  @override
  String get fromReceiptListButton => 'Z účtenky';

  @override
  String get shelfLabelAction => 'Cena z cedulky na polici';

  @override
  String get priceCandidatesTitle => 'Kandidáti na cenu';

  @override
  String get noPriceCandidates =>
      'Nebyla nalezena žádná cena; zadejte ji ručně.';

  @override
  String get voiceUnavailable =>
      'Rozpoznávání hlasu není k dispozici; zadejte ručně.';

  @override
  String get linkToItem => 'Odkaz na položku';

  @override
  String get splitLine => 'Rozdělit na dvě části';

  @override
  String get mergeWithNext => 'Sloučit s další';

  @override
  String get ocrNoText => 'Nebyl přečten žádný text; zkuste to znovu.';

  @override
  String get priceHistoryAction => 'Historie cen';

  @override
  String get itemsEmptyTitle => 'Zatím žádné položky';

  @override
  String get itemsEmptyBody =>
      'Přidejte svou první položku — skutečné ceny zadáte přímo v obchodě.';

  @override
  String get addItemTooltip => 'Přidat položku';

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
  String get unitKutu => 'krabice';

  @override
  String get unitSise => 'láhev';

  @override
  String get unitKavanoz => 'sklenice';

  @override
  String get unitDemet => 'svazek';

  @override
  String get unitDuzine => 'dvanáct';

  @override
  String get unitMetre => 'm';

  @override
  String get unitCustom => 'Vlastní';

  @override
  String get setReminderAction => 'Nastavit připomínku';

  @override
  String get reminderPermissionDenied =>
      'Pro připomínky je vyžadován souhlas s notifikacemi. Můžete jej povolit v nastavení systému.';

  @override
  String get reminderScheduled => 'Připomínka nastavena.';

  @override
  String get reminderCancelled => 'Připomínka odebrána.';

  @override
  String get reminderTitle => 'Připomínka nákupu';

  @override
  String reminderBody(Object title) {
    return 'Čas podívat se na seznam: $title';
  }

  @override
  String get reminderPickDate => 'Vyberte datum';

  @override
  String get reminderPickTime => 'Vyberte čas';

  @override
  String get itemDetailsSection => 'Detaily';

  @override
  String get priceOptionalHint => 'Volitelné — skutečnou cenu zadáte v obchodě';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Plánováno: $total · $count položek';
  }

  @override
  String get proActiveLabel => 'Pro aktivní — děkujeme!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Žádné reklamy · Záloha, export a import · Měsíční';

  @override
  String get proBenefitNoAds => 'Provoz bez reklam';

  @override
  String get proBenefitBackup => 'Záloha (export/import)';

  @override
  String aboutVersion(Object version) {
    return 'Verze $version';
  }

  @override
  String get navDiscover => 'Objevovat';

  @override
  String get shareAction => 'Sdílet aplikaci';

  @override
  String get rateAction => 'Ohodnotit nás';

  @override
  String get aboutOpenRow => 'O aplikaci & open source';

  @override
  String get voiceAddItemAction => 'Přidat hlasem';

  @override
  String get formatLocaleLabel => 'Formát čísel a měny';

  @override
  String get formatLocaleSystem =>
      'Formát systému zařízení (latinské číslice; jinak anglicky)';

  @override
  String get formatLocaleTr => 'Turečtina (1.234,56)';

  @override
  String get formatLocaleEn => 'Angličtina (1,234.56)';

  @override
  String get aiToggleTitle => 'Nápověda AI';

  @override
  String get aiToggleSubtitle =>
      'Párování účtenek, čtení cenovek a převět vět na seznamy. Fotky a hlas zůstávají ve vašem zařízení; zpracovává se pouze text.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Vyčerpali jste měsíční limit AI požadavků ($used/$limit). Zvyšte limit nebo pokračujte bez AI.';
  }

  @override
  String get aiOffline => 'Bez připojení — pokračování bez AI.';

  @override
  String get aiFailed => 'AI je momentálně nedostupná — pokračování bez ní.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'Zařízení';

  @override
  String get quickListAction => 'Přidat z věty';

  @override
  String get quickListTitle => 'Rychlý seznam';

  @override
  String get quickListHint => 'např. 1 kg jablek 20, 2 chleby, půl kila sýra';

  @override
  String get quickListConvert => 'Převést na seznam';

  @override
  String quickListAdd(int count) {
    return 'Přidat $count položek';
  }

  @override
  String get quickListEmpty =>
      'Nebyly nalezeny žádné položky. Zkuste je vypsat oddělené čárkami.';

  @override
  String get receiptAiMatched =>
      'AI spárovala účtenku s vaším seznamem. Zkontrolujte propojení a potvrďte.';

  @override
  String get receiptNeedsCheck => 'Zkontrolovat toto spárování';

  @override
  String get receiptDiscountLine => 'Sleva';

  @override
  String get compareItem => 'Položka';

  @override
  String get compareEstimated => 'Odhad';

  @override
  String get compareActual => 'Skutečnost';

  @override
  String get compareDiff => 'Rozdíl';

  @override
  String get compareTotal => 'Celkem';

  @override
  String get compareBudget => 'Rozpočet';

  @override
  String get compareNotBought => 'nekoupeno';

  @override
  String get compareUnplanned => 'neplánováno';

  @override
  String get pricierItems => 'Dražší položky';

  @override
  String get cheaperItems => 'Lacinější položky';

  @override
  String get compareAction => 'Porovnat';

  @override
  String get detailsSection => 'Detaily';

  @override
  String get spendingTitle => 'Výdaje';

  @override
  String get spendingAction => 'Výdaje';

  @override
  String get spendingMonthTotal => 'Tento měsíc';

  @override
  String get spendingWeekly => 'Týdenní výdaje';

  @override
  String get spendingMonthly => 'Měsíční výdaje';

  @override
  String get monthlyLimitTitle => 'Měsíční limit';

  @override
  String get monthlyLimitHelp => 'Kolik chcete utratit za nákupy měsíčně?';

  @override
  String get monthlyLimitRemove => 'Odebrat';

  @override
  String get monthlyLimitSet => 'Nastavit';

  @override
  String get monthlyLimitChange => 'Změnit';

  @override
  String get monthlyLimitNone =>
      'Nastavte si měsíční limit a uvidíte, kolik vám zbývá.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount nad limitem';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return '$amount zbývá tento měsíc';
  }

  @override
  String get plansTitle => 'Plány';

  @override
  String get plansHeadline => 'Nakupujte chytřeji s AI';

  @override
  String get plansSubhead =>
      'Párování účtenek, čtení cenovek a seznamy z věty. Zrušení kdykoli.';

  @override
  String get plansMonthly => 'Měsíční';

  @override
  String get plansYearly => 'Roční';

  @override
  String get planFree => 'Zdarma';

  @override
  String get planFreePrice => 'Navždy zdarma';

  @override
  String get planFreeAi => '10 AI požadavků měsíčně';

  @override
  String get planFreeAds => 'Malé bannerové reklamy (žádné v prvních 7 dnech)';

  @override
  String get planCoreFeatures => 'Seznamy, ceny, účtenky, grafy výdajů';

  @override
  String get plansPerYear => '/ rok';

  @override
  String get plansPerMonth => '/ měsíc';

  @override
  String get planTrial => 'Zkušební období zdarma';

  @override
  String get planProAi => '100 AI požadavků měsíčně';

  @override
  String get planNoAds => 'Žádné reklamy';

  @override
  String get planBackup => 'Záloha, export a import';

  @override
  String get planMaxAi => '300 AI požadavků měsíčně';

  @override
  String get planMaxFamily => 'Pro nákupy velké rodiny';

  @override
  String get plansStoreUnavailable => 'Obchod je právě nedostupný.';

  @override
  String get retryAction => 'Zkusit znovu';

  @override
  String get plansPurchaseFailed =>
      'Nákup se nepodařil. Zkuste to prosím znovu.';

  @override
  String get plansRestore => 'Obnovit nákupy';

  @override
  String get plansLegal =>
      'Pro se automaticky obnovuje každý rok až do zrušení a zahrnuje 100 AI požadavků měsíčně. Základní cena je 1 americký dolar ročně bez příslušných daní; před potvrzením nákupu zkontrolujte konečnou místní cenu a daně v obchodě. Předplatné spravujte nebo zrušte v Google Play.';

  @override
  String get planCurrent => 'Aktuální';

  @override
  String get planStartTrial => 'Zahájit zkušební období zdarma';

  @override
  String get planChoose => 'Vybrat';

  @override
  String get plansAction => 'Plány: Pro';

  @override
  String get assistantTitle => 'Asistent';

  @override
  String get assistantGreeting => 'Ahoj! Co bys chtěl dělat?';

  @override
  String get assistantNewList => 'Nový seznam';

  @override
  String get assistantVoiceList => 'Seznam hlasem';

  @override
  String get assistantTextList => 'Seznam ze věty';

  @override
  String get assistantScanReceipt => 'Skenovat účtenku';

  @override
  String get assistantSpending => 'Moje výdaje';

  @override
  String get assistantReceiptHint =>
      'Otevři svůj seznam a klepni na ikonu účtenky pro skenování.';

  @override
  String get assistantToggleTitle => 'Zobrazit asistenta';

  @override
  String get assistantToggleSubtitle => 'Malý pomocník v pravém dolním rohu';

  @override
  String get scanPriceLabel => 'Skenovat cenovou etiketu';

  @override
  String get saveFailed =>
      'Uložení se nezdařilo. Změny zůstávají. Zkuste to prosím znovu.';

  @override
  String get deleteItemConfirm => 'Smazat tuto položku a zaznamenané nákupy?';

  @override
  String get clearPurchaseConfirm =>
      'Odebrat zaškrtnutí této položky a odstranit zaznamenané nákupy?';

  @override
  String get reportPdfAction => 'Uložit PDF report';

  @override
  String get reportNotInvoice =>
      'Souhrn nákupů, ne daňový doklad. Daňové sazby nejsou známy.';

  @override
  String get purchaseVisits => 'Nákupní návštěvy';

  @override
  String get purchaseInterval => 'Průměrný počet dní mezi nákupy';

  @override
  String get purchasedQuantity => 'Koupěné množství';

  @override
  String get purchaseAnalyticsHint =>
      'Nákupy neměřují spotřebu. Měny a jednotky jsou zobrazovány odděleně.';

  @override
  String get receiptReplaces =>
      'Položky bez ceny se doplní. Položky, které už mají tržní cenu, se přidají jako samostatné nákupy.';

  @override
  String get receiptIncompleteHeader =>
      'Do další fotografie zahrňte obchod, datum, čas a číslo účtenky.';

  @override
  String get receiptIncompleteTail =>
      'Vyfoťte další část s několika překrývajícími se položkami a konečným součtem.';

  @override
  String get receiptContinuationRejected =>
      'Tuto fotografii se nepodařilo připojit k účtence. Vyfoťte ji znovu tak, aby se překrývala s položkami ze stejné účtenky.';

  @override
  String get receiptDraftSaved =>
      'Účtenka byla uložena jako koncept. Můžete pokračovat později.';

  @override
  String get receiptContinueAction => 'Pokračovat v účtence';

  @override
  String get receiptDraftsTitle => 'Nedokončené účtenky';

  @override
  String get receiptDuplicate => 'Tato účtenka už byla přidána.';

  @override
  String get receiptTotalMismatch =>
      'Položky neodpovídají celkové částce na účtence. Zkontrolujte, zda je vidět celá účtenka.';

  @override
  String get receiptSaveDraftAction => 'Uložit na později';

  @override
  String get receiptResolveLines =>
      'Před uložením přijměte nebo ignorujte každou položku.';

  @override
  String get receiptPartialConfirm =>
      'Přidají se pouze vybrané položky. Tato účtenka bude označena jako importovaná. Pokračovat?';

  @override
  String get voiceUnsupportedLanguage =>
      'Tento jazyk není na tomto zařízení dostupný pro hlasový vstup. Můžete místo toho psát.';

  @override
  String get voiceStopListening => 'Přestat poslouchat';

  @override
  String get keepAwakeFailed =>
      'Nepodařilo se udržet obrazovku zapnutou. Zkuste to prosím znovu.';

  @override
  String get purchaseHistoryHint =>
      'Všechny dokončené nákupy. Vrácení zboží snižuje celkové částky. Data se vztahují k dokončení nákupu. Jedna návštěva nestačí k výpočtu průměrného intervalu.';

  @override
  String get planLegacyRights =>
      'Stávající předplatné Pro a Max si zachovávají původní měsíční limit AI požadavků.';

  @override
  String get csvExportAction => 'Exportovat CSV';

  @override
  String get backupSizeWarning =>
      'JSON obsahuje záznamy, nikoliv soubory fotografií. Limit importu: 16 MB.';

  @override
  String get backupImportFailed =>
      'Tuto zálohu se nepodařilo importovat. Vaše data nebyla změněna.';

  @override
  String get backupImported => 'Záloha byla úspěšně importována.';

  @override
  String backupPreviewCounts(Object entries, Object items, Object lists) {
    return '$lists seznamy · $items položky · $entries nákupy';
  }

  @override
  String get voiceModelDownloading =>
      'Hlasový model pro tento jazyk se stahuje. Zkuste to znovu za minutu.';

  @override
  String get historyThisWeek => 'Tento týden';

  @override
  String get historyProductsSection => 'Koupené produkty';

  @override
  String get tipReceiptScan => 'Naskenujte účtenku a spárujte ceny se seznamem';

  @override
  String get tipVoiceAdd =>
      'Řekněte jednu nebo více položek a před přidáním je zkontrolujte';

  @override
  String get tipShelfCamera => 'Přečtěte cenu z cenovky na regálu fotoaparátem';

  @override
  String get tipPlan =>
      'Váš tarif: zobrazte podrobnosti, předplaťte si nebo přejděte na vyšší';

  @override
  String get guideAddBody =>
      'Klepnutím na + přidáte položku. Plánovanou cenu zadejte hned a tržní cenu u pokladny.';

  @override
  String get guideVoiceBody =>
      'Klepněte na mikrofon a řekněte položky, například: \'1 kilo jablek, 1 chleba\'.';

  @override
  String get guideReceiptBody =>
      'Naskenujte účtenku a spárujte její ceny s položkami na seznamu.';

  @override
  String get guidePlanBody =>
      'Klepnutím na ikonu tarifu zobrazíte tarif, předplatíte si ho nebo přejdete na vyšší.';

  @override
  String get guideNext => 'OK';

  @override
  String get guideDone => 'Začít';

  @override
  String get paletteLabel => 'Barevný motiv';

  @override
  String get paletteForest => 'Les';

  @override
  String get paletteOcean => 'Oceán';

  @override
  String get paletteSunset => 'Západ slunce';

  @override
  String get paletteLavender => 'Levandule';

  @override
  String get darkBlackLabel => 'Čistě černá v tmavém motivu';

  @override
  String get spendingOverview => 'Přehled';

  @override
  String get spendingThisYear => 'Tento rok';

  @override
  String get spendingYearly => 'Roční výdaje';

  @override
  String get productSpending => 'Výdaje podle produktu';

  @override
  String get spanWeek => 'Týden';

  @override
  String get spanMonth => 'Měsíc';

  @override
  String get spanYear => 'Rok';

  @override
  String get weeklyLimitTitle => 'Týdenní limit';

  @override
  String get weeklyLimitHelp => 'Kolik chcete týdně utratit za nákupy?';

  @override
  String get weeklyLimitNone =>
      'Nastavte týdenní limit a uvidíte, kolik zbývá.';

  @override
  String weeklyLimitLeft(String amount) {
    return 'Tento týden zbývá $amount';
  }

  @override
  String get shoppingLimitTitle => 'Limit na nákup';

  @override
  String get shoppingLimitHelp => 'Nové seznamy začínají s tímto rozpočtem.';

  @override
  String get shoppingLimitNone =>
      'Nastavte výchozí rozpočet pro každý nový nákup.';

  @override
  String get monthlyReportAction => 'Měsíční přehled';

  @override
  String get reportShoppingColumn => 'Nákup';

  @override
  String get reportDateColumn => 'Datum';

  @override
  String get planUnavailable => 'Momentálně není v obchodě k dispozici';

  @override
  String get demoDataTitle => 'Ukázková data';

  @override
  String get demoDataLoad => 'Vyzkoušet s ukázkovými daty';

  @override
  String get demoDataLoadHelp =>
      'Přidá ukázkové nákupy za 12 měsíců, abyste viděli historii, grafy a vývoj cen.';

  @override
  String get demoDataRemove => 'Odstranit ukázková data';

  @override
  String get demoDataAdded => 'Ukázková data přidána';

  @override
  String get demoDataRemoved => 'Ukázková data odstraněna';

  @override
  String get demoProductApple => 'Jablka';

  @override
  String get demoProductBread => 'Chléb';

  @override
  String get demoProductMilk => 'Mléko';

  @override
  String get demoProductCheese => 'Sýr';

  @override
  String get demoProductTomato => 'Rajčata';

  @override
  String get demoProductEggs => 'Vejce';

  @override
  String get demoProductCoffee => 'Káva';

  @override
  String get demoProductDetergent => 'Prací prostředek';

  @override
  String get sendAction => 'Send';

  @override
  String get previousMonthAction => 'Previous month';

  @override
  String get nextMonthAction => 'Next month';

  @override
  String get helpSection => 'Nápověda a podpora';

  @override
  String get howToUseLabel => 'Jak používat';

  @override
  String get guidePricesBody =>
      'Cena v obchodě označí položku jako koupenou; počítá se i 0. Domácí cena je volitelná. Vymazáním ceny v obchodě zrušíte zaškrtnutí.';

  @override
  String get shoppingDateLabel => 'Datum nákupu';

  @override
  String get shoppingDateNone => 'Není vybráno datum';

  @override
  String get clearShoppingDateAction => 'Vymazat datum';

  @override
  String get listSortLabel => 'Pořadí seznamu';

  @override
  String get listSortDate => 'Datum nákupu';

  @override
  String get listSortAz => 'Název (A–Z)';

  @override
  String get listSortManual => 'Ruční pořadí';

  @override
  String get imageCameraAction => 'Vyfotit';

  @override
  String get imageGalleryAction => 'Vybrat z fotek';

  @override
  String get imageCaptureFailed =>
      'Fotoaparát nebo fotky se nepodařilo otevřít. Zkontrolujte oprávnění k přístupu a zkuste to znovu.';

  @override
  String get imageRecognitionFailed =>
      'Fotku se nepodařilo zpracovat. Zkuste jinou fotku.';

  @override
  String get receiptNoProducts =>
      'Text byl přečten, ale položky účtenky nebyly nalezeny. Zahrňte do fotky položky i celkovou částku.';

  @override
  String get keepAwakeOn => 'Obrazovka zůstane zapnutá';

  @override
  String get keepAwakeOff => 'Obrazovka se může vypnout';

  @override
  String get spanDay => 'Den';

  @override
  String get spanCustom => 'Rozmezí dat';

  @override
  String get reportTotalSpent => 'Celkem utraceno';

  @override
  String get reportAddedAt => 'Přidáno';

  @override
  String get reportReceiptNumber => 'Číslo účtenky';

  @override
  String get reportPreview => 'Náhled';

  @override
  String get reportShareAction => 'Sdílet';

  @override
  String get previousPeriodAction => 'Předchozí období';

  @override
  String get nextPeriodAction => 'Následující období';

  @override
  String get reportSaved => 'Zpráva byla uložena.';

  @override
  String get reportZoom => 'Přiblížit';

  @override
  String planTrialDaysLeft(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '# dní zbývá',
      few: '# dny zbývají',
      one: '# den zbývá',
    );
    return '$_temp0';
  }

  @override
  String planTrialHoursLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '# hodin zbývá',
      few: '# hodiny zbývají',
      one: '# hodina zbývá',
    );
    return '$_temp0';
  }

  @override
  String get planTrialEndedTitle => 'Zkušební období Pro skončilo';

  @override
  String get planTrialEndedBody =>
      'Seznamy, ruční zadávání i hlasové funkce v zařízení můžete dál používat zdarma. Bezplatný tarif zahrnuje 10 požadavků na AI za kalendářní měsíc. Zvolte roční Pro pro 100 požadavků na AI měsíčně, bez reklam a se zálohami. Vaše stávající data vám zůstanou.';

  @override
  String get planContinueFree => 'Pokračovat zdarma';

  @override
  String get supportIdLabel => 'ID podpory';

  @override
  String get supportEmailLabel => 'Podpora e-mailem';
}
