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
  String get backupSizeWarning =>
      'Stor säkerhetskopia: filen kan bli stor. Vill du inkludera bilder också?';

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
      'Dina listor, priser, kvitton och bilder stannar på din enhet. Bilder och röst lämnar den aldrig. När AI-hjälp är aktiverad skickas endast text (till exempel raderna från ett kvitto eller vad du dikterat) till vår server för bearbetning och lagras inte.';

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
      'Inga annonser, mer AI, säkerhetskopiering · till ett lågt månadspris';

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
  String get formatLocaleSystem => 'System (följer appens språk)';

  @override
  String get formatLocaleTr => 'Turkiska (1.234,56)';

  @override
  String get formatLocaleEn => 'Engelska (1,234.56)';

  @override
  String get aiToggleTitle => 'AI-hjälp';

  @override
  String get aiToggleSubtitle =>
      'Matchar kvitton, läser prisetiketter och omvandlar meningar till listor. Bilder och röst stannar på din enhet; endast text bearbetas.';

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
  String get planFreeAi => '15 AI-förfrågningar i månaden';

  @override
  String get planFreeAds => 'Små bannerreklam (ingen de första 7 dagarna)';

  @override
  String get planCoreFeatures => 'Listor, priser, kvitton, utgiftsdiagram';

  @override
  String get plansPerYear => '/ år';

  @override
  String get plansPerMonth => '/ månad';

  @override
  String get planTrial => '7 dagar gratis';

  @override
  String get planProAi => '200 AI-förfrågningar i månaden';

  @override
  String get planNoAds => 'Ingen reklam';

  @override
  String get planBackup => 'Säkerhetskopiera och importera';

  @override
  String get planMaxAi => '1000 AI-förfrågningar per månad';

  @override
  String get planMaxFamily => 'För stora familjehandelar';

  @override
  String get plansStoreUnavailable => 'Butiken är inte tillgänglig just nu.';

  @override
  String get retryAction => 'Försök igen';

  @override
  String get plansPurchaseFailed => 'Köpet misslyckades. Försök igen.';

  @override
  String get planLifetimeTitle => 'Reklamfritt för livet';

  @override
  String get planLifetimeSubtitle =>
      'Engångsavgift: ingen reklam, säkerhetskopiering; AI kvarstår på gratisnivån';

  @override
  String get plansRestore => 'Återställ köp';

  @override
  String get plansLegal =>
      'Prenumerationer förnyas automatiskt tills de sägs upp. Avsluta när som helst i Google Play › Betalningar och prenumerationer. Priserna inkluderar de skatter som visas av Google Play.';

  @override
  String get planCurrent => 'Nuvarande';

  @override
  String get planStartTrial => 'Starta 7 dagars gratis provperiod';

  @override
  String get planChoose => 'Välj';

  @override
  String get plansAction => 'Planer: Pro och Max';

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
}
