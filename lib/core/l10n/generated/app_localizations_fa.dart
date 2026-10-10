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
  String get backupSizeWarning =>
      'پشتیبان بزرگ: فایل ممکن است بزرگ باشد. آیا می‌خواهید عکس‌ها نیز شامل شوند؟';

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
      'لیست‌ها، قیمت‌ها، رسیدها و عکس‌های شما روی دستگاه شما باقی می‌مانند. عکس‌ها و صدا هرگز از آن خارج نمی‌شوند. وقتی کمک AI روشن است، فقط متن (مثلاً خطوط رسید یا آنچه شما دیکته کردید) برای پردازش به سرور ما ارسال می‌شود و ذخیره نمی‌شود.';

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
      'بدون تبلیغ، هوش مصنوعی بیشتر، پشتیبان‌گیری · از یک قیمت ماهانه کم';

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
      'رسیدها را تطبیق می‌دهد، برچسب قیمت را می‌خواند و جملات را به لیست تبدیل می‌کند. عکس‌ها و صدا فقط روی دستگاه شما می‌مانند؛ فقط متن پردازش می‌شود.';

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
  String get planTrial => '۷ روز رایگان';

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
  String get planLifetimeTitle => 'بدون تبلیغ برای همیشه';

  @override
  String get planLifetimeSubtitle =>
      'پرداخت یک‌باره: بدون تبلیغ، پشتیبان‌گیری؛ استفاده از هوش مصنوعی طبق سهم رایگان';

  @override
  String get plansRestore => 'بازیابی خریدها';

  @override
  String get plansLegal =>
      'اشتراک‌ها تا زمان لغو، به‌طور خودکار تمدید می‌شوند. هر زمان می‌توانید از طریق Google Play › پرداخت‌ها و اشتراک‌ها آن را لغو کنید. قیمت‌ها شامل مالیات‌هایی است که توسط Google Play نمایش داده شده است.';

  @override
  String get planCurrent => 'فعال';

  @override
  String get planStartTrial => 'شروع آزمایش ۷ روزه رایگان';

  @override
  String get planChoose => 'انتخاب';

  @override
  String get plansAction => 'طرح‌ها: پرو و مکس';

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
      'خطوط رسید پیوند‌خورده، خریدهای موجود را جایگزین می‌کنند؛ خطوط بدون پیوند اضافه می‌شوند.';

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
      'اشتراک‌های Pro و Max موجود، سهمیه ماهانه AI اصلی خود را حفظ می‌کنند. پیشنهادهای جدید ۱۰۰ و ۳۰۰ درخواست دارند.';

  @override
  String get csvExportAction => 'خروجی CSV';
}
