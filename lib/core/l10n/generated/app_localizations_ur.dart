// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan =>
      'گھر پر منصوبہ بنائیں۔ جیسا منصوبہ بنا، ویسا ہی خریداری کریں۔';

  @override
  String get listsTitle => 'فہرستیں';

  @override
  String get listsTabActive => 'فعال';

  @override
  String get listsTabCompleted => 'مکمل شدہ';

  @override
  String get listsTabArchived => 'محفوظ شدہ';

  @override
  String get newListButton => 'نئی فہرست';

  @override
  String get listTitleHint => 'عنوان (اختیاری)';

  @override
  String get saveButton => 'محفوظ کریں';

  @override
  String get cancelButton => 'منسوخ کریں';

  @override
  String get deleteButton => 'حذف کریں';

  @override
  String get editAction => 'ترمیم';

  @override
  String get listDeleted => 'فہرست حذف ہو گئی';

  @override
  String get invalidAmountError => 'غلط رقم';

  @override
  String get duplicateAction => 'نقل کریں';

  @override
  String get archiveAction => 'محفوظ کریں';

  @override
  String get unarchiveAction => 'محفوظ شدہ سے نکالیں';

  @override
  String get deleteListConfirm =>
      'کیا آپ اس فہرست کو حذف کرنا چاہتے ہیں؟ اس کے منصوبہ بند اشیاء بھی حذف ہو جائیں گی۔';

  @override
  String get undoButton => 'واپس لیں';

  @override
  String get searchListHint => 'فہرستیں تلاش کریں';

  @override
  String get currencyLabel => 'کرنسی';

  @override
  String get budgetLabel => 'بجٹ (اختیاری)';

  @override
  String get noteLabel => 'نوٹ (اختیاری)';

  @override
  String get storeLabel => 'دکان';

  @override
  String get keepAmountsAction => 'رقموں کو برقرار رکھیں';

  @override
  String get resetAmountsAction => 'رقموں کو ری سیٹ کریں';

  @override
  String get currencyChangeWarning =>
      'کرنسی تبدیل ہو رہی ہے۔ موجودہ رقوم کے ساتھ کیا ہونا چاہیے؟';

  @override
  String get listsEmpty =>
      'ابھی تک کوئی فہرست نہیں۔ اپنی پہلی شاپنگ پلان بنائیں۔';

  @override
  String get statusDraft => 'مسودہ';

  @override
  String get statusPlanned => 'منصوبہ بند';

  @override
  String get statusShopping => 'خریداری جاری';

  @override
  String get statusCompleted => 'مکمل شدہ';

  @override
  String get statusArchived => 'محفوظ شدہ';

  @override
  String autoListTitle(String date) {
    return '$date کی شاپنگ';
  }

  @override
  String get itemFormTitle => 'آئٹم شامل کریں';

  @override
  String get itemNameLabel => 'آئٹم کا نام';

  @override
  String get brandLabel => 'برانڈ / ویرینٹ (اختیاری)';

  @override
  String get categoryLabel => 'زمرہ';

  @override
  String get quantityLabel => 'مقدار';

  @override
  String get unitLabel => 'اکائی';

  @override
  String get pricingModeLabel => 'قیمت درج کرنے کا طریقہ';

  @override
  String get pricingModeUnitPrice => 'فی اکائی قیمت';

  @override
  String get pricingModeLineTotal => 'لائن کل';

  @override
  String get plannedPriceLabel => 'منصوبہ بند قیمت';

  @override
  String lineTotalCalculated(String value) {
    return 'لائن کل: $value';
  }

  @override
  String get requiredItemToggle => 'ضروری آئٹم';

  @override
  String get maxPriceLabel => 'زیادہ سے زیادہ قابل قبول قیمت (اختیاری)';

  @override
  String get itemNoteLabel => 'نوٹ (اختیاری)';

  @override
  String get categoryProduce => 'پھل اور سبزیاں';

  @override
  String get categoryDairy => 'دیہی مصنوعات';

  @override
  String get categoryMeat => 'گوشت';

  @override
  String get categoryBakery => 'بیکنری';

  @override
  String get categoryDrinks => 'مشروبات';

  @override
  String get categoryCleaning => 'صفائی';

  @override
  String get categoryPersonalCare => 'ذاتی دیکھ بھال';

  @override
  String get categoryHome => 'گھر';

  @override
  String get categoryOther => 'دیگر';

  @override
  String get invalidQuantityError => 'غلط مقدار';

  @override
  String get invalidPriceError => 'غلط قیمت';

  @override
  String get invalidNameError => 'نام درج کریں';

  @override
  String unitPriceCalculated(String value) {
    return 'فی یونٹ قیمت: $value';
  }

  @override
  String get shoppingTitle => 'شاپنگ موڈ';

  @override
  String get summaryPlannedTotal => 'منصوبہ بند کل';

  @override
  String get summaryInCart => 'کارٹ میں';

  @override
  String get summaryRemainingPlan => 'باقی منصوبہ';

  @override
  String get summaryProjected => 'تخمینی چیک آؤٹ';

  @override
  String get summaryBudgetRemaining => 'بجٹ بچا ہوا';

  @override
  String get summaryBudgetOver => 'بجٹ سے تجاوز';

  @override
  String itemsProgress(String done, String total) {
    return '$total میں سے $done اشیاء';
  }

  @override
  String get filterAll => 'سب';

  @override
  String get filterToBuy => 'خریدنے کے لیے';

  @override
  String get filterInCart => 'کارٹ میں';

  @override
  String get filterNotFound => 'نہیں ملا';

  @override
  String get filterRequired => 'ضروری';

  @override
  String get quickEntryTitle => 'حقیقی قیمت';

  @override
  String get actualQuantityLabel => 'حقیقی مقدار';

  @override
  String get actualPriceLabel => 'حقیقی قیمت';

  @override
  String get discountLabel => 'ڈسکاؤنٹ (اختیاری)';

  @override
  String get alternativeNameLabel => 'متبادل پروڈکٹ کا نام (اختیاری)';

  @override
  String get savePurchaseButton => 'کارٹ میں شامل کریں';

  @override
  String get unplannedAddButton => 'غیر منصوبہ بند شے شامل کریں';

  @override
  String get statusPending => 'لیا نہیں گیا';

  @override
  String get statusInCart => 'کارٹ میں';

  @override
  String get statusNotFound => 'نہیں ملا';

  @override
  String get statusGaveUp => 'ہاتھ دھو لیا';

  @override
  String get statusAlternative => 'متبادل خریدا گیا';

  @override
  String get keepScreenAwake => 'اسکرین آن رکھیں';

  @override
  String get finishShopping => 'شاپنگ مکمل کریں';

  @override
  String get completionWarning =>
      'کچھ ریکارڈز غائب یا غیر تصدیق شدہ ہیں۔ آپ پھر بھی مکمل کر سکتے ہیں؛ نتیجے میں ان کی نشاندہی کی جائے گی۔';

  @override
  String get continueShoppingButton => 'شاپنگ جاری رکھیں';

  @override
  String get resultTitle => 'نتیجہ';

  @override
  String get summarySection => 'خلاصہ';

  @override
  String get plannedTotalLabel => 'منصوبہ بند کل';

  @override
  String get actualTotalLabel => 'حقیقی کل';

  @override
  String get varianceLabel => 'فرق';

  @override
  String get varianceNotComputable => 'حساب نہیں لگایا جا سکتا';

  @override
  String get budgetStatusLabel => 'بجٹ';

  @override
  String get savingsLabel => 'منصوبے سے کم خرچ';

  @override
  String get overspendLabel => 'منصوبے سے زیادہ خرچ';

  @override
  String get unplannedTotalLabel => 'غیر منصوبہ بند کل';

  @override
  String get unpurchasedLabel => 'منصوبہ بند لیکن نہ خریدی گئی';

  @override
  String get totalDiscountLabel => 'کل ڈسکاؤنٹس';

  @override
  String get accuracyLabel => 'تخمینہ کی درستگی';

  @override
  String get groupsSection => 'اشیاء';

  @override
  String get groupPricier => 'منصوبے سے مہنگی';

  @override
  String get groupCheaper => 'منصوبے سے سستی';

  @override
  String get groupClose => 'تخمینے کے قریب';

  @override
  String get groupNotTaken => 'منصوبہ بند، نہ خریدی گئی';

  @override
  String get groupUnplanned => 'بغیر منصوبے کے خریدی گئی';

  @override
  String get groupQuantityChanged => 'مقدار تبدیل ہوئی';

  @override
  String get groupUnverified => 'غیر تصدیق شدہ';

  @override
  String get plannedQtyLabel => 'منصوبہ بند مقدار';

  @override
  String get actualQtyLabel => 'حقیقی مقدار';

  @override
  String get plannedUnitPriceLabel => 'منصوبہ بند فی یونٹ قیمت';

  @override
  String get actualUnitPriceLabel => 'حقیقی فی یونٹ قیمت';

  @override
  String get lineVarianceLabel => 'لائن کا فرق';

  @override
  String get discountEffectLabel => 'ڈسکاؤنٹ کا اثر';

  @override
  String get notBoughtMark => 'نہ خریدی گئی';

  @override
  String get noPurchasesNote => 'کوئی خریداری ریکارڈ نہیں کی گئی۔';

  @override
  String get navHome => 'ہوم';

  @override
  String get navLists => 'فہرستیں';

  @override
  String get navHistory => 'تاریخچہ';

  @override
  String get navSettings => 'ترتیبات';

  @override
  String get homeEmptyTitle => 'اپنی خریداری کی منصوبہ بندی کریں';

  @override
  String get homeEmptyBody =>
      'اپنی پہلی فہرست بنائیں اور منصوبہ بند بمقابلہ اصل لاگت کا موازنہ کریں۔';

  @override
  String get homeActiveSection => 'فعال فہرستیں';

  @override
  String get homeCompletedSection => 'حال ہی میں مکمل شدہ';

  @override
  String get homeMonthlySection => 'اس مہینے';

  @override
  String get monthPlannedLabel => 'منصوبہ بند';

  @override
  String get monthActualLabel => 'اصل';

  @override
  String get monthVarianceLabel => 'فرق';

  @override
  String get continueShoppingLabel => 'خریداری جاری رکھیں';

  @override
  String get historyEmpty =>
      'ابھی تک کوئی مکمل شدہ خریداری نہیں۔ آپ کا تاریخچہ اور بصیرت یہاں ظاہر ہوگی۔';

  @override
  String get aboutTabTitle => 'NShoptor کے بارے میں';

  @override
  String get aboutBody =>
      'Crazy Penguin سے NShoptor۔ آف لائن فرسٹ شاپنگ پلانر۔ GPL-3.0 کے تحت لائسنس یافتہ۔';

  @override
  String get startShoppingLabel => 'خریداری شروع کریں';

  @override
  String get finishAndSeeResult => 'مکمل کریں اور نتیجہ دیکھیں';

  @override
  String get settingsTitle => 'ترتیبات';

  @override
  String get languageLabel => 'زبان';

  @override
  String get languageSystem => 'سسٹم';

  @override
  String get languageTr => 'ترکی';

  @override
  String get languageEn => 'انگلش';

  @override
  String get themeLabel => 'تھیم';

  @override
  String get themeSystem => 'سسٹم';

  @override
  String get themeLight => 'لائٹ';

  @override
  String get themeDark => 'ڈارک';

  @override
  String get defaultCurrencyLabel => 'ڈیفالٹ کرنسی';

  @override
  String get defaultUnitLabel => 'ڈیفالٹ یونٹ';

  @override
  String get keepAwakeLabel => 'خریداری کے دوران اسکرین آن رکھیں';

  @override
  String get backupSection => 'بیک اپ';

  @override
  String get exportBackupLabel => 'بیک اپ ایکسپورٹ کریں';

  @override
  String get importBackupLabel => 'بیک اپ امپورٹ کریں';

  @override
  String get mergeImportLabel => 'موجودہ ڈیٹا میں ضم کریں';

  @override
  String get separateImportLabel => 'ایک الگ کاپی کے طور پر امپورٹ کریں';

  @override
  String get importCancelled => 'امپورٹ منسوخ کر دیا گیا۔';

  @override
  String get backupExported => 'بیک اپ کامیابی سے ایکسپورٹ ہو گیا۔';

  @override
  String get deleteAllSection => 'خطرناک زون';

  @override
  String get deleteAllLabel => 'تمام ڈیٹا حذف کریں';

  @override
  String get deleteAllConfirm =>
      'اس سے تمام فہرستیں، تاریخچہ، رسید کی تصاویر اور قیمتیں ہٹ جائیں گی۔ آپ نے ایکسپورٹ کی گئی فائلیں آپ کے ڈرائیو پر رہیں گی۔ جاری رکھیں؟';

  @override
  String get deleteAllConfirm2 =>
      'کیا آپ بالکل یقین رکھتے ہیں؟ یہ عمل واپس نہیں کیا جا سکتا۔';

  @override
  String get cancelAction => 'منسوخ کریں';

  @override
  String get confirmDelete => 'ہمیشہ کے لیے حذف کریں';

  @override
  String get dataDeleted => 'تمام مقامی ڈیٹا حذف کر دیا گیا۔';

  @override
  String get privacyInfoLabel => 'رازداری';

  @override
  String get privacyInfoBody =>
      'آپ کی فہرستیں، قیمتیں، رسیدیں اور تصاویر آپ کے ڈیوائس پر محفوظ رہتی ہیں۔ آواز کبھی اس سے باہر نہیں جاتی۔ جب AI مدد آن ہو تو رسیدوں اور قیمت کے لیبلز کی تصاویر (سائز کم کی ہوئی) اور ٹیکسٹ، جیسے بول کر لکھوائی گئی اشیا، صرف پڑھے جانے کے لیے ہمارے سرور پر بھیجی جاتی ہیں؛ انہیں فوراً پروسیس کیا جاتا ہے اور کبھی محفوظ نہیں کیا جاتا۔';

  @override
  String get aboutSection => 'متعلقہ';

  @override
  String get aboutPublisher => 'اشاعت کار: Crazy Penguin';

  @override
  String get aboutLicenses => 'لائسنسز (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'آواز ان پٹ';

  @override
  String get voiceStatusUnknown => 'سروس: جانچ نہیں کی گئی';

  @override
  String get permissionsLabel => 'اجازتیں';

  @override
  String get permissionsBody =>
      'کیمرہ، مائیکروفون اور نوٹیفکیشنز صرف تب مانگی جاتی ہیں جب آپ واقعی ان فیچرز کا استعمال کرتے ہیں۔';

  @override
  String get unitsSection => 'ڈیفالٹس';

  @override
  String get roundingNote =>
      'پیسے کی رائونڈنگ ایک اصول پر عمل کرتی ہے: نصف صفر سے دور رائونڈ ہوتے ہیں، پیسے کی تبدیلی پر ایک بار لاگو ہوتا ہے۔';

  @override
  String get voiceInputTitle => 'آواز ان پٹ';

  @override
  String get voiceStartListening => 'سننا شروع کریں';

  @override
  String get voiceTranscriptLabel => 'ٹرانسکرپٹ';

  @override
  String get parseAction => 'پارس کریں';

  @override
  String get receiptReviewTitle => 'رسید کا جائزہ';

  @override
  String get receiptTotal => 'رسید کا کل';

  @override
  String get receiptTotalUnknown => 'کل نہیں ملا';

  @override
  String get receiptDiff => 'فرق';

  @override
  String get acceptLine => 'لائن قبول کریں';

  @override
  String get ignoreLine => 'لائن نظر انداز کریں';

  @override
  String get receiptLineActions =>
      'آئٹم سے جوڑیں، تقسیم کریں یا نظر انداز کریں';

  @override
  String get receiptCommit => 'سب قبول کریں';

  @override
  String get receiptCommitted => 'رسید لاگو ہو گئی۔';

  @override
  String get priceHistoryTitle => 'قیمت کی تاریخ';

  @override
  String get noObservations => 'ابھی تک کوئی قیمت نہیں ملی';

  @override
  String get templatesSection => 'ٹیمپلیٹس';

  @override
  String get templateHint => 'پچھلی خریداری سے نیا پلان بنائیں';

  @override
  String get scanReceiptAction => 'رسید اسکین کریں';

  @override
  String get fromReceiptListButton => 'رسید سے فہرست';

  @override
  String get shelfLabelAction => 'شیلف لیبل سے قیمت';

  @override
  String get priceCandidatesTitle => 'قیمت کے امیدوار';

  @override
  String get noPriceCandidates => 'کوئی قیمت نہیں ملی؛ خود درج کریں۔';

  @override
  String get voiceUnavailable => 'آواز کی پہچان دستیاب نہیں؛ خود درج کریں۔';

  @override
  String get linkToItem => 'آئٹم سے جوڑیں';

  @override
  String get splitLine => 'دو حصوں میں تقسیم کریں';

  @override
  String get mergeWithNext => 'اگلی کے ساتھ ملا دیں';

  @override
  String get ocrNoText => 'کوئی متن نہیں ملا؛ دوبارہ کوشش کریں۔';

  @override
  String get priceHistoryAction => 'قیمت کی تاریخ';

  @override
  String get itemsEmptyTitle => 'ابھی تک کوئی آئٹم نہیں';

  @override
  String get itemsEmptyBody =>
      'اپنا پہلا آئٹم شامل کریں — اسٹور میں اصل قیمت یہاں درج کریں گے۔';

  @override
  String get addItemTooltip => 'آئٹم شامل کریں';

  @override
  String get unitAdet => 'عدد';

  @override
  String get unitKilogram => 'کلوگرام';

  @override
  String get unitGram => 'گرام';

  @override
  String get unitLitre => 'لیٹر';

  @override
  String get unitMililitre => 'ملی لیٹر';

  @override
  String get unitPaket => 'پیکیج';

  @override
  String get unitKutu => 'باکس';

  @override
  String get unitSise => 'بوتل';

  @override
  String get unitKavanoz => 'جر';

  @override
  String get unitDemet => 'گٹھا';

  @override
  String get unitDuzine => 'ڈزن';

  @override
  String get unitMetre => 'میٹر';

  @override
  String get unitCustom => 'حسب ضرورت';

  @override
  String get setReminderAction => 'یاد دہانی سیٹ کریں';

  @override
  String get reminderPermissionDenied =>
      'یاد دہانیوں کے لیے نوٹیفیکیشن اجازت درکار ہے۔ آپ سسٹم سیٹنگز میں اسے فعال کر سکتے ہیں۔';

  @override
  String get reminderScheduled => 'یاد دہانی سیٹ ہو گئی۔';

  @override
  String get reminderCancelled => 'یاد دہانی ہٹا دی گئی۔';

  @override
  String get reminderTitle => 'خریداری کی یاد دہانی';

  @override
  String reminderBody(Object title) {
    return 'اپنی لسٹ چیک کرنے کا وقت: $title';
  }

  @override
  String get reminderPickDate => 'تاریخ منتخب کریں';

  @override
  String get reminderPickTime => 'وقت منتخب کریں';

  @override
  String get itemDetailsSection => 'تفصیلات';

  @override
  String get priceOptionalHint => 'اختیاری — اسٹور میں اصل قیمت درج کریں گے';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'منصوبہ بند: $total · $count آئٹمز';
  }

  @override
  String get proActiveLabel => 'Pro فعال — شکریہ!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'کوئی اشتہار نہیں · بیک اپ ایکسپورٹ اور امپورٹ · سالانہ';

  @override
  String get proBenefitNoAds => 'اشتہار سے پاک تجربہ';

  @override
  String get proBenefitBackup => 'بیک اپ (ایکسپورٹ/امپورٹ)';

  @override
  String aboutVersion(Object version) {
    return 'ورژن $version';
  }

  @override
  String get navDiscover => 'دریافت کریں';

  @override
  String get shareAction => 'ایپ شیئر کریں';

  @override
  String get rateAction => 'ہمیں ریٹ کریں';

  @override
  String get aboutOpenRow => 'ایپ کے بارے میں اور اوپن سورس';

  @override
  String get voiceAddItemAction => 'آواز سے شامل کریں';

  @override
  String get formatLocaleLabel => 'نمبر اور کرنسی کی فارمیٹ';

  @override
  String get formatLocaleSystem => 'ڈیوائس فارمیٹ (لینی ڈیجٹس؛ ورنہ انگریزی)';

  @override
  String get formatLocaleTr => 'ترکی (1.234,56)';

  @override
  String get formatLocaleEn => 'انگلش (1,234.56)';

  @override
  String get aiToggleTitle => 'AI مدد';

  @override
  String get aiToggleSubtitle =>
      'تصاویر سے رسیدیں اور قیمت کے لیبلز پڑھتا ہے، رسیدوں کا ملاپ کرتا ہے اور جملوں کو فہرستوں میں بدلتا ہے۔ تصاویر صرف پڑھے جانے کے لیے بھیجی جاتی ہیں اور کبھی محفوظ نہیں کی جاتیں۔';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'آپ نے اس ماہ کی AI درخواستیں استعمال کر دی ہیں ($used/$limit)۔ مزید کے لیے اپگریڈ کریں، یا AI کے بغیر جاری رکھیں۔';
  }

  @override
  String get aiOffline => 'کوئی کنکشن نہیں — AI کے بغیر جاری رہا۔';

  @override
  String get aiFailed => 'AI فی الحال دستیاب نہیں — اس کے بغیر جاری رہا۔';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'ڈیوائس';

  @override
  String get quickListAction => 'ایک جملے سے شامل کریں';

  @override
  String get quickListTitle => 'فوری لسٹ';

  @override
  String get quickListHint => 'مثلاً 1 کلو سیب 20، 2 روٹیاں، آدھا کلو پنیر';

  @override
  String get quickListConvert => 'لسٹ میں تبدیل کریں';

  @override
  String quickListAdd(int count) {
    return '$count اشیاء شامل کریں';
  }

  @override
  String get quickListEmpty =>
      'کوئی شے نہیں ملی۔ انہیں کمما سے الگ کر کے لکھنے کی کوشش کریں۔';

  @override
  String get receiptAiMatched =>
      'AI نے رسید کو آپ کی لسٹ سے ملا دیا ہے۔ لنکس چیک کریں اور تصدیق کریں۔';

  @override
  String get receiptNeedsCheck => 'اس میچ کو چیک کریں';

  @override
  String get receiptDiscountLine => 'ڈسکاؤنٹ';

  @override
  String get compareItem => 'شے';

  @override
  String get compareEstimated => 'تخمینہ';

  @override
  String get compareActual => 'حقیقی';

  @override
  String get compareDiff => 'فرق';

  @override
  String get compareTotal => 'کل';

  @override
  String get compareBudget => 'بجٹ';

  @override
  String get compareNotBought => 'خریدا نہیں گیا';

  @override
  String get compareUnplanned => 'منصوبہ بند نہیں تھا';

  @override
  String get pricierItems => 'زیادہ خرچ ہوئے';

  @override
  String get cheaperItems => 'کم خرچ ہوئے';

  @override
  String get compareAction => 'موازنہ کریں';

  @override
  String get detailsSection => 'تفصیلات';

  @override
  String get spendingTitle => 'خرچ';

  @override
  String get spendingAction => 'خرچ';

  @override
  String get spendingMonthTotal => 'اس ماہ';

  @override
  String get spendingWeekly => 'ہفتہ وار خرچ';

  @override
  String get spendingMonthly => 'ماہوار خرچ';

  @override
  String get monthlyLimitTitle => 'ماہوار حد';

  @override
  String get monthlyLimitHelp =>
      'آپ ماہوار خریداری پر کتنا خرچ کرنا چاہتے ہیں؟';

  @override
  String get monthlyLimitRemove => 'ہٹائیں';

  @override
  String get monthlyLimitSet => 'سیٹ کریں';

  @override
  String get monthlyLimitChange => 'بدلیں';

  @override
  String get monthlyLimitNone =>
      'باقی رقم دیکھنے کے لیے ایک ماہوار حد مقرر کریں۔';

  @override
  String monthlyLimitOver(String amount) {
    return 'حد سے $amount زیادہ';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return 'اس ماہ $amount باقی';
  }

  @override
  String get plansTitle => 'پلانز';

  @override
  String get plansHeadline => 'AI کے ساتھ بہتر شاپنگ کریں';

  @override
  String get plansSubhead =>
      'رسید میلان، قیمت کے لیبل اور جملے سے لسٹ۔ کسی بھی وقت منسوخ کریں۔';

  @override
  String get plansMonthly => 'ماہوار';

  @override
  String get plansYearly => 'سالانہ';

  @override
  String get planFree => 'مفت';

  @override
  String get planFreePrice => 'ہمیشہ مفت';

  @override
  String get planFreeAi => 'ماہانہ 10 AI درخواستیں';

  @override
  String get planFreeAds => 'چھوٹی بینر اشتہارات (پہلے 7 دنوں میں کوئی نہیں)';

  @override
  String get planCoreFeatures => 'لسٹیں، قیمتیں، رسیدیں، خرچ گراف';

  @override
  String get plansPerYear => '/ سال';

  @override
  String get plansPerMonth => '/ ماہ';

  @override
  String get planTrial => 'مفت ٹرائل';

  @override
  String get planProAi => 'ماہانہ 100 AI درخواستیں';

  @override
  String get planNoAds => 'کوئی اشتہار نہیں';

  @override
  String get planBackup => 'بیک اپ ایکسپورٹ اور امپورٹ';

  @override
  String get planMaxAi => 'ماہانہ 300 AI درخواستیں';

  @override
  String get planMaxFamily => 'بڑی خاندانی خریداری کے لیے';

  @override
  String get plansStoreUnavailable => 'دکان فی الحال دستیاب نہیں ہے۔';

  @override
  String get retryAction => 'دوبارہ کوشش کریں';

  @override
  String get plansPurchaseFailed =>
      'خریداری کامیاب نہیں ہوئی۔ براہ کرم دوبارہ کوشش کریں۔';

  @override
  String get plansRestore => 'خریداری بحال کریں';

  @override
  String get plansLegal =>
      'Pro منسوخ ہونے تک ہر سال خودکار طور پر تجدید ہوتا ہے اور ہر ماہ ۱۰۰ AI درخواستیں شامل ہیں۔ قابلِ اطلاق ٹیکسوں سے پہلے بنیادی قیمت سالانہ ۱ امریکی ڈالر ہے؛ خریداری کی تصدیق سے پہلے اسٹور میں حتمی مقامی قیمت اور ٹیکس دیکھیں۔ Google Play میں سبسکرپشن کا نظم کریں یا اسے منسوخ کریں۔';

  @override
  String get planCurrent => 'موجودہ';

  @override
  String get planStartTrial => 'مفت ٹرائل شروع کریں';

  @override
  String get planChoose => 'منتخب کریں';

  @override
  String get plansAction => 'پلانز: Pro';

  @override
  String get assistantTitle => 'اسسٹنٹ';

  @override
  String get assistantGreeting => 'ہیلو! آپ کیا کرنا چاہیں گے؟';

  @override
  String get assistantNewList => 'نئی فہرست';

  @override
  String get assistantVoiceList => 'آواز سے فہرست بنائیں';

  @override
  String get assistantTextList => 'جملے سے فہرست بنائیں';

  @override
  String get assistantScanReceipt => 'رسید اسکین کریں';

  @override
  String get assistantSpending => 'میری خرچہ';

  @override
  String get assistantReceiptHint =>
      'اپنی فہرست کھولیں اور اسے اسکین کرنے کے لیے رسید آئیکن پر ٹیپ کریں۔';

  @override
  String get assistantToggleTitle => 'اسسٹنٹ دکھائیں';

  @override
  String get assistantToggleSubtitle => 'نیچے دائیں جانب چھوٹا مددگار';

  @override
  String get scanPriceLabel => 'قیمت کا لیبل اسکین کریں';

  @override
  String get saveFailed =>
      'محفوظ نہیں ہو سکا۔ آپ کی تبدیلیاں ابھی بھی موجود ہیں۔ براہ کرم دوبارہ کوشش کریں۔';

  @override
  String get deleteItemConfirm =>
      'کیا آپ اس آئٹم اور اس کی ریکارڈ شدہ خریداریوں کو حذف کرنا چاہتے ہیں؟';

  @override
  String get clearPurchaseConfirm =>
      'کیا آپ اس آئٹم کو غیر منتخب کر کے اس کی ریکارڈ شدہ خریداریوں کو ہٹانا چاہتے ہیں؟';

  @override
  String get reportPdfAction => 'PDF رپورٹ محفوظ کریں';

  @override
  String get reportNotInvoice =>
      'خریداری کا خلاصہ، ٹیکس انوائس نہیں۔ ٹیکس ریٹس نامعلوم ہیں۔';

  @override
  String get purchaseVisits => 'خریداری کے دورے';

  @override
  String get purchaseInterval => 'خریداریوں کے درمیان اوسط دن';

  @override
  String get purchasedQuantity => 'خریدا گیا مقدار';

  @override
  String get purchaseAnalyticsHint =>
      'خریداریاں استعمال کی پیمائش نہیں کرتیں۔ کرنسیاں اور اکائیاں الگ دکھائی جاتی ہیں۔';

  @override
  String get receiptReplaces =>
      'بغیر قیمت والی اشیا کی قیمت درج ہو جائے گی۔ بازار کی قیمت والی اشیا الگ خریداری کے طور پر شامل ہوں گی۔';

  @override
  String get receiptIncompleteHeader =>
      'اگلی تصویر میں دکان، تاریخ، وقت اور رسید نمبر شامل کریں۔';

  @override
  String get receiptIncompleteTail =>
      'اگلا حصہ ایسی تصویر میں لیں جس میں چند اشیا ایک دوسرے پر آتی ہوں اور آخری کل رقم نظر آئے۔';

  @override
  String get receiptContinuationRejected =>
      'یہ تصویر جوڑی نہیں جا سکی۔ اسی رسید کی اشیا کو ایک دوسرے پر رکھتے ہوئے دوبارہ تصویر لیں۔';

  @override
  String get receiptDraftSaved =>
      'رسید مسودے کے طور پر محفوظ ہو گئی۔ آپ بعد میں جاری رکھ سکتے ہیں۔';

  @override
  String get receiptContinueAction => 'رسید جاری رکھیں';

  @override
  String get receiptDraftsTitle => 'نامکمل رسیدیں';

  @override
  String get receiptDuplicate => 'یہ رسید پہلے ہی شامل ہے۔';

  @override
  String get receiptTotalMismatch =>
      'اشیا کا مجموعہ رسید کی کل رقم سے نہیں ملتا۔ دیکھیں کہ پوری رسید نظر آ رہی ہے۔';

  @override
  String get receiptSaveDraftAction => 'بعد کے لیے محفوظ کریں';

  @override
  String get receiptResolveLines =>
      'محفوظ کرنے سے پہلے ہر چیز قبول کریں یا نظرانداز کریں۔';

  @override
  String get receiptPartialConfirm =>
      'صرف منتخب کردہ اشیا شامل کی جائیں گی۔ اس رسید کو درآمد شدہ کے طور پر نشان زد کیا جائے گا۔ جاری رکھیں؟';

  @override
  String get voiceUnsupportedLanguage =>
      'اس ڈیوائس پر آواز کے ذریعے ان زبان کے لیے ان پٹ دستیاب نہیں ہے۔ آپ ٹائپ کر سکتے ہیں۔';

  @override
  String get voiceStopListening => 'سننا بند کریں';

  @override
  String get keepAwakeFailed =>
      'اسکرین کو زندہ نہیں رکھا جا سکا۔ براہ کرم دوبارہ کوشش کریں۔';

  @override
  String get purchaseHistoryHint =>
      'تمام مکمل شاپنگ۔ واپسی کل رقم میں کمی لاتے ہیں۔ تاریخیں شاپنگ کی تکمیل سے متعلق ہیں۔ ایک دورہ اوسط وقفہ کا حساب لگانے کے لیے کافی نہیں ہے۔';

  @override
  String get planLegacyRights =>
      'موجودہ Pro اور Max سبسکرپشنز کی AI درخواستوں کی اصل ماہانہ حد برقرار رہے گی۔';

  @override
  String get csvExportAction => 'CSV برآمد کریں';

  @override
  String get reportSharePdf => 'PDF کے طور پر شیئر کریں';

  @override
  String get reportShareCsv => 'CSV کے طور پر شیئر کریں';

  @override
  String get reportPrintAction => 'پرنٹ کریں';

  @override
  String get backupSizeWarning =>
      'JSON میں ریکارڈز شامل ہیں، فائلیں نہیں۔ امپورٹ کی حد: 16 MB.';

  @override
  String get backupImportFailed =>
      'اس بیک اپ کو درآمد نہیں کیا جا سکا۔ آپ کا ڈیٹا تبدیل نہیں ہوا۔';

  @override
  String get backupImported => 'بیک اپ کامیابی سے درآمد ہو گیا۔';

  @override
  String backupPreviewCounts(Object entries, Object items, Object lists) {
    return '$lists لسٹیں · $items آئٹمز · $entries خریداریاں';
  }

  @override
  String get voiceModelDownloading =>
      'اس زبان کا وائس ماڈل ڈاؤن لوڈ ہو رہا ہے۔ ایک منٹ بعد دوبارہ کوشش کریں۔';

  @override
  String get historyThisWeek => 'اس ہفتے';

  @override
  String get historyProductsSection => 'خریدی گئی مصنوعات';

  @override
  String get tipReceiptScan =>
      'رسید اسکین کریں اور قیمتیں اپنی فہرست سے ملائیں';

  @override
  String get tipVoiceAdd =>
      'ایک یا زیادہ چیزیں بولیں، پھر شامل کرنے سے پہلے جانچ لیں';

  @override
  String get tipShelfCamera => 'کیمرے سے شیلف لیبل کی قیمت پڑھیں';

  @override
  String get tipPlan =>
      'آپ کا پلان: تفصیلات دیکھیں، سبسکرائب کریں یا اپ گریڈ کریں';

  @override
  String get guideAddBody =>
      'چیز شامل کرنے کے لیے + دبائیں۔ منصوبہ بند قیمت ابھی اور بازار کی قیمت کاؤنٹر پر درج کریں۔';

  @override
  String get guideVoiceBody =>
      'مائیک دبائیں اور چیزیں بولیں، مثلاً: \'1 کلو سیب، 1 ڈبل روٹی\'۔';

  @override
  String get guideReceiptBody =>
      'رسید اسکین کریں تاکہ اس کی قیمتیں آپ کی فہرست کی چیزوں سے ملیں۔';

  @override
  String get guidePlanBody =>
      'پلان کا آئیکن دبائیں تاکہ پلان دیکھیں، سبسکرائب کریں یا اپ گریڈ کریں۔';

  @override
  String get guideNext => 'ٹھیک ہے';

  @override
  String get guideDone => 'شروع کریں';

  @override
  String get paletteLabel => 'رنگ تھیم';

  @override
  String get paletteForest => 'جنگل';

  @override
  String get paletteOcean => 'سمندر';

  @override
  String get paletteSunset => 'غروبِ آفتاب';

  @override
  String get paletteLavender => 'لیونڈر';

  @override
  String get darkBlackLabel => 'ڈارک تھیم میں مکمل سیاہ';

  @override
  String get spendingOverview => 'جائزہ';

  @override
  String get spendingThisYear => 'اس سال';

  @override
  String get spendingYearly => 'سالانہ خرچ';

  @override
  String get productSpending => 'چیز کے لحاظ سے خرچ';

  @override
  String get spanWeek => 'ہفتہ';

  @override
  String get spanMonth => 'مہینہ';

  @override
  String get spanYear => 'سال';

  @override
  String get weeklyLimitTitle => 'ہفتہ وار حد';

  @override
  String get weeklyLimitHelp => 'ہفتے میں خریداری پر کتنا خرچ کرنا چاہتے ہیں؟';

  @override
  String get weeklyLimitNone =>
      'کتنا باقی ہے دیکھنے کے لیے ہفتہ وار حد مقرر کریں۔';

  @override
  String weeklyLimitLeft(String amount) {
    return 'اس ہفتے $amount باقی';
  }

  @override
  String get shoppingLimitTitle => 'ہر خریداری کی حد';

  @override
  String get shoppingLimitHelp => 'نئی فہرستیں اسی بجٹ سے شروع ہوتی ہیں۔';

  @override
  String get shoppingLimitNone =>
      'ہر نئی خریداری کے لیے پہلے سے طے شدہ بجٹ مقرر کریں۔';

  @override
  String get monthlyReportAction => 'ماہانہ رپورٹ';

  @override
  String get reportShoppingColumn => 'خریداری';

  @override
  String get reportDateColumn => 'تاریخ';

  @override
  String get planUnavailable => 'ابھی اسٹور میں دستیاب نہیں';

  @override
  String get demoDataTitle => 'نمونہ ڈیٹا';

  @override
  String get demoDataLoad => 'نمونہ ڈیٹا کے ساتھ آزمائیں';

  @override
  String get demoDataLoadHelp =>
      'تاریخ، چارٹ اور قیمتوں کی تاریخ دیکھنے کے لیے 12 ماہ کی نمونہ خریداری شامل کرتا ہے۔';

  @override
  String get demoDataRemove => 'نمونہ ڈیٹا ہٹائیں';

  @override
  String get demoDataAdded => 'نمونہ ڈیٹا شامل ہو گیا';

  @override
  String get demoDataRemoved => 'نمونہ ڈیٹا ہٹا دیا گیا';

  @override
  String get demoProductApple => 'سیب';

  @override
  String get demoProductBread => 'ڈبل روٹی';

  @override
  String get demoProductMilk => 'دودھ';

  @override
  String get demoProductCheese => 'پنیر';

  @override
  String get demoProductTomato => 'ٹماٹر';

  @override
  String get demoProductEggs => 'انڈے';

  @override
  String get demoProductCoffee => 'کافی';

  @override
  String get demoProductDetergent => 'ڈٹرجنٹ';

  @override
  String get sendAction => 'Send';

  @override
  String get previousMonthAction => 'Previous month';

  @override
  String get nextMonthAction => 'Next month';

  @override
  String get helpSection => 'مدد اور معاونت';

  @override
  String get howToUseLabel => 'استعمال کا طریقہ';

  @override
  String get guidePricesBody =>
      'دکان کی قیمت درج کرنے سے چیز خریدی ہوئی نشان زد ہوتی ہے؛ 0 بھی درست ہے۔ گھر کی قیمت اختیاری ہے۔ نشان ہٹانے کے لیے دکان کی قیمت مٹا دیں۔';

  @override
  String get shoppingDateLabel => 'خریداری کی تاریخ';

  @override
  String get shoppingDateNone => 'کوئی تاریخ منتخب نہیں';

  @override
  String get clearShoppingDateAction => 'تاریخ ہٹائیں';

  @override
  String get listSortLabel => 'فہرست کی ترتیب';

  @override
  String get listSortDate => 'خریداری کی تاریخ';

  @override
  String get listSortAz => 'نام (الف–ے)';

  @override
  String get listSortManual => 'دستی ترتیب';

  @override
  String get imageCameraAction => 'تصویر لیں';

  @override
  String get imageGalleryAction => 'تصاویر میں سے منتخب کریں';

  @override
  String get imageCaptureFailed =>
      'کیمرہ یا تصاویر نہیں کھولی جا سکیں۔ رسائی کی اجازت چیک کریں اور دوبارہ کوشش کریں۔';

  @override
  String get imageRecognitionFailed =>
      'تصویر پر کارروائی نہیں ہو سکی۔ کوئی دوسری تصویر آزمائیں۔';

  @override
  String get receiptNoProducts =>
      'متن پڑھ لیا گیا، لیکن رسید کی اشیا نہیں ملیں۔ تصویر میں اشیا اور کل رقم شامل کریں۔';

  @override
  String get keepAwakeOn => 'اسکرین آن رہے گی';

  @override
  String get keepAwakeOff => 'اسکرین بند ہو سکتی ہے';

  @override
  String get spanDay => 'دن';

  @override
  String get spanCustom => 'تاریخ کی حد';

  @override
  String get reportTotalSpent => 'کل خرچ';

  @override
  String get reportAddedAt => 'شامل کرنے کی تاریخ';

  @override
  String get reportReceiptNumber => 'رسید نمبر';

  @override
  String get reportPreview => 'پیش نظارہ';

  @override
  String get reportShareAction => 'شیئر کریں';

  @override
  String get previousPeriodAction => 'پچھلی مدت';

  @override
  String get nextPeriodAction => 'اگلی مدت';

  @override
  String get reportSaved => 'رپورٹ محفوظ ہو گئی۔';

  @override
  String get reportZoom => 'بڑا کریں';

  @override
  String planTrialDaysLeft(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days دن باقی',
    );
    return '$_temp0';
  }

  @override
  String planTrialHoursLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours گھنٹے باقی',
    );
    return '$_temp0';
  }

  @override
  String get planTrialEndedTitle => 'آپ کا Pro آزمائشی عرصہ ختم ہو گیا ہے';

  @override
  String get planTrialEndedBody =>
      'آپ فہرستیں، دستی اندراج اور ڈیوائس پر آواز مفت استعمال کرتے رہ سکتے ہیں۔ Free میں ہر کیلنڈر ماہ 10 AI درخواستیں شامل ہیں۔ ماہانہ 100 AI درخواستوں، اشتہارات کے بغیر استعمال اور بیک اپ کے لیے سالانہ Pro منتخب کریں۔ آپ کا موجودہ ڈیٹا آپ کے پاس رہے گا۔';

  @override
  String get planContinueFree => 'Free جاری رکھیں';

  @override
  String get supportIdLabel => 'سپورٹ ID';

  @override
  String get supportEmailLabel => 'ای میل سپورٹ';

  @override
  String get captureTipFirst =>
      'بالکل اوپر سے شروع کریں: دکان کا نام اور تاریخ نظر آنی چاہیے۔ جتنی ہو سکے اشیا شامل کریں؛ باقی اگلی تصویر میں آئیں گی۔';

  @override
  String get captureTipContinue =>
      'وہی رسید: پچھلی تصویر کی آخری شے شامل کریں۔';

  @override
  String get captureTipNeverShow => 'دوبارہ نہ دکھائیں';

  @override
  String get captureTipOk => 'سمجھ گیا';

  @override
  String get captureTipsSetting => 'رسید کھینچنے کے مشورے دکھائیں';

  @override
  String get tourSkip => 'چھوڑیں';

  @override
  String get tourNewListBody =>
      'خریداری کی فہرست شروع کریں اور جو خریدنا ہے شامل کریں۔';

  @override
  String get tourFromReceiptBody =>
      'خریداری کر چکے؟ رسید کو اس کی قیمتوں کے ساتھ فہرست میں بدلیں۔';

  @override
  String get tourReceiptFlowBody =>
      'رسید کے اوپر سے شروع کریں: پہلے دکان اور تاریخ لیں، پھر باقی سطروں کے ساتھ جاری رکھیں۔';

  @override
  String get tourTabsBody =>
      'فعال، مکمل اور محفوظ شدہ فہرستوں کے درمیان جائیں۔ آخر والا بٹن ترتیب بدلتا ہے۔';

  @override
  String get tourDiscoverBody => 'اسی ڈویلپر کی مزید ایپس دیکھیں۔';

  @override
  String get tourHelpBody =>
      'یہ رہنمائی دوبارہ دیکھنے کے لیے یہاں تھپتھپائیں۔ مجموعے اور اشیا کی وضاحت کے لیے کوئی فہرست کھولیں۔';

  @override
  String get tourTotalsBody =>
      'منصوبہ بند، اصل اور فرق کے مجموعے خریداری کے دوران اپ ڈیٹ ہوتے ہیں۔';

  @override
  String get tourItemsBody =>
      'آپ کی اشیا۔ یہاں ان کی ترتیب بدلیں یا انہیں تلاش کریں۔';
}
