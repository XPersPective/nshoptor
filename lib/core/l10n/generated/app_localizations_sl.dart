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
      'Vaši seznami, cene, računi in fotografije so shranjeni v vaši napravi. Glas je nikoli ne zapusti. Ko je pomoč AI vklopljena, se fotografije računov in cenovnih oznak (pomanjšane) ter besedilo, na primer narekovani izdelki, pošljejo na naš strežnik samo za branje; obdelajo se takoj in se nikoli ne shranijo.';

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
  String get fromReceiptListButton => 'Iz računa';

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
      'Brez oglasov · Izvoz in uvoz varnostnih kopij · Letno';

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
  String get formatLocaleSystem =>
      'Oblika sistema (latinske števke; sicer angleško)';

  @override
  String get formatLocaleTr => 'Turško (1.234,56)';

  @override
  String get formatLocaleEn => 'Angleško (1,234.56)';

  @override
  String get aiToggleTitle => 'Pomoč AI';

  @override
  String get aiToggleSubtitle =>
      'Bere račune in cenovne oznake s fotografij, ujema račune in pretvarja stavke v sezname. Fotografije se pošljejo samo za branje in se nikoli ne shranijo.';

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
  String get planFreeAi => '10 zahtev AI na mesec';

  @override
  String get planFreeAds => 'Manjši banerski oglasi (brez v prvih 7 dneh)';

  @override
  String get planCoreFeatures => 'Seznami, cene, računi, grafi porabe';

  @override
  String get plansPerYear => '/ leto';

  @override
  String get plansPerMonth => '/ mesec';

  @override
  String get planTrial => 'Brezplačni preizkus';

  @override
  String get planProAi => '100 zahtev AI na mesec';

  @override
  String get planNoAds => 'Brez oglasov';

  @override
  String get planBackup => 'Izvoz in uvoz varnostnih kopij';

  @override
  String get planMaxAi => '300 zahtev AI na mesec';

  @override
  String get planMaxFamily => 'Za nakupovanje velike družine';

  @override
  String get plansStoreUnavailable => 'Trgovina trenutno ni dosegljiva.';

  @override
  String get retryAction => 'Poskusi znova';

  @override
  String get plansPurchaseFailed => 'Nakup ni bil uspešen. Poskusite znova.';

  @override
  String get plansRestore => 'Obnovi nakupe';

  @override
  String get plansLegal =>
      'Pro se samodejno obnavlja vsako leto do preklica in vključuje 100 zahtevkov UI na mesec. Osnovna cena je 1 ameriški dolar na leto pred veljavnimi davki; pred potrditvijo nakupa preverite končno lokalno ceno in davke v trgovini. Naročnino upravljajte ali prekličite v Googlu Play.';

  @override
  String get planCurrent => 'Trenutna';

  @override
  String get planStartTrial => 'Začni brezplačni preizkus';

  @override
  String get planChoose => 'Izberi';

  @override
  String get plansAction => 'Načrti: Pro';

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
      'Cene izdelkov brez cene se dopolnijo. Izdelki s tržno ceno se dodajo kot ločeni nakupi.';

  @override
  String get receiptIncompleteHeader =>
      'Na naslednji fotografiji naj bodo trgovina, datum, ura in številka računa.';

  @override
  String get receiptIncompleteTail =>
      'Fotografirajte naslednji del z nekaj prekrivajočimi se izdelki in končnim zneskom.';

  @override
  String get receiptContinuationRejected =>
      'Te fotografije ni bilo mogoče združiti. Znova jo posnemite s prekrivajočimi se izdelki z istega računa.';

  @override
  String get receiptDraftSaved =>
      'Račun je shranjen kot osnutek. Nadaljujete lahko pozneje.';

  @override
  String get receiptContinueAction => 'Nadaljuj račun';

  @override
  String get receiptDraftsTitle => 'Nedokončani računi';

  @override
  String get receiptDuplicate => 'Ta račun je že dodan.';

  @override
  String get receiptTotalMismatch =>
      'Vsota izdelkov se ne ujema s skupnim zneskom na računu. Preverite, ali je viden celoten račun.';

  @override
  String get receiptSaveDraftAction => 'Shrani za pozneje';

  @override
  String get receiptResolveLines =>
      'Pred shranjevanjem sprejmite ali prezrite vsak izdelek.';

  @override
  String get receiptPartialConfirm =>
      'Dodani bodo samo izbrani izdelki. Ta račun bo označen kot uvožen. Želite nadaljevati?';

  @override
  String get voiceUnsupportedLanguage =>
      'Ta jezik na tej napravi ni podprt za glasovni vnos. Namesto tega lahko tipkate.';

  @override
  String get voiceStopListening => 'Ustavi poslušanje';

  @override
  String get keepAwakeFailed => 'Zaslon ni ostal vklopljen. Poskusite znova.';

  @override
  String get purchaseHistoryHint =>
      'Vsa zaključena nakupovanja. Vrnitve zmanjšajo skupne vsote. Datumi se nanašajo na datum zaključka nakupa. En obisk ni dovolj za izračun povprečnega intervala.';

  @override
  String get planLegacyRights =>
      'Obstoječe naročnine Pro in Max ohranjajo svoj prvotni mesečni obseg AI zahtevkov.';

  @override
  String get csvExportAction => 'Izvozi CSV';

  @override
  String get reportSharePdf => 'Deli kot PDF';

  @override
  String get reportShareCsv => 'Deli kot CSV';

  @override
  String get reportPrintAction => 'Natisni';

  @override
  String get backupSizeWarning =>
      'JSON vsebuje zapise, ne datotek s fotografijami. Omejitev uvoza: 16 MB.';

  @override
  String get backupImportFailed =>
      'Uvoza te varnostne kopije ni bilo mogoče izvesti. Vaši podatki niso bili spremenjeni.';

  @override
  String get backupImported => 'Nadzorna kopija je bila uspešno uvožena.';

  @override
  String backupPreviewCounts(Object entries, Object items, Object lists) {
    return '$lists seznama · $items izdelkov · $entries nakupov';
  }

  @override
  String get voiceModelDownloading =>
      'Glasovni model za ta jezik se prenaša. Poskusite znova čez minuto.';

  @override
  String get historyThisWeek => 'Ta teden';

  @override
  String get historyProductsSection => 'Kupljeni izdelki';

  @override
  String get tipReceiptScan =>
      'Optično preberite račun in ujemajte cene s seznamom';

  @override
  String get tipVoiceAdd =>
      'Izgovorite enega ali več izdelkov in jih pred dodajanjem preglejte';

  @override
  String get tipShelfCamera => 'S kamero preberite ceno z nalepke na polici';

  @override
  String get tipPlan =>
      'Vaš načrt: oglejte si podrobnosti, naročite se ali nadgradite';

  @override
  String get guideAddBody =>
      'Tapnite +, da dodate izdelek. Vnesite načrtovano ceno zdaj, tržno ceno pa na blagajni.';

  @override
  String get guideVoiceBody =>
      'Tapnite mikrofon in povejte izdelke, na primer: »1 kg jabolk, 1 kruh«.';

  @override
  String get guideReceiptBody =>
      'Optično preberite račun, da ujamete njegove cene z izdelki na seznamu.';

  @override
  String get guidePlanBody =>
      'Tapnite ikono načrta, da si ogledate načrt, se naročite ali nadgradite.';

  @override
  String get guideNext => 'V redu';

  @override
  String get guideDone => 'Začni';

  @override
  String get paletteLabel => 'Barvna tema';

  @override
  String get paletteForest => 'Gozd';

  @override
  String get paletteOcean => 'Ocean';

  @override
  String get paletteSunset => 'Sončni zahod';

  @override
  String get paletteLavender => 'Sivka';

  @override
  String get darkBlackLabel => 'Čisto črna v temni temi';

  @override
  String get spendingOverview => 'Pregled';

  @override
  String get spendingThisYear => 'Letos';

  @override
  String get spendingYearly => 'Letna poraba';

  @override
  String get productSpending => 'Poraba po izdelkih';

  @override
  String get spanWeek => 'Teden';

  @override
  String get spanMonth => 'Mesec';

  @override
  String get spanYear => 'Leto';

  @override
  String get weeklyLimitTitle => 'Tedenska omejitev';

  @override
  String get weeklyLimitHelp => 'Koliko želite tedensko porabiti za nakupe?';

  @override
  String get weeklyLimitNone =>
      'Nastavite tedensko omejitev, da vidite, koliko je ostalo.';

  @override
  String weeklyLimitLeft(String amount) {
    return 'Ta teden je ostalo $amount';
  }

  @override
  String get shoppingLimitTitle => 'Omejitev na nakup';

  @override
  String get shoppingLimitHelp => 'Novi seznami se začnejo s tem proračunom.';

  @override
  String get shoppingLimitNone =>
      'Nastavite privzeti proračun za vsak nov nakup.';

  @override
  String get monthlyReportAction => 'Mesečno poročilo';

  @override
  String get reportShoppingColumn => 'Nakup';

  @override
  String get reportDateColumn => 'Datum';

  @override
  String get planUnavailable => 'Trenutno ni na voljo v trgovini';

  @override
  String get demoDataTitle => 'Vzorčni podatki';

  @override
  String get demoDataLoad => 'Preizkusi z vzorčnimi podatki';

  @override
  String get demoDataLoadHelp =>
      'Doda 12 mesecev vzorčnih nakupov, da vidite zgodovino, grafe in zgodovino cen.';

  @override
  String get demoDataRemove => 'Odstrani vzorčne podatke';

  @override
  String get demoDataAdded => 'Vzorčni podatki dodani';

  @override
  String get demoDataRemoved => 'Vzorčni podatki odstranjeni';

  @override
  String get demoProductApple => 'Jabolka';

  @override
  String get demoProductBread => 'Kruh';

  @override
  String get demoProductMilk => 'Mleko';

  @override
  String get demoProductCheese => 'Sir';

  @override
  String get demoProductTomato => 'Paradižnik';

  @override
  String get demoProductEggs => 'Jajca';

  @override
  String get demoProductCoffee => 'Kava';

  @override
  String get demoProductDetergent => 'Detergent';

  @override
  String get sendAction => 'Send';

  @override
  String get previousMonthAction => 'Previous month';

  @override
  String get nextMonthAction => 'Next month';

  @override
  String get helpSection => 'Pomoč in podpora';

  @override
  String get howToUseLabel => 'Kako uporabljati';

  @override
  String get guidePricesBody =>
      'Cena v trgovini označi izdelek kot kupljen; šteje tudi 0. Domača cena ni obvezna. Izbrišite ceno v trgovini, da odstranite kljukico.';

  @override
  String get shoppingDateLabel => 'Datum nakupa';

  @override
  String get shoppingDateNone => 'Datum ni izbran';

  @override
  String get clearShoppingDateAction => 'Odstrani datum';

  @override
  String get listSortLabel => 'Vrstni red seznama';

  @override
  String get listSortDate => 'Datum nakupa';

  @override
  String get listSortAz => 'Ime (A–Ž)';

  @override
  String get listSortManual => 'Ročni vrstni red';

  @override
  String get imageCameraAction => 'Fotografiraj';

  @override
  String get imageGalleryAction => 'Izberi iz fotografij';

  @override
  String get imageCaptureFailed =>
      'Kamere ali fotografij ni bilo mogoče odpreti. Preverite dovoljenje za dostop in poskusite znova.';

  @override
  String get imageRecognitionFailed =>
      'Fotografije ni bilo mogoče obdelati. Poskusite z drugo fotografijo.';

  @override
  String get receiptNoProducts =>
      'Besedilo je bilo prebrano, vendar izdelki na računu niso bili najdeni. Na fotografijo vključite izdelke in skupni znesek.';

  @override
  String get keepAwakeOn => 'Zaslon ostane vklopljen';

  @override
  String get keepAwakeOff => 'Zaslon se lahko izklopi';

  @override
  String get spanDay => 'Dan';

  @override
  String get spanCustom => 'Časovno obdobje';

  @override
  String get reportTotalSpent => 'Skupaj porabljeno';

  @override
  String get reportAddedAt => 'Dodano';

  @override
  String get reportReceiptNumber => 'Številka računa';

  @override
  String get reportPreview => 'Predogled';

  @override
  String get reportShareAction => 'Deli';

  @override
  String get previousPeriodAction => 'Prejšnje obdobje';

  @override
  String get nextPeriodAction => 'Naslednje obdobje';

  @override
  String get reportSaved => 'Poročilo je shranjeno.';

  @override
  String get reportZoom => 'Povečaj';

  @override
  String planTrialDaysLeft(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dni preostanejo',
      few: '$days dnevi preostanejo',
      two: '$days dneva preostaneta',
      one: '$days dan preostane',
    );
    return '$_temp0';
  }

  @override
  String planTrialHoursLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours ur preostane',
      few: '$hours ure preostanejo',
      two: '$hours uri preostaneta',
      one: '$hours ura preostane',
    );
    return '$_temp0';
  }

  @override
  String get planTrialEndedTitle => 'Preizkusno obdobje Pro se je končalo';

  @override
  String get planTrialEndedBody =>
      'Sezname, ročni vnos in glasovne funkcije v napravi lahko še naprej uporabljate brezplačno. Brezplačni paket vključuje 10 zahtev za AI na koledarski mesec. Izberite letni Pro za 100 zahtev za AI na mesec, brez oglasov in z varnostnimi kopijami. Vaši obstoječi podatki ostanejo vaši.';

  @override
  String get planContinueFree => 'Nadaljuj brezplačno';

  @override
  String get supportIdLabel => 'ID podpore';

  @override
  String get supportEmailLabel => 'Podpora po e-pošti';

  @override
  String get captureTipFirst =>
      'Začnite povsem na vrhu: ime trgovine in datum morata biti vidna. Zajemite čim več izdelkov, ostali bodo na naslednji fotografiji.';

  @override
  String get captureTipContinue =>
      'Isti račun: vključite zadnji izdelek s prejšnje fotografije.';

  @override
  String get captureTipNeverShow => 'Ne prikaži več';

  @override
  String get captureTipOk => 'Razumem';

  @override
  String get captureTipsSetting => 'Prikaži nasvete za slikanje računa';

  @override
  String get receiptReadingProgress => 'Branje računa …';

  @override
  String get receiptReadInBackground => 'Nadaljuj v ozadju';

  @override
  String get receiptReadDoneTitle => 'Račun prebran';

  @override
  String get receiptReadDoneBody => 'Tapnite za pregled in shranjevanje.';

  @override
  String get receiptReadMoreTitle => 'Fotografirajte preostanek računa';

  @override
  String get receiptReadFailedTitle => 'Računa ni bilo mogoče prebrati';

  @override
  String get listReceiptsSection => 'Računi';

  @override
  String get receiptStateComplete => 'Dokončan';

  @override
  String get receiptStateIncomplete => 'Nepopoln';

  @override
  String get receiptStateFailed => 'Ni uspelo';

  @override
  String get receiptStoreUnknown => 'Trgovina ni prebrana';

  @override
  String get receiptDeleteAction => 'Izbriši račun';

  @override
  String get receiptDeleteConfirm =>
      'Želite izbrisati ta račun in izdelke, ki jih je dodal? Pozneje ga lahko znova uvozite.';

  @override
  String get receiptDeleted => 'Račun izbrisan.';

  @override
  String listReceiptsShowAll(int count) {
    return 'Pokaži vse ($count)';
  }

  @override
  String get listReceiptsShowLess => 'Pokaži manj';

  @override
  String receiptDateLabel(String date) {
    return 'Datum računa: $date';
  }

  @override
  String get historyViewShopping => 'Po nakupu';

  @override
  String get historyViewStore => 'Po trgovini';

  @override
  String get historyViewProduct => 'Po izdelku';

  @override
  String get historyShareAll => 'Deli vse';

  @override
  String get historyUnknownStore => 'Neznana trgovina';

  @override
  String get historyDailySpending => 'Dnevna poraba';

  @override
  String get historyResetPeriod => 'Nazaj na ta teden';

  @override
  String get tourSkip => 'Preskoči';

  @override
  String get tourNewListBody =>
      'Začnite nakupovalni seznam in dodajte, kar nameravate kupiti.';

  @override
  String get tourFromReceiptBody =>
      'Ste že nakupovali? Spremenite račun v seznam s cenami.';

  @override
  String get tourReceiptFlowBody =>
      'Začnite na vrhu računa: najprej zajemite trgovino in datum, nato nadaljujte s preostalimi vrsticami.';

  @override
  String get tourTabsBody =>
      'Preklapljajte med aktivnimi, dokončanimi in arhiviranimi seznami. Gumb na koncu spremeni vrstni red.';

  @override
  String get tourDiscoverBody => 'Druge aplikacije istega razvijalca.';

  @override
  String get tourHelpBody =>
      'Tapnite tukaj za ponovni ogled vodiča. Odprite seznam za razlago vsot in izdelkov.';

  @override
  String get tourTotalsBody =>
      'Načrtovana, dejanska vsota in razlika se med nakupovanjem posodabljajo.';

  @override
  String get tourItemsBody =>
      'Vaši izdelki. Tukaj spremenite njihov vrstni red ali jih poiščite.';

  @override
  String budgetAlertNear(String percent) {
    return 'Porabljenih $percent % omejitve';
  }
}
