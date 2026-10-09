// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'خطّط في البيت. تسوّق كما خطّطت.';

  @override
  String get listsTitle => 'القوائم';

  @override
  String get listsTabActive => 'النشطة';

  @override
  String get listsTabCompleted => 'المكتملة';

  @override
  String get listsTabArchived => 'المؤرشفة';

  @override
  String get newListButton => 'قائمة جديدة';

  @override
  String get listTitleHint => 'العنوان (اختياري)';

  @override
  String get saveButton => 'حفظ';

  @override
  String get cancelButton => 'إلغاء';

  @override
  String get deleteButton => 'حذف';

  @override
  String get editAction => 'تعديل';

  @override
  String get listDeleted => 'تم حذف القائمة';

  @override
  String get invalidAmountError => 'مبلغ غير صالح';

  @override
  String get duplicateAction => 'تكرار';

  @override
  String get archiveAction => 'أرشفة';

  @override
  String get unarchiveAction => 'إلغاء الأرشفة';

  @override
  String get deleteListConfirm =>
      'حذف هذه القائمة؟ ستُحذف العناصر المخطط لها أيضًا.';

  @override
  String get undoButton => 'تراجع';

  @override
  String get searchListHint => 'ابحث في القوائم';

  @override
  String get currencyLabel => 'العملة';

  @override
  String get budgetLabel => 'الميزانية (اختياري)';

  @override
  String get noteLabel => 'ملاحظة (اختياري)';

  @override
  String get storeLabel => 'المتجر';

  @override
  String get keepAmountsAction => 'الإبقاء على المبالغ';

  @override
  String get resetAmountsAction => 'إعادة ضبط المبالغ';

  @override
  String get currencyChangeWarning =>
      'ستتغير العملة. ماذا نفعل بالمبالغ الحالية؟';

  @override
  String get listsEmpty => 'لا توجد قوائم بعد. أنشئ أول خطة تسوّق.';

  @override
  String get statusDraft => 'مسودة';

  @override
  String get statusPlanned => 'مخطط لها';

  @override
  String get statusShopping => 'قيد التسوّق';

  @override
  String get statusCompleted => 'مكتملة';

  @override
  String get statusArchived => 'مؤرشفة';

  @override
  String autoListTitle(String date) {
    return 'تسوّق $date';
  }

  @override
  String get itemFormTitle => 'إضافة عنصر';

  @override
  String get itemNameLabel => 'اسم العنصر';

  @override
  String get brandLabel => 'العلامة / النوع (اختياري)';

  @override
  String get categoryLabel => 'الفئة';

  @override
  String get quantityLabel => 'الكمية';

  @override
  String get unitLabel => 'الوحدة';

  @override
  String get pricingModeLabel => 'إدخال السعر';

  @override
  String get pricingModeUnitPrice => 'سعر الوحدة';

  @override
  String get pricingModeLineTotal => 'السعر الإجمالي';

  @override
  String get plannedPriceLabel => 'السعر المخطط';

  @override
  String lineTotalCalculated(String value) {
    return 'الإجمالي: $value';
  }

  @override
  String get requiredItemToggle => 'عنصر ضروري';

  @override
  String get maxPriceLabel => 'أعلى سعر مقبول (اختياري)';

  @override
  String get itemNoteLabel => 'ملاحظة (اختياري)';

  @override
  String get categoryProduce => 'فواكه وخضروات';

  @override
  String get categoryDairy => 'ألبان';

  @override
  String get categoryMeat => 'لحوم';

  @override
  String get categoryBakery => 'مخبوزات';

  @override
  String get categoryDrinks => 'مشروبات';

  @override
  String get categoryCleaning => 'منظفات';

  @override
  String get categoryPersonalCare => 'عناية شخصية';

  @override
  String get categoryHome => 'المنزل';

  @override
  String get categoryOther => 'أخرى';

  @override
  String get invalidQuantityError => 'كمية غير صالحة';

  @override
  String get invalidPriceError => 'سعر غير صالح';

  @override
  String get invalidNameError => 'أدخل اسمًا';

  @override
  String unitPriceCalculated(String value) {
    return 'سعر الوحدة: $value';
  }

  @override
  String get shoppingTitle => 'وضع التسوّق';

  @override
  String get summaryPlannedTotal => 'المخطط';

  @override
  String get summaryInCart => 'في السلة';

  @override
  String get summaryRemainingPlan => 'المتبقي من الخطة';

  @override
  String get summaryProjected => 'الحساب المتوقع';

  @override
  String get summaryBudgetRemaining => 'المتبقي من الميزانية';

  @override
  String get summaryBudgetOver => 'تجاوز الميزانية';

  @override
  String itemsProgress(String done, String total) {
    return '$done من $total عناصر';
  }

  @override
  String get filterAll => 'الكل';

  @override
  String get filterToBuy => 'للشراء';

  @override
  String get filterInCart => 'في السلة';

  @override
  String get filterNotFound => 'غير موجود';

  @override
  String get filterRequired => 'ضروري';

  @override
  String get quickEntryTitle => 'السعر الفعلي';

  @override
  String get actualQuantityLabel => 'الكمية الفعلية';

  @override
  String get actualPriceLabel => 'السعر الفعلي';

  @override
  String get discountLabel => 'الخصم (اختياري)';

  @override
  String get alternativeNameLabel => 'اسم المنتج البديل (اختياري)';

  @override
  String get savePurchaseButton => 'أضف إلى السلة';

  @override
  String get unplannedAddButton => 'إضافة عنصر غير مخطط';

  @override
  String get statusPending => 'لم يُؤخذ';

  @override
  String get statusInCart => 'في السلة';

  @override
  String get statusNotFound => 'غير موجود';

  @override
  String get statusGaveUp => 'تم العدول';

  @override
  String get statusAlternative => 'اشتُري بديل';

  @override
  String get keepScreenAwake => 'إبقاء الشاشة مضاءة';

  @override
  String get finishShopping => 'إنهاء التسوّق';

  @override
  String get completionWarning =>
      'هناك سجلات ناقصة أو غير مؤكدة. يمكنك الإنهاء على أي حال، وستُذكر في النتيجة.';

  @override
  String get continueShoppingButton => 'متابعة التسوّق';

  @override
  String get resultTitle => 'النتيجة';

  @override
  String get summarySection => 'الملخص';

  @override
  String get plannedTotalLabel => 'الإجمالي المخطط';

  @override
  String get actualTotalLabel => 'الإجمالي الفعلي';

  @override
  String get varianceLabel => 'الفرق';

  @override
  String get varianceNotComputable => 'لا يمكن حسابه';

  @override
  String get budgetStatusLabel => 'الميزانية';

  @override
  String get savingsLabel => 'أقل من الخطة';

  @override
  String get overspendLabel => 'أعلى من الخطة';

  @override
  String get unplannedTotalLabel => 'إجمالي غير المخطط';

  @override
  String get unpurchasedLabel => 'مخطط ولم يُشترَ';

  @override
  String get totalDiscountLabel => 'إجمالي الخصومات';

  @override
  String get accuracyLabel => 'دقة التقدير';

  @override
  String get groupsSection => 'العناصر';

  @override
  String get groupPricier => 'أغلى من المخطط';

  @override
  String get groupCheaper => 'أرخص من المخطط';

  @override
  String get groupClose => 'قريب من التقدير';

  @override
  String get groupNotTaken => 'مخطط ولم يُشترَ';

  @override
  String get groupUnplanned => 'اشتُري دون خطة';

  @override
  String get groupQuantityChanged => 'تغيرت الكمية';

  @override
  String get groupUnverified => 'غير مؤكد';

  @override
  String get plannedQtyLabel => 'الكمية المخططة';

  @override
  String get actualQtyLabel => 'الكمية الفعلية';

  @override
  String get plannedUnitPriceLabel => 'سعر الوحدة المخطط';

  @override
  String get actualUnitPriceLabel => 'سعر الوحدة الفعلي';

  @override
  String get lineVarianceLabel => 'الفرق';

  @override
  String get discountEffectLabel => 'أثر الخصم';

  @override
  String get notBoughtMark => 'لم يُشترَ';

  @override
  String get noPurchasesNote => 'لم تُسجّل أي مشتريات.';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navLists => 'القوائم';

  @override
  String get navHistory => 'السجل';

  @override
  String get navSettings => 'الإعدادات';

  @override
  String get homeEmptyTitle => 'خطّط لتسوّقك';

  @override
  String get homeEmptyBody => 'أنشئ قائمتك الأولى وقارن المخطط بالفعلي.';

  @override
  String get homeActiveSection => 'القوائم النشطة';

  @override
  String get homeCompletedSection => 'المكتملة مؤخرًا';

  @override
  String get homeMonthlySection => 'هذا الشهر';

  @override
  String get monthPlannedLabel => 'المخطط';

  @override
  String get monthActualLabel => 'الفعلي';

  @override
  String get monthVarianceLabel => 'الفرق';

  @override
  String get continueShoppingLabel => 'متابعة التسوّق';

  @override
  String get historyEmpty =>
      'لا يوجد تسوّق مكتمل بعد. سيظهر سجلك وتحليلاتك هنا.';

  @override
  String get aboutTabTitle => 'حول NShoptor';

  @override
  String get aboutBody =>
      'NShoptor من Crazy Penguin. مخطط تسوّق يعمل دون اتصال. مرخّص بموجب GPL-3.0.';

  @override
  String get startShoppingLabel => 'ابدأ التسوّق';

  @override
  String get finishAndSeeResult => 'إنهاء وعرض النتيجة';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get languageLabel => 'اللغة';

  @override
  String get languageSystem => 'لغة النظام';

  @override
  String get languageTr => 'التركية';

  @override
  String get languageEn => 'الإنجليزية';

  @override
  String get themeLabel => 'المظهر';

  @override
  String get themeSystem => 'حسب النظام';

  @override
  String get themeLight => 'فاتح';

  @override
  String get themeDark => 'داكن';

  @override
  String get defaultCurrencyLabel => 'العملة الافتراضية';

  @override
  String get defaultUnitLabel => 'الوحدة الافتراضية';

  @override
  String get keepAwakeLabel => 'إبقاء الشاشة مضاءة أثناء التسوّق';

  @override
  String get backupSection => 'النسخ الاحتياطي';

  @override
  String get exportBackupLabel => 'تصدير نسخة احتياطية';

  @override
  String get importBackupLabel => 'استيراد نسخة احتياطية';

  @override
  String get mergeImportLabel => 'دمج مع البيانات الحالية';

  @override
  String get separateImportLabel => 'استيراد كنسخة منفصلة';

  @override
  String get importCancelled => 'أُلغي الاستيراد.';

  @override
  String get backupExported => 'تم تصدير النسخة الاحتياطية بنجاح.';

  @override
  String get backupSizeWarning =>
      'نسخة كبيرة: قد يكون الملف كبيرًا. هل تريد تضمين الصور أيضًا؟';

  @override
  String get deleteAllSection => 'منطقة الخطر';

  @override
  String get deleteAllLabel => 'حذف كل البيانات';

  @override
  String get deleteAllConfirm =>
      'سيؤدي ذلك إلى حذف كل القوائم والسجل وصور الإيصالات والأسعار. الملفات التي صدّرتها تبقى كما هي. متابعة؟';

  @override
  String get deleteAllConfirm2 =>
      'هل أنت متأكد تمامًا؟ لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get cancelAction => 'إلغاء';

  @override
  String get confirmDelete => 'حذف نهائي';

  @override
  String get dataDeleted => 'تم حذف كل البيانات المحلية.';

  @override
  String get privacyInfoLabel => 'الخصوصية';

  @override
  String get privacyInfoBody =>
      'تبقى قوائمك وأسعارك وإيصالاتك وصورك على جهازك. الصور والصوت لا يغادرانه أبدًا. عند تفعيل مساعدة الذكاء الاصطناعي، يُرسل النص فقط (مثل أسطر الإيصال أو ما أمليته) إلى خادمنا لمعالجته دون حفظه.';

  @override
  String get aboutSection => 'حول';

  @override
  String get aboutPublisher => 'الناشر: Crazy Penguin';

  @override
  String get aboutLicenses => 'التراخيص (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'الإدخال الصوتي';

  @override
  String get voiceStatusUnknown => 'الخدمة: لم يتم التحقق';

  @override
  String get permissionsLabel => 'الأذونات';

  @override
  String get permissionsBody =>
      'تُطلب الكاميرا والميكروفون والإشعارات فقط عند استخدامك لهذه الميزات.';

  @override
  String get unitsSection => 'الافتراضيات';

  @override
  String get roundingNote =>
      'تُقرّب المبالغ بقاعدة واحدة: الأنصاف بعيدًا عن الصفر، مرة واحدة عند التحويل.';

  @override
  String get voiceInputTitle => 'الإدخال الصوتي';

  @override
  String get voiceStartListening => 'ابدأ الاستماع';

  @override
  String get voiceTranscriptLabel => 'النص';

  @override
  String get parseAction => 'تحليل';

  @override
  String get receiptReviewTitle => 'مراجعة الإيصال';

  @override
  String get receiptTotal => 'إجمالي الإيصال';

  @override
  String get receiptTotalUnknown => 'لم يُكتشف الإجمالي';

  @override
  String get receiptDiff => 'الفرق';

  @override
  String get acceptLine => 'قبول السطر';

  @override
  String get ignoreLine => 'تجاهل السطر';

  @override
  String get receiptLineActions => 'ربط بعنصر أو تقسيم أو تجاهل';

  @override
  String get receiptCommit => 'قبول الكل';

  @override
  String get receiptCommitted => 'تم تطبيق الإيصال.';

  @override
  String get priceHistoryTitle => 'سجل الأسعار';

  @override
  String get noObservations => 'لا توجد أسعار مسجلة بعد';

  @override
  String get templatesSection => 'القوالب';

  @override
  String get templateHint => 'أنشئ خطة جديدة من تسوّق سابق';

  @override
  String get scanReceiptAction => 'مسح الإيصال';

  @override
  String get shelfLabelAction => 'السعر من ملصق الرف';

  @override
  String get priceCandidatesTitle => 'أسعار مقترحة';

  @override
  String get noPriceCandidates => 'لم يُعثر على سعر؛ أدخله يدويًا.';

  @override
  String get voiceUnavailable => 'التعرف على الكلام غير متاح؛ أدخل يدويًا.';

  @override
  String get linkToItem => 'ربط بعنصر';

  @override
  String get splitLine => 'تقسيم إلى اثنين';

  @override
  String get mergeWithNext => 'دمج مع التالي';

  @override
  String get ocrNoText => 'لم يُقرأ أي نص؛ حاول مرة أخرى.';

  @override
  String get priceHistoryAction => 'سجل الأسعار';

  @override
  String get itemsEmptyTitle => 'لا توجد عناصر بعد';

  @override
  String get itemsEmptyBody =>
      'أضف أول عنصر – ستُدخل الأسعار الحقيقية هنا في المتجر.';

  @override
  String get addItemTooltip => 'إضافة عنصر';

  @override
  String get unitAdet => 'قطعة';

  @override
  String get unitKilogram => 'كغ';

  @override
  String get unitGram => 'غ';

  @override
  String get unitLitre => 'لتر';

  @override
  String get unitMililitre => 'مل';

  @override
  String get unitPaket => 'عبوة';

  @override
  String get unitKutu => 'علبة';

  @override
  String get unitSise => 'زجاجة';

  @override
  String get unitKavanoz => 'مرطبان';

  @override
  String get unitDemet => 'حزمة';

  @override
  String get unitDuzine => 'دزينة';

  @override
  String get unitMetre => 'م';

  @override
  String get unitCustom => 'مخصصة';

  @override
  String get setReminderAction => 'ضبط تذكير';

  @override
  String get reminderPermissionDenied =>
      'تحتاج التذكيرات إلى إذن الإشعارات. يمكنك تفعيله من إعدادات النظام.';

  @override
  String get reminderScheduled => 'تم ضبط التذكير.';

  @override
  String get reminderCancelled => 'تمت إزالة التذكير.';

  @override
  String get reminderTitle => 'تذكير بالتسوّق';

  @override
  String reminderBody(Object title) {
    return 'حان وقت مراجعة قائمتك: $title';
  }

  @override
  String get reminderPickDate => 'اختر تاريخًا';

  @override
  String get reminderPickTime => 'اختر وقتًا';

  @override
  String get itemDetailsSection => 'التفاصيل';

  @override
  String get priceOptionalHint => 'اختياري – ستُدخل السعر الحقيقي في المتجر';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'المخطط: $total · $count عناصر';
  }

  @override
  String get proActiveLabel => 'Pro مفعّل – شكرًا لك!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'بلا إعلانات، ذكاء اصطناعي أكثر، نسخ احتياطي · بسعر شهري صغير';

  @override
  String get proBenefitNoAds => 'بلا إعلانات';

  @override
  String get proBenefitBackup => 'نسخ احتياطي (تصدير/استيراد)';

  @override
  String aboutVersion(Object version) {
    return 'الإصدار $version';
  }

  @override
  String get navDiscover => 'اكتشف';

  @override
  String get shareAction => 'مشاركة التطبيق';

  @override
  String get rateAction => 'قيّمنا';

  @override
  String get aboutOpenRow => 'حول التطبيق والمصدر المفتوح';

  @override
  String get voiceAddItemAction => 'إضافة بالصوت';

  @override
  String get formatLocaleLabel => 'تنسيق الأرقام والعملة';

  @override
  String get formatLocaleSystem => 'تنسيق الجهاز (أرقام لاتينية؛ وإلا إنجليزي)';

  @override
  String get formatLocaleTr => 'التركية (1.234,56)';

  @override
  String get formatLocaleEn => 'الإنجليزية (1,234.56)';

  @override
  String get aiToggleTitle => 'مساعدة الذكاء الاصطناعي';

  @override
  String get aiToggleSubtitle =>
      'يطابق الإيصالات ويقرأ ملصقات الأسعار ويحوّل الجمل إلى قوائم. تبقى الصور والصوت على جهازك؛ يُعالَج النص فقط.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'استخدمت طلبات الذكاء الاصطناعي لهذا الشهر ($used/$limit). رقِّ خطتك للمزيد أو تابع دون ذكاء اصطناعي.';
  }

  @override
  String get aiOffline => 'لا يوجد اتصال – المتابعة دون ذكاء اصطناعي.';

  @override
  String get aiFailed => 'الذكاء الاصطناعي غير متاح الآن – المتابعة من دونه.';

  @override
  String get aiSourceLabel => 'ذكاء اصطناعي';

  @override
  String get deviceSourceLabel => 'الجهاز';

  @override
  String get quickListAction => 'إضافة من جملة';

  @override
  String get quickListTitle => 'قائمة سريعة';

  @override
  String get quickListHint => 'مثال: 1 كغ تفاح 10، رغيفا خبز، نصف كيلو جبن';

  @override
  String get quickListConvert => 'حوّلها إلى قائمة';

  @override
  String quickListAdd(int count) {
    return 'إضافة $count عناصر';
  }

  @override
  String get quickListEmpty => 'لم يُعثر على عناصر. افصل بينها بفواصل.';

  @override
  String get receiptAiMatched =>
      'طابق الذكاء الاصطناعي الإيصال مع قائمتك. راجع الروابط ثم أكّد.';

  @override
  String get receiptNeedsCheck => 'راجع هذه المطابقة';

  @override
  String get receiptDiscountLine => 'خصم';

  @override
  String get compareItem => 'العنصر';

  @override
  String get compareEstimated => 'التقديري';

  @override
  String get compareActual => 'الفعلي';

  @override
  String get compareDiff => 'الفرق';

  @override
  String get compareTotal => 'الإجمالي';

  @override
  String get compareBudget => 'الميزانية';

  @override
  String get compareNotBought => 'لم يُشترَ';

  @override
  String get compareUnplanned => 'غير مخطط';

  @override
  String get pricierItems => 'الأغلى';

  @override
  String get cheaperItems => 'الأرخص';

  @override
  String get compareAction => 'مقارنة';

  @override
  String get detailsSection => 'التفاصيل';

  @override
  String get spendingTitle => 'المصروفات';

  @override
  String get spendingAction => 'المصروفات';

  @override
  String get spendingMonthTotal => 'هذا الشهر';

  @override
  String get spendingWeekly => 'المصروف الأسبوعي';

  @override
  String get spendingMonthly => 'المصروف الشهري';

  @override
  String get monthlyLimitTitle => 'الحد الشهري';

  @override
  String get monthlyLimitHelp => 'كم تريد أن تنفق على التسوّق شهريًا؟';

  @override
  String get monthlyLimitRemove => 'إزالة';

  @override
  String get monthlyLimitSet => 'تحديد';

  @override
  String get monthlyLimitChange => 'تغيير';

  @override
  String get monthlyLimitNone => 'حدّد حدًا شهريًا لترى كم تبقّى لك.';

  @override
  String monthlyLimitOver(String amount) {
    return 'تجاوز الحد بمقدار $amount';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return 'تبقّى $amount هذا الشهر';
  }

  @override
  String get plansTitle => 'الخطط';

  @override
  String get plansHeadline => 'تسوّق بذكاء مع الذكاء الاصطناعي';

  @override
  String get plansSubhead =>
      'مطابقة الإيصالات وملصقات الأسعار وقوائم من جملة واحدة. ألغِ في أي وقت.';

  @override
  String get plansMonthly => 'شهري';

  @override
  String get plansYearly => 'سنوي';

  @override
  String get planFree => 'مجاني';

  @override
  String get planFreePrice => 'مجاني دائمًا';

  @override
  String get planFreeAi => '15 طلب ذكاء اصطناعي شهريًا';

  @override
  String get planFreeAds => 'إعلانات بانر صغيرة (لا إعلانات في أول 7 أيام)';

  @override
  String get planCoreFeatures => 'قوائم وأسعار وإيصالات ورسوم بيانية للمصروف';

  @override
  String get plansPerYear => '/ سنة';

  @override
  String get plansPerMonth => '/ شهر';

  @override
  String get planTrial => '7 أيام مجانًا';

  @override
  String get planProAi => '200 طلب ذكاء اصطناعي شهريًا';

  @override
  String get planNoAds => 'بلا إعلانات';

  @override
  String get planBackup => 'تصدير واستيراد النسخ الاحتياطية';

  @override
  String get planMaxAi => '1000 طلب ذكاء اصطناعي شهريًا';

  @override
  String get planMaxFamily => 'لتسوّق العائلات الكبير';

  @override
  String get plansStoreUnavailable => 'تعذّر الوصول إلى المتجر الآن.';

  @override
  String get retryAction => 'إعادة المحاولة';

  @override
  String get plansPurchaseFailed => 'لم تكتمل عملية الشراء. حاول مرة أخرى.';

  @override
  String get planLifetimeTitle => 'بلا إعلانات مدى الحياة';

  @override
  String get planLifetimeSubtitle =>
      'دفعة واحدة: بلا إعلانات ونسخ احتياطي؛ يبقى الذكاء الاصطناعي ضمن الحصة المجانية';

  @override
  String get plansRestore => 'استعادة المشتريات';

  @override
  String get plansLegal =>
      'تتجدد الاشتراكات تلقائيًا حتى إلغائها. يمكنك الإلغاء في أي وقت من Google Play › المدفوعات والاشتراكات. تشمل الأسعار الضرائب التي يعرضها Google Play.';

  @override
  String get planCurrent => 'الحالية';

  @override
  String get planStartTrial => 'جرّب مجانًا 7 أيام';

  @override
  String get planChoose => 'اختيار';

  @override
  String get plansAction => 'الخطط: Pro وMax';

  @override
  String get assistantTitle => 'المساعد';

  @override
  String get assistantGreeting => 'مرحبًا! ماذا تريد أن تفعل؟';

  @override
  String get assistantNewList => 'قائمة جديدة';

  @override
  String get assistantVoiceList => 'قائمة بالصوت';

  @override
  String get assistantTextList => 'قائمة من جملة';

  @override
  String get assistantScanReceipt => 'مسح إيصال';

  @override
  String get assistantSpending => 'مصروفاتي';

  @override
  String get assistantReceiptHint =>
      'افتح قائمتك واضغط على أيقونة الإيصال لمسحه.';

  @override
  String get assistantToggleTitle => 'إظهار المساعد';

  @override
  String get assistantToggleSubtitle => 'المساعد الصغير أسفل اليمين';

  @override
  String get scanPriceLabel => 'امسح ملصق السعر';

  @override
  String get saveFailed =>
      'تعذّر الحفظ. لا تزال التغييرات موجودة. يرجى المحاولة مرة أخرى.';

  @override
  String get deleteItemConfirm => 'حذف هذا العنصر ومشترياته المسجلة؟';

  @override
  String get clearPurchaseConfirm =>
      'إلغاء تحديد هذا العنصر وإزالة مشترياته المسجلة؟';

  @override
  String get reportPdfAction => 'حفظ تقرير بصيغة PDF';

  @override
  String get reportNotInvoice =>
      'ملخص التسوق، وليس فاتورة ضريبية. أسعار الضرائب غير معروفة.';

  @override
  String get purchaseVisits => 'زيارات التسوق';

  @override
  String get purchaseInterval => 'متوسط الأيام بين المشتريات';

  @override
  String get purchasedQuantity => 'الكمية المشتراة';

  @override
  String get purchaseAnalyticsHint =>
      'لا تقيس المشتريات الاستهلاك. تُعرض العملات والوحدات بشكل منفصل.';

  @override
  String get receiptReplaces =>
      'تستبدل أسطر الإيصال المرتبطة المشتريات الموجودة؛ وتُضاف الأسطر غير المرتبطة.';

  @override
  String get voiceUnsupportedLanguage =>
      'هذه اللغة غير متاحة للإدخال الصوتي على هذا الجهاز. يمكنك الكتابة بدلاً من ذلك.';

  @override
  String get voiceStopListening => 'توقف عن الاستماع';
}
