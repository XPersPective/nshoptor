// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Icelandic (`is`).
class AppLocalizationsIs extends AppLocalizations {
  AppLocalizationsIs([String locale = 'is']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Skipuleggðu heima. Keyptu eins og áætlað.';

  @override
  String get listsTitle => 'Listar';

  @override
  String get listsTabActive => 'Virkir';

  @override
  String get listsTabCompleted => 'Lokið';

  @override
  String get listsTabArchived => 'Safnað';

  @override
  String get newListButton => 'Nýr listi';

  @override
  String get listTitleHint => 'Titill (valfrjálst)';

  @override
  String get saveButton => 'Vista';

  @override
  String get cancelButton => 'Hætta við';

  @override
  String get deleteButton => 'Eyða';

  @override
  String get editAction => 'Breyta';

  @override
  String get listDeleted => 'Listi eyttur';

  @override
  String get invalidAmountError => 'Ógild magn';

  @override
  String get duplicateAction => 'Afrita';

  @override
  String get archiveAction => 'Safna';

  @override
  String get unarchiveAction => 'Fjarlægja úr söfnum';

  @override
  String get deleteListConfirm =>
      'Ertu viss um að þú viljir eyða þessum lista? Áætlaðar vörur verða einnig fjarlægðar.';

  @override
  String get undoButton => 'Afturkalla';

  @override
  String get searchListHint => 'Leita í listum';

  @override
  String get currencyLabel => 'Gilda';

  @override
  String get budgetLabel => 'Fjárlag (valfrjálst)';

  @override
  String get noteLabel => 'Athugasemd (valfrjálst)';

  @override
  String get storeLabel => 'Verslun';

  @override
  String get keepAmountsAction => 'Halda magninum';

  @override
  String get resetAmountsAction => 'Endurstilla magn';

  @override
  String get currencyChangeWarning =>
      'Gildan er að breytast. Hvað á að gerast með núverandi magn?';

  @override
  String get listsEmpty =>
      'Engir listar ennþá. Búðu til fyrstu innkaupaáætlunina þína.';

  @override
  String get statusDraft => 'Uppkast';

  @override
  String get statusPlanned => 'Áætlað';

  @override
  String get statusShopping => 'Í innkaupum';

  @override
  String get statusCompleted => 'Lokið';

  @override
  String get statusArchived => 'Safnað';

  @override
  String autoListTitle(String date) {
    return '$date innkaup';
  }

  @override
  String get itemFormTitle => 'Bæta við vöru';

  @override
  String get itemNameLabel => 'Vöruheiti';

  @override
  String get brandLabel => 'Merki / útgáfa (valfrjálst)';

  @override
  String get categoryLabel => 'Flokkur';

  @override
  String get quantityLabel => 'Magn';

  @override
  String get unitLabel => 'Eining';

  @override
  String get pricingModeLabel => 'Verðskráning';

  @override
  String get pricingModeUnitPrice => 'Eindaverð';

  @override
  String get pricingModeLineTotal => 'Heildarmagn línu';

  @override
  String get plannedPriceLabel => 'Áætlað verð';

  @override
  String lineTotalCalculated(String value) {
    return 'Heildarmagn línu: $value';
  }

  @override
  String get requiredItemToggle => 'Nauðsynleg vara';

  @override
  String get maxPriceLabel => 'Hámarksverð sem er ásættanlegt (valfrjálst)';

  @override
  String get itemNoteLabel => 'Athugasemd (valfrjálst)';

  @override
  String get categoryProduce => 'Ávextir & grænmeti';

  @override
  String get categoryDairy => 'Mjólkurvörur';

  @override
  String get categoryMeat => 'Kjötvörur';

  @override
  String get categoryBakery => 'Bakarí';

  @override
  String get categoryDrinks => 'Drykkir';

  @override
  String get categoryCleaning => 'Hreinsiefni';

  @override
  String get categoryPersonalCare => 'Persónuleg umhirða';

  @override
  String get categoryHome => 'Heimili';

  @override
  String get categoryOther => 'Annað';

  @override
  String get invalidQuantityError => 'Ógilt magn';

  @override
  String get invalidPriceError => 'Ógilt verð';

  @override
  String get invalidNameError => 'Sláðu inn nafn';

  @override
  String unitPriceCalculated(String value) {
    return 'Einingaverð: $value';
  }

  @override
  String get shoppingTitle => 'Verslunarhamur';

  @override
  String get summaryPlannedTotal => 'Áætlað';

  @override
  String get summaryInCart => 'Í körfu';

  @override
  String get summaryRemainingPlan => 'Afgangur áætlunar';

  @override
  String get summaryProjected => 'Áætlað greiðsla';

  @override
  String get summaryBudgetRemaining => 'Uppstokk eftir';

  @override
  String get summaryBudgetOver => 'Yfir fjárhagsáætlun';

  @override
  String itemsProgress(String done, String total) {
    return '$done af $total vörum';
  }

  @override
  String get filterAll => 'Allar';

  @override
  String get filterToBuy => 'Á að kaupa';

  @override
  String get filterInCart => 'Í körfu';

  @override
  String get filterNotFound => 'Ekki fundist';

  @override
  String get filterRequired => 'Nauðsynlegar';

  @override
  String get quickEntryTitle => 'Raunverulegt verð';

  @override
  String get actualQuantityLabel => 'Raunveruleg magn';

  @override
  String get actualPriceLabel => 'Raunverulegt verð';

  @override
  String get discountLabel => 'Afsláttur (valfrjálst)';

  @override
  String get alternativeNameLabel => 'Heiti áskiptavöru (valfrjálst)';

  @override
  String get savePurchaseButton => 'Bæta í körfu';

  @override
  String get unplannedAddButton => 'Bæta óáætluðri vöru við';

  @override
  String get statusPending => 'Ekki tekið';

  @override
  String get statusInCart => 'Í körfu';

  @override
  String get statusNotFound => 'Ekki fundist';

  @override
  String get statusGaveUp => 'Hætt við';

  @override
  String get statusAlternative => 'Skipt var út';

  @override
  String get keepScreenAwake => 'Halda skjá kveiknum';

  @override
  String get finishShopping => 'Ljúka verslun';

  @override
  String get completionWarning =>
      'Vantar eða óstaðfestar færslur. Þú getur samt lokið; niðurstaðan mun vísa til þeirra.';

  @override
  String get continueShoppingButton => 'Halda áfram að versla';

  @override
  String get resultTitle => 'Niðurstaða';

  @override
  String get summarySection => 'Samantekt';

  @override
  String get plannedTotalLabel => 'Áætlað heildarverð';

  @override
  String get actualTotalLabel => 'Raunverulegt heildarverð';

  @override
  String get varianceLabel => 'Munur';

  @override
  String get varianceNotComputable => 'Ekki hægt að reikna';

  @override
  String get budgetStatusLabel => 'Fjárhagsáætlun';

  @override
  String get savingsLabel => 'Undir áætlun';

  @override
  String get overspendLabel => 'Yfir áætlun';

  @override
  String get unplannedTotalLabel => 'Óáætlað heildarverð';

  @override
  String get unpurchasedLabel => 'Áætlað en ekki keypt';

  @override
  String get totalDiscountLabel => 'Samtals afsláttur';

  @override
  String get accuracyLabel => 'Nákvæmni áætlanar';

  @override
  String get groupsSection => 'Vörur';

  @override
  String get groupPricier => 'Dýrari en áætlað';

  @override
  String get groupCheaper => 'Ódýrari en áætlað';

  @override
  String get groupClose => 'Nærri áætlun';

  @override
  String get groupNotTaken => 'Áætlað, ekki keypt';

  @override
  String get groupUnplanned => 'Keypt án áætlunar';

  @override
  String get groupQuantityChanged => 'Magn breytt';

  @override
  String get groupUnverified => 'Ekki staðfest';

  @override
  String get plannedQtyLabel => 'Áætlað magn';

  @override
  String get actualQtyLabel => 'Raunverulegt magn';

  @override
  String get plannedUnitPriceLabel => 'Áætlað einingaverð';

  @override
  String get actualUnitPriceLabel => 'Raunverulegt einingaverð';

  @override
  String get lineVarianceLabel => 'Línusamdráttur';

  @override
  String get discountEffectLabel => 'Áhrif afsláttar';

  @override
  String get notBoughtMark => 'ekki keypt';

  @override
  String get noPurchasesNote => 'Engin kaup voru skráð.';

  @override
  String get navHome => 'Heim';

  @override
  String get navLists => 'Listar';

  @override
  String get navHistory => 'Ferill';

  @override
  String get navSettings => 'Stillingar';

  @override
  String get homeEmptyTitle => 'Skipuleggðu innkaupin þín';

  @override
  String get homeEmptyBody =>
      'Búðu til fyrsta listann og berðu saman áætlaðar og raunverulegar kostnaðarmörk.';

  @override
  String get homeActiveSection => 'Virkir listar';

  @override
  String get homeCompletedSection => 'Nýlega lokið';

  @override
  String get homeMonthlySection => 'Þessi mánuður';

  @override
  String get monthPlannedLabel => 'Áætlað';

  @override
  String get monthActualLabel => 'Raunverulegt';

  @override
  String get monthVarianceLabel => 'Munur';

  @override
  String get continueShoppingLabel => 'Halda áfram að versla';

  @override
  String get historyEmpty =>
      'Engin lokin innkaup ennþá. Ferillinn þinn og greiningar birtast hér.';

  @override
  String get aboutTabTitle => 'Um NShoptor';

  @override
  String get aboutBody =>
      'NShoptor af Crazy Penguin. Ófært innkaupasjálfstætt. Leyfisveitt undir GPL-3.0.';

  @override
  String get startShoppingLabel => 'Byrja að versla';

  @override
  String get finishAndSeeResult => 'Ljúka & sjá niðurstöðu';

  @override
  String get settingsTitle => 'Stillingar';

  @override
  String get languageLabel => 'Tungumál';

  @override
  String get languageSystem => 'Kerfi';

  @override
  String get languageTr => 'Tyrkneska';

  @override
  String get languageEn => 'Enska';

  @override
  String get themeLabel => 'Þema';

  @override
  String get themeSystem => 'Kerfi';

  @override
  String get themeLight => 'Ljóst';

  @override
  String get themeDark => 'Dökkt';

  @override
  String get defaultCurrencyLabel => 'Gildismynt';

  @override
  String get defaultUnitLabel => 'Eining';

  @override
  String get keepAwakeLabel => 'Halda skjánum kveiktum á meðan verslað er';

  @override
  String get backupSection => 'Öryggisafrit';

  @override
  String get exportBackupLabel => 'Flytja út öryggisafrit';

  @override
  String get importBackupLabel => 'Flytja inn öryggisafrit';

  @override
  String get mergeImportLabel => 'Sameina við núverandi gögn';

  @override
  String get separateImportLabel => 'Flytja inn sem sjálfstæða afrit';

  @override
  String get importCancelled => 'Innflutningi hafnað.';

  @override
  String get backupExported => 'Öryggisafrit flutt út með góðum árangri.';

  @override
  String get deleteAllSection => 'Hættusvæði';

  @override
  String get deleteAllLabel => 'Eyða öllum gögnum';

  @override
  String get deleteAllConfirm =>
      'Þetta fjarlægir alla lista, feril, kvittunarmyndir og verð. Skrár sem þú hefur flutt út eru á drifinu þínu. Halda áfram?';

  @override
  String get deleteAllConfirm2 =>
      'Ertu alveg viss? Þessa aðgerð er ekki hægt að afturkalla.';

  @override
  String get cancelAction => 'Hætta við';

  @override
  String get confirmDelete => 'Eyða varanlega';

  @override
  String get dataDeleted => 'Öll staðbundin gögn voru eydd.';

  @override
  String get privacyInfoLabel => 'Persónuvernd';

  @override
  String get privacyInfoBody =>
      'Listarnir þínir, verð, kvittanir og myndir eru vistuð á tækinu þínu. Röddin yfirgefur það aldrei. Þegar AI aðstoð er virk eru myndir af kvittunum og verðmiðum (minnkaðar) og texti, svo sem atriði sem þú talar inn, send á netþjóninn okkar eingöngu til lestrar; þetta er unnið strax og aldrei vistað.';

  @override
  String get aboutSection => 'Um';

  @override
  String get aboutPublisher => 'Útgefandi: Crazy Penguin';

  @override
  String get aboutLicenses => 'Leyfi (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Raddinntak';

  @override
  String get voiceStatusUnknown => 'Þjónusta: ekki athugað';

  @override
  String get permissionsLabel => 'Réttindi';

  @override
  String get permissionsBody =>
      'Myndavél, hljóðnemi og tilkynningar eru beðið aðeins þegar þú notar þessar eiginleika raunverulega.';

  @override
  String get unitsSection => 'Sjálfgefið';

  @override
  String get roundingNote =>
      'Peningaumbreyting fylgir einni reglu: helmingar eru hringjaðir frá núlli, einu sinni við peningaumbreytingu.';

  @override
  String get voiceInputTitle => 'Raddinntak';

  @override
  String get voiceStartListening => 'Byrja að hlusta';

  @override
  String get voiceTranscriptLabel => 'Texti';

  @override
  String get parseAction => 'Greina';

  @override
  String get receiptReviewTitle => 'Yfirferð kvittunar';

  @override
  String get receiptTotal => 'Heildarverð á kvittun';

  @override
  String get receiptTotalUnknown => 'Heildarverð greindist ekki';

  @override
  String get receiptDiff => 'Munur';

  @override
  String get acceptLine => 'Samþykkja línu';

  @override
  String get ignoreLine => 'Hunsa línu';

  @override
  String get receiptLineActions => 'Tengja við vöru, skipta eða hunsa';

  @override
  String get receiptCommit => 'Samþykkja allt';

  @override
  String get receiptCommitted => 'Kvittun notuð.';

  @override
  String get priceHistoryTitle => 'Verðsaga';

  @override
  String get noObservations => 'Engin verðathuganir ennþá';

  @override
  String get templatesSection => 'Sniðmát';

  @override
  String get templateHint => 'Búa til nýjan lista frá fyrri innkaupum';

  @override
  String get scanReceiptAction => 'Skanna kvittun';

  @override
  String get fromReceiptListButton => 'Úr kvittun';

  @override
  String get shelfLabelAction => 'Verð úr hillumerki';

  @override
  String get priceCandidatesTitle => 'Verðtilbúnaðir';

  @override
  String get noPriceCandidates =>
      'Ekkert verð fannst; sláðu það inn handvirkt.';

  @override
  String get voiceUnavailable => 'Talgreining ótiltæk; sláðu inn handvirkt.';

  @override
  String get linkToItem => 'Tengja við vöru';

  @override
  String get splitLine => 'Skipta í tvo';

  @override
  String get mergeWithNext => 'Sameina við næstu';

  @override
  String get ocrNoText => 'Enginn texti lesinn; reyndu aftur.';

  @override
  String get priceHistoryAction => 'Verðsaga';

  @override
  String get itemsEmptyTitle => 'Engar vörur ennþá';

  @override
  String get itemsEmptyBody =>
      'Bættu við fyrstu vörunni — þú munt slá inn raunverulegt verð hér í versluninni.';

  @override
  String get addItemTooltip => 'Bæta við vöru';

  @override
  String get unitAdet => 'stk';

  @override
  String get unitKilogram => 'kg';

  @override
  String get unitGram => 'g';

  @override
  String get unitLitre => 'L';

  @override
  String get unitMililitre => 'ml';

  @override
  String get unitPaket => 'pakki';

  @override
  String get unitKutu => 'kassi';

  @override
  String get unitSise => 'flaska';

  @override
  String get unitKavanoz => 'glös';

  @override
  String get unitDemet => 'bundinn';

  @override
  String get unitDuzine => 'dósín';

  @override
  String get unitMetre => 'm';

  @override
  String get unitCustom => 'Sérsniðið';

  @override
  String get setReminderAction => 'Setja áminningu';

  @override
  String get reminderPermissionDenied =>
      'Stillingar fyrir tilkynningar eru nauðsynlegar fyrir áminningar. Þú getur virkjað þær í kerfisstillingum.';

  @override
  String get reminderScheduled => 'Áminning sett.';

  @override
  String get reminderCancelled => 'Áminning fjarlægð.';

  @override
  String get reminderTitle => 'Innkaupaáminning';

  @override
  String reminderBody(Object title) {
    return 'Tími til að skoða listann: $title';
  }

  @override
  String get reminderPickDate => 'Veldu dagsetningu';

  @override
  String get reminderPickTime => 'Veldu tíma';

  @override
  String get itemDetailsSection => 'Upplýsingar';

  @override
  String get priceOptionalHint =>
      'Valfrjálst — þú munt slá inn raunverulegt verð í versluninni';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Áætlað: $total · $count vörur';
  }

