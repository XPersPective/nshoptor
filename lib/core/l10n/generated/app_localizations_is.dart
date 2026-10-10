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
  String get backupSizeWarning =>
      'Stórt öryggisafrit: skráin getur verið stór. Viltu innihalda einnig myndir?';

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
      'Listarnir þínir, verð, kvittanir og myndir geymast á tækinu þínu. Myndir og rödd yfirgefa aldrei tækið. Þegar AI-hjálp er virk, er aðeins texta (til dæmis línur frá kvittun eða það sem þú sagðir) sent til okkar netþjóns til vinnslu og er ekki geymt.';

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
      'Engar auglýsingar, meira AI, öryggisafrit · frá lítilli mánaðargjaldi';

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
      'Samanburður við kvittanir, lestur verðmiða og breyting setninga í lista. Myndir og rödd eru á tækinu þínu; aðeins texti er vinnslinn.';

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
  String get planFreeAi => '15 AI beiðnir á mánuði';

  @override
  String get planFreeAds => 'Lítillar auglýsingar (engrar fyrstu 7 dagana)';

  @override
  String get planCoreFeatures => 'Listar, verð, kvittanir, gjaldagrafar';

  @override
  String get plansPerYear => '/ ár';

  @override
  String get plansPerMonth => '/ mánuður';

  @override
  String get planTrial => '7 dagar ókeypis';

  @override
  String get planProAi => '200 AI beiðnir á mánuði';

  @override
  String get planNoAds => 'Engar auglýsingar';

  @override
  String get planBackup => 'Bakgrunnshermt og innflutningur';

  @override
  String get planMaxAi => '1000 AI beiðnir á mánuði';

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
  String get planLifetimeTitle => 'Auglýsingalaust fyrir ævi';

  @override
  String get planLifetimeSubtitle =>
      'Einu sinnis greiðsla: engar auglýsingar, bakgrunnsherm; AI heldur áfram að vera ókeypis';

  @override
  String get plansRestore => 'Endurheimta kaup';

  @override
  String get plansLegal =>
      'Áskriftir endurnýjast sjálfkrafa þar til hætt er við þær. Hægt er að hætta hvenær sem er í Google Play › Greiðslur og áskriftir. Verð inniheldur skatta sýnda af Google Play.';

  @override
  String get planCurrent => 'Núverandi';

  @override
  String get planStartTrial => 'Byrja 7 daga ókeypis prófun';

  @override
  String get planChoose => 'Veldu';

  @override
  String get plansAction => 'Áskriftir: Pro og Max';

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
      'Línur tengd kvittingu koma í stað núverandi kaupa; ótengdar línur eru bættar við.';

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
}
