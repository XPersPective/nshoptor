// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tagalog (`tl`).
class AppLocalizationsTl extends AppLocalizations {
  AppLocalizationsTl([String locale = 'tl']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Magplano sa bahay. Bumili ayon sa plano.';

  @override
  String get listsTitle => 'Mga Listahan';

  @override
  String get listsTabActive => 'Aktibo';

  @override
  String get listsTabCompleted => 'Natapos';

  @override
  String get listsTabArchived => 'Na-archive';

  @override
  String get newListButton => 'Bagong listahan';

  @override
  String get listTitleHint => 'Pamagat (opsyonal)';

  @override
  String get saveButton => 'I-save';

  @override
  String get cancelButton => 'Kanselahin';

  @override
  String get deleteButton => 'Burahin';

  @override
  String get editAction => 'I-edit';

  @override
  String get listDeleted => 'Tinanggal ang listahan';

  @override
  String get invalidAmountError => 'Hindi wastong halaga';

  @override
  String get duplicateAction => 'Duplicahin';

  @override
  String get archiveAction => 'I-archive';

  @override
  String get unarchiveAction => 'I-unarchive';

  @override
  String get deleteListConfirm =>
      'Burahin ang listahang ito? Tinatanggal din ang mga naplanong item dito.';

  @override
  String get undoButton => 'I-undo';

  @override
  String get searchListHint => 'Maghanap ng mga listahan';

  @override
  String get currencyLabel => 'Yunit ng Pera';

  @override
  String get budgetLabel => 'Budget (opsyonal)';

  @override
  String get noteLabel => 'Tala (opsyonal)';

  @override
  String get storeLabel => 'Tindahan';

  @override
  String get keepAmountsAction => 'Panatilihin ang mga halaga';

  @override
  String get resetAmountsAction => 'I-reset ang mga halaga';

  @override
  String get currencyChangeWarning =>
      'Papalitan ang yunit ng pera. Ano ang mangyayari sa kasalukuyang mga halaga?';

  @override
  String get listsEmpty =>
      'Wala pang listahan. Gumawa ng iyong unang shopping plan.';

  @override
  String get statusDraft => 'Draft';

  @override
  String get statusPlanned => 'Naplanong';

  @override
  String get statusShopping => 'Bumibili';

  @override
  String get statusCompleted => 'Natapos';

  @override
  String get statusArchived => 'Na-archive';

  @override
  String autoListTitle(String date) {
    return 'Pagbili noong $date';
  }

  @override
  String get itemFormTitle => 'Magdagdag ng item';

  @override
  String get itemNameLabel => 'Pangalan ng item';

  @override
  String get brandLabel => 'Brand / variant (opsyonal)';

  @override
  String get categoryLabel => 'Kategorya';

  @override
  String get quantityLabel => 'Dami';

  @override
  String get unitLabel => 'Yunit';

  @override
  String get pricingModeLabel => 'Paraan ng pagpasok ng presyo';

  @override
  String get pricingModeUnitPrice => 'Presyo bawat yunit';

  @override
  String get pricingModeLineTotal => 'Kabuuang linya';

  @override
  String get plannedPriceLabel => 'Naplanong presyo';

  @override
  String lineTotalCalculated(String value) {
    return 'Kabuuang linya: $value';
  }

  @override
  String get requiredItemToggle => 'Kailangan na item';

  @override
  String get maxPriceLabel => 'Pinakamataas na tanggap na presyo (opsyonal)';

  @override
  String get itemNoteLabel => 'Tala (opsyonal)';

  @override
  String get categoryProduce => 'Prutas at gulay';

  @override
  String get categoryDairy => 'Gatas';

  @override
  String get categoryMeat => 'Karne';

  @override
  String get categoryBakery => 'Panaderya';

  @override
  String get categoryDrinks => 'Inumin';

  @override
  String get categoryCleaning => 'Paglilinis';

  @override
  String get categoryPersonalCare => 'Pag-aalaga sa sarili';

  @override
  String get categoryHome => 'Bahay';

  @override
  String get categoryOther => 'Iba pa';

  @override
  String get invalidQuantityError => 'Hindi wastong dami';

  @override
  String get invalidPriceError => 'Hindi wastong presyo';

  @override
  String get invalidNameError => 'Ilagay ang pangalan';

  @override
  String unitPriceCalculated(String value) {
    return 'Presyo bawat yunit: $value';
  }

  @override
  String get shoppingTitle => 'Mode ng pagbili';

  @override
  String get summaryPlannedTotal => 'Inaasahan';

  @override
  String get summaryInCart => 'Nasa cart';

  @override
  String get summaryRemainingPlan => 'Natitirang plano';

  @override
  String get summaryProjected => 'Inaasahang checkout';

  @override
  String get summaryBudgetRemaining => 'Natitirang budget';

  @override
  String get summaryBudgetOver => 'Lumampas sa budget';

  @override
  String itemsProgress(String done, String total) {
    return '$done sa $total na item';
  }

  @override
  String get filterAll => 'Lahat';

  @override
  String get filterToBuy => 'Bibilihin';

  @override
  String get filterInCart => 'Nasa cart';

  @override
  String get filterNotFound => 'Hindi nakita';

  @override
  String get filterRequired => 'Kailangan';

  @override
  String get quickEntryTitle => 'Tunay na presyo';

  @override
  String get actualQuantityLabel => 'Tunay na dami';

  @override
  String get actualPriceLabel => 'Tunay na presyo';

  @override
  String get discountLabel => 'Diskwento (opsyonal)';

  @override
  String get alternativeNameLabel =>
      'Pangalan ng alternatibong produkto (opsyonal)';

  @override
  String get savePurchaseButton => 'Idagdag sa cart';

  @override
  String get unplannedAddButton => 'Magdagdag ng di-naplano';

  @override
  String get statusPending => 'Hindi pa kinuha';

  @override
  String get statusInCart => 'Nasa cart';

  @override
  String get statusNotFound => 'Hindi nakita';

  @override
  String get statusGaveUp => 'Ipinabayaan';

  @override
  String get statusAlternative => 'Binili ang alternatibo';

  @override
  String get keepScreenAwake => 'Panatilihing bukas ang screen';

  @override
  String get finishShopping => 'Tapusin ang pagbili';

  @override
  String get completionWarning =>
      'May mga kulang o hindi pa napatunayang tala. Maaari mo pa ring tapusin; ituturo nito ang mga ito.';

  @override
  String get continueShoppingButton => 'Patuloy na bumili';

  @override
  String get resultTitle => 'Resulta';

  @override
  String get summarySection => 'Buod';

  @override
  String get plannedTotalLabel => 'Kabuuang inaasahan';

  @override
  String get actualTotalLabel => 'Kabuuang tunay';

  @override
  String get varianceLabel => 'Pagkakaiba';

  @override
  String get varianceNotComputable => 'Hindi ma-iisip';

  @override
  String get budgetStatusLabel => 'Budget';

  @override
  String get savingsLabel => 'Sa ilalim ng plano';

  @override
  String get overspendLabel => 'Lumampas sa plano';

  @override
  String get unplannedTotalLabel => 'Kabuuang di-naplano';

  @override
  String get unpurchasedLabel => 'Naplano pero hindi binili';

  @override
  String get totalDiscountLabel => 'Kabuuang diskwento';

  @override
  String get accuracyLabel => 'Katumpakan ng hula';

  @override
  String get groupsSection => 'Mga Item';

  @override
  String get groupPricier => 'Mas mahal kaysa naplano';

  @override
  String get groupCheaper => 'Mas mura kaysa naplano';

  @override
  String get groupClose => 'Malapit sa hula';

  @override
  String get groupNotTaken => 'Naplano, hindi binili';

  @override
  String get groupUnplanned => 'Binili nang walang plano';

  @override
  String get groupQuantityChanged => 'Nagbago ang dami';

  @override
  String get groupUnverified => 'Hindi pa napatunayan';

  @override
  String get plannedQtyLabel => 'Naplano na dami';

  @override
  String get actualQtyLabel => 'Tunay na dami';

  @override
  String get plannedUnitPriceLabel => 'Naplano na presyo bawat yunit';

  @override
  String get actualUnitPriceLabel => 'Tunay na presyo bawat yunit';

  @override
  String get lineVarianceLabel => 'Pagkakaiba sa linya';

  @override
  String get discountEffectLabel => 'Epekto ng diskwento';

  @override
  String get notBoughtMark => 'hindi binili';

  @override
  String get noPurchasesNote => 'Walang nakatalang pagbili.';

  @override
  String get navHome => 'Home';

  @override
  String get navLists => 'Mga Listahan';

  @override
  String get navHistory => 'Kasaysayan';

  @override
  String get navSettings => 'Mga Setting';

  @override
  String get homeEmptyTitle => 'Magplano ng pagbili';

  @override
  String get homeEmptyBody =>
      'Gumawa ng unang listahan at ikumpara ang inaasahang vs tunay na gastos.';

  @override
  String get homeActiveSection => 'Aktibong mga listahan';

  @override
  String get homeCompletedSection => 'Kamakailan natapos';

  @override
  String get homeMonthlySection => 'Ngayong buwan';

  @override
  String get monthPlannedLabel => 'Inaasahan';

  @override
  String get monthActualLabel => 'Tunay';

  @override
  String get monthVarianceLabel => 'Pagkakaiba';

  @override
  String get continueShoppingLabel => 'Magpatuloy sa pagbili';

  @override
  String get historyEmpty =>
      'Wala pang natapos na pagbili. Dito lilitaw ang iyong kasaysayan at insights.';

  @override
  String get aboutTabTitle => 'Tungkol sa NShoptor';

  @override
  String get aboutBody =>
      'NShoptor ni Crazy Penguin. Offline-first na planner sa pamimili. May lisensyang GPL-3.0.';

  @override
  String get startShoppingLabel => 'Simulan ang pagbili';

  @override
  String get finishAndSeeResult => 'Tapusin & tingnan ang resulta';

  @override
  String get settingsTitle => 'Mga Setting';

  @override
  String get languageLabel => 'Wika';

  @override
  String get languageSystem => 'System';

  @override
  String get languageTr => 'Turko';

  @override
  String get languageEn => 'Ingles';

  @override
  String get themeLabel => 'Tema';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Maliwanag';

  @override
  String get themeDark => 'Madilim';

  @override
  String get defaultCurrencyLabel => 'Default na pera';

  @override
  String get defaultUnitLabel => 'Default na yunit';

  @override
  String get keepAwakeLabel => 'Panatiling gising ang screen habang nagbibili';

  @override
  String get backupSection => 'Backup';

  @override
  String get exportBackupLabel => 'I-export ang backup';

  @override
  String get importBackupLabel => 'I-import ang backup';

  @override
  String get mergeImportLabel => 'Isama sa kasalukuyang data';

  @override
  String get separateImportLabel => 'I-import bilang hiwalay na kopya';

  @override
  String get importCancelled => 'Nakansela ang import.';

  @override
  String get backupExported => 'Matagumpay na na-export ang backup.';

  @override
  String get backupSizeWarning =>
      'Malaking backup: maaaring malaki ang file. Gusto mo bang isama ang mga litrato?';

  @override
  String get deleteAllSection => 'Danger zone';

  @override
  String get deleteAllLabel => 'Burahin ang lahat ng data';

  @override
  String get deleteAllConfirm =>
      'Buburahin nito ang lahat ng listahan, kasaysayan, litrato ng resibo at presyo. Ang mga file na i-export mo ay mananatili sa iyong drive. Magpapatuloy ka ba?';

  @override
  String get deleteAllConfirm2 =>
      'Sigurado ka ba? Hindi na maibabalik ang aksyong ito.';

  @override
  String get cancelAction => 'Kanselahin';

  @override
  String get confirmDelete => 'Permanenteng burahin';

  @override
  String get dataDeleted => 'Na-delete ang lahat ng lokal na data.';

  @override
  String get privacyInfoLabel => 'Privacy';

  @override
  String get privacyInfoBody =>
      'Ang iyong mga listahan, presyo, resibo at litrato ay nananatili sa iyong device. Hindi lumalabas ang mga litrato at boses. Kapag naka-on ang AI help, ipinapadala lamang ang text (halimbawa, mga linya ng resibo o iyong binigkas) sa aming server para maproseso at hindi ito naii-save.';

  @override
  String get aboutSection => 'Tungkol';

  @override
  String get aboutPublisher => 'Publisher: Crazy Penguin';

  @override
  String get aboutLicenses => 'Mga Lisensya (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Voice input';

  @override
  String get voiceStatusUnknown => 'Serbisyo: hindi pa sinusuri';

  @override
  String get permissionsLabel => 'Mga Permissions';

  @override
  String get permissionsBody =>
      'Ang Camera, microphone at notifications ay hinihingi lamang kapag aktwal mong ginagamit ang mga feature na iyon.';

  @override
  String get unitsSection => 'Defaults';

  @override
  String get roundingNote =>
      'Ang money rounding ay sumusunod sa isang rule: ang kalahati ay round away from zero, inilalapat nang isang beses sa Money conversion.';

  @override
  String get voiceInputTitle => 'Voice input';

  @override
  String get voiceStartListening => 'Simulan ang pakikinig';

  @override
  String get voiceTranscriptLabel => 'Transcript';

  @override
  String get parseAction => 'I-parse';

  @override
  String get receiptReviewTitle => 'I-review ang resibo';

  @override
  String get receiptTotal => 'Kabuuang resibo';

  @override
  String get receiptTotalUnknown => 'Hindi nakita ang kabuuan';

  @override
  String get receiptDiff => 'Pagkakaiba';

  @override
  String get acceptLine => 'Tanggapin ang linya';

  @override
  String get ignoreLine => 'Ingatan ang linya';

  @override
  String get receiptLineActions => 'I-link sa item, hiwain o ingatan';

  @override
  String get receiptCommit => 'Tanggapin lahat';

  @override
  String get receiptCommitted => 'Naipatupad na ang resibo.';

  @override
  String get priceHistoryTitle => 'Kasaysayan ng presyo';

  @override
  String get noObservations => 'Wala pang obserbasyon sa presyo';

  @override
  String get templatesSection => 'Mga template';

  @override
  String get templateHint => 'Gumawa ng bagong plano mula sa nakaraang pagbili';

  @override
  String get scanReceiptAction => 'Mag-scan ng resibo';

  @override
  String get shelfLabelAction => 'Presyo mula sa label sa shelf';

  @override
  String get priceCandidatesTitle => 'Mga posibleng presyo';

  @override
  String get noPriceCandidates =>
      'Walang nahanap na presyo; ilagay ito nang manu-mano.';

  @override
  String get voiceUnavailable =>
      'Hindi available ang speech recognition; ilagay nang manu-mano.';

  @override
  String get linkToItem => 'I-link sa item';

  @override
  String get splitLine => 'Hatiin sa dalawa';

  @override
  String get mergeWithNext => 'Pagsamahin sa susunod';

  @override
  String get ocrNoText => 'Walang nabasa na teksto; subukan ulit.';

  @override
  String get priceHistoryAction => 'Kasaysayan ng presyo';

  @override
  String get itemsEmptyTitle => 'Wala pang mga item';

  @override
  String get itemsEmptyBody =>
      'Magdagdag ng unang item — doon mo ilalagay ang tunay na presyo sa tindahan.';

  @override
  String get addItemTooltip => 'Magdagdag ng item';

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
  String get unitCustom => 'Custom';

  @override
  String get setReminderAction => 'Magtakda ng paalala';

  @override
  String get reminderPermissionDenied =>
      'Kailangan ng pahintulot para sa notification upang gumana ang paalala. Maaari mo itong i-enable sa system settings.';

  @override
  String get reminderScheduled => 'Na-takda na ang paalala.';

  @override
  String get reminderCancelled => 'Tinanggal na ang paalala.';

  @override
  String get reminderTitle => 'Paalala sa pagbili';

  @override
  String reminderBody(Object title) {
    return 'Oras na para suriin ang iyong listahan: $title';
  }

  @override
  String get reminderPickDate => 'Pumili ng petsa';

  @override
  String get reminderPickTime => 'Pumili ng oras';

  @override
  String get itemDetailsSection => 'Detalye';

  @override
  String get priceOptionalHint =>
      'Opsyonal — ilalagay mo ang tunay na presyo sa tindahan';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Inirehistro: $total · $count items';
  }

