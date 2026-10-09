// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class AppLocalizationsRo extends AppLocalizations {
  AppLocalizationsRo([String locale = 'ro']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Planifică acasă. Cumpără conform planului.';

  @override
  String get listsTitle => 'Liste';

  @override
  String get listsTabActive => 'Active';

  @override
  String get listsTabCompleted => 'Finalizate';

  @override
  String get listsTabArchived => 'Arhivate';

  @override
  String get newListButton => 'Listă nouă';

  @override
  String get listTitleHint => 'Titlu (opțional)';

  @override
  String get saveButton => 'Salvează';

  @override
  String get cancelButton => 'Anulează';

  @override
  String get deleteButton => 'Șterge';

  @override
  String get editAction => 'Editare';

  @override
  String get listDeleted => 'Listă ștearsă';

  @override
  String get invalidAmountError => 'Sumă invalidă';

  @override
  String get duplicateAction => 'Duplicare';

  @override
  String get archiveAction => 'Arhivare';

  @override
  String get unarchiveAction => 'Dezarhivare';

  @override
  String get deleteListConfirm =>
      'Ștergi această listă? Elementele planificate vor fi, de asemenea, eliminate.';

  @override
  String get undoButton => 'Anulare';

  @override
  String get searchListHint => 'Caută liste';

  @override
  String get currencyLabel => 'Monedă';

  @override
  String get budgetLabel => 'Buget (opțional)';

  @override
  String get noteLabel => 'Notă (opțional)';

  @override
  String get storeLabel => 'Magazin';

  @override
  String get keepAmountsAction => 'Păstrează sumele';

  @override
  String get resetAmountsAction => 'Resetează sumele';

  @override
  String get currencyChangeWarning =>
      'Moneda se schimbă. Ce se întâmplă cu sumele existente?';

  @override
  String get listsEmpty =>
      'Nu există încă liste. Creează-ți primul plan de cumpărături.';

  @override
  String get statusDraft => 'Ciornă';

  @override
  String get statusPlanned => 'Planificat';

  @override
  String get statusShopping => 'Cumpărături';

  @override
  String get statusCompleted => 'Finalizat';

  @override
  String get statusArchived => 'Arhivat';

  @override
  String autoListTitle(String date) {
    return 'cumpărături $date';
  }

  @override
  String get itemFormTitle => 'Adaugă produs';

  @override
  String get itemNameLabel => 'Nume produs';

  @override
  String get brandLabel => 'Brand / variantă (opțional)';

  @override
  String get categoryLabel => 'Categorie';

  @override
  String get quantityLabel => 'Cantitate';

  @override
  String get unitLabel => 'Unitate';

  @override
  String get pricingModeLabel => 'Mod preț';

  @override
  String get pricingModeUnitPrice => 'Preț unitar';

  @override
  String get pricingModeLineTotal => 'Total linie';

  @override
  String get plannedPriceLabel => 'Preț planificat';

  @override
  String lineTotalCalculated(String value) {
    return 'Total linie: $value';
  }

  @override
  String get requiredItemToggle => 'Produs necesar';

  @override
  String get maxPriceLabel => 'Preț maxim acceptabil (opțional)';

  @override
  String get itemNoteLabel => 'Notă (opțional)';

  @override
  String get categoryProduce => 'Fructe și legume';

  @override
  String get categoryDairy => 'Lactate';

  @override
  String get categoryMeat => 'Carne';

  @override
  String get categoryBakery => 'Panificație';

  @override
  String get categoryDrinks => 'Băuturi';

  @override
  String get categoryCleaning => 'Curățenie';

  @override
  String get categoryPersonalCare => 'Îngrijire personală';

  @override
  String get categoryHome => 'Casă';

  @override
  String get categoryOther => 'Altele';

  @override
  String get invalidQuantityError => 'Cantitate invalidă';

  @override
  String get invalidPriceError => 'Preț invalid';

  @override
  String get invalidNameError => 'Introdu un nume';

  @override
  String unitPriceCalculated(String value) {
    return 'Preț unitar: $value';
  }

  @override
  String get shoppingTitle => 'Mod cumpărături';

  @override
  String get summaryPlannedTotal => 'Planificat';

  @override
  String get summaryInCart => 'În coș';

  @override
  String get summaryRemainingPlan => 'Plan rămas';

  @override
  String get summaryProjected => 'Estimare la casă';

  @override
  String get summaryBudgetRemaining => 'Buget rămas';

  @override
  String get summaryBudgetOver => 'Depășit bugetul';

  @override
  String itemsProgress(String done, String total) {
    return '$done din $total produse';
  }

  @override
  String get filterAll => 'Toate';

  @override
  String get filterToBuy => 'De cumpărat';

  @override
  String get filterInCart => 'În coș';

  @override
  String get filterNotFound => 'Nu s-a găsit';

  @override
  String get filterRequired => 'Obligatoriu';

  @override
  String get quickEntryTitle => 'Preț real';

  @override
  String get actualQuantityLabel => 'Cantitate reală';

  @override
  String get actualPriceLabel => 'Preț real';

  @override
  String get discountLabel => 'Reducere (opțional)';

  @override
  String get alternativeNameLabel => 'Nume produs alternativ (opțional)';

  @override
  String get savePurchaseButton => 'Adaugă în coș';

  @override
  String get unplannedAddButton => 'Adaugă produs neprevăzut';

  @override
  String get statusPending => 'Neînceput';

  @override
  String get statusInCart => 'În coș';

  @override
  String get statusNotFound => 'Nu s-a găsit';

  @override
  String get statusGaveUp => 'Renunțat';

  @override
  String get statusAlternative => 'Alternativă cumpărată';

  @override
  String get keepScreenAwake => 'Păstrează ecranul activ';

  @override
  String get finishShopping => 'Finalizează cumpărăturile';

  @override
  String get completionWarning =>
      'Există înregistrări lipsă sau neverificate. Poți finaliza; rezultatul va menționa aceste aspecte.';

  @override
  String get continueShoppingButton => 'Continuă cumpărăturile';

  @override
  String get resultTitle => 'Rezultat';

  @override
  String get summarySection => 'Sumar';

  @override
  String get plannedTotalLabel => 'Total planificat';

  @override
  String get actualTotalLabel => 'Total real';

  @override
  String get varianceLabel => 'Diferență';

  @override
  String get varianceNotComputable => 'Nu se poate calcula';

  @override
  String get budgetStatusLabel => 'Buget';

  @override
  String get savingsLabel => 'Sub plan';

  @override
  String get overspendLabel => 'Peste plan';

  @override
  String get unplannedTotalLabel => 'Total neprevăzut';

  @override
  String get unpurchasedLabel => 'Planificat, dar necumpărat';

  @override
  String get totalDiscountLabel => 'Reduceri totale';

  @override
  String get accuracyLabel => 'Acuratețe estimare';

  @override
  String get groupsSection => 'Produse';

  @override
  String get groupPricier => 'Mai scump decât planificat';

  @override
  String get groupCheaper => 'Mai ieftin decât planificat';

  @override
  String get groupClose => 'Lângă estimare';

  @override
  String get groupNotTaken => 'Planificat, necumpărat';

  @override
  String get groupUnplanned => 'Cumpărat fără plan';

  @override
  String get groupQuantityChanged => 'Cantitate modificată';

  @override
  String get groupUnverified => 'Neconfirmat';

  @override
  String get plannedQtyLabel => 'Cantitate planificată';

  @override
  String get actualQtyLabel => 'Cantitate reală';

  @override
  String get plannedUnitPriceLabel => 'Preț unitar planificat';

  @override
  String get actualUnitPriceLabel => 'Preț unitar real';

  @override
  String get lineVarianceLabel => 'Diferență pe linie';

  @override
  String get discountEffectLabel => 'Efect reducere';

  @override
  String get notBoughtMark => 'nu a fost cumpărat';

  @override
  String get noPurchasesNote => 'Nu au fost înregistrate cumpărături.';

  @override
  String get navHome => 'Acasă';

  @override
  String get navLists => 'Liste';

  @override
  String get navHistory => 'Istoric';

  @override
  String get navSettings => 'Setări';

  @override
  String get homeEmptyTitle => 'Planifică cumpărăturile';

  @override
  String get homeEmptyBody =>
      'Creează prima ta listă și compară costurile estimate cu cele reale.';

  @override
  String get homeActiveSection => 'Liste active';

  @override
  String get homeCompletedSection => 'Finalizate recent';

  @override
  String get homeMonthlySection => 'Această lună';

  @override
  String get monthPlannedLabel => 'Estimat';

  @override
  String get monthActualLabel => 'Real';

  @override
  String get monthVarianceLabel => 'Diferență';

  @override
  String get continueShoppingLabel => 'Continuă cumpărăturile';

  @override
  String get historyEmpty =>
      'Nicio achiziție finalizată încă. Istoricul și analizele tale vor apărea aici.';

  @override
  String get aboutTabTitle => 'Despre NShoptor';

  @override
  String get aboutBody =>
      'NShoptor de la Crazy Penguin. Planificator de cumpărături funcțional offline. Licențiat sub GPL-3.0.';

  @override
  String get startShoppingLabel => 'Începe cumpărăturile';

  @override
  String get finishAndSeeResult => 'Finalizează și vezi rezultatul';

  @override
  String get settingsTitle => 'Setări';

  @override
  String get languageLabel => 'Limba';

  @override
  String get languageSystem => 'Sistem';

  @override
  String get languageTr => 'Turcă';

  @override
  String get languageEn => 'Engleză';

  @override
  String get themeLabel => 'Temă';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get themeLight => 'Clară';

  @override
  String get themeDark => 'Întunecată';

  @override
  String get defaultCurrencyLabel => 'Monedă implicită';

  @override
  String get defaultUnitLabel => 'Unitate implicită';

  @override
  String get keepAwakeLabel => 'Menține ecranul activ în timpul cumpărăturilor';

  @override
  String get backupSection => 'Backup';

  @override
  String get exportBackupLabel => 'Exportă backup';

  @override
  String get importBackupLabel => 'Importă backup';

  @override
  String get mergeImportLabel => 'Fuzionează cu datele curente';

  @override
  String get separateImportLabel => 'Importă ca o copie separată';

  @override
  String get importCancelled => 'Import anulată.';

  @override
  String get backupExported => 'Backup exportat cu succes.';

  @override
  String get backupSizeWarning =>
      'Backup mare: fișierul poate fi voluminos. Dorești să incluzi și poze?';

  @override
  String get deleteAllSection => 'Zona periculoasă';

  @override
  String get deleteAllLabel => 'Șterge toate datele';

  @override
  String get deleteAllConfirm =>
      'Aceasta va elimina toate listele, istoricul, pozele de pe chitanțe și prețurile. Fișierele exportate de tine rămân pe dispozitiv. Continuăm?';

  @override
  String get deleteAllConfirm2 =>
      'Ești complet sigur? Această acțiune nu poate fi anulată.';

  @override
  String get cancelAction => 'Anulează';

  @override
  String get confirmDelete => 'Șterge definitiv';

  @override
  String get dataDeleted => 'Toate datele locale au fost șterse.';

  @override
  String get privacyInfoLabel => 'Confidențialitate';

  @override
  String get privacyInfoBody =>
      'Listele, prețurile, chitanțele și pozele tale rămân pe dispozitiv. Pozele și vocea nu părăsesc niciodată dispozitivul. Când asistența AI este activă, doar textul (de exemplu, liniile din chitanță sau ceea ce ai dictat) este trimis pe serverul nostru pentru procesare și nu este stocat.';

  @override
  String get aboutSection => 'Despre';

  @override
  String get aboutPublisher => 'Editor: Crazy Penguin';

  @override
  String get aboutLicenses => 'Licențe (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Intrare vocală';

  @override
  String get voiceStatusUnknown => 'Serviciu: neverificat';

  @override
  String get permissionsLabel => 'Permisiuni';

  @override
  String get permissionsBody =>
      'Camera, microfonul și notificările sunt solicitate doar atunci când folosești efectiv aceste funcții.';

  @override
  String get unitsSection => 'Implicit';

  @override
  String get roundingNote =>
      'Rotunjirea banilor urmează o regulă: jumătățile se rotunjesc departe de zero, aplicată o singură dată la conversia monetară.';

  @override
  String get voiceInputTitle => 'Intrare vocală';

  @override
  String get voiceStartListening => 'Începe ascultarea';

  @override
  String get voiceTranscriptLabel => 'Transcriere';

  @override
  String get parseAction => 'Analizează';

  @override
  String get receiptReviewTitle => 'Revizuiește chitanța';

  @override
  String get receiptTotal => 'Total chitanță';

  @override
  String get receiptTotalUnknown => 'Total nedetectat';

  @override
  String get receiptDiff => 'Diferență';

  @override
  String get acceptLine => 'Acceptă linia';

  @override
  String get ignoreLine => 'Ignoră linia';

  @override
  String get receiptLineActions => 'Leagă de produs, împarte sau ignoră';

  @override
  String get receiptCommit => 'Acceptă toate';

  @override
  String get receiptCommitted => 'Chitanță aplicată.';

  @override
  String get priceHistoryTitle => 'Istoric prețuri';

  @override
  String get noObservations => 'Niciun preț înregistrat încă';

  @override
  String get templatesSection => 'Șabloane';

  @override
  String get templateHint => 'Creează un nou plan dintr-o cumpărare anterioară';

  @override
  String get scanReceiptAction => 'Scanează chitanța';

  @override
  String get shelfLabelAction => 'Preț din eticheta raftului';

  @override
  String get priceCandidatesTitle => 'Candidați la preț';

  @override
  String get noPriceCandidates => 'Nu s-a găsit preț; introdu-l manual.';

  @override
  String get voiceUnavailable =>
      'Recunoașterea vocală indisponibilă; introdu manual.';

  @override
  String get linkToItem => 'Leagă de produs';

  @override
  String get splitLine => 'Împarte în două';

  @override
  String get mergeWithNext => 'Fuzionează cu următoarea';

  @override
  String get ocrNoText => 'Niciun text citit; încearcă din nou.';

  @override
  String get priceHistoryAction => 'Istoric prețuri';

  @override
  String get itemsEmptyTitle => 'Niciun produs încă';

  @override
  String get itemsEmptyBody =>
      'Adaugă primul produs — vei introduce prețurile reale aici, în magazin.';

  @override
  String get addItemTooltip => 'Adaugă produs';

  @override
  String get unitAdet => 'buc';

  @override
  String get unitKilogram => 'kg';

  @override
  String get unitGram => 'g';

  @override
  String get unitLitre => 'L';

  @override
  String get unitMililitre => 'ml';

  @override
  String get unitPaket => 'pachet';

  @override
  String get unitKutu => 'cutie';

  @override
  String get unitSise => 'sticlă';

  @override
  String get unitKavanoz => 'borcan';

  @override
  String get unitDemet => 'legătură';

  @override
  String get unitDuzine => 'dozină';

  @override
  String get unitMetre => 'm';

  @override
  String get unitCustom => 'Personalizat';

  @override
  String get setReminderAction => 'Setează o alertă';

  @override
  String get reminderPermissionDenied =>
      'Este necesară permisiunea pentru notificări. O poți activa în setările sistemului.';

  @override
  String get reminderScheduled => 'Alertă setată.';

  @override
  String get reminderCancelled => 'Alertă eliminată.';

  @override
  String get reminderTitle => 'Alertă cumpărături';

  @override
  String reminderBody(Object title) {
    return 'E timpul să verifici lista: $title';
  }

  @override
  String get reminderPickDate => 'Alege o dată';

  @override
  String get reminderPickTime => 'Alege o oră';

  @override
  String get itemDetailsSection => 'Detalii';

  @override
  String get priceOptionalHint =>
      'Opțional — vei introduce prețul real în magazin';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Planificat: $total · $count produse';
  }

  @override
  String get proActiveLabel => 'Pro activ — mulțumim!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Fără reclame, mai mult AI, backup · de la un preț lunar mic';

  @override
  String get proBenefitNoAds => 'Experiență fără reclame';

  @override
  String get proBenefitBackup => 'Backup (export/import)';

  @override
  String aboutVersion(Object version) {
    return 'Versiunea $version';
  }

  @override
  String get navDiscover => 'Descoperă';

  @override
  String get shareAction => 'Distribuie aplicația';

  @override
  String get rateAction => 'Evaluează-ne';

  @override
  String get aboutOpenRow => 'Despre & open source';

  @override
  String get voiceAddItemAction => 'Adaugă prin voce';

  @override
  String get formatLocaleLabel => 'Format număr și valută';

  @override
  String get formatLocaleSystem => 'Sistem (urmează limba aplicației)';

  @override
  String get formatLocaleTr => 'Turcă (1.234,56)';

  @override
  String get formatLocaleEn => 'Engleză (1,234.56)';

  @override
  String get aiToggleTitle => 'Ajutor AI';

  @override
  String get aiToggleSubtitle =>
      'Potrivește chitanțele, citește etichetele de preț și transformă propozițiile în liste. Fotografiile și vocea rămân pe dispozitivul tău; doar textul este procesat.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Ai folosit cererile lunare pentru AI ($used/$limit). Fă upgrade pentru mai multe sau continuă fără AI.';
  }

  @override
  String get aiOffline => 'Fără conexiune — se continuă fără AI.';

  @override
  String get aiFailed =>
      'AI nu este disponibil momentan — se continuă fără el.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'Dispozitiv';

  @override
  String get quickListAction => 'Adaugă dintr-o propoziție';

  @override
  String get quickListTitle => 'Listă rapidă';

  @override
  String get quickListHint =>
      'ex: 1 kg mere 20, 2 pâini, jumătate de kilo de brânză';

  @override
  String get quickListConvert => 'Transformă într-o listă';

  @override
  String quickListAdd(int count) {
    return 'Adaugă $count articole';
  }

  @override
  String get quickListEmpty =>
      'Nu s-au găsit articole. Încearcă să le listezi separate prin virgulă.';

  @override
  String get receiptAiMatched =>
      'AI a potolit chitanța cu lista ta. Verifică legăturile și confirmă.';

  @override
  String get receiptNeedsCheck => 'Verifică această potrivire';

  @override
  String get receiptDiscountLine => 'Reducere';

  @override
  String get compareItem => 'Articol';

  @override
  String get compareEstimated => 'Estimat';

  @override
  String get compareActual => 'Real';

  @override
  String get compareDiff => 'Diferență';

  @override
  String get compareTotal => 'Total';

  @override
  String get compareBudget => 'Buget';

  @override
  String get compareNotBought => 'nu cumpărat';

  @override
  String get compareUnplanned => 'neplanat';

  @override
  String get pricierItems => 'Costă mai mult';

  @override
  String get cheaperItems => 'Costă mai puțin';

  @override
  String get compareAction => 'Compară';

  @override
  String get detailsSection => 'Detalii';

  @override
  String get spendingTitle => 'Cheltuieli';

  @override
  String get spendingAction => 'Cheltuieli';

  @override
  String get spendingMonthTotal => 'Această lună';

  @override
  String get spendingWeekly => 'Cheltuieli săptămânale';

  @override
  String get spendingMonthly => 'Cheltuieli lunare';

  @override
  String get monthlyLimitTitle => 'Limita lunară';

  @override
  String get monthlyLimitHelp =>
      'Cât vrei să cheltuiești pe cumpărături pe lună?';

  @override
  String get monthlyLimitRemove => 'Elimină';

  @override
  String get monthlyLimitSet => 'Setează';

  @override
  String get monthlyLimitChange => 'Modifică';

  @override
  String get monthlyLimitNone =>
      'Setează o limită lunară pentru a vedea cât îți mai rămâne.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount peste limită';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return '$amount rămas această lună';
  }

  @override
  String get plansTitle => 'Planuri';

  @override
  String get plansHeadline => 'Cumpără mai inteligent cu AI';

  @override
  String get plansSubhead =>
      'Potrivirea chitanțelor, etichetele de preț și listele dintr-o propoziție. Anulează oricând.';

  @override
  String get plansMonthly => 'Lunar';

  @override
  String get plansYearly => 'Anual';

  @override
  String get planFree => 'Gratuit';

  @override
  String get planFreePrice => 'Gratuit pentru totdeauna';

  @override
  String get planFreeAi => '15 cereri AI pe lună';

  @override
  String get planFreeAds => 'Banner-uri mici (fără primele 7 zile)';

  @override
  String get planCoreFeatures =>
      'Liste, prețuri, chitanțe, grafice de cheltuieli';

  @override
  String get plansPerYear => '/ an';

  @override
  String get plansPerMonth => '/ lună';

  @override
  String get planTrial => '7 zile gratuite';

  @override
  String get planProAi => '200 cereri AI pe lună';

  @override
  String get planNoAds => 'Fără reclame';

  @override
  String get planBackup => 'Export și import de backup';

  @override
  String get planMaxAi => '1000 cereri AI pe lună';

  @override
  String get planMaxFamily => 'Pentru cumpărături mari în familie';

  @override
  String get plansStoreUnavailable => 'Magazinul nu este disponibil momentan.';

  @override
  String get retryAction => 'Reîncearcă';

  @override
  String get plansPurchaseFailed =>
      'Achiziția nu a reușit. Te rugăm să încerci din nou.';

  @override
  String get planLifetimeTitle => 'Fără reclame pentru totdeauna';

  @override
  String get planLifetimeSubtitle =>
      'Plată unică: fără reclame, backup; AI rămâne la limita gratuită';

  @override
  String get plansRestore => 'Restabilește achizițiile';

  @override
  String get plansLegal =>
      'Abonamentele se reînnoiesc automat până la anularea lor. Poți anula oricând în Google Play › Plăți și abonamente. Prețurile includ taxele afișate de Google Play.';

  @override
  String get planCurrent => 'Actual';

  @override
  String get planStartTrial => 'Încearcă gratuit timp de 7 zile';

  @override
  String get planChoose => 'Alege';

  @override
  String get plansAction => 'Planuri: Pro și Max';

  @override
  String get assistantTitle => 'Asistent';

  @override
  String get assistantGreeting => 'Salut! Ce ai vrea să faci?';

  @override
  String get assistantNewList => 'Listă nouă';

  @override
  String get assistantVoiceList => 'Listă vocală';

  @override
  String get assistantTextList => 'Listă dintr-o propoziție';

  @override
  String get assistantScanReceipt => 'Scanează un chitanță';

  @override
  String get assistantSpending => 'Cheltuielile mele';

  @override
  String get assistantReceiptHint =>
      'Deschide lista ta și atinge pictograma chitanței pentru a o scana.';

  @override
  String get assistantToggleTitle => 'Arată asistentul';

  @override
  String get assistantToggleSubtitle =>
      'Micul ajutor în colțul din dreapta jos';

  @override
  String get scanPriceLabel => 'Scanează eticheta de preț';
}
