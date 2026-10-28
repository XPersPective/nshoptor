// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Planera hemma. Handla enligt plan.';

  @override
  String get listsTitle => 'Listor';

  @override
  String get listsTabActive => 'Aktiva';

  @override
  String get listsTabCompleted => 'Klarade';

  @override
  String get listsTabArchived => 'Arkiverade';

  @override
  String get newListButton => 'Ny lista';

  @override
  String get listTitleHint => 'Titel (valfritt)';

  @override
  String get saveButton => 'Spara';

  @override
  String get cancelButton => 'Avbryt';

  @override
  String get deleteButton => 'Ta bort';

  @override
  String get editAction => 'Redigera';

  @override
  String get listDeleted => 'Listan har tagits bort';

  @override
  String get invalidAmountError => 'Ogiltigt belopp';

  @override
  String get duplicateAction => 'Duplicera';

  @override
  String get archiveAction => 'Arkivera';

  @override
  String get unarchiveAction => 'Ångra arkivering';

  @override
  String get deleteListConfirm =>
      'Vill du ta bort den här listan? Planerade varor tas också bort.';

  @override
  String get undoButton => 'Ångra';

  @override
  String get searchListHint => 'Sök i listor';

  @override
  String get currencyLabel => 'Valuta';

  @override
  String get budgetLabel => 'Budget (valfritt)';

  @override
  String get noteLabel => 'Anteckning (valfritt)';

  @override
  String get storeLabel => 'Butik';

  @override
  String get keepAmountsAction => 'Behåll beloppen';

  @override
  String get resetAmountsAction => 'Återställ beloppen';

  @override
  String get currencyChangeWarning =>
      'Valutan ändras. Vad ska hända med de befintliga beloppen?';

  @override
  String get listsEmpty => 'Inga listor ännu. Skapa din första handlingsplan.';

  @override
  String get statusDraft => 'Utkast';

  @override
  String get statusPlanned => 'Planerad';

  @override
  String get statusShopping => 'Handlar';

  @override
  String get statusCompleted => 'Klarad';

  @override
  String get statusArchived => 'Arkiverad';

  @override
  String autoListTitle(String date) {
    return '$date shopping';
  }

  @override
  String get itemFormTitle => 'Lägg till vara';

  @override
  String get itemNameLabel => 'Varunamn';

  @override
  String get brandLabel => 'Märke / variant (valfritt)';

  @override
  String get categoryLabel => 'Kategori';

  @override
  String get quantityLabel => 'Kvantitet';

  @override
  String get unitLabel => 'Enhet';

  @override
  String get pricingModeLabel => 'Prisangivelse';

  @override
  String get pricingModeUnitPrice => 'Enhetspris';

  @override
  String get pricingModeLineTotal => 'Radtotal';

  @override
  String get plannedPriceLabel => 'Planerat pris';

  @override
  String lineTotalCalculated(String value) {
    return 'Radtotal: $value';
  }

  @override
  String get requiredItemToggle => 'Nödvändig vara';

  @override
  String get maxPriceLabel => 'Maximalt acceptabelt pris (valfritt)';

  @override
  String get itemNoteLabel => 'Anteckning (valfritt)';

  @override
  String get categoryProduce => 'Frukter & grönsaker';

  @override
  String get categoryDairy => 'Mejeri';

  @override
  String get categoryMeat => 'Kött';

  @override
  String get categoryBakery => 'Bageri';

  @override
  String get categoryDrinks => 'Drycker';

  @override
  String get categoryCleaning => 'Rengöring';

  @override
  String get categoryPersonalCare => 'Personlig vård';

  @override
  String get categoryHome => 'Hem';

  @override
  String get categoryOther => 'Övrigt';

  @override
  String get invalidQuantityError => 'Ogiltig kvantitet';

  @override
  String get invalidPriceError => 'Ogiltigt pris';

  @override
  String get invalidNameError => 'Ange ett namn';

  @override
  String unitPriceCalculated(String value) {
    return 'Enhetspris: $value';
  }

  @override
  String get shoppingTitle => 'Shoppingläge';

  @override
  String get summaryPlannedTotal => 'Planerat';

  @override
  String get summaryInCart => 'I varukorgen';

  @override
  String get summaryRemainingPlan => 'Återstående plan';

  @override
  String get summaryProjected => 'Beräknad kassa';

  @override
  String get summaryBudgetRemaining => 'Kvar av budget';

  @override
  String get summaryBudgetOver => 'Över budget';

  @override
  String itemsProgress(String done, String total) {
    return '$done av $total varor';
  }

  @override
  String get filterAll => 'Alla';

  @override
  String get filterToBuy => 'Ska köpas';

  @override
  String get filterInCart => 'I varukorgen';

  @override
  String get filterNotFound => 'Hittades ej';

  @override
  String get filterRequired => 'Krävs';

  @override
  String get quickEntryTitle => 'Faktiskt pris';

  @override
  String get actualQuantityLabel => 'Faktisk kvantitet';

  @override
  String get actualPriceLabel => 'Faktiskt pris';

  @override
  String get discountLabel => 'Rabatt (valfritt)';

  @override
  String get alternativeNameLabel => 'Alternativt produktnamn (valfritt)';

  @override
  String get savePurchaseButton => 'Lägg i varukorg';

  @override
  String get unplannedAddButton => 'Lägg till oplanerad vara';

  @override
  String get statusPending => 'Inte tagen';

  @override
  String get statusInCart => 'I varukorgen';

  @override
  String get statusNotFound => 'Hittades ej';

  @override
  String get statusGaveUp => 'Avbruten';

  @override
  String get statusAlternative => 'Alternativ köpt';

  @override
  String get keepScreenAwake => 'Håll skärmen påslagen';

  @override
  String get finishShopping => 'Avsluta shopping';

  @override
  String get completionWarning =>
      'Det saknas eller är okontrollerade poster. Du kan fortfarande avsluta; resultatet kommer att notera dem.';

  @override
  String get continueShoppingButton => 'Fortsätt handla';

  @override
  String get resultTitle => 'Resultat';

  @override
  String get summarySection => 'Sammanfattning';

  @override
  String get plannedTotalLabel => 'Planerat totalt';

  @override
  String get actualTotalLabel => 'Faktiskt totalt';

  @override
  String get varianceLabel => 'Skillnad';

  @override
  String get varianceNotComputable => 'Kan inte beräknas';

  @override
  String get budgetStatusLabel => 'Budget';

  @override
  String get savingsLabel => 'Under plan';

  @override
  String get overspendLabel => 'Över plan';

  @override
  String get unplannedTotalLabel => 'Oplanerat totalt';

  @override
  String get unpurchasedLabel => 'Planerat men inte köpt';

  @override
  String get totalDiscountLabel => 'Totala rabatter';

  @override
  String get accuracyLabel => 'Estimeringsnoggrannhet';

  @override
  String get groupsSection => 'Varor';

  @override
  String get groupPricier => 'Dyrare än planerat';

  @override
  String get groupCheaper => 'Billigare än planerat';

  @override
  String get groupClose => 'Nära estimatet';

  @override
  String get groupNotTaken => 'Planerat, inte köpt';

  @override
  String get groupUnplanned => 'Köpt utan plan';

  @override
  String get groupQuantityChanged => 'Kvantitet ändrad';

  @override
  String get groupUnverified => 'Ej verifierad';

  @override
  String get plannedQtyLabel => 'Planerad kvantitet';

  @override
  String get actualQtyLabel => 'Faktisk kvantitet';

  @override
  String get plannedUnitPriceLabel => 'Planerat enhetspris';

  @override
  String get actualUnitPriceLabel => 'Faktiskt enhetspris';

  @override
  String get lineVarianceLabel => 'Radskillnad';

  @override
  String get discountEffectLabel => 'Rabatteffekt';

  @override
  String get notBoughtMark => 'inte köpt';

  @override
  String get noPurchasesNote => 'Inga inköp registrerades.';

  @override
  String get navHome => 'Hem';

  @override
  String get navLists => 'Listor';

  @override
  String get navHistory => 'Historik';

  @override
  String get navSettings => 'Inställningar';

  @override
  String get homeEmptyTitle => 'Planera din shopping';

  @override
  String get homeEmptyBody =>
      'Skapa din första lista och jämför planerade mot faktiska kostnader.';

  @override
  String get homeActiveSection => 'Aktiva listor';

  @override
  String get homeCompletedSection => 'Nyligen slutförda';

  @override
  String get homeMonthlySection => 'Denna månad';

  @override
  String get monthPlannedLabel => 'Planerat';

  @override
  String get monthActualLabel => 'Faktiskt';

  @override
  String get monthVarianceLabel => 'Skillnad';

  @override
  String get continueShoppingLabel => 'Fortsätt handla';

  @override
  String get historyEmpty =>
      'Ingen slutförd shopping ännu. Din historik och insikter visas här.';

  @override
  String get aboutTabTitle => 'Om NShoptor';

  @override
  String get aboutBody =>
      'NShoptor av Crazy Penguin. Offline-first shoppingplanerare. Licensierad under GPL-3.0.';

  @override
  String get startShoppingLabel => 'Börja handla';

  @override
  String get finishAndSeeResult => 'Avsluta & se resultat';

  @override
  String get settingsTitle => 'Inställningar';

  @override
  String get languageLabel => 'Språk';

  @override
  String get languageSystem => 'System';

  @override
  String get languageTr => 'Turkiska';

  @override
  String get languageEn => 'Engelska';

  @override
  String get themeLabel => 'Tema';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Ljust';

  @override
  String get themeDark => 'Mörkt';

  @override
  String get defaultCurrencyLabel => 'Standardvaluta';

  @override
  String get defaultUnitLabel => 'Standardenhet';

  @override
  String get keepAwakeLabel => 'Håll skärmen på medan du handlar';

  @override
  String get backupSection => 'Säkerhetskopiera';

  @override
  String get exportBackupLabel => 'Exportera säkerhetskopia';

  @override
  String get importBackupLabel => 'Importera säkerhetskopia';

  @override
  String get mergeImportLabel => 'Sammanfoga med nuvarande data';

  @override
  String get separateImportLabel => 'Importera som en separat kopia';

  @override
  String get importCancelled => 'Import avbruten.';

  @override
  String get backupExported => 'Säkerhetskopia exporterad framgångsrikt.';

  @override
  String get deleteAllSection => 'Farozon';

  @override
  String get deleteAllLabel => 'Radera all data';

  @override
  String get deleteAllConfirm =>
      'Detta kommer att ta bort alla listor, historik, kvittobilder och priser. Filer du har exporterat finns kvar på din enhet. Fortsätt?';

  @override
  String get deleteAllConfirm2 =>
      'Är du helt säker? Denna åtgärd kan inte ångras.';

  @override
  String get cancelAction => 'Avbryt';

  @override
  String get confirmDelete => 'Radera permanent';

  @override
  String get dataDeleted => 'All lokal data har raderats.';

  @override
  String get privacyInfoLabel => 'Integritet';

  @override
  String get privacyInfoBody =>
      'Dina listor, priser, kvitton och bilder sparas på din enhet. Rösten lämnar den aldrig. När AI-hjälp är på skickas bilder på kvitton och prislappar (förminskade) samt text, till exempel dikterade varor, till vår server endast för att läsas; de bearbetas direkt och sparas aldrig.';

  @override
  String get aboutSection => 'Om';

  @override
  String get aboutPublisher => 'Utgivare: Crazy Penguin';

  @override
  String get aboutLicenses => 'Licenser (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Röstinmatning';

  @override
  String get voiceStatusUnknown => 'Tjänst: ej kontrollerad';

  @override
  String get permissionsLabel => 'Behörigheter';

  @override
  String get permissionsBody =>
      'Kamera, mikrofon och aviseringar begärs endast när du faktiskt använder dessa funktioner.';

  @override
  String get unitsSection => 'Standardvärden';

  @override
  String get roundingNote =>
      'Avrundning av pengar följer en regel: halvor rundas bort från noll, tillämpas en gång vid Money-konvertering.';

  @override
  String get voiceInputTitle => 'Röstinmatning';

  @override
  String get voiceStartListening => 'Börja lyssna';

  @override
  String get voiceTranscriptLabel => 'Transkript';

  @override
  String get parseAction => 'Analysera';

  @override
  String get receiptReviewTitle => 'Granska kvitto';

  @override
  String get receiptTotal => 'Kvittosumma';

  @override
  String get receiptTotalUnknown => 'Summan kunde inte detekteras';

  @override
  String get receiptDiff => 'Skillnad';

  @override
  String get acceptLine => 'Acceptera rad';

  @override
  String get ignoreLine => 'Ignorera rad';

  @override
  String get receiptLineActions => 'Länka till vara, dela eller ignorera';

  @override
  String get receiptCommit => 'Acceptera alla';

  @override
  String get receiptCommitted => 'Kvitto har registrerats.';

  @override
  String get priceHistoryTitle => 'Prishistorik';

  @override
  String get noObservations => 'Inga prisskillnader registrerade ännu';

  @override
  String get templatesSection => 'Mallar';

  @override
  String get templateHint => 'Skapa en ny lista från ett tidigare köp';

  @override
  String get scanReceiptAction => 'Skanna kvitto';

  @override
  String get fromReceiptListButton => 'Från kvitto';

  @override
  String get shelfLabelAction => 'Pris från hyllmärke';

  @override
  String get priceCandidatesTitle => 'Priskandidater';

  @override
  String get noPriceCandidates => 'Inget pris hittat; ange det manuellt.';

  @override
  String get voiceUnavailable =>
      'Talin recognition är inte tillgängligt; ange manuellt.';

  @override
  String get linkToItem => 'Länka till vara';

  @override
  String get splitLine => 'Dela upp i två';

  @override
  String get mergeWithNext => 'Slå ihop med nästa';

  @override
  String get ocrNoText => 'Ingen text läst; försök igen.';

  @override
  String get priceHistoryAction => 'Prishistorik';

  @override
  String get itemsEmptyTitle => 'Inga varor ännu';

  @override
  String get itemsEmptyBody =>
      'Lägg till din första vara — här anger du de faktiska priserna i butiken.';

  @override
  String get addItemTooltip => 'Lägg till vara';

  @override
  String get unitAdet => 'st';

  @override
  String get unitKilogram => 'kg';

  @override
  String get unitGram => 'g';

  @override
  String get unitLitre => 'L';

  @override
  String get unitMililitre => 'ml';

  @override
  String get unitPaket => 'förpackning';

  @override
  String get unitKutu => 'låd';

  @override
  String get unitSise => 'flaska';

  @override
  String get unitKavanoz => 'burk';

  @override
  String get unitDemet => 'knippe';

  @override
  String get unitDuzine => 'dussin';

  @override
  String get unitMetre => 'm';

  @override
  String get unitCustom => 'Anpassad';

  @override
  String get setReminderAction => 'Ställ in påminnelse';

  @override
  String get reminderPermissionDenied =>
      'Aviseringsbehörighet krävs för påminnelser. Du kan aktivera det i systeminställningarna.';

  @override
  String get reminderScheduled => 'Påminnelse inställd.';

  @override
  String get reminderCancelled => 'Påminnelse borttagen.';

  @override
  String get reminderTitle => 'Handlingspåminnelse';

  @override
  String reminderBody(Object title) {
    return 'Det är dags att kolla din lista: $title';
  }

  @override
  String get reminderPickDate => 'Välj datum';

  @override
  String get reminderPickTime => 'Välj tid';

  @override
  String get itemDetailsSection => 'Detaljer';

  @override
  String get priceOptionalHint =>
      'Valfritt — du anger det faktiska priset i butiken';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Planerat: $total · $count varor';
  }

  @override
  String get proActiveLabel => 'Pro aktivt — tack!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Ingen reklam · Säkerhetskopiera och importera · Årligen';

  @override
  String get proBenefitNoAds => 'Annonserfri upplevelse';

  @override
  String get proBenefitBackup => 'Säkerhetskopiering (export/import)';

  @override
  String aboutVersion(Object version) {
    return 'Version $version';
  }

  @override
  String get navDiscover => 'Upptäck';

  @override
  String get shareAction => 'Dela appen';

  @override
  String get rateAction => 'Betygsätt oss';

  @override
  String get aboutOpenRow => 'Om & öppen källkod';

  @override
  String get voiceAddItemAction => 'Lägg till via röst';

  @override
  String get formatLocaleLabel => 'Nummer- och valutainställningar';

  @override
  String get formatLocaleSystem =>
      'Enhetens format (Latinska siffror; annars engelska)';

  @override
  String get formatLocaleTr => 'Turkiska (1.234,56)';

  @override
  String get formatLocaleEn => 'Engelska (1,234.56)';

  @override
  String get aiToggleTitle => 'AI-hjälp';

  @override
  String get aiToggleSubtitle =>
      'Läser kvitton och prislappar från bilder, matchar kvitton och gör om meningar till listor. Bilder skickas endast för att läsas och sparas aldrig.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Du har använt dina månadsvisa AI-förfrågningar ($used/$limit). Uppgradera för fler, eller fortsätt utan AI.';
  }

  @override
  String get aiOffline => 'Ingen anslutning – fortsätter utan AI.';

  @override
  String get aiFailed =>
      'AI är inte tillgänglig just nu – fortsätter utan den.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'Enhet';

  @override
  String get quickListAction => 'Lägg till från en mening';

  @override
  String get quickListTitle => 'Snabblista';

  @override
  String get quickListHint => 't.ex. 1 kg äpplen 20, 2 bröd, halva kilo ost';

  @override
  String get quickListConvert => 'Gör till lista';

  @override
  String quickListAdd(int count) {
    return 'Lägg till $count varor';
  }

  @override
  String get quickListEmpty =>
      'Inga varor hittades. Försök att lista dem med kommatecken emellan.';

  @override
  String get receiptAiMatched =>
      'AI matchade kvittot mot din lista. Granska länkarna och bekräfta.';

  @override
  String get receiptNeedsCheck => 'Granska denna matchning';

  @override
  String get receiptDiscountLine => 'Rabatt';

  @override
  String get compareItem => 'Vara';

  @override
  String get compareEstimated => 'Uppskattad';

  @override
  String get compareActual => 'Faktisk';

  @override
  String get compareDiff => 'Skillnad';

  @override
  String get compareTotal => 'Totalt';

  @override
  String get compareBudget => 'Budget';

  @override
  String get compareNotBought => 'inte köpt';

  @override
  String get compareUnplanned => 'inte planerad';

  @override
  String get pricierItems => 'Kostade mer';

  @override
  String get cheaperItems => 'Kostade mindre';

  @override
  String get compareAction => 'Jämför';

  @override
  String get detailsSection => 'Detaljer';

  @override
  String get spendingTitle => 'Utgifter';

  @override
  String get spendingAction => 'Utgifter';

  @override
  String get spendingMonthTotal => 'Denna månad';

  @override
  String get spendingWeekly => 'Veckovisa utgifter';

  @override
  String get spendingMonthly => 'Månadsvisa utgifter';

  @override
  String get monthlyLimitTitle => 'Månadsgräns';

  @override
  String get monthlyLimitHelp =>
      'Hur mycket vill du spendera på matvaror per månad?';

  @override
  String get monthlyLimitRemove => 'Ta bort';

  @override
  String get monthlyLimitSet => 'Ange';

  @override
  String get monthlyLimitChange => 'Ändra';

  @override
  String get monthlyLimitNone =>
      'Ange en månadsgräns för att se hur mycket som återstår.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount över gränsen';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return '$amount kvar denna månad';
  }

  @override
  String get plansTitle => 'Paket';

  @override
  String get plansHeadline => 'Handla smartare med AI';

  @override
  String get plansSubhead =>
      'Kvitto-matchning, prisetiketter och listor från en mening. Säga upp när du vill.';

  @override
  String get plansMonthly => 'Månadsvis';

  @override
  String get plansYearly => 'Årligen';

  @override
  String get planFree => 'Gratis';

  @override
  String get planFreePrice => 'Alltid gratis';

  @override
  String get planFreeAi => '10 AI-förfrågningar i månaden';

  @override
  String get planFreeAds => 'Små bannerreklam (ingen de första 7 dagarna)';

  @override
  String get planCoreFeatures => 'Listor, priser, kvitton, utgiftsdiagram';

  @override
  String get plansPerYear => '/ år';

  @override
  String get plansPerMonth => '/ månad';

  @override
  String get planTrial => 'Gratis provperiod';

  @override
  String get planProAi => '100 AI-förfrågningar i månaden';

  @override
  String get planNoAds => 'Ingen reklam';

  @override
  String get planBackup => 'Säkerhetskopiera och importera';

  @override
  String get planMaxAi => '300 AI-förfrågningar per månad';

  @override
  String get planMaxFamily => 'För stora familjehandelar';

  @override
  String get plansStoreUnavailable => 'Butiken är inte tillgänglig just nu.';

  @override
  String get retryAction => 'Försök igen';

  @override
  String get plansPurchaseFailed => 'Köpet misslyckades. Försök igen.';

  @override
  String get plansRestore => 'Återställ köp';

  @override
  String get plansLegal =>
      'Pro förnyas automatiskt varje år tills det sägs upp och omfattar 100 AI-förfrågningar per månad. Grundpriset är 1 amerikansk dollar per år före tillämpliga skatter; kontrollera det slutliga lokala priset och skatterna i butiken innan du bekräftar köpet. Hantera eller säg upp i Google Play.';

  @override
  String get planCurrent => 'Nuvarande';

  @override
  String get planStartTrial => 'Starta gratis provperiod';

  @override
  String get planChoose => 'Välj';

  @override
  String get plansAction => 'Paket: Pro';

  @override
  String get assistantTitle => 'Assistent';

  @override
  String get assistantGreeting => 'Hej! Vad vill du göra?';

  @override
  String get assistantNewList => 'Ny lista';

  @override
  String get assistantVoiceList => 'Lista via röst';

  @override
  String get assistantTextList => 'Lista från en mening';

  @override
  String get assistantScanReceipt => 'Skanna ett kvitto';

  @override
  String get assistantSpending => 'Mina utgifter';

  @override
  String get assistantReceiptHint =>
      'Öppna din lista och tryck på kvittosymbolen för att skanna det.';

  @override
  String get assistantToggleTitle => 'Visa assistent';

  @override
  String get assistantToggleSubtitle => 'Den lilla hjälparen nere till höger';

  @override
  String get scanPriceLabel => 'Skanna prisetikett';

  @override
  String get saveFailed =>
      'Kunde inte spara. Dina ändringar finns kvar. Försök igen.';

  @override
  String get deleteItemConfirm =>
      'Ta bort denna vara och dess registrerade köp?';

  @override
  String get clearPurchaseConfirm =>
      'Avmarkera denna vara och ta bort dess registrerade köp?';

  @override
  String get reportPdfAction => 'Spara PDF-rapport';

  @override
  String get reportNotInvoice =>
      'Inköpsöversikt, inte en skattefaktura. Skattesatser är okända.';

  @override
  String get purchaseVisits => 'Inköpsbesök';

  @override
  String get purchaseInterval => 'Genomsnittliga dagar mellan inköp';

  @override
  String get purchasedQuantity => 'Köpt kvantitet';

  @override
  String get purchaseAnalyticsHint =>
      'Inköp mäter inte konsumtion. Valutor och enheter visas separat.';

  @override
  String get receiptReplaces =>
      'Varor utan pris fylls i. Varor med marknadspris läggs till som separata köp.';

  @override
  String get receiptIncompleteHeader =>
      'Ta med butik, datum, tid och kvittonummer på nästa foto.';

  @override
  String get receiptIncompleteTail =>
      'Fotografera nästa del med några överlappande varor och slutsumman.';

  @override
  String get receiptContinuationRejected =>
      'Det gick inte att slå ihop fotot. Ta om det med överlappande varor från samma kvitto.';

  @override
  String get receiptDraftSaved =>
      'Kvitto sparat som utkast. Du kan fortsätta senare.';

  @override
  String get receiptContinueAction => 'Fortsätt kvitto';

  @override
  String get receiptDraftsTitle => 'Oavslutade kvitton';

  @override
  String get receiptDuplicate => 'Det här kvittot har redan lagts till.';

  @override
  String get receiptTotalMismatch =>
      'Varornas summa stämmer inte med kvittots totalsumma. Kontrollera att hela kvittot syns.';

  @override
  String get receiptSaveDraftAction => 'Spara till senare';

  @override
  String get receiptResolveLines =>
      'Godkänn eller ignorera varje vara innan du sparar.';

  @override
  String get receiptPartialConfirm =>
      'Endast de valda varorna läggs till. Kvittot markeras som importerat. Vill du fortsätta?';

  @override
  String get voiceUnsupportedLanguage =>
      'Detta språk stöder inte röstinskrivning på den här enheten. Du kan skriva istället.';

  @override
  String get voiceStopListening => 'Sluta lyssna';

  @override
  String get keepAwakeFailed =>
      'Det gick inte att hålla skärmen vaken. Försök igen.';

  @override
  String get purchaseHistoryHint =>
      'Alla genomförda shoppingar. Returer minskar totalbeloppet. Datum avser när shoppingen slutfördes. Ett besök räcker inte för att beräkna ett genomsnittligt intervall.';

  @override
  String get planLegacyRights =>
      'Befintliga Pro- och Max-prenumerationer behåller sin ursprungliga månatliga AI-begränsning.';

  @override
  String get csvExportAction => 'Exportera CSV';

  @override
  String get reportSharePdf => 'Dela som PDF';

  @override
  String get reportShareCsv => 'Dela som CSV';

  @override
  String get reportPrintAction => 'Skriv ut';

  @override
  String get backupSizeWarning =>
      'JSON innehåller poster, inte bildfiler. Importgräns: 16 MB.';

  @override
  String get backupImportFailed =>
      'Kunde inte importera denna säkerhetskopia. Dina data har inte ändrats.';

  @override
  String get backupImported => 'Säkerhetskopiering importerad.';

  @override
  String backupPreviewCounts(Object entries, Object items, Object lists) {
    return '$lists listor · $items varor · $entries inköp';
  }

  @override
  String get voiceModelDownloading =>
      'Röstmodellen för det här språket laddas ned. Försök igen om en minut.';

  @override
  String get historyThisWeek => 'Den här veckan';

  @override
  String get historyProductsSection => 'Köpta varor';

  @override
  String get tipReceiptScan =>
      'Skanna ett kvitto för att matcha priserna med din lista';

  @override
  String get tipVoiceAdd =>
      'Säg en eller flera varor och granska dem innan du lägger till dem';

  @override
  String get tipShelfCamera => 'Läs priset från hylletiketten med kameran';

  @override
  String get tipPlan => 'Din plan: se detaljer, prenumerera eller uppgradera';

  @override
  String get guideAddBody =>
      'Tryck på + för att lägga till en vara. Ange det planerade priset nu och marknadspriset vid kassan.';

  @override
  String get guideVoiceBody =>
      'Tryck på mikrofonen och säg varorna, till exempel: ”1 kg äpplen, 1 bröd”.';

  @override
  String get guideReceiptBody =>
      'Skanna ett kvitto för att matcha priserna med varorna på din lista.';

  @override
  String get guidePlanBody =>
      'Tryck på plan-ikonen för att se din plan, prenumerera eller uppgradera.';

  @override
  String get guideNext => 'OK';

  @override
  String get guideDone => 'Starta';

  @override
  String get paletteLabel => 'Färgtema';

  @override
  String get paletteForest => 'Skog';

  @override
  String get paletteOcean => 'Hav';

  @override
  String get paletteSunset => 'Solnedgång';

  @override
  String get paletteLavender => 'Lavendel';

  @override
  String get darkBlackLabel => 'Helt svart i mörkt tema';

  @override
  String get spendingOverview => 'Översikt';

  @override
  String get spendingThisYear => 'I år';

  @override
  String get spendingYearly => 'Årlig kostnad';

  @override
  String get productSpending => 'Kostnad per vara';

  @override
  String get spanWeek => 'Vecka';

  @override
  String get spanMonth => 'Månad';

  @override
  String get spanYear => 'År';

  @override
  String get weeklyLimitTitle => 'Veckogräns';

  @override
  String get weeklyLimitHelp => 'Hur mycket vill du handla för per vecka?';

  @override
  String get weeklyLimitNone =>
      'Sätt en veckogräns för att se hur mycket som är kvar.';

  @override
  String weeklyLimitLeft(String amount) {
    return '$amount kvar den här veckan';
  }

  @override
  String get shoppingLimitTitle => 'Gräns per inköp';

  @override
  String get shoppingLimitHelp => 'Nya listor startar med den här budgeten.';

  @override
  String get shoppingLimitNone =>
      'Sätt en standardbudget för varje nytt inköp.';

  @override
  String get monthlyReportAction => 'Månadsrapport';

  @override
  String get reportShoppingColumn => 'Inköp';

  @override
  String get reportDateColumn => 'Datum';

  @override
  String get planUnavailable => 'Inte tillgänglig i butiken just nu';

  @override
  String get demoDataTitle => 'Exempeldata';

  @override
  String get demoDataLoad => 'Prova med exempeldata';

  @override
  String get demoDataLoadHelp =>
      'Lägger till 12 månaders exempelinköp så att du ser historik, diagram och prishistorik.';

  @override
  String get demoDataRemove => 'Ta bort exempeldata';

  @override
  String get demoDataAdded => 'Exempeldata tillagda';

  @override
  String get demoDataRemoved => 'Exempeldata borttagna';

  @override
  String get demoProductApple => 'Äpplen';

  @override
  String get demoProductBread => 'Bröd';

  @override
  String get demoProductMilk => 'Mjölk';

  @override
  String get demoProductCheese => 'Ost';

  @override
  String get demoProductTomato => 'Tomater';

  @override
  String get demoProductEggs => 'Ägg';

  @override
  String get demoProductCoffee => 'Kaffe';

  @override
  String get demoProductDetergent => 'Tvättmedel';

  @override
  String get sendAction => 'Send';

  @override
  String get previousMonthAction => 'Previous month';

  @override
  String get nextMonthAction => 'Next month';

  @override
  String get helpSection => 'Hjälp och support';

  @override
  String get howToUseLabel => 'Så använder du appen';

  @override
  String get guidePricesBody =>
      'Ett butikspris markerar varan som köpt; även 0 räknas. Hemmapriset är valfritt. Radera butikspriset för att ta bort bocken.';

  @override
  String get shoppingDateLabel => 'Inköpsdatum';

  @override
  String get shoppingDateNone => 'Inget datum valt';

  @override
  String get clearShoppingDateAction => 'Ta bort datum';

  @override
  String get listSortLabel => 'Listordning';

  @override
  String get listSortDate => 'Inköpsdatum';

  @override
  String get listSortAz => 'Namn (A–Ö)';

  @override
  String get listSortManual => 'Manuell ordning';

  @override
  String get imageCameraAction => 'Ta foto';

  @override
  String get imageGalleryAction => 'Välj bland foton';

  @override
  String get imageCaptureFailed =>
      'Det gick inte att öppna kameran eller fotona. Kontrollera åtkomstbehörigheten och försök igen.';

  @override
  String get imageRecognitionFailed =>
      'Fotot kunde inte bearbetas. Prova ett annat foto.';

  @override
  String get receiptNoProducts =>
      'Texten lästes, men inga varor på kvittot hittades. Ta med varorna och totalbeloppet i fotot.';

  @override
  String get keepAwakeOn => 'Skärmen förblir på';

  @override
  String get keepAwakeOff => 'Skärmen kan släckas';

  @override
  String get spanDay => 'Dag';

  @override
  String get spanCustom => 'Datumintervall';

  @override
  String get reportTotalSpent => 'Totalt spenderat';

  @override
  String get reportAddedAt => 'Tillagd';

  @override
  String get reportReceiptNumber => 'Kvittonummer';

  @override
  String get reportPreview => 'Förhandsvisning';

  @override
  String get reportShareAction => 'Dela';

  @override
  String get previousPeriodAction => 'Föregående period';

  @override
  String get nextPeriodAction => 'Nästa period';

  @override
  String get reportSaved => 'Rapporten har sparats.';

  @override
  String get reportZoom => 'Zooma';

  @override
  String planTrialDaysLeft(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dagar kvar',
      one: '$days dag kvar',
    );
    return '$_temp0';
  }

  @override
  String planTrialHoursLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours timmar kvar',
      one: '$hours timme kvar',
    );
    return '$_temp0';
  }

  @override
  String get planTrialEndedTitle => 'Din Pro-testperiod har löpt ut';

  @override
  String get planTrialEndedBody =>
      'Du kan fortsätta använda listor, manuell inmatning och röst på enheten gratis. Gratis innehåller 10 AI-förfrågningar per kalendermånad. Välj årlig Pro för 100 AI-förfrågningar i månaden, inga annonser och säkerhetskopior. Dina befintliga data finns kvar hos dig.';

  @override
  String get planContinueFree => 'Fortsätt gratis';

  @override
  String get supportIdLabel => 'Support-ID';

  @override
  String get supportEmailLabel => 'E-postsupport';

  @override
  String get captureTipFirst =>
      'Börja högst upp: butikens namn och datum måste synas. Ta med så många varor du kan; resten kommer på nästa foto.';

  @override
  String get captureTipContinue =>
      'Samma kvitto: ta med den sista varan från föregående foto.';

  @override
  String get captureTipNeverShow => 'Visa inte igen';

  @override
  String get captureTipOk => 'Uppfattat';

  @override
  String get captureTipsSetting => 'Visa tips för att fotografera kvitton';

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

  @override
  String get listReceiptsSection => 'Kvitton';

  @override
  String get receiptStateComplete => 'Klart';

  @override
  String get receiptStateIncomplete => 'Ofullständigt';

  @override
  String get receiptStateFailed => 'Misslyckades';

  @override
  String get receiptStoreUnknown => 'Butiken lästes inte';

  @override
  String get receiptDeleteAction => 'Radera kvitto';

  @override
  String get receiptDeleteConfirm =>
      'Radera det här kvittot och varorna det lade till? Du kan importera det igen senare.';

  @override
  String get receiptDeleted => 'Kvittot har raderats.';

  @override
  String listReceiptsShowAll(int count) {
    return 'Visa alla ($count)';
  }

  @override
  String get listReceiptsShowLess => 'Visa färre';

  @override
  String receiptDateLabel(String date) {
    return 'Kvittodatum: $date';
  }

  @override
  String get historyViewShopping => 'Per inköp';

  @override
  String get historyViewStore => 'Per butik';

  @override
  String get historyViewProduct => 'Per produkt';

  @override
  String get historyShareAll => 'Dela allt';

  @override
  String get historyUnknownStore => 'Okänd butik';

  @override
  String get historyDailySpending => 'Daglig utgift';

  @override
  String get historyResetPeriod => 'Tillbaka till denna vecka';
}
