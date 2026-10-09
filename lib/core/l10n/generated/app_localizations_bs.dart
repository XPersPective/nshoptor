// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bosnian (`bs`).
class AppLocalizationsBs extends AppLocalizations {
  AppLocalizationsBs([String locale = 'bs']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Planiraj kod kuće. Kupuj kako si planirao.';

  @override
  String get listsTitle => 'Popisi';

  @override
  String get listsTabActive => 'Aktivni';

  @override
  String get listsTabCompleted => 'Završeni';

  @override
  String get listsTabArchived => 'Arhivirani';

  @override
  String get newListButton => 'Novi popis';

  @override
  String get listTitleHint => 'Naziv (opcionalno)';

  @override
  String get saveButton => 'Spremi';

  @override
  String get cancelButton => 'Otkaži';

  @override
  String get deleteButton => 'Obriši';

  @override
  String get editAction => 'Uredi';

  @override
  String get listDeleted => 'Popis obrisan';

  @override
  String get invalidAmountError => 'Neispravan iznos';

  @override
  String get duplicateAction => 'Kopiraj';

  @override
  String get archiveAction => 'Arhiviraj';

  @override
  String get unarchiveAction => 'Razarhiviraj';

  @override
  String get deleteListConfirm =>
      'Obrisati ovaj popis? Planirane stavke će također biti uklonjene.';

  @override
  String get undoButton => 'Poništi';

  @override
  String get searchListHint => 'Pretraži popise';

  @override
  String get currencyLabel => 'Valuta';

  @override
  String get budgetLabel => 'Budžet (opcionalno)';

  @override
  String get noteLabel => 'Bilješka (opcionalno)';

  @override
  String get storeLabel => 'Trgovina';

  @override
  String get keepAmountsAction => 'Zadrži iznose';

  @override
  String get resetAmountsAction => 'Resetuj iznose';

  @override
  String get currencyChangeWarning =>
      'Valuta se mijenja. Šta treba uraditi sa postojećim iznosima?';

  @override
  String get listsEmpty => 'Još nema popisa. Napravi svoj prvi plan kupovine.';

  @override
  String get statusDraft => 'Nacrt';

  @override
  String get statusPlanned => 'Planirano';

  @override
  String get statusShopping => 'Kupovina';

  @override
  String get statusCompleted => 'Završeno';

  @override
  String get statusArchived => 'Arhivirano';

  @override
  String autoListTitle(String date) {
    return 'Kupovina $date';
  }

  @override
  String get itemFormTitle => 'Dodaj stavku';

  @override
  String get itemNameLabel => 'Naziv stavke';

  @override
  String get brandLabel => 'Marka / varijanta (opcionalno)';

  @override
  String get categoryLabel => 'Kategorija';

  @override
  String get quantityLabel => 'Količina';

  @override
  String get unitLabel => 'Jedinica';

  @override
  String get pricingModeLabel => 'Način unosa cijene';

  @override
  String get pricingModeUnitPrice => 'Cijena po jedinici';

  @override
  String get pricingModeLineTotal => 'Ukupno za stavku';

  @override
  String get plannedPriceLabel => 'Planirana cijena';

  @override
  String lineTotalCalculated(String value) {
    return 'Ukupno za stavku: $value';
  }

  @override
  String get requiredItemToggle => 'Obavezna stavka';

  @override
  String get maxPriceLabel => 'Maksimalna prihvatljiva cijena (opcionalno)';

  @override
  String get itemNoteLabel => 'Bilješka (opcionalno)';

  @override
  String get categoryProduce => 'Voće i povrće';

  @override
  String get categoryDairy => 'Mliječni proizvodi';

  @override
  String get categoryMeat => 'Mesni proizvodi';

  @override
  String get categoryBakery => 'Pečeni proizvodi';

  @override
  String get categoryDrinks => 'Pića';

  @override
  String get categoryCleaning => 'Sredstva za čišćenje';

  @override
  String get categoryPersonalCare => 'Lična higijena';

  @override
  String get categoryHome => 'Za dom';

  @override
  String get categoryOther => 'Ostalo';

  @override
  String get invalidQuantityError => 'Neispravna količina';

  @override
  String get invalidPriceError => 'Neispravna cijena';

  @override
  String get invalidNameError => 'Unesite naziv';

  @override
  String unitPriceCalculated(String value) {
    return 'Jedinična cijena: $value';
  }

  @override
  String get shoppingTitle => 'Način kupovine';

  @override
  String get summaryPlannedTotal => 'Planirano';

  @override
  String get summaryInCart => 'U korpi';

  @override
  String get summaryRemainingPlan => 'Preostali plan';

  @override
  String get summaryProjected => 'Procijenjeno na blagajni';

  @override
  String get summaryBudgetRemaining => 'Preostalo budžeta';

  @override
  String get summaryBudgetOver => 'Izvan budžeta';

  @override
  String itemsProgress(String done, String total) {
    return '$done od $total stavki';
  }

  @override
  String get filterAll => 'Sve';

  @override
  String get filterToBuy => 'Za kupiti';

  @override
  String get filterInCart => 'U korpi';

  @override
  String get filterNotFound => 'Nije pronađeno';

  @override
  String get filterRequired => 'Obavezno';

  @override
  String get quickEntryTitle => 'Stvarna cijena';

  @override
  String get actualQuantityLabel => 'Stvarna količina';

  @override
  String get actualPriceLabel => 'Stvarna cijena';

  @override
  String get discountLabel => 'Popust (opcionalno)';

  @override
  String get alternativeNameLabel =>
      'Naziv alternativnog proizvoda (opcionalno)';

  @override
  String get savePurchaseButton => 'Dodaj u korpu';

  @override
  String get unplannedAddButton => 'Dodaj neplaniranu stavku';

  @override
  String get statusPending => 'Nije uzeto';

  @override
  String get statusInCart => 'U korpi';

  @override
  String get statusNotFound => 'Nije pronađeno';

  @override
  String get statusGaveUp => 'Odustao/la';

  @override
  String get statusAlternative => 'Kupljena alternativa';

  @override
  String get keepScreenAwake => 'Održavaj ekran aktivnim';

  @override
  String get finishShopping => 'Završi kupovinu';

  @override
  String get completionWarning =>
      'Postoje nedostajući ili nepotvrđeni zapisi. I dalje možete završiti; rezultat će ih navesti.';

  @override
  String get continueShoppingButton => 'Nastavi s kupovinom';

  @override
  String get resultTitle => 'Rezultat';

  @override
  String get summarySection => 'Sažetak';

  @override
  String get plannedTotalLabel => 'Ukupno planirano';

  @override
  String get actualTotalLabel => 'Ukupno stvarno';

  @override
  String get varianceLabel => 'Razlika';

  @override
  String get varianceNotComputable => 'Ne može se izračunati';

  @override
  String get budgetStatusLabel => 'Budžet';

  @override
  String get savingsLabel => 'Manje od plana';

  @override
  String get overspendLabel => 'Više od plana';

  @override
  String get unplannedTotalLabel => 'Ukupno neplanirano';

  @override
  String get unpurchasedLabel => 'Planirano, ali nije kupljeno';

  @override
  String get totalDiscountLabel => 'Ukupni popusti';

  @override
  String get accuracyLabel => 'Tačnost procjene';

  @override
  String get groupsSection => 'Stavke';

  @override
  String get groupPricier => 'Skuplje nego planirano';

  @override
  String get groupCheaper => 'Jeftinije nego planirano';

  @override
  String get groupClose => 'Blizu procjene';

  @override
  String get groupNotTaken => 'Planirano, nije kupljeno';

  @override
  String get groupUnplanned => 'Kupljeno bez plana';

  @override
  String get groupQuantityChanged => 'Količina je promijenjena';

  @override
  String get groupUnverified => 'Nepotvrđeno';

  @override
  String get plannedQtyLabel => 'Planirana količina';

  @override
  String get actualQtyLabel => 'Stvarna količina';

  @override
  String get plannedUnitPriceLabel => 'Planirana jedinična cijena';

  @override
  String get actualUnitPriceLabel => 'Stvarna jedinična cijena';

  @override
  String get lineVarianceLabel => 'Razlika po stavci';

  @override
  String get discountEffectLabel => 'Efekat popusta';

  @override
  String get notBoughtMark => 'nije kupljeno';

  @override
  String get noPurchasesNote => 'Nema zabilježenih kupovina.';

  @override
  String get navHome => 'Početna';

  @override
  String get navLists => 'Popisi';

  @override
  String get navHistory => 'Povijest';

  @override
  String get navSettings => 'Postavke';

  @override
  String get homeEmptyTitle => 'Planirajte kupovinu';

  @override
  String get homeEmptyBody =>
      'Kreirajte svoj prvi popis i usporedite planirane i stvarne troškove.';

  @override
  String get homeActiveSection => 'Aktivni popisi';

  @override
  String get homeCompletedSection => 'Nedavno završeno';

  @override
  String get homeMonthlySection => 'Ovaj mjesec';

  @override
  String get monthPlannedLabel => 'Planirano';

  @override
  String get monthActualLabel => 'Stvarno';

  @override
  String get monthVarianceLabel => 'Razlika';

  @override
  String get continueShoppingLabel => 'Nastavi s kupovinom';

  @override
  String get historyEmpty =>
      'Još nema završenih kupovina. Vaša povijest i uvidi pojavit će se ovdje.';

  @override
  String get aboutTabTitle => 'O NShoptoru';

  @override
  String get aboutBody =>
      'NShoptor od Crazy Penguin. Offline-first planer za kupovinu. Licenciran pod GPL-3.0.';

  @override
  String get startShoppingLabel => 'Započni kupovinu';

  @override
  String get finishAndSeeResult => 'Završi i vidi rezultat';

  @override
  String get settingsTitle => 'Postavke';

  @override
  String get languageLabel => 'Jezik';

  @override
  String get languageSystem => 'Sustav';

  @override
  String get languageTr => 'Turski';

  @override
  String get languageEn => 'Engleski';

  @override
  String get themeLabel => 'Tema';

  @override
  String get themeSystem => 'Sustav';

  @override
  String get themeLight => 'Svijetla';

  @override
  String get themeDark => 'Tamna';

  @override
  String get defaultCurrencyLabel => 'Zadana valuta';

  @override
  String get defaultUnitLabel => 'Zadana jedinica';

  @override
  String get keepAwakeLabel => 'Održavaj ekran aktivnim tijekom kupovine';

  @override
  String get backupSection => 'Sigurnosna kopija';

  @override
  String get exportBackupLabel => 'Izvezi sigurnosnu kopiju';

  @override
  String get importBackupLabel => 'Uvezi sigurnosnu kopiju';

  @override
  String get mergeImportLabel => 'Spoji s trenutnim podacima';

  @override
  String get separateImportLabel => 'Uvezi kao zasebnu kopiju';

  @override
  String get importCancelled => 'Uvoz je otkazan.';

  @override
  String get backupExported => 'Sigurnosna kopija uspješno izvezena.';

  @override
  String get backupSizeWarning =>
      'Velika sigurnosna kopija: datoteka može biti velika. Želite li uključiti i fotografije?';

  @override
  String get deleteAllSection => 'Opasna zona';

  @override
  String get deleteAllLabel => 'Obriši sve podatke';

  @override
  String get deleteAllConfirm =>
      'Ovo će ukloniti sve popise, povijest, fotografije računa i cijene. Datoteke koje ste vi izvezle/izvezli ostaju na vašem disku. Nastaviti?';

  @override
  String get deleteAllConfirm2 =>
      'Jeste li potpuno sigurne/sigurni? Ova radnja se ne može poništiti.';

  @override
  String get cancelAction => 'Otkaži';

  @override
  String get confirmDelete => 'Trajno obriši';

  @override
  String get dataDeleted => 'Svi lokalni podaci su obrisani.';

  @override
  String get privacyInfoLabel => 'Privatnost';

  @override
  String get privacyInfoBody =>
      'Vaši popisi, cijene, računi i fotografije ostaju na vašem uređaju. Fotografije i glas nikada ne napuštaju uređaj. Kada je AI pomoć uključena, samo tekst (npr. stavke s računa ili ono što ste dictirali) šalje se na naš poslužitelj radi obrade i ne pohranjuje se.';

  @override
  String get aboutSection => 'O aplikaciji';

  @override
  String get aboutPublisher => 'Objavljuju: Crazy Penguin';

  @override
  String get aboutLicenses => 'Licence (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Glasovni unos';

  @override
  String get voiceStatusUnknown => 'Servis: nije provjereno';

  @override
  String get permissionsLabel => 'Dozvole';

  @override
  String get permissionsBody =>
      'Kamera, mikrofon i obavijesti traže se samo kada stvarno koristite te značajke.';

  @override
  String get unitsSection => 'Zadane vrijednosti';

  @override
  String get roundingNote =>
      'Zaokruživanje novca prati jedno pravilo: polovice se zaokružuju udaljavajući se od nule, primjenjuje se jednom pri pretvorbi novca.';

  @override
  String get voiceInputTitle => 'Glasovni unos';

  @override
  String get voiceStartListening => 'Počni slušati';

  @override
  String get voiceTranscriptLabel => 'Transkript';

  @override
  String get parseAction => 'Analiziraj';

  @override
  String get receiptReviewTitle => 'Pregled računa';

  @override
  String get receiptTotal => 'Ukupno na računu';

  @override
  String get receiptTotalUnknown => 'Ukupno nije detektovano';

  @override
  String get receiptDiff => 'Razlika';

  @override
  String get acceptLine => 'Prihvati stavku';

  @override
  String get ignoreLine => 'Ignoriši stavku';

  @override
  String get receiptLineActions => 'Poveži sa stavkom, podijeli ili ignoriši';

  @override
  String get receiptCommit => 'Prihvati sve';

  @override
  String get receiptCommitted => 'Račun primijenjen.';

  @override
  String get priceHistoryTitle => 'Istorija cijena';

  @override
  String get noObservations => 'Još nema zabilježenih cijena';

  @override
  String get templatesSection => 'Predlošci';

  @override
  String get templateHint => 'Kreiraj novi plan na osnovu prethodne kupovine';

  @override
  String get scanReceiptAction => 'Skeniraj račun';

  @override
  String get shelfLabelAction => 'Cijena s etikete na polici';

  @override
  String get priceCandidatesTitle => 'Kandidati za cijenu';

  @override
  String get noPriceCandidates => 'Cijena nije pronađena; unesite je ručno.';

  @override
  String get voiceUnavailable =>
      'Prepoznavanje govora nije dostupno; unesite ručno.';

  @override
  String get linkToItem => 'Poveži sa stavkom';

  @override
  String get splitLine => 'Podijeli na dva';

  @override
  String get mergeWithNext => 'Spoji sa sljedećom';

  @override
  String get ocrNoText => 'Tekst nije pročitán; pokušajte ponovo.';

  @override
  String get priceHistoryAction => 'Istorija cijena';

  @override
  String get itemsEmptyTitle => 'Još nema stavki';

  @override
  String get itemsEmptyBody =>
      'Dodajte svoju prvu stavku — stvarne cijene ćete unositi ovdje u prodavnici.';

  @override
  String get addItemTooltip => 'Dodaj stavku';

  @override
  String get unitAdet => 'kom';

  @override
  String get unitKilogram => 'kg';

  @override
  String get unitGram => 'g';

  @override
  String get unitLitre => 'L';

  @override
  String get unitMililitre => 'ml';

  @override
  String get unitPaket => 'pak';

  @override
  String get unitKutu => 'kutija';

  @override
  String get unitSise => 'boca';

  @override
  String get unitKavanoz => 'teglja';

  @override
  String get unitDemet => 'snop';

  @override
  String get unitDuzine => 'džina';

  @override
  String get unitMetre => 'm';

  @override
  String get unitCustom => 'Prilagođeno';

  @override
  String get setReminderAction => 'Postavi podsjetnik';

  @override
  String get reminderPermissionDenied =>
      'Za podsjetnike su potrebna ovlaštenja za notifikacije. Možete ih omogućiti u postavkama sistema.';

  @override
  String get reminderScheduled => 'Podsjetnik postavljen.';

  @override
  String get reminderCancelled => 'Podsjetnik uklonjen.';

  @override
  String get reminderTitle => 'Podsjetnik za kupovinu';

  @override
  String reminderBody(Object title) {
    return 'Vrijeme je da provjerite listu: $title';
  }

  @override
  String get reminderPickDate => 'Odaberite datum';

  @override
  String get reminderPickTime => 'Odaberite vrijeme';

  @override
  String get itemDetailsSection => 'Detalji';

  @override
  String get priceOptionalHint =>
      'Opcionalno — stvarnu cijenu ćete unijeti u prodavnici';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Planirano: $total · $count stavki';
  }

