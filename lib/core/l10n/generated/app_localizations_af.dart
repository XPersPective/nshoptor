// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Afrikaans (`af`).
class AppLocalizationsAf extends AppLocalizations {
  AppLocalizationsAf([String locale = 'af']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Plan tuis. Shop soos beplan.';

  @override
  String get listsTitle => 'Lyste';

  @override
  String get listsTabActive => 'Aktief';

  @override
  String get listsTabCompleted => 'Voltooi';

  @override
  String get listsTabArchived => 'Geargiveer';

  @override
  String get newListButton => 'Nuwe lys';

  @override
  String get listTitleHint => 'Titel (opsioneel)';

  @override
  String get saveButton => 'Stoor';

  @override
  String get cancelButton => 'Kanselleer';

  @override
  String get deleteButton => 'Vee uit';

  @override
  String get editAction => 'Redigeer';

  @override
  String get listDeleted => 'Lys uitgevee';

  @override
  String get invalidAmountError => 'Ongeldige bedrag';

  @override
  String get duplicateAction => 'Dupliseer';

  @override
  String get archiveAction => 'Argiveer';

  @override
  String get unarchiveAction => 'Verwyder argief';

  @override
  String get deleteListConfirm =>
      'Vee hierdie lys uit? Die beplande items sal ook verwyder word.';

  @override
  String get undoButton => 'Ontdoen';

  @override
  String get searchListHint => 'Soek lyste';

  @override
  String get currencyLabel => 'Geldeenheid';

  @override
  String get budgetLabel => 'Begroting (opsioneel)';

  @override
  String get noteLabel => 'Nota (opsioneel)';

  @override
  String get storeLabel => 'Winkel';

  @override
  String get keepAmountsAction => 'Behou bedrae';

  @override
  String get resetAmountsAction => 'Herstel bedrae';

  @override
  String get currencyChangeWarning =>
      'Die geldeenheid verander. Wat moet met die bestaande bedrae gebeur?';

  @override
  String get listsEmpty =>
      'Nog geen lyste nie. Skep jou eerste inkopiesbeplanning.';

  @override
  String get statusDraft => 'Konsep';

  @override
  String get statusPlanned => 'Beplan';

  @override
  String get statusShopping => 'Aan die koop';

  @override
  String get statusCompleted => 'Voltooi';

  @override
  String get statusArchived => 'Geargiveer';

  @override
  String autoListTitle(String date) {
    return '$date inkopies';
  }

  @override
  String get itemFormTitle => 'Voeg item by';

  @override
  String get itemNameLabel => 'Itemnaam';

  @override
  String get brandLabel => 'Merk / variantie (opsioneel)';

  @override
  String get categoryLabel => 'Kategorie';

  @override
  String get quantityLabel => 'Hoeveelheid';

  @override
  String get unitLabel => 'Eenheid';

  @override
  String get pricingModeLabel => 'Prysinskrywing';

  @override
  String get pricingModeUnitPrice => 'Eenheidsprys';

  @override
  String get pricingModeLineTotal => 'Lyntotaal';

  @override
  String get plannedPriceLabel => 'Beplande prys';

  @override
  String lineTotalCalculated(String value) {
    return 'Lyntotaal: $value';
  }

  @override
  String get requiredItemToggle => 'Verpligte item';

  @override
  String get maxPriceLabel => 'Maksimum aanvaarbare prys (opsioneel)';

  @override
  String get itemNoteLabel => 'Nota (opsioneel)';

  @override
  String get categoryProduce => 'Fruit & groente';

  @override
  String get categoryDairy => 'Suivelprodukte';

  @override
  String get categoryMeat => 'Vleis';

  @override
  String get categoryBakery => 'Bakkerij';

  @override
  String get categoryDrinks => 'Drankies';

  @override
  String get categoryCleaning => 'Skoonmaak';

  @override
  String get categoryPersonalCare => 'Persoonlike sorg';

  @override
  String get categoryHome => 'Tuis';

  @override
  String get categoryOther => 'Ander';

  @override
  String get invalidQuantityError => 'Ongeldige hoeveelheid';

  @override
  String get invalidPriceError => 'Ongeldige prys';

  @override
  String get invalidNameError => 'Voer \'n naam in';

  @override
  String unitPriceCalculated(String value) {
    return 'Eenheidsprys: $value';
  }

  @override
  String get shoppingTitle => 'Winkelmodus';

  @override
  String get summaryPlannedTotal => 'Beplan';

  @override
  String get summaryInCart => 'In mandjie';

  @override
  String get summaryRemainingPlan => 'Oorblywende beplanning';

  @override
  String get summaryProjected => 'Geskatte uitbetaling';

  @override
  String get summaryBudgetRemaining => 'Begroting oorbly';

  @override
  String get summaryBudgetOver => 'Begroting oorskry';

  @override
  String itemsProgress(String done, String total) {
    return '$done van $total items';
  }

  @override
  String get filterAll => 'Alles';

  @override
  String get filterToBuy => 'Om te koop';

  @override
  String get filterInCart => 'In mandjie';

  @override
  String get filterNotFound => 'Nie gevind nie';

  @override
  String get filterRequired => 'Verplicht';

  @override
  String get quickEntryTitle => 'Werklike prys';

  @override
  String get actualQuantityLabel => 'Werklike hoeveelheid';

  @override
  String get actualPriceLabel => 'Werklike prys';

  @override
  String get discountLabel => 'Korting (opsioneel)';

  @override
  String get alternativeNameLabel => 'Alternatiewe produknaam (opsioneel)';

  @override
  String get savePurchaseButton => 'Voeg by mandjie';

  @override
  String get unplannedAddButton => 'Voeg onbeplande item by';

  @override
  String get statusPending => 'Nie geneem nie';

  @override
  String get statusInCart => 'In mandjie';

  @override
  String get statusNotFound => 'Nie gevind nie';

  @override
  String get statusGaveUp => 'Opgegee';

  @override
  String get statusAlternative => 'Alternatief gekoop';

  @override
  String get keepScreenAwake => 'Hou skerm aan';

  @override
  String get finishShopping => 'Klaar winkel';

  @override
  String get completionWarning =>
      'Daar is ontbrekende of ongeverifieerde rekords. Jy kan steeds klaar maak; die resultaat sal dit aanteken.';

  @override
  String get continueShoppingButton => 'Bly winkel';

  @override
  String get resultTitle => 'Resultaat';

  @override
  String get summarySection => 'Opsomming';

  @override
  String get plannedTotalLabel => 'Beplande totaal';

  @override
  String get actualTotalLabel => 'Werklike totaal';

  @override
  String get varianceLabel => 'Verskil';

  @override
  String get varianceNotComputable => 'Kan nie bereken word nie';

  @override
  String get budgetStatusLabel => 'Begroting';

  @override
  String get savingsLabel => 'Onder plan';

  @override
  String get overspendLabel => 'Bo plan';

  @override
  String get unplannedTotalLabel => 'Onbeplande totaal';

  @override
  String get unpurchasedLabel => 'Beplan maar nie gekoop nie';

  @override
  String get totalDiscountLabel => 'Totale kortings';

  @override
  String get accuracyLabel => 'Schatnauwkeurigheid';

  @override
  String get groupsSection => 'Items';

  @override
  String get groupPricier => 'Duurder as beplan';

  @override
  String get groupCheaper => 'Goedkoper as beplan';

  @override
  String get groupClose => 'Naby aan skatting';

  @override
  String get groupNotTaken => 'Beplan, nie gekoop nie';

  @override
  String get groupUnplanned => 'Gekoop sonder plan';

  @override
  String get groupQuantityChanged => 'Hoeveelheid verander';

  @override
  String get groupUnverified => 'Nie geverifieer nie';

  @override
  String get plannedQtyLabel => 'Beplande hoeveelheid';

  @override
  String get actualQtyLabel => 'Werklike hoeveelheid';

  @override
  String get plannedUnitPriceLabel => 'Beplande eenheidsprys';

  @override
  String get actualUnitPriceLabel => 'Werklike eenheidsprys';

  @override
  String get lineVarianceLabel => 'Lyntotverskil';

  @override
  String get discountEffectLabel => 'Kortingsuitwerking';

  @override
  String get notBoughtMark => 'nie gekoop nie';

  @override
  String get noPurchasesNote => 'Geen aankope is aangeteken nie.';

  @override
  String get navHome => 'Tuis';

  @override
  String get navLists => 'Lyste';

  @override
  String get navHistory => 'Geskiedenis';

  @override
  String get navSettings => 'Instellings';

  @override
  String get homeEmptyTitle => 'Plan jou boodskappe';

  @override
  String get homeEmptyBody =>
      'Skep jou eerste lys en vergelyk beplande teenoor werklike koste.';

  @override
  String get homeActiveSection => 'Aktiewe lyste';

  @override
  String get homeCompletedSection => 'Onlangs voltooi';

  @override
  String get homeMonthlySection => 'Hierdie maand';

  @override
  String get monthPlannedLabel => 'Beplan';

  @override
  String get monthActualLabel => 'Werklik';

  @override
  String get monthVarianceLabel => 'Verskil';

  @override
  String get continueShoppingLabel => 'Gaan voort met winkels';

  @override
  String get historyEmpty =>
      'Nog geen voltooide boodskappe nie. Jou geskiedenis en insigte sal hier verskyn.';

  @override
  String get aboutTabTitle => 'Aangaande NShoptor';

  @override
  String get aboutBody =>
      'NShoptor deur Crazy Penguin. Boodskapplaner wat offline-first is. Gelisensieer onder GPL-3.0.';

  @override
  String get startShoppingLabel => 'Begin winkels';

  @override
  String get finishAndSeeResult => 'Voltooi & sien resultaat';

  @override
  String get settingsTitle => 'Instellings';

  @override
  String get languageLabel => 'Taal';

  @override
  String get languageSystem => 'Stelsel';

  @override
  String get languageTr => 'Turks';

  @override
  String get languageEn => 'Engels';

  @override
  String get themeLabel => 'Tema';

  @override
  String get themeSystem => 'Stelsel';

  @override
  String get themeLight => 'Lig';

  @override
  String get themeDark => 'Donker';

  @override
  String get defaultCurrencyLabel => 'Verstekgeldeenheid';

  @override
  String get defaultUnitLabel => 'Verstekeenheid';

  @override
  String get keepAwakeLabel => 'Hou skerm aan tydens winkels';

  @override
  String get backupSection => 'Rugsteun';

  @override
  String get exportBackupLabel => 'Eksporteer rugsteun';

  @override
  String get importBackupLabel => 'Importeer rugsteun';

  @override
  String get mergeImportLabel => 'Voeg saam met huidige data';

  @override
  String get separateImportLabel => 'Importeer as aparte kopie';

  @override
  String get importCancelled => 'Importering gekanselleer.';

  @override
  String get backupExported => 'Rugsteun suksesvol geëksporteer.';

  @override
  String get backupSizeWarning =>
      'Groot rugsteun: die lêer mag groot wees. Wil jy foto\'s ook insluit?';

  @override
  String get deleteAllSection => 'Gevaarson';

  @override
  String get deleteAllLabel => 'Vee alle data uit';

  @override
  String get deleteAllConfirm =>
      'Dit sal alle lyste, geskiedenis, resceipt-foto\'s en pryse verwyder. Lêers wat jy self geëksporteer het, bly op jou skyf. Gaan voort?';

  @override
  String get deleteAllConfirm2 =>
      'Is jy heeltemal seker? Hierdie aksie kan nie ongedaan gemaak word nie.';

  @override
  String get cancelAction => 'Kanselleer';

  @override
  String get confirmDelete => 'Permanent vee uit';

  @override
  String get dataDeleted => 'Alle plaaslike data is uitgevee.';

  @override
  String get privacyInfoLabel => 'Privaatheid';

  @override
  String get privacyInfoBody =>
      'Jou lyste, pryse, resceipts en foto\'s bly op jou toestel. Foto\'s en stemme vertrek nooit dit nie. Wanneer AI-hulp aangeskakel is, slegs teks (bv. resceipt-lyne of wat jy gedikteer het) word na ons bediener gestuur om verwerk te word en word nie gestoor nie.';

  @override
  String get aboutSection => 'Aangaande';

  @override
  String get aboutPublisher => 'Uitgewer: Crazy Penguin';

  @override
  String get aboutLicenses => 'Lisensies (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Steminvoer';

  @override
  String get voiceStatusUnknown => 'Diens: nie nagegaan nie';

  @override
  String get permissionsLabel => 'Magtigings';

  @override
  String get permissionsBody =>
      'Kamera, mikrofoon en kennisgewings word slegs versoek wanneer jy daardie kenmerke werklik gebruik.';

  @override
  String get unitsSection => 'Verstekwaardes';

  @override
  String get roundingNote =>
      'Geldafgronding volg een reël: halwes rond weg van nul, een keer toegepas by Geld-omskakeling.';

  @override
  String get voiceInputTitle => 'Steminvoer';

  @override
  String get voiceStartListening => 'Begin luister';

  @override
  String get voiceTranscriptLabel => 'Transkripsie';

  @override
  String get parseAction => 'Ontleed';

  @override
  String get receiptReviewTitle => 'Bekyk resceipt';

  @override
  String get receiptTotal => 'Resieptotaal';

  @override
  String get receiptTotalUnknown => 'Totaal nie opgespoor nie';

  @override
  String get receiptDiff => 'Verskil';

  @override
  String get acceptLine => 'Aanvaar lyn';

  @override
  String get ignoreLine => 'Ignoreer lyn';

  @override
  String get receiptLineActions => 'Koppel aan item, verdeel of ignoreer';

  @override
  String get receiptCommit => 'Aanvaar alles';

  @override
  String get receiptCommitted => 'Resiept toegepas.';

  @override
  String get priceHistoryTitle => 'Prysgeskiedenis';

  @override
  String get noObservations => 'Nog geen pryswaarnemings nie';

  @override
  String get templatesSection => 'Sjablone';

  @override
  String get templateHint => 'Skep \'n nuwe plan van \'n vorige inkopieslag';

  @override
  String get scanReceiptAction => 'Skandeer resiept';

  @override
  String get shelfLabelAction => 'Prys vanaf raketiket';

  @override
  String get priceCandidatesTitle => 'Pryskandidate';

  @override
  String get noPriceCandidates => 'Geen prys gevind; voer dit handmatig in.';

  @override
  String get voiceUnavailable =>
      'Stemherkenning nie beskikbaar nie; voer handmatig in.';

  @override
  String get linkToItem => 'Koppel aan item';

  @override
  String get splitLine => 'Verdeel in twee';

  @override
  String get mergeWithNext => 'Voeg saam met volgende';

  @override
  String get ocrNoText => 'Geen teks gelees nie; probeer weer.';

  @override
  String get priceHistoryAction => 'Prysgeskiedenis';

  @override
  String get itemsEmptyTitle => 'Nog geen items nie';

  @override
  String get itemsEmptyBody =>
      'Voeg jou eerste item by — jy sal die werklike pryse hier in die winkel invoer.';

  @override
  String get addItemTooltip => 'Voeg item by';

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
  String get unitKutu => 'boks';

  @override
  String get unitSise => 'fles';

  @override
  String get unitKavanoz => 'pot';

  @override
  String get unitDemet => 'bos';

  @override
  String get unitDuzine => 'dosyn';

  @override
  String get unitMetre => 'm';

  @override
  String get unitCustom => 'Aangepas';

  @override
  String get setReminderAction => 'Stel herinnering';

  @override
  String get reminderPermissionDenied =>
      'Notifikasietoestemming word benodig vir herinneringe. Jy kan dit in stelselinstellings inskakel.';

  @override
  String get reminderScheduled => 'Herinnering gestel.';

  @override
  String get reminderCancelled => 'Herinnering verwyder.';

  @override
  String get reminderTitle => 'Inkoperinnering';

  @override
  String reminderBody(Object title) {
    return 'Tyd om jou lys te kontroleer: $title';
  }

  @override
  String get reminderPickDate => 'Kies \'n datum';

  @override
  String get reminderPickTime => 'Kies \'n tyd';

  @override
  String get itemDetailsSection => 'Besonderhede';

  @override
  String get priceOptionalHint =>
      'Opsioneel — jy sal die werklike prys in die winkel invoer';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Beplan: $total · $count items';
  }

