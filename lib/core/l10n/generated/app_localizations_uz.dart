// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Uzbek (`uz`).
class AppLocalizationsUz extends AppLocalizations {
  AppLocalizationsUz([String locale = 'uz']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Uyda rejalashtiring. Reja bo\'yicha xarid qiling.';

  @override
  String get listsTitle => 'Ro\'yxatlar';

  @override
  String get listsTabActive => 'Faol';

  @override
  String get listsTabCompleted => 'Bajarilgan';

  @override
  String get listsTabArchived => 'Arxivlangan';

  @override
  String get newListButton => 'Yangi ro\'yxat';

  @override
  String get listTitleHint => 'Sarlavha (ixtiyoriy)';

  @override
  String get saveButton => 'Saqlash';

  @override
  String get cancelButton => 'Bekor qilish';

  @override
  String get deleteButton => 'O\'chirish';

  @override
  String get editAction => 'Tahrirlash';

  @override
  String get listDeleted => 'Ro\'yxat o\'chirildi';

  @override
  String get invalidAmountError => 'Yaroqsiz miqdor';

  @override
  String get duplicateAction => 'Qayta yaratish';

  @override
  String get archiveAction => 'Arxivlash';

  @override
  String get unarchiveAction => 'Arxivdan chiqarish';

  @override
  String get deleteListConfirm =>
      'Bu ro\'yxatni o\'chirmoqchimisiz? Undagi rejalashtirilgan mahsulotlar ham o\'chiriladi.';

  @override
  String get undoButton => 'Orqaga qaytarish';

  @override
  String get searchListHint => 'Ro\'yxatlarni qidirish';

  @override
  String get currencyLabel => 'Valyuta';

  @override
  String get budgetLabel => 'Byudjet (ixtiyoriy)';

  @override
  String get noteLabel => 'Izoh (ixtiyoriy)';

  @override
  String get storeLabel => 'Do\'kon';

  @override
  String get keepAmountsAction => 'Miqdorlarni saqlash';

  @override
  String get resetAmountsAction => 'Miqdorlarni tiklash';

  @override
  String get currencyChangeWarning =>
      'Valyuta o\'zgaryapti. Mavjud miqdorlar bilan nima bo\'lishi kerak?';

  @override
  String get listsEmpty =>
      'Hali ro\'yxatlar yo\'q. Birinchi xarid rejangizni yarating.';

  @override
  String get statusDraft => 'Loyiha';

  @override
  String get statusPlanned => 'Rejalashtirilgan';

  @override
  String get statusShopping => 'Xarid jarayonida';

  @override
  String get statusCompleted => 'Bajarilgan';

  @override
  String get statusArchived => 'Arxivlangan';

  @override
  String autoListTitle(String date) {
    return '$date xaridi';
  }

  @override
  String get itemFormTitle => 'Mahsulot qo\'shish';

  @override
  String get itemNameLabel => 'Mahsulot nomi';

  @override
  String get brandLabel => 'Brend / variant (ixtiyoriy)';

  @override
  String get categoryLabel => 'Kategoriya';

  @override
  String get quantityLabel => 'Miqdor';

  @override
  String get unitLabel => 'O\'lchov birligi';

  @override
  String get pricingModeLabel => 'Narx kiritish usuli';

  @override
  String get pricingModeUnitPrice => 'Bitta narxi';

  @override
  String get pricingModeLineTotal => 'Jami summa';

  @override
  String get plannedPriceLabel => 'Rejalashtirilgan narx';

  @override
  String lineTotalCalculated(String value) {
    return 'Jami summa: $value';
  }

  @override
  String get requiredItemToggle => 'Zarur mahsulot';

  @override
  String get maxPriceLabel => 'Maksimum qabul qilinadigan narx (ixtiyoriy)';

  @override
  String get itemNoteLabel => 'Izoh (ixtiyoriy)';

  @override
  String get categoryProduce => 'Mevalar va sabzavotlar';

  @override
  String get categoryDairy => 'Sut mahsulotlari';

  @override
  String get categoryMeat => 'Go\'sht';

  @override
  String get categoryBakery => 'Nonushta va non mahsulotlari';

  @override
  String get categoryDrinks => 'Ichimliklar';

  @override
  String get categoryCleaning => 'Tozalash vositalari';

  @override
  String get categoryPersonalCare => 'Shaxsiy parvarish';

  @override
  String get categoryHome => 'Uy uchun';

  @override
  String get categoryOther => 'Boshqa';

  @override
  String get invalidQuantityError => 'Yaroqsiz miqdor';

  @override
  String get invalidPriceError => 'Yaroqsiz narx';

  @override
  String get invalidNameError => 'Ism kiriting';

  @override
  String unitPriceCalculated(String value) {
    return 'Bitta narx: $value';
  }

  @override
  String get shoppingTitle => 'Xarid rejimi';

  @override
  String get summaryPlannedTotal => 'Rejalashtirilgan';

  @override
  String get summaryInCart => 'Savatda';

  @override
  String get summaryRemainingPlan => 'Qolgan reja';

  @override
  String get summaryProjected => 'Taxminiy to\'lov';

  @override
  String get summaryBudgetRemaining => 'Byudjet qoldi';

  @override
  String get summaryBudgetOver => 'Byudjetdan oshdi';

  @override
  String itemsProgress(String done, String total) {
    return '$total dan $done ta mahsulot';
  }

  @override
  String get filterAll => 'Hammasi';

  @override
  String get filterToBuy => 'Sotib olish kerak';

  @override
  String get filterInCart => 'Savatda';

  @override
  String get filterNotFound => 'Topilmadi';

  @override
  String get filterRequired => 'Shartli';

  @override
  String get quickEntryTitle => 'Haqiqiy narx';

  @override
  String get actualQuantityLabel => 'Haqiqiy miqdor';

  @override
  String get actualPriceLabel => 'Haqiqiy narx';

  @override
  String get discountLabel => 'Chegirma (ixtiyoriy)';

  @override
  String get alternativeNameLabel => 'Muqobil mahsulot nomi (ixtiyoriy)';

  @override
  String get savePurchaseButton => 'Savatga qo\'shish';

  @override
  String get unplannedAddButton => 'Rejasiz mahsulot qo\'shish';

  @override
  String get statusPending => 'Olib kelingan emas';

  @override
  String get statusInCart => 'Savatda';

  @override
  String get statusNotFound => 'Topilmadi';

  @override
  String get statusGaveUp => 'Vaz kechildi';

  @override
  String get statusAlternative => 'Muqobili sotib olindi';

  @override
  String get keepScreenAwake => 'Ekranni yoqib turish';

  @override
  String get finishShopping => 'Xaridni tugatish';

  @override
  String get completionWarning =>
      'Yetishmayotgan yoki tasdiqlanmagan ma\'lumotlar bor. Hali ham tugatishingiz mumkin; natijada bu haqida eslatma bo\'ladi.';

  @override
  String get continueShoppingButton => 'Xaridni davom ettirish';

  @override
  String get resultTitle => 'Natija';

  @override
  String get summarySection => 'Xulosa';

  @override
  String get plannedTotalLabel => 'Rejalashtirilgan umumiy';

  @override
  String get actualTotalLabel => 'Haqiqiy umumiy';

  @override
  String get varianceLabel => 'Farq';

  @override
  String get varianceNotComputable => 'Hisoblab bo\'lmaydi';

  @override
  String get budgetStatusLabel => 'Byudjet';

  @override
  String get savingsLabel => 'Rejadagi kamroq';

  @override
  String get overspendLabel => 'Rejadagi ko\'proq';

  @override
  String get unplannedTotalLabel => 'Rejasiz umumiy';

  @override
  String get unpurchasedLabel => 'Rejalashtirilgan, lekin sotib olinmagan';

  @override
  String get totalDiscountLabel => 'Jami chegirmalar';

  @override
  String get accuracyLabel => 'Baholash aniqligi';

  @override
  String get groupsSection => 'Mahsulotlar';

  @override
  String get groupPricier => 'Rejadan qimmatroq';

  @override
  String get groupCheaper => 'Rejadan arzonroq';

  @override
  String get groupClose => 'Baholashga yaqin';

  @override
  String get groupNotTaken => 'Rejalashtirilgan, olib kelingan emas';

  @override
  String get groupUnplanned => 'Rejasiz sotib olingan';

  @override
  String get groupQuantityChanged => 'Miqdor o\'zgargan';

  @override
  String get groupUnverified => 'Tekshirilmagan';

  @override
  String get plannedQtyLabel => 'Rejalashtirilgan miqdor';

  @override
  String get actualQtyLabel => 'Haqiqiy miqdor';

  @override
  String get plannedUnitPriceLabel => 'Rejalashtirilgan bitta narxi';

  @override
  String get actualUnitPriceLabel => 'Haqiqiy bitta narxi';

  @override
  String get lineVarianceLabel => 'Qator farqi';

  @override
  String get discountEffectLabel => 'Chegirma ta\'siri';

  @override
  String get notBoughtMark => 'sotib olinmagan';

  @override
  String get noPurchasesNote => 'Hech qanday xarid qayd etilmadi.';

  @override
  String get navHome => 'Bosh sahifa';

  @override
  String get navLists => 'Ro\'yxatlar';

  @override
  String get navHistory => 'Tarix';

  @override
  String get navSettings => 'Sozlamalar';

  @override
  String get homeEmptyTitle => 'Xarid rejangizni tuzing';

  @override
  String get homeEmptyBody =>
      'Birinchi ro\'yxatingizni yarating va rejalashtirilgan xarajatlar haqiqiy xarajatlardan farqini ko\'ring.';

  @override
  String get homeActiveSection => 'Faol ro\'yxatlar';

  @override
  String get homeCompletedSection => 'Yaqinda tugallangan';

  @override
  String get homeMonthlySection => 'Bu oy';

  @override
  String get monthPlannedLabel => 'Rejalashtirilgan';

  @override
  String get monthActualLabel => 'Haqiqiy';

  @override
  String get monthVarianceLabel => 'Farq';

  @override
  String get continueShoppingLabel => 'Xaridni davom ettirish';

  @override
  String get historyEmpty =>
      'Hali hech qanday xarid tugallanmagan. Tarix va tahlillar shu yerda paydo bo\'ladi.';

  @override
  String get aboutTabTitle => 'NShoptor haqida';

  @override
  String get aboutBody =>
      'Crazy Penguin tomonidan NShoptor. Oflayn birinchi xarid rejalashtiruvchisi. GPL-3.0 litsenziyasi ostida.';

  @override
  String get startShoppingLabel => 'Xaridni boshlash';

  @override
  String get finishAndSeeResult => 'Tugatish va natijani ko\'rish';

  @override
  String get settingsTitle => 'Sozlamalar';

  @override
  String get languageLabel => 'Til';

  @override
  String get languageSystem => 'Tizim';

  @override
  String get languageTr => 'Turkcha';

  @override
  String get languageEn => 'Inglizcha';

  @override
  String get themeLabel => 'Mavzu';

  @override
  String get themeSystem => 'Tizim';

  @override
  String get themeLight => 'Yorug\'';

  @override
  String get themeDark => 'Qorong\'i';

  @override
  String get defaultCurrencyLabel => 'Asosiy valyuta';

  @override
  String get defaultUnitLabel => 'Asosiy birlik';

  @override
  String get keepAwakeLabel => 'Xarid paytida ekranni yoqib turish';

  @override
  String get backupSection => 'Zaxira nusxa';

  @override
  String get exportBackupLabel => 'Zaxira nusxani eksport qilish';

  @override
  String get importBackupLabel => 'Zaxira nusxani import qilish';

  @override
  String get mergeImportLabel => 'Joriy ma\'lumotlarga birlashtirish';

  @override
  String get separateImportLabel => 'Alohida nusxa sifatida import qilish';

  @override
  String get importCancelled => 'Import bekor qilindi.';

  @override
  String get backupExported => 'Zaxira nusxa muvaffaqiyatli eksport qilindi.';

  @override
  String get backupSizeWarning =>
      'Katta zaxira: fayl hajmi katta bo\'lishi mumkin. Rasmlarni ham qo\'shasizmi?';

  @override
  String get deleteAllSection => 'Xavfli zona';

  @override
  String get deleteAllLabel => 'Barcha ma\'lumotlarni o\'chirish';

  @override
  String get deleteAllConfirm =>
      'Bu barcha ro\'yxatlar, tarix, cheklar rasmlari va narxlarni o\'chiradi. Siz eksport qilgan fayllar diskingizda saqlanib qoladi. Davom etasizmi?';

  @override
  String get deleteAllConfirm2 =>
      'Haqiqatan ham ishonchingiz komilmi? Bu amalni qaytarib bo\'lmaydi.';

  @override
  String get cancelAction => 'Bekor qilish';

  @override
  String get confirmDelete => 'Abadiy o\'chirish';

  @override
  String get dataDeleted => 'Barcha mahalliy ma\'lumotlar o\'chirildi.';

  @override
  String get privacyInfoLabel => 'Maxfiylik';

  @override
  String get privacyInfoBody =>
      'Ro\'yxatlaringiz, narxlaringiz, cheklaringiz va rasmlaringiz qurilmangizda saqlanadi. Rasmlar va ovoz hech qachon undan chiqmaydi. AI yordam yoqilganda, faqat matn (masalan, chek qatorlari yoki siz aytgan narsalar) serverga yuboriladi va saqlanmaydi.';

  @override
  String get aboutSection => 'Haqida';

  @override
  String get aboutPublisher => 'Nashr etuvchi: Crazy Penguin';

  @override
  String get aboutLicenses => 'Litsenziyalar (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Ovozli kiritish';

  @override
  String get voiceStatusUnknown => 'Xizmat: tekshirilmagan';

  @override
  String get permissionsLabel => 'Ruxsatlar';

  @override
  String get permissionsBody =>
      'Kamera, mikrofon va bildirishnomalar faqat ushbu funksiyalardan foydalanganda so\'raladi.';

  @override
  String get unitsSection => 'Standartlar';

  @override
  String get roundingNote =>
      'Pulni yaxlitlash bir qoidaga amal qiladi: yarimlar nol dan uzoqlashadi, Money konversiyasida bir marta qo\'llaniladi.';

  @override
  String get voiceInputTitle => 'Ovozli kiritish';

  @override
  String get voiceStartListening => 'Eshitishni boshlash';

  @override
  String get voiceTranscriptLabel => 'Matn';

  @override
  String get parseAction => 'Tahlil qilish';

  @override
  String get receiptReviewTitle => 'Chekni ko\'rib chiqish';

  @override
  String get receiptTotal => 'Chek summasi';

  @override
  String get receiptTotalUnknown => 'Summa aniqlanmadi';

  @override
  String get receiptDiff => 'Farq';

  @override
  String get acceptLine => 'Qabul qilish';

  @override
  String get ignoreLine => 'E\'tiborsiz qoldirish';

  @override
  String get receiptLineActions =>
      'Mahsulotga bog\'lash, bo\'lish yoki e\'tiborsiz qoldirish';

  @override
  String get receiptCommit => 'Hammasini tasdiqlash';

  @override
  String get receiptCommitted => 'Chek qo\'llanildi.';

  @override
  String get priceHistoryTitle => 'Narxlar tarixi';

  @override
  String get noObservations => 'Hali narx kuzatuvlari yo\'q';

  @override
  String get templatesSection => 'Shablonlar';

  @override
  String get templateHint => 'Avvalgi xarid safaridan yangi reja tuzing';

  @override
  String get scanReceiptAction => 'Chekni skanerlash';

  @override
  String get shelfLabelAction => 'Raf etiketkasidagi narx';

  @override
  String get priceCandidatesTitle => 'Narx variantlari';

  @override
  String get noPriceCandidates => 'Narx topilmadi; uni qo\'lda kiriting.';

  @override
  String get voiceUnavailable => 'Ovozli tanish imkonsiz; qo\'lda kiriting.';

  @override
  String get linkToItem => 'Mahsulotga bog\'lash';

  @override
  String get splitLine => 'Ikki qismga bo\'lish';

  @override
  String get mergeWithNext => 'Keyingisi bilan birlashtirish';

  @override
  String get ocrNoText => 'Hech qanday matn o\'qilmadi; qayta urinib ko\'ring.';

  @override
  String get priceHistoryAction => 'Narxlar tarixi';

  @override
  String get itemsEmptyTitle => 'Hali mahsulotlar yo\'q';

  @override
  String get itemsEmptyBody =>
      'Birinchi mahsulotni qo\'shing — do\'konda haqiqiy narxlarni shu yerda kiritasiz.';

  @override
  String get addItemTooltip => 'Mahsulot qo\'shish';

  @override
  String get unitAdet => 'dona';

  @override
  String get unitKilogram => 'kg';

  @override
  String get unitGram => 'g';

  @override
  String get unitLitre => 'L';

  @override
  String get unitMililitre => 'ml';

  @override
  String get unitPaket => 'paket';

  @override
  String get unitKutu => 'quti';

  @override
  String get unitSise => 'shisha';

  @override
  String get unitKavanoz => 'banka';

  @override
  String get unitDemet => 'barg';

  @override
  String get unitDuzine => 'dastachi';

  @override
  String get unitMetre => 'm';

  @override
  String get unitCustom => 'Maxsus';

  @override
  String get setReminderAction => 'Esdatish belgilash';

  @override
  String get reminderPermissionDenied =>
      'Esdatishlar uchun bildirishnoma ruxsati kerak. Buni tizim sozlamalarida yoqishingiz mumkin.';

  @override
  String get reminderScheduled => 'Esdatish belgilandi.';

  @override
  String get reminderCancelled => 'Esdatish olib tashlandi.';

  @override
  String get reminderTitle => 'Xarid esdatishi';

  @override
  String reminderBody(Object title) {
    return 'Ro\'yxatingizni tekshirish vaqti keldi: $title';
  }

  @override
  String get reminderPickDate => 'Sanani tanlang';

  @override
  String get reminderPickTime => 'Vaqt tanlang';

  @override
  String get itemDetailsSection => 'Tafsilotlar';

  @override
  String get priceOptionalHint =>
      'Ixtiyoriy — haqiqiy narxni do\'konda kiritasiz';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Rejalashtirilgan: $total · $count ta mahsulot';
  }

