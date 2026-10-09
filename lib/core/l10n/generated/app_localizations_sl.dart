// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovenian (`sl`).
class AppLocalizationsSl extends AppLocalizations {
  AppLocalizationsSl([String locale = 'sl']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Načrtuj doma. Kupuj po načrtu.';

  @override
  String get listsTitle => 'Seznami';

  @override
  String get listsTabActive => 'Aktivni';

  @override
  String get listsTabCompleted => 'Dokončani';

  @override
  String get listsTabArchived => 'Arhivirani';

  @override
  String get newListButton => 'Nov seznam';

  @override
  String get listTitleHint => 'Naslov (neobvezno)';

  @override
  String get saveButton => 'Shrani';

  @override
  String get cancelButton => 'Prekliči';

  @override
  String get deleteButton => 'Izbriši';

  @override
  String get editAction => 'Uredi';

  @override
  String get listDeleted => 'Seznam izbrisan';

  @override
  String get invalidAmountError => 'Neveljavna količina';

  @override
  String get duplicateAction => 'Podvoji';

  @override
  String get archiveAction => 'Arhiviraj';

  @override
  String get unarchiveAction => 'Odpri arhiv';

  @override
  String get deleteListConfirm =>
      'Želite izbrisati ta seznam? Tudi načrtovane postavke bodo odstranjene.';

  @override
  String get undoButton => 'Razveljavi';

  @override
  String get searchListHint => 'Iskanje seznamov';

  @override
  String get currencyLabel => 'Valuta';

  @override
  String get budgetLabel => 'Proračun (neobvezno)';

  @override
  String get noteLabel => 'Opomba (neobvezno)';

  @override
  String get storeLabel => 'Trgovina';

  @override
  String get keepAmountsAction => 'Obdrži zneske';

  @override
  String get resetAmountsAction => 'Ponastavi zneske';

  @override
  String get currencyChangeWarning =>
      'Valuta se spreminja. Kaj naj se zgodi z obstoječimi zneski?';

  @override
  String get listsEmpty =>
      'Še nimate seznamov. Ustvarite svoj prvi nakupovalni načrt.';

  @override
  String get statusDraft => 'Osnek';

  @override
  String get statusPlanned => 'Načrtovano';

  @override
  String get statusShopping => 'Nakupovanje';

  @override
  String get statusCompleted => 'Dokončano';

  @override
  String get statusArchived => 'Arhivirano';

  @override
  String autoListTitle(String date) {
    return 'Nakupi $date';
  }

  @override
  String get itemFormTitle => 'Dodaj artikel';

  @override
  String get itemNameLabel => 'Ime artikla';

  @override
  String get brandLabel => 'Blagovna znamka / različica (neobvezno)';

  @override
  String get categoryLabel => 'Kategorija';

  @override
  String get quantityLabel => 'Količina';

  @override
  String get unitLabel => 'Enota';

  @override
  String get pricingModeLabel => 'Vnos cene';

  @override
  String get pricingModeUnitPrice => 'Cena na enoto';

  @override
  String get pricingModeLineTotal => 'Skupaj za vrstico';

  @override
  String get plannedPriceLabel => 'Načrtovana cena';

  @override
  String lineTotalCalculated(String value) {
    return 'Skupaj za vrstico: $value';
  }

  @override
  String get requiredItemToggle => 'Obvezen artikel';

  @override
  String get maxPriceLabel => 'Najvišja sprejemljiva cena (neobvezno)';

  @override
  String get itemNoteLabel => 'Opomba (neobvezno)';

  @override
  String get categoryProduce => 'Sadje in zelenjava';

  @override
  String get categoryDairy => 'Mlečni izdelki';

  @override
  String get categoryMeat => 'Mesne pridelke';

  @override
  String get categoryBakery => 'Pečenka';

  @override
  String get categoryDrinks => 'Pijače';

  @override
  String get categoryCleaning => 'Čistila';

  @override
  String get categoryPersonalCare => 'Osebna nega';

  @override
  String get categoryHome => 'Dom';

  @override
  String get categoryOther => 'Drugo';

  @override
  String get invalidQuantityError => 'Neveljavna količina';

  @override
  String get invalidPriceError => 'Neveljavna cena';

  @override
  String get invalidNameError => 'Vnesite ime';

  @override
  String unitPriceCalculated(String value) {
    return 'Enotna cena: $value';
  }

  @override
  String get shoppingTitle => 'Način nakupovanja';

  @override
  String get summaryPlannedTotal => 'Načrtovano';

  @override
  String get summaryInCart => 'V košarici';

  @override
  String get summaryRemainingPlan => 'Preostanek načrta';

  @override
  String get summaryProjected => 'Predvidena plačila';

  @override
  String get summaryBudgetRemaining => 'Preostanek proračuna';

  @override
  String get summaryBudgetOver => 'Prekoračen proračun';

  @override
  String itemsProgress(String done, String total) {
    return '$done od $total izdelkov';
  }

  @override
  String get filterAll => 'Vse';

  @override
  String get filterToBuy => 'Za nakup';

  @override
  String get filterInCart => 'V košarici';

  @override
  String get filterNotFound => 'Ni najdeno';

  @override
  String get filterRequired => 'Potrebno';

  @override
  String get quickEntryTitle => 'Dejanska cena';

  @override
  String get actualQuantityLabel => 'Dejanska količina';

  @override
  String get actualPriceLabel => 'Dejanska cena';

  @override
  String get discountLabel => 'Popust (neobvezno)';

  @override
  String get alternativeNameLabel => 'Ime alternativnega izdelka (neobvezno)';

  @override
  String get savePurchaseButton => 'Dodaj v košarico';

  @override
  String get unplannedAddButton => 'Dodaj nepredviden izdelek';

  @override
  String get statusPending => 'Ni vzeto';

  @override
  String get statusInCart => 'V košarici';

  @override
  String get statusNotFound => 'Ni najdeno';

  @override
  String get statusGaveUp => 'Odstopljeno';

  @override
  String get statusAlternative => 'Kupljena alternativa';

  @override
  String get keepScreenAwake => 'Ohrani zaslon vklopljen';

  @override
  String get finishShopping => 'Končaj nakupovanje';

  @override
  String get completionWarning =>
      'Manjkajo ali niso preverjeni zapisi. Kljub temu lahko končate; rezultat bo to označil.';

  @override
  String get continueShoppingButton => 'Nadaljuj z nakupovanjem';

  @override
  String get resultTitle => 'Rezultat';

  @override
  String get summarySection => 'Povzetek';

  @override
  String get plannedTotalLabel => 'Skupaj načrtovano';

  @override
  String get actualTotalLabel => 'Skupaj dejansko';

  @override
  String get varianceLabel => 'Razlika';

  @override
  String get varianceNotComputable => 'Ni mogoče izračunati';

  @override
  String get budgetStatusLabel => 'Proračun';

  @override
  String get savingsLabel => 'Pod načrtom';

  @override
  String get overspendLabel => 'Nad načrtom';

  @override
  String get unplannedTotalLabel => 'Skupaj nepredvideno';

  @override
  String get unpurchasedLabel => 'Načrtovano, a ne kupljeno';

  @override
  String get totalDiscountLabel => 'Skupni popusti';

  @override
  String get accuracyLabel => 'Natančnost ocene';

  @override
  String get groupsSection => 'Izdelki';

  @override
  String get groupPricier => 'Dragše kot načrtovano';

  @override
  String get groupCheaper => 'Ceneje kot načrtovano';

  @override
  String get groupClose => 'Blizu ocene';

  @override
  String get groupNotTaken => 'Načrtovano, ni kupljeno';

  @override
  String get groupUnplanned => 'Kupljeno brez načrta';

  @override
  String get groupQuantityChanged => 'Količina spremenjena';

  @override
  String get groupUnverified => 'Ni preverjeno';

  @override
  String get plannedQtyLabel => 'Načrtovana količina';

  @override
  String get actualQtyLabel => 'Dejanska količina';

  @override
  String get plannedUnitPriceLabel => 'Načrtovana enotna cena';

  @override
  String get actualUnitPriceLabel => 'Dejanska enotna cena';

  @override
  String get lineVarianceLabel => 'Razlika vrstice';

  @override
  String get discountEffectLabel => 'Učinek popusta';

  @override
  String get notBoughtMark => 'ni kupljeno';

  @override
  String get noPurchasesNote => 'Nakupi niso bili zabeleženi.';

  @override
  String get navHome => 'Domov';

  @override
  String get navLists => 'Seznami';

  @override
  String get navHistory => 'Zgodovina';

  @override
  String get navSettings => 'Nastavitve';

  @override
  String get homeEmptyTitle => 'Načrtujte nakupovanje';

  @override
  String get homeEmptyBody =>
      'Ustvarite svoj prvi seznam in primerjajte načrtovane s dejanskimi stroški.';

  @override
  String get homeActiveSection => 'Aktivni seznami';

  @override
  String get homeCompletedSection => 'Dokončano v nedavnem času';

  @override
  String get homeMonthlySection => 'Ta mesec';

  @override
  String get monthPlannedLabel => 'Načrtovano';

  @override
  String get monthActualLabel => 'Dejansko';

  @override
  String get monthVarianceLabel => 'Razlika';

  @override
  String get continueShoppingLabel => 'Nadaljujte z nakupovanjem';

  @override
  String get historyEmpty =>
      'Še ni dokončanega nakupovanja. Vaša zgodovina in vpogledi se bodo pojavili tukaj.';

  @override
  String get aboutTabTitle => 'O programu NShoptor';

  @override
  String get aboutBody =>
      'NShoptor od Crazy Penguin. Načrtovalnik nakupovanja, ki deluje brez povezave. Licencirano pod GPL-3.0.';

  @override
  String get startShoppingLabel => 'Začni z nakupovanjem';

  @override
  String get finishAndSeeResult => 'Končaj & oglej si rezultat';

  @override
  String get settingsTitle => 'Nastavitve';

  @override
  String get languageLabel => 'Jezik';

  @override
  String get languageSystem => 'Sistem';

  @override
  String get languageTr => 'Turščina';

  @override
  String get languageEn => 'Angleščina';

  @override
  String get themeLabel => 'Tema';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get themeLight => 'Svetla';

  @override
  String get themeDark => 'Temna';

  @override
  String get defaultCurrencyLabel => 'Privzeta valuta';

  @override
  String get defaultUnitLabel => 'Privzeta enota';

  @override
  String get keepAwakeLabel => 'Ohrani zaslon vklopljen med nakupovanjem';

  @override
  String get backupSection => 'Varnostna kopija';

  @override
  String get exportBackupLabel => 'Izvozi varnostno kopijo';

  @override
  String get importBackupLabel => 'Uvozi varnostno kopijo';

  @override
  String get mergeImportLabel => 'Združi s trenutnimi podatki';

  @override
  String get separateImportLabel => 'Uvozi kot ločeno kopijo';

  @override
  String get importCancelled => 'Uvoz preklican.';

  @override
  String get backupExported => 'Varnostna kopija uspešno izvožena.';

  @override
  String get backupSizeWarning =>
      'Velika varnostna kopija: datoteka je lahko velika. Želite vključiti tudi fotografije?';

  @override
  String get deleteAllSection => 'Nevarna cona';

  @override
  String get deleteAllLabel => 'Izbriši vse podatke';

  @override
  String get deleteAllConfirm =>
      'To bo odstranilo vse sezname, zgodovino, fotografije računov in cene. Datoteke, ki ste jih izvozili vi, ostanejo na vašem disku. Nadaljujete?';

  @override
  String get deleteAllConfirm2 =>
      'Ste popolnoma prepričani? Tega dejanja ni mogoče razveljaviti.';

  @override
  String get cancelAction => 'Prekliči';

  @override
  String get confirmDelete => 'Trajno izbriši';

  @override
  String get dataDeleted => 'Vsi lokalni podatki so bili izbrisani.';

  @override
  String get privacyInfoLabel => 'Zasebnost';

  @override
  String get privacyInfoBody =>
      'Vaši seznami, cene, računi in fotografije ostanejo na vaši napravi. Fotografije in glas nikoli ne zapustijo naprave. Ko je pomoč AI vklopljena, se na naš strežnik pošlje le besedilo (na primer vrstice iz računa ali kar ste diktirali) za obdelavo in se ne shrani.';

  @override
  String get aboutSection => 'O nas';

  @override
  String get aboutPublisher => 'Izdajatelj: Crazy Penguin';

  @override
  String get aboutLicenses => 'Licence (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Glasovni vnos';

  @override
  String get voiceStatusUnknown => 'Storitev: preverjeno ni';

  @override
  String get permissionsLabel => 'Dovoljenja';

  @override
  String get permissionsBody =>
      'Kamera, mikrofon in obvestila so zahtevana samo, ko dejansko uporabljate te funkcije.';

  @override
  String get unitsSection => 'Privzete nastavitve';

  @override
  String get roundingNote =>
      'Zakroževanje denarja sledi pravilu: polovice se zakrožijo stran od ničle, uporabi se enkrat pri pretvorbi denarja.';

  @override
  String get voiceInputTitle => 'Glasovni vnos';

  @override
  String get voiceStartListening => 'Začni poslušati';

  @override
  String get voiceTranscriptLabel => 'Besedilo';

  @override
  String get parseAction => 'Analiziraj';

  @override
  String get receiptReviewTitle => 'Preglej račun';

  @override
  String get receiptTotal => 'Skupni znesek računa';

  @override
  String get receiptTotalUnknown => 'Skupni znesek ni zaznan';

  @override
  String get receiptDiff => 'Razlika';

  @override
  String get acceptLine => 'Sprejmi vrstico';

  @override
  String get ignoreLine => 'Prezri vrstico';

  @override
  String get receiptLineActions => 'Poveži s predmetom, razdeli ali prezri';

  @override
  String get receiptCommit => 'Sprejmi vse';

  @override
  String get receiptCommitted => 'Račun je uporabljen.';

  @override
  String get priceHistoryTitle => 'Zgodovina cen';

  @override
  String get noObservations => 'Še brez opazovanj cen';

  @override
  String get templatesSection => 'Predloge';

  @override
  String get templateHint => 'Ustvari nov načrt iz prejšnje nakupovalne poti';

  @override
  String get scanReceiptAction => 'Skeniraj račun';

  @override
  String get shelfLabelAction => 'Cena z nalepnice na polici';

  @override
  String get priceCandidatesTitle => 'Kandidati za ceno';

  @override
  String get noPriceCandidates => 'Cene ni mogoče najti; vnesite jo ročno.';

  @override
  String get voiceUnavailable =>
      'Glasovno prepoznavanje ni na voljo; vnesite ročno.';

  @override
  String get linkToItem => 'Poveži s predmetom';

  @override
  String get splitLine => 'Razdeli na dva';

  @override
  String get mergeWithNext => 'Združi z naslednjim';

  @override
  String get ocrNoText => 'Besedilo ni bilo prebrano; poskusite znova.';

  @override
  String get priceHistoryAction => 'Zgodovina cen';

  @override
  String get itemsEmptyTitle => 'Še ni predmetov';

  @override
  String get itemsEmptyBody =>
      'Dodajte svoj prvi predmet — prave cene boste vnesli tukaj v trgovini.';

  @override
  String get addItemTooltip => 'Dodaj predmet';

  @override
  String get unitAdet => 'kos';

  @override
  String get unitKilogram => 'kg';

  @override
  String get unitGram => 'g';

  @override
  String get unitLitre => 'L';

  @override
  String get unitMililitre => 'ml';

  @override
  String get unitPaket => 'paket';

  @override
  String get unitKutu => 'škatla';

  @override
  String get unitSise => 'steklenica';

  @override
  String get unitKavanoz => ' kozarec';

  @override
  String get unitDemet => 'snop';

  @override
  String get unitDuzine => 'ducat';

  @override
  String get unitMetre => 'm';

  @override
  String get unitCustom => 'Po meri';

  @override
  String get setReminderAction => 'Nastavi opomnik';

  @override
  String get reminderPermissionDenied =>
      'Za opomnike je potrebna dovoljenje za obvestila. Omogočite ga lahko v nastavitvah sistema.';

  @override
  String get reminderScheduled => 'Opomnik nastavljen.';

  @override
  String get reminderCancelled => 'Opomnik odstranjen.';

  @override
  String get reminderTitle => 'Opomnik za nakupovanje';

  @override
  String reminderBody(Object title) {
    return 'Čas je, da preverite svoj seznam: $title';
  }

  @override
  String get reminderPickDate => 'Izberite datum';

  @override
  String get reminderPickTime => 'Izberite čas';

  @override
  String get itemDetailsSection => 'Podrobnosti';

  @override
  String get priceOptionalHint =>
      'Neobvezno — pravo ceno boste vnesli v trgovini';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Načrtovano: $total · $count predmetov';
  }