  @override
  String get proActiveLabel => 'Pro aktief — dankie!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Geen advertensies, meer AI, rugsteun · vanaf \'n klein maandelikse prys';

  @override
  String get proBenefitNoAds => 'Advertensievrye ervaring';

  @override
  String get proBenefitBackup => 'Rugsteun (uitvoer/inskryf)';

  @override
  String aboutVersion(Object version) {
    return 'Weergawe $version';
  }

  @override
  String get navDiscover => 'Ontdek';

  @override
  String get shareAction => 'Deel die app';

  @override
  String get rateAction => 'Gradeer ons';

  @override
  String get aboutOpenRow => 'Aangaande & oopbron';

  @override
  String get voiceAddItemAction => 'Voeg deur stem by';

  @override
  String get formatLocaleLabel => 'Getal- en geldeenheidsformaat';

  @override
  String get formatLocaleSystem =>
      'Toestelindeling (Latynse syfers; andersins Engels)';

  @override
  String get formatLocaleTr => 'Turks (1.234,56)';

  @override
  String get formatLocaleEn => 'Engels (1,234.56)';

  @override
  String get aiToggleTitle => 'AI-hulp';

  @override
  String get aiToggleSubtitle =>
      'Pas kwiteansies toe, lees prysetikette en omskakel sinne na lyste. Foto\'s en stem bly op jou toestel; slegs teks word verwerk.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Jy het hierdie maand se AI-aanvrae gebruik ($used/$limit). Upgradeer vir meer, of gaan voort sonder AI.';
  }

  @override
  String get aiOffline => 'Geen verbinding nie — gaan voort sonder AI.';

  @override
  String get aiFailed => 'AI is regtig onbeskikbaar — gaan voort sonder dit.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'Toestel';

  @override
  String get quickListAction => 'Voeg uit \'n sin by';

  @override
  String get quickListTitle => 'Vinnige lys';

  @override
  String get quickListHint => 'bv. 1 kg appels 20, 2 brode, half kilogram kaas';

  @override
  String get quickListConvert => 'Omskep na \'n lys';

  @override
  String quickListAdd(int count) {
    return 'Voeg $count items by';
  }

  @override
  String get quickListEmpty =>
      'Geen items gevind nie. Probeer om hulle deur kommas geskei te lys.';

  @override
  String get receiptAiMatched =>
      'AI het die kwitansie aan jou lys gekoppel. Kontroleer die skakels en bevestig.';

  @override
  String get receiptNeedsCheck => 'Kontroleer hierdie ooreenkoms';

  @override
  String get receiptDiscountLine => 'Korting';

  @override
  String get compareItem => 'Item';

  @override
  String get compareEstimated => 'Skatting';

  @override
  String get compareActual => 'Werklik';

  @override
  String get compareDiff => 'Verskil';

  @override
  String get compareTotal => 'Totaal';

  @override
  String get compareBudget => 'Begroot';

  @override
  String get compareNotBought => 'nie gekoop nie';

  @override
  String get compareUnplanned => 'nie beplan nie';

  @override
  String get pricierItems => 'Het meer gekos';

  @override
  String get cheaperItems => 'Het minder gekos';

  @override
  String get compareAction => 'Vergelyk';

  @override
  String get detailsSection => 'Besonderhede';

  @override
  String get spendingTitle => 'Spendering';

  @override
  String get spendingAction => 'Spendering';

  @override
  String get spendingMonthTotal => 'Hierdie maand';

  @override
  String get spendingWeekly => 'Weeklikse spendering';

  @override
  String get spendingMonthly => 'Maandelikse spendering';

  @override
  String get monthlyLimitTitle => 'Maandelike limiet';

  @override
  String get monthlyLimitHelp =>
      'Hoeveel wil jy per maand aan inkopies spandeer?';

  @override
  String get monthlyLimitRemove => 'Verwyder';

  @override
  String get monthlyLimitSet => 'Stel';

  @override
  String get monthlyLimitChange => 'Verander';

  @override
  String get monthlyLimitNone =>
      'Stel \'n maandelike limiet om te sien hoeveel jy nog oor het.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount bo die limiet';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return '$amount oor hierdie maand';
  }

  @override
  String get plansTitle => 'Pakkette';

  @override
  String get plansHeadline => 'Koop wyser met AI';

  @override
  String get plansSubhead =>
      'Kwitansie-ooreenkoms, prysetikette en lyste uit \'n sin. Kan enige tyd kanselleer word.';

  @override
  String get plansMonthly => 'Maandeliks';

  @override
  String get plansYearly => 'Jaarliks';

  @override
  String get planFree => 'Gratis';

  @override
  String get planFreePrice => 'Vir altyd gratis';

  @override
  String get planFreeAi => '15 AI-aanvrae per maand';

  @override
  String get planFreeAds =>
      'Klein bannerreklames (geen in jou eerste 7 dae nie)';

  @override
  String get planCoreFeatures =>
      'Lyste, pryse, kwiteansies, spenderingsgrafieke';

  @override
  String get plansPerYear => '/ jaar';

  @override
  String get plansPerMonth => '/ maand';

  @override
  String get planTrial => '7 dae gratis';

  @override
  String get planProAi => '200 AI-aanvrae per maand';

  @override
  String get planNoAds => 'Geen reklames nie';

  @override
  String get planBackup => 'Sleutel- en invoer';

  @override
  String get planMaxAi => '1000 AI-aanvrae per maand';

  @override
  String get planMaxFamily => 'Vir groot gesinsinkopies';

  @override
  String get plansStoreUnavailable => 'Die winkel is tans nie bereikbaar nie.';

  @override
  String get retryAction => 'Probeer weer';

  @override
  String get plansPurchaseFailed =>
      'Die aankoop kon nie voltooi word nie. Probeer asseblief weer.';

  @override
  String get planLifetimeTitle => 'Reklame-vry vir altyd';

  @override
  String get planLifetimeSubtitle =>
      'Eenmalige betaling: geen advertensies, rugsteun; AI bly by die gratis toelaat';

  @override
  String get plansRestore => 'Herstel aankope';

  @override
  String get plansLegal =>
      'Abonnemente vernuut outomaties tot kansellasie. Kan enige tyd gekanselleer word in Google Play › Betalings en abonnemente. Prys sluit belasting in soos deur Google Play getoon.';

  @override
  String get planCurrent => 'Huidig';

  @override
  String get planStartTrial => 'Begin 7-dae gratis proefperiode';

  @override
  String get planChoose => 'Kies';

  @override
  String get plansAction => 'Planne: Pro en Max';

  @override
  String get assistantTitle => 'Assistent';

  @override
  String get assistantGreeting => 'Hi! Wat wil jy doen?';

  @override
  String get assistantNewList => 'Nuwe lys';

  @override
  String get assistantVoiceList => 'Lys per stem';

  @override
  String get assistantTextList => 'Lys uit \'n sin';

  @override
  String get assistantScanReceipt => 'Skandeer \'n kwitansie';

  @override
  String get assistantSpending => 'My uitgawes';

  @override
  String get assistantReceiptHint =>
      'Maak jou lys oop en tik op die kwitansie-ikoon om dit te skandeer.';

  @override
  String get assistantToggleTitle => 'Wys assistent';

  @override
  String get assistantToggleSubtitle => 'Die klein helper regs onder';

  @override
  String get scanPriceLabel => 'Skandeer prysetiket';

  @override
  String get saveFailed =>
      'Kon nie stoor nie. Jou veranderinge is steeds hier. Probeer asseblief weer.';

  @override
  String get deleteItemConfirm =>
      'Verwyder hierdie item en sy geregistreerde aankope?';

  @override
  String get clearPurchaseConfirm =>
      'Vee hierdie item af en verwyder sy geregistreerde aankope?';

  @override
  String get reportPdfAction => 'Stoor PDF-verslag';

  @override
  String get reportNotInvoice =>
      'Aankopsamevatting, nie \'n belastingfactuur nie. Belastingkoerse is onbekend.';

  @override
  String get purchaseVisits => 'Aankoopbesoeke';

  @override
  String get purchaseInterval => 'Gemiddelde dae tussen aankope';

  @override
  String get purchasedQuantity => 'Aangekoopte hoeveelheid';

  @override
  String get purchaseAnalyticsHint =>
      'Aankope meet nie verbruik nie. Geldeenhede en eenhede word apart vertoon.';

  @override
  String get receiptReplaces =>
      'Geskakelde bonlyne vervang bestaande aankope; ongeskakelde lyne word bygevoeg.';

  @override
  String get voiceUnsupportedLanguage =>
      'Hierdie taal is nie beskikbaar vir stemintyding op hierdie toestel nie. Jy kan tik.';

  @override
  String get voiceStopListening => 'Stop met luister';

  @override
  String get keepAwakeFailed =>
      'Kon nie die skerm wakker hou nie. Probeer asseblief weer.';
}
