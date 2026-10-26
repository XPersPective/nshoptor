// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Gujarati (`gu`).
class AppLocalizationsGu extends AppLocalizations {
  AppLocalizationsGu([String locale = 'gu']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'ઘરેથી યોજના બનાવો. યોજના મુજબ શોપિંગ કરો.';

  @override
  String get listsTitle => 'લિસ્ટ્સ';

  @override
  String get listsTabActive => 'સક્રિય';

  @override
  String get listsTabCompleted => 'પૂર્ણ';

  @override
  String get listsTabArchived => 'આર્કાઇવ';

  @override
  String get newListButton => 'નવી લિસ્ટ';

  @override
  String get listTitleHint => 'ટાઈટલ (વૈકલ્પિક)';

  @override
  String get saveButton => 'સેવ કરો';

  @override
  String get cancelButton => 'રદ કરો';

  @override
  String get deleteButton => 'ડિલીટ કરો';

  @override
  String get editAction => 'એડિટ';

  @override
  String get listDeleted => 'લિસ્ટ ડિલીટ થઈ ગઈ';

  @override
  String get invalidAmountError => 'અમાઉન્ટ અમાન્ય છે';

  @override
  String get duplicateAction => 'ડુપ્લિકેટ';

  @override
  String get archiveAction => 'આર્કાઇવ કરો';

  @override
  String get unarchiveAction => 'આર્કાઇવ હટાવો';

  @override
  String get deleteListConfirm =>
      'શું તમે આ લિસ્ટ ડિલીટ કરવા માંગો છો? તેની યોજનાબદ્ધ વસ્તુઓ પણ દૂર થશે.';

  @override
  String get undoButton => 'અન્ડૂ';

  @override
  String get searchListHint => 'લિસ્ટ્સ શોધો';

  @override
  String get currencyLabel => 'કરન્સી';

  @override
  String get budgetLabel => 'બજેટ (વૈકલ્પિક)';

  @override
  String get noteLabel => 'નોંધ (વૈકલ્પિક)';

  @override
  String get storeLabel => 'સ્ટોર';

  @override
  String get keepAmountsAction => 'અમાઉન્ટ્સ રાખો';

  @override
  String get resetAmountsAction => 'અમાઉન્ટ્સ રીસેટ કરો';

  @override
  String get currencyChangeWarning =>
      'કરન્સી બદલાઈ રહી છે. હાલના અમાઉન્ટ્સ સાથે શું થવું જોઈએ?';

  @override
  String get listsEmpty => 'હજુ કોઈ લિસ્ટ નથી. તમારી પ્રથમ શોપિંગ યોજના બનાવો.';

  @override
  String get statusDraft => 'ડ્રાફ્ટ';

  @override
  String get statusPlanned => 'યોજનાબદ્ધ';

  @override
  String get statusShopping => 'શોપિંગ ચાલુ';

  @override
  String get statusCompleted => 'પૂર્ણ';

  @override
  String get statusArchived => 'આર્કાઇવ';

  @override
  String autoListTitle(String date) {
    return '$date શોપિંગ';
  }

  @override
  String get itemFormTitle => 'વસ્તુ ઉમેરો';

  @override
  String get itemNameLabel => 'વસ્તુનું નામ';

  @override
  String get brandLabel => 'બ્રાન્ડ / વેરિયન્ટ (વૈકલ્પિક)';

  @override
  String get categoryLabel => 'કેટેગરી';

  @override
  String get quantityLabel => 'પ્રમાણ';

  @override
  String get unitLabel => 'યુનિટ';

  @override
  String get pricingModeLabel => 'કિંમત એન્ટ્રી';

  @override
  String get pricingModeUnitPrice => 'યુનિટ કિંમત';

  @override
  String get pricingModeLineTotal => 'લાઈન કુલ';

  @override
  String get plannedPriceLabel => 'યોજનાબદ્ધ કિંમત';

  @override
  String lineTotalCalculated(String value) {
    return 'લાઈન કુલ: $value';
  }

  @override
  String get requiredItemToggle => 'જરૂરી વસ્તુ';

  @override
  String get maxPriceLabel => 'મહત્તમ સ્વીકાર્ય કિંમત (વૈકલ્પિક)';

  @override
  String get itemNoteLabel => 'નોંધ (વૈકલ્પિક)';

  @override
  String get categoryProduce => 'ફળ અને શાકભાજી';

  @override
  String get categoryDairy => 'ડેરી';

  @override
  String get categoryMeat => 'માંસ';

  @override
  String get categoryBakery => 'બેકરી';

  @override
  String get categoryDrinks => 'પીણાં';

  @override
  String get categoryCleaning => 'ક્લીનિંગ';

  @override
  String get categoryPersonalCare => 'પર્સનલ કેર';

  @override
  String get categoryHome => 'હોમ';

  @override
  String get categoryOther => 'અન્ય';

  @override
  String get invalidQuantityError => 'પ્રમાણ અમાન્ય છે';

  @override
  String get invalidPriceError => 'કિંમત અમાન્ય છે';

  @override
  String get invalidNameError => 'નામ દાખલ કરો';

  @override
  String unitPriceCalculated(String value) {
    return 'એકમ કિંમત: $value';
  }

  @override
  String get shoppingTitle => 'શોપિંગ મોડ';

  @override
  String get summaryPlannedTotal => 'યોજનાબદ્ધ';

  @override
  String get summaryInCart => 'કાર્ટમાં';

  @override
  String get summaryRemainingPlan => 'બાકીની યોજના';

  @override
  String get summaryProjected => 'અંદાજિત ચેકઆઉટ';

  @override
  String get summaryBudgetRemaining => 'બજેટ બાકી';

  @override
  String get summaryBudgetOver => 'બજેટ વધુ';

  @override
  String itemsProgress(String done, String total) {
    return '$total માંથી $done આઈટમ્સ';
  }

  @override
  String get filterAll => 'બધા';

  @override
  String get filterToBuy => 'ખરીદવાના';

  @override
  String get filterInCart => 'કાર્ટમાં';

  @override
  String get filterNotFound => 'મળ્યું નહીં';

  @override
  String get filterRequired => 'જરૂરી';

  @override
  String get quickEntryTitle => 'વાસ્તવિક કિંમત';

  @override
  String get actualQuantityLabel => 'વાસ્તવિક જથ્થો';

  @override
  String get actualPriceLabel => 'વાસ્તવિક કિંમત';

  @override
  String get discountLabel => 'છૂટ (વૈકલ્પિક)';

  @override
  String get alternativeNameLabel => 'વૈકલ્પિક ઉત્પાદનનું નામ (વૈકલ્પિક)';

  @override
  String get savePurchaseButton => 'કાર્ટમાં ઉમેરો';

  @override
  String get unplannedAddButton => 'યોજનાબદ્ધ ન હોય તેવી આઈટમ ઉમેરો';

  @override
  String get statusPending => 'લટકતું';

  @override
  String get statusInCart => 'કાર્ટમાં';

  @override
  String get statusNotFound => 'મળ્યું નહીં';

  @override
  String get statusGaveUp => 'છોડી દીધું';

  @override
  String get statusAlternative => 'વૈકલ્પિક ખરીદ્યું';

  @override
  String get keepScreenAwake => 'સ્ક્રીન સક્રિય રાખો';

  @override
  String get finishShopping => 'શોપિંગ પૂર્ણ કરો';

  @override
  String get completionWarning =>
      'અધૂરા અથવા અનુમાનિત રેકોર્ડ્સ છે. તમે હજુ પણ પૂર્ણ કરી શકો છો; પરિણામમાં તેનો ઉલ્લેખ થશે.';

  @override
  String get continueShoppingButton => 'શોપિંગ ચાલુ રાખો';

  @override
  String get resultTitle => 'પરિણામ';

  @override
  String get summarySection => 'સારાંશ';

  @override
  String get plannedTotalLabel => 'યોજનાબદ્ધ કુલ';

  @override
  String get actualTotalLabel => 'વાસ્તવિક કુલ';

  @override
  String get varianceLabel => 'ફરક';

  @override
  String get varianceNotComputable => 'ગણી શકાતું નથી';

  @override
  String get budgetStatusLabel => 'બજેટ';

  @override
  String get savingsLabel => 'યોજના કરતા ઓછા';

  @override
  String get overspendLabel => 'યોજના કરતા વધુ';

  @override
  String get unplannedTotalLabel => 'યોજનાબદ્ધ ન હોય તેવું કુલ';

  @override
  String get unpurchasedLabel => 'યોજનાબદ્ધ પણ ખરીદ્યું નહીં';

  @override
  String get totalDiscountLabel => 'કુલ છૂટ';

  @override
  String get accuracyLabel => 'અંદાજની ચોકસાઈ';

  @override
  String get groupsSection => 'આઈટમ્સ';

  @override
  String get groupPricier => 'યોજના કરતા મોંઘું';

  @override
  String get groupCheaper => 'યોજના કરતા સસ્તું';

  @override
  String get groupClose => 'અંદાજની નજીક';

  @override
  String get groupNotTaken => 'યોજનાબદ્ધ, ખરીદ્યું નહીં';

  @override
  String get groupUnplanned => 'યોજના વિના ખરીદ્યું';

  @override
  String get groupQuantityChanged => 'જથ્થો બદલાયો';

  @override
  String get groupUnverified => 'ચકાસાયેલ નથી';

  @override
  String get plannedQtyLabel => 'યોજનાબદ્ધ જથ્થો';

  @override
  String get actualQtyLabel => 'વાસ્તવિક જથ્થો';

  @override
  String get plannedUnitPriceLabel => 'યોજનાબદ્ધ એકમ કિંમત';

  @override
  String get actualUnitPriceLabel => 'વાસ્તવિક એકમ કિંમત';

  @override
  String get lineVarianceLabel => 'લાઇન ફરક';

  @override
  String get discountEffectLabel => 'છૂટની અસર';

  @override
  String get notBoughtMark => 'ખરીદ્યું નથી';

  @override
  String get noPurchasesNote => 'કોઈ ખરીદી નોંધાઈ નથી.';

  @override
  String get navHome => 'હોમ';

  @override
  String get navLists => 'લિસ્ટો';

  @override
  String get navHistory => 'ઇતિહાસ';

  @override
  String get navSettings => 'સેટિંગ્સ';

  @override
  String get homeEmptyTitle => 'શોપિંગની યોજના બનાવો';

  @override
  String get homeEmptyBody =>
      'તમારી પ્રથમ લિસ્ટ બનાવો અને અંદાજિત ખર્ચ સાથે વાસ્તવિક ખર્ચની સરખામણી કરો.';

  @override
  String get homeActiveSection => 'સક્રિય લિસ્ટો';

  @override
  String get homeCompletedSection => 'તાજેતરમાં પૂર્ણ થયેલ';

  @override
  String get homeMonthlySection => 'આ મહિને';

  @override
  String get monthPlannedLabel => 'અંદાજિત';

  @override
  String get monthActualLabel => 'વાસ્તવિક';

  @override
  String get monthVarianceLabel => 'ફરક';

  @override
  String get continueShoppingLabel => 'શોપિંગ ચાલુ રાખો';

  @override
  String get historyEmpty =>
      'હજુ સુધી કોઈ શોપિંગ પૂર્ણ થયું નથી. તમારો ઇતિહાસ અને માહિતી અહીં દેખાશે.';

  @override
  String get aboutTabTitle => 'NShoptor વિશે';

  @override
  String get aboutBody =>
      'Crazy Penguin દ્વારા NShoptor. ઑફલાઇન-ફર્સ્ટ શોપિંગ પ્લાનર. GPL-3.0 લાઇસન્સ હેઠળ.';

  @override
  String get startShoppingLabel => 'શોપિંગ શરૂ કરો';

  @override
  String get finishAndSeeResult => 'પૂર્ણ કરો અને પરિણામ જુઓ';

  @override
  String get settingsTitle => 'સેટિંગ્સ';

  @override
  String get languageLabel => 'ભાષા';

  @override
  String get languageSystem => 'સિસ્ટમ';

  @override
  String get languageTr => 'તુર્કી';

  @override
  String get languageEn => 'અંગ્રેજી';

  @override
  String get themeLabel => 'થિમ';

  @override
  String get themeSystem => 'સિસ્ટમ';

  @override
  String get themeLight => 'લાઇટ';

  @override
  String get themeDark => 'ડાર્ક';

  @override
  String get defaultCurrencyLabel => 'ડિફોલ્ટ કરન્સી';

  @override
  String get defaultUnitLabel => 'ડિફોલ્ટ એકમ';

  @override
  String get keepAwakeLabel => 'શોપિંગ દરમિયાન સ્ક્રીન ચાલુ રાખો';

  @override
  String get backupSection => 'બેકઅપ';

  @override
  String get exportBackupLabel => 'બેકઅપ એક્સપોર્ટ કરો';

  @override
  String get importBackupLabel => 'બેકઅપ આયાત કરો';

  @override
  String get mergeImportLabel => 'વર્તમાન ડેટામાં મર્જ કરો';

  @override
  String get separateImportLabel => 'અલગ કોપી તરીકે આયાત કરો';

  @override
  String get importCancelled => 'આયાત રદ કરવામાં આવી.';

  @override
  String get backupExported => 'બેકઅપ સફળતાપૂર્વક એક્સપોર્ટ થયું.';

  @override
  String get deleteAllSection => 'ખતરનાક વિસ્તાર';

  @override
  String get deleteAllLabel => 'બધો ડેટા ડિલીટ કરો';

  @override
  String get deleteAllConfirm =>
      'આથી તમામ લિસ્ટો, ઇતિહાસ, રસીદ ફોટા અને ભાવ દૂર થશે. તમે એક્સપોર્ટ કરેલી ફાઇલો તમારા ડ્રાઇવ પર રહેશે. ચાલુ રાખવું?';

  @override
  String get deleteAllConfirm2 =>
      'શું તમે સંપૂર્ણપણે સુનિશ્ચિત છો? આ ક્રિયા પાછળ ફરતી નથી.';

  @override
  String get cancelAction => 'રદ કરો';

  @override
  String get confirmDelete => 'સ્થાયી રીતે ડિલીટ કરો';

  @override
  String get dataDeleted => 'બધો સ્થાનિક ડેટા ડિલીટ થયો.';

  @override
  String get privacyInfoLabel => 'ગોપનીયતા';

  @override
  String get privacyInfoBody =>
      'તમારી લિસ્ટો, ભાવ, રસીદો અને ફોટા તમારા ઉપકરણ પર જ રહે છે. ફોટા અને વૉઇસ તેનાથી ક્યારેય બહાર નથી જતા. જ્યારે AI help સક્રિય હોય, ત્યારે ફક્ત ટેક્સ્ટ (ઉદાહરણ તરીકે રસીદની લાઇનો અથવા તમે જે બોલ્યા) પ્રોસેસ કરવા માટે અમારા સર્વર પર મોકલવામાં આવે છે અને સંગ્રહિત થતું નથી.';

  @override
  String get aboutSection => 'વિશે';

  @override
  String get aboutPublisher => 'પબ્લિશર: Crazy Penguin';

  @override
  String get aboutLicenses => 'લાઇસન્સ (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'વૉઇસ ઇનપુટ';

  @override
  String get voiceStatusUnknown => 'સર્વિસ: તપાસવામાં આવી નથી';

  @override
  String get permissionsLabel => 'પરમિશન્સ';

  @override
  String get permissionsBody =>
      'કેમેરા, માઇક્રોફોન અને નોટિફિકેશન્સ ફક્ત ત્યારે જ માંગવામાં આવે છે જ્યારે તમે તે ફીચર્સનો વાસ્તવિક ઉપયોગ કરો છો.';

  @override
  String get unitsSection => 'ડિફોલ્ટ્સ';

  @override
  String get roundingNote =>
      'પૈસાના રાઉન્ડિંગ એક નિયમને અનુસરે છે: અડધા શૂન્યથી દૂર રાઉન્ડ થાય છે, Money કન્વર્ઝન પર એકવાર લાગુ પડે છે.';

  @override
  String get voiceInputTitle => 'વૉઇસ ઇનપુટ';

  @override
  String get voiceStartListening => 'સાંભળવાનું શરૂ કરો';

  @override
  String get voiceTranscriptLabel => 'ટ્રાન્સક્રિપ્ટ';

  @override
  String get parseAction => 'પાર્સ કરો';

  @override
  String get receiptReviewTitle => 'રસીદની સમીક્ષા';

  @override
  String get receiptTotal => 'રસીદનો કુલ';

  @override
  String get receiptTotalUnknown => 'કુલ શોધાયું નથી';

  @override
  String get receiptDiff => 'તફાવત';

  @override
  String get acceptLine => 'લાઇન સ્વીકારો';

  @override
  String get ignoreLine => 'લાઇન અવગણો';

  @override
  String get receiptLineActions => 'આઇટમ સાથે લિંક કરો, વિભાજિત કરો અથવા અવગણો';

  @override
  String get receiptCommit => 'બધું સ્વીકારો';

  @override
  String get receiptCommitted => 'રસીદ લાગુ પડી.';

  @override
  String get priceHistoryTitle => 'કિંમત ઇતિહાસ';

  @override
  String get noObservations => 'હજુ સુધી કોઈ કિંમત નિરીક્ષણ નથી';

  @override
  String get templatesSection => 'ટેમ્પલેટ્સ';

  @override
  String get templateHint => 'પૂર્વની શોપિંગ યાત્રા પરથી નવો પ્લાન બનાવો';

  @override
  String get scanReceiptAction => 'રસીદ સ્કેન કરો';

  @override
  String get fromReceiptListButton => 'રસીદમાંથી યાદી';

  @override
  String get shelfLabelAction => 'શેલ્ફ લેબલ પરથી કિંમત';

  @override
  String get priceCandidatesTitle => 'કિંમત ઉમેદવારો';

  @override
  String get noPriceCandidates => 'કોઈ કિંમત મળી નથી; મેન્યુઅલી દાખલ કરો.';

  @override
  String get voiceUnavailable =>
      'સ્પીચ રિકોગ્નિશન ઉપલબ્ધ નથી; મેન્યુઅલી દાખલ કરો.';

  @override
  String get linkToItem => 'આઇટમ સાથે લિંક કરો';

  @override
  String get splitLine => 'બે ભાગમાં વહેંચો';

  @override
  String get mergeWithNext => 'આગળની સાથે જોડો';

  @override
  String get ocrNoText => 'કોઈ ટેક્સ્ટ વાંચાયું નથી; ફરી પ્રયાસ કરો.';

  @override
  String get priceHistoryAction => 'કિંમત ઇતિહાસ';

  @override
  String get itemsEmptyTitle => 'હજુ કોઈ આઇટમ નથી';

  @override
  String get itemsEmptyBody =>
      'તમારી પ્રથમ આઇટમ ઉમેરો — તમે સ્ટોરમાં અહીં વાસ્તવિક કિંમતો દાખલ કરશો.';

  @override
  String get addItemTooltip => 'આઇટમ ઉમેરો';

  @override
  String get unitAdet => 'pc';

  @override
  String get unitKilogram => 'kg';

  @override
  String get unitGram => 'g';

  @override
  String get unitLitre => 'L';

  @override
  String get unitMililitre => 'ml';

  @override
  String get unitPaket => 'pack';

  @override
  String get unitKutu => 'box';

  @override
  String get unitSise => 'bottle';

  @override
  String get unitKavanoz => 'jar';

  @override
  String get unitDemet => 'bunch';

  @override
  String get unitDuzine => 'dozen';

  @override
  String get unitMetre => 'm';

  @override
  String get unitCustom => 'કસ્ટમ';

  @override
  String get setReminderAction => 'રિમાઇન્ડર સેટ કરો';

  @override
  String get reminderPermissionDenied =>
      'રિમાઇન્ડર્સ માટે નોટિફિકેશન પરમિશન જરૂરી છે. તમે સિસ્ટમ સેટિંગ્સમાં તેને સક્ષમ કરી શકો છો.';

  @override
  String get reminderScheduled => 'રિમાઇન્ડર સેટ થયું.';

  @override
  String get reminderCancelled => 'રિમાઇન્ડર દૂર કર્યું.';

  @override
  String get reminderTitle => 'શોપિંગ રિમાઇન્ડર';

  @override
  String reminderBody(Object title) {
    return 'તમારી યાદી ચકાસવાનો સમય: $title';
  }

  @override
  String get reminderPickDate => 'તારીખ પસંદ કરો';

  @override
  String get reminderPickTime => 'સમય પસંદ કરો';

  @override
  String get itemDetailsSection => 'વિગતો';

  @override
  String get priceOptionalHint =>
      '૨ૈખિક — તમે સ્ટોરમાં વાસ્તવિક કિંમત દાખલ કરશો';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'પ્લાન કરેલ: $total · $count આઇટમ્સ';
  }

