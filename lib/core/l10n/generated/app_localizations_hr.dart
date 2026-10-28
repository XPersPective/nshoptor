// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Croatian (`hr`).
class AppLocalizationsHr extends AppLocalizations {
  AppLocalizationsHr([String locale = 'hr']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Planiraj kod kuće. Kupuj prema planu.';

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
  String get listTitleHint => 'Naslov (opcionalno)';

  @override
  String get saveButton => 'Spremi';

  @override
  String get cancelButton => 'Odustani';

  @override
  String get deleteButton => 'Izbriši';

  @override
  String get editAction => 'Uredi';

  @override
  String get listDeleted => 'Popis izbrisan';

  @override
  String get invalidAmountError => 'Neispravan iznos';

  @override
  String get duplicateAction => 'Dupliciraj';

  @override
  String get archiveAction => 'Arhiviraj';

  @override
  String get unarchiveAction => 'Razarhiviraj';

  @override
  String get deleteListConfirm =>
      'Izbrisati ovaj popis? Planirane stavke također će biti uklonjene.';

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
  String get resetAmountsAction => 'Resetiraj iznose';

  @override
  String get currencyChangeWarning =>
      'Valuta se mijenja. Što učiniti s postojećim iznosima?';

  @override
  String get listsEmpty =>
      'Još nema popisa. Kreirajte svoj prvi shopping plan.';

  @override
  String get statusDraft => 'Skica';

  @override
  String get statusPlanned => 'Planirano';

  @override
  String get statusShopping => 'Kupnja';

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
  String get pricingModeLabel => 'Unos cijene';

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
  String get categoryCleaning => 'Čišćenje';

  @override
  String get categoryPersonalCare => 'Osobna njega';

  @override
  String get categoryHome => 'Dom';

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
  String get shoppingTitle => 'Način kupnje';

  @override
  String get summaryPlannedTotal => 'Planirano';

  @override
  String get summaryInCart => 'U košarici';

  @override
  String get summaryRemainingPlan => 'Preostali plan';

  @override
  String get summaryProjected => 'Procijenjena ukupno';

  @override
  String get summaryBudgetRemaining => 'Preostali budžet';

  @override
  String get summaryBudgetOver => 'Izvan budžeta';

  @override
  String itemsProgress(String done, String total) {
    return '$done od $total stavki';
  }

  @override
  String get filterAll => 'Sve';

  @override
  String get filterToBuy => 'Za kupnju';

  @override
  String get filterInCart => 'U košarici';

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
  String get savePurchaseButton => 'Dodaj u košaricu';

  @override
  String get unplannedAddButton => 'Dodaj neplaniranu stavku';

  @override
  String get statusPending => 'Nije uzeto';

  @override
  String get statusInCart => 'U košarici';

  @override
  String get statusNotFound => 'Nije pronađeno';

  @override
  String get statusGaveUp => 'Odustalo';

  @override
  String get statusAlternative => 'Kupljena alternativa';

  @override
  String get keepScreenAwake => 'Održavaj ekran aktivnim';

  @override
  String get finishShopping => 'Završi kupovinu';

  @override
  String get completionWarning =>
      'Postoje nedostajuće ili neprovjerene zapise. I dalje možete završiti; rezultat će ih navesti.';

  @override
  String get continueShoppingButton => 'Nastavi s kupnjom';

  @override
  String get resultTitle => 'Rezultat';

  @override
  String get summarySection => 'Sažetak';

  @override
  String get plannedTotalLabel => 'Planirana ukupno';

  @override
  String get actualTotalLabel => 'Stvarna ukupno';

  @override
  String get varianceLabel => 'Razlika';

  @override
  String get varianceNotComputable => 'Ne može se izračunati';

  @override
  String get budgetStatusLabel => 'Budžet';

  @override
  String get savingsLabel => 'Ispod plana';

  @override
  String get overspendLabel => 'Iznad plana';

  @override
  String get unplannedTotalLabel => 'Ukupno neplanirano';

  @override
  String get unpurchasedLabel => 'Planirano, ali nije kupljeno';

  @override
  String get totalDiscountLabel => 'Ukupni popusti';

  @override
  String get accuracyLabel => 'Točnost procjene';

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
  String get groupQuantityChanged => 'Količina promijenjena';

  @override
  String get groupUnverified => 'Neprovjereno';

  @override
  String get plannedQtyLabel => 'Planirana količina';

  @override
  String get actualQtyLabel => 'Stvarna količina';

  @override
  String get plannedUnitPriceLabel => 'Planirana jedinična cijena';

  @override
  String get actualUnitPriceLabel => 'Stvarna jedinična cijena';

  @override
  String get lineVarianceLabel => 'Razlika po retku';

  @override
  String get discountEffectLabel => 'Učinak popusta';

  @override
  String get notBoughtMark => 'nije kupljeno';

  @override
  String get noPurchasesNote => 'Nema zabilježenih kupnji.';

  @override
  String get navHome => 'Početna';

  @override
  String get navLists => 'Popisi';

  @override
  String get navHistory => 'Povijest';

  @override
  String get navSettings => 'Postavke';

  @override
  String get homeEmptyTitle => 'Planirajte kupnju';

  @override
  String get homeEmptyBody =>
      'Izradite svoj prvi popis i usporedite planirane i stvarne troškove.';

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
  String get continueShoppingLabel => 'Nastavi s kupnjom';

  @override
  String get historyEmpty =>
      'Još nema završenih kupnji. Vaša povijest i uvidi pojavit će se ovdje.';

  @override
  String get aboutTabTitle => 'O NShoptoru';

  @override
  String get aboutBody =>
      'NShoptor od Crazy Penguin. Planer kupnje koji radi offline. Licenciran pod GPL-3.0.';

  @override
  String get startShoppingLabel => 'Započni kupnju';

  @override
  String get finishAndSeeResult => 'Završi & pogledaj rezultat';

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
  String get themeLight => 'Svjetla';

  @override
  String get themeDark => 'Tamna';

  @override
  String get defaultCurrencyLabel => 'Zadana valuta';

  @override
  String get defaultUnitLabel => 'Zadana jedinica';

  @override
  String get keepAwakeLabel => 'Drži zaslon aktivnim tijekom kupnje';

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
  String get deleteAllSection => 'Opasna zona';

  @override
  String get deleteAllLabel => 'Izbriši sve podatke';

  @override
  String get deleteAllConfirm =>
      'Ovo će ukloniti sve popise, povijest, fotografije računa i cijene. Datoteke koje ste vi izvezle/izvezli ostaju na vašem disku. Nastaviti?';

  @override
  String get deleteAllConfirm2 =>
      'Jeste li potpuno sigurna/siguran? Ovaj se postupak ne može poništiti.';

  @override
  String get cancelAction => 'Odustani';

  @override
  String get confirmDelete => 'Trajno izbriši';

  @override
  String get dataDeleted => 'Svi lokalni podaci su izbrisani.';

  @override
  String get privacyInfoLabel => 'Privatnost';

  @override
  String get privacyInfoBody =>
      'Vaši popisi, cijene, računi i fotografije pohranjeni su na vašem uređaju. Glas ga nikada ne napušta. Kada je pomoć AI-ja uključena, fotografije računa i cjenovnih oznaka (smanjene veličine) te tekst, poput diktiranih stavki, šalju se na naš poslužitelj samo radi čitanja; obrađuju se odmah i nikada se ne pohranjuju.';

  @override
  String get aboutSection => 'O aplikaciji';

  @override
  String get aboutPublisher => 'Objavitelj: Crazy Penguin';

  @override
  String get aboutLicenses => 'Licence (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Unos glasom';

  @override
  String get voiceStatusUnknown => 'Usluga: nije provjereno';

  @override
  String get permissionsLabel => 'Dozvole';

  @override
  String get permissionsBody =>
      'Kamera, mikrofon i obavijesti traže se samo kada stvarno koristite te značajke.';

  @override
  String get unitsSection => 'Zadane vrijednosti';

  @override
  String get roundingNote =>
      'Zaokruživanje novca prati jedno pravilo: polovice se zaokružuju dalje od nule, primjenjuje se jednom pri pretvorbi u novac.';

  @override
  String get voiceInputTitle => 'Unos glasom';

  @override
  String get voiceStartListening => 'Započni slušanje';

  @override
  String get voiceTranscriptLabel => 'Prijevod';

  @override
  String get parseAction => 'Analiziraj';

  @override
  String get receiptReviewTitle => 'Pregled računa';

  @override
  String get receiptTotal => 'Ukupno na računu';

  @override
  String get receiptTotalUnknown => 'Ukupno nije detektirano';

  @override
  String get receiptDiff => 'Razlika';

  @override
  String get acceptLine => 'Prihvati stavku';

  @override
  String get ignoreLine => 'Zanemari stavku';

  @override
  String get receiptLineActions => 'Poveži s artiklom, podijeli ili zanemari';

  @override
  String get receiptCommit => 'Prihvati sve';

  @override
  String get receiptCommitted => 'Račun je primijenjen.';

  @override
  String get priceHistoryTitle => 'Povijest cijena';

  @override
  String get noObservations => 'Još nema zabilježenih cijena';

  @override
  String get templatesSection => 'Predlošci';

  @override
  String get templateHint => 'Kreiraj novi popis iz prethodne kupovine';

  @override
  String get scanReceiptAction => 'Skeniraj račun';

  @override
  String get fromReceiptListButton => 'Iz računa';

  @override
  String get shelfLabelAction => 'Cijena s naljepnice na polici';

  @override
  String get priceCandidatesTitle => 'Kandidati za cijenu';

  @override
  String get noPriceCandidates => 'Nema pronađenih cijena; unesite ih ručno.';

  @override
  String get voiceUnavailable =>
      'Prepoznavanje govca nije dostupno; unesite ručno.';

  @override
  String get linkToItem => 'Poveži s artiklom';

  @override
  String get splitLine => 'Podijeli na dva';

  @override
  String get mergeWithNext => 'Spoji sa sljedećom';

  @override
  String get ocrNoText => 'Tekst nije prepoznat; pokušajte ponovo.';

  @override
  String get priceHistoryAction => 'Povijest cijena';

  @override
  String get itemsEmptyTitle => 'Još nema artikala';

  @override
  String get itemsEmptyBody =>
      'Dodajte prvi artikal — stvarne cijene unosite ovdje u trgovini.';

  @override
  String get addItemTooltip => 'Dodaj artikal';

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
  String get unitPaket => 'pakiranje';

  @override
  String get unitKutu => 'kutija';

  @override
  String get unitSise => 'boca';

  @override
  String get unitKavanoz => 'tegla';

  @override
  String get unitDemet => 'snop';

  @override
  String get unitDuzine => 'džina';

  @override
  String get unitMetre => 'm';

  @override
  String get unitCustom => 'Prilagođeno';

  @override
  String get setReminderAction => 'Postavi upozorenje';

  @override
  String get reminderPermissionDenied =>
      'Za upozorenja su potrebna dopuštenja za obavijesti. Možete ih omogućiti u postavkama sustava.';

  @override
  String get reminderScheduled => 'Upozorenje je postavljeno.';

  @override
  String get reminderCancelled => 'Upozorenje je uklonjeno.';

  @override
  String get reminderTitle => 'Upozorenje za kupovinu';

  @override
  String reminderBody(Object title) {
    return 'Vrijeme je da pregledate svoj popis: $title';
  }

  @override
  String get reminderPickDate => 'Odaberite datum';

  @override
  String get reminderPickTime => 'Odaberite vrijeme';

  @override
  String get itemDetailsSection => 'Detalji';

  @override
  String get priceOptionalHint =>
      'Opcionalno — stvarnu cijenu unosite u trgovini';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Planirano: $total · $count artikala';
  }