  @override
  String get proActiveLabel => 'Pro faol — rahmat!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Reklamasiz, ko\'proq AI, zaxira nusxa · kichik oylik narxdan boshlab';

  @override
  String get proBenefitNoAds => 'Reklamasiz tajriba';

  @override
  String get proBenefitBackup => 'Zaxira nusxa (eksport/import)';

  @override
  String aboutVersion(Object version) {
    return 'Versiya $version';
  }

  @override
  String get navDiscover => 'Kashf qilish';

  @override
  String get shareAction => 'Ilovani ulashish';

  @override
  String get rateAction => 'Bizga baho bering';

  @override
  String get aboutOpenRow => 'Haqida va ochiq kod';

  @override
  String get voiceAddItemAction => 'Ovoz orqali qo\'shish';

  @override
  String get formatLocaleLabel => 'Raqam va valyuta formati';

  @override
  String get formatLocaleSystem =>
      'Qurilma formati (Lotin raqamlari; aks holda ingliz tili)';

  @override
  String get formatLocaleTr => 'Turkcha (1.234,56)';

  @override
  String get formatLocaleEn => 'Inglizcha (1,234.56)';

  @override
  String get aiToggleTitle => 'AI yordami';

  @override
  String get aiToggleSubtitle =>
      'Cheklarni moslashtiradi, narx yorliqlarini o‘qiydi va gaplarni ro‘yxatga aylantiradi. Rasmlar va ovoz qurilmangizda qoladi; faqat matn qayta ishlanadi.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Siz bu oy uchun AI so‘rovlarini ($used/$limit) ishlatdingiz. Ko‘proq imkoniyat uchun yangilang yoki AI dan foydalanmasdan davom eting.';
  }

  @override
  String get aiOffline =>
      'Internet yo‘q — AI dan foydalanmasdan davom etilmoqda.';

  @override
  String get aiFailed =>
      'AI hozircha mavjud emas — undan foydalanmasdan davom etilmoqda.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'Qurilma';

  @override
  String get quickListAction => 'Gapdan qo‘shish';

  @override
  String get quickListTitle => 'Tezkor ro‘yxat';

  @override
  String get quickListHint =>
      'masalan, 1 kg olma 20, 2 dona non, yarim kilo pishloq';

  @override
  String get quickListConvert => 'Ro‘yxatga aylantirish';

  @override
  String quickListAdd(int count) {
    return '$count ta mahsulot qo‘shish';
  }

  @override
  String get quickListEmpty =>
      'Hech narsa topilmadi. Ularni vergul bilan ajratib yozib ko‘ring.';

  @override
  String get receiptAiMatched =>
      'AI chekni sizning ro‘yxatingizga moslab topdi. Havolalarni tekshiring va tasdiqlang.';

  @override
  String get receiptNeedsCheck => 'Ushbu moslikni tekshiring';

  @override
  String get receiptDiscountLine => 'Chegirma';

  @override
  String get compareItem => 'Mahsulot';

  @override
  String get compareEstimated => 'Baholangan';

  @override
  String get compareActual => 'Haqiqiy';

  @override
  String get compareDiff => 'Farq';

  @override
  String get compareTotal => 'Jami';

  @override
  String get compareBudget => 'Byudjet';

  @override
  String get compareNotBought => 'sotib olinmagan';

  @override
  String get compareUnplanned => 'rejalashtirilmagan';

  @override
  String get pricierItems => 'Qimmatroq';

  @override
  String get cheaperItems => 'Arzonroq';

  @override
  String get compareAction => 'Taqqoslash';

  @override
  String get detailsSection => 'Tafsilotlar';

  @override
  String get spendingTitle => 'Xarajatlar';

  @override
  String get spendingAction => 'Xarajatlar';

  @override
  String get spendingMonthTotal => 'Bu oy';

  @override
  String get spendingWeekly => 'Haftalik xarajatlar';

  @override
  String get spendingMonthly => 'Oylik xarajatlar';

  @override
  String get monthlyLimitTitle => 'Oylik limit';

  @override
  String get monthlyLimitHelp =>
      'Oyiga necha so‘m savdo qilishni rejalashtirmoqchisiz?';

  @override
  String get monthlyLimitRemove => 'Olib tashlash';

  @override
  String get monthlyLimitSet => 'Belgilash';

  @override
  String get monthlyLimitChange => 'O‘zgartirish';

  @override
  String get monthlyLimitNone =>
      'Qancha pul qolgani ko‘rish uchun oylik limit belgilang.';

  @override
  String monthlyLimitOver(String amount) {
    return 'Limitdan $amount ortiq';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return 'Bu oyda $amount qoldi';
  }

  @override
  String get plansTitle => 'Tariflar';

  @override
  String get plansHeadline => 'AI bilan aqlli xarid qiling';

  @override
  String get plansSubhead =>
      'Cheklarni moslashtirish, narx yorliqlari va gapdan ro‘yxat. Istalgan vaqtda bekor qiling.';

  @override
  String get plansMonthly => 'Oylik';

  @override
  String get plansYearly => 'Yillik';

  @override
  String get planFree => 'Bepul';

  @override
  String get planFreePrice => 'Abadiy bepul';

  @override
  String get planFreeAi => 'Oyiga 15 ta AI so‘rov';

  @override
  String get planFreeAds => 'Kichik banner reklama (birinchi 7 kunida yo‘q)';

  @override
  String get planCoreFeatures =>
      'Ro‘yxatlar, narxlar, cheklar, xarajat grafiklari';

  @override
  String get plansPerYear => '/ yil';

  @override
  String get plansPerMonth => '/ oy';

  @override
  String get planTrial => '7 kun bepul';

  @override
  String get planProAi => 'Oyiga 200 ta AI so‘rov';

  @override
  String get planNoAds => 'Reklamasiz';

  @override
  String get planBackup => 'Zaxiralash eksport va import';

  @override
  String get planMaxAi => 'Oyiga 1000 ta AI so\'rov';

  @override
  String get planMaxFamily => 'Katta oila uchun xaridlar';

  @override
  String get plansStoreUnavailable => 'Do\'kon hozircha ulanmagan.';

  @override
  String get retryAction => 'Qayta urinish';

  @override
  String get plansPurchaseFailed =>
      'Xarid amalga oshmadi. Iltimos, qaytadan urinib ko\'ring.';

  @override
  String get planLifetimeTitle => 'Umrbod reklamasiz';

  @override
  String get planLifetimeSubtitle =>
      'Bir marta to\'lov: reklama yo\'q, zaxiralash; AI bepul imkoniyatlar doirasida ishlaydi';

  @override
  String get plansRestore => 'Xaridlarni tiklash';

  @override
  String get plansLegal =>
      'Obunalarni bekor qilmaguningizcha avtomatik yangilanib turadi. Istalgan vaqtda Google Play › To\'lovlar va obunalar bo\'limidan bekor qilishingiz mumkin. Narxlar Google Play ko\'rsatgan soliqni o\'z ichiga oladi.';

  @override
  String get planCurrent => 'Joriy';

  @override
  String get planStartTrial => '7 kunlik bepul sinovni boshlash';

  @override
  String get planChoose => 'Tanlash';

  @override
  String get plansAction => 'Rejalarni boshqarish: Pro va Max';

  @override
  String get assistantTitle => 'Yordamchi';

  @override
  String get assistantGreeting => 'Salom! Nima qilmoqchisiz?';

  @override
  String get assistantNewList => 'Yangi ro\'yxat';

  @override
  String get assistantVoiceList => 'Ovoz orqali ro\'yxat';

  @override
  String get assistantTextList => 'Gapdan ro\'yxat tuzish';

  @override
  String get assistantScanReceipt => 'Chekni skanerlash';

  @override
  String get assistantSpending => 'Mening xarajatlarim';

  @override
  String get assistantReceiptHint =>
      'Ro\'yxatingizni oching va chekni skanerlash uchun chek belgisini bosing.';

  @override
  String get assistantToggleTitle => 'Yordamchini ko\'rsatish';

  @override
  String get assistantToggleSubtitle =>
      'O\'ng pastki burchakdagi kichik yordamchi';

  @override
  String get scanPriceLabel => 'Narx yorlig\'ini skanerlang';

  @override
  String get saveFailed =>
      'Saqlanmadi. O\'zgarishlaringiz hali ham saqlangan. Iltimos, qayta urinib ko\'ring.';

  @override
  String get deleteItemConfirm =>
      'Ushbu mahsulotni va uning sotib olish yozuvlarini o\'chirishni xohlaysizmi?';

  @override
  String get clearPurchaseConfirm =>
      'Ushbu mahsulotni belgisiz qilish va uning sotib olish yozuvlarini o\'chirishni xohlaysizmi?';

  @override
  String get reportPdfAction => 'PDF hisobotni saqlash';

  @override
  String get reportNotInvoice =>
      'Xaridlar tahlili, soliq cheki emas. Soliq stavkalari noma\'lum.';

  @override
  String get purchaseVisits => 'Xarid safarlari';

  @override
  String get purchaseInterval => 'Xaridlar orasidagi o\'rtacha kunlar soni';

  @override
  String get purchasedQuantity => 'Sotib olingan miqdor';

  @override
  String get purchaseAnalyticsHint =>
      'Xaridlar iste\'molni o\'lchamaydi. Valyutalar va birliklar alohida ko\'rsatiladi.';

  @override
  String get receiptReplaces =>
      'Bog\'langan chek qatorlari mavjud xaridlarni almashtiradi; bog\'lanmagan qatorlar qo\'shiladi.';

  @override
  String get voiceUnsupportedLanguage =>
      'Bu til ushbu qurilmada ovozli kiritish uchun mavjud emas. Buning o\'rniga matn kiritishingiz mumkin.';
}
