// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'برنامه‌ریزی در خانه، خرید طبق برنامه.';

  @override
  String get listsTitle => 'لیست‌ها';

  @override
  String get listsTabActive => 'فعال';

  @override
  String get listsTabCompleted => 'تکمیل‌شده';

  @override
  String get listsTabArchived => 'بایگانی‌شده';

  @override
  String get newListButton => 'لیست جدید';

  @override
  String get listTitleHint => 'عنوان (اختیاری)';

  @override
  String get saveButton => 'ذخیره';

  @override
  String get cancelButton => 'انصراف';

  @override
  String get deleteButton => 'حذف';

  @override
  String get editAction => 'ویرایش';

  @override
  String get listDeleted => 'لیست حذف شد';

  @override
  String get invalidAmountError => 'مقدار نامعتبر است';

  @override
  String get duplicateAction => 'تکرار';

  @override
  String get archiveAction => 'بایگانی';

  @override
  String get unarchiveAction => 'از بایگانی خارج کردن';

  @override
  String get deleteListConfirm =>
      'این لیست حذف شود؟ آیتم‌های برنامه‌ریزی‌شده آن نیز حذف خواهند شد.';

  @override
  String get undoButton => 'واگرد';

  @override
  String get searchListHint => 'جستجوی لیست‌ها';

  @override
  String get currencyLabel => 'واحد پول';

  @override
  String get budgetLabel => 'بودجه (اختیاری)';

  @override
  String get noteLabel => 'یادداشت (اختیاری)';

  @override
  String get storeLabel => 'فروشگاه';

  @override
  String get keepAmountsAction => 'نگه داشتن مقادیر';

  @override
  String get resetAmountsAction => 'بازنشانی مقادیر';

  @override
  String get currencyChangeWarning =>
      'واحد پول در حال تغییر است. با مقادیر موجود چه باید کرد؟';

  @override
  String get listsEmpty =>
      'هنوز لیستی وجود ندارد. اولین برنامه خرید خود را ایجاد کنید.';

  @override
  String get statusDraft => 'پیش‌نویس';

  @override
  String get statusPlanned => 'برنامه‌ریزی‌شده';

  @override
  String get statusShopping => 'در حال خرید';

  @override
  String get statusCompleted => 'تکمیل‌شده';

  @override
  String get statusArchived => 'بایگانی‌شده';

  @override
  String autoListTitle(String date) {
    return 'خرید $date';
  }

  @override
  String get itemFormTitle => 'افزودن قلم';

  @override
  String get itemNameLabel => 'نام قلم';

  @override
  String get brandLabel => 'برند / نوع (اختیاری)';

  @override
  String get categoryLabel => 'دسته‌بندی';

  @override
  String get quantityLabel => 'تعداد';

  @override
  String get unitLabel => 'واحد';

  @override
  String get pricingModeLabel => 'روش وارد کردن قیمت';

  @override
  String get pricingModeUnitPrice => 'قیمت واحد';

  @override
  String get pricingModeLineTotal => 'جمع سطر';

  @override
  String get plannedPriceLabel => 'قیمت برنامه‌ریزی‌شده';

  @override
  String lineTotalCalculated(String value) {
    return 'جمع سطر: $value';
  }

  @override
  String get requiredItemToggle => 'قلم ضروری';

  @override
  String get maxPriceLabel => 'حداکثر قیمت قابل قبول (اختیاری)';

  @override
  String get itemNoteLabel => 'یادداشت (اختیاری)';

  @override
  String get categoryProduce => 'میوه و سبزیجات';

  @override
  String get categoryDairy => 'لبنیات';

  @override
  String get categoryMeat => 'گوشت';

  @override
  String get categoryBakery => 'نان و شیرینی';

  @override
  String get categoryDrinks => 'نوشیدنی‌ها';

  @override
  String get categoryCleaning => 'مواد شوینده';

  @override
  String get categoryPersonalCare => 'مراقبت شخصی';

  @override
  String get categoryHome => 'خانه';

  @override
  String get categoryOther => 'سایر';

  @override
  String get invalidQuantityError => 'تعداد نامعتبر است';

  @override
  String get invalidPriceError => 'قیمت نامعتبر است';

  @override
  String get invalidNameError => 'یک نام وارد کنید';

  @override
  String unitPriceCalculated(String value) {
    return 'قیمت واحد: $value';
  }

  @override
  String get shoppingTitle => 'حالت خرید';

  @override
  String get summaryPlannedTotal => 'برنامه‌ریزی شده';

  @override
  String get summaryInCart => 'در سبد';

  @override
  String get summaryRemainingPlan => 'باقی‌مانده برنامه';

  @override
  String get summaryProjected => 'مجموع تخمینی';

  @override
  String get summaryBudgetRemaining => 'بودجه باقی‌مانده';

  @override
  String get summaryBudgetOver => 'از بودجه بیشتر';

  @override
  String itemsProgress(String done, String total) {
    return '$done از $total قلم';
  }

  @override
  String get filterAll => 'همه';

  @override
  String get filterToBuy => 'خریدنی';

  @override
  String get filterInCart => 'در سبد';

  @override
  String get filterNotFound => 'پیدا نشد';

  @override
  String get filterRequired => 'ضروری';

  @override
  String get quickEntryTitle => 'قیمت واقعی';

  @override
  String get actualQuantityLabel => 'مقدار واقعی';

  @override
  String get actualPriceLabel => 'قیمت واقعی';

  @override
  String get discountLabel => 'تخفیف (اختیاری)';

  @override
  String get alternativeNameLabel => 'نام محصول جایگزین (اختیاری)';

  @override
  String get savePurchaseButton => 'افزودن به سبد';

  @override
  String get unplannedAddButton => 'افزودن قلم غیربرنامه‌ریزی شده';

  @override
  String get statusPending => 'برداشته نشده';

  @override
  String get statusInCart => 'در سبد';

  @override
  String get statusNotFound => 'پیدا نشد';

  @override
  String get statusGaveUp => 'صرف‌نظر شد';

  @override
  String get statusAlternative => 'جایگزین خریداری شد';

  @override
  String get keepScreenAwake => 'روشن ماندن صفحه';

  @override
  String get finishShopping => 'پایان خرید';

  @override
  String get completionWarning =>
      'سوابق ناقص یا تأییدنشده وجود دارد. می‌توانید ادامه دهید؛ نتیجه آن‌ها را یادآوری می‌کند.';

  @override
  String get continueShoppingButton => 'ادامه خرید';

  @override
  String get resultTitle => 'نتیجه';

  @override
  String get summarySection => 'خلاصه';

  @override
  String get plannedTotalLabel => 'مجموع برنامه‌ریزی شده';

  @override
  String get actualTotalLabel => 'مجموع واقعی';

  @override
  String get varianceLabel => 'تفاوت';

  @override
  String get varianceNotComputable => 'قابل محاسبه نیست';

  @override
  String get budgetStatusLabel => 'بودجه';

  @override
  String get savingsLabel => 'کمتر از برنامه';

  @override
  String get overspendLabel => 'بیشتر از برنامه';

  @override
  String get unplannedTotalLabel => 'مجموع غیربرنامه‌ریزی شده';

  @override
  String get unpurchasedLabel => 'برنامه‌ریزی شده اما خریداری نشده';

  @override
  String get totalDiscountLabel => 'کل تخفیف‌ها';

  @override
  String get accuracyLabel => 'دقت تخمین';

  @override
  String get groupsSection => 'اقلام';

  @override
  String get groupPricier => 'گران‌تر از برنامه';

  @override
  String get groupCheaper => 'ارزان‌تر از برنامه';

  @override
  String get groupClose => 'نزدیک به تخمین';

  @override
  String get groupNotTaken => 'برنامه‌ریزی شده، خریداری نشده';

  @override
  String get groupUnplanned => 'خریداری شده بدون برنامه';

  @override
  String get groupQuantityChanged => 'تغییر مقدار';

  @override
  String get groupUnverified => 'تأییدنشده';

  @override
  String get plannedQtyLabel => 'مقدار برنامه‌ریزی شده';

  @override
  String get actualQtyLabel => 'مقدار واقعی';

  @override
  String get plannedUnitPriceLabel => 'قیمت واحد برنامه‌ریزی شده';

  @override
  String get actualUnitPriceLabel => 'قیمت واحد واقعی';

  @override
  String get lineVarianceLabel => 'تفاوت خط';

  @override
  String get discountEffectLabel => 'اثر تخفیف';

  @override
  String get notBoughtMark => 'خریداری نشده';

  @override
  String get noPurchasesNote => 'هیچ خریدی ثبت نشده است.';

  @override
  String get navHome => 'خانه';

  @override
  String get navLists => 'لیست‌ها';

  @override
  String get navHistory => 'تاریخچه';

  @override
  String get navSettings => 'تنظیمات';

  @override
  String get homeEmptyTitle => 'خرید خود را برنامه‌ریزی کنید';

  @override
  String get homeEmptyBody =>
      'اولین لیست خود را ایجاد کنید و هزینه‌های برنامه‌ریزی شده را با هزینه‌های واقعی مقایسه کنید.';

  @override
  String get homeActiveSection => 'لیست‌های فعال';

  @override
  String get homeCompletedSection => 'تکمیل‌شده‌های اخیر';

  @override
  String get homeMonthlySection => 'این ماه';

  @override
  String get monthPlannedLabel => 'برنامه‌ریزی‌شده';

  @override
  String get monthActualLabel => 'واقعی';

  @override
  String get monthVarianceLabel => 'اختلاف';

  @override
  String get continueShoppingLabel => 'ادامه خرید';

  @override
  String get historyEmpty =>
      'هنوز هیچ خرید تکمیل‌شده‌ای وجود ندارد. تاریخچه و بینش‌های شما اینجا نمایش داده می‌شود.';

  @override
  String get aboutTabTitle => 'درباره NShoptor';

  @override
  String get aboutBody =>
      'NShoptor توسط Crazy Penguin. برنامه‌ریز خرید آفلاین-اول. مجاز تحت GPL-3.0.';

  @override
  String get startShoppingLabel => 'شروع خرید';

  @override
  String get finishAndSeeResult => 'پایان و مشاهده نتیجه';

  @override
  String get settingsTitle => 'تنظیمات';

  @override
  String get languageLabel => 'زبان';

  @override
  String get languageSystem => 'سیستم';

  @override
  String get languageTr => 'ترکی';

  @override
  String get languageEn => 'انگلیسی';

  @override
  String get themeLabel => 'تم';

  @override
  String get themeSystem => 'سیستم';

  @override
  String get themeLight => 'روشن';

  @override
  String get themeDark => 'تیره';

  @override
  String get defaultCurrencyLabel => 'ارز پیش‌فرض';

  @override
  String get defaultUnitLabel => 'واحد پیش‌فرض';

  @override
  String get keepAwakeLabel => 'روشن نگه داشتن صفحه هنگام خرید';

  @override
  String get backupSection => 'پشتیبان‌گیری';

  @override
  String get exportBackupLabel => 'خروجی پشتیبان';

  @override
  String get importBackupLabel => 'ورودی پشتیبان';

  @override
  String get mergeImportLabel => 'ادغام با داده‌های فعلی';

  @override
  String get separateImportLabel => 'وارد کردن به عنوان یک کپی جداگانه';

  @override
  String get importCancelled => 'وارد کردن لغو شد.';

  @override
  String get backupExported => 'پشتیبان با موفقیت صادر شد.';

  @override
  String get deleteAllSection => 'منطقه خطرناک';

  @override
  String get deleteAllLabel => 'حذف تمام داده‌ها';

  @override
  String get deleteAllConfirm =>
      'این کار تمام لیست‌ها، تاریخچه، عکس‌های رسید و قیمت‌ها را حذف می‌کند. فایل‌هایی که شما صادر کرده‌اید روی درایو شما باقی می‌مانند. ادامه می‌دهید؟';

  @override
  String get deleteAllConfirm2 =>
      'آیا کاملاً مطمئن هستید؟ این عمل قابل بازگشت نیست.';

  @override
  String get cancelAction => 'لغو';

  @override
  String get confirmDelete => 'حذف دائمی';

  @override
  String get dataDeleted => 'تمام داده‌های محلی حذف شدند.';

  @override
  String get privacyInfoLabel => 'حریم خصوصی';

  @override
  String get privacyInfoBody =>
      'فهرست‌ها، قیمت‌ها، رسیدها و عکس‌های شما روی دستگاه شما ذخیره می‌شود. صدا هرگز از دستگاه خارج نمی‌شود. وقتی کمک هوش مصنوعی روشن است، عکس رسیدها و برچسب قیمت‌ها (با اندازهٔ کاهش‌یافته) و متن، مثلاً اقلام دیکته‌شده، فقط برای خوانده شدن به سرور ما ارسال می‌شود؛ بلافاصله پردازش می‌شود و هرگز ذخیره نمی‌شود.';

  @override
  String get aboutSection => 'درباره';

  @override
  String get aboutPublisher => 'ناشر: Crazy Penguin';

  @override
  String get aboutLicenses => 'مجوزها (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'ورودی صوتی';

  @override
  String get voiceStatusUnknown => 'خدمات: بررسی نشده';

  @override
  String get permissionsLabel => 'دسترسی‌ها';

  @override
  String get permissionsBody =>
      'دسترسی دوربین، میکروفون و اعلان‌ها فقط زمانی درخواست می‌شود که واقعاً از آن ویژگی‌ها استفاده کنید.';

  @override
  String get unitsSection => 'پیش‌فرض‌ها';

  @override
  String get roundingNote =>
      'گرد پول از یک قانون پیروی می‌کند: نیم‌ها دور از صفر گرد می‌شوند، یک بار در تبدیل Money اعمال می‌شود.';

  @override
  String get voiceInputTitle => 'ورودی صوتی';

  @override
  String get voiceStartListening => 'شروع گوش دادن';

  @override
  String get voiceTranscriptLabel => 'متن';

  @override
  String get parseAction => 'تجزیه';

  @override
  String get receiptReviewTitle => 'بررسی رسید';

  @override
  String get receiptTotal => 'مبلغ رسید';

  @override
  String get receiptTotalUnknown => 'مجموع تشخیص داده نشد';

  @override
  String get receiptDiff => 'اختلاف';

  @override
  String get acceptLine => 'تأیید سطر';

  @override
  String get ignoreLine => 'نادیده گرفتن سطر';

  @override
  String get receiptLineActions => 'اتصال به کالا، تقسیم یا نادیده‌گیری';

  @override
  String get receiptCommit => 'تأیید همه';

  @override
  String get receiptCommitted => 'رسید اعمال شد.';

  @override
  String get priceHistoryTitle => 'تاریخچه قیمت';

  @override
  String get noObservations => 'هنوز مشاهده‌ای از قیمت ثبت نشده';

  @override
  String get templatesSection => 'الگوها';

  @override
  String get templateHint => 'ایجاد برنامه جدید بر اساس یک خرید قبلی';

  @override
  String get scanReceiptAction => 'اسکن رسید';

  @override
  String get fromReceiptListButton => 'از رسید';

  @override
  String get shelfLabelAction => 'قیمت از برچسب قفسه';

  @override
  String get priceCandidatesTitle => 'نامزدهای قیمت';

  @override
  String get noPriceCandidates => 'هیچ قیمتی یافت نشد؛ دستی وارد کنید.';

  @override
  String get voiceUnavailable => 'تشخیص گفتار در دسترس نیست؛ دستی وارد کنید.';

  @override
  String get linkToItem => 'اتصال به کالا';

  @override
  String get splitLine => 'تقسیم به دو';

  @override
  String get mergeWithNext => 'ادغام با بعدی';

  @override
  String get ocrNoText => 'متنی خوانده نشد؛ دوباره تلاش کنید.';

  @override
  String get priceHistoryAction => 'تاریخچه قیمت';

  @override
  String get itemsEmptyTitle => 'هنوز کالایی نیست';

  @override
  String get itemsEmptyBody =>
      'اولین کالای خود را اضافه کنید — اینجا در فروشگاه قیمت واقعی را وارد می‌کنید.';

  @override
  String get addItemTooltip => 'افزودن کالا';

  @override
  String get unitAdet => 'عدد';

  @override
  String get unitKilogram => 'کیلوگرم';

  @override
  String get unitGram => 'گرم';

  @override
  String get unitLitre => 'لیتر';

  @override
  String get unitMililitre => 'میلی‌لیتر';

  @override
  String get unitPaket => 'بسته';

  @override
  String get unitKutu => 'جعبه';

  @override
  String get unitSise => 'بطری';

  @override
  String get unitKavanoz => 'شیشه';

  @override
  String get unitDemet => 'دسته';

  @override
  String get unitDuzine => 'دوجین';

  @override
  String get unitMetre => 'متر';

  @override
  String get unitCustom => 'سفارشی';

  @override
  String get setReminderAction => 'تنظیم یادآور';

  @override
  String get reminderPermissionDenied =>
      'برای یادآورها نیاز به مجوز اعلان است. می‌توانید آن را در تنظیمات سیستم فعال کنید.';

  @override
  String get reminderScheduled => 'یادآور تنظیم شد.';

  @override
  String get reminderCancelled => 'یادآور حذف شد.';

  @override
  String get reminderTitle => 'یادآور خرید';

  @override
  String reminderBody(Object title) {
    return 'وقت چک کردن لیست شماست: $title';
  }

  @override
  String get reminderPickDate => 'انتخاب تاریخ';

  @override
  String get reminderPickTime => 'انتخاب زمان';

  @override
  String get itemDetailsSection => 'جزئیات';

  @override
  String get priceOptionalHint =>
      'اختیاری — قیمت واقعی را در فروشگاه وارد می‌کنید';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'برنامه‌ریزی شده: $total · $count کالا';
  }

  @override
  String get proActiveLabel => 'فعال‌سازی Pro — ممنون!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'بدون تبلیغات · پشتیبان‌گیری و بازیابی · سالانه';

  @override
  String get proBenefitNoAds => 'تجربه بدون تبلیغ';

  @override
  String get proBenefitBackup => 'پشتیبان‌گیری (خروجی/ورودی)';

  @override
  String aboutVersion(Object version) {
    return 'نسخه $version';
  }

  @override
  String get navDiscover => 'کاوش';

  @override
  String get shareAction => 'اشتراک‌گذاری برنامه';

  @override
  String get rateAction => 'امتیاز دادن';

  @override
  String get aboutOpenRow => 'درباره و متن‌باز';

  @override
  String get voiceAddItemAction => 'افزودن با صدا';

  @override
  String get formatLocaleLabel => 'فرمت عدد و ارز';

  @override
  String get formatLocaleSystem =>
      'فرمت دستگاه (اعداد لاتین؛ در غیر این صورت انگلیسی)';

  @override
  String get formatLocaleTr => 'ترکی (1.234,56)';

  @override
  String get formatLocaleEn => 'انگلیسی (1,234.56)';

  @override
  String get aiToggleTitle => 'کمک هوش مصنوعی';

  @override
  String get aiToggleSubtitle =>
      'رسیدها و برچسب قیمت‌ها را از روی عکس می‌خواند، رسیدها را تطبیق می‌دهد و جمله‌ها را به فهرست تبدیل می‌کند. عکس‌ها فقط برای خوانده شدن ارسال می‌شوند و هرگز ذخیره نمی‌شوند.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'درخواست‌های ماهانه هوش مصنوعی شما تمام شده است ($used/$limit). برای استفاده بیشتر ارتقا دهید یا بدون هوش مصنوعی ادامه دهید.';
  }

  @override
  String get aiOffline => 'بدون اتصال — ادامه بدون هوش مصنوعی.';

  @override
  String get aiFailed => 'هوش مصنوعی در دسترس نیست — ادامه بدون آن.';

  @override
  String get aiSourceLabel => 'هوش مصنوعی';

  @override
  String get deviceSourceLabel => 'دستگاه';

  @override
  String get quickListAction => 'افزودن از طریق جمله';

  @override
  String get quickListTitle => 'لیست سریع';

  @override
  String get quickListHint => 'مثلاً ۱ کیلو سیب ۲۰، ۲ نان، نیم کیلو پنیر';

  @override
  String get quickListConvert => 'تبدیل به لیست';

  @override
  String quickListAdd(int count) {
    return 'افزودن $count قلم';
  }

  @override
  String get quickListEmpty =>
      'هیچ موردی یافت نشد. سعی کنید موارد را با کاما جدا کنید.';

  @override
  String get receiptAiMatched =>
      'هوش مصنوعی رسید را با لیست شما تطبیق داد. پیوندها را بررسی و تأیید کنید.';

  @override
  String get receiptNeedsCheck => 'بررسی این تطبیق';

  @override
  String get receiptDiscountLine => 'تخفیف';

  @override
  String get compareItem => 'قلم';

  @override
  String get compareEstimated => 'تخمین';

  @override
  String get compareActual => 'واقعی';

  @override
  String get compareDiff => 'اختلاف';

  @override
  String get compareTotal => 'جمع کل';

  @override
  String get compareBudget => 'بودجه';

  @override
  String get compareNotBought => 'خریده نشده';

  @override
  String get compareUnplanned => 'برنامه‌ریزی نشده';

  @override
  String get pricierItems => 'گران‌تر';

  @override
  String get cheaperItems => 'ارزان‌تر';

  @override
  String get compareAction => 'مقایسه';

  @override
  String get detailsSection => 'جزئیات';

  @override
  String get spendingTitle => 'مصرف';

  @override
  String get spendingAction => 'مصرف';

  @override
  String get spendingMonthTotal => 'این ماه';

  @override
  String get spendingWeekly => 'مصرف هفتگی';

  @override
  String get spendingMonthly => 'مصرف ماهانه';

  @override
  String get monthlyLimitTitle => 'حد ماهانه';

  @override
  String get monthlyLimitHelp => 'می‌خواهید هر ماه چقدر برای خرید هزینه کنید؟';

  @override
  String get monthlyLimitRemove => 'حذف';

  @override
  String get monthlyLimitSet => 'تنظیم';

  @override
  String get monthlyLimitChange => 'تغییر';

  @override
  String get monthlyLimitNone =>
      'برای دیدن مبلغ باقی‌مانده، یک حد ماهانه تنظیم کنید.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount بالاتر از حد مجاز';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return '$amount باقی‌مانده در این ماه';
  }

  @override
  String get plansTitle => 'پلن‌ها';

  @override
  String get plansHeadline => 'هوشمندانه‌تر خرید کنید';

  @override
  String get plansSubhead =>
      'تطبیق رسید، برچسب قیمت و لیست از طریق جمله. هر زمان لغو کنید.';

  @override
  String get plansMonthly => 'ماهانه';

  @override
  String get plansYearly => 'سالانه';

  @override
  String get planFree => 'رایگان';

  @override
  String get planFreePrice => 'همیشه رایگان';

  @override
  String get planFreeAi => '10 درخواست هوش مصنوعی در ماه';

  @override
  String get planFreeAds => 'بنر تبلیغاتی کوچک (۷ روز اول هیچ تبلیغی ندارید)';

  @override
  String get planCoreFeatures => 'لیست‌ها، قیمت‌ها، رسیدها، نمودارهای مصرف';

  @override
  String get plansPerYear => '/ سال';

  @override
  String get plansPerMonth => '/ ماه';

  @override
  String get planTrial => 'دوره آزمایشی رایگان';

  @override
  String get planProAi => '100 درخواست هوش مصنوعی در ماه';

  @override
  String get planNoAds => 'بدون تبلیغات';

  @override
  String get planBackup => 'پشتیبان‌گیری و بازیابی';

  @override
  String get planMaxAi => '300 درخواست هوش مصنوعی در ماه';

  @override
  String get planMaxFamily => 'برای خریدهای خانوادگی بزرگ';

  @override
  String get plansStoreUnavailable => 'فروشگاه در حال حاضر در دسترس نیست.';

  @override
  String get retryAction => 'تلاش مجدد';

  @override
  String get plansPurchaseFailed => 'خرید انجام نشد. لطفاً دوباره تلاش کنید.';

  @override
  String get plansRestore => 'بازیابی خریدها';

  @override
  String get plansLegal =>
      'اشتراک Pro تا زمان لغو، هر سال به‌طور خودکار تمدید می‌شود و شامل ۱۰۰ درخواست هوش مصنوعی در هر ماه است. قیمت پایه سالانه ۱ دلار آمریکا پیش از مالیات‌های قابل اعمال است؛ پیش از تأیید خرید، قیمت نهایی محلی و مالیات‌ها را در فروشگاه بررسی کنید. اشتراک را در Google Play مدیریت یا لغو کنید.';

  @override
  String get planCurrent => 'فعال';

  @override
  String get planStartTrial => 'شروع دوره آزمایشی رایگان';

  @override
  String get planChoose => 'انتخاب';

  @override
  String get plansAction => 'پلن‌ها: Pro';

  @override
  String get assistantTitle => 'دستیار';

  @override
  String get assistantGreeting => 'سلام! چه کاری می‌خواهید انجام دهید؟';

  @override
  String get assistantNewList => 'لیست جدید';

  @override
  String get assistantVoiceList => 'لیست صوتی';

  @override
  String get assistantTextList => 'لیست از روی جمله';

  @override
  String get assistantScanReceipt => 'اسکن رسید';

  @override
  String get assistantSpending => 'مخارج من';

  @override
  String get assistantReceiptHint =>
      'لیست خود را باز کنید و برای اسکن، روی آیکون رسید ضربه بزنید.';

  @override
  String get assistantToggleTitle => 'نمایش دستیار';

  @override
  String get assistantToggleSubtitle => 'کمک‌کننده کوچک در گوشه پایین سمت راست';

  @override
  String get scanPriceLabel => 'اسکن برچسب قیمت';

  @override
  String get saveFailed =>
      'ذخیره نشد. تغییرات شما هنوز باقی است. لطفاً دوباره تلاش کنید.';

  @override
  String get deleteItemConfirm => 'این مورد و خریدهای ثبت‌شده آن حذف شود؟';

  @override
  String get clearPurchaseConfirm =>
      'تیک این مورد برداشته و خریدهای ثبت‌شده آن حذف شود؟';

  @override
  String get reportPdfAction => 'ذخیره گزارش PDF';

  @override
  String get reportNotInvoice =>
      'خلاصه خرید، نه فاکتور مالیاتی. نرخ‌های مالیاتی نامشخص هستند.';

  @override
  String get purchaseVisits => 'بازدیدهای خرید';

  @override
  String get purchaseInterval => 'میانگین روزهای بین خریدها';

  @override
  String get purchasedQuantity => 'تعداد خریداری‌شده';

  @override
  String get purchaseAnalyticsHint =>
      'خریدها نشان‌دهنده مصرف نیستند. ارزها و واحدها جداگانه نمایش داده می‌شوند.';

  @override
  String get receiptReplaces =>
      'قیمت موارد بدون قیمت تکمیل می‌شود. مواردی که از قبل قیمت بازار دارند، به‌عنوان خریدهای جداگانه افزوده می‌شوند.';

  @override
  String get receiptIncompleteHeader =>
      'فروشگاه، تاریخ، ساعت و شماره رسید را در عکس بعدی بگنجانید.';

  @override
  String get receiptIncompleteTail =>
      'از بخش بعدی عکس بگیرید؛ چند مورد هم‌پوشان و مبلغ نهایی در تصویر باشند.';

  @override
  String get receiptContinuationRejected =>
      'این عکس به رسید پیوست نشد. آن را با چند مورد هم‌پوشان از همان رسید دوباره بگیرید.';

  @override
  String get receiptDraftSaved =>
      'رسید به‌صورت پیش‌نویس ذخیره شد. بعداً می‌توانید ادامه دهید.';

  @override
  String get receiptContinueAction => 'ادامه رسید';

  @override
  String get receiptDraftsTitle => 'رسیدهای ناتمام';

  @override
  String get receiptDuplicate => 'این رسید قبلاً اضافه شده است.';

  @override
  String get receiptTotalMismatch =>
      'موارد با مبلغ کل رسید مطابقت ندارند. بررسی کنید که تمام رسید در تصویر باشد.';

  @override
  String get receiptSaveDraftAction => 'ذخیره برای بعد';

  @override
  String get receiptResolveLines =>
      'پیش از ذخیره، هر مورد را بپذیرید یا نادیده بگیرید.';

  @override
  String get receiptPartialConfirm =>
      'فقط موارد انتخاب‌شده اضافه می‌شوند. این رسید به‌عنوان واردشده علامت‌گذاری می‌شود. ادامه می‌دهید؟';

  @override
  String get voiceUnsupportedLanguage =>
      'این زبان برای ورود صوتی در این دستگاه در دسترس نیست. می‌توانید تایپ کنید.';

  @override
  String get voiceStopListening => 'قطع شنیدن';

  @override
  String get keepAwakeFailed =>
      'نمی‌توان صفحه را روشن نگه داشت. لطفاً دوباره تلاش کنید.';

  @override
  String get purchaseHistoryHint =>
      'تمام خریدهای تکمیل‌شده. بازگشت کالا، مبالغ را کاهش می‌دهد. تاریخ‌ها مربوط به زمان تکمیل خرید هستند. یک بازدید برای محاسبه میانگین فاصله کافی نیست.';

  @override
  String get planLegacyRights =>
      'اشتراک‌های Pro و Max موجود، سهمیه ماهانه AI اصلی خود را حفظ می‌کنند.';

  @override
  String get csvExportAction => 'خروجی CSV';

  @override
  String get reportSharePdf => 'اشتراک‌گذاری به‌صورت PDF';

  @override
  String get reportShareCsv => 'اشتراک‌گذاری به‌صورت CSV';

  @override
  String get reportPrintAction => 'چاپ';

  @override
  String get backupSizeWarning =>
      'فایل JSON شامل رکوردها است، نه عکس‌ها. محدودیت وارد کردن: ۱۶ مگابایت.';

  @override
  String get backupImportFailed =>
      'امکان وارد کردن این پشتیبان وجود ندارد. داده‌های شما تغییر نکرده است.';

  @override
  String get backupImported => 'پشتیبان با موفقیت وارد شد.';

  @override
  String backupPreviewCounts(Object entries, Object items, Object lists) {
    return '$lists لیست · $items کالا · $entries خرید';
  }

  @override
  String get voiceModelDownloading =>
      'مدل صوتی این زبان در حال دانلود است. یک دقیقه دیگر دوباره امتحان کنید.';

  @override
  String get historyThisWeek => 'این هفته';

  @override
  String get historyProductsSection => 'محصولات خریداری‌شده';

  @override
  String get tipReceiptScan =>
      'رسید را اسکن کنید تا قیمت‌ها با فهرستتان تطبیق داده شوند';

  @override
  String get tipVoiceAdd =>
      'یک یا چند کالا را بگویید و قبل از افزودن بررسی کنید';

  @override
  String get tipShelfCamera => 'قیمت را از برچسب قفسه با دوربین بخوانید';

  @override
  String get tipPlan => 'طرح شما: جزئیات را ببینید، مشترک شوید یا ارتقا دهید';

  @override
  String get guideAddBody =>
      'برای افزودن کالا + را بزنید. قیمت برنامه‌ریزی‌شده را اکنون و قیمت بازار را در صندوق وارد کنید.';

  @override
  String get guideVoiceBody =>
      'میکروفون را بزنید و کالاها را بگویید، مثلاً: «یک کیلو سیب، یک نان».';

  @override
  String get guideReceiptBody =>
      'رسید را اسکن کنید تا قیمت‌هایش با کالاهای فهرست شما تطبیق داده شود.';

  @override
  String get guidePlanBody =>
      'برای دیدن طرح، اشتراک یا ارتقا روی نماد طرح بزنید.';

  @override
  String get guideNext => 'باشه';

  @override
  String get guideDone => 'شروع';

  @override
  String get paletteLabel => 'تم رنگ';

  @override
  String get paletteForest => 'جنگل';

  @override
  String get paletteOcean => 'اقیانوس';

  @override
  String get paletteSunset => 'غروب';

  @override
  String get paletteLavender => 'اسطوخودوس';

  @override
  String get darkBlackLabel => 'سیاه کامل در تم تیره';

  @override
  String get spendingOverview => 'نمای کلی';

  @override
  String get spendingThisYear => 'امسال';

  @override
  String get spendingYearly => 'هزینه سالانه';

  @override
  String get productSpending => 'هزینه بر اساس کالا';

  @override
  String get spanWeek => 'هفته';

  @override
  String get spanMonth => 'ماه';

  @override
  String get spanYear => 'سال';

  @override
  String get weeklyLimitTitle => 'سقف هفتگی';

  @override
  String get weeklyLimitHelp => 'هر هفته چقدر می‌خواهید برای خرید خرج کنید؟';

  @override
  String get weeklyLimitNone => 'برای دیدن مانده، یک سقف هفتگی تعیین کنید.';

  @override
  String weeklyLimitLeft(String amount) {
    return 'این هفته $amount مانده';
  }

  @override
  String get shoppingLimitTitle => 'سقف هر خرید';

  @override
  String get shoppingLimitHelp => 'فهرست‌های جدید با این بودجه شروع می‌شوند.';

  @override
  String get shoppingLimitNone =>
      'برای هر خرید جدید یک بودجه پیش‌فرض تعیین کنید.';

  @override
  String get monthlyReportAction => 'گزارش ماهانه';

  @override
  String get reportShoppingColumn => 'خرید';

  @override
  String get reportDateColumn => 'تاریخ';

  @override
  String get planUnavailable => 'فعلاً در فروشگاه موجود نیست';

  @override
  String get demoDataTitle => 'داده‌های نمونه';

  @override
  String get demoDataLoad => 'امتحان با داده‌های نمونه';

  @override
  String get demoDataLoadHelp =>
      '۱۲ ماه خرید نمونه اضافه می‌کند تا تاریخچه، نمودارها و تاریخچه قیمت را ببینید.';

  @override
  String get demoDataRemove => 'حذف داده‌های نمونه';

  @override
  String get demoDataAdded => 'داده‌های نمونه اضافه شد';

  @override
  String get demoDataRemoved => 'داده‌های نمونه حذف شد';

  @override
  String get demoProductApple => 'سیب';

  @override
  String get demoProductBread => 'نان';

  @override
  String get demoProductMilk => 'شیر';

  @override
  String get demoProductCheese => 'پنیر';

  @override
  String get demoProductTomato => 'گوجه‌فرنگی';

  @override
  String get demoProductEggs => 'تخم‌مرغ';

  @override
  String get demoProductCoffee => 'قهوه';

  @override
  String get demoProductDetergent => 'شوینده';

  @override
  String get sendAction => 'Send';

  @override
  String get previousMonthAction => 'Previous month';

  @override
  String get nextMonthAction => 'Next month';

  @override
  String get helpSection => 'راهنما و پشتیبانی';

  @override
  String get howToUseLabel => 'روش استفاده';

  @override
  String get guidePricesBody =>
      'قیمت فروشگاه، کالا را خریداری‌شده علامت می‌زند؛ 0 هم معتبر است. قیمت خانه اختیاری است. برای برداشتن علامت، قیمت فروشگاه را پاک کنید.';

  @override
  String get shoppingDateLabel => 'تاریخ خرید';

  @override
  String get shoppingDateNone => 'تاریخی انتخاب نشده';

  @override
  String get clearShoppingDateAction => 'پاک کردن تاریخ';

  @override
  String get listSortLabel => 'ترتیب فهرست';

  @override
  String get listSortDate => 'تاریخ خرید';

  @override
  String get listSortAz => 'نام (الف تا ی)';

  @override
  String get listSortManual => 'ترتیب دستی';

  @override
  String get imageCameraAction => 'گرفتن عکس';

  @override
  String get imageGalleryAction => 'انتخاب از عکس‌ها';

  @override
  String get imageCaptureFailed =>
      'دوربین یا عکس‌ها باز نشدند. مجوز دسترسی را بررسی کنید و دوباره تلاش کنید.';

  @override
  String get imageRecognitionFailed =>
      'پردازش عکس ممکن نشد. عکس دیگری را امتحان کنید.';

  @override
  String get receiptNoProducts =>
      'متن خوانده شد، اما کالایی از رسید پیدا نشد. کالاها و مبلغ کل را در عکس بگنجانید.';

  @override
  String get keepAwakeOn => 'صفحه روشن می‌ماند';

  @override
  String get keepAwakeOff => 'صفحه می‌تواند خاموش شود';

  @override
  String get spanDay => 'روز';

  @override
  String get spanCustom => 'بازهٔ تاریخ';

  @override
  String get reportTotalSpent => 'مجموع هزینه';

  @override
  String get reportAddedAt => 'افزوده‌شده';

  @override
  String get reportReceiptNumber => 'شماره رسید';

  @override
  String get reportPreview => 'پیش‌نمایش';

  @override
  String get reportShareAction => 'اشتراک‌گذاری';

  @override
  String get previousPeriodAction => 'دورهٔ قبل';

  @override
  String get nextPeriodAction => 'دورهٔ بعد';

  @override
  String get reportSaved => 'گزارش ذخیره شد.';

  @override
  String get reportZoom => 'بزرگ‌نمایی';

  @override
  String planTrialDaysLeft(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days روز باقی‌مانده',
    );
    return '$_temp0';
  }

  @override
  String planTrialHoursLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours ساعت باقی‌مانده',
    );
    return '$_temp0';
  }

  @override
  String get planTrialEndedTitle => 'دوره آزمایشی Pro شما پایان یافت';

  @override
  String get planTrialEndedBody =>
      'می‌توانید فهرست‌ها، ورود دستی و صدای روی دستگاه را رایگان ادامه دهید. طرح رایگان در هر ماه میلادی ۱۰ درخواست هوش مصنوعی دارد. برای ۱۰۰ درخواست هوش مصنوعی در ماه، بدون تبلیغات و همراه با پشتیبان‌گیری، Pro سالانه را انتخاب کنید. داده‌های فعلی شما حفظ می‌شوند.';

  @override
  String get planContinueFree => 'ادامه با طرح رایگان';

  @override
  String get supportIdLabel => 'شناسه پشتیبانی';

  @override
  String get supportEmailLabel => 'پشتیبانی ایمیلی';

  @override
  String get captureTipFirst =>
      'از بالاترین قسمت شروع کنید: نام فروشگاه و تاریخ باید دیده شوند. تا جایی که می‌شود اقلام را در کادر بگنجانید؛ بقیه در عکس بعدی قرار می‌گیرد.';

  @override
  String get captureTipContinue =>
      'همان رسید: آخرین قلم عکس قبلی را هم بگنجانید.';

  @override
  String get captureTipNeverShow => 'دیگر نشان نده';

  @override
  String get captureTipOk => 'متوجه شدم';

  @override
  String get captureTipsSetting => 'نمایش نکات عکس‌برداری از رسید';

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
  String get listReceiptsSection => 'رسیدها';

  @override
  String get receiptStateComplete => 'کامل';

  @override
  String get receiptStateIncomplete => 'ناقص';

  @override
  String get receiptStateFailed => 'ناموفق';

  @override
  String get receiptStoreUnknown => 'فروشگاه خوانده نشد';

  @override
  String get receiptDeleteAction => 'حذف رسید';

  @override
  String get receiptDeleteConfirm =>
      'این رسید و اقلامی که اضافه کرده حذف شوند؟ بعداً می‌توانید دوباره آن را وارد کنید.';

  @override
  String get receiptDeleted => 'رسید حذف شد.';

  @override
  String listReceiptsShowAll(int count) {
    return 'نمایش همه ($count)';
  }

  @override
  String get listReceiptsShowLess => 'نمایش کمتر';

  @override
  String receiptDateLabel(String date) {
    return 'تاریخ رسید: $date';
  }
}