  @override
  String get proActiveLabel => 'Pro virkt — takk!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Engar auglýsingar · Bakgrunnshermt og innflutningur · Árlega';

  @override
  String get proBenefitNoAds => 'Auglýsingalaust upplifun';

  @override
  String get proBenefitBackup => 'Öryggisafrit (flytja út/inn)';

  @override
  String aboutVersion(Object version) {
    return 'Útgáfa $version';
  }

  @override
  String get navDiscover => 'Uppgötva';

  @override
  String get shareAction => 'Deila forritinu';

  @override
  String get rateAction => 'Gefa okkur einkunn';

  @override
  String get aboutOpenRow => 'Um & opinn kóða';

  @override
  String get voiceAddItemAction => 'Bæta við með tali';

  @override
  String get formatLocaleLabel => 'Tölur og gjaldmiðill';

  @override
  String get formatLocaleSystem =>
      'Tæki stillt (Latneskir tölustafir; annars enska)';

  @override
  String get formatLocaleTr => 'Tyrkneska (1.234,56)';

  @override
  String get formatLocaleEn => 'Enska (1,234.56)';

  @override
  String get aiToggleTitle => 'AI aðstoð';

  @override
  String get aiToggleSubtitle =>
      'Les kvittanir og verðmiða úr myndum, passar saman kvittanir og breytir setningum í lista. Myndir eru sendar eingöngu til lestrar og aldrei vistaðar.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Þú hefur nýtt þessa mánaðarlegu AI beiðni ($used/$limit). Uppfærðu til að fá fleiri eða halda áfram án AI.';
  }

  @override
  String get aiOffline => 'Engin tenging — heldur áfram án AI.';

  @override
  String get aiFailed => 'AI er ekki tiltæk núna — heldur áfram án hennar.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'Tæki';

  @override
  String get quickListAction => 'Bæta við úr setningu';

  @override
  String get quickListTitle => 'Fljótur listi';

  @override
  String get quickListHint => 't.d. 1 kg epli 20, 2 brauð, há kilo af osti';

  @override
  String get quickListConvert => 'Breyta í lista';

  @override
  String quickListAdd(int count) {
    return 'Bæta $count atriðum við';
  }

  @override
  String get quickListEmpty =>
      'Engin atriði fundust. Reyndu að telja þau upp með kommum aðskild.';

  @override
  String get receiptAiMatched =>
      'AI fann kvittunina og tengdi henni listann þinn. Athugaðu tengingin og staðfestu.';

  @override
  String get receiptNeedsCheck => 'Athugaðu þessa tengingu';

  @override
  String get receiptDiscountLine => 'Afsláttur';

  @override
  String get compareItem => 'Atriði';

  @override
  String get compareEstimated => 'Áætlað';

  @override
  String get compareActual => 'Raunverulegt';

  @override
  String get compareDiff => 'Munur';

  @override
  String get compareTotal => 'Samtals';

  @override
  String get compareBudget => 'Fjárhagsáætlun';

  @override
  String get compareNotBought => 'ekki keypt';

  @override
  String get compareUnplanned => 'ekki áætlað';

  @override
  String get pricierItems => 'Dýrari';

  @override
  String get cheaperItems => 'Ódýrari';

  @override
  String get compareAction => 'Bera saman';

  @override
  String get detailsSection => 'Upplýsingar';

  @override
  String get spendingTitle => 'Gjöld';

  @override
  String get spendingAction => 'Gjöld';

  @override
  String get spendingMonthTotal => 'Þessi mánuður';

  @override
  String get spendingWeekly => 'Vikuleg gjöld';

  @override
  String get spendingMonthly => 'Mánaðarleg gjöld';

  @override
  String get monthlyLimitTitle => 'Mánaðarlegur takmarkun';

  @override
  String get monthlyLimitHelp => 'Hversu mikið viltu eyða í innkaup á mánuði?';

  @override
  String get monthlyLimitRemove => 'Fjarlægja';

  @override
  String get monthlyLimitSet => 'Setja';

  @override
  String get monthlyLimitChange => 'Breyta';

  @override
  String get monthlyLimitNone =>
      'Settu mánaðarlega takmörkun til að sjá hversu mikið eftir er.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount yfir takmarkanina';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return '$amount eftir í þessum mánuði';
  }

  @override
  String get plansTitle => 'Pakkar';

  @override
  String get plansHeadline => 'Kaupa snarpailega með AI';

  @override
  String get plansSubhead =>
      'Kvittunasamsvörun, verðmiðar og listar úr setningu. Hæft hvenær sem er.';

  @override
  String get plansMonthly => 'Mánaðarlega';

  @override
  String get plansYearly => 'Árlega';

  @override
  String get planFree => 'Ókeypis';

  @override
  String get planFreePrice => 'Alltaf ókeypis';

  @override
  String get planFreeAi => '10 AI beiðnir á mánuði';

  @override
  String get planFreeAds => 'Lítillar auglýsingar (engrar fyrstu 7 dagana)';

  @override
  String get planCoreFeatures => 'Listar, verð, kvittanir, gjaldagrafar';

  @override
  String get plansPerYear => '/ ár';

  @override
  String get plansPerMonth => '/ mánuður';

  @override
  String get planTrial => 'Ókeypis prufuáskrift';

  @override
  String get planProAi => '100 AI beiðnir á mánuði';

  @override
  String get planNoAds => 'Engar auglýsingar';

  @override
  String get planBackup => 'Bakgrunnshermt og innflutningur';

  @override
  String get planMaxAi => '300 AI beiðnir á mánuði';

  @override
  String get planMaxFamily => 'Fyrir stórfjölskylduverslun';

  @override
  String get plansStoreUnavailable =>
      'Verslunin er ekki til staðar í augnablikinu.';

  @override
  String get retryAction => 'Reyna aftur';

  @override
  String get plansPurchaseFailed =>
      'Kaupið tókst ekki. Vinsamlegast reyndu aftur.';

  @override
  String get plansRestore => 'Endurheimta kaup';

  @override
  String get plansLegal =>
      'Pro endurnýjast sjálfkrafa á hverju ári þar til áskriftinni er sagt upp og inniheldur 100 gervigreindarbeiðnir á mánuði. Grunnverðið er 1 Bandaríkjadalur á ári fyrir viðeigandi skatta; athugaðu endanlegt staðbundið verð og skatta í versluninni áður en þú staðfestir kaup. Stjórnaðu áskriftinni eða segðu henni upp í Google Play.';

  @override
  String get planCurrent => 'Núverandi';

  @override
  String get planStartTrial => 'Hefja ókeypis prufuáskrift';

  @override
  String get planChoose => 'Veldu';

  @override
  String get plansAction => 'Pakkar: Pro';

  @override
  String get assistantTitle => 'Aðstoðarmaður';

  @override
  String get assistantGreeting => 'Halló! Hvað viltu gera?';

  @override
  String get assistantNewList => 'Nýr listi';

  @override
  String get assistantVoiceList => 'Listi með rödd';

  @override
  String get assistantTextList => 'Listi úr setningu';

  @override
  String get assistantScanReceipt => 'Skanna kvittun';

  @override
  String get assistantSpending => 'Útgjöld mín';

  @override
  String get assistantReceiptHint =>
      'Opnaðu listann þinn og ýttu á kvittunartáknið til að skanna hann.';

  @override
  String get assistantToggleTitle => 'Sýna aðstoðarmann';

  @override
  String get assistantToggleSubtitle => 'Líti hjálparmaðurinn neðst til hægri';

  @override
  String get scanPriceLabel => 'Skanna verðmerki';

  @override
  String get saveFailed =>
      'Gat ekki vistað. Breytingarnar þínar eru enn til staðar. Vinsamlegast reyndu aftur.';

  @override
  String get deleteItemConfirm => 'Eyða þessu atriði og skráðum kaupum?';

  @override
  String get clearPurchaseConfirm =>
      'Fjarlægja merkið frá þessu atriði og eyða skráðum kaupum?';

  @override
  String get reportPdfAction => 'Vista PDF skýrslu';

  @override
  String get reportNotInvoice =>
      'Yfirlit yfir innkaup, ekki skattreikning. Skattprósentur eru óþekktar.';

  @override
  String get purchaseVisits => 'Innkaupasjón';

  @override
  String get purchaseInterval => 'Meðaldagabil á milli innkaupa';

  @override
  String get purchasedQuantity => 'Magn keypt';

  @override
  String get purchaseAnalyticsHint =>
      'Innkaup mæla ekki neyslu. Gjaldmiðlar og einingar eru sýndir aðskild.';

  @override
  String get receiptReplaces =>
      'Vörur án verðs eru fylltar út. Vörur með markaðsverð bætast við sem aðskilin kaup.';

  @override
  String get receiptIncompleteHeader =>
      'Hafðu verslun, dagsetningu, tíma og kvittunarnúmer með á næstu mynd.';

  @override
  String get receiptIncompleteTail =>
      'Taktu mynd af næsta hluta með nokkrum vörum sem skarast og lokaupphæðinni.';

  @override
  String get receiptContinuationRejected =>
      'Ekki tókst að sameina þessa mynd. Taktu hana aftur með vörum úr sömu kvittun sem skarast.';

  @override
  String get receiptDraftSaved =>
      'Kvittunin var vistuð sem drög. Þú getur haldið áfram síðar.';

  @override
  String get receiptContinueAction => 'Halda áfram með kvittun';

  @override
  String get receiptDraftsTitle => 'Ókláraðar kvittanir';

  @override
  String get receiptDuplicate => 'Þessari kvittun hefur þegar verið bætt við.';

  @override
  String get receiptTotalMismatch =>
      'Vörurnar stemma ekki við heildarupphæð kvittunarinnar. Athugaðu hvort kvittunin sjáist öll.';

  @override
  String get receiptSaveDraftAction => 'Vista síðar';

  @override
  String get receiptResolveLines =>
      'Samþykktu eða hunsaðu hverja vöru áður en þú vistar.';

  @override
  String get receiptPartialConfirm =>
      'Aðeins valdar vörur verða bættar við. Þessi kvittun verður merkt sem innflutt. Halda áfram?';

  @override
  String get voiceUnsupportedLanguage =>
      'Þetta tungumál er ekki tiltækt fyrir raddinntak á þessu tæki. Þú getur skrifað í staðinn.';

  @override
  String get voiceStopListening => 'Hætta að hlusta';

  @override
  String get keepAwakeFailed =>
      'Gat ekki haldið skjánum vakandi. Vinsamlegast reyndu aftur.';

  @override
  String get purchaseHistoryHint =>
      'Allar fullunnar innkaup. Endurheimt dregur úr heildarverði. Dagar vísa til lokunar innkaupa. Eitt ferð er ekki nóg til að reikna út meðalfjöldi.';

  @override
  String get planLegacyRights =>
      'Núverandi Pro og Max áskriftir halda upprunalegum mánaðarlegum fjölda gervigreindarbeiðna.';

  @override
  String get csvExportAction => 'Flytja út CSV';

  @override
  String get reportSharePdf => 'Deila sem PDF';

  @override
  String get reportShareCsv => 'Deila sem CSV';

  @override
  String get reportPrintAction => 'Prenta';

  @override
  String get backupSizeWarning =>
      'JSON inniheldur skrár, ekki ljósmyndaskrár. Innflutningstakmörk: 16 MB.';

  @override
  String get backupImportFailed =>
      'Gat ekki flutt inn þessa afritun. Gögnin þín voru ekki breytt.';

  @override
  String get backupImported => 'Afhending varð successfully.';

  @override
  String backupPreviewCounts(Object entries, Object items, Object lists) {
    return '$lists listar · $items vörur · $entries kaup';
  }

  @override
  String get voiceModelDownloading =>
      'Verið er að sækja raddlíkanið fyrir þetta tungumál. Reyndu aftur eftir mínútu.';

  @override
  String get historyThisWeek => 'Þessi vika';

  @override
  String get historyProductsSection => 'Keyptar vörur';

  @override
  String get tipReceiptScan =>
      'Skannaðu kvittun til að bera saman verðin við listann þinn';

  @override
  String get tipVoiceAdd =>
      'Segðu einn eða fleiri hluti og skoðaðu þá áður en þú bætir þeim við';

  @override
  String get tipShelfCamera => 'Lestu verðið af hillumerkinu með myndavélinni';

  @override
  String get tipPlan =>
      'Áskriftin þín: skoðaðu upplýsingar, gerðu áskrift eða uppfærðu';

  @override
  String get guideAddBody =>
      'Ýttu á + til að bæta við hlut. Settu inn áætlað verð núna og markaðsverð við kassann.';

  @override
  String get guideVoiceBody =>
      'Ýttu á hljóðnemann og segðu hlutina, til dæmis: \'1 kíló epli, 1 brauð\'.';

  @override
  String get guideReceiptBody =>
      'Skannaðu kvittun til að para verðin við hlutina á listanum þínum.';

  @override
  String get guidePlanBody =>
      'Ýttu á áskriftartáknið til að sjá áskriftina, gerast áskrifandi eða uppfæra.';

  @override
  String get guideNext => 'OK';

  @override
  String get guideDone => 'Byrja';

  @override
  String get paletteLabel => 'Litaþema';

  @override
  String get paletteForest => 'Skógur';

  @override
  String get paletteOcean => 'Haf';

  @override
  String get paletteSunset => 'Sólsetur';

  @override
  String get paletteLavender => 'Lavender';

  @override
  String get darkBlackLabel => 'Alsvart í dökku þema';

  @override
  String get spendingOverview => 'Yfirlit';

  @override
  String get spendingThisYear => 'Þetta ár';

  @override
  String get spendingYearly => 'Árleg útgjöld';

  @override
  String get productSpending => 'Útgjöld eftir vöru';

  @override
  String get spanWeek => 'Vika';

  @override
  String get spanMonth => 'Mánuður';

  @override
  String get spanYear => 'Ár';

  @override
  String get weeklyLimitTitle => 'Vikumörk';

  @override
  String get weeklyLimitHelp => 'Hve miklu viltu eyða í innkaup á viku?';

  @override
  String get weeklyLimitNone => 'Settu vikumörk til að sjá hvað er eftir.';

  @override
  String weeklyLimitLeft(String amount) {
    return '$amount eftir í þessari viku';
  }

  @override
  String get shoppingLimitTitle => 'Mörk á hver innkaup';

  @override
  String get shoppingLimitHelp => 'Nýir listar byrja með þessu fjárhagsáætlun.';

  @override
  String get shoppingLimitNone =>
      'Settu sjálfgefna fjárhagsáætlun fyrir hver ný innkaup.';

  @override
  String get monthlyReportAction => 'Mánaðarskýrsla';

  @override
  String get reportShoppingColumn => 'Innkaup';

  @override
  String get reportDateColumn => 'Dagsetning';

  @override
  String get planUnavailable => 'Ekki í boði í versluninni núna';

  @override
  String get demoDataTitle => 'Sýnigögn';

  @override
  String get demoDataLoad => 'Prófa með sýnigögnum';

  @override
  String get demoDataLoadHelp =>
      'Bætir við 12 mánuðum af sýnikaupum svo þú sjáir sögu, gröf og verðsögu.';

  @override
  String get demoDataRemove => 'Fjarlægja sýnigögn';

  @override
  String get demoDataAdded => 'Sýnigögnum bætt við';

  @override
  String get demoDataRemoved => 'Sýnigögn fjarlægð';

  @override
  String get demoProductApple => 'Epli';

  @override
  String get demoProductBread => 'Brauð';

  @override
  String get demoProductMilk => 'Mjólk';

  @override
  String get demoProductCheese => 'Ostur';

  @override
  String get demoProductTomato => 'Tómatar';

  @override
  String get demoProductEggs => 'Egg';

  @override
  String get demoProductCoffee => 'Kaffi';

  @override
  String get demoProductDetergent => 'Þvottaefni';

  @override
  String get sendAction => 'Send';

  @override
  String get previousMonthAction => 'Previous month';

  @override
  String get nextMonthAction => 'Next month';

  @override
  String get helpSection => 'Hjálp og aðstoð';

  @override
  String get howToUseLabel => 'Notkunarleiðbeiningar';

  @override
  String get guidePricesBody =>
      'Verslunarverð merkir vöruna sem keypta; 0 gildir líka. Verð heima er valfrjálst. Eyddu verslunarverðinu til að fjarlægja hakið.';

  @override
  String get shoppingDateLabel => 'Innkaupadagur';

  @override
  String get shoppingDateNone => 'Engin dagsetning valin';

  @override
  String get clearShoppingDateAction => 'Fjarlægja dagsetningu';

  @override
  String get listSortLabel => 'Röð lista';

  @override
  String get listSortDate => 'Innkaupadagur';

  @override
  String get listSortAz => 'Nafn (A–Ö)';

  @override
  String get listSortManual => 'Handvirk röð';

  @override
  String get imageCameraAction => 'Taka mynd';

  @override
  String get imageGalleryAction => 'Velja úr myndum';

  @override
  String get imageCaptureFailed =>
      'Ekki tókst að opna myndavélina eða myndirnar. Athugaðu aðgangsheimild og reyndu aftur.';

  @override
  String get imageRecognitionFailed =>
      'Ekki tókst að vinna úr myndinni. Prófaðu aðra mynd.';

  @override
  String get receiptNoProducts =>
      'Textinn var lesinn en engar vörur fundust á kvittuninni. Láttu vörurnar og heildarupphæðina sjást á myndinni.';

  @override
  String get keepAwakeOn => 'Skjárinn helst kveiktur';

  @override
  String get keepAwakeOff => 'Slökkt getur orðið á skjánum';

  @override
  String get spanDay => 'Dagur';

  @override
  String get spanCustom => 'Dagsetningabil';

  @override
  String get reportTotalSpent => 'Samtals eytt';

  @override
  String get reportAddedAt => 'Bætt við';

  @override
  String get reportReceiptNumber => 'Númer kvittunar';

  @override
  String get reportPreview => 'Forskoðun';

  @override
  String get reportShareAction => 'Deila';

  @override
  String get previousPeriodAction => 'Fyrra tímabil';

  @override
  String get nextPeriodAction => 'Næsta tímabil';

  @override
  String get reportSaved => 'Skýrsla vistuð.';

  @override
  String get reportZoom => 'Aðdráttur';

  @override
  String planTrialDaysLeft(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dagar eftir',
      few: '$days dagar eftir',
      one: '$days dagur eftir',
    );
    return '$_temp0';
  }

  @override
  String planTrialHoursLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours klukkustundir eftir',
      few: '$hours klukkustundir eftir',
      one: '$hours klukkustund eftir',
    );
    return '$_temp0';
  }

  @override
  String get planTrialEndedTitle => 'Pro-prufutímabilinu þínu er lokið';

  @override
  String get planTrialEndedBody =>
      'Þú getur áfram notað lista, handvirka innsláttar og tal á tækinu þér að kostnaðarlausu. Ókeypis áskrift inniheldur 10 AI-beiðnir á almanaksmánuði. Veldu árlegt Pro fyrir 100 AI-beiðnir á mánuði, engar auglýsingar og afrit. Gögnin þín haldast hjá þér.';

  @override
  String get planContinueFree => 'Halda áfram ókeypis';

  @override
  String get supportIdLabel => 'Auðkenni þjónustuvers';

  @override
  String get supportEmailLabel => 'Þjónustuaðstoð í tölvupósti';

  @override
  String get captureTipFirst =>
      'Byrjaðu efst: nafn verslunar og dagsetning þurfa að sjást. Taktu með eins margar vörur og þú getur; restin fer á næstu mynd.';

  @override
  String get captureTipContinue =>
      'Sama kvittun: hafðu síðustu vöruna af fyrri mynd með.';

  @override
  String get captureTipNeverShow => 'Ekki sýna aftur';

  @override
  String get captureTipOk => 'Skilið';

  @override
  String get captureTipsSetting => 'Sýna ráð til að mynda kvittun';

  @override
  String get receiptReadingProgress => 'Les kvittun…';

  @override
  String get receiptReadInBackground => 'Halda áfram í bakgrunni';

  @override
  String get receiptReadDoneTitle => 'Kvittun lesin';

  @override
  String get receiptReadDoneBody => 'Ýttu til að yfirfara og vista.';

  @override
  String get receiptReadMoreTitle => 'Taktu mynd af restinni af kvittuninni';

  @override
  String get receiptReadFailedTitle => 'Ekki tókst að lesa kvittunina';

  @override
  String get listReceiptsSection => 'Kvittanir';

  @override
  String get receiptStateComplete => 'Lokið';

  @override
  String get receiptStateIncomplete => 'Ófullgerð';

  @override
  String get receiptStateFailed => 'Mistókst';

  @override
  String get receiptStoreUnknown => 'Verslun ekki lesin';

  @override
  String get receiptDeleteAction => 'Eyða kvittun';

  @override
  String get receiptDeleteConfirm =>
      'Eyða þessari kvittun og vörunum sem hún bætti við? Þú getur flutt hana inn aftur síðar.';

  @override
  String get receiptDeleted => 'Kvittun eytt.';

  @override
  String listReceiptsShowAll(int count) {
    return 'Sýna allt ($count)';
  }

  @override
  String get listReceiptsShowLess => 'Sýna minna';

  @override
  String receiptDateLabel(String date) {
    return 'Dagsetning kvittunar: $date';
  }

  @override
  String get historyViewShopping => 'Eftir innkaupum';

  @override
  String get historyViewStore => 'Eftir verslun';

  @override
  String get historyViewProduct => 'Eftir vöru';

  @override
  String get historyShareAll => 'Deila öllu';

  @override
  String get historyUnknownStore => 'Óþekkt verslun';

  @override
  String get historyDailySpending => 'Dagleg útgjöld';

  @override
  String get historyResetPeriod => 'Aftur í þessa viku';

  @override
  String get tourSkip => 'Sleppa';

  @override
  String get tourNewListBody =>
      'Byrjaðu innkaupalista og bættu við því sem þú ætlar að kaupa.';

  @override
  String get tourFromReceiptBody =>
      'Búin(n) að versla? Breyttu kvittun í lista með verðum.';

  @override
  String get tourReceiptFlowBody =>
      'Byrjaðu efst á kvittuninni: fyrst verslun og dagsetningu, haltu svo áfram með restina af línunum.';

  @override
  String get tourTabsBody =>
      'Skiptu á milli virkra, lokinna og safnaðra lista. Hnappurinn í lokin breytir röðinni.';

  @override
  String get tourDiscoverBody => 'Sjáðu fleiri öpp frá sama forritara.';

  @override
  String get tourHelpBody =>
      'Ýttu hér til að sjá leiðarvísinn aftur. Opnaðu lista til að fá útskýringu á samtölum og vörum.';

  @override
  String get tourTotalsBody =>
      'Áætluð, raunveruleg samtala og mismunur uppfærast meðan þú verslar.';

  @override
  String get tourItemsBody =>
      'Vörurnar þínar. Breyttu röðinni eða leitaðu að þeim hér.';

  @override
  String budgetAlertNear(String percent) {
    return '$percent% af mörkunum notuð';
  }
}
