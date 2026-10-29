// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Pushto Pashto (`ps`).
class AppLocalizationsPs extends AppLocalizations {
  AppLocalizationsPs([String locale = 'ps']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'په کور کې پلان جوړ کړئ. د پلان له مخې خرید وکړئ.';

  @override
  String get listsTitle => 'لیستونه';

  @override
  String get listsTabActive => 'فعال';

  @override
  String get listsTabCompleted => 'بشپړ شوي';

  @override
  String get listsTabArchived => 'آرشیف شوي';

  @override
  String get newListButton => 'نوی لیست';

  @override
  String get listTitleHint => 'عنوان (اختیاري)';

  @override
  String get saveButton => 'خوندي کول';

  @override
  String get cancelButton => 'لغوه کول';

  @override
  String get deleteButton => 'ړنګول';

  @override
  String get editAction => 'سمون';

  @override
  String get listDeleted => 'لیست ړنګ شو';

  @override
  String get invalidAmountError => 'نا معتبر مقدار';

  @override
  String get duplicateAction => 'تکرار';

  @override
  String get archiveAction => 'آرشیف کول';

  @override
  String get unarchiveAction => 'آرشیف لرې کول';

  @override
  String get deleteListConfirm =>
      'دا لیست ړنګ کړم؟ زما پلان شوي توکي به هم لرې شي.';

  @override
  String get undoButton => 'بیرته اخیستل';

  @override
  String get searchListHint => 'د لیستونو لټون';

  @override
  String get currencyLabel => 'پیسه';

  @override
  String get budgetLabel => 'بودیجه (اختیاري)';

  @override
  String get noteLabel => 'یادښت (اختیاري)';

  @override
  String get storeLabel => 'مخزن';

  @override
  String get keepAmountsAction => 'مقدارونه وساتئ';

  @override
  String get resetAmountsAction => 'مقدارونه بیا تنظیم کړئ';

  @override
  String get currencyChangeWarning =>
      'پیسه بدلیږي. موجود مقدارونو سره څه پیښ شي؟';

  @override
  String get listsEmpty => 'هیڅ لیست نشته. خپل لومړی خرید پلان جوړ کړئ.';

  @override
  String get statusDraft => 'مسوده';

  @override
  String get statusPlanned => 'پلان شوی';

  @override
  String get statusShopping => 'خرید';

  @override
  String get statusCompleted => 'بشپړ شوی';

  @override
  String get statusArchived => 'آرشیف شوی';

  @override
  String autoListTitle(String date) {
    return '$date خرید';
  }

  @override
  String get itemFormTitle => 'توکي اضافه کړئ';

  @override
  String get itemNameLabel => 'د توکي نوم';

  @override
  String get brandLabel => 'برانډ / ډول (اختیاري)';

  @override
  String get categoryLabel => 'صنف';

  @override
  String get quantityLabel => 'مقدار';

  @override
  String get unitLabel => 'واحد';

  @override
  String get pricingModeLabel => 'د بیه داخلول';

  @override
  String get pricingModeUnitPrice => 'د واحد بیه';

  @override
  String get pricingModeLineTotal => 'د خط مجموعي';

  @override
  String get plannedPriceLabel => 'پلان شوی بیه';

  @override
  String lineTotalCalculated(String value) {
    return 'د خط مجموعي: $value';
  }

  @override
  String get requiredItemToggle => 'اړین توکی';

  @override
  String get maxPriceLabel => 'اعظمي منلو وړ بیه (اختیاري)';

  @override
  String get itemNoteLabel => 'یادښت (اختیاري)';

  @override
  String get categoryProduce => 'میوې او سبزیجات';

  @override
  String get categoryDairy => 'شیريات';

  @override
  String get categoryMeat => 'غوښه';

  @override
  String get categoryBakery => 'نانوایی';

  @override
  String get categoryDrinks => 'مشروبات';

  @override
  String get categoryCleaning => 'خالصول';

  @override
  String get categoryPersonalCare => ' شخصي کاغذ';

  @override
  String get categoryHome => 'کور';

  @override
  String get categoryOther => 'نور';

  @override
  String get invalidQuantityError => 'نا معتبر مقدار';

  @override
  String get invalidPriceError => 'نا معتبر بیه';

  @override
  String get invalidNameError => 'نوم ولیکئ';

  @override
  String unitPriceCalculated(String value) {
    return 'واحد بیه: $value';
  }

  @override
  String get shoppingTitle => 'خرید حالت';

  @override
  String get summaryPlannedTotal => 'پلان شوې';

  @override
  String get summaryInCart => 'په کارټ کې';

  @override
  String get summaryRemainingPlan => 'پاتې پلان';

  @override
  String get summaryProjected => 'اټکل شوی تادیه';

  @override
  String get summaryBudgetRemaining => 'پاتې بودیجه';

  @override
  String get summaryBudgetOver => 'له بودیجې زیات';

  @override
  String itemsProgress(String done, String total) {
    return '$done له $total توکو څخه';
  }

  @override
  String get filterAll => 'ټول';

  @override
  String get filterToBuy => 'د خرید لپاره';

  @override
  String get filterInCart => 'په کارټ کې';

  @override
  String get filterNotFound => 'نه موندل شو';

  @override
  String get filterRequired => 'اړین';

  @override
  String get quickEntryTitle => 'اصلي بیه';

  @override
  String get actualQuantityLabel => 'اصلي مقدار';

  @override
  String get actualPriceLabel => 'اصلي بیه';

  @override
  String get discountLabel => 'تخفیف (اختیاري)';

  @override
  String get alternativeNameLabel => 'بدیل محصول نوم (اختیاري)';

  @override
  String get savePurchaseButton => 'کارټ ته اضافه کړئ';

  @override
  String get unplannedAddButton => 'غیر پلان شو توکي اضافه کړئ';

  @override
  String get statusPending => 'نه نیول شوی';

  @override
  String get statusInCart => 'په کارټ کې';

  @override
  String get statusNotFound => 'نه موندل شوی';

  @override
  String get statusGaveUp => 'پرې ایښودل شو';

  @override
  String get statusAlternative => 'بدیل واخیستل شو';

  @override
  String get keepScreenAwake => 'سکرین فعال وساتئ';

  @override
  String get finishShopping => 'خرید پای ته ورسوئ';

  @override
  String get completionWarning =>
      'بعض ریکارډونه نشت یا تایید شوي نه دي. تاسو لا هم پای ته رسولی شئ؛ پایله به یې یادونه وکړي.';

  @override
  String get continueShoppingButton => 'خرید دوام ورکړئ';

  @override
  String get resultTitle => 'پایله';

  @override
  String get summarySection => 'لنډیز';

  @override
  String get plannedTotalLabel => 'ټول پلان شوې';

  @override
  String get actualTotalLabel => 'ټول اصلي';

  @override
  String get varianceLabel => 'توپیر';

  @override
  String get varianceNotComputable => 'حساب نشي کیدی';

  @override
  String get budgetStatusLabel => 'بودیجه';

  @override
  String get savingsLabel => 'له پلان څخه کم';

  @override
  String get overspendLabel => 'له پلان څخه زیات';

  @override
  String get unplannedTotalLabel => 'ټول غیر پلان شوي';

  @override
  String get unpurchasedLabel => 'پلان شوی خو نه دی اخیستل شوی';

  @override
  String get totalDiscountLabel => 'ټول تخفیفونه';

  @override
  String get accuracyLabel => 'د اټکل دقیقوالی';

  @override
  String get groupsSection => 'توکي';

  @override
  String get groupPricier => 'له پلان څخه لوړ بیه';

  @override
  String get groupCheaper => 'له پلان څخه ارزانه';

  @override
  String get groupClose => 'اټکل ته نږدې';

  @override
  String get groupNotTaken => 'پلان شوی، نه دی اخیستل شوی';

  @override
  String get groupUnplanned => 'پرته له پلان څخه اخیستل شوی';

  @override
  String get groupQuantityChanged => 'مقدار بدل شوی';

  @override
  String get groupUnverified => 'تایید شوی نه دی';

  @override
  String get plannedQtyLabel => 'پلان شوې مقدار';

  @override
  String get actualQtyLabel => 'اصلي مقدار';

  @override
  String get plannedUnitPriceLabel => 'پلان شوې واحد بیه';

  @override
  String get actualUnitPriceLabel => 'اصلي واحد بیه';

  @override
  String get lineVarianceLabel => 'د کرښې توپیر';

  @override
  String get discountEffectLabel => 'د تخفیف اغیز';

  @override
  String get notBoughtMark => 'نه دی اخیستل شوی';

  @override
  String get noPurchasesNote => 'هیڅ خرید ثبت شوی نه دی.';

  @override
  String get navHome => 'کور';

  @override
  String get navLists => 'لیستونه';

  @override
  String get navHistory => 'تاریخچه';

  @override
  String get navSettings => 'تنظیمات';

  @override
  String get homeEmptyTitle => 'د خپلو اړتیاوو پلان جوړ کړئ';

  @override
  String get homeEmptyBody =>
      'لومړی لیست جوړ کړئ او تخمیني لګښتونه د رښتیني لګښت سره پرتله کړئ.';

  @override
  String get homeActiveSection => 'فعال لیستونه';

  @override
  String get homeCompletedSection => 'وروسته بشپړ شوي';

  @override
  String get homeMonthlySection => 'دا میاشت';

  @override
  String get monthPlannedLabel => 'تخمیني';

  @override
  String get monthActualLabel => 'رښتیني';

  @override
  String get monthVarianceLabel => 'توپیر';

  @override
  String get continueShoppingLabel => 'په خرید کې دوام ورکړئ';

  @override
  String get historyEmpty =>
      'تر اوسه هیڅ خرید بشپړ نه دی. ستاسو تاریخچه او معلومات دلته به ښکاره شي.';

  @override
  String get aboutTabTitle => 'د NShoptor په اړه';

  @override
  String get aboutBody =>
      'NShoptor له خوا Crazy Penguin. آفلاین خرید پلان جوړونکی. GPL-3.0 لایسنس لري.';

  @override
  String get startShoppingLabel => 'خرید پیل کړئ';

  @override
  String get finishAndSeeResult => 'بشپړ کړئ او پایله وګورئ';

  @override
  String get settingsTitle => 'تنظیمات';

  @override
  String get languageLabel => 'ژبه';

  @override
  String get languageSystem => 'سیسټم';

  @override
  String get languageTr => 'ترکي';

  @override
  String get languageEn => 'انګلیسي';

  @override
  String get themeLabel => 'تم';

  @override
  String get themeSystem => 'سیسټم';

  @override
  String get themeLight => 'روښانه';

  @override
  String get themeDark => 'تیاره';

  @override
  String get defaultCurrencyLabel => 'اصلي پیسه';

  @override
  String get defaultUnitLabel => 'اصلي واحد';

  @override
  String get keepAwakeLabel => 'په خرید مهال سکرین فعال وساتئ';

  @override
  String get backupSection => 'بیک اپ';

  @override
  String get exportBackupLabel => 'بیک اپ صادرول';

  @override
  String get importBackupLabel => 'بیک اپ واردول';

  @override
  String get mergeImportLabel => 'اوسني معلوماتو سره یوځای کړئ';

  @override
  String get separateImportLabel => 'جلا کاپي په توګه وارد کړئ';

  @override
  String get importCancelled => 'واردول لغوه شو.';

  @override
  String get backupExported => 'بیک اپ په بریالیتوب سره صادر شو.';

  @override
  String get deleteAllSection => 'خطرناکه سیمه';

  @override
  String get deleteAllLabel => 'ټول معلومات حذف کړئ';

  @override
  String get deleteAllConfirm =>
      'دا به ټول لیستونه، تاریخچه، د رسید عکسونه او قیمتونه لرې کړي. هغه فایلونه چې تاسو صادر کړي دي په ستاسو ډرایو کې پاتې کیږي. دوام ورکړئ؟';

  @override
  String get deleteAllConfirm2 =>
      'آیا تاسو په بشپړ ډول ډاډه یاست؟ دا عمل بیرته نشي اخیستل کیدی.';

  @override
  String get cancelAction => 'لغوه';

  @override
  String get confirmDelete => 'په تل لپاره حذف کړئ';

  @override
  String get dataDeleted => 'ټول محلي معلومات حذف شول.';

  @override
  String get privacyInfoLabel => 'محرمیت';

  @override
  String get privacyInfoBody =>
      'ستاسو لیستونه، قیمتونه، رسیدونه او عکسونه ستاسو په وسیله کې ساتل کیږي. غږ هیڅکله له هغې نه وځي. کله چې د AI مرسته فعاله وي، د رسیدونو او د قیمت لیبلونو عکسونه (کوچني شوي) او متن، لکه ویل شوي توکي، یوازې د لوستلو لپاره زموږ سرور ته لیږل کیږي؛ دوی سمدستي پروسس کیږي او هیڅکله نه ساتل کیږي.';

  @override
  String get aboutSection => 'په اړه';

  @override
  String get aboutPublisher => 'خپرونکی: Crazy Penguin';

  @override
  String get aboutLicenses => 'اجازې (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'غږیز انپوت';

  @override
  String get voiceStatusUnknown => 'خدمت: نه چک شوی';

  @override
  String get permissionsLabel => 'اجازې';

  @override
  String get permissionsBody =>
      'کیمره، مایکروفون او خبرتیاوې یوازې هغه وخت غوښتل کیږي کله چې تاسو په حقیقت کې له دې فیچرونو څخه کار واخلئ.';

  @override
  String get unitsSection => 'اصلي تنظیمات';

  @override
  String get roundingNote =>
      'د پیسو راوندنګ یوه قاعده تعقیبوي: نیمګړي له صفر څخه لرې راوند کیږي، یوازې د پیسو په تبدیل کې تطبیق کیږي.';

  @override
  String get voiceInputTitle => 'غږیز انپوت';

  @override
  String get voiceStartListening => 'اوریدل پیل کړئ';

  @override
  String get voiceTranscriptLabel => 'لیکنه';

  @override
  String get parseAction => 'تحلیل';

  @override
  String get receiptReviewTitle => 'د رسید بیاکتنه';

  @override
  String get receiptTotal => 'د رسید مجموع';

  @override
  String get receiptTotalUnknown => 'مجموع تشخیص نه شوې';

  @override
  String get receiptDiff => 'توپیر';

  @override
  String get acceptLine => 'قطعه ومنئ';

  @override
  String get ignoreLine => 'قطعه له پامه وغورځوئ';

  @override
  String get receiptLineActions => 'د توکي سره نښلول، ویشل یا له پامه غورځول';

  @override
  String get receiptCommit => 'ټول ومنئ';

  @override
  String get receiptCommitted => 'رسید تطبیق شو.';

  @override
  String get priceHistoryTitle => 'د بیه تاریخچه';

  @override
  String get noObservations => 'لا تر اوسه د بیه مشاهدات نشته';

  @override
  String get templatesSection => 'نمونې';

  @override
  String get templateHint => 'له یوه مخکینۍ خرید سفر څخه نوی پلان جوړ کړئ';

  @override
  String get scanReceiptAction => 'رسید سکن کړئ';

  @override
  String get fromReceiptListButton => 'له رسید څخه';

  @override
  String get shelfLabelAction => 'بیه د قفسې لیبل څخه';

  @override
  String get priceCandidatesTitle => 'د بیه نامزده توکي';

  @override
  String get noPriceCandidates =>
      'هیڅ بیه ونه موندل شوه؛ په لاسي ډول یې داخل کړئ.';

  @override
  String get voiceUnavailable => 'غږ پیژندنه شتون نلري؛ په لاسي ډول داخل کړئ.';

  @override
  String get linkToItem => 'د توکي سره نښلول';

  @override
  String get splitLine => 'په دوو برخو وویشئ';

  @override
  String get mergeWithNext => 'له راتلونکي سره یوځای کړئ';

  @override
  String get ocrNoText => 'هیڅ متن ولوستل شو؛ بیا هڅه وکړئ.';

  @override
  String get priceHistoryAction => 'د بیه تاریخچه';

  @override
  String get itemsEmptyTitle => 'لا تر اوسه هیڅ توکی نشته';

  @override
  String get itemsEmptyBody =>
      'خپل لومړی توکی اضافه کړئ — تاسو به په دوکان کې ریښتینې بیه دلته داخل کړئ.';

  @override
  String get addItemTooltip => 'توکی اضافه کړئ';

  @override
  String get unitAdet => 'عدد';

  @override
  String get unitKilogram => 'kg';

  @override
  String get unitGram => 'g';

  @override
  String get unitLitre => 'L';

  @override
  String get unitMililitre => 'ml';

  @override
  String get unitPaket => 'پیکټ';

  @override
  String get unitKutu => 'باکس';

  @override
  String get unitSise => 'شیشه';

  @override
  String get unitKavanoz => 'جار';

  @override
  String get unitDemet => 'ګوتی';

  @override
  String get unitDuzine => 'دوجینه';

  @override
  String get unitMetre => 'm';

  @override
  String get unitCustom => 'سفارشي';

  @override
  String get setReminderAction => 'یادونه تنظیم کړئ';

  @override
  String get reminderPermissionDenied =>
      'د یادونو لپاره د خبرتیا اجازه اړینه ده. تاسو کولی شئ دا په سیسټم تنظیماتو کې فعال کړئ.';

  @override
  String get reminderScheduled => 'یادونه تنظیم شوه.';

  @override
  String get reminderCancelled => 'یادونه لرې شوه.';

  @override
  String get reminderTitle => 'د خرید یادونه';

  @override
  String reminderBody(Object title) {
    return 'د خپل لیست چک کولو وخت: $title';
  }

  @override
  String get reminderPickDate => 'نیټه وټاکئ';

  @override
  String get reminderPickTime => 'وخت وټاکئ';

  @override
  String get itemDetailsSection => 'جزئیات';

  @override
  String get priceOptionalHint =>
      'اختیاري — تاسو به په دوکان کې ریښتینې بیه داخل کړئ';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'پلان شوی: $total · $count توکي';
  }

