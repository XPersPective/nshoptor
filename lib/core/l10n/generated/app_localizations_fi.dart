// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Suunnittele kotona. Osta suunnitelmien mukaan.';

  @override
  String get listsTitle => 'Listat';

  @override
  String get listsTabActive => 'Aktiiviset';

  @override
  String get listsTabCompleted => 'Valmiit';

  @override
  String get listsTabArchived => 'Arkistoidut';

  @override
  String get newListButton => 'Uusi lista';

  @override
  String get listTitleHint => 'Otsikko (valinnainen)';

  @override
  String get saveButton => 'Tallenna';

  @override
  String get cancelButton => 'Peruuta';

  @override
  String get deleteButton => 'Poista';

  @override
  String get editAction => 'Muokkaa';

  @override
  String get listDeleted => 'Lista poistettu';

  @override
  String get invalidAmountError => 'Virheellinen määrä';

  @override
  String get duplicateAction => 'Kopioi';

  @override
  String get archiveAction => 'Arkistoi';

  @override
  String get unarchiveAction => 'Palauta arkistosta';

  @override
  String get deleteListConfirm =>
      'Poistetaanko tämä lista? Myös sen suunnitellut tuotteet poistetaan.';

  @override
  String get undoButton => 'Kumoa';

  @override
  String get searchListHint => 'Hae listoja';

  @override
  String get currencyLabel => 'Valuutta';

  @override
  String get budgetLabel => 'Budjetti (valinnainen)';

  @override
  String get noteLabel => 'Huomautus (valinnainen)';

  @override
  String get storeLabel => 'Kauppa';

  @override
  String get keepAmountsAction => 'Säilytä määrät';

  @override
  String get resetAmountsAction => 'Tyhjennä määrät';

  @override
  String get currencyChangeWarning =>
      'Valuuttaa muutetaan. Mitä tapahtuu olemassa oleville määriin?';

  @override
  String get listsEmpty =>
      'Ei vielä listoja. Luo ensimmäinen ostossuunnitelmasi.';

  @override
  String get statusDraft => 'Luonnos';

  @override
  String get statusPlanned => 'Suunniteltu';

  @override
  String get statusShopping => 'Ostoksilla';

  @override
  String get statusCompleted => 'Valmis';

  @override
  String get statusArchived => 'Arkistoitu';

  @override
  String autoListTitle(String date) {
    return '$date ostokset';
  }

  @override
  String get itemFormTitle => 'Lisää tuote';

  @override
  String get itemNameLabel => 'Tuotteen nimi';

  @override
  String get brandLabel => 'Brändi / vaihtoehto (valinnainen)';

  @override
  String get categoryLabel => 'Kategoria';

  @override
  String get quantityLabel => 'Määrä';

  @override
  String get unitLabel => 'Yksikkö';

  @override
  String get pricingModeLabel => 'Hinta-asetus';

  @override
  String get pricingModeUnitPrice => 'Yksikköhinta';

  @override
  String get pricingModeLineTotal => 'Rivisumma';

  @override
  String get plannedPriceLabel => 'Suunniteltu hinta';

  @override
  String lineTotalCalculated(String value) {
    return 'Rivisumma: $value';
  }

  @override
  String get requiredItemToggle => 'Pakollinen tuote';

  @override
  String get maxPriceLabel => 'Hyväksyttävä enimmäishinta (valinnainen)';

  @override
  String get itemNoteLabel => 'Huomautus (valinnainen)';

  @override
  String get categoryProduce => 'Vihannekset ja hedelmät';

  @override
  String get categoryDairy => 'Maitotuotteet';

  @override
  String get categoryMeat => 'Liha';

  @override
  String get categoryBakery => 'Leivonnaiset';

  @override
  String get categoryDrinks => 'Juomat';

  @override
  String get categoryCleaning => 'Siivous';

  @override
  String get categoryPersonalCare => 'Henkilökohtainen hygienia';

  @override
  String get categoryHome => 'Koti';

  @override
  String get categoryOther => 'Muu';

  @override
  String get invalidQuantityError => 'Virheellinen määrä';

  @override
  String get invalidPriceError => 'Virheellinen hinta';

  @override
  String get invalidNameError => 'Syötä nimi';

  @override
  String unitPriceCalculated(String value) {
    return 'Yksikköhinta: $value';
  }

  @override
  String get shoppingTitle => 'Ostostila';

  @override
  String get summaryPlannedTotal => 'Suunniteltu';

  @override
  String get summaryInCart => 'Korissa';

  @override
  String get summaryRemainingPlan => 'Jäljellä oleva lista';

  @override
  String get summaryProjected => 'Arvioitu kassa';

  @override
  String get summaryBudgetRemaining => 'Budjettia jäljellä';

  @override
  String get summaryBudgetOver => 'Budjetti ylittynyt';

  @override
  String itemsProgress(String done, String total) {
    return '$done / $total tuotetta';
  }

  @override
  String get filterAll => 'Kaikki';

  @override
  String get filterToBuy => 'Ostettava';

  @override
  String get filterInCart => 'Korissa';

  @override
  String get filterNotFound => 'Ei löytynyt';

  @override
  String get filterRequired => 'Välttämätön';

  @override
  String get quickEntryTitle => 'Todellinen hinta';

  @override
  String get actualQuantityLabel => 'Todellinen määrä';

  @override
  String get actualPriceLabel => 'Todellinen hinta';

  @override
  String get discountLabel => 'Alennus (valinnainen)';

  @override
  String get alternativeNameLabel => 'Vaihtoehtoinen tuotenimi (valinnainen)';

  @override
  String get savePurchaseButton => 'Lisää koriin';

  @override
  String get unplannedAddButton => 'Lisää suunnittelematon tuote';

  @override
  String get statusPending => 'Ei otettu';

  @override
  String get statusInCart => 'Korissa';

  @override
  String get statusNotFound => 'Ei löytynyt';

  @override
  String get statusGaveUp => 'Hylätty';

  @override
  String get statusAlternative => 'Vaihtoehto ostettu';

  @override
  String get keepScreenAwake => 'Pidä näyttö päällä';

  @override
  String get finishShopping => 'Valmistele ostokset';

  @override
  String get completionWarning =>
      'Puuttuvia tai vahvistamattomia tietoja. Voit silti lopettaa; tulos merkitsee ne.';

  @override
  String get continueShoppingButton => 'Jatka ostoksia';

  @override
  String get resultTitle => 'Tulos';

  @override
  String get summarySection => 'Yhteenveto';

  @override
  String get plannedTotalLabel => 'Suunniteltu yhteensä';

  @override
  String get actualTotalLabel => 'Todellinen yhteensä';

  @override
  String get varianceLabel => 'Erotus';

  @override
  String get varianceNotComputable => 'Ei laskettavissa';

  @override
  String get budgetStatusLabel => 'Budjetti';

  @override
  String get savingsLabel => 'Säästöä suunnitelmaan nähden';

  @override
  String get overspendLabel => 'Ylitystä suunnitelmaan nähden';

  @override
  String get unplannedTotalLabel => 'Suunnittelemattomat yhteensä';

  @override
  String get unpurchasedLabel => 'Suunniteltu, mutta ei ostettu';

  @override
  String get totalDiscountLabel => 'Alennukset yhteensä';

  @override
  String get accuracyLabel => 'Arvion tarkkuus';

  @override
  String get groupsSection => 'Tuotteet';

  @override
  String get groupPricier => 'Kalliimpi kuin suunniteltu';

  @override
  String get groupCheaper => 'Edullisempi kuin suunniteltu';

  @override
  String get groupClose => 'Arvion lähellä';

  @override
  String get groupNotTaken => 'Suunniteltu, ei ostettu';

  @override
  String get groupUnplanned => 'Ostettu ilman suunnitelmaa';

  @override
  String get groupQuantityChanged => 'Määrä muuttunut';

  @override
  String get groupUnverified => 'Ei vahvistettu';

  @override
  String get plannedQtyLabel => 'Suunniteltu määrä';

  @override
  String get actualQtyLabel => 'Todellinen määrä';

  @override
  String get plannedUnitPriceLabel => 'Suunniteltu yksikköhinta';

  @override
  String get actualUnitPriceLabel => 'Todellinen yksikköhinta';

  @override
  String get lineVarianceLabel => 'Rivin erotus';

  @override
  String get discountEffectLabel => 'Alennuksen vaikutus';

  @override
  String get notBoughtMark => 'ei ostettu';

  @override
  String get noPurchasesNote => 'Ostoksia ei kirjattu.';

  @override
  String get navHome => 'Koti';

  @override
  String get navLists => 'Listat';

  @override
  String get navHistory => 'Historia';

  @override
  String get navSettings => 'Asetukset';

  @override
  String get homeEmptyTitle => 'Suunnittele ostokset';

  @override
  String get homeEmptyBody =>
      'Luo ensimmäinen listasi ja vertaa suunniteltuja ja todellisia kustannuksia.';

  @override
  String get homeActiveSection => 'Aktiiviset listat';

  @override
  String get homeCompletedSection => 'Viimeksi suoritettu';

  @override
  String get homeMonthlySection => 'Tässä kuussa';

  @override
  String get monthPlannedLabel => 'Suunniteltu';

  @override
  String get monthActualLabel => 'Todellinen';

  @override
  String get monthVarianceLabel => 'Ero';

  @override
  String get continueShoppingLabel => 'Jatka ostoksia';

  @override
  String get historyEmpty =>
      'Ei vielä suoritettuja ostoksia. Historia ja oivallukset näkyvät täällä.';

  @override
  String get aboutTabTitle => 'Tietoja NShoptorista';

  @override
  String get aboutBody =>
      'NShoptor by Crazy Penguin. Offline-ensin ostossuunnittelija. Lisenssi GPL-3.0.';

  @override
  String get startShoppingLabel => 'Aloita ostokset';

  @override
  String get finishAndSeeResult => 'Valmis & katso tulos';

  @override
  String get settingsTitle => 'Asetukset';

  @override
  String get languageLabel => 'Kieli';

  @override
  String get languageSystem => 'Järjestelmä';

  @override
  String get languageTr => 'Turkki';

  @override
  String get languageEn => 'Englanti';

  @override
  String get themeLabel => 'Teema';

  @override
  String get themeSystem => 'Järjestelmä';

  @override
  String get themeLight => 'Vaalea';

  @override
  String get themeDark => 'Tumma';

  @override
  String get defaultCurrencyLabel => 'Oletusvaluutta';

  @override
  String get defaultUnitLabel => 'Oletusyksikkö';

  @override
  String get keepAwakeLabel => 'Pidä näyttö päällä ostosten aikana';

  @override
  String get backupSection => 'Varmuuskopiointi';

  @override
  String get exportBackupLabel => 'Vie varmuuskopio';

  @override
  String get importBackupLabel => 'Tuo varmuuskopio';

  @override
  String get mergeImportLabel => 'Yhdistä nykyisiin tietoihin';

  @override
  String get separateImportLabel => 'Tuo erillisenä kopiona';

  @override
  String get importCancelled => 'Tuonti peruutettu.';

  @override
  String get backupExported => 'Varmuuskopio viety onnistuneesti.';

  @override
  String get backupSizeWarning =>
      'Suuri varmuuskopio: tiedosto voi olla iso. Haluatko sisällyttää myös valokuvat?';

  @override
  String get deleteAllSection => 'Vaarallinen alue';

  @override
  String get deleteAllLabel => 'Poista kaikki tiedot';

  @override
  String get deleteAllConfirm =>
      'Tämä poistaa kaikki listat, historian, kuitin valokuvat ja hinnat. Sinun vientisi pysyvät levylläsi. Jatketaanko?';

  @override
  String get deleteAllConfirm2 =>
      'Oletko aivan varma? Tätä toimintoa ei voi perua.';

  @override
  String get cancelAction => 'Peruuta';

  @override
  String get confirmDelete => 'Poista pysyvästi';

  @override
  String get dataDeleted => 'Kaikki paikalliset tiedot poistettiin.';

  @override
  String get privacyInfoLabel => 'Tietosuoja';

  @override
  String get privacyInfoBody =>
      'Listasi, hinnat, kuitit ja valokuvat säilyvät laitteellasi. Valokuvat ja ääni eivät koskaan poistu laitteestasi. Kun tekoälyavustin on käytössä, vain teksti (esim. kuitirivit tai diktoimaasi) lähetetään palvelimellemme prosessoitavaaksi eikä sitä säilytetä.';

  @override
  String get aboutSection => 'Tietoja';

  @override
  String get aboutPublisher => 'Julkaisija: Crazy Penguin';

  @override
  String get aboutLicenses => 'Lisenssit (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Puheentulo';

  @override
  String get voiceStatusUnknown => 'Palvelu: ei tarkistettu';

  @override
  String get permissionsLabel => 'Oikeudet';

  @override
  String get permissionsBody =>
      'Kameraa, mikrofonia ja ilmoituksia pyydetään vain, kun käytät näitä ominaisuuksia.';

  @override
  String get unitsSection => 'Oletukset';

  @override
  String get roundingNote =>
      'Rahan pyöristys noudattaa yhtä sääntöä: puolikkaat pyöristetään nollasta poispäin, sovelletaan kerran Raha-muunnoksessa.';

  @override
  String get voiceInputTitle => 'Puheentulo';

  @override
  String get voiceStartListening => 'Aloita kuuntelu';

  @override
  String get voiceTranscriptLabel => 'Tekstitys';

  @override
  String get parseAction => 'Jäsennä';

  @override
  String get receiptReviewTitle => 'Tarkista kuitti';

  @override
  String get receiptTotal => 'Kuitin yhteissumma';

  @override
  String get receiptTotalUnknown => 'Yhteissummaa ei tunnistettu';

  @override
  String get receiptDiff => 'Ero';

  @override
  String get acceptLine => 'Hyväksy rivi';

  @override
  String get ignoreLine => 'Ohita rivi';

  @override
  String get receiptLineActions => 'Linkitä tuotteeseen, jaa tai ohita';

  @override
  String get receiptCommit => 'Hyväksy kaikki';

  @override
  String get receiptCommitted => 'Kuitti käsitelty.';

  @override
  String get priceHistoryTitle => 'Historia';

  @override
  String get noObservations => 'Hintahavaintoja ei vielä ole';

  @override
  String get templatesSection => 'Pohjat';

  @override
  String get templateHint => 'Luo uusi lista aiemmasta kauppareissusta';

  @override
  String get scanReceiptAction => 'Skannaa kuitti';

  @override
  String get shelfLabelAction => 'Hyllyn hintalappu';

  @override
  String get priceCandidatesTitle => 'Ehdokkaat';

  @override
  String get noPriceCandidates => 'Hintaa ei löytynyt; syötä se manuaalisesti.';

  @override
  String get voiceUnavailable =>
      'Puheentunnistus ei käytössä; syötä manuaalisesti.';

  @override
  String get linkToItem => 'Linkitä tuotteeseen';

  @override
  String get splitLine => 'Jaa kahteen';

  @override
  String get mergeWithNext => 'Yhdistä seuraavaan';

  @override
  String get ocrNoText => 'Tekstiä ei luettu; yritä uudelleen.';

  @override
  String get priceHistoryAction => 'Historia';

  @override
  String get itemsEmptyTitle => 'Tuotteita ei vielä ole';

  @override
  String get itemsEmptyBody =>
      'Lisää ensimmäinen tuote — todelliset hinnat syötetään täällä kaupassa.';

  @override
  String get addItemTooltip => 'Lisää tuote';

  @override
  String get unitAdet => 'kpl';

  @override
  String get unitKilogram => 'kg';

  @override
  String get unitGram => 'g';

  @override
  String get unitLitre => 'l';

  @override
  String get unitMililitre => 'ml';

  @override
  String get unitPaket => 'paketti';

  @override
  String get unitKutu => 'laatikko';

  @override
  String get unitSise => 'pullo';

  @override
  String get unitKavanoz => 'purkki';

  @override
  String get unitDemet => 'kimppu';

  @override
  String get unitDuzine => 'tuomi';

  @override
  String get unitMetre => 'm';

  @override
  String get unitCustom => 'Mukautettu';

  @override
  String get setReminderAction => 'Aseta muistutus';

  @override
  String get reminderPermissionDenied =>
      'Muistutuksia varten tarvitaan ilmoitusoikeus. Voit ottaa sen käyttöön järjestelmäasetuksissa.';

  @override
  String get reminderScheduled => 'Muistutus asetettu.';

  @override
  String get reminderCancelled => 'Muistutus poistettu.';

  @override
  String get reminderTitle => 'Kauppareissumuistutus';

  @override
  String reminderBody(Object title) {
    return 'On aika tarkistaa listasi: $title';
  }

  @override
  String get reminderPickDate => 'Valitse päivämäärä';

  @override
  String get reminderPickTime => 'Valitse kellonaika';

  @override
  String get itemDetailsSection => 'Tiedot';

  @override
  String get priceOptionalHint =>
      'Valinnainen — todellinen hinta syötetään kaupassa';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Suunniteltu: $total · $count tuotetta';
  }

  @override
  String get proActiveLabel => 'Pro aktiivinen — kiitos!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Ei mainoksia, enemmän tekoälyä, varmuuskopio · pienestä kuukausihinnasta';

  @override
  String get proBenefitNoAds => 'Mainokseton kokemus';

  @override
  String get proBenefitBackup => 'Varmuuskopio (vienti/tuonti)';

  @override
  String aboutVersion(Object version) {
    return 'Versio $version';
  }

  @override
  String get navDiscover => 'Löydä';

  @override
  String get shareAction => 'Jaa sovellus';

  @override
  String get rateAction => 'Arvostele meidät';

  @override
  String get aboutOpenRow => 'Tietoja & avoin lähdekoodi';

  @override
  String get voiceAddItemAction => 'Lisää puheella';

  @override
  String get formatLocaleLabel => 'Numerot ja valuuttamuoto';

  @override
  String get formatLocaleSystem => 'Järjestelmä (noudattaa sovelluksen kieltä)';

  @override
  String get formatLocaleTr => 'Turkki (1.234,56)';

  @override
  String get formatLocaleEn => 'Englanti (1,234.56)';

  @override
  String get aiToggleTitle => 'AI-avustaja';

  @override
  String get aiToggleSubtitle =>
      'Yhdistää kuitit, lukee hintalappuja ja muuntaa lauseet listoiksi. Kuvat ja ääni pysyvät laitteellasi; vain tekstiä käsitellään.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Olet käyttänyt tämän kuun AI-pyyntösi ($used/$limit). Päivitä lisäpyyntöjä varten tai jatka ilman tekoälyä.';
  }

  @override
  String get aiOffline => 'Ei yhteyttä — jatketaan ilman tekoälyä.';

  @override
  String get aiFailed =>
      'Tekoäly ei ole saatavilla tällä hetkellä — jatketaan ilman sitä.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'Laite';

  @override
  String get quickListAction => 'Lisää lauseesta';

  @override
  String get quickListTitle => 'Pikalista';

  @override
  String get quickListHint =>
      'esim. 1 kg omenoita 20, 2 leipää, puoli kiloa juustoa';

  @override
  String get quickListConvert => 'Muunna listaksi';

  @override
  String quickListAdd(int count) {
    return 'Lisää $count tuotetta';
  }

  @override
  String get quickListEmpty =>
      'Tuotteita ei löytynyt. Yritä luetteloida ne pilkulla erotettuna.';

  @override
  String get receiptAiMatched =>
      'AI yhdisti kuitin listaasi. Tarkista linkit ja vahvista.';

  @override
  String get receiptNeedsCheck => 'Tarkista tämä yhteensopivuus';

  @override
  String get receiptDiscountLine => 'Alennus';

  @override
  String get compareItem => 'Tuote';

  @override
  String get compareEstimated => 'Arvioitu';

  @override
  String get compareActual => 'Todellinen';

  @override
  String get compareDiff => 'Ero';

  @override
  String get compareTotal => 'Yhteensä';

  @override
  String get compareBudget => 'Budjetti';

  @override
  String get compareNotBought => 'ei ostettu';

  @override
  String get compareUnplanned => 'ei suunniteltu';

  @override
  String get pricierItems => 'Kalliimpia';

  @override
  String get cheaperItems => 'Edullisempia';

  @override
  String get compareAction => 'Vertaa';

  @override
  String get detailsSection => 'Yksityiskohdat';

  @override
  String get spendingTitle => 'Menot';

  @override
  String get spendingAction => 'Menot';

  @override
  String get spendingMonthTotal => 'Tässä kuussa';

  @override
  String get spendingWeekly => 'Viikoittaiset menot';

  @override
  String get spendingMonthly => 'Kuukausittaiset menot';

  @override
  String get monthlyLimitTitle => 'Kuukausiraja';

  @override
  String get monthlyLimitHelp =>
      'Kuinka paljon haluat käyttää ruokaostoksiin kuukaudessa?';

  @override
  String get monthlyLimitRemove => 'Poista';

  @override
  String get monthlyLimitSet => 'Aseta';

  @override
  String get monthlyLimitChange => 'Muuta';

  @override
  String get monthlyLimitNone =>
      'Aseta kuukausiraja nähdäksesi, kuinka paljon sinulla on jäljellä.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount yli rajan';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return '$amount jäljellä tässä kuussa';
  }

  @override
  String get plansTitle => 'Suunnitelmat';

  @override
  String get plansHeadline => 'Osta järkevästi tekoälyn avulla';

  @override
  String get plansSubhead =>
      'Kuitin yhdistäminen, hintalaput ja listat lauseesta. Peru milloin tahansa.';

  @override
  String get plansMonthly => 'Kuukausittain';

  @override
  String get plansYearly => 'Vuosittain';

  @override
  String get planFree => 'Ilmainen';

  @override
  String get planFreePrice => 'Ikuisesti ilmainen';

  @override
  String get planFreeAi => '15 AI-pyyntöä kuukaudessa';

  @override
  String get planFreeAds =>
      'Pieni mainospalkki (ei ensimmäisten 7 päivän aikana)';

  @override
  String get planCoreFeatures => 'Listat, hinnat, kuitit, kulukaaviot';

  @override
  String get plansPerYear => '/ vuosi';

  @override
  String get plansPerMonth => '/ kuukausi';

  @override
  String get planTrial => '7 päivää ilmaiseksi';

  @override
  String get planProAi => '200 AI-pyyntöä kuukaudessa';

  @override
  String get planNoAds => 'Ei mainoksia';

  @override
  String get planBackup => 'Varmuuskopiointi ja tuonti';

  @override
  String get planMaxAi => '1000 tekoälypyyntöä kuukaudessa';

  @override
  String get planMaxFamily => 'Suuren perheen ruokaostoksille';

  @override
  String get plansStoreUnavailable =>
      'Kauppa ei ole tällä hetkellä tavoitettavissa.';

  @override
  String get retryAction => 'Yritä uudelleen';

  @override
  String get plansPurchaseFailed =>
      'Ostoa ei voitu suorittaa. Yritä uudelleen.';

  @override
  String get planLifetimeTitle => 'Mainoksetta loppuelämäksi';

  @override
  String get planLifetimeSubtitle =>
      'Kertamaksu: mainokset pois, varmuuskopio; tekoäly pysyy ilmaisella käyttökiintiöllä';

  @override
  String get plansRestore => 'Palauta ostokset';

  @override
  String get plansLegal =>
      'Tilaukset uusiutuvat automaattisesti, kunnes ne peruutetaan. Peruuta milloin tahansa Google Playn › Maksut ja tilaukset -kohdassa. Hinnat sisältävät Google Playn näyttämät verot.';

  @override
  String get planCurrent => 'Nykyinen';

  @override
  String get planStartTrial => 'Aloita 7 päivän ilmainen kokeilu';

  @override
  String get planChoose => 'Valitse';

  @override
  String get plansAction => 'Suunnitelmat: Pro ja Max';

  @override
  String get assistantTitle => 'Avustaja';

  @override
  String get assistantGreeting => 'Hei! Mitä haluaisit tehdä?';

  @override
  String get assistantNewList => 'Uusi lista';

  @override
  String get assistantVoiceList => 'Äänipohjainen lista';

  @override
  String get assistantTextList => 'Tekstipohjainen lista';

  @override
  String get assistantScanReceipt => 'Skannaa kuitti';

  @override
  String get assistantSpending => 'Kulutukseni';

  @override
  String get assistantReceiptHint =>
      'Avaa listasi ja napauta skannataksesi kuitin kuvaketta.';

  @override
  String get assistantToggleTitle => 'Näytä avustaja';

  @override
  String get assistantToggleSubtitle => 'Pieni apuri oikeassa alakulmassa';

  @override
  String get scanPriceLabel => 'Skannaa hintalappu';
}
