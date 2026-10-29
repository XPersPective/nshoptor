// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Latvian (`lv`).
class AppLocalizationsLv extends AppLocalizations {
  AppLocalizationsLv([String locale = 'lv']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Plāno mājās. Pērc pēc plāna.';

  @override
  String get listsTitle => 'Saraksti';

  @override
  String get listsTabActive => 'Aktīvie';

  @override
  String get listsTabCompleted => 'Pabeigtie';

  @override
  String get listsTabArchived => 'Arhivētie';

  @override
  String get newListButton => 'Jauns saraksts';

  @override
  String get listTitleHint => 'Nosaukums (pēc izvēles)';

  @override
  String get saveButton => 'Saglabāt';

  @override
  String get cancelButton => 'Atcelt';

  @override
  String get deleteButton => 'Dzēst';

  @override
  String get editAction => 'Rediģēt';

  @override
  String get listDeleted => 'Saraksts dzēsts';

  @override
  String get invalidAmountError => 'Nederīga summa';

  @override
  String get duplicateAction => 'Dublēt';

  @override
  String get archiveAction => 'Arhivēt';

  @override
  String get unarchiveAction => 'Atarhivēt';

  @override
  String get deleteListConfirm =>
      'Vai tiešām dzēst šo sarakstu? Tā plānotās preces arī tiks noņemtas.';

  @override
  String get undoButton => 'Atsaukt';

  @override
  String get searchListHint => 'Meklēt sarakstus';

  @override
  String get currencyLabel => 'Valūta';

  @override
  String get budgetLabel => 'Budžets (pēc izvēles)';

  @override
  String get noteLabel => 'Piezīme (pēc izvēles)';

  @override
  String get storeLabel => 'Veikals';

  @override
  String get keepAmountsAction => 'Saglabāt summas';

  @override
  String get resetAmountsAction => 'Atiestatīt summas';

  @override
  String get currencyChangeWarning =>
      'Valūta mainās. Ko darīt ar esošajām summām?';

  @override
  String get listsEmpty =>
      'Vēl nav sarakstu. Izveido savu pirmo iepirkuma plānu.';

  @override
  String get statusDraft => 'Melnraksts';

  @override
  String get statusPlanned => 'Plānots';

  @override
  String get statusShopping => 'Iepērkos';

  @override
  String get statusCompleted => 'Pabeigts';

  @override
  String get statusArchived => 'Arhivēts';

  @override
  String autoListTitle(String date) {
    return '$date iepirkums';
  }

  @override
  String get itemFormTitle => 'Pievienot preci';

  @override
  String get itemNameLabel => 'Preces nosaukums';

  @override
  String get brandLabel => 'Zīmols / variants (pēc izvēles)';

  @override
  String get categoryLabel => 'Kategorija';

  @override
  String get quantityLabel => 'Daudzums';

  @override
  String get unitLabel => 'Mērvienība';

  @override
  String get pricingModeLabel => 'Cenas ievade';

  @override
  String get pricingModeUnitPrice => 'Vienības cena';

  @override
  String get pricingModeLineTotal => 'Kopsumma rindai';

  @override
  String get plannedPriceLabel => 'Plānotā cena';

  @override
  String lineTotalCalculated(String value) {
    return 'Kopsumma rindai: $value';
  }

  @override
  String get requiredItemToggle => 'Nepieciešama prece';

  @override
  String get maxPriceLabel => 'Maksimālā pieļaujamā cena (pēc izvēles)';

  @override
  String get itemNoteLabel => 'Piezīme (pēc izvēles)';

  @override
  String get categoryProduce => 'Augļi un dārzeņi';

  @override
  String get categoryDairy => 'Piena produkti';

  @override
  String get categoryMeat => 'Gaļa';

  @override
  String get categoryBakery => 'Maiznīcas izstrādājumi';

  @override
  String get categoryDrinks => 'Dzeramie dzērieni';

  @override
  String get categoryCleaning => 'Tīrīšanas līdzekļi';

  @override
  String get categoryPersonalCare => 'Personīgā higiēna';

  @override
  String get categoryHome => 'Mājsaimniecība';

  @override
  String get categoryOther => 'Cits';

  @override
  String get invalidQuantityError => 'Nederīgs daudzums';

  @override
  String get invalidPriceError => 'Nederīga cena';

  @override
  String get invalidNameError => 'Ievadiet nosaukumu';

  @override
  String unitPriceCalculated(String value) {
    return 'Vienības cena: $value';
  }

  @override
  String get shoppingTitle => 'Pirkumu režīms';

  @override
  String get summaryPlannedTotal => 'Plānots';

  @override
  String get summaryInCart => 'Grozā';

  @override
  String get summaryRemainingPlan => 'Atlikušais plāns';

  @override
  String get summaryProjected => 'Pronozētais kopsavilkums';

  @override
  String get summaryBudgetRemaining => 'Budžeta atlikums';

  @override
  String get summaryBudgetOver => 'Pārsniegts budžets';

  @override
  String itemsProgress(String done, String total) {
    return '$done no $total preču';
  }

  @override
  String get filterAll => 'Visas';

  @override
  String get filterToBuy => 'Pirkt';

  @override
  String get filterInCart => 'Grozā';

  @override
  String get filterNotFound => 'Nav atrasta';

  @override
  String get filterRequired => 'Nepieciešams';

  @override
  String get quickEntryTitle => 'Reālā cena';

  @override
  String get actualQuantityLabel => 'Reālā daudzums';

  @override
  String get actualPriceLabel => 'Reālā cena';

  @override
  String get discountLabel => 'Atlaide (pēc izvēles)';

  @override
  String get alternativeNameLabel =>
      'Alternatīvās preces nosaukums (pēc izvēles)';

  @override
  String get savePurchaseButton => 'Pievienot grozam';

  @override
  String get unplannedAddButton => 'Pievienot neparedzētu preci';

  @override
  String get statusPending => 'Nav ņemta';

  @override
  String get statusInCart => 'Grozā';

  @override
  String get statusNotFound => 'Nav atrasta';

  @override
  String get statusGaveUp => 'Tika atteikts';

  @override
  String get statusAlternative => 'Pirkta alternatīva';

  @override
  String get keepScreenAwake => 'Uzturēt ekrānu aktīvu';

  @override
  String get finishShopping => 'Pabeigt pirkumus';

  @override
  String get completionWarning =>
      'Ir trūkstoši vai nepārbaudīti ieraksti. Jūs joprojām varat pabeigt; rezultātā tie tiks norādīti.';

  @override
  String get continueShoppingButton => 'Turpināt pirkumus';

  @override
  String get resultTitle => 'Rezultāts';

  @override
  String get summarySection => 'Kopsavilkums';

  @override
  String get plannedTotalLabel => 'Plānotais kopsumma';

  @override
  String get actualTotalLabel => 'Reālā kopsumma';

  @override
  String get varianceLabel => 'Starpība';

  @override
  String get varianceNotComputable => 'Nevar aprēķināt';

  @override
  String get budgetStatusLabel => 'Budžets';

  @override
  String get savingsLabel => 'Zem plāna';

  @override
  String get overspendLabel => 'Virsz plāna';

  @override
  String get unplannedTotalLabel => 'Neparedzētā kopsumma';

  @override
  String get unpurchasedLabel => 'Plānota, bet nepirkta';

  @override
  String get totalDiscountLabel => 'Kopējās atlaidēs';

  @override
  String get accuracyLabel => 'Novērtējuma precizitāte';

  @override
  String get groupsSection => 'Preces';

  @override
  String get groupPricier => 'Dārgākas nekā plānots';

  @override
  String get groupCheaper => 'Lētākas nekā plānots';

  @override
  String get groupClose => 'Tuvas novērtējumam';

  @override
  String get groupNotTaken => 'Plānota, nepirkta';

  @override
  String get groupUnplanned => 'Pirkta bez plāna';

  @override
  String get groupQuantityChanged => 'Daudzums mainīts';

  @override
  String get groupUnverified => 'Nav pārbaudīta';

  @override
  String get plannedQtyLabel => 'Plānotais daudzums';

  @override
  String get actualQtyLabel => 'Reālais daudzums';

  @override
  String get plannedUnitPriceLabel => 'Plānotā vienības cena';

  @override
  String get actualUnitPriceLabel => 'Reālā vienības cena';

  @override
  String get lineVarianceLabel => 'Rindas starpība';

  @override
  String get discountEffectLabel => 'Atlaižu ietekme';

  @override
  String get notBoughtMark => 'nepirkta';

  @override
  String get noPurchasesNote => 'Nav reģistrēti pirkumi.';

  @override
  String get navHome => 'Sākums';

  @override
  String get navLists => 'Saraksti';

  @override
  String get navHistory => 'Vēsture';

  @override
  String get navSettings => 'Iestatījumi';

  @override
  String get homeEmptyTitle => 'Plānojiet iepirkšanos';

  @override
  String get homeEmptyBody =>
      'Izveidojiet savu pirmo sarakstu un salīdzināt plānotās un faktiskās izmaksas.';

  @override
  String get homeActiveSection => 'Aktīvie saraksti';

  @override
  String get homeCompletedSection => 'Nesen pabeigti';

  @override
  String get homeMonthlySection => 'Šajā mēnesī';

  @override
  String get monthPlannedLabel => 'Plānots';

  @override
  String get monthActualLabel => 'Faktiski';

  @override
  String get monthVarianceLabel => 'Atšķirība';

  @override
  String get continueShoppingLabel => 'Turpināt iepirkties';

  @override
  String get historyEmpty =>
      'Vēl nav pabeigtu iepirkumu. Jūsu vēsture un analītika šeit parādīsies.';

  @override
  String get aboutTabTitle => 'Par NShoptor';

  @override
  String get aboutBody =>
      'NShoptor no Crazy Penguin. Iepirkšanās plānotājs, kas strādā bezsaistē. Licencēts ar GPL-3.0.';

  @override
  String get startShoppingLabel => 'Sākt iepirkties';

  @override
  String get finishAndSeeResult => 'Pabeigt un skatīt rezultātu';

  @override
  String get settingsTitle => 'Iestatījumi';

  @override
  String get languageLabel => 'Valoda';

  @override
  String get languageSystem => 'Sistēma';

  @override
  String get languageTr => 'Turku';

  @override
  String get languageEn => 'Angļu';

  @override
  String get themeLabel => 'Tēma';

  @override
  String get themeSystem => 'Sistēma';

  @override
  String get themeLight => 'Gaišā';

  @override
  String get themeDark => 'Tumšā';

  @override
  String get defaultCurrencyLabel => 'Noklusējuma valūta';

  @override
  String get defaultUnitLabel => 'Noklusējuma mērvienība';

  @override
  String get keepAwakeLabel => 'Uzturēt ekrānu ieslēgtu iepirkšanās laikā';

  @override
  String get backupSection => 'Rezerves kopija';

  @override
  String get exportBackupLabel => 'Eksportēt rezerves kopiju';

  @override
  String get importBackupLabel => 'Importēt rezerves kopiju';

  @override
  String get mergeImportLabel => 'Apvienot ar pašreizējiem datiem';

  @override
  String get separateImportLabel => 'Importēt kā atsevišķu kopiju';

  @override
  String get importCancelled => 'Importēšana atcelta.';

  @override
  String get backupExported => 'Rezerves kopija veiksmīgi eksportēta.';

  @override
  String get deleteAllSection => 'Bīstamā zona';

  @override
  String get deleteAllLabel => 'Dzēst visus datus';

  @override
  String get deleteAllConfirm =>
      'Tiks dzēsti visi saraksti, vēsture, čeku fotogrāfijas un cenas. Jums eksportētie faili paliks jūsu diskā. Turpināt?';

  @override
  String get deleteAllConfirm2 =>
      'Vai esat pilnīgi pārliecināts? Šo darbību nevar atsaukt.';

  @override
  String get cancelAction => 'Atcelt';

  @override
  String get confirmDelete => 'Dzēst neatgriezeniski';

  @override
  String get dataDeleted => 'Visi lokālie dati ir dzēsti.';

  @override
  String get privacyInfoLabel => 'Privātums';

  @override
  String get privacyInfoBody =>
      'Jūsu saraksti, cenas, čeki un fotogrāfijas tiek glabāti jūsu ierīcē. Balss to nekad nepamet. Kad AI palīdzība ir ieslēgta, čeku un cenu etiķešu fotogrāfijas (samazinātā izmērā) un teksts, piemēram, nodiktētie ieraksti, tiek nosūtīti uz mūsu serveri tikai nolasīšanai; tie tiek apstrādāti uzreiz un nekad netiek glabāti.';

  @override
  String get aboutSection => 'Par';

  @override
  String get aboutPublisher => 'Izdevējs: Crazy Penguin';

  @override
  String get aboutLicenses => 'Licences (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Balss ievade';

  @override
  String get voiceStatusUnknown => 'Serviss: nav pārbaudīts';

  @override
  String get permissionsLabel => 'Atļaujas';

  @override
  String get permissionsBody =>
      'Kamera, mikrofons un paziņojumi tiek pieprasīti tikai tad, kad jūs faktiski izmantojat šīs funkcijas.';

  @override
  String get unitsSection => 'Noklusējumi';

  @override
  String get roundingNote =>
      'Naudas noapaļošana seko vienam noteikumam: pusi noapaļo prom no nulles, piemērojot to vienu reizi naudas konvertēšanas brīdī.';

  @override
  String get voiceInputTitle => 'Balss ievade';

  @override
  String get voiceStartListening => 'Sākt klausīties';

  @override
  String get voiceTranscriptLabel => 'Transkripts';

  @override
  String get parseAction => 'Analizēt';

  @override
  String get receiptReviewTitle => 'Apskatīt čeku';

  @override
  String get receiptTotal => 'Čeka kopsavilkums';

  @override
  String get receiptTotalUnknown => 'Kopsavilkums nenoteikts';

  @override
  String get receiptDiff => 'Atšķirība';

  @override
  String get acceptLine => 'Apstiprināt rindu';

  @override
  String get ignoreLine => 'Ignorēt rindu';

  @override
  String get receiptLineActions => 'Saistīt ar preci, sadalīt vai ignorēt';

  @override
  String get receiptCommit => 'Apstiprināt visu';

  @override
  String get receiptCommitted => 'Čeks piemērots.';

  @override
  String get priceHistoryTitle => 'Cenu vēsture';

  @override
  String get noObservations => 'Vēl nav cenu novērojumu';

  @override
  String get templatesSection => 'Šabloni';

  @override
  String get templateHint =>
      'Izveidot jaunu sarakstu no iepriekšējas iepirkšanās reizes';

  @override
  String get scanReceiptAction => 'Skenēt čeku';

  @override
  String get fromReceiptListButton => 'No čeka';

  @override
  String get shelfLabelAction => 'Cena no plaukta etiķetes';

  @override
  String get priceCandidatesTitle => 'Cenu varianti';

  @override
  String get noPriceCandidates => 'Cena nav atrasta; ievadiet manuāli.';

  @override
  String get voiceUnavailable =>
      'Balss atpazīšana nav pieejama; ievadiet manuāli.';

  @override
  String get linkToItem => 'Saistīt ar preci';

  @override
  String get splitLine => 'Sadalīt divās';

  @override
  String get mergeWithNext => 'Apvienot ar nākamo';

  @override
  String get ocrNoText => 'Teksts nolasīts tukšs; mēģiniet vēlreiz.';

  @override
  String get priceHistoryAction => 'Cenu vēsture';

  @override
  String get itemsEmptyTitle => 'Vēl nav preču';

  @override
  String get itemsEmptyBody =>
      'Pievienojiet savu pirmo preci — veikalu apmeklējuma laikā šeit ievadīsiet reālās cenas.';

  @override
  String get addItemTooltip => 'Pievienot preci';

  @override
  String get unitAdet => 'gab.';

  @override
  String get unitKilogram => 'kg';

  @override
  String get unitGram => 'g';

  @override
  String get unitLitre => 'L';

  @override
  String get unitMililitre => 'ml';

  @override
  String get unitPaket => 'pak.';

  @override
  String get unitKutu => 'kar.';

  @override
  String get unitSise => 'fl.';

  @override
  String get unitKavanoz => 'burk.';

  @override
  String get unitDemet => 'saiņ.';

  @override
  String get unitDuzine => 'dūz.';

  @override
  String get unitMetre => 'm';

  @override
  String get unitCustom => 'Pielāgots';

  @override
  String get setReminderAction => 'Iestatīt atgādinājumu';

  @override
  String get reminderPermissionDenied =>
      'Atgādinājumiem ir nepieciešamas paziņojumu atļaujas. Tās varat aktivizēt sistēmas iestatījumos.';

  @override
  String get reminderScheduled => 'Atgādinājums iestatīts.';

  @override
  String get reminderCancelled => 'Atgādinājums noņemts.';

  @override
  String get reminderTitle => 'Iepirkšanās atgādinājums';

  @override
  String reminderBody(Object title) {
    return 'Laiks pārbaudīt sarakstu: $title';
  }

  @override
  String get reminderPickDate => 'Izvēlieties datumu';

  @override
  String get reminderPickTime => 'Izvēlieties laiku';

  @override
  String get itemDetailsSection => 'Detaļas';

  @override
  String get priceOptionalHint => 'Neobligāti — reālo cenu ievadīsit veikalā';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Plānots: $total · $count preces';
  }