  @override
  String get proActiveLabel => 'Pro فعال — مننه!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'هیڅ اعلان نشته · بیک اپ صادرول او واردول · کلنی';

  @override
  String get proBenefitNoAds => 'پرېکړه تجربه';

  @override
  String get proBenefitBackup => 'بیک اپ (صادرات/واردات)';

  @override
  String aboutVersion(Object version) {
    return 'نسخه $version';
  }

  @override
  String get navDiscover => 'کشف کړئ';

  @override
  String get shareAction => 'اپ شریک کړئ';

  @override
  String get rateAction => 'موږ ته درجه ورکړئ';

  @override
  String get aboutOpenRow => 'په اړه او خلاص سورس';

  @override
  String get voiceAddItemAction => 'غږ په واسطه اضافه کړئ';

  @override
  String get formatLocaleLabel => 'د شمېرو او پیسو بڼه';

  @override
  String get formatLocaleSystem =>
      'د وسیزې فارمیټ (لاتیني شمیرې؛ نور ځایونه انګلیسي)';

  @override
  String get formatLocaleTr => 'ترکي (1.234,56)';

  @override
  String get formatLocaleEn => 'انګلیسي (1,234.56)';

  @override
  String get aiToggleTitle => 'د AI مرسته';

  @override
  String get aiToggleSubtitle =>
      'له عکسونو رسیدونه او د قیمت لیبلونه لولي، رسیدونه سره برابروي او جملې په لیستونو بدلوي. عکسونه یوازې د لوستلو لپاره لیږل کیږي او هیڅکله نه ساتل کیږي.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'تاسو د میاشتې AI غوښتنې ($used/$limit) کارولې دي. ډیرې ترلاسه کولو لپاره اپګریډ کړئ، یا پرته له AI دوام ورکړئ.';
  }

  @override
  String get aiOffline => 'هیڅ اړیکه نشته — پرته له AI دوام ورکول.';

  @override
  String get aiFailed => 'AI اوس مهال شتون نلري — پرته له هغه دوام ورکول.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'وسیله';

  @override
  String get quickListAction => 'له یوې جملې څخه اضافه کړئ';

  @override
  String get quickListTitle => 'چټک لیست';

  @override
  String get quickListHint => 'لکه: ۱ کیلو سیب ۲۰، ۲ نان، نیم کیلو پنیر';

  @override
  String get quickListConvert => 'لیست ته واړوئ';

  @override
  String quickListAdd(int count) {
    return '$count توکي اضافه کړئ';
  }

  @override
  String get quickListEmpty =>
      'هیڅ توک ونه موندل شو. هڅه وکړئ چې د کاما په واسطه جلا کړئ.';

  @override
  String get receiptAiMatched =>
      'AI ریسیټ ستاسو د لیست سره مطابقت کړ. لینکونه وګورئ او تایید کړئ.';

  @override
  String get receiptNeedsCheck => 'دا مطابکت وګورئ';

  @override
  String get receiptDiscountLine => 'تخفیف';

  @override
  String get compareItem => 'توک';

  @override
  String get compareEstimated => 'اټکل';

  @override
  String get compareActual => 'اصلي';

  @override
  String get compareDiff => 'توپیر';

  @override
  String get compareTotal => 'ټول';

  @override
  String get compareBudget => 'بودیجه';

  @override
  String get compareNotBought => 'نه دی خریدل شوی';

  @override
  String get compareUnplanned => 'نقشه نه ده شوې';

  @override
  String get pricierItems => 'لګښت یې زیات دی';

  @override
  String get cheaperItems => 'لګښت یې کم دی';

  @override
  String get compareAction => 'پرتله کول';

  @override
  String get detailsSection => 'جزئیات';

  @override
  String get spendingTitle => 'لګښت';

  @override
  String get spendingAction => 'لګښت';

  @override
  String get spendingMonthTotal => 'دا میاشت';

  @override
  String get spendingWeekly => 'اونیز لګښت';

  @override
  String get spendingMonthly => 'میاشتنی لګښت';

  @override
  String get monthlyLimitTitle => 'میاشتنی حد';

  @override
  String get monthlyLimitHelp =>
      'تاسو غواړئ په هر میاشت کې په خریداري څومره لګښت وکړئ؟';

  @override
  String get monthlyLimitRemove => 'لیرې کړئ';

  @override
  String get monthlyLimitSet => 'ټاکل';

  @override
  String get monthlyLimitChange => 'بدلول';

  @override
  String get monthlyLimitNone => 'د پاتې مقدار لیدلو لپاره یو میاشتنی حد ټاکئ.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount حد څخه زیات';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return '$amount دا میاشت پاتې دی';
  }

  @override
  String get plansTitle => 'پلانونه';

  @override
  String get plansHeadline => 'د AI سره ښه خریدارۍ وکړئ';

  @override
  String get plansSubhead =>
      'د ریسیټ مطابقت، د قیمت لیبلونه او له یوې جملې څخه لیستونه. هر وخت لغوه کیدی شي.';

  @override
  String get plansMonthly => 'میاشتنی';

  @override
  String get plansYearly => 'کلنی';

  @override
  String get planFree => 'وړیا';

  @override
  String get planFreePrice => 'تل وړیا';

  @override
  String get planFreeAi => 'پر میاشت 10 AI غوښتنې';

  @override
  String get planFreeAds => 'کوچني بانر اعلانات (لومړی ۷ ورځې هیڅ)';

  @override
  String get planCoreFeatures => 'لیستونه، قیمتونه، ریسیټونه، د لګښت چارتونه';

  @override
  String get plansPerYear => '/ کال';

  @override
  String get plansPerMonth => '/ میاشت';

  @override
  String get planTrial => 'وړیا ازموینه';

  @override
  String get planProAi => 'پر میاشت 100 AI غوښتنې';

  @override
  String get planNoAds => 'هیڅ اعلان نشته';

  @override
  String get planBackup => 'بیک اپ صادرول او واردول';

  @override
  String get planMaxAi => 'د میاشتې لپاره 300 AI غوښتنې';

  @override
  String get planMaxFamily => 'د لوی کورنۍ د خرید لپاره';

  @override
  String get plansStoreUnavailable => 'اوس مهال دوکان ته لاسرسی نشته.';

  @override
  String get retryAction => 'بیا هڅه وکړئ';

  @override
  String get plansPurchaseFailed =>
      'خرید ترسره نه شو. مهرباني وکړئ بیا هڅه وکړئ.';

  @override
  String get plansRestore => 'خریدونه بیرته راوړئ';

  @override
  String get plansLegal =>
      'Pro تر لغوه کېدو پورې هر کال په اوتومات ډول نوي کېږي او هره میاشت د مصنوعي ځیرکتیا ۱۰۰ غوښتنې لري. بنسټیزه بیه د اړوندو مالیاتو له زیاتېدو مخکې په کال کې ۱ امریکایي ډالر ده؛ د پېرود تر تایید مخکې په پلورنځي کې وروستۍ سیمه‌ییزه بیه او مالیات وګورئ. په Google Play کې ګډون اداره یا لغوه کړئ.';

  @override
  String get planCurrent => 'اوسنی';

  @override
  String get planStartTrial => 'وړیا ازموینه پیل کړئ';

  @override
  String get planChoose => 'انتخاب کړئ';

  @override
  String get plansAction => 'پلانونه: Pro';

  @override
  String get assistantTitle => 'مرسته کوونکی';

  @override
  String get assistantGreeting => 'سلام! تاسو څه غواړئ وکړئ؟';

  @override
  String get assistantNewList => 'نوی لیست';

  @override
  String get assistantVoiceList => 'غږیز لیست';

  @override
  String get assistantTextList => 'لیست له یوې جملې څخه';

  @override
  String get assistantScanReceipt => 'رسید سکن کړئ';

  @override
  String get assistantSpending => 'زما مصرف';

  @override
  String get assistantReceiptHint =>
      'خپل لیست خلاص کړئ او د سکن کولو لپاره د رسید آیکون ته ټچ وکړئ.';

  @override
  String get assistantToggleTitle => 'مرسته کوونکی ښکاره کړئ';

  @override
  String get assistantToggleSubtitle => 'د ښي لاندې کوچنی مرسته کوونکی';

  @override
  String get scanPriceLabel => 'د بیه لیبل سکین کړئ';

  @override
  String get saveFailed =>
      'نږدې کول ناموفق پاتې شول. ستاسو بدلونونه لا هم شته. بیا هڅه وکړئ.';

  @override
  String get deleteItemConfirm => 'دا توکي او د هغې ثبت شوي خریدونه حذف کړم؟';

  @override
  String get clearPurchaseConfirm =>
      'دا توکی ناسیټ کړم او د هغې ثبت شوي خریدونه لرې کړم؟';

  @override
  String get reportPdfAction => 'PDF راپور خوندي کړئ';

  @override
  String get reportNotInvoice =>
      'د خرید لنډیز، د مالیاتو انوائس نه. د مالیاتو نرخونه ناشتون دي.';

  @override
  String get purchaseVisits => 'د خرید سفرې';

  @override
  String get purchaseInterval => 'په منځ کې د خریدونو اوسط ورځې';

  @override
  String get purchasedQuantity => 'خریدل شوې مقدار';

  @override
  String get purchaseAnalyticsHint =>
      'خریدونه د مصرف اندازه نه کوي. کرنسي او واحدونه جلا ښودل کیږي.';

  @override
  String get receiptReplaces =>
      'د بې‌بیې توکو بیې ډکېږي. د بازار بیه لرونکي توکي د جلا پېرودونو په توګه زیاتېږي.';

  @override
  String get receiptIncompleteHeader =>
      'په راتلونکي انځور کې هټۍ، نېټه، وخت او د رسید شمېره شامله کړئ.';

  @override
  String get receiptIncompleteTail =>
      'بله برخه داسې انځور کړئ چې څو توکي یو پر بل ولګېږي او وروستی ټولیز مقدار ښکاره وي.';

  @override
  String get receiptContinuationRejected =>
      'دا انځور یوځای کېدای نه شو. د هماغه رسید توکي یو پر بل ولګوئ او بیا یې انځور کړئ.';

  @override
  String get receiptDraftSaved =>
      'رسید د مسودې په توګه خوندي شو. وروسته یې دوام ورکولی شئ.';

  @override
  String get receiptContinueAction => 'رسید ته دوام ورکړئ';

  @override
  String get receiptDraftsTitle => 'ناتمام رسیدونه';

  @override
  String get receiptDuplicate => 'دا رسید لا دمخه زیات شوی دی.';

  @override
  String get receiptTotalMismatch =>
      'د توکو مجموعه د رسید له ټولیز مقدار سره سمون نه خوري. وګورئ چې ټول رسید ښکاري.';

  @override
  String get receiptSaveDraftAction => 'وروسته لپاره خوندي کړئ';

  @override
  String get receiptResolveLines =>
      'د خوندي کولو مخکې هر توکی ومنئ یا یې له پامه وغورځوئ.';

  @override
  String get receiptPartialConfirm =>
      'یوازې ټاکل شوي توکي به ورزیات شي. دا رسید به د وارد شوي په توګه نښه شي. دوام ورکوئ؟';

  @override
  String get voiceUnsupportedLanguage =>
      'دا ژبه په دې وسیله کې د غږیزو داخلولو لپاره شتون نلري. تاسو کولی شئ تایپ وکړئ.';

  @override
  String get voiceStopListening => 'اوریدل ودرول';

  @override
  String get keepAwakeFailed =>
      'د سکرین ژوند ساتلو کې پاتې راغلو. مهرباني وکړئ بیا هڅه وکړئ.';

  @override
  String get purchaseHistoryHint =>
      'ټول بشپړ شوي خریدونه. بیرته ورکړل شوي توکي ټولیز قیمت کموي. نیټې د خرید د بشپړیدو نښه کوي. یوه سفر د اوسط واټن محاسبې لپاره کافی نه ده.';

  @override
  String get planLegacyRights =>
      'شته Pro او Max ګډونونه د مصنوعي ځیرکتیا د غوښتنو خپل اصلي میاشتنی حد ساتي.';

  @override
  String get csvExportAction => 'CSV صادر کړئ';

  @override
  String get reportSharePdf => 'د PDF په توګه شریکول';

  @override
  String get reportShareCsv => 'د CSV په توګه شریکول';

  @override
  String get reportPrintAction => 'چاپ';

  @override
  String get backupSizeWarning =>
      'JSON کې ریکارډونه شامل دي، د عکس فایلونه نه. د واردولو حد: ۱۶ MB.';

  @override
  String get backupImportFailed =>
      'د دې بیک اپ ایمپورٹ نشو کړی. ستاسو ډاټا نه ده بدله شوې.';

  @override
  String get backupImported => 'بیک اپ په بریالیتوب سره وارد شو.';

  @override
  String backupPreviewCounts(Object entries, Object items, Object lists) {
    return '$lists لیستونه · $items توکي · $entries خریدونه';
  }

  @override
  String get voiceModelDownloading =>
      'د دې ژبې غږیز ماډل ښکته کېږي. یوه دقیقه وروسته بیا هڅه وکړئ.';

  @override
  String get historyThisWeek => 'دا اونۍ';

  @override
  String get historyProductsSection => 'پېرل شوي توکي';

  @override
  String get tipReceiptScan => 'رسید سکن کړئ ترڅو بیې ستاسو لیست سره سمې شي';

  @override
  String get tipVoiceAdd =>
      'یو یا ډیر توکي ووایاست، بیا یې د اضافه کولو دمخه وګورئ';

  @override
  String get tipShelfCamera => 'د کیمرې په مرسته د ریک لیبل څخه بیه ولولئ';

  @override
  String get tipPlan => 'ستاسو پلان: جزییات وګورئ، ګډون وکړئ یا لوړ کړئ';

  @override
  String get guideAddBody =>
      'د توکي د اضافه کولو لپاره + کېکاږئ. پلان شوې بیه اوس او د بازار بیه د کاونټر پر مهال ولیکئ.';

  @override
  String get guideVoiceBody =>
      'مایکروفون کېکاږئ او توکي ووایاست، د بېلګې په توګه: \'۱ کیلو مڼې، ۱ ډوډۍ\'.';

  @override
  String get guideReceiptBody =>
      'رسید سکن کړئ ترڅو د هغې بیې ستاسو د لیست توکو سره سمې شي.';

  @override
  String get guidePlanBody =>
      'د پلان نښې کېکاږئ ترڅو پلان وګورئ، ګډون وکړئ یا لوړ کړئ.';

  @override
  String get guideNext => 'سم دی';

  @override
  String get guideDone => 'پیل';

  @override
  String get paletteLabel => 'د رنګ موضوع';

  @override
  String get paletteForest => 'ځنګل';

  @override
  String get paletteOcean => 'سمندر';

  @override
  String get paletteSunset => 'لمر لوېده';

  @override
  String get paletteLavender => 'لوینډر';

  @override
  String get darkBlackLabel => 'په تیاره موضوع کې بشپړ تور';

  @override
  String get spendingOverview => 'لنډه کتنه';

  @override
  String get spendingThisYear => 'سږکال';

  @override
  String get spendingYearly => 'کلنی لګښت';

  @override
  String get productSpending => 'د توکي له مخې لګښت';

  @override
  String get spanWeek => 'اونۍ';

  @override
  String get spanMonth => 'میاشت';

  @override
  String get spanYear => 'کال';

  @override
  String get weeklyLimitTitle => 'اونیز حد';

  @override
  String get weeklyLimitHelp => 'په اونۍ کې د پیرودلو لپاره څومره لګول غواړئ؟';

  @override
  String get weeklyLimitNone => 'د پاتې پیسو لیدو لپاره اونیز حد وټاکئ.';

  @override
  String weeklyLimitLeft(String amount) {
    return 'پدې اونۍ $amount پاتې';
  }

  @override
  String get shoppingLimitTitle => 'د هر پیرود حد';

  @override
  String get shoppingLimitHelp => 'نوي لیستونه په دې بودیجې پیلېږي.';

  @override
  String get shoppingLimitNone => 'د هر نوي پیرود لپاره ډیفالټ بودیجه وټاکئ.';

  @override
  String get monthlyReportAction => 'میاشتنی راپور';

  @override
  String get reportShoppingColumn => 'پیرود';

  @override
  String get reportDateColumn => 'نېټه';

  @override
  String get planUnavailable => 'اوس مهال په پلورنځي کې نشته';

  @override
  String get demoDataTitle => 'بېلګه معلومات';

  @override
  String get demoDataLoad => 'د بېلګې معلوماتو سره یې وازمویئ';

  @override
  String get demoDataLoadHelp =>
      'د تاریخچې، چارټونو او د بیو تاریخچې لیدو لپاره د ۱۲ میاشتو بېلګه پیرودونه زیاتوي.';

  @override
  String get demoDataRemove => 'بېلګه معلومات لرې کړئ';

  @override
  String get demoDataAdded => 'بېلګه معلومات زیات شول';

  @override
  String get demoDataRemoved => 'بېلګه معلومات لرې شول';

  @override
  String get demoProductApple => 'مڼې';

  @override
  String get demoProductBread => 'ډوډۍ';

  @override
  String get demoProductMilk => 'شیدې';

  @override
  String get demoProductCheese => 'پنیر';

  @override
  String get demoProductTomato => 'رومیان';

  @override
  String get demoProductEggs => 'هګۍ';

  @override
  String get demoProductCoffee => 'قهوه';

  @override
  String get demoProductDetergent => 'صابون';

  @override
  String get sendAction => 'Send';

  @override
  String get previousMonthAction => 'Previous month';

  @override
  String get nextMonthAction => 'Next month';

  @override
  String get helpSection => 'مرسته او ملاتړ';

  @override
  String get howToUseLabel => 'د کارولو لارښود';

  @override
  String get guidePricesBody =>
      'د پلورنځي بیه توکی د اخیستل شوي په توګه نښه کوي؛ 0 هم منل کېږي. د کور بیه اختیاري ده. د نښې لرې کولو لپاره د پلورنځي بیه پاکه کړئ.';

  @override
  String get shoppingDateLabel => 'د پېرود نېټه';

  @override
  String get shoppingDateNone => 'نېټه نه ده ټاکل شوې';

  @override
  String get clearShoppingDateAction => 'نېټه پاکه کړئ';

  @override
  String get listSortLabel => 'د لړ ترتیب';

  @override
  String get listSortDate => 'د پېرود نېټه';

  @override
  String get listSortAz => 'نوم (الف–ی)';

  @override
  String get listSortManual => 'لاسي ترتیب';

  @override
  String get imageCameraAction => 'عکس واخلئ';

  @override
  String get imageGalleryAction => 'له عکسونو څخه غوره کړئ';

  @override
  String get imageCaptureFailed =>
      'کمره یا عکسونه پرانیستل نه شول. د لاسرسي اجازه وګورئ او بیا هڅه وکړئ.';

  @override
  String get imageRecognitionFailed => 'عکس پروسس نه شو. بل عکس وازمویئ.';

  @override
  String get receiptNoProducts =>
      'متن ولوستل شو، خو د رسید توکي ونه موندل شول. توکي او ټول مبلغ په عکس کې شامل کړئ.';

  @override
  String get keepAwakeOn => 'سکرین به روښانه پاتې شي';

  @override
  String get keepAwakeOff => 'سکرین بندېدای شي';

  @override
  String get spanDay => 'ورځ';

  @override
  String get spanCustom => 'د نېټو موده';

  @override
  String get reportTotalSpent => 'ټول لګښت';

  @override
  String get reportAddedAt => 'د زیاتولو نېټه';

  @override
  String get reportReceiptNumber => 'د رسید شمېره';

  @override
  String get reportPreview => 'مخکتنه';

  @override
  String get reportShareAction => 'شریکول';

  @override
  String get previousPeriodAction => 'تېر پړاو';

  @override
  String get nextPeriodAction => 'راتلونکی پړاو';

  @override
  String get reportSaved => 'راپور خوندي شو.';

  @override
  String get reportZoom => 'لویول';

  @override
  String planTrialDaysLeft(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days ورځې پاتې دي',
    );
    return '$_temp0';
  }

  @override
  String planTrialHoursLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours ساعتونه پاتې دي',
    );
    return '$_temp0';
  }

  @override
  String get planTrialEndedTitle => 'ستاسو د Pro ازمایښتي موده پای ته ورسېده';

  @override
  String get planTrialEndedBody =>
      'تاسو لا هم کولای شئ لېستونه، لاسي ننوتل او د وسیلې غږ په وړیا توګه وکاروئ. Free په هره کلیزې میاشت کې ۱۰ د AI غوښتنې لري. د میاشتې ۱۰۰ د AI غوښتنو، بې‌اعلانه کارونې او شاتړ لپاره کلنی Pro وټاکئ. ستاسو اوسني معلومات به درسره پاتې شي.';

  @override
  String get planContinueFree => 'په وړیا توګه دوام ورکړئ';

  @override
  String get supportIdLabel => 'د ملاتړ پېژند';

  @override
  String get supportEmailLabel => 'د برېښنالیک له لارې ملاتړ';

  @override
  String get captureTipFirst =>
      'له بشپړ سر څخه پیل کړئ: د هټۍ نوم او نېټه باید ښکاره وي. څومره چې کولی شئ توکي شامل کړئ؛ پاتې به په راتلونکي انځور کې وي.';

  @override
  String get captureTipContinue =>
      'ورته رسید: د مخکینۍ انځور وروستی توکی شامل کړئ.';

  @override
  String get captureTipNeverShow => 'بیا مه ښایئ';

  @override
  String get captureTipOk => 'پوه شوم';

  @override
  String get captureTipsSetting => 'د رسید اخیستلو لارښوونې وښایاست';

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
  String get listReceiptsSection => 'رسیدونه';

  @override
  String get receiptStateComplete => 'بشپړ';

  @override
  String get receiptStateIncomplete => 'نیمګړی';

  @override
  String get receiptStateFailed => 'ناکام';

  @override
  String get receiptStoreUnknown => 'پلورنځی ونه لوستل شو';

  @override
  String get receiptDeleteAction => 'رسید ړنګ کړئ';

  @override
  String get receiptDeleteConfirm =>
      'دا رسید او هغه توکي چې زیات کړي دي ړنګ شي؟ وروسته یې بیا وارد کولی شئ.';

  @override
  String get receiptDeleted => 'رسید ړنګ شو.';

  @override
  String listReceiptsShowAll(int count) {
    return 'ټول وښایاست ($count)';
  }

  @override
  String get listReceiptsShowLess => 'لږ وښایاست';

  @override
  String receiptDateLabel(String date) {
    return 'د رسید نېټه: $date';
  }

  @override
  String get historyViewShopping => 'د پیرودنې له مخې';

  @override
  String get historyViewStore => 'د هټۍ له مخې';

  @override
  String get historyViewProduct => 'د محصول له مخې';

  @override
  String get historyShareAll => 'ټول شریک کړئ';

  @override
  String get historyUnknownStore => 'نامعلومه هټۍ';

  @override
  String get historyDailySpending => 'ورځنی لګښت';

  @override
  String get historyResetPeriod => 'دې اونۍ ته ستون شئ';

  @override
  String get tourSkip => 'تېرول';

  @override
  String get tourNewListBody =>
      'د پیرودلو لېست پیل کړئ او هغه څه ورزیات کړئ چې اخلئ یې.';

  @override
  String get tourFromReceiptBody =>
      'پېرود مو کړی؟ رسید د بیو سره په لېست بدل کړئ.';

  @override
  String get tourReceiptFlowBody =>
      'د رسید له سر څخه پیل وکړئ: لومړی پلورنځی او نېټه واخلئ، بیا پاتې کرښې دوام ورکړئ.';

  @override
  String get tourTabsBody =>
      'د فعالو، بشپړو او ارشیف شویو لېستونو ترمنځ واوړئ. په پای کې تڼۍ ترتیب بدلوي.';

  @override
  String get tourDiscoverBody => 'د همدې جوړونکي نور اپونه وګورئ.';

  @override
  String get tourHelpBody =>
      'د دې لارښود د بیا لیدو لپاره دلته ټک کړئ. د مجموعو او توکو د تشریح لپاره یو لېست پرانیزئ.';

  @override
  String get tourTotalsBody =>
      'پلان شوي، اصلي او توپیر مجموعې د پېرود پر مهال تازه کېږي.';

  @override
  String get tourItemsBody => 'ستاسو توکي. دلته یې ترتیب بدل کړئ یا یې ولټوئ.';
}
