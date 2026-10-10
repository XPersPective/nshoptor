// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Plan thuis. Winkelen zoals gepland.';

  @override
  String get listsTitle => 'Lijsten';

  @override
  String get listsTabActive => 'Actief';

  @override
  String get listsTabCompleted => 'Voltooid';

  @override
  String get listsTabArchived => 'Gearchiveerd';

  @override
  String get newListButton => 'Nieuwe lijst';

  @override
  String get listTitleHint => 'Titel (optioneel)';

  @override
  String get saveButton => 'Opslaan';

  @override
  String get cancelButton => 'Annuleren';

  @override
  String get deleteButton => 'Verwijderen';

  @override
  String get editAction => 'Bewerken';

  @override
  String get listDeleted => 'Lijst verwijderd';

  @override
  String get invalidAmountError => 'Ongeldig bedrag';

  @override
  String get duplicateAction => 'Dupliceren';

  @override
  String get archiveAction => 'Archiveren';

  @override
  String get unarchiveAction => 'Uit archiveren';

  @override
  String get deleteListConfirm =>
      'Deze lijst verwijderen? De geplande items worden ook verwijderd.';

  @override
  String get undoButton => 'Ongedaan maken';

  @override
  String get searchListHint => 'Lijsten zoeken';

  @override
  String get currencyLabel => 'Valuta';

  @override
  String get budgetLabel => 'Budget (optioneel)';

  @override
  String get noteLabel => 'Opmerking (optioneel)';

  @override
  String get storeLabel => 'Winkel';

  @override
  String get keepAmountsAction => 'Bedragen behouden';

  @override
  String get resetAmountsAction => 'Bedragen resetten';

  @override
  String get currencyChangeWarning =>
      'De valuta verandert. Wat moet er gebeuren met de bestaande bedragen?';

  @override
  String get listsEmpty =>
      'Nog geen lijsten. Maak je eerste boodschappenlijst.';

  @override
  String get statusDraft => 'Concept';

  @override
  String get statusPlanned => 'Gepland';

  @override
  String get statusShopping => 'Aan het winkelen';

  @override
  String get statusCompleted => 'Voltooid';

  @override
  String get statusArchived => 'Gearchiveerd';

  @override
  String autoListTitle(String date) {
    return '$date boodschappen';
  }

  @override
  String get itemFormTitle => 'Item toevoegen';

  @override
  String get itemNameLabel => 'Productnaam';

  @override
  String get brandLabel => 'Merk / variant (optioneel)';

  @override
  String get categoryLabel => 'Categorie';

  @override
  String get quantityLabel => 'Hoeveelheid';

  @override
  String get unitLabel => 'Eenheid';

  @override
  String get pricingModeLabel => 'Prijsinvoer';

  @override
  String get pricingModeUnitPrice => 'Stuksprijs';

  @override
  String get pricingModeLineTotal => 'Totaal per regel';

  @override
  String get plannedPriceLabel => 'Geplande prijs';

  @override
  String lineTotalCalculated(String value) {
    return 'Totaal per regel: $value';
  }

  @override
  String get requiredItemToggle => 'Vereist item';

  @override
  String get maxPriceLabel => 'Maximale acceptabele prijs (optioneel)';

  @override
  String get itemNoteLabel => 'Opmerking (optioneel)';

  @override
  String get categoryProduce => 'Groente & fruit';

  @override
  String get categoryDairy => 'Zuivel';

  @override
  String get categoryMeat => 'Vlees';

  @override
  String get categoryBakery => 'Bakkerij';

  @override
  String get categoryDrinks => 'Dranken';

  @override
  String get categoryCleaning => 'Schoonmaak';

  @override
  String get categoryPersonalCare => 'Persoonlijke verzorging';

  @override
  String get categoryHome => 'Huishouden';

  @override
  String get categoryOther => 'Overig';

  @override
  String get invalidQuantityError => 'Ongeldige hoeveelheid';

  @override
  String get invalidPriceError => 'Ongeldige prijs';

  @override
  String get invalidNameError => 'Voer een naam in';

  @override
  String unitPriceCalculated(String value) {
    return 'Eenheidsprijs: $value';
  }

  @override
  String get shoppingTitle => 'Winkelmodus';

  @override
  String get summaryPlannedTotal => 'Gepland';

  @override
  String get summaryInCart => 'In winkelwagen';

  @override
  String get summaryRemainingPlan => 'Resterende boodschappenlijst';

  @override
  String get summaryProjected => 'Geschatte kassa';

  @override
  String get summaryBudgetRemaining => 'Budget over';

  @override
  String get summaryBudgetOver => 'Buiten budget';

  @override
  String itemsProgress(String done, String total) {
    return '$done van $total artikelen';
  }

  @override
  String get filterAll => 'Alle';

  @override
  String get filterToBuy => 'Te kopen';

  @override
  String get filterInCart => 'In winkelwagen';

  @override
  String get filterNotFound => 'Niet gevonden';

  @override
  String get filterRequired => 'Verplicht';

  @override
  String get quickEntryTitle => 'Werkelijke prijs';

  @override
  String get actualQuantityLabel => 'Werkelijke hoeveelheid';

  @override
  String get actualPriceLabel => 'Werkelijke prijs';

  @override
  String get discountLabel => 'Korting (optioneel)';

  @override
  String get alternativeNameLabel => 'Alternatieve productnaam (optioneel)';

  @override
  String get savePurchaseButton => 'Toevoegen aan winkelwagen';

  @override
  String get unplannedAddButton => 'Ongepland item toevoegen';

  @override
  String get statusPending => 'Niet meegenomen';

  @override
  String get statusInCart => 'In winkelwagen';

  @override
  String get statusNotFound => 'Niet gevonden';

  @override
  String get statusGaveUp => 'Opgegeven';

  @override
  String get statusAlternative => 'Alternatief gekocht';

  @override
  String get keepScreenAwake => 'Scherm aanhouden';

  @override
  String get finishShopping => 'Winkelen afronden';

  @override
  String get completionWarning =>
      'Er ontbreken of zijn niet-geverifieerde records. Je kunt nog steeds afronden; het resultaat zal dit vermelden.';

  @override
  String get continueShoppingButton => 'Doorgaan met winkelen';

  @override
  String get resultTitle => 'Resultaat';

  @override
  String get summarySection => 'Samenvatting';

  @override
  String get plannedTotalLabel => 'Totale geplande kosten';

  @override
  String get actualTotalLabel => 'Totale werkelijke kosten';

  @override
  String get varianceLabel => 'Verschil';

  @override
  String get varianceNotComputable => 'Kan niet worden berekend';

  @override
  String get budgetStatusLabel => 'Budget';

  @override
  String get savingsLabel => 'Onder plan';

  @override
  String get overspendLabel => 'Buiten plan';

  @override
  String get unplannedTotalLabel => 'Totale ongeplande kosten';

  @override
  String get unpurchasedLabel => 'Gepland maar niet gekocht';

  @override
  String get totalDiscountLabel => 'Totale kortingen';

  @override
  String get accuracyLabel => 'Schatnauwkeurigheid';

  @override
  String get groupsSection => 'Artikelen';

  @override
  String get groupPricier => 'Duurder dan gepland';

  @override
  String get groupCheaper => 'Goedkoper dan gepland';

  @override
  String get groupClose => 'Dicht bij schatting';

  @override
  String get groupNotTaken => 'Gepland, niet gekocht';

  @override
  String get groupUnplanned => 'Gekocht zonder plan';

  @override
  String get groupQuantityChanged => 'Hoeveelheid gewijzigd';

  @override
  String get groupUnverified => 'Niet geverifieerd';

  @override
  String get plannedQtyLabel => 'Geplande hoeveelheid';

  @override
  String get actualQtyLabel => 'Werkelijke hoeveelheid';

  @override
  String get plannedUnitPriceLabel => 'Geplande eenheidsprijs';

  @override
  String get actualUnitPriceLabel => 'Werkelijke eenheidsprijs';

  @override
  String get lineVarianceLabel => 'Lijnverschil';

  @override
  String get discountEffectLabel => 'Kortingseffect';

  @override
  String get notBoughtMark => 'niet gekocht';

  @override
  String get noPurchasesNote => 'Er zijn geen aankopen geregistreerd.';

  @override
  String get navHome => 'Home';

  @override
  String get navLists => 'Lijsten';

  @override
  String get navHistory => 'Geschiedenis';

  @override
  String get navSettings => 'Instellingen';

  @override
  String get homeEmptyTitle => 'Plan je boodschappen';

  @override
  String get homeEmptyBody =>
      'Maak je eerste lijst en vergelijk geplande met werkelijke kosten.';

  @override
  String get homeActiveSection => 'Actieve lijsten';

  @override
  String get homeCompletedSection => 'Onlangs voltooid';

  @override
  String get homeMonthlySection => 'Deze maand';

  @override
  String get monthPlannedLabel => 'Gepland';

  @override
  String get monthActualLabel => 'Werkelijk';

  @override
  String get monthVarianceLabel => 'Verschil';

  @override
  String get continueShoppingLabel => 'Verder winkelen';

  @override
  String get historyEmpty =>
      'Nog geen voltooide boodschappen. Je geschiedenis en inzichten verschijnen hier.';

  @override
  String get aboutTabTitle => 'Over NShoptor';

  @override
  String get aboutBody =>
      'NShoptor van Crazy Penguin. Offline-first boodschappenplanner. Gelicenseerd onder GPL-3.0.';

  @override
  String get startShoppingLabel => 'Begin met winkelen';

  @override
  String get finishAndSeeResult => 'Voltooien & resultaat bekijken';

  @override
  String get settingsTitle => 'Instellingen';

  @override
  String get languageLabel => 'Taal';

  @override
  String get languageSystem => 'Systeem';

  @override
  String get languageTr => 'Turks';

  @override
  String get languageEn => 'Engels';

  @override
  String get themeLabel => 'Thema';

  @override
  String get themeSystem => 'Systeem';

  @override
  String get themeLight => 'Licht';

  @override
  String get themeDark => 'Donker';

  @override
  String get defaultCurrencyLabel => 'Standaard valuta';

  @override
  String get defaultUnitLabel => 'Standaard eenheid';

  @override
  String get keepAwakeLabel => 'Scherm aanhouden tijdens winkelen';

  @override
  String get backupSection => 'Back-up';

  @override
  String get exportBackupLabel => 'Back-up exporteren';

  @override
  String get importBackupLabel => 'Back-up importeren';

  @override
  String get mergeImportLabel => 'Samenvoegen in huidige gegevens';

  @override
  String get separateImportLabel => 'Importeren als aparte kopie';

  @override
  String get importCancelled => 'Importeren geannuleerd.';

  @override
  String get backupExported => 'Back-up succesvol geëxporteerd.';

  @override
  String get backupSizeWarning =>
      'Grote back-up: het bestand kan groot zijn. Wil je ook foto\'s opnemen?';

  @override
  String get deleteAllSection => 'Gevarenzone';

  @override
  String get deleteAllLabel => 'Alle gegevens verwijderen';

  @override
  String get deleteAllConfirm =>
      'Hiermee worden alle lijsten, geschiedenis, bonfoto\'s en prijzen verwijderd. Door jou geëxporteerde bestanden blijven op je schijf. Doorgaan?';

  @override
  String get deleteAllConfirm2 =>
      'Weet je het helemaal zeker? Deze actie kan niet ongedaan worden gemaakt.';

  @override
  String get cancelAction => 'Annuleren';

  @override
  String get confirmDelete => 'Permanent verwijderen';

  @override
  String get dataDeleted => 'Alle lokale gegevens zijn verwijderd.';

  @override
  String get privacyInfoLabel => 'Privacy';

  @override
  String get privacyInfoBody =>
      'Je lijsten, prijzen, bonnen en foto\'s blijven op je apparaat. Foto\'s en stemmen verlaten het nooit. Wanneer AI-hulp is ingeschakeld, wordt alleen tekst (bijvoorbeeld bonregels of wat je hebt ingedikt) naar onze server gestuurd voor verwerking en niet bewaard.';

  @override
  String get aboutSection => 'Over';

  @override
  String get aboutPublisher => 'Uitgever: Crazy Penguin';

  @override
  String get aboutLicenses => 'Licenties (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Steminvoer';

  @override
  String get voiceStatusUnknown => 'Service: niet gecontroleerd';

  @override
  String get permissionsLabel => 'Machtigingen';

  @override
  String get permissionsBody =>
      'Camera, microfoon en meldingen worden alleen aangevraagd wanneer je die functies daadwerkelijk gebruikt.';

  @override
  String get unitsSection => 'Standaarden';

  @override
  String get roundingNote =>
      'Ronding van geld volgt één regel: halven worden weg van nul afgerond, toegepast één keer bij Money-conversie.';

  @override
  String get voiceInputTitle => 'Steminvoer';

  @override
  String get voiceStartListening => 'Luisteren starten';

  @override
  String get voiceTranscriptLabel => 'Transcript';

  @override
  String get parseAction => 'Parseren';

  @override
  String get receiptReviewTitle => 'Bon controleren';

  @override
  String get receiptTotal => 'Totaal van bon';

  @override
  String get receiptTotalUnknown => 'Totaal niet gedetecteerd';

  @override
  String get receiptDiff => 'Verschil';

  @override
  String get acceptLine => 'Regel accepteren';

  @override
  String get ignoreLine => 'Regel negeren';

  @override
  String get receiptLineActions => 'Koppelen aan item, splitsen of negeren';

  @override
  String get receiptCommit => 'Alles accepteren';

  @override
  String get receiptCommitted => 'Bon verwerkt.';

  @override
  String get priceHistoryTitle => 'Prijsverloop';

  @override
  String get noObservations => 'Nog geen prijsobservaties';

  @override
  String get templatesSection => 'Sjablonen';

  @override
  String get templateHint =>
      'Maak een nieuw boodschappenlijstje op basis van een vorige keer';

  @override
  String get scanReceiptAction => 'Bon scannen';

  @override
  String get shelfLabelAction => 'Prijs van etiket';

  @override
  String get priceCandidatesTitle => 'Prijskandidaten';

  @override
  String get noPriceCandidates => 'Geen prijs gevonden; handmatig invoeren.';

  @override
  String get voiceUnavailable =>
      'Spraakherkenning niet beschikbaar; handmatig invoeren.';

  @override
  String get linkToItem => 'Koppelen aan item';

  @override
  String get splitLine => 'In twee delen splitsen';

  @override
  String get mergeWithNext => 'Samenvoegen met volgende';

  @override
  String get ocrNoText => 'Geen tekst gelezen; opnieuw proberen.';

  @override
  String get priceHistoryAction => 'Prijsverloop';

  @override
  String get itemsEmptyTitle => 'Nog geen items';

  @override
  String get itemsEmptyBody =>
      'Voeg je eerste item toe — hier voer je de werkelijke prijzen in in de winkel.';

  @override
  String get addItemTooltip => 'Item toevoegen';

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
  String get unitPaket => 'pak';

  @override
  String get unitKutu => 'doos';

  @override
  String get unitSise => 'fles';

  @override
  String get unitKavanoz => 'pot';

  @override
  String get unitDemet => 'bos';

  @override
  String get unitDuzine => 'dozijn';

  @override
  String get unitMetre => 'm';

  @override
  String get unitCustom => 'Aangepast';

  @override
  String get setReminderAction => 'Herinnering instellen';

  @override
  String get reminderPermissionDenied =>
      'Meldingsmachtiging is nodig voor herinneringen. Je kunt dit inschakelen in de systeeminstellingen.';

  @override
  String get reminderScheduled => 'Herinnering ingesteld.';

  @override
  String get reminderCancelled => 'Herinnering verwijderd.';

  @override
  String get reminderTitle => 'Boodschappenherinnering';

  @override
  String reminderBody(Object title) {
    return 'Het is tijd om je lijst te bekijken: $title';
  }

  @override
  String get reminderPickDate => 'Kies een datum';

  @override
  String get reminderPickTime => 'Kies een tijd';

  @override
  String get itemDetailsSection => 'Details';

  @override
  String get priceOptionalHint =>
      'Optioneel — je voert de werkelijke prijs in in de winkel';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Geschat: $total · $count items';
  }

  @override
  String get proActiveLabel => 'Pro actief — bedankt!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Geen advertenties, meer AI, back-up · vanaf een klein maandbedrag';

  @override
  String get proBenefitNoAds => 'Advrije ervaring';

  @override
  String get proBenefitBackup => 'Back-up (exporteren/importeren)';

  @override
  String aboutVersion(Object version) {
    return 'Versie $version';
  }

  @override
  String get navDiscover => 'Ontdekken';

  @override
  String get shareAction => 'App delen';

  @override
  String get rateAction => 'Beoordeel ons';

  @override
  String get aboutOpenRow => 'Over & open source';

  @override
  String get voiceAddItemAction => 'Toevoegen via spraak';

  @override
  String get formatLocaleLabel => 'Getallen- en valuta-indeling';

  @override
  String get formatLocaleSystem =>
      'Apparaatindeling (Latijnse cijfers; anders Engels)';

  @override
  String get formatLocaleTr => 'Turks (1.234,56)';

  @override
  String get formatLocaleEn => 'Engels (1,234.56)';

  @override
  String get aiToggleTitle => 'AI-hulp';

  @override
  String get aiToggleSubtitle =>
      'Kwitanties matchen, prijslabels lezen en zinnen omzetten naar lijsten. Foto\'s en spraak blijven op je apparaat; alleen tekst wordt verwerkt.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Je hebt dit maand AI-verzoeken gebruikt ($used/$limit). Upgrade voor meer, of ga verder zonder AI.';
  }

  @override
  String get aiOffline => 'Geen verbinding — doorgaan zonder AI.';

  @override
  String get aiFailed =>
      'AI is momenteel niet beschikbaar — doorgaan zonder AI.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'Apparaat';

  @override
  String get quickListAction => 'Toevoegen vanuit een zin';

  @override
  String get quickListTitle => 'Snelle lijst';

  @override
  String get quickListHint => 'bijv. 1 kg appels 20, 2 broden, half kilo kaas';

  @override
  String get quickListConvert => 'Omzetten naar lijst';

  @override
  String quickListAdd(int count) {
    return '$count items toevoegen';
  }

  @override
  String get quickListEmpty =>
      'Geen items gevonden. Probeer ze door komma\'s gescheiden op te sommen.';

  @override
  String get receiptAiMatched =>
      'AI heeft de kwitantie aan je lijst gekoppeld. Controleer de koppelingen en bevestig.';

  @override
  String get receiptNeedsCheck => 'Deze match controleren';

  @override
  String get receiptDiscountLine => 'Korting';

  @override
  String get compareItem => 'Artikel';

  @override
  String get compareEstimated => 'Geschat';

  @override
  String get compareActual => 'Werkelijk';

  @override
  String get compareDiff => 'Verschil';

  @override
  String get compareTotal => 'Totaal';

  @override
  String get compareBudget => 'Budget';

  @override
  String get compareNotBought => 'niet gekocht';

  @override
  String get compareUnplanned => 'niet gepland';

  @override
  String get pricierItems => 'Duurder';

  @override
  String get cheaperItems => 'Goedkoper';

  @override
  String get compareAction => 'Vergelijken';

  @override
  String get detailsSection => 'Details';

  @override
  String get spendingTitle => 'Uitgaven';

  @override
  String get spendingAction => 'Uitgaven';

  @override
  String get spendingMonthTotal => 'Deze maand';

  @override
  String get spendingWeekly => 'Wekelijkse uitgaven';

  @override
  String get spendingMonthly => 'Maandelijkse uitgaven';

  @override
  String get monthlyLimitTitle => 'Maandelijks budget';

  @override
  String get monthlyLimitHelp =>
      'Hoeveel wil je per maand uitgeven aan boodschappen?';

  @override
  String get monthlyLimitRemove => 'Verwijderen';

  @override
  String get monthlyLimitSet => 'Instellen';

  @override
  String get monthlyLimitChange => 'Wijzigen';

  @override
  String get monthlyLimitNone =>
      'Stel een maandelijks budget in om te zien wat er nog over is.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount boven het budget';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return '$amount over deze maand';
  }

  @override
  String get plansTitle => 'Abonnementen';

  @override
  String get plansHeadline => 'Slimmer winkelen met AI';

  @override
  String get plansSubhead =>
      'Kwitantiematching, prijslabels en lijsten uit een zin. Op elk moment opzeggen.';

  @override
  String get plansMonthly => 'Maandelijks';

  @override
  String get plansYearly => 'Jaarlijks';

  @override
  String get planFree => 'Gratis';

  @override
  String get planFreePrice => 'Altijd gratis';

  @override
  String get planFreeAi => '10 AI-verzoeken per maand';

  @override
  String get planFreeAds =>
      'Kleine banneradvertenties (geen in je eerste 7 dagen)';

  @override
  String get planCoreFeatures =>
      'Lijsten, prijzen, kwitanties, uitgavenoverzichten';

  @override
  String get plansPerYear => '/ jaar';

  @override
  String get plansPerMonth => '/ maand';

  @override
  String get planTrial => '7 dagen gratis';

  @override
  String get planProAi => '100 AI-verzoeken per maand';

  @override
  String get planNoAds => 'Geen advertenties';

  @override
  String get planBackup => 'Back-up export en import';

  @override
  String get planMaxAi => '300 AI-verzoeken per maand';

  @override
  String get planMaxFamily => 'Voor grote gezinsboodschappen';

  @override
  String get plansStoreUnavailable => 'De winkel is momenteel niet bereikbaar.';

  @override
  String get retryAction => 'Opnieuw proberen';

  @override
  String get plansPurchaseFailed =>
      'De aankoop is mislukt. Probeer het opnieuw.';

  @override
  String get planLifetimeTitle => 'Reclamevrij voor altijd';

  @override
  String get planLifetimeSubtitle =>
      'Eenmalige betaling: geen reclame, back-up; AI blijft binnen de gratis limiet';

  @override
  String get plansRestore => 'Aankopen herstellen';

  @override
  String get plansLegal =>
      'Abonnementen worden automatisch verlengd tot ze worden opgezegd. Opzeggen kan altijd via Google Play › Betalingen & abonnementen. Prijzen zijn inclusief de door Google Play getoonde belastingen.';

  @override
  String get planCurrent => 'Huidig';

  @override
  String get planStartTrial => 'Start 7 dagen gratis proefperiode';

  @override
  String get planChoose => 'Kiezen';

  @override
  String get plansAction => 'Plans: Pro en Max';

  @override
  String get assistantTitle => 'Assistent';

  @override
  String get assistantGreeting => 'Hallo! Wat wil je doen?';

  @override
  String get assistantNewList => 'Nieuwe lijst';

  @override
  String get assistantVoiceList => 'Lijst via spraak';

  @override
  String get assistantTextList => 'Lijst uit een zin';

  @override
  String get assistantScanReceipt => 'Bon scannen';

  @override
  String get assistantSpending => 'Mijn uitgaven';

  @override
  String get assistantReceiptHint =>
      'Open je lijst en tik op het bonpictogram om te scannen.';

  @override
  String get assistantToggleTitle => 'Assistent tonen';

  @override
  String get assistantToggleSubtitle => 'Het kleine hulpje rechtsonder';

  @override
  String get scanPriceLabel => 'Prijslabel scannen';

  @override
  String get saveFailed =>
      'Opslaan mislukt. Je wijzigingen zijn nog steeds beschikbaar. Probeer het opnieuw.';

  @override
  String get deleteItemConfirm =>
      'Dit item en de geregistreerde aankopen verwijderen?';

  @override
  String get clearPurchaseConfirm =>
      'Dit item uitvinken en de geregistreerde aankopen verwijderen?';

  @override
  String get reportPdfAction => 'PDF-rapport opslaan';

  @override
  String get reportNotInvoice =>
      'Winkeloverzicht, geen belastingfactuur. BTW-tarieven zijn onbekend.';

  @override
  String get purchaseVisits => 'Winkelbezoeken';

  @override
  String get purchaseInterval => 'Gemiddelde dagen tussen aankopen';

  @override
  String get purchasedQuantity => 'Aangekochte hoeveelheid';

  @override
  String get purchaseAnalyticsHint =>
      'Aankopen meten geen verbruik. Valuta\'s en eenheden worden apart weergegeven.';

  @override
  String get receiptReplaces =>
      'Gekoppelde bonregels vervangen bestaande aankopen; niet-gekoppelde regels worden toegevoegd.';

  @override
  String get voiceUnsupportedLanguage =>
      'Deze taal is niet beschikbaar voor spraakinvoer op dit apparaat. Je kunt in plaats daarvan typen.';

  @override
  String get voiceStopListening => 'Stop met luisteren';

  @override
  String get keepAwakeFailed =>
      'Het is niet gelukt om het scherm actief te houden. Probeer het opnieuw.';

  @override
  String get purchaseHistoryHint =>
      'Alle voltooide boodschappen. Terugbrings verlagen de totalen. Data verwijzen naar het moment van afrekenen. Eén bezoek is niet genoeg om een gemiddelde interval te berekenen.';

  @override
  String get planLegacyRights =>
      'Bestaande Pro- en Max-abonnementen behouden hun oorspronkelijke maandelijkse AI-toelage. Nieuwe aanbiedingen bieden 100 en 300 verzoeken.';

  @override
  String get csvExportAction => 'CSV exporteren';
}