  @override
  String get proActiveLabel => 'Pro active — maraming salamat!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Walang ads, mas maraming AI, backup · mula sa maliit na buwanang bayarin';

  @override
  String get proBenefitNoAds => 'Walang-ads na karanasan';

  @override
  String get proBenefitBackup => 'Backup (i-export/i-import)';

  @override
  String aboutVersion(Object version) {
    return 'Bersyon $version';
  }

  @override
  String get navDiscover => 'Discover';

  @override
  String get shareAction => 'Ibahagi ang app';

  @override
  String get rateAction => 'I-rate kami';

  @override
  String get aboutOpenRow => 'Tungkol & open source';

  @override
  String get voiceAddItemAction => 'Magdagdag gamit ang boses';

  @override
  String get formatLocaleLabel => 'Format ng numero at pera';

  @override
  String get formatLocaleSystem =>
      'Format ng device (Latin digits; kung hindi, English)';

  @override
  String get formatLocaleTr => 'Turko (1.234,56)';

  @override
  String get formatLocaleEn => 'Ingles (1,234.56)';

  @override
  String get aiToggleTitle => 'Tulong AI';

  @override
  String get aiToggleSubtitle =>
      'Ina-match ang resibo, binabasa ang label ng presyo, at ginagawa listahan mula sa pangungusap. Ang mga litrato at boses ay nananatili sa iyong device; ang teksto lamang ang pinoproseso.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Ginamit mo na ang buwanang quota ng AI ($used/$limit). Mag-upgrade para sa higit pa, o magpatuloy nang walang AI.';
  }

  @override
  String get aiOffline => 'Walang koneksyon — nagpapatuloy nang walang AI.';

  @override
  String get aiFailed =>
      'Hindi available ang AI ngayon — nagpapatuloy nang walang ito.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'Device';

  @override
  String get quickListAction => 'Magdagdag mula sa pangungusap';

  @override
  String get quickListTitle => 'Mabilis na listahan';

  @override
  String get quickListHint =>
      'hal. 1 kg mansanas 20, 2 tinapay, kalahating kilo ng keso';

  @override
  String get quickListConvert => 'I-convert sa listahan';

  @override
  String quickListAdd(int count) {
    return 'Magdagdag ng $count item';
  }

  @override
  String get quickListEmpty =>
      'Walang nahanap na item. Subukan mong ilista ang mga ito hiwalay ng comma.';

  @override
  String get receiptAiMatched =>
      'Na-match ng AI ang resibo sa iyong listahan. Tignan ang mga link at kumpirmahin.';

  @override
  String get receiptNeedsCheck => 'I-check ang match na ito';

  @override
  String get receiptDiscountLine => 'Diskwento';

  @override
  String get compareItem => 'Item';

  @override
  String get compareEstimated => 'Estimado';

  @override
  String get compareActual => 'Aktwal';

  @override
  String get compareDiff => 'Pagkakaiba';

  @override
  String get compareTotal => 'Kabuoan';

  @override
  String get compareBudget => 'Budget';

  @override
  String get compareNotBought => 'hindi bumili';

  @override
  String get compareUnplanned => 'hindi naplano';

  @override
  String get pricierItems => 'Mas mahal';

  @override
  String get cheaperItems => 'Mas murang';

  @override
  String get compareAction => 'Ihambing';

  @override
  String get detailsSection => 'Detalye';

  @override
  String get spendingTitle => 'Gastos';

  @override
  String get spendingAction => 'Gastos';

  @override
  String get spendingMonthTotal => 'Ngayong buwan';

  @override
  String get spendingWeekly => 'Lingguhang gastos';

  @override
  String get spendingMonthly => 'Buwanang gastos';

  @override
  String get monthlyLimitTitle => 'Buwanang limitasyon';

  @override
  String get monthlyLimitHelp =>
      'Gaano ka karami ang gusto mong gastusin sa pagbili kada buwan?';

  @override
  String get monthlyLimitRemove => 'Alisin';

  @override
  String get monthlyLimitSet => 'Itakda';

  @override
  String get monthlyLimitChange => 'Baguhin';

  @override
  String get monthlyLimitNone =>
      'Magtakda ng buwanang limitasyon upang makita kung magkano ang natitira.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount labas sa limitasyon';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return '$amount natitira ngayong buwan';
  }

  @override
  String get plansTitle => 'Mga Plano';

  @override
  String get plansHeadline => 'Matalinong pamimili gamit ang AI';

  @override
  String get plansSubhead =>
      'Pag-match ng resibo, label ng presyo, at listahan mula sa pangungusap. Maaaring kanselahin anumang oras.';

  @override
  String get plansMonthly => 'Buwang-buwan';

  @override
  String get plansYearly => 'Taon-taon';

  @override
  String get planFree => 'Libre';

  @override
  String get planFreePrice => 'Libre forever';

  @override
  String get planFreeAi => '15 AI requests kada buwan';

  @override
  String get planFreeAds => 'Maliit na banner ads (walang sa unang 7 araw)';

  @override
  String get planCoreFeatures =>
      'Mga listahan, presyo, resibo, chart ng gastos';

  @override
  String get plansPerYear => '/ taon';

  @override
  String get plansPerMonth => '/ buwan';

  @override
  String get planTrial => '7 araw libre';

  @override
  String get planProAi => '200 AI requests kada buwan';

  @override
  String get planNoAds => 'Walang ads';

  @override
  String get planBackup => 'I-export at i-import ang backup';

  @override
  String get planMaxAi => '1000 AI requests bawat buwan';

  @override
  String get planMaxFamily => 'Para sa malaking pamilya na pagbili';

  @override
  String get plansStoreUnavailable => 'Hindi maabot ang tindahan ngayon.';

  @override
  String get retryAction => 'Subukan ulit';

  @override
  String get plansPurchaseFailed =>
      'Hindi matagumpay ang pagbili. Pakisubukan ulit.';

  @override
  String get planLifetimeTitle => 'Walang ads habambuhay';

  @override
  String get planLifetimeSubtitle =>
      'Isang beses na bayad: walang ads, may backup; mananatiling libre ang AI allowance';

  @override
  String get plansRestore => 'Ibalik ang mga binili';

  @override
  String get plansLegal =>
      'Awtomatikong magre-renew ang subscriptions hanggang itatago. Maaaring kanselahin anumang oras sa Google Play › Payments & subscriptions. Kasama sa presyo ang mga tax na ipinapakita ng Google Play.';

  @override
  String get planCurrent => 'Kasalukuyan';

  @override
  String get planStartTrial => 'Simulan ang 7-araw na libreng trial';

  @override
  String get planChoose => 'Piliin';

  @override
  String get plansAction => 'Mga Plano: Pro at Max';

  @override
  String get assistantTitle => 'Assistant';

  @override
  String get assistantGreeting => 'Kumusta! Ano ang gustong gawin?';

  @override
  String get assistantNewList => 'Bagong listahan';

  @override
  String get assistantVoiceList => 'Listahan gamit ang boses';

  @override
  String get assistantTextList => 'Listahan mula sa pangungusap';

  @override
  String get assistantScanReceipt => 'Mag-scan ng resibo';

  @override
  String get assistantSpending => 'Ang aking gastusin';

  @override
  String get assistantReceiptHint =>
      'Buksan ang iyong listahan at i-tap ang icon ng resibo para i-scan ito.';

  @override
  String get assistantToggleTitle => 'Ipakita ang assistant';

  @override
  String get assistantToggleSubtitle =>
      'Ang maliit na katulong sa kanang ibaba';

  @override
  String get scanPriceLabel => 'I-scan ang label ng presyo';

  @override
  String get saveFailed =>
      'Hindi ma-save. Manatili pa rin ang iyong mga pagbabago. Subukan ulit.';

  @override
  String get deleteItemConfirm =>
      'Burahin ang item na ito at ang mga nakarekord na pagbili?';

  @override
  String get clearPurchaseConfirm =>
      'I-uncheck ang item na ito at burahin ang mga nakarekord na pagbili?';

  @override
  String get reportPdfAction => 'I-save ang PDF report';

  @override
  String get reportNotInvoice =>
      'Buod ng pamimili, hindi tax invoice. Hindi alam ang mga rate ng buwis.';

  @override
  String get purchaseVisits => 'Mga bisita sa pamimili';

  @override
  String get purchaseInterval => 'Karaniwang araw sa pagitan ng mga pagbili';

  @override
  String get purchasedQuantity => 'Dami ng binili';

  @override
  String get purchaseAnalyticsHint =>
      'Hindi sinusukat ng mga pagbili ang konsumpsyon. Hiwalay na ipinapakita ang mga currency at yunit.';

  @override
  String get receiptReplaces =>
      'Ang mga linked receipt line ay papalitan ang umiiral na pagbili; ang mga unlinked line ay idadagdag.';

  @override
  String get voiceUnsupportedLanguage =>
      'Hindi available ang wika na ito para sa voice input sa device na ito. Maaari kang mag-type.';

  @override
  String get voiceStopListening => 'Itigil ang pakinggan';
}