  @override
  String get proActiveLabel => 'Pro aktivno — hvala!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Brez oglasov, več AI, varnostna kopija · od majhne mesečne cene';

  @override
  String get proBenefitNoAds => 'Brez oglasov';

  @override
  String get proBenefitBackup => 'Varnostna kopija (izvoz/uvoz)';

  @override
  String aboutVersion(Object version) {
    return 'Različica $version';
  }

  @override
  String get navDiscover => 'Odkrij';

  @override
  String get shareAction => 'Delite aplikacijo';

  @override
  String get rateAction => 'Ocenite nas';

  @override
  String get aboutOpenRow => 'O aplikaciji in odprta koda';

  @override
  String get voiceAddItemAction => 'Dodaj z glasom';

  @override
  String get formatLocaleLabel => 'Oblika številk in valute';

  @override
  String get formatLocaleSystem => 'Sistem (sledi jeziku aplikacije)';

  @override
  String get formatLocaleTr => 'Turško (1.234,56)';

  @override
  String get formatLocaleEn => 'Angleško (1,234.56)';

  @override
  String get aiToggleTitle => 'Pomoč AI';

  @override
  String get aiToggleSubtitle =>
      'Ujema račune, bere cenike in pretvarja stavke v sezname. Fotografije in glas ostanejo na vašem napravi; obdeluje se le besedilo.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Ta mesec ste porabili vse zahteve AI ($used/$limit). Nadgradite za več ali nadaljujte brez AI.';
  }

  @override
  String get aiOffline => 'Ni povezave — nadaljujemo brez AI.';

  @override
  String get aiFailed => 'AI trenutno ni na voljo — nadaljujemo brez njega.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'Naprava';

  @override
  String get quickListAction => 'Dodaj iz stavka';

  @override
  String get quickListTitle => 'Hitri seznam';

  @override
  String get quickListHint =>
      'npr. 1 kg jabolk 20, 2 kruha, pol kilograma sira';

  @override
  String get quickListConvert => 'Pretvori v seznam';

  @override
  String quickListAdd(int count) {
    return 'Dodaj $count elementov';
  }

  @override
  String get quickListEmpty =>
      'Ni najdenih elementov. Poskusite jih naštevati ločeno z vejicami.';

  @override
  String get receiptAiMatched =>
      'AI je ujel račun s svojim seznamom. Preverite povezave in potrdite.';

  @override
  String get receiptNeedsCheck => 'Preveri to ujemanje';

  @override
  String get receiptDiscountLine => 'Popust';

  @override
  String get compareItem => 'Element';

  @override
  String get compareEstimated => 'Ocena';

  @override
  String get compareActual => 'Dejansko';

  @override
  String get compareDiff => 'Razlika';

  @override
  String get compareTotal => 'Skupaj';

  @override
  String get compareBudget => 'Proračun';

  @override
  String get compareNotBought => 'ni kupljeno';

  @override
  String get compareUnplanned => 'ni načrtovano';

  @override
  String get pricierItems => 'Stalo je več';

  @override
  String get cheaperItems => 'Stalo je manj';

  @override
  String get compareAction => 'Primerjaj';

  @override
  String get detailsSection => 'Podrobnosti';

  @override
  String get spendingTitle => 'Poraba';

  @override
  String get spendingAction => 'Poraba';

  @override
  String get spendingMonthTotal => 'Ta mesec';

  @override
  String get spendingWeekly => 'Tedenska poraba';

  @override
  String get spendingMonthly => 'Mesečna poraba';

  @override
  String get monthlyLimitTitle => 'Mesečni limit';

  @override
  String get monthlyLimitHelp =>
      'Koliko želite porabiti za nakupovanje na mesec?';

  @override
  String get monthlyLimitRemove => 'Odstrani';

  @override
  String get monthlyLimitSet => 'Nastavi';

  @override
  String get monthlyLimitChange => 'Spremeni';

  @override
  String get monthlyLimitNone =>
      'Nastavite mesečni limit, da vidite, koliko vam še ostaja.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount čez limito';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return '$amount ostalo ta mesec';
  }

  @override
  String get plansTitle => 'Načrti';

  @override
  String get plansHeadline => 'Nakupujte pametneje z AI';

  @override
  String get plansSubhead =>
      'Ujemanje računov, ceniki in sezname iz stavka. Odjava kadarkoli.';

  @override
  String get plansMonthly => 'Mesečno';

  @override
  String get plansYearly => 'Letno';

  @override
  String get planFree => 'Brezplačno';

  @override
  String get planFreePrice => 'Za vedno brezplačno';

  @override
  String get planFreeAi => '15 zahtev AI na mesec';

  @override
  String get planFreeAds => 'Manjši banerski oglasi (brez v prvih 7 dneh)';

  @override
  String get planCoreFeatures => 'Seznami, cene, računi, grafi porabe';

  @override
  String get plansPerYear => '/ leto';

  @override
  String get plansPerMonth => '/ mesec';

  @override
  String get planTrial => '7 dni brezplačno';

  @override
  String get planProAi => '200 zahtev AI na mesec';

  @override
  String get planNoAds => 'Brez oglasov';

  @override
  String get planBackup => 'Izvoz in uvoz varnostnih kopij';

  @override
  String get planMaxAi => '1000 zahtev AI na mesec';

  @override
  String get planMaxFamily => 'Za nakupovanje velike družine';

  @override
  String get plansStoreUnavailable => 'Trgovina trenutno ni dosegljiva.';

  @override
  String get retryAction => 'Poskusi znova';

  @override
  String get plansPurchaseFailed => 'Nakup ni bil uspešen. Poskusite znova.';

  @override
  String get planLifetimeTitle => 'Brez oglasov za vedno';

  @override
  String get planLifetimeSubtitle =>
      'Enkratno plačilo: brez oglasov, varnostne kopije; AI ostane v okviru brezplačne dovoljene količine';

  @override
  String get plansRestore => 'Obnovi nakupe';

  @override
  String get plansLegal =>
      'Naročnine se samodejno obnavljajo, dokler jih ne prekličete. Preklicati jih lahko kadarkoli v Google Play › Plačila in naročnine. Cene vključujejo davke, ki jih prikaže Google Play.';

  @override
  String get planCurrent => 'Trenutna';

  @override
  String get planStartTrial => 'Začni 7-dnevno brezplačno preizkušnjo';

  @override
  String get planChoose => 'Izberi';

  @override
  String get plansAction => 'Načrti: Pro in Max';

  @override
  String get assistantTitle => 'Pomočnik';

  @override
  String get assistantGreeting => 'Živijo! Kaj želiš narediti?';

  @override
  String get assistantNewList => 'Nov seznam';

  @override
  String get assistantVoiceList => 'Seznam z glasom';

  @override
  String get assistantTextList => 'Seznam iz stavka';

  @override
  String get assistantScanReceipt => 'Skeniraj račun';

  @override
  String get assistantSpending => 'Moji stroški';

  @override
  String get assistantReceiptHint =>
      'Odpri svoj seznam in pritisni ikono računa za skeniranje.';

  @override
  String get assistantToggleTitle => 'Prikaži pomočnika';

  @override
  String get assistantToggleSubtitle => 'Mali pomočnik v spodnjem desnem kotu';

  @override
  String get scanPriceLabel => 'Skeniraj cenovno nalepko';

  @override
  String get saveFailed =>
      'Shranjevanje ni uspelo. Vaše spremembe so še vedno tukaj. Poskusite znova.';

  @override
  String get deleteItemConfirm =>
      'Izbrišite ta artikel in vse zabeležene nakupe?';

  @override
  String get clearPurchaseConfirm =>
      'Označite ta artikel kot ne-nakupovan in odstranite vse zabeležene nakupe?';

  @override
  String get reportPdfAction => 'Shrani poročilo PDF';

  @override
  String get reportNotInvoice =>
      'Povzetek nakupov, ne davčna faktura. Davne stopnje so neznane.';

  @override
  String get purchaseVisits => 'Obiski nakupovanja';

  @override
  String get purchaseInterval => 'Povprečno število dni med nakupi';

  @override
  String get purchasedQuantity => 'Količina kupljenega';

  @override
  String get purchaseAnalyticsHint =>
      'Nakupi ne merijo porabe. Valute in enote so prikazane ločeno.';

  @override
  String get receiptReplaces =>
      'Povezane vrstice računa nadomestijo obstoječe nakupe; nepovezane vrstice se dodajo.';

  @override
  String get voiceUnsupportedLanguage =>
      'Ta jezik na tej napravi ni podprt za glasovni vnos. Namesto tega lahko tipkate.';
}
