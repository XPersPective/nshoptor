// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Plan derhjemme. Handl som planlagt.';

  @override
  String get listsTitle => 'Lister';

  @override
  String get listsTabActive => 'Aktive';

  @override
  String get listsTabCompleted => 'Færdige';

  @override
  String get listsTabArchived => 'Arkiverede';

  @override
  String get newListButton => 'Ny liste';

  @override
  String get listTitleHint => 'Titel (valgfrit)';

  @override
  String get saveButton => 'Gem';

  @override
  String get cancelButton => 'Annuller';

  @override
  String get deleteButton => 'Slet';

  @override
  String get editAction => 'Rediger';

  @override
  String get listDeleted => 'Liste slettet';

  @override
  String get invalidAmountError => 'Ugyldigt beløb';

  @override
  String get duplicateAction => 'Dupliker';

  @override
  String get archiveAction => 'Arkivér';

  @override
  String get unarchiveAction => 'Afkurvér';

  @override
  String get deleteListConfirm =>
      'Slet denne liste? Dine planlagte varer fjernes også.';

  @override
  String get undoButton => 'Fortryd';

  @override
  String get searchListHint => 'Søg i lister';

  @override
  String get currencyLabel => 'Valuta';

  @override
  String get budgetLabel => 'Budget (valgfrit)';

  @override
  String get noteLabel => 'Note (valgfrit)';

  @override
  String get storeLabel => 'Butik';

  @override
  String get keepAmountsAction => 'Behold beløb';

  @override
  String get resetAmountsAction => 'Nulstil beløb';

  @override
  String get currencyChangeWarning =>
      'Valutaen ændres. Hvad skal der ske med de eksisterende beløb?';

  @override
  String get listsEmpty => 'Ingen lister endnu. Opret din første indkøbsplan.';

  @override
  String get statusDraft => 'Kladde';

  @override
  String get statusPlanned => 'Planlagt';

  @override
  String get statusShopping => 'Undervejs';

  @override
  String get statusCompleted => 'Færdig';

  @override
  String get statusArchived => 'Arkiveret';

  @override
  String autoListTitle(String date) {
    return '$date indkøb';
  }

  @override
  String get itemFormTitle => 'Tilføj vare';

  @override
  String get itemNameLabel => 'Varenavn';

  @override
  String get brandLabel => 'Mærke / variant (valgfrit)';

  @override
  String get categoryLabel => 'Kategori';

  @override
  String get quantityLabel => 'Antal';

  @override
  String get unitLabel => 'Enhed';

  @override
  String get pricingModeLabel => 'Prisindtastning';

  @override
  String get pricingModeUnitPrice => 'Enhedspris';

  @override
  String get pricingModeLineTotal => 'Linjesum';

  @override
  String get plannedPriceLabel => 'Planlagt pris';

  @override
  String lineTotalCalculated(String value) {
    return 'Linjesum: $value';
  }

  @override
  String get requiredItemToggle => 'Påkrævet vare';

  @override
  String get maxPriceLabel => 'Maksimal acceptabel pris (valgfrit)';

  @override
  String get itemNoteLabel => 'Note (valgfrit)';

  @override
  String get categoryProduce => 'Frugt & grønt';

  @override
  String get categoryDairy => 'Mejeri';

  @override
  String get categoryMeat => 'Kød';

  @override
  String get categoryBakery => 'Bagværk';

  @override
  String get categoryDrinks => 'Drikkevarer';

  @override
  String get categoryCleaning => 'Rengøring';

  @override
  String get categoryPersonalCare => 'Personlig pleje';

  @override
  String get categoryHome => 'Husstand';

  @override
  String get categoryOther => 'Andet';

  @override
  String get invalidQuantityError => 'Ugyldigt antal';

  @override
  String get invalidPriceError => 'Ugyldig pris';

  @override
  String get invalidNameError => 'Indtast et navn';

  @override
  String unitPriceCalculated(String value) {
    return 'Enhedspris: $value';
  }

  @override
  String get shoppingTitle => 'Indkøbstilstand';

  @override
  String get summaryPlannedTotal => 'Planlagt';

  @override
  String get summaryInCart => 'I kurven';

  @override
  String get summaryRemainingPlan => 'Resterende plan';

  @override
  String get summaryProjected => 'Estimeret samlet beløb';

  @override
  String get summaryBudgetRemaining => 'Budget tilbage';

  @override
  String get summaryBudgetOver => 'Over budget';

  @override
  String itemsProgress(String done, String total) {
    return '$done af $total varer';
  }

  @override
  String get filterAll => 'Alle';

  @override
  String get filterToBuy => 'Skal købes';

  @override
  String get filterInCart => 'I kurven';

  @override
  String get filterNotFound => 'Ikke fundet';

  @override
  String get filterRequired => 'Påkrævet';

  @override
  String get quickEntryTitle => 'Faktisk pris';

  @override
  String get actualQuantityLabel => 'Faktisk mængde';

  @override
  String get actualPriceLabel => 'Faktisk pris';

  @override
  String get discountLabel => 'Rabat (valgfrit)';

  @override
  String get alternativeNameLabel => 'Alternativt produktnavn (valgfrit)';

  @override
  String get savePurchaseButton => 'Tilføj til kurv';

  @override
  String get unplannedAddButton => 'Tilføj uplanlagt vare';

  @override
  String get statusPending => 'Ikke taget';

  @override
  String get statusInCart => 'I kurven';

  @override
  String get statusNotFound => 'Ikke fundet';

  @override
  String get statusGaveUp => 'Opdaget';

  @override
  String get statusAlternative => 'Alternativ købt';

  @override
  String get keepScreenAwake => 'Hold skærmen vågen';

  @override
  String get finishShopping => 'Afslut indkøb';

  @override
  String get completionWarning =>
      'Der mangler eller er ukontrollerede poster. Du kan stadig afslutte; resultatet vil notere dem.';

  @override
  String get continueShoppingButton => 'Fortsæt med at handle';

  @override
  String get resultTitle => 'Resultat';

  @override
  String get summarySection => 'Oversigt';

  @override
  String get plannedTotalLabel => 'Planlagt total';

  @override
  String get actualTotalLabel => 'Faktisk total';

  @override
  String get varianceLabel => 'Forskel';

  @override
  String get varianceNotComputable => 'Kan ikke beregnes';

  @override
  String get budgetStatusLabel => 'Budget';

  @override
  String get savingsLabel => 'Under plan';

  @override
  String get overspendLabel => 'Over plan';

  @override
  String get unplannedTotalLabel => 'Uplanlagt total';

  @override
  String get unpurchasedLabel => 'Planlagt, men ikke købt';

  @override
  String get totalDiscountLabel => 'Samlede rabatter';

  @override
  String get accuracyLabel => 'Estimatnøjagtighed';

  @override
  String get groupsSection => 'Varer';

  @override
  String get groupPricier => 'Dyere end planlagt';

  @override
  String get groupCheaper => 'Billigere end planlagt';

  @override
  String get groupClose => 'Tæt på estimat';

  @override
  String get groupNotTaken => 'Planlagt, ikke købt';

  @override
  String get groupUnplanned => 'Købt uden plan';

  @override
  String get groupQuantityChanged => 'Mængde ændret';

  @override
  String get groupUnverified => 'Ikke verificeret';

  @override
  String get plannedQtyLabel => 'Planlagt mængde';

  @override
  String get actualQtyLabel => 'Faktisk mængde';

  @override
  String get plannedUnitPriceLabel => 'Planlagt enhedspris';

  @override
  String get actualUnitPriceLabel => 'Faktisk enhedspris';

  @override
  String get lineVarianceLabel => 'Linjeforskel';

  @override
  String get discountEffectLabel => 'Rabatteffekt';

  @override
  String get notBoughtMark => 'ikke købt';

  @override
  String get noPurchasesNote => 'Der blev ikke registreret nogen køb.';

  @override
  String get navHome => 'Hjem';

  @override
  String get navLists => 'Lister';

  @override
  String get navHistory => 'Historik';

  @override
  String get navSettings => 'Indstillinger';

  @override
  String get homeEmptyTitle => 'Planlæg din indkøb';

  @override
  String get homeEmptyBody =>
      'Opret din første liste og sammenlign planlagte med faktiske omkostninger.';

  @override
  String get homeActiveSection => 'Aktive lister';

  @override
  String get homeCompletedSection => 'Nyligt afsluttet';

  @override
  String get homeMonthlySection => 'Denne måned';

  @override
  String get monthPlannedLabel => 'Planlagt';

  @override
  String get monthActualLabel => 'Faktisk';

  @override
  String get monthVarianceLabel => 'Forskel';

  @override
  String get continueShoppingLabel => 'Fortsæt med at handle';

  @override
  String get historyEmpty =>
      'Ingen afsluttede indkøb endnu. Din historik og indsigt vises her.';

  @override
  String get aboutTabTitle => 'Om NShoptor';

  @override
  String get aboutBody =>
      'NShoptor af Crazy Penguin. Offline-first indkøbsplanlægger. Licenseret under GPL-3.0.';

  @override
  String get startShoppingLabel => 'Start indkøb';

  @override
  String get finishAndSeeResult => 'Afslut & se resultat';

  @override
  String get settingsTitle => 'Indstillinger';

  @override
  String get languageLabel => 'Sprog';

  @override
  String get languageSystem => 'System';

  @override
  String get languageTr => 'Tyrkisk';

  @override
  String get languageEn => 'Engelsk';

  @override
  String get themeLabel => 'Tema';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Lyst';

  @override
  String get themeDark => 'Mørkt';

  @override
  String get defaultCurrencyLabel => 'Standard valuta';

  @override
  String get defaultUnitLabel => 'Standard enhed';

  @override
  String get keepAwakeLabel => 'Hold skærmen tændt under indkøb';

  @override
  String get backupSection => 'Backup';

  @override
  String get exportBackupLabel => 'Eksporter backup';

  @override
  String get importBackupLabel => 'Importer backup';

  @override
  String get mergeImportLabel => 'Flet til nuværende data';

  @override
  String get separateImportLabel => 'Importer som en separat kopi';

  @override
  String get importCancelled => 'Import annulleret.';

  @override
  String get backupExported => 'Backup eksporteret succesfuldt.';

  @override
  String get deleteAllSection => 'Farlig zone';

  @override
  String get deleteAllLabel => 'Slet alle data';

  @override
  String get deleteAllConfirm =>
      'Dette vil fjerne alle lister, historik, kvitteringsfotos og priser. Filer, du har eksporteret, bliver på din harddisk. Fortsæt?';

  @override
  String get deleteAllConfirm2 =>
      'Er du helt sikker? Denne handling kan ikke fortrydes.';

  @override
  String get cancelAction => 'Annuller';

  @override
  String get confirmDelete => 'Slet permanent';

  @override
  String get dataDeleted => 'Alle lokale data blev slettet.';

  @override
  String get privacyInfoLabel => 'Privatliv';

  @override
  String get privacyInfoBody =>
      'Dine lister, priser, kvitteringer og fotos bliver på din enhed. Fotos og stemme forlader aldrig den. Når AI-hjælp er aktiveret, sendes kun tekst (f.eks. kvitteringslinjer eller det, du har dikteret) til vores server til behandling og gemmes ikke.';

  @override
  String get aboutSection => 'Om';

  @override
  String get aboutPublisher => 'Udgiver: Crazy Penguin';

  @override
  String get aboutLicenses => 'Licenser (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Stemmeinput';

  @override
  String get voiceStatusUnknown => 'Service: ikke tjekket';

  @override
  String get permissionsLabel => 'Tilladelser';

  @override
  String get permissionsBody =>
      'Kamera, mikrofon og notifikationer anmodes kun, når du faktisk bruger disse funktioner.';

  @override
  String get unitsSection => 'Standarder';

  @override
  String get roundingNote =>
      'Runding af penge følger én regel: halve tal rundes væk fra nul, anvendes én gang ved konvertering af penge.';

  @override
  String get voiceInputTitle => 'Stemmeinput';

  @override
  String get voiceStartListening => 'Start lytning';

  @override
  String get voiceTranscriptLabel => 'Transskription';

  @override
  String get parseAction => 'Fortolk';

  @override
  String get receiptReviewTitle => 'Gennemse kvittering';

  @override
  String get receiptTotal => 'Kvittering i alt';

  @override
  String get receiptTotalUnknown => 'Total ikke registreret';

  @override
  String get receiptDiff => 'Forskel';

  @override
  String get acceptLine => 'Acceptér linje';

  @override
  String get ignoreLine => 'Ignorer linje';

  @override
  String get receiptLineActions => 'Link til vare, del eller ignorer';

  @override
  String get receiptCommit => 'Acceptér alle';

  @override
  String get receiptCommitted => 'Kvittering anvendt.';

  @override
  String get priceHistoryTitle => 'Prishistorik';

  @override
  String get noObservations => 'Ingen prisobservationer endnu';

  @override
  String get templatesSection => 'Skabeloner';

  @override
  String get templateHint => 'Opret en ny indkøbsliste fra en tidligere tur';

  @override
  String get scanReceiptAction => 'Scan kvittering';

  @override
  String get shelfLabelAction => 'Pris fra hyldemærke';

  @override
  String get priceCandidatesTitle => 'Priskandidater';

  @override
  String get noPriceCandidates => 'Ingen pris fundet; skriv den manuelt.';

  @override
  String get voiceUnavailable => 'Talegenkendelse utilgængelig; skriv manuelt.';

  @override
  String get linkToItem => 'Link til vare';

  @override
  String get splitLine => 'Del i to';

  @override
  String get mergeWithNext => 'Sammenflet med næste';

  @override
  String get ocrNoText => 'Ingen tekst læst; prøv igen.';

  @override
  String get priceHistoryAction => 'Prishistorik';

  @override
  String get itemsEmptyTitle => 'Ingen varer endnu';

  @override
  String get itemsEmptyBody =>
      'Tilføj din første vare — du skriver de rigtige priser her i butikken.';

  @override
  String get addItemTooltip => 'Tilføj vare';

  @override
  String get unitAdet => 'stk';

  @override
  String get unitKilogram => 'kg';

  @override
  String get unitGram => 'g';

  @override
  String get unitLitre => 'L';

  @override
  String get unitMililitre => 'ml';

  @override
  String get unitPaket => 'pakke';

  @override
  String get unitKutu => 'æske';

  @override
  String get unitSise => 'flaske';

  @override
  String get unitKavanoz => 'glas';

  @override
  String get unitDemet => 'bundt';

  @override
  String get unitDuzine => 'dutz.';

  @override
  String get unitMetre => 'm';

  @override
  String get unitCustom => 'Brugerdefineret';

  @override
  String get setReminderAction => 'Indstil påmindelse';

  @override
  String get reminderPermissionDenied =>
      'Notifikationstilladelse er påkrævet for påmindelser. Du kan aktivere det i systemindstillingerne.';

  @override
  String get reminderScheduled => 'Påmindelse indstillet.';

  @override
  String get reminderCancelled => 'Påmindelse fjernet.';

  @override
  String get reminderTitle => 'Indkøbspåmindelse';

  @override
  String reminderBody(Object title) {
    return 'Det er tid til at tjekke din liste: $title';
  }

  @override
  String get reminderPickDate => 'Vælg en dato';

  @override
  String get reminderPickTime => 'Vælg et tidspunkt';

  @override
  String get itemDetailsSection => 'Detaljer';

  @override
  String get priceOptionalHint =>
      'Valgfrit — du indtaster den rigtige pris i butikken';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Planlagt: $total · $count varer';
  }

  @override
  String get proActiveLabel => 'Pro aktiv — tak!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Ingen reklamer, mere AI, backup · fra en lille månedlig pris';

  @override
  String get proBenefitNoAds => 'Reklamefri oplevelse';

  @override
  String get proBenefitBackup => 'Backup (eksport/import)';

  @override
  String aboutVersion(Object version) {
    return 'Version $version';
  }

  @override
  String get navDiscover => 'Opdag';

  @override
  String get shareAction => 'Del appen';

  @override
  String get rateAction => 'Bedøm os';

  @override
  String get aboutOpenRow => 'Om & open source';

  @override
  String get voiceAddItemAction => 'Tilføj med stemme';

  @override
  String get formatLocaleLabel => 'Nummer- og valutaformat';

  @override
  String get formatLocaleSystem =>
      'Enhedsformat (Latinske cifre; ellers engelsk)';

  @override
  String get formatLocaleTr => 'Tyrkisk (1.234,56)';

  @override
  String get formatLocaleEn => 'Engelsk (1,234.56)';

  @override
  String get aiToggleTitle => 'AI-hjælp';

  @override
  String get aiToggleSubtitle =>
      'Matcher kvitteringer, læser prislabel og omdanner sætninger til lister. Fotos og stemme bliver på din enhed; kun tekst behandles.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Du har brugt månedens AI-anmodninger ($used/$limit). Opgrader for flere, eller fortsæt uden AI.';
  }

  @override
  String get aiOffline => 'Ingen forbindelse — fortsætter uden AI.';

  @override
  String get aiFailed =>
      'AI er ikke tilgængelig lige nu — fortsætter uden den.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'Enhed';

  @override
  String get quickListAction => 'Tilføj fra en sætning';

  @override
  String get quickListTitle => 'Hurtig liste';

  @override
  String get quickListHint => 'f.eks. 1 kg æbler 20, 2 brød, halvt kilo ost';

  @override
  String get quickListConvert => 'Omdann til en liste';

  @override
  String quickListAdd(int count) {
    return 'Tilføj $count varer';
  }

  @override
  String get quickListEmpty =>
      'Ingen varer fundet. Prøv at opremse dem adskilt af kommaer.';

  @override
  String get receiptAiMatched =>
      'AI matchede kvitteringen med din liste. Tjek linkene og bekræft.';

  @override
  String get receiptNeedsCheck => 'Tjek denne match';

  @override
  String get receiptDiscountLine => 'Rabat';

  @override
  String get compareItem => 'Vare';

  @override
  String get compareEstimated => 'Estimat';

  @override
  String get compareActual => 'Faktisk';

  @override
  String get compareDiff => 'Forskel';

  @override
  String get compareTotal => 'I alt';

  @override
  String get compareBudget => 'Budget';

  @override
  String get compareNotBought => 'ikke købt';

  @override
  String get compareUnplanned => 'ikke planlagt';

  @override
  String get pricierItems => 'Koster mere';

  @override
  String get cheaperItems => 'Koster mindre';

  @override
  String get compareAction => 'Sammenlign';

  @override
  String get detailsSection => 'Detaljer';

  @override
  String get spendingTitle => 'Forbrug';

  @override
  String get spendingAction => 'Forbrug';

  @override
  String get spendingMonthTotal => 'Denne måned';

  @override
  String get spendingWeekly => 'Ugentligt forbrug';

  @override
  String get spendingMonthly => 'Månedligt forbrug';

  @override
  String get monthlyLimitTitle => 'Månedlig grænse';

  @override
  String get monthlyLimitHelp =>
      'Hvor meget vil du bruge på indkøb om måneden?';

  @override
  String get monthlyLimitRemove => 'Fjern';

  @override
  String get monthlyLimitSet => 'Indstil';

  @override
  String get monthlyLimitChange => 'Ændr';

  @override
  String get monthlyLimitNone =>
      'Indstil en månedlig grænse for at se, hvor meget der er tilbage.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount over grænsen';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return '$amount tilbage i denne måned';
  }

  @override
  String get plansTitle => 'Abonnementer';

  @override
  String get plansHeadline => 'Handle smartere med AI';

  @override
  String get plansSubhead =>
      'Kvitteringsmatch, prislabels og lister fra en sætning. Opsig når som helst.';

  @override
  String get plansMonthly => 'Månedlig';

  @override
  String get plansYearly => 'Årlig';

  @override
  String get planFree => 'Gratis';

  @override
  String get planFreePrice => 'Gratis for evigt';

  @override
  String get planFreeAi => '10 AI-anmodninger om måneden';

  @override
  String get planFreeAds => 'Små bannerannoncer (ingen de første 7 dage)';

  @override
  String get planCoreFeatures =>
      'Lister, priser, kvitteringer, forbrugsdiagrammer';

  @override
  String get plansPerYear => '/ år';

  @override
  String get plansPerMonth => '/ måned';

  @override
  String get planTrial => '7 dages gratis prøveperiode';

  @override
  String get planProAi => '100 AI-anmodninger om måneden';

  @override
  String get planNoAds => 'Ingen annoncer';

  @override
  String get planBackup => 'Backup-eksport og -import';

  @override
  String get planMaxAi => '300 AI-anmodninger om måneden';

  @override
  String get planMaxFamily => 'Til store familieshoppingture';

  @override
  String get plansStoreUnavailable => 'Butikken er ikke tilgængelig lige nu.';

  @override
  String get retryAction => 'Prøv igen';

  @override
  String get plansPurchaseFailed =>
      'Købet blev ikke gennemført. Prøv venligst igen.';

  @override
  String get planLifetimeTitle => 'Reklamefri for livet';

  @override
  String get planLifetimeSubtitle =>
      'Engangsbetaling: ingen reklamer, backup; AI forbliver på den gratis tilladelse';

  @override
  String get plansRestore => 'Gendan køb';

  @override
  String get plansLegal =>
      'Abonnementer fornyes automatisk, indtil de opsiges. Opsig når som helst i Google Play › Betalinger og abonnementer. Priserne inkluderer de skatter, der vises af Google Play.';

  @override
  String get planCurrent => 'Nuværende';

  @override
  String get planStartTrial => 'Start 7-dages gratis prøveperiode';

  @override
  String get planChoose => 'Vælg';

  @override
  String get plansAction => 'Planer: Pro og Max';

  @override
  String get assistantTitle => 'Assistent';

  @override
  String get assistantGreeting => 'Hej! Hvad vil du gerne gøre?';

  @override
  String get assistantNewList => 'Ny liste';

  @override
  String get assistantVoiceList => 'Liste ved stemme';

  @override
  String get assistantTextList => 'Liste fra en sætning';

  @override
  String get assistantScanReceipt => 'Skan en kvittering';

  @override
  String get assistantSpending => 'Mine udgifter';

  @override
  String get assistantReceiptHint =>
      'Åbn din liste, og tryk på kvitteringsikonet for at scanne den.';

  @override
  String get assistantToggleTitle => 'Vis assistent';

  @override
  String get assistantToggleSubtitle => 'Den lille hjælper nederst til højre';

  @override
  String get scanPriceLabel => 'Scan prislabel';

  @override
  String get saveFailed =>
      'Kunne ikke gemme. Dine ændringer er stadig her. Prøv venligst igen.';

  @override
  String get deleteItemConfirm =>
      'Slet dette produkt og dets registrerede køb?';

  @override
  String get clearPurchaseConfirm =>
      'Fjern markeringen for dette produkt og fjern dets registrerede køb?';

  @override
  String get reportPdfAction => 'Gem PDF-rapport';

  @override
  String get reportNotInvoice =>
      'Indkøbsoversigt, ikke en momsregning. Momsatsen er ukendt.';

  @override
  String get purchaseVisits => 'Indkøbssøgninger';

  @override
  String get purchaseInterval => 'Gennemsnitlige dage mellem indkøb';

  @override
  String get purchasedQuantity => 'Købt mængde';

  @override
  String get purchaseAnalyticsHint =>
      'Indkøb måler ikke forbrug. Valutaer og enheder vises separat.';

  @override
  String get receiptReplaces =>
      'Linkede kvitteringslinjer erstatter eksisterende køb; ulinkede linjer tilføjes.';

  @override
  String get voiceUnsupportedLanguage =>
      'Dette sprog er ikke tilgængeligt til stemmeinput på denne enhed. Du kan i stedet skrive.';

  @override
  String get voiceStopListening => 'Stop med at lytte';

  @override
  String get keepAwakeFailed =>
      'Skærmen kunne ikke holdes vågen. Prøv venligst igen.';

  @override
  String get purchaseHistoryHint =>
      'Alle gennemførte indkøb. Tilbageleveringer reducerer totalen. Datoerne refererer til afslutning af indkøbet. Et enkelt besøg er ikke nok til at beregne et gennemsnitligt interval.';

  @override
  String get planLegacyRights =>
      'Eksisterende Pro- og Max-abonnementer beholder deres oprindelige månedlige AI-tilladelse. Nye tilbud har 100 og 300 anmodninger.';

  @override
  String get csvExportAction => 'Eksporter CSV';

  @override
  String get backupSizeWarning =>
      'JSON indeholder poster, ikke fotofiler. Importgrænse: 16 MB.';

  @override
  String get backupImportFailed =>
      'Kunne ikke importere denne backup. Dine data er ikke blevet ændret.';

  @override
  String get backupImported => 'Backup importeret succesfuldt.';

  @override
  String backupPreviewCounts(Object entries, Object items, Object lists) {
    return '$lists lister · $items varer · $entries køb';
  }
}