  @override
  String get proActiveLabel => 'Pro aktivno — hvala vam!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Bez reklama, više AI, backup · od male mjesečne cijene';

  @override
  String get proBenefitNoAds => 'Iskustvo bez reklama';

  @override
  String get proBenefitBackup => 'Rezervna kopija (izvoz/uvoz)';

  @override
  String aboutVersion(Object version) {
    return 'Verzija $version';
  }

  @override
  String get navDiscover => 'Otkrij';

  @override
  String get shareAction => 'Podijeli aplikaciju';

  @override
  String get rateAction => 'Ocijenite nas';

  @override
  String get aboutOpenRow => 'O aplikaciji i open source';

  @override
  String get voiceAddItemAction => 'Dodaj glasom';

  @override
  String get formatLocaleLabel => 'Format brojeva i valuta';

  @override
  String get formatLocaleSystem =>
      'Format uređaja (Latinke cifre; inače engleski)';

  @override
  String get formatLocaleTr => 'Turski (1.234,56)';

  @override
  String get formatLocaleEn => 'Engleski (1,234.56)';

  @override
  String get aiToggleTitle => 'Pomoć AI';

  @override
  String get aiToggleSubtitle =>
      'Uparuje račune, čita cijene s etiketa i pretvara rečenice u liste. Fotografije i glas ostaju na vašem uređaju; obrađuje se samo tekst.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Iskoristili ste mjesečni limit AI zahtjeva ($used/$limit). Nadogradite za više ili nastavite bez AI.';
  }

  @override
  String get aiOffline => 'Nema veze — radimo bez AI.';

  @override
  String get aiFailed => 'AI trenutno nije dostupan — radimo bez njega.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'Uređaj';

  @override
  String get quickListAction => 'Dodaj iz rečenice';

  @override
  String get quickListTitle => 'Brza lista';

  @override
  String get quickListHint =>
      'npr. 1 kg jabuka 20, 2 kruha, pola kilograma sira';

  @override
  String get quickListConvert => 'Pretvori u listu';

  @override
  String quickListAdd(int count) {
    return 'Dodaj $count stavki';
  }

  @override
  String get quickListEmpty =>
      'Nema pronađenih stavki. Pokušajte navesti ih odvojeno zarezima.';

  @override
  String get receiptAiMatched =>
      'AI je upario račun s vašom listom. Provjerite poveznice i potvrdite.';

  @override
  String get receiptNeedsCheck => 'Provjeri ovaj upar';

  @override
  String get receiptDiscountLine => 'Popust';

  @override
  String get compareItem => 'Stavka';

  @override
  String get compareEstimated => 'Procjena';

  @override
  String get compareActual => 'Stvarno';

  @override
  String get compareDiff => 'Razlika';

  @override
  String get compareTotal => 'Ukupno';

  @override
  String get compareBudget => 'Budžet';

  @override
  String get compareNotBought => 'nije kupljeno';

  @override
  String get compareUnplanned => 'nije planirano';

  @override
  String get pricierItems => 'Skuplje';

  @override
  String get cheaperItems => 'Jeftinije';

  @override
  String get compareAction => 'Usporedi';

  @override
  String get detailsSection => 'Detalji';

  @override
  String get spendingTitle => 'Troškovi';

  @override
  String get spendingAction => 'Troškovi';

  @override
  String get spendingMonthTotal => 'Ovaj mjesec';

  @override
  String get spendingWeekly => 'Tjedni troškovi';

  @override
  String get spendingMonthly => 'Mjesečni troškovi';

  @override
  String get monthlyLimitTitle => 'Mjesečni limit';

  @override
  String get monthlyLimitHelp =>
      'Koliko želite potrošiti na kupovinu mjesečno?';

  @override
  String get monthlyLimitRemove => 'Ukloni';

  @override
  String get monthlyLimitSet => 'Postavi';

  @override
  String get monthlyLimitChange => 'Promijeni';

  @override
  String get monthlyLimitNone =>
      'Postavite mjesečni limit da vidite koliko vam preostaje.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount preko limita';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return '$amount preostalo ovog mjeseca';
  }

  @override
  String get plansTitle => 'Planovi';

  @override
  String get plansHeadline => 'Pametnija kupovina uz AI';

  @override
  String get plansSubhead =>
      'Uparivanje računa, cijene s etiketa i liste iz rečenice. Odjava bilo kada.';

  @override
  String get plansMonthly => 'Mjesečno';

  @override
  String get plansYearly => 'Godišnje';

  @override
  String get planFree => 'Besplatno';

  @override
  String get planFreePrice => 'Zauvijek besplatno';

  @override
  String get planFreeAi => '15 AI zahtjeva mjesečno';

  @override
  String get planFreeAds => 'Male banner reklame (nijedne prvih 7 dana)';

  @override
  String get planCoreFeatures => 'Liste, cijene, računi, grafikoni troškova';

  @override
  String get plansPerYear => '/ godišnje';

  @override
  String get plansPerMonth => '/ mjesečno';

  @override
  String get planTrial => '7 dana besplatno';

  @override
  String get planProAi => '200 AI zahtjeva mjesečno';

  @override
  String get planNoAds => 'Bez reklama';

  @override
  String get planBackup => 'Sigurnosna kopija: izvoz i uvoz';

  @override
  String get planMaxAi => '1000 AI zahtjeva mjesečno';

  @override
  String get planMaxFamily => 'Za kupovinu velike porodice';

  @override
  String get plansStoreUnavailable => 'Trgovina trenutno nije dostupna.';

  @override
  String get retryAction => 'Pokušaj ponovo';

  @override
  String get plansPurchaseFailed =>
      'Kupovina nije uspješna. Molimo pokušajte ponovo.';

  @override
  String get planLifetimeTitle => 'Bez reklama zauvijek';

  @override
  String get planLifetimeSubtitle =>
      'Jednokratna uplata: bez reklama, sigurnosne kopije; AI ostaje na besplatnom ograničenju';

  @override
  String get plansRestore => 'Obnovi kupovine';

  @override
  String get plansLegal =>
      'Pretplate se automatski obnavljaju dok se ne otkažu. Otkažite bilo kada u Google Play › Plaćanje i pretplate. Cijene uključuju poreze prikazane od strane Google Playa.';

  @override
  String get planCurrent => 'Trenutna';

  @override
  String get planStartTrial => 'Započni 7-dnevni besplatni probni period';

  @override
  String get planChoose => 'Odaberi';

  @override
  String get plansAction => 'Planovi: Pro i Max';

  @override
  String get assistantTitle => 'Asistent';

  @override
  String get assistantGreeting => 'Ćao! Šta želiš da uradiš?';

  @override
  String get assistantNewList => 'Nova lista';

  @override
  String get assistantVoiceList => 'Lista glasom';

  @override
  String get assistantTextList => 'Lista iz rečenice';

  @override
  String get assistantScanReceipt => 'Skeniraj račun';

  @override
  String get assistantSpending => 'Moji troškovi';

  @override
  String get assistantReceiptHint =>
      'Otvori svoju listu i dodirni ikonu računa za skeniranje.';

  @override
  String get assistantToggleTitle => 'Prikaži asistenta';

  @override
  String get assistantToggleSubtitle => 'Mali pomoćnik u donjem desnom uglu';

  @override
  String get scanPriceLabel => 'Skeniraj cijenu';

  @override
  String get saveFailed =>
      'Nije moguće spremiti. Vaše promjene su i dalje ovdje. Molimo pokušajte ponovo.';

  @override
  String get deleteItemConfirm =>
      'Izbrisati ovu stavku i njezine zabilježene kupnje?';

  @override
  String get clearPurchaseConfirm =>
      'Poništiti odabir ove stavke i ukloniti njezine zabilježene kupnje?';

  @override
  String get reportPdfAction => 'Spremi PDF izvještaj';

  @override
  String get reportNotInvoice =>
      'Sažetak kupovine, nije porezni račun. Porezne stope su nepoznate.';

  @override
  String get purchaseVisits => 'Posjeti kupovini';

  @override
  String get purchaseInterval => 'Prosječni dani između kupovina';

  @override
  String get purchasedQuantity => 'Količina kupljena';

  @override
  String get purchaseAnalyticsHint =>
      'Kupnje ne mjere potrošnju. Valute i jedinice prikazuju se odvojeno.';

  @override
  String get receiptReplaces =>
      'Povezane linije računa zamjenjuju postojeće kupnje; nepovezane linije se dodaju.';

  @override
  String get voiceUnsupportedLanguage =>
      'Ovaj jezik nije dostupan za glasovni unos na ovom uređaju. Umjesto toga možete tipkati.';
}