  @override
  String get proActiveLabel => 'Pro aktīvs — paldies!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Bez reklāmām · Rezerves kopija eksportēšanai un importēšanai · Gadā';

  @override
  String get proBenefitNoAds => 'Tīra pieredze bez reklāmām';

  @override
  String get proBenefitBackup => 'Dublējums (eksports/imports)';

  @override
  String aboutVersion(Object version) {
    return 'Versija $version';
  }

  @override
  String get navDiscover => 'Atrast';

  @override
  String get shareAction => 'Dalīties ar lietotni';

  @override
  String get rateAction => 'Novērtēt mūs';

  @override
  String get aboutOpenRow => 'Par un atvērtā koda';

  @override
  String get voiceAddItemAction => 'Pievienot ar balss komandu';

  @override
  String get formatLocaleLabel => 'Skaitļu un valūtas formāts';

  @override
  String get formatLocaleSystem =>
      'Ierīces formāts (Latīņu cipari; citādi angļu valodā)';

  @override
  String get formatLocaleTr => 'Turku (1.234,56)';

  @override
  String get formatLocaleEn => 'Angļu (1,234.56)';

  @override
  String get aiToggleTitle => 'AI palīdzība';

  @override
  String get aiToggleSubtitle =>
      'Nolasa čekus un cenu etiķetes no fotogrāfijām, saskaņo čekus un pārvērš teikumus sarakstos. Fotogrāfijas tiek sūtītas tikai nolasīšanai un nekad netiek glabātas.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Šo mēnesi esat izmantojis AI pieprasījumus ($used/$limit). Uzlabojiet plānu, lai iegūtu vairāk, vai turpiniet bez AI.';
  }

  @override
  String get aiOffline => 'Nav savienojuma — turpinām bez AI.';

  @override
  String get aiFailed => 'AI pašlaik nav pieejams — turpinām bez tā.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'Ierīce';

  @override
  String get quickListAction => 'Pievienot no teikuma';

  @override
  String get quickListTitle => 'Ātrais saraksts';

  @override
  String get quickListHint =>
      'piem., 1 kg ābolu 20, 2 maizes, puskilograms siera';

  @override
  String get quickListConvert => 'Pārvērst sarakstā';

  @override
  String quickListAdd(int count) {
    return 'Pievienot $count vienumus';
  }

  @override
  String get quickListEmpty =>
      'Vienumi netika atrasti. Mēģiniet tos uzskaitīt ar komatu atdalītus.';

  @override
  String get receiptAiMatched =>
      'AI ir sasaistījis čeku ar jūsu sarakstu. Pārbaudiet saites un apstipriniet.';

  @override
  String get receiptNeedsCheck => 'Pārbaudīt šo sasaisti';

  @override
  String get receiptDiscountLine => 'Atlaide';

  @override
  String get compareItem => 'Viens';

  @override
  String get compareEstimated => 'Plānots';

  @override
  String get compareActual => 'Reāls';

  @override
  String get compareDiff => 'Starpība';

  @override
  String get compareTotal => 'Kopā';

  @override
  String get compareBudget => 'Budžets';

  @override
  String get compareNotBought => 'nav nopirkts';

  @override
  String get compareUnplanned => 'nav plānots';

  @override
  String get pricierItems => 'Dārgāki';

  @override
  String get cheaperItems => 'Lētāki';

  @override
  String get compareAction => 'Salīdzināt';

  @override
  String get detailsSection => 'Detaļas';

  @override
  String get spendingTitle => 'Tēriņi';

  @override
  String get spendingAction => 'Tēriņi';

  @override
  String get spendingMonthTotal => 'Šajā mēnesī';

  @override
  String get spendingWeekly => 'Nedēļas tēriņi';

  @override
  String get spendingMonthly => 'Mēneša tēriņi';

  @override
  String get monthlyLimitTitle => 'Mēneša limits';

  @override
  String get monthlyLimitHelp =>
      'Cik daudz vēlaties tērēt iepirkumiem katru mēnesi?';

  @override
  String get monthlyLimitRemove => 'Noņemt';

  @override
  String get monthlyLimitSet => 'Iestatīt';

  @override
  String get monthlyLimitChange => 'Mainīt';

  @override
  String get monthlyLimitNone =>
      'Iestatiet mēneša limitu, lai redzētu, cik vēl atlicis.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount pāri limitam';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return '$amount atlicis šajā mēnesī';
  }

  @override
  String get plansTitle => 'Plāni';

  @override
  String get plansHeadline => 'Iepirkties gudrāk ar AI';

  @override
  String get plansSubhead =>
      'Čeku sasaiste, cenu etiķetes un saraksti no teikuma. Atcelt jebkurā brīdī.';

  @override
  String get plansMonthly => 'Mēnesī';

  @override
  String get plansYearly => 'Gadā';

  @override
  String get planFree => 'Bezmaksas';

  @override
  String get planFreePrice => 'Bezmaksas uz visiem laikiem';

  @override
  String get planFreeAi => '10 AI pieprasījumi mēnesī';

  @override
  String get planFreeAds =>
      'Mazi reklāmas baneri (pirmajās 7 dienās nav neviena)';

  @override
  String get planCoreFeatures => 'Saraksti, cenas, čeki, tēriņu diagrammas';

  @override
  String get plansPerYear => '/ gadā';

  @override
  String get plansPerMonth => '/ mēnesī';

  @override
  String get planTrial => 'Bezmaksas izmēģinājums';

  @override
  String get planProAi => '100 AI pieprasījumi mēnesī';

  @override
  String get planNoAds => 'Bez reklāmām';

  @override
  String get planBackup => 'Rezerves kopija eksportēšanai un importēšanai';

  @override
  String get planMaxAi => '300 AI pieprasījumu mēnesī';

  @override
  String get planMaxFamily => 'Liela ģimenes iepirkumam';

  @override
  String get plansStoreUnavailable => 'Veikals šobrīd nav sasniedzams.';

  @override
  String get retryAction => 'Mēģināt vēlreiz';

  @override
  String get plansPurchaseFailed =>
      'Pirkums neizdevās. Lūdzu, mēģiniet vēlreiz.';

  @override
  String get plansRestore => 'Atjaunot pirkumus';

  @override
  String get plansLegal =>
      'Pro automātiski atjaunojas katru gadu līdz atcelšanai un ietver 100 MI pieprasījumus mēnesī. Bāzes cena ir 1 ASV dolārs gadā pirms piemērojamajiem nodokļiem; pirms pirkuma apstiprināšanas pārbaudiet galīgo vietējo cenu un nodokļus veikalā. Pārvaldiet vai atceliet abonementu pakalpojumā Google Play.';

  @override
  String get planCurrent => 'Pašreizējais';

  @override
  String get planStartTrial => 'Sākt bezmaksas izmēģinājumu';

  @override
  String get planChoose => 'Izvēlēties';

  @override
  String get plansAction => 'Plāni: Pro';

  @override
  String get assistantTitle => 'Asistents';

  @override
  String get assistantGreeting => 'Sveiki! Ko vēlaties darīt?';

  @override
  String get assistantNewList => 'Jauns saraksts';

  @override
  String get assistantVoiceList => 'Saraksts ar balsi';

  @override
  String get assistantTextList => 'Saraksts no teikuma';

  @override
  String get assistantScanReceipt => 'Skenēt čeku';

  @override
  String get assistantSpending => 'Manas izmaksas';

  @override
  String get assistantReceiptHint =>
      'Atveriet savu sarakstu un pieskarieties čekam, lai to ieskenētu.';

  @override
  String get assistantToggleTitle => 'Rādīt asistentu';

  @override
  String get assistantToggleSubtitle => 'Mazais palīgs apakšējā labajā stūrī';

  @override
  String get scanPriceLabel => 'Skenē cenu etiķeti';

  @override
  String get saveFailed =>
      'Neizdevās saglabāt. Jūsu izmaiņas joprojām ir šeit. Lūdzu, mēģiniet vēlreiz.';

  @override
  String get deleteItemConfirm => 'Dzēst šo preci un tās reģistrētos pirkumus?';

  @override
  String get clearPurchaseConfirm =>
      'Noņemt atzīmi no šīs preces un dzēst tās reģistrētos pirkumus?';

  @override
  String get reportPdfAction => 'Saglabāt PDF pārskatu';

  @override
  String get reportNotInvoice =>
      'Pirkumu kopsavilkums, nevis nodokļu rēķins. Nodokļa likmes nav zināmas.';

  @override
  String get purchaseVisits => 'Veikalu apmeklējumi';

  @override
  String get purchaseInterval => 'Vidējais dienu skaits starp pirkumiem';

  @override
  String get purchasedQuantity => 'Iegādātā daudzums';

  @override
  String get purchaseAnalyticsHint =>
      'Pirkumi nemēra patēriņu. Valūtas un vienības tiek rādītas atsevišķi.';

  @override
  String get receiptReplaces =>
      'Precēm bez cenas tā tiek aizpildīta. Preces ar tirgus cenu tiek pievienotas kā atsevišķi pirkumi.';

  @override
  String get receiptIncompleteHeader =>
      'Nākamajā foto iekļaujiet veikalu, datumu, laiku un čeka numuru.';

  @override
  String get receiptIncompleteTail =>
      'Nofotografējiet nākamo daļu ar dažām pārklājošām precēm un gala summu.';

  @override
  String get receiptContinuationRejected =>
      'Šo foto neizdevās apvienot. Uzņemiet vēlreiz, pārklājot tās pašas kvīts preces.';

  @override
  String get receiptDraftSaved =>
      'Kvīts saglabāta kā melnraksts. Varat turpināt vēlāk.';

  @override
  String get receiptContinueAction => 'Turpināt kvīti';

  @override
  String get receiptDraftsTitle => 'Nepabeigtās kvītis';

  @override
  String get receiptDuplicate => 'Šī kvīts jau ir pievienota.';

  @override
  String get receiptTotalMismatch =>
      'Preču summa neatbilst kvīts kopsummai. Pārbaudiet, vai redzama visa kvīts.';

  @override
  String get receiptSaveDraftAction => 'Saglabāt vēlākam';

  @override
  String get receiptResolveLines =>
      'Pirms saglabāšanas pieņemiet vai ignorējiet katru preci.';

  @override
  String get receiptPartialConfirm =>
      'Tiks pievienotas tikai atlasītās preces. Šis čeks tiks atzīmēts kā importēts. Vai turpināt?';

  @override
  String get voiceUnsupportedLanguage =>
      'Šī valoda nav pieejama balss ievadei šajā ierīcē. Varat rakstīt tekstu.';

  @override
  String get voiceStopListening => 'Pārtraukt klausīšanos';

  @override
  String get keepAwakeFailed =>
      'Neizdevās noturēt ekrānu aktīvu. Lūdzu, mēģiniet vēlreiz.';

  @override
  String get purchaseHistoryHint =>
      'Visi pabeigtie iepirkumi. Atgrieztie produkti samazina kopējos izdevumus. Datumi attiecas uz iepirkumu pabeigšanas brīdi. Viena apmeklējuma nav pietiekami, lai aprēķinātu vidējo intervālu.';

  @override
  String get planLegacyRights =>
      'Esošie Pro un Max abonementi saglabā sākotnējo mēneša MI pieprasījumu limitu.';

  @override
  String get csvExportAction => 'Eksportēt CSV';

  @override
  String get reportSharePdf => 'Kopīgot kā PDF';

  @override
  String get reportShareCsv => 'Kopīgot kā CSV';

  @override
  String get reportPrintAction => 'Drukāt';

  @override
  String get backupSizeWarning =>
      'JSON ietver ierakstus, nevis foto failus. Importa limits: 16 MB.';

  @override
  String get backupImportFailed =>
      'Neizdevās importēt šo rezerves kopiju. Jūsu dati netika mainīti.';

  @override
  String get backupImported => 'Rezerves kopija veiksmīgi importēta.';

  @override
  String backupPreviewCounts(Object entries, Object items, Object lists) {
    return '$lists saraksti · $items preces · $entries pirkumi';
  }

  @override
  String get voiceModelDownloading =>
      'Šīs valodas balss modelis tiek lejupielādēts. Mēģiniet vēlreiz pēc minūtes.';

  @override
  String get historyThisWeek => 'Šī nedēļa';

  @override
  String get historyProductsSection => 'Nopirktie produkti';

  @override
  String get tipReceiptScan =>
      'Noskenējiet čeku, lai salīdzinātu cenas ar sarakstu';

  @override
  String get tipVoiceAdd =>
      'Pasakiet vienu vai vairākus produktus un pārbaudiet tos pirms pievienošanas';

  @override
  String get tipShelfCamera => 'Nolasiet cenu no plaukta etiķetes ar kameru';

  @override
  String get tipPlan => 'Jūsu plāns: skatīt detaļas, abonēt vai uzlabot';

  @override
  String get guideAddBody =>
      'Pieskarieties +, lai pievienotu produktu. Ievadiet plānoto cenu tagad un tirgus cenu kasē.';

  @override
  String get guideVoiceBody =>
      'Pieskarieties mikrofonam un pasakiet produktus, piemēram: \'1 kg ābolu, 1 maize\'.';

  @override
  String get guideReceiptBody =>
      'Noskenējiet čeku, lai saskaņotu tā cenas ar sarakstā esošajiem produktiem.';

  @override
  String get guidePlanBody =>
      'Pieskarieties plāna ikonai, lai skatītu plānu, abonētu vai uzlabotu.';

  @override
  String get guideNext => 'Labi';

  @override
  String get guideDone => 'Sākt';

  @override
  String get paletteLabel => 'Krāsu tēma';

  @override
  String get paletteForest => 'Mežs';

  @override
  String get paletteOcean => 'Okeāns';

  @override
  String get paletteSunset => 'Saulriets';

  @override
  String get paletteLavender => 'Lavanda';

  @override
  String get darkBlackLabel => 'Tīri melns tumšajā tēmā';

  @override
  String get spendingOverview => 'Pārskats';

  @override
  String get spendingThisYear => 'Šogad';

  @override
  String get spendingYearly => 'Gada izdevumi';

  @override
  String get productSpending => 'Izdevumi pa produktiem';

  @override
  String get spanWeek => 'Nedēļa';

  @override
  String get spanMonth => 'Mēnesis';

  @override
  String get spanYear => 'Gads';

  @override
  String get weeklyLimitTitle => 'Nedēļas limits';

  @override
  String get weeklyLimitHelp => 'Cik vēlaties nedēļā tērēt iepirkumiem?';

  @override
  String get weeklyLimitNone =>
      'Iestatiet nedēļas limitu, lai redzētu, cik palicis.';

  @override
  String weeklyLimitLeft(String amount) {
    return 'Šonedēļ palikuši $amount';
  }

  @override
  String get shoppingLimitTitle => 'Limits vienam iepirkumam';

  @override
  String get shoppingLimitHelp => 'Jaunie saraksti sākas ar šo budžetu.';

  @override
  String get shoppingLimitNone =>
      'Iestatiet noklusējuma budžetu katram jaunam iepirkumam.';

  @override
  String get monthlyReportAction => 'Mēneša pārskats';

  @override
  String get reportShoppingColumn => 'Iepirkums';

  @override
  String get reportDateColumn => 'Datums';

  @override
  String get planUnavailable => 'Pašlaik veikalā nav pieejams';

  @override
  String get demoDataTitle => 'Paraugdati';

  @override
  String get demoDataLoad => 'Izmēģināt ar paraugdatiem';

  @override
  String get demoDataLoadHelp =>
      'Pievieno 12 mēnešu paraugpirkumus, lai redzētu vēsturi, grafikus un cenu vēsturi.';

  @override
  String get demoDataRemove => 'Noņemt paraugdatus';

  @override
  String get demoDataAdded => 'Paraugdati pievienoti';

  @override
  String get demoDataRemoved => 'Paraugdati noņemti';

  @override
  String get demoProductApple => 'Āboli';

  @override
  String get demoProductBread => 'Maize';

  @override
  String get demoProductMilk => 'Piens';

  @override
  String get demoProductCheese => 'Siers';

  @override
  String get demoProductTomato => 'Tomāti';

  @override
  String get demoProductEggs => 'Olas';

  @override
  String get demoProductCoffee => 'Kafija';

  @override
  String get demoProductDetergent => 'Mazgāšanas līdzeklis';

  @override
  String get sendAction => 'Send';

  @override
  String get previousMonthAction => 'Previous month';

  @override
  String get nextMonthAction => 'Next month';

  @override
  String get helpSection => 'Palīdzība un atbalsts';

  @override
  String get howToUseLabel => 'Kā lietot';

  @override
  String get guidePricesBody =>
      'Veikala cena atzīmē preci kā nopirktu; der arī 0. Mājas cena nav obligāta. Izdzēsiet veikala cenu, lai noņemtu atzīmi.';

  @override
  String get shoppingDateLabel => 'Iepirkšanās datums';

  @override
  String get shoppingDateNone => 'Datums nav izvēlēts';

  @override
  String get clearShoppingDateAction => 'Noņemt datumu';

  @override
  String get listSortLabel => 'Saraksta secība';

  @override
  String get listSortDate => 'Iepirkšanās datums';

  @override
  String get listSortAz => 'Nosaukums (A–Z)';

  @override
  String get listSortManual => 'Manuāla secība';

  @override
  String get imageCameraAction => 'Uzņemt fotoattēlu';

  @override
  String get imageGalleryAction => 'Izvēlēties no fotoattēliem';

  @override
  String get imageCaptureFailed =>
      'Neizdevās atvērt kameru vai fotoattēlus. Pārbaudiet piekļuves atļauju un mēģiniet vēlreiz.';

  @override
  String get imageRecognitionFailed =>
      'Fotoattēlu neizdevās apstrādāt. Izmēģiniet citu fotoattēlu.';

  @override
  String get receiptNoProducts =>
      'Teksts tika nolasīts, taču čeka preces netika atrastas. Iekļaujiet fotoattēlā preces un kopsummu.';

  @override
  String get keepAwakeOn => 'Ekrāns paliek ieslēgts';

  @override
  String get keepAwakeOff => 'Ekrāns var izslēgties';

  @override
  String get spanDay => 'Diena';

  @override
  String get spanCustom => 'Datumu diapazons';

  @override
  String get reportTotalSpent => 'Kopā iztērēts';

  @override
  String get reportAddedAt => 'Pievienots';

  @override
  String get reportReceiptNumber => 'Čeka numurs';

  @override
  String get reportPreview => 'Priekšskatījums';

  @override
  String get reportShareAction => 'Kopīgot';

  @override
  String get previousPeriodAction => 'Iepriekšējais periods';

  @override
  String get nextPeriodAction => 'Nākamais periods';

  @override
  String get reportSaved => 'Pārskats saglabāts.';

  @override
  String get reportZoom => 'Tuvināt';

  @override
  String planTrialDaysLeft(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dienas atlikušas',
      one: '$days diena atlikusi',
      zero: '$days dienu atlikušas',
    );
    return '$_temp0';
  }

  @override
  String planTrialHoursLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours stundas atlikušas',
      one: '$hours stunda atlikusi',
      zero: '$hours stundu atlikušas',
    );
    return '$_temp0';
  }

  @override
  String get planTrialEndedTitle => 'Pro izmēģinājuma periods ir beidzies';

  @override
  String get planTrialEndedBody =>
      'Joprojām bez maksas varat izmantot sarakstus, manuālu ievadi un ierīces balss funkciju. Bezmaksas plānā ir 10 AI pieprasījumi kalendārajā mēnesī. Izvēlieties gada Pro, lai saņemtu 100 AI pieprasījumus mēnesī, bez reklāmām un ar dublējumkopijām. Jūsu esošie dati paliks pie jums.';

  @override
  String get planContinueFree => 'Turpināt bez maksas';

  @override
  String get supportIdLabel => 'Atbalsta ID';

  @override
  String get supportEmailLabel => 'Atbalsts e-pastā';

  @override
  String get captureTipFirst =>
      'Sāciet pašā augšā: jābūt redzamam veikala nosaukumam un datumam. Iekļaujiet pēc iespējas vairāk preču, pārējās būs nākamajā foto.';

  @override
  String get captureTipContinue =>
      'Tas pats čeks: iekļaujiet iepriekšējā foto pēdējo preci.';

  @override
  String get captureTipNeverShow => 'Vairs nerādīt';

  @override
  String get captureTipOk => 'Skaidrs';

  @override
  String get captureTipsSetting => 'Rādīt čeka fotografēšanas padomus';

  @override
  String get receiptReadingProgress => 'Čeks tiek lasīts…';

  @override
  String get receiptReadInBackground => 'Turpināt fonā';

  @override
  String get receiptReadDoneTitle => 'Čeks nolasīts';

  @override
  String get receiptReadDoneBody =>
      'Pieskarieties, lai pārskatītu un saglabātu.';

  @override
  String get receiptReadMoreTitle => 'Nofotografējiet pārējo čeka daļu';

  @override
  String get receiptReadFailedTitle => 'Čeku neizdevās nolasīt';

  @override
  String get listReceiptsSection => 'Čeki';

  @override
  String get receiptStateComplete => 'Pabeigts';

  @override
  String get receiptStateIncomplete => 'Nepilnīgs';

  @override
  String get receiptStateFailed => 'Neizdevās';

  @override
  String get receiptStoreUnknown => 'Veikals nav nolasīts';

  @override
  String get receiptDeleteAction => 'Dzēst čeku';

  @override
  String get receiptDeleteConfirm =>
      'Vai dzēst šo čeku un tā pievienotās preces? Vēlāk to varēsiet importēt vēlreiz.';

  @override
  String get receiptDeleted => 'Čeks izdzēsts.';

  @override
  String listReceiptsShowAll(int count) {
    return 'Rādīt visus ($count)';
  }

  @override
  String get listReceiptsShowLess => 'Rādīt mazāk';

  @override
  String receiptDateLabel(String date) {
    return 'Čeka datums: $date';
  }

  @override
  String get historyViewShopping => 'Pēc iepirkšanās';

  @override
  String get historyViewStore => 'Pēc veikala';

  @override
  String get historyViewProduct => 'Pēc produkta';

  @override
  String get historyShareAll => 'Kopīgot visu';

  @override
  String get historyUnknownStore => 'Nezināms veikals';

  @override
  String get historyDailySpending => 'Dienas tēriņi';

  @override
  String get historyResetPeriod => 'Atpakaļ uz šo nedēļu';

  @override
  String get tourSkip => 'Izlaist';

  @override
  String get tourNewListBody =>
      'Sāciet iepirkumu sarakstu un pievienojiet, ko plānojat pirkt.';

  @override
  String get tourFromReceiptBody =>
      'Jau iepirkāties? Pārvērtiet čeku sarakstā ar cenām.';

  @override
  String get tourReceiptFlowBody =>
      'Sāciet čeka augšā: vispirms veikalu un datumu, pēc tam turpiniet ar pārējām rindām.';

  @override
  String get tourTabsBody =>
      'Pārslēdzieties starp aktīviem, pabeigtiem un arhivētiem sarakstiem. Poga galā maina secību.';

  @override
  String get tourDiscoverBody => 'Citas tā paša izstrādātāja lietotnes.';

  @override
  String get tourHelpBody =>
      'Pieskarieties šeit, lai vēlreiz skatītu ceļvedi. Atveriet sarakstu, lai redzētu summu un preču skaidrojumu.';

  @override
  String get tourTotalsBody =>
      'Plānotā, faktiskā summa un starpība atjaunojas iepirkšanās laikā.';

  @override
  String get tourItemsBody =>
      'Jūsu preces. Šeit mainiet to secību vai meklējiet tās.';

  @override
  String budgetAlertNear(String percent) {
    return 'Izmantoti $percent% no limita';
  }
}