  @override
  String get proActiveLabel => 'Pro aktivna hvala!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Bez reklama · Izvoz i uvoz sigurnosne kopije · Godišnje';

  @override
  String get proBenefitNoAds => 'Iskustvo bez reklama';

  @override
  String get proBenefitBackup => 'Sigurnosna kopija (izvoz/uvoz)';

  @override
  String aboutVersion(Object version) {
    return 'Verzija $version';
  }

  @override
  String get navDiscover => 'Istraži';

  @override
  String get shareAction => 'Podijeli aplikaciju';

  @override
  String get rateAction => 'Ocijenite nas';

  @override
  String get aboutOpenRow => 'O aplikaciji & otvoreni kod';

  @override
  String get voiceAddItemAction => 'Dodaj glasom';

  @override
  String get formatLocaleLabel => 'Format brojeva i valuta';

  @override
  String get formatLocaleSystem =>
      'Format uređaja (latinične znamenke; inače engleski)';

  @override
  String get formatLocaleTr => 'Turski (1.234,56)';

  @override
  String get formatLocaleEn => 'Engleski (1,234.56)';

  @override
  String get aiToggleTitle => 'Pomoć AI-ja';

  @override
  String get aiToggleSubtitle =>
      'Čita račune i cjenovne oznake s fotografija, povezuje račune i pretvara rečenice u popise. Fotografije se šalju samo radi čitanja i nikada se ne pohranjuju.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Iskoristili ste mjesečni limit AI zahtjeva ($used/$limit). Nadogradite za više ili nastavite bez AI-ja.';
  }

  @override
  String get aiOffline => 'Nema veze — nastavljam bez AI-ja.';

  @override
  String get aiFailed => 'AI trenutno nije dostupan — nastavljam bez njega.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'Uređaj';

  @override
  String get quickListAction => 'Dodaj iz rečenice';

  @override
  String get quickListTitle => 'Brzi popis';

  @override
  String get quickListHint =>
      'npr. 1 kg jabuka 20, 2 kruha, pola kilograma sira';

  @override
  String get quickListConvert => 'Pretvori u popis';

  @override
  String quickListAdd(int count) {
    return 'Dodaj $count stavki';
  }

  @override
  String get quickListEmpty =>
      'Nema pronađenih stavki. Pokušajte navesti ih odvojeno zarezima.';

  @override
  String get receiptAiMatched =>
      'AI je upario račun s vašim popisom. Provjerite poveznice i potvrdite.';

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
  String get monthlyLimitHelp => 'Koliko želite trošiti na kupovinu mjesečno?';

  @override
  String get monthlyLimitRemove => 'Ukloni';

  @override
  String get monthlyLimitSet => 'Postavi';

  @override
  String get monthlyLimitChange => 'Promijeni';

  @override
  String get monthlyLimitNone =>
      'Postavite mjesečni limit da biste vidjeli koliko vam preostaje.';

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
  String get plansHeadline => 'Kupujte pametnije uz AI';

  @override
  String get plansSubhead =>
      'Uparivanje računa, cijene s etiketa i popisi iz rečenice. Otkazivanje bilo kada.';

  @override
  String get plansMonthly => 'Mjesečno';

  @override
  String get plansYearly => 'Godišnje';

  @override
  String get planFree => 'Besplatno';

  @override
  String get planFreePrice => 'Besplatno zauvijek';

  @override
  String get planFreeAi => '10 AI zahtjeva mjesečno';

  @override
  String get planFreeAds => 'Male banner reklame (bez njih prvih 7 dana)';

  @override
  String get planCoreFeatures => 'Popisi, cijene, računi, grafikoni troškova';

  @override
  String get plansPerYear => '/ godišnje';

  @override
  String get plansPerMonth => '/ mjesečno';

  @override
  String get planTrial => 'Besplatno probno razdoblje';

  @override
  String get planProAi => '100 AI zahtjeva mjesečno';

  @override
  String get planNoAds => 'Bez reklama';

  @override
  String get planBackup => 'Izvoz i uvoz sigurnosne kopije';

  @override
  String get planMaxAi => '300 AI zahtjeva mjesečno';

  @override
  String get planMaxFamily => 'Za kupovinu velike obitelji';

  @override
  String get plansStoreUnavailable => 'Trgovina trenutno nije dostupna.';

  @override
  String get retryAction => 'Pokušaj ponovo';

  @override
  String get plansPurchaseFailed =>
      'Kupnja nije uspjela. Molimo pokušajte ponovo.';

  @override
  String get plansRestore => 'Obnovi kupnje';

  @override
  String get plansLegal =>
      'Pro se automatski obnavlja svake godine do otkazivanja i uključuje 100 AI zahtjeva mjesečno. Osnovna cijena iznosi 1 američki dolar godišnje prije primjenjivih poreza; prije potvrde kupnje provjerite konačnu lokalnu cijenu i poreze u trgovini. Upravljajte pretplatom ili je otkažite u Google Playu.';

  @override
  String get planCurrent => 'Trenutna';

  @override
  String get planStartTrial => 'Započni besplatno probno razdoblje';

  @override
  String get planChoose => 'Odaberi';

  @override
  String get plansAction => 'Planovi: Pro';

  @override
  String get assistantTitle => 'Asistent';

  @override
  String get assistantGreeting => 'Bok! Što želiš učiniti?';

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
  String get assistantToggleSubtitle => 'Mali pomoćnik u donjem desnom kutu';

  @override
  String get scanPriceLabel => 'Skeniraj cijenu';

  @override
  String get saveFailed =>
      'Spremanje nije uspjelo. Vaše izmjene su i dalje ovdje. Pokušajte ponovo.';

  @override
  String get deleteItemConfirm =>
      'Želite li izbrisati ovu stavku i njezine zabilježene kupnje?';

  @override
  String get clearPurchaseConfirm =>
      'Želite li poništiti odabir ove stavke i ukloniti njezine zabilježene kupnje?';

  @override
  String get reportPdfAction => 'Spremi PDF izvješće';

  @override
  String get reportNotInvoice =>
      'Sažetak kupovine, ne porezni račun. Stope poreza nisu poznate.';

  @override
  String get purchaseVisits => 'Posjeti kupovini';

  @override
  String get purchaseInterval => 'Prosječni broj dana između kupnji';

  @override
  String get purchasedQuantity => 'Količina kupljena';

  @override
  String get purchaseAnalyticsHint =>
      'Kupnje ne mjere potrošnju. Valute i jedinice prikazuju se odvojeno.';

  @override
  String get receiptReplaces =>
      'Artikli bez cijene popunjavaju se. Artikli koji već imaju tržišnu cijenu dodaju se kao zasebne kupnje.';

  @override
  String get receiptIncompleteHeader =>
      'U sljedeću fotografiju uključite trgovinu, datum, vrijeme i broj računa.';

  @override
  String get receiptIncompleteTail =>
      'Snimite sljedeći dio s nekoliko preklopljenih artikala i konačnim iznosom.';

  @override
  String get receiptContinuationRejected =>
      'Ovu fotografiju nije moguće spojiti s računom. Ponovno je snimite s preklopljenim artiklima s istog računa.';

  @override
  String get receiptDraftSaved =>
      'Račun je spremljen kao skica. Možete nastaviti kasnije.';

  @override
  String get receiptContinueAction => 'Nastavi račun';

  @override
  String get receiptDraftsTitle => 'Nedovršeni računi';

  @override
  String get receiptDuplicate => 'Ovaj je račun već dodan.';

  @override
  String get receiptTotalMismatch =>
      'Artikli se ne podudaraju s ukupnim iznosom računa. Provjerite je li cijeli račun vidljiv.';

  @override
  String get receiptSaveDraftAction => 'Spremi za kasnije';

  @override
  String get receiptResolveLines =>
      'Prihvatite ili zanemarite svaku stavku prije spremanja.';

  @override
  String get receiptPartialConfirm =>
      'Dodat će se samo odabrane stavke. Ovaj račun bit će označen kao uvezen. Nastaviti?';

  @override
  String get voiceUnsupportedLanguage =>
      'Ovaj jezik nije dostupan za glasovni unos na ovom uređaju. Umjesto toga možete tipkati.';

  @override
  String get voiceStopListening => 'Zaustavi slušanje';

  @override
  String get keepAwakeFailed =>
      'Nije moguće zadržati ekran aktivnim. Pokušajte ponovno.';

  @override
  String get purchaseHistoryHint =>
      'Sva završena kupovna. Povratci smanjuju ukupne iznose. Datumi se odnose na završetak kupovine. Jedan odlazak nije dovoljan za izračun prosječnog intervala.';

  @override
  String get planLegacyRights =>
      'Postojeće Pro i Max pretplate zadržavaju izvorni mjesečni AI limit.';

  @override
  String get csvExportAction => 'Izvoz CSV';

  @override
  String get reportSharePdf => 'Podijeli kao PDF';

  @override
  String get reportShareCsv => 'Podijeli kao CSV';

  @override
  String get reportPrintAction => 'Ispiši';

  @override
  String get backupSizeWarning =>
      'JSON sadrži zapise, a ne datoteke fotografija. Ograničenje uvoza: 16 MB.';

  @override
  String get backupImportFailed =>
      'Nije moguće uvesti ovu sigurnosnu kopiju. Vaši podaci nisu promijenjeni.';

  @override
  String get backupImported => 'Sigurnosna kopija uspješno uvezena.';

  @override
  String backupPreviewCounts(Object entries, Object items, Object lists) {
    return '$lists popisa · $items stavki · $entries kupnji';
  }

  @override
  String get voiceModelDownloading =>
      'Glasovni model za ovaj jezik se preuzima. Pokušajte ponovno za minutu.';

  @override
  String get historyThisWeek => 'Ovaj tjedan';

  @override
  String get historyProductsSection => 'Kupljeni proizvodi';

  @override
  String get tipReceiptScan => 'Skenirajte račun da uskladite cijene s popisom';

  @override
  String get tipVoiceAdd =>
      'Izgovorite jednu ili više stavki i provjerite ih prije dodavanja';

  @override
  String get tipShelfCamera => 'Pročitajte cijenu s oznake na polici kamerom';

  @override
  String get tipPlan =>
      'Vaš plan: pogledajte pojedinosti, pretplatite se ili nadogradite';

  @override
  String get guideAddBody =>
      'Dodirnite + za dodavanje stavke. Unesite planiranu cijenu sada, a tržišnu na blagajni.';

  @override
  String get guideVoiceBody =>
      'Dodirnite mikrofon i izgovorite stavke, na primjer: \'1 kg jabuka, 1 kruh\'.';

  @override
  String get guideReceiptBody =>
      'Skenirajte račun da uskladite njegove cijene sa stavkama na popisu.';

  @override
  String get guidePlanBody =>
      'Dodirnite ikonu plana da vidite plan, pretplatite se ili nadogradite.';

  @override
  String get guideNext => 'U redu';

  @override
  String get guideDone => 'Započni';

  @override
  String get paletteLabel => 'Tema boja';

  @override
  String get paletteForest => 'Šuma';

  @override
  String get paletteOcean => 'Ocean';

  @override
  String get paletteSunset => 'Zalazak sunca';

  @override
  String get paletteLavender => 'Lavanda';

  @override
  String get darkBlackLabel => 'Potpuno crna u tamnoj temi';

  @override
  String get spendingOverview => 'Pregled';

  @override
  String get spendingThisYear => 'Ova godina';

  @override
  String get spendingYearly => 'Godišnja potrošnja';

  @override
  String get productSpending => 'Potrošnja po proizvodu';

  @override
  String get spanWeek => 'Tjedan';

  @override
  String get spanMonth => 'Mjesec';

  @override
  String get spanYear => 'Godina';

  @override
  String get weeklyLimitTitle => 'Tjedni limit';

  @override
  String get weeklyLimitHelp => 'Koliko želite trošiti na kupnju tjedno?';

  @override
  String get weeklyLimitNone =>
      'Postavite tjedni limit da vidite koliko je ostalo.';

  @override
  String weeklyLimitLeft(String amount) {
    return 'Ovaj tjedan ostalo je $amount';
  }

  @override
  String get shoppingLimitTitle => 'Limit po kupnji';

  @override
  String get shoppingLimitHelp => 'Novi popisi počinju s ovim proračunom.';

  @override
  String get shoppingLimitNone =>
      'Postavite zadani proračun za svaku novu kupnju.';

  @override
  String get monthlyReportAction => 'Mjesečno izvješće';

  @override
  String get reportShoppingColumn => 'Kupnja';

  @override
  String get reportDateColumn => 'Datum';

  @override
  String get planUnavailable => 'Trenutačno nije dostupno u trgovini';

  @override
  String get demoDataTitle => 'Primjer podataka';

  @override
  String get demoDataLoad => 'Isprobajte s primjerom podataka';

  @override
  String get demoDataLoadHelp =>
      'Dodaje 12 mjeseci primjera kupnji da vidite povijest, grafikone i povijest cijena.';

  @override
  String get demoDataRemove => 'Ukloni primjer podataka';

  @override
  String get demoDataAdded => 'Primjer podataka dodan';

  @override
  String get demoDataRemoved => 'Primjer podataka uklonjen';

  @override
  String get demoProductApple => 'Jabuke';

  @override
  String get demoProductBread => 'Kruh';

  @override
  String get demoProductMilk => 'Mlijeko';

  @override
  String get demoProductCheese => 'Sir';

  @override
  String get demoProductTomato => 'Rajčice';

  @override
  String get demoProductEggs => 'Jaja';

  @override
  String get demoProductCoffee => 'Kava';

  @override
  String get demoProductDetergent => 'Deterdžent';

  @override
  String get sendAction => 'Send';

  @override
  String get previousMonthAction => 'Previous month';

  @override
  String get nextMonthAction => 'Next month';

  @override
  String get helpSection => 'Pomoć i podrška';

  @override
  String get howToUseLabel => 'Kako koristiti';

  @override
  String get guidePricesBody =>
      'Cijena u trgovini označava proizvod kao kupljen; računa se i 0. Kućna cijena nije obvezna. Izbrišite cijenu u trgovini da uklonite kvačicu.';

  @override
  String get shoppingDateLabel => 'Datum kupnje';

  @override
  String get shoppingDateNone => 'Datum nije odabran';

  @override
  String get clearShoppingDateAction => 'Ukloni datum';

  @override
  String get listSortLabel => 'Redoslijed popisa';

  @override
  String get listSortDate => 'Datum kupnje';

  @override
  String get listSortAz => 'Naziv (A–Z)';

  @override
  String get listSortManual => 'Ručni redoslijed';

  @override
  String get imageCameraAction => 'Fotografiraj';

  @override
  String get imageGalleryAction => 'Odaberi iz fotografija';

  @override
  String get imageCaptureFailed =>
      'Nije moguće otvoriti kameru ili fotografije. Provjerite dopuštenje za pristup i pokušajte ponovno.';

  @override
  String get imageRecognitionFailed =>
      'Fotografiju nije moguće obraditi. Pokušajte s drugom fotografijom.';

  @override
  String get receiptNoProducts =>
      'Tekst je pročitan, ali stavke računa nisu pronađene. Fotografijom obuhvatite stavke i ukupan iznos.';

  @override
  String get keepAwakeOn => 'Zaslon ostaje uključen';

  @override
  String get keepAwakeOff => 'Zaslon se može isključiti';

  @override
  String get spanDay => 'Dan';

  @override
  String get spanCustom => 'Raspon datuma';

  @override
  String get reportTotalSpent => 'Ukupno potrošeno';

  @override
  String get reportAddedAt => 'Dodano';

  @override
  String get reportReceiptNumber => 'Broj računa';

  @override
  String get reportPreview => 'Pregled';

  @override
  String get reportShareAction => 'Podijeli';

  @override
  String get previousPeriodAction => 'Prethodno razdoblje';

  @override
  String get nextPeriodAction => 'Sljedeće razdoblje';

  @override
  String get reportSaved => 'Izvješće je spremljeno.';

  @override
  String get reportZoom => 'Povećaj';

  @override
  String planTrialDaysLeft(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dana preostalo',
      few: '$days dana preostala',
      one: '$days dan preostao',
    );
    return '$_temp0';
  }

  @override
  String planTrialHoursLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours sati preostalo',
      few: '$hours sata preostala',
      one: '$hours sat preostao',
    );
    return '$_temp0';
  }

  @override
  String get planTrialEndedTitle => 'Probno razdoblje Proa je završilo';

  @override
  String get planTrialEndedBody =>
      'I dalje možete besplatno koristiti popise, ručni unos i glas na uređaju. Besplatni plan uključuje 10 AI zahtjeva po kalendarskom mjesecu. Odaberite godišnji Pro za 100 AI zahtjeva mjesečno, bez oglasa i uz sigurnosne kopije. Vaši postojeći podaci ostaju vaši.';

  @override
  String get planContinueFree => 'Nastavi besplatno';

  @override
  String get supportIdLabel => 'ID podrške';

  @override
  String get supportEmailLabel => 'Podrška e-poštom';

  @override
  String get captureTipFirst =>
      'Počnite sasvim od vrha: naziv trgovine i datum moraju biti vidljivi. Obuhvatite što više artikala, ostatak ide u sljedeću fotografiju.';

  @override
  String get captureTipContinue =>
      'Isti račun: uključite zadnji artikl s prethodne fotografije.';

  @override
  String get captureTipNeverShow => 'Ne prikazuj ponovno';

  @override
  String get captureTipOk => 'Razumijem';

  @override
  String get captureTipsSetting => 'Prikaži savjete za snimanje računa';

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
  String get listReceiptsSection => 'Računi';

  @override
  String get receiptStateComplete => 'Dovršen';

  @override
  String get receiptStateIncomplete => 'Nepotpun';

  @override
  String get receiptStateFailed => 'Neuspjelo';

  @override
  String get receiptStoreUnknown => 'Trgovina nije pročitana';

  @override
  String get receiptDeleteAction => 'Izbriši račun';

  @override
  String get receiptDeleteConfirm =>
      'Izbrisati ovaj račun i stavke koje je dodao? Kasnije ga možete ponovno uvesti.';

  @override
  String get receiptDeleted => 'Račun je izbrisan.';

  @override
  String listReceiptsShowAll(int count) {
    return 'Prikaži sve ($count)';
  }

  @override
  String get listReceiptsShowLess => 'Prikaži manje';

  @override
  String receiptDateLabel(String date) {
    return 'Datum računa: $date';
  }
}