  @override
  String get proActiveLabel => 'Pro સક્રિય — આભાર!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'કોઈ એડ્સ નહીં · બેકઅપ એક્સપોર્ટ અને ઇમ્પોર્ટ · વાર્ષિક';

  @override
  String get proBenefitNoAds => 'એડ-ફ્રી અનુભવ';

  @override
  String get proBenefitBackup => 'બેકઅપ (એક્સપોર્ટ/ઇમ્પોર્ટ)';

  @override
  String aboutVersion(Object version) {
    return 'વર્ઝન $version';
  }

  @override
  String get navDiscover => 'શોધો';

  @override
  String get shareAction => 'એપ શેર કરો';

  @override
  String get rateAction => 'આપણને રેટ કરો';

  @override
  String get aboutOpenRow => 'અંગે અને ઓપન સોર્સ';

  @override
  String get voiceAddItemAction => 'વૉઇસ દ્વારા ઉમેરો';

  @override
  String get formatLocaleLabel => 'સંખ્યા અને મુદ્રા ફોર્મેટ';

  @override
  String get formatLocaleSystem =>
      'ડિવાઇસ ફોર્મેટ (લેટિન અંકો; અન્યથા અંગ્રેજી)';

  @override
  String get formatLocaleTr => 'તુર્કી (1.234,56)';

  @override
  String get formatLocaleEn => 'અંગ્રેજી (1,234.56)';

  @override
  String get aiToggleTitle => 'AI મદદ';

  @override
  String get aiToggleSubtitle =>
      'રસીદોને મેચ કરે છે, કિંમતના લેબલ વાંચે છે અને વાક્યોને યાદીમાં બદલે છે. ફોટા અને વૉઇસ તમારા ઉપકરણ પર રહે છે; માત્ર ટેક્સ્ટ પ્રોસેસ થાય છે.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'તમે આ મહિનાની AI વિનંતીઓ ($used/$limit) વાપરી લીધી છે. વધુ માટે અપગ્રેડ કરો, અથવા AI વિના ચાલુ રાખો.';
  }

  @override
  String get aiOffline => 'કોઈ કનેક્શન નથી — AI વિના ચાલુ રાખી રહ્યા છીએ.';

  @override
  String get aiFailed => 'AI હાલ ઉપલબ્ધ નથી — તે વિના ચાલુ રાખી રહ્યા છીએ.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'ઉપકરણ';

  @override
  String get quickListAction => 'વાક્યમાંથી ઉમેરો';

  @override
  String get quickListTitle => 'ઝડપી યાદી';

  @override
  String get quickListHint => 'દા.ત. 1 kg સેબુ 20, 2 બ્રેડ, અડધું કિલો પનીર';

  @override
  String get quickListConvert => 'યાદીમાં બદલો';

  @override
  String quickListAdd(int count) {
    return '$count આઈટમ ઉમેરો';
  }

  @override
  String get quickListEmpty =>
      'કોઈ આઈટમ મળી નથી. કૃપા કરીને કોમાથી અલગ કરીને યાદી બનાવો.';

  @override
  String get receiptAiMatched =>
      'AI એ રસીદને તમારી યાદી સાથે મેચ કરી દીધી છે. લિંક્સ તપાસો અને પુષ્ટિ કરો.';

  @override
  String get receiptNeedsCheck => 'આ મેચ તપાસો';

  @override
  String get receiptDiscountLine => 'છૂટ';

  @override
  String get compareItem => 'આઈટમ';

  @override
  String get compareEstimated => 'અંદાજિત';

  @override
  String get compareActual => 'વાસ્તવિક';

  @override
  String get compareDiff => 'ફરક';

  @override
  String get compareTotal => 'કુલ';

  @override
  String get compareBudget => 'બજેટ';

  @override
  String get compareNotBought => 'ખરીદ્યું નથી';

  @override
  String get compareUnplanned => 'યોજનામાં ન હતું';

  @override
  String get pricierItems => 'વધુ ખર્ચાળ';

  @override
  String get cheaperItems => 'સસ્તા';

  @override
  String get compareAction => 'તુલના કરો';

  @override
  String get detailsSection => 'વિગતો';

  @override
  String get spendingTitle => 'ખર્ચ';

  @override
  String get spendingAction => 'ખર્ચ';

  @override
  String get spendingMonthTotal => 'આ મહિને';

  @override
  String get spendingWeekly => 'સાપ્તાહિક ખર્ચ';

  @override
  String get spendingMonthly => 'માસિક ખર્ચ';

  @override
  String get monthlyLimitTitle => 'માસિક લિમિટ';

  @override
  String get monthlyLimitHelp =>
      'તમે દર મહિને ખરીદી માટે કેટલો ખર્ચ કરવા માંગો છો?';

  @override
  String get monthlyLimitRemove => 'દૂર કરો';

  @override
  String get monthlyLimitSet => 'સેટ કરો';

  @override
  String get monthlyLimitChange => 'બદલો';

  @override
  String get monthlyLimitNone =>
      'કેટલું બાકી છે તે જોવા માટે માસિક લિમિટ સેટ કરો.';

  @override
  String monthlyLimitOver(String amount) {
    return 'લિમિટથી $amount વધુ';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return 'આ મહિને $amount બાકી';
  }

  @override
  String get plansTitle => 'પ્લાન્સ';

  @override
  String get plansHeadline => 'AI સાથે સ્માર્ટ શોપિંગ';

  @override
  String get plansSubhead =>
      'રસીદ મેચિંગ, કિંમતના લેબલ અને વાક્યમાંથી યાદીઓ. કોઈ પણ સમયે કેન્સલ કરી શકો છો.';

  @override
  String get plansMonthly => 'માસિક';

  @override
  String get plansYearly => 'વાર્ષિક';

  @override
  String get planFree => 'ફ્રી';

  @override
  String get planFreePrice => 'આખી ઉમર ફ્રી';

  @override
  String get planFreeAi => 'મહિને 10 AI વિનંતીઓ';

  @override
  String get planFreeAds => 'નાના બેનર એડ્સ (પહેલા 7 દિવસે કોઈ નહીં)';

  @override
  String get planCoreFeatures => 'યાદીઓ, કિંમતો, રસીદો, ખર્ચ ચાર્ટ્સ';

  @override
  String get plansPerYear => '/ વર્ષ';

  @override
  String get plansPerMonth => '/ મહિનો';

  @override
  String get planTrial => 'મફત ટ્રાયલ';

  @override
  String get planProAi => 'મહિને 100 AI વિનંતીઓ';

  @override
  String get planNoAds => 'કોઈ એડ્સ નહીં';

  @override
  String get planBackup => 'બેકઅપ એક્સપોર્ટ અને ઇમ્પોર્ટ';

  @override
  String get planMaxAi => 'એક મહિને 300 AI રિક્વેસ્ટ્સ';

  @override
  String get planMaxFamily => 'મોટા પરિવારની શોપિંગ માટે';

  @override
  String get plansStoreUnavailable => 'હાલમાં સ્ટોર ઉપલબ્ધ નથી.';

  @override
  String get retryAction => 'ફરી પ્રયાસ કરો';

  @override
  String get plansPurchaseFailed =>
      'ખરીદી પૂર્ણ થઈ નથી. કૃપા કરીને ફરી પ્રયાસ કરો.';

  @override
  String get plansRestore => 'ખરીદીઓ પુનઃસ્થાપિત કરો';

  @override
  String get plansLegal =>
      'રદ ન કરો ત્યાં સુધી Pro દર વર્ષે આપમેળે રિન્યૂ થાય છે અને દર મહિને 100 AI વિનંતીઓ મળે છે. લાગુ પડતા કર પહેલાં મૂળ કિંમત વાર્ષિક 1 અમેરિકન ડૉલર છે; ખરીદીની પુષ્ટિ કરતાં પહેલાં સ્ટોરમાં અંતિમ સ્થાનિક કિંમત અને કર તપાસો. Google Playમાં સબ્સ્ક્રિપ્શન મેનેજ કરો અથવા રદ કરો.';

  @override
  String get planCurrent => 'વર્તમાન';

  @override
  String get planStartTrial => 'મફત ટ્રાયલ શરૂ કરો';

  @override
  String get planChoose => 'ચૂંટો';

  @override
  String get plansAction => 'પ્લાન્સ: Pro';

  @override
  String get assistantTitle => 'સહાયક';

  @override
  String get assistantGreeting => 'નમસ્તે! તમે શું કરવા માંગો છો?';

  @override
  String get assistantNewList => 'નવી લિસ્ટ';

  @override
  String get assistantVoiceList => 'વૉઇસ દ્વારા લિસ્ટ';

  @override
  String get assistantTextList => 'વાક્યમાંથી લિસ્ટ';

  @override
  String get assistantScanReceipt => 'રસીદ સ્કેન કરો';

  @override
  String get assistantSpending => 'મારો ખર્ચ';

  @override
  String get assistantReceiptHint =>
      'તમારી લિસ્ટ ખોલો અને તેને સ્કેન કરવા માટે રસીદ આઇકન પર ટેપ કરો.';

  @override
  String get assistantToggleTitle => 'સહાયક દર્શાવો';

  @override
  String get assistantToggleSubtitle => 'જમણી બાજુ નીચેનો નાનો હેલ્પર';

  @override
  String get scanPriceLabel => 'કિંમત લેબલ સ્કેન કરો';

  @override
  String get saveFailed =>
      'સેવ કરી શકાયા નહીં. તમારા ફેરફારો હજુ પણ અહીં છે. કૃપા કરીને ફરી પ્રયાસ કરો.';

  @override
  String get deleteItemConfirm =>
      'આ આઇટમ અને તેના રેકોર્ડેડ ખરીદીઓ ડિલીટ કરવા?';

  @override
  String get clearPurchaseConfirm =>
      'આ આઇટમનું ચેકબોક્સ દૂર કરીને તેની રેકોર્ડેડ ખરીદીઓ દૂર કરવી?';

  @override
  String get reportPdfAction => 'PDF રિપોર્ટ સેવ કરો';

  @override
  String get reportNotInvoice =>
      'શોપિંગ સારાંશ, ટેક્સ ઇન્વોઇસ નથી. ટેક્સ રેટ્સ અજ્ઞાત છે.';

  @override
  String get purchaseVisits => 'શોપિંગ વિઝિટ્સ';

  @override
  String get purchaseInterval => 'ખરીદી વચ્ચેનો સરેરાશ દિવસો';

  @override
  String get purchasedQuantity => 'ખરીદેલ માત્રા';

  @override
  String get purchaseAnalyticsHint =>
      'ખરીદીઓ ખપતને માપતી નથી. કરન્સી અને એકમો અલગ દર્શાવવામાં આવે છે.';

  @override
  String get receiptReplaces =>
      'કિંમત વગરની વસ્તુઓની કિંમત ભરાશે. બજારભાવ પહેલેથી હોય તેવી વસ્તુઓ અલગ ખરીદી તરીકે ઉમેરાશે.';

  @override
  String get receiptIncompleteHeader =>
      'આગળના ફોટામાં દુકાન, તારીખ, સમય અને રસીદ નંબર સામેલ કરો.';

  @override
  String get receiptIncompleteTail =>
      'આગળના ભાગનો ફોટો લો, જેમાં કેટલીક એકબીજા પર આવતી વસ્તુઓ અને અંતિમ કુલ દેખાય.';

  @override
  String get receiptContinuationRejected =>
      'આ ફોટો રસીદ સાથે જોડી શકાયો નહીં. એ જ રસીદની એકબીજા પર આવતી વસ્તુઓ સાથે ફરી ફોટો લો.';

  @override
  String get receiptDraftSaved =>
      'રસીદ ડ્રાફ્ટ તરીકે સાચવાઈ. તમે પછીથી ચાલુ રાખી શકો છો.';

  @override
  String get receiptContinueAction => 'રસીદ ચાલુ રાખો';

  @override
  String get receiptDraftsTitle => 'અધૂરી રસીદો';

  @override
  String get receiptDuplicate => 'આ રસીદ પહેલેથી ઉમેરાઈ છે.';

  @override
  String get receiptTotalMismatch =>
      'વસ્તુઓ રસીદના કુલ સાથે મેળ ખાતી નથી. આખી રસીદ દેખાય છે કે નહીં તે તપાસો.';

  @override
  String get receiptSaveDraftAction => 'પછી માટે સાચવો';

  @override
  String get receiptResolveLines =>
      'સાચવતા પહેલાં દરેક વસ્તુ સ્વીકારો અથવા અવગણો.';

  @override
  String get receiptPartialConfirm =>
      'માત્ર પસંદ કરેલી વસ્તુઓ ઉમેરાશે. આ રસીદ આયાત કરેલી તરીકે ચિહ્નિત થશે. આગળ વધવું છે?';

  @override
  String get voiceUnsupportedLanguage =>
      'આ ભાષા આ ડિવાઇસ પર વૉઇસ ઇનપુટ માટે ઉપલબ્ધ નથી. તમે ટાઇપ કરી શકો છો.';

  @override
  String get voiceStopListening => 'સાંભળવાનું બંધ કરો';

  @override
  String get keepAwakeFailed =>
      'સ્ક્રીન જાગૃત રાખવામાં નિષ્ફળતા. કૃપા કરીને ફરી પ્રયાસ કરો.';

  @override
  String get purchaseHistoryHint =>
      'બધી પૂર્ણ થયેલી શોપિંગ. રિટર્નથી કુલ રકમ ઘટે છે. તારીખો શોપિંગ પૂર્ણ થવાની છે. એક વારની મુલાકાત સરેરાશ અંતર ગણવા માટે પૂરતી નથી.';

  @override
  String get planLegacyRights =>
      'હાલના Pro અને Max સબ્સ્ક્રિપ્શન તેમની મૂળ માસિક AI વિનંતીઓની મર્યાદા જાળવી રાખે છે.';

  @override
  String get csvExportAction => 'CSV નિકાસ કરો';

  @override
  String get backupSizeWarning =>
      'JSON માં રેકોર્ડ્સ છે, ફોટો ફાઇલો નથી. આયાત મર્યાદા: 16 MB.';

  @override
  String get backupImportFailed =>
      'આ બેકઅપ આયાત કરી શકાયા નથી. તમારા ડેટામાં કોઈ ફેરફાર થયો નથી.';

  @override
  String get backupImported => 'બેકઅપ સફળતાપૂર્વક આયાત થયું.';

  @override
  String backupPreviewCounts(Object entries, Object items, Object lists) {
    return '$lists યાદીઓ · $items આઇટમ્સ · $entries ખરીદીઓ';
  }

  @override
  String get voiceModelDownloading =>
      'આ ભાષા માટે વૉઇસ મોડેલ ડાઉનલોડ થઈ રહ્યું છે. એક મિનિટ પછી ફરી પ્રયાસ કરો.';

  @override
  String get historyThisWeek => 'આ અઠવાડિયું';

  @override
  String get historyProductsSection => 'ખરીદેલા ઉત્પાદનો';

  @override
  String get tipReceiptScan => 'રસીદ સ્કેન કરીને કિંમતો તમારી યાદી સાથે મેળવો';

  @override
  String get tipVoiceAdd => 'એક કે વધુ વસ્તુઓ બોલો અને ઉમેરતા પહેલાં તપાસો';

  @override
  String get tipShelfCamera => 'કૅમેરાથી શેલ્ફ લેબલ પરથી કિંમત વાંચો';

  @override
  String get tipPlan =>
      'તમારો પ્લાન: વિગતો જુઓ, સબ્સ્ક્રાઇબ કરો અથવા અપગ્રેડ કરો';

  @override
  String get guideAddBody =>
      'વસ્તુ ઉમેરવા + દબાવો. આયોજિત કિંમત હમણાં અને બજાર કિંમત ચેકઆઉટ પર દાખલ કરો.';

  @override
  String get guideVoiceBody =>
      'માઇક્રોફોન દબાવો અને વસ્તુઓ બોલો, જેમ કે: \'1 કિલો સફરજન, 1 બ્રેડ\'.';

  @override
  String get guideReceiptBody =>
      'તમારી યાદીની વસ્તુઓ સાથે કિંમતો મેળવવા રસીદ સ્કેન કરો.';

  @override
  String get guidePlanBody =>
      'તમારો પ્લાન જોવા, સબ્સ્ક્રાઇબ કરવા અથવા અપગ્રેડ કરવા પ્લાન આઇકન દબાવો.';

  @override
  String get guideNext => 'ઓકે';

  @override
  String get guideDone => 'શરૂ કરો';

  @override
  String get paletteLabel => 'રંગ થીમ';

  @override
  String get paletteForest => 'જંગલ';

  @override
  String get paletteOcean => 'સમુદ્ર';

  @override
  String get paletteSunset => 'સૂર્યાસ્ત';

  @override
  String get paletteLavender => 'લવંડર';

  @override
  String get darkBlackLabel => 'ડાર્ક થીમમાં સંપૂર્ણ કાળો';

  @override
  String get spendingOverview => 'ઝાંખી';

  @override
  String get spendingThisYear => 'આ વર્ષ';

  @override
  String get spendingYearly => 'વાર્ષિક ખર્ચ';

  @override
  String get productSpending => 'ઉત્પાદન મુજબ ખર્ચ';

  @override
  String get spanWeek => 'અઠવાડિયું';

  @override
  String get spanMonth => 'મહિનો';

  @override
  String get spanYear => 'વર્ષ';

  @override
  String get weeklyLimitTitle => 'સાપ્તાહિક મર્યાદા';

  @override
  String get weeklyLimitHelp => 'અઠવાડિયે ખરીદી પર કેટલો ખર્ચ કરવો છે?';

  @override
  String get weeklyLimitNone =>
      'કેટલું બાકી છે તે જોવા સાપ્તાહિક મર્યાદા સેટ કરો.';

  @override
  String weeklyLimitLeft(String amount) {
    return 'આ અઠવાડિયે $amount બાકી';
  }

  @override
  String get shoppingLimitTitle => 'દરેક ખરીદીની મર્યાદા';

  @override
  String get shoppingLimitHelp => 'નવી યાદીઓ આ બજેટથી શરૂ થાય છે.';

  @override
  String get shoppingLimitNone => 'દરેક નવી ખરીદી માટે ડિફોલ્ટ બજેટ સેટ કરો.';

  @override
  String get monthlyReportAction => 'માસિક અહેવાલ';

  @override
  String get reportShoppingColumn => 'ખરીદી';

  @override
  String get reportDateColumn => 'તારીખ';

  @override
  String get planUnavailable => 'હાલમાં સ્ટોરમાં ઉપલબ્ધ નથી';

  @override
  String get demoDataTitle => 'નમૂના ડેટા';

  @override
  String get demoDataLoad => 'નમૂના ડેટા સાથે અજમાવો';

  @override
  String get demoDataLoadHelp =>
      'ઇતિહાસ, ચાર્ટ અને ભાવ ઇતિહાસ જોવા માટે 12 મહિનાની નમૂના ખરીદી ઉમેરે છે.';

  @override
  String get demoDataRemove => 'નમૂના ડેટા કાઢો';

  @override
  String get demoDataAdded => 'નમૂના ડેટા ઉમેરાયો';

  @override
  String get demoDataRemoved => 'નમૂના ડેટા કાઢી નાખ્યો';

  @override
  String get demoProductApple => 'સફરજન';

  @override
  String get demoProductBread => 'બ્રેડ';

  @override
  String get demoProductMilk => 'દૂધ';

  @override
  String get demoProductCheese => 'ચીઝ';

  @override
  String get demoProductTomato => 'ટમેટાં';

  @override
  String get demoProductEggs => 'ઈંડાં';

  @override
  String get demoProductCoffee => 'કોફી';

  @override
  String get demoProductDetergent => 'ડિટર્જન્ટ';

  @override
  String get sendAction => 'Send';

  @override
  String get previousMonthAction => 'Previous month';

  @override
  String get nextMonthAction => 'Next month';

  @override
  String get helpSection => 'મદદ અને સહાય';

  @override
  String get howToUseLabel => 'કેવી રીતે વાપરવું';

  @override
  String get guidePricesBody =>
      'દુકાનની કિંમત લખવાથી વસ્તુ ખરીદેલી ગણાય છે; 0 પણ માન્ય છે. ઘરની કિંમત વૈકલ્પિક છે. નિશાની દૂર કરવા દુકાનની કિંમત ભૂંસો.';

  @override
  String get shoppingDateLabel => 'ખરીદીની તારીખ';

  @override
  String get shoppingDateNone => 'કોઈ તારીખ પસંદ કરેલી નથી';

  @override
  String get clearShoppingDateAction => 'તારીખ દૂર કરો';

  @override
  String get listSortLabel => 'સૂચિનો ક્રમ';

  @override
  String get listSortDate => 'ખરીદીની તારીખ';

  @override
  String get listSortAz => 'નામ (અ–હ)';

  @override
  String get listSortManual => 'જાતે ગોઠવો';

  @override
  String get imageCameraAction => 'ફોટો લો';

  @override
  String get imageGalleryAction => 'ફોટામાંથી પસંદ કરો';

  @override
  String get imageCaptureFailed =>
      'કૅમેરા અથવા ફોટા ખોલી શકાયા નથી. ઍક્સેસની પરવાનગી તપાસો અને ફરી પ્રયાસ કરો.';

  @override
  String get imageRecognitionFailed =>
      'ફોટો પર પ્રક્રિયા થઈ શકી નથી. બીજો ફોટો અજમાવો.';

  @override
  String get receiptNoProducts =>
      'લખાણ વંચાયું, પરંતુ રસીદની વસ્તુઓ મળી નથી. ફોટામાં વસ્તુઓ અને કુલ રકમ સામેલ કરો.';

  @override
  String get keepAwakeOn => 'સ્ક્રીન ચાલુ રહેશે';

  @override
  String get keepAwakeOff => 'સ્ક્રીન બંધ થઈ શકે છે';

  @override
  String get spanDay => 'દિવસ';

  @override
  String get spanCustom => 'તારીખની શ્રેણી';

  @override
  String get reportTotalSpent => 'કુલ ખર્ચ';

  @override
  String get reportAddedAt => 'ઉમેર્યું';

  @override
  String get reportReceiptNumber => 'રસીદ નંબર';

  @override
  String get reportPreview => 'પૂર્વાવલોકન';

  @override
  String get reportShareAction => 'શેર કરો';

  @override
  String get previousPeriodAction => 'પહેલાનો સમયગાળો';

  @override
  String get nextPeriodAction => 'આગળનો સમયગાળો';

  @override
  String get reportSaved => 'રિપોર્ટ સાચવાયો.';

  @override
  String get reportZoom => 'ઝૂમ';

  @override
  String planTrialDaysLeft(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days દિવસો બાકી',
      one: '$days દિવસ બાકી',
    );
    return '$_temp0';
  }

  @override
  String planTrialHoursLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours કલાકો બાકી',
      one: '$hours કલાક બાકી',
    );
    return '$_temp0';
  }

  @override
  String get planTrialEndedTitle => 'તમારી Pro અજમાયશ પૂરી થઈ ગઈ છે';

  @override
  String get planTrialEndedBody =>
      'તમે યાદીઓ, હાથથી દાખલ કરવું અને ઉપકરણ પર વૉઇસનો મફતમાં ઉપયોગ ચાલુ રાખી શકો છો. Freeમાં દર કૅલેન્ડર મહિને 10 AI વિનંતીઓ મળે છે. દર મહિને 100 AI વિનંતીઓ, જાહેરાતો વિના અને બૅકઅપ માટે વાર્ષિક Pro પસંદ કરો. તમારો હાલનો ડેટા તમારી પાસે જ રહેશે.';

  @override
  String get planContinueFree => 'Free સાથે ચાલુ રાખો';

  @override
  String get supportIdLabel => 'સપોર્ટ ID';

  @override
  String get supportEmailLabel => 'ઈમેલ સપોર્ટ';
}
