// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Mongolian (`mn`).
class AppLocalizationsMn extends AppLocalizations {
  AppLocalizationsMn([String locale = 'mn']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Гэрт төлөвлө. Хуваарьт дагаж худалдаа хий.';

  @override
  String get listsTitle => 'Жагсаалтууд';

  @override
  String get listsTabActive => 'Идэвхтэй';

  @override
  String get listsTabCompleted => 'Дууссан';

  @override
  String get listsTabArchived => 'Архивласан';

  @override
  String get newListButton => 'Шинэ жагсаалт';

  @override
  String get listTitleHint => 'Гарчиг (заавал биш)';

  @override
  String get saveButton => 'Хадгалах';

  @override
  String get cancelButton => 'Цуцлах';

  @override
  String get deleteButton => 'Устгах';

  @override
  String get editAction => 'Засварлах';

  @override
  String get listDeleted => 'Жагсаалт устгагдсан';

  @override
  String get invalidAmountError => 'Буруу тоо хэмжээ';

  @override
  String get duplicateAction => 'Хуулбарлах';

  @override
  String get archiveAction => 'Архивлах';

  @override
  String get unarchiveAction => 'Архиваас гаргах';

  @override
  String get deleteListConfirm =>
      'Энэ жагсаалтыг устгах уу? Төлөвлөсөн зүйлс нь мөн хамт устана.';

  @override
  String get undoButton => 'Буцаах';

  @override
  String get searchListHint => 'Жагсаалтаас хайх';

  @override
  String get currencyLabel => 'Валют';

  @override
  String get budgetLabel => 'Төсөв (заавал биш)';

  @override
  String get noteLabel => 'Тэмдэглэл (заавал биш)';

  @override
  String get storeLabel => 'Дэлгүүр';

  @override
  String get keepAmountsAction => 'Тоо хэмжээг хадгалах';

  @override
  String get resetAmountsAction => 'Тоо хэмжээг шинэчлэх';

  @override
  String get currencyChangeWarning =>
      'Валют солигдаж байна. Одоо байгаа тоо хэмжээнд юу болох вэ?';

  @override
  String get listsEmpty =>
      'Одоогоор жагсаалт байхгүй. Эхний худалдааны төлөвлөгөөгөө үүсгэ.';

  @override
  String get statusDraft => 'Ноорог';

  @override
  String get statusPlanned => 'Төлөвлөсөн';

  @override
  String get statusShopping => 'Худалдаж буй';

  @override
  String get statusCompleted => 'Дууссан';

  @override
  String get statusArchived => 'Архивласан';

  @override
  String autoListTitle(String date) {
    return '$date-ны худалдаа';
  }

  @override
  String get itemFormTitle => 'Зүйл нэмэх';

  @override
  String get itemNameLabel => 'Зүйлийн нэр';

  @override
  String get brandLabel => 'Брэнд / хувилбар (заавал биш)';

  @override
  String get categoryLabel => 'Ангилал';

  @override
  String get quantityLabel => 'Тоо хэмжээ';

  @override
  String get unitLabel => 'Нэгж';

  @override
  String get pricingModeLabel => 'Үнийн оруулалт';

  @override
  String get pricingModeUnitPrice => 'Нэгжийн үнэ';

  @override
  String get pricingModeLineTotal => 'Мөр бүрийн нийт';

  @override
  String get plannedPriceLabel => 'Төлөвлөсөн үнэ';

  @override
  String lineTotalCalculated(String value) {
    return 'Мөр бүрийн нийт: $value';
  }

  @override
  String get requiredItemToggle => 'Шаардлагатай зүйл';

  @override
  String get maxPriceLabel => 'Хамгийн их зөвшөөрөгдөх үнэ (заавал биш)';

  @override
  String get itemNoteLabel => 'Тэмдэглэл (заавал биш)';

  @override
  String get categoryProduce => 'Ургамал, жимс';

  @override
  String get categoryDairy => 'Сүүн бүтээгдэхүүн';

  @override
  String get categoryMeat => 'Ма';

  @override
  String get categoryBakery => 'Хоол';

  @override
  String get categoryDrinks => 'Ундаа';

  @override
  String get categoryCleaning => 'Цэвэрлэгээ';

  @override
  String get categoryPersonalCare => 'Хувийн арчилгаа';

  @override
  String get categoryHome => 'Гэр ахуй';

  @override
  String get categoryOther => 'Бусад';

  @override
  String get invalidQuantityError => 'Буруу тоо хэмжээ';

  @override
  String get invalidPriceError => 'Буруу үнэ';

  @override
  String get invalidNameError => 'Нэр оруулна уу';

  @override
  String unitPriceCalculated(String value) {
    return 'Нэгжийн үнэ: $value';
  }

  @override
  String get shoppingTitle => 'Захиалга хийх горим';

  @override
  String get summaryPlannedTotal => 'Төлөвлөсөн';

  @override
  String get summaryInCart => 'Сагсанд байгаа';

  @override
  String get summaryRemainingPlan => 'Үлдсэн төлөвлөгөө';

  @override
  String get summaryProjected => 'Тооцоолсон нийт';

  @override
  String get summaryBudgetRemaining => 'Төсвийн үлдэгдэл';

  @override
  String get summaryBudgetOver => 'Төсвөөс хэтэрчээ';

  @override
  String itemsProgress(String done, String total) {
    return '$total зүйлээс $done-г дуусгасан';
  }

  @override
  String get filterAll => 'Бүгд';

  @override
  String get filterToBuy => 'Эзэмших шаардлагатай';

  @override
  String get filterInCart => 'Сагсанд байгаа';

  @override
  String get filterNotFound => 'Олдсонгүй';

  @override
  String get filterRequired => 'Шаардлагатай';

  @override
  String get quickEntryTitle => 'Бодит үнэ';

  @override
  String get actualQuantityLabel => 'Бодит хэмжээ';

  @override
  String get actualPriceLabel => 'Бодит үнэ';

  @override
  String get discountLabel => 'Хөнгөлөлт (заавал биш)';

  @override
  String get alternativeNameLabel =>
      'Өөрөөр сонгогдсон бүтээгдэхүүний нэр (заавал биш)';

  @override
  String get savePurchaseButton => 'Сагсанд нэмэх';

  @override
  String get unplannedAddButton => 'Төлөвлөөгүй зүйл нэмэх';

  @override
  String get statusPending => 'Авсангүй';

  @override
  String get statusInCart => 'Сагсанд байгаа';

  @override
  String get statusNotFound => 'Олдсонгүй';

  @override
  String get statusGaveUp => 'Татгалзсан';

  @override
  String get statusAlternative => 'Өөрөөр авсан';

  @override
  String get keepScreenAwake => 'Дэлгэцийг идэвхтэй байлгах';

  @override
  String get finishShopping => 'Захиалга дуусгах';

  @override
  String get completionWarning =>
      'Дутуу эсвэл баталгаажуулаагүй мэдээлэл байна. Та дуусгаж болох бөгөөд үр дүнд тэмдэглэгдэнэ.';

  @override
  String get continueShoppingButton => 'Үргэлжлүүлэх';

  @override
  String get resultTitle => 'Үр дүн';

  @override
  String get summarySection => 'Нийтлэг';

  @override
  String get plannedTotalLabel => 'Төлөвлөсөн нийт';

  @override
  String get actualTotalLabel => 'Бодит нийт';

  @override
  String get varianceLabel => 'Ялгаа';

  @override
  String get varianceNotComputable => 'Тооцоолох боломжгүй';

  @override
  String get budgetStatusLabel => 'Төсөв';

  @override
  String get savingsLabel => 'Төлөвлөгөөгөөс хэмнэсэн';

  @override
  String get overspendLabel => 'Төлөвлөгөөгөөс хэтэрсэн';

  @override
  String get unplannedTotalLabel => 'Төлөвлөөгүй нийт';

  @override
  String get unpurchasedLabel => 'Төлөвлөсөн ч авсангүй';

  @override
  String get totalDiscountLabel => 'Нийт хөнгөлөлт';

  @override
  String get accuracyLabel => 'Таамаглалын нарийвчлал';

  @override
  String get groupsSection => 'Зүйлс';

  @override
  String get groupPricier => 'Төлөвлөснөөс үнэтэй';

  @override
  String get groupCheaper => 'Төлөвлөснөөс хямд';

  @override
  String get groupClose => 'Таамаглалтай ойролцоо';

  @override
  String get groupNotTaken => 'Төлөвлөсөн, авсангүй';

  @override
  String get groupUnplanned => 'Төлөвлөөгүйгээр авсан';

  @override
  String get groupQuantityChanged => 'Хэмжээ өөрчлөгдсөн';

  @override
  String get groupUnverified => 'Баталгаажуулаагүй';

  @override
  String get plannedQtyLabel => 'Төлөвлөсөн хэмжээ';

  @override
  String get actualQtyLabel => 'Бодит хэмжээ';

  @override
  String get plannedUnitPriceLabel => 'Төлөвлөсөн нэгжийн үнэ';

  @override
  String get actualUnitPriceLabel => 'Бодит нэгжийн үнэ';

  @override
  String get lineVarianceLabel => 'Мөрийн ялгаа';

  @override
  String get discountEffectLabel => 'Хөнгөлөлтийн нөлөө';

  @override
  String get notBoughtMark => 'авсангүй';

  @override
  String get noPurchasesNote => 'Борлуулалтын бүртгэл олдсонгүй.';

  @override
  String get navHome => 'Нүүр';

  @override
  String get navLists => 'Жагсаалтууд';

  @override
  String get navHistory => 'Түүх';

  @override
  String get navSettings => 'Тохиргоо';

  @override
  String get homeEmptyTitle => 'Хүнсний жагсаалтаа төлөвлө';

  @override
  String get homeEmptyBody =>
      'Эхний жагсаалтаа үүсгэж, төлөвлөсөн болон бодит зардлыг харьцуул.';

  @override
  String get homeActiveSection => 'Идэвхтэй жагсаалтууд';

  @override
  String get homeCompletedSection => 'Сүүлд дууссан';

  @override
  String get homeMonthlySection => 'Энэ сар';

  @override
  String get monthPlannedLabel => 'Төлөвлөсөн';

  @override
  String get monthActualLabel => 'Бодит';

  @override
  String get monthVarianceLabel => 'Зөрүү';

  @override
  String get continueShoppingLabel => 'Үргэлжлүүлэх';

  @override
  String get historyEmpty =>
      'Одоогоор дууссан худалдан авалт байхгүй. Таны түүх болон дүн шинжилгээ энд харагдана.';

  @override
  String get aboutTabTitle => 'NShoptor-ын тухай';

  @override
  String get aboutBody =>
      'Crazy Penguin-ийн NShoptor. Сүлжээгүй ажилладаг хүнсний төлөвлөгч. GPL-3.0 зөвшөөрлөөр эрхлэгдсэн.';

  @override
  String get startShoppingLabel => 'Худалдаанд гарах';

  @override
  String get finishAndSeeResult => 'Дуусгаж, үр дүнг харах';

  @override
  String get settingsTitle => 'Тохиргоо';

  @override
  String get languageLabel => 'Хэл';

  @override
  String get languageSystem => 'Систем';

  @override
  String get languageTr => 'Турк';

  @override
  String get languageEn => 'Англи';

  @override
  String get themeLabel => 'Загвар';

  @override
  String get themeSystem => 'Систем';

  @override
  String get themeLight => 'Гэрэлтэй';

  @override
  String get themeDark => 'Харанхуй';

  @override
  String get defaultCurrencyLabel => 'Үндсэн валют';

  @override
  String get defaultUnitLabel => 'Үндсэн нэгж';

  @override
  String get keepAwakeLabel => 'Худалдаж байхдаа дэлгэцийг идэвхтэй байлгах';

  @override
  String get backupSection => 'Нөөц хуулбар';

  @override
  String get exportBackupLabel => 'Нөөц хуулбарыг экспортлох';

  @override
  String get importBackupLabel => 'Нөөц хуулбарыг импортлох';

  @override
  String get mergeImportLabel => 'Одоогийн өгөгдөлтэй нэгтгэх';

  @override
  String get separateImportLabel => 'Ялгаатай хуулбар болгон импортлох';

  @override
  String get importCancelled => 'Импортлохыг цуллаа.';

  @override
  String get backupExported => 'Нөөц хуулбар амжилттай экспортлогдлоо.';

  @override
  String get deleteAllSection => 'Аюултай бүс';

  @override
  String get deleteAllLabel => 'Бүх өгөгдлийг устгах';

  @override
  String get deleteAllConfirm =>
      'Энэ нь бүх жагсаалт, түүх, найруулгын зураг болон үнийг устгана. Та экспортлосон файлууд тань диск дээрээ хэвээр үлдэнэ. Үргэлжлүүлэх үү?';

  @override
  String get deleteAllConfirm2 =>
      'Та бүрэн итгэлтэй байна уу? Энэ үйлдлийг буцааж болохгүй.';

  @override
  String get cancelAction => 'Цулах';

  @override
  String get confirmDelete => 'Машинд нь устгах';

  @override
  String get dataDeleted => 'Бүх локаль өгөгдлийг устлав.';

  @override
  String get privacyInfoLabel => 'Нууцлал';

  @override
  String get privacyInfoBody =>
      'Таны жагсаалт, үнэ, найруулга болон зураг таны төхөөрөмж дээр л хадгалагдана. Зураг болон дууны бичлэг төхөөрөмжөөс гардаггүй. Хэрэв AI тусламж идэвхтэй бол зөвхөн текст (жишээ нь найруулгын мөр эсвэл та яриад өгсөн зүйл) сервер рүүгээ боловсруулахад илгээгдэж, хадгалагдахгүй.';

  @override
  String get aboutSection => 'Тухай';

  @override
  String get aboutPublisher => 'Хөгжүүлэгч: Crazy Penguin';

  @override
  String get aboutLicenses => 'Зөвшөөрлүүд (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Дуут оролт';

  @override
  String get voiceStatusUnknown => 'Үйлчилгээ: шалгаагаагүй';

  @override
  String get permissionsLabel => 'Зөвшөөрлүүд';

  @override
  String get permissionsBody =>
      'Камер, микрофон болон мэдэгдэл зөвхөн та эдгээр функцуудыг бодитоор ашиглах үед л шаардагдана.';

  @override
  String get unitsSection => 'Үндсэн';

  @override
  String get roundingNote =>
      'Мөнгөний тоймлолт нэг дүрмийг дагадаг: хагас нь тэгээс холдуулан тоймлогдоно, Мөнгө хөрвүүлэх үед нэг удаа хэрэглэгдэнэ.';

  @override
  String get voiceInputTitle => 'Дуут оролт';

  @override
  String get voiceStartListening => 'Сонсож эхлэх';

  @override
  String get voiceTranscriptLabel => 'Бичвэр';

  @override
  String get parseAction => 'Шинжлэх';

  @override
  String get receiptReviewTitle => 'Найруулгыг шалгах';

  @override
  String get receiptTotal => 'Түлхүүрийн нийт';

  @override
  String get receiptTotalUnknown => 'Нийтийг тодорхойлоогүй';

  @override
  String get receiptDiff => 'Ялгаа';

  @override
  String get acceptLine => 'Зөвшөөрөх';

  @override
  String get ignoreLine => 'Үл хайхарч';

  @override
  String get receiptLineActions =>
      'Бүтээгдэхүүнтэй холбох, хуваах эсвэл үл хайхарч';

  @override
  String get receiptCommit => 'Бүгдийг зөвшөөрөх';

  @override
  String get receiptCommitted => 'Түлхүүрийг ашигласан.';

  @override
  String get priceHistoryTitle => 'Үнийн түүх';

  @override
  String get noObservations => 'Одоогоор үнийн ажиглалт байхгүй';

  @override
  String get templatesSection => 'Загварууд';

  @override
  String get templateHint =>
      'Өмнөх худалдааны аялалаас шинэ төлөвлөгөөг үүсгэх';

  @override
  String get scanReceiptAction => 'Түлхүүрийг сканнердах';

  @override
  String get shelfLabelAction => 'Шелфийн шошгоноос үнэ';

  @override
  String get priceCandidatesTitle => 'Үнийн саналууд';

  @override
  String get noPriceCandidates => 'Үнэ олдсонгүй; гараар оруулна уу.';

  @override
  String get voiceUnavailable =>
      'Дуу хоолойн таньдлага боломжгүй; гараар оруулна уу.';

  @override
  String get linkToItem => 'Бүтээгдэхүүнтэй холбох';

  @override
  String get splitLine => 'Хоёр хэсэгт хуваах';

  @override
  String get mergeWithNext => 'Дараагийнтай нэгтгэх';

  @override
  String get ocrNoText => 'Текст уншаагүй; дахин оролдоно уу.';

  @override
  String get priceHistoryAction => 'Үнийн түүх';

  @override
  String get itemsEmptyTitle => 'Одоогоор бүтээгдэхүүн байхгүй';

  @override
  String get itemsEmptyBody =>
      'Эхний бүтээгдэхүүнээ нэмээрэй — дэлгүүрт явж бодит үнийг энд оруулна.';

  @override
  String get addItemTooltip => 'Бүтээгдэхүүн нэмэх';

  @override
  String get unitAdet => 'шт';

  @override
  String get unitKilogram => 'кг';

  @override
  String get unitGram => 'г';

  @override
  String get unitLitre => 'Л';

  @override
  String get unitMililitre => 'мл';

  @override
  String get unitPaket => 'багц';

  @override
  String get unitKutu => 'хайрцаг';

  @override
  String get unitSise => 'сав';

  @override
  String get unitKavanoz => 'банзан';

  @override
  String get unitDemet => 'бүл';

  @override
  String get unitDuzine => 'зуун';

  @override
  String get unitMetre => 'м';

  @override
  String get unitCustom => 'Хувийн';

  @override
  String get setReminderAction => 'Санамж тохируулах';

  @override
  String get reminderPermissionDenied =>
      'Санамжийн тулд мэдэгдлийн зөвшөөрөл шаардлагатай. Та системийн тохиргооноос идэвхжүүлж болно.';

  @override
  String get reminderScheduled => 'Санамж тохируулагдсан.';

  @override
  String get reminderCancelled => 'Санамж устгагдсан.';

  @override
  String get reminderTitle => 'Худалдааны санамж';

  @override
  String reminderBody(Object title) {
    return 'Жагсаалтаа шалгах цаг: $title';
  }

  @override
  String get reminderPickDate => 'Огноо сонгох';

  @override
  String get reminderPickTime => 'Цаг сонгох';

  @override
  String get itemDetailsSection => 'Дэлгэрэнгүй';

  @override
  String get priceOptionalHint =>
      'Сонголтоор — та дэлгүүрт явж бодит үнийг оруулна';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Төлөвлөсөн: $total · $count бүтээгдэхүүн';
  }

  @override
  String get proActiveLabel => 'Pro идэвхтэй — баярлалаа!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine => 'Зогсоолгүй, илүү AI, нөөц · бага сарын үнээр';

  @override
  String get proBenefitNoAds => 'Зогсоолгүй туршлага';

  @override
  String get proBenefitBackup => 'Нөөц (экспорт/импорт)';

  @override
  String aboutVersion(Object version) {
    return 'Хувилбар $version';
  }

  @override
  String get navDiscover => 'Нээлт';

  @override
  String get shareAction => 'Аппыг хуваалцах';

  @override
  String get rateAction => 'Бидэнд үнэлгээ өгөх';

  @override
  String get aboutOpenRow => 'Тухай & нээлттэй эхийн код';

  @override
  String get voiceAddItemAction => 'Дуу хоолоор нэмэх';

  @override
  String get formatLocaleLabel => 'Тоо ба валютын формат';

  @override
  String get formatLocaleSystem =>
      'Төхөөрөмжийн хэлбэр (Латин цифр; бусад нь Англи)';

  @override
  String get formatLocaleTr => 'Турк (1.234,56)';

  @override
  String get formatLocaleEn => 'Англи (1,234.56)';

  @override
  String get aiToggleTitle => 'AI тусламж';

  @override
  String get aiToggleSubtitle =>
      'Нэхэмжлэлийг тохируулж, үнийн шошгыг уншиж, өгүүлбэрийг жагсаалт болгоно. Зураг, дуу хоолой таны төхөөрөмж дээр хадгалагдаж, зөвхөн текст боловсруулна.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Энэ сарын AI хүсэлтийг ($used/$limit) ашигласан байна. Илүү авахын тулд шинэчлэл хийнэ үү эсвэл AI-гүйгээр үргэлжлүүлнэ үү.';
  }

  @override
  String get aiOffline => 'Холболт байхгүй — AI-гүйгээр үргэлжлүүлж байна.';

  @override
  String get aiFailed =>
      'AI одоогоор боломжгүй — түүнийг ашиглахгүйгээр үргэлжлүүлж байна.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'Төхөөрөмж';

  @override
  String get quickListAction => 'Өгүүлбэрээс нэмэх';

  @override
  String get quickListTitle => 'Хурдан жагсаалт';

  @override
  String get quickListHint =>
      'жишээ нь 1 кг алчуур 20, 2 талх, хагас кг цагаан идээ';

  @override
  String get quickListConvert => 'Жагсаалт болгон хувиргах';

  @override
  String quickListAdd(int count) {
    return '$count зүйл нэмэх';
  }

  @override
  String get quickListEmpty =>
      'Ямар ч зүйл олдсонгүй. Татвар тэмдэгтээр ялгаж оролдоно уу.';

  @override
  String get receiptAiMatched =>
      'AI нэхэмжлэлийг таны жагсаалтад тааруулав. Холбоосуудыг шалгаж баталгаажуулна уу.';

  @override
  String get receiptNeedsCheck => 'Энэ таарцуулыг шалгах';

  @override
  String get receiptDiscountLine => 'Хөнгөлөлт';

  @override
  String get compareItem => 'Зүйл';

  @override
  String get compareEstimated => 'Таамаглал';

  @override
  String get compareActual => 'Бодит';

  @override
  String get compareDiff => 'Ялгаа';

  @override
  String get compareTotal => 'Нийт';

  @override
  String get compareBudget => 'Төсөв';

  @override
  String get compareNotBought => 'худалдаж аваагүй';

  @override
  String get compareUnplanned => 'төлөвлөөгүй';

  @override
  String get pricierItems => 'Илүү үнэтэй';

  @override
  String get cheaperItems => 'Хямд';

  @override
  String get compareAction => 'Харьцуулах';

  @override
  String get detailsSection => 'Дэлгэрэнгүй';

  @override
  String get spendingTitle => 'Зардал';

  @override
  String get spendingAction => 'Зардал';

  @override
  String get spendingMonthTotal => 'Энэ сар';

  @override
  String get spendingWeekly => 'Долоо хоногийн зардал';

  @override
  String get spendingMonthly => 'Сарын зардал';

  @override
  String get monthlyLimitTitle => 'Сарын хязгаар';

  @override
  String get monthlyLimitHelp =>
      'Та сар бүр худалдаанд хэдэн төгрөг зарлахыг хүсч байна вэ?';

  @override
  String get monthlyLimitRemove => 'Устгах';

  @override
  String get monthlyLimitSet => 'Орлуулах';

  @override
  String get monthlyLimitChange => 'Өөрчлөх';

  @override
  String get monthlyLimitNone =>
      'Үлдсэн хэмжээгээ харахын тулд сарын хязгаар тохируулна уу.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount хязгаараас давсан';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return 'Энэ сард $amount үлдсэн';
  }

  @override
  String get plansTitle => 'Төлөвлөгөө';

  @override
  String get plansHeadline => 'AI-тайгаа ухаалаг худалдаа хий';

  @override
  String get plansSubhead =>
      'Нэхэмжлэлийн таарцуулалт, үнийн шошго, өгүүлбэрээс жагсаалт. Дурын үед цуцалж болно.';

  @override
  String get plansMonthly => 'Сар бүр';

  @override
  String get plansYearly => 'Жил бүр';

  @override
  String get planFree => 'Үнэгүй';

  @override
  String get planFreePrice => 'Мөнхийн үнэгүй';

  @override
  String get planFreeAi => 'Сар бүр 10 AI хүсэлт';

  @override
  String get planFreeAds => 'Жижиг баннер реклам (эхний 7 хоногт байхгүй)';

  @override
  String get planCoreFeatures => 'Жагсаалт, үнэ, нэхэмжлэл, зардлын диаграмм';

  @override
  String get plansPerYear => '/ жил';

  @override
  String get plansPerMonth => '/ сар';

  @override
  String get planTrial => '7 хоног үнэгүй';

  @override
  String get planProAi => 'Сар бүр 100 AI хүсэлт';

  @override
  String get planNoAds => 'Рекламгүй';

  @override
  String get planBackup => 'Нөөцлөх экспорт, импорт';

  @override
  String get planMaxAi => 'Сард 300 AI хүсэлт';

  @override
  String get planMaxFamily => 'Том гэр бүлийн худалдаанд зориулсан';

  @override
  String get plansStoreUnavailable =>
      'Дэлгүүр одоогоор холбогдох боломжгүй байна.';

  @override
  String get retryAction => 'Дахин оролдоно уу';

  @override
  String get plansPurchaseFailed =>
      'Худалдан авалт амжилтгүй боллоо. Дахин оролдоно уу.';

  @override
  String get planLifetimeTitle => 'Мэдээж зар сурталчилгаагүй';

  @override
  String get planLifetimeSubtitle =>
      'Нэг удаа төлбөр: зар сурталчилгаагүй, нөөц; AI үнэ төлбөргүй хязгаарт үлдэнэ';

  @override
  String get plansRestore => 'Худалдан авалтыг сэргээх';

  @override
  String get plansLegal =>
      'Захиалга нь цуцлагдаana хүртэл автоматаар шинэчлэгдэнэ. Google Play › Төлбөр ба захиалга-аас дурын цагт цуцалж болно. Үнийн дүн нь Google Play-ээр харуулсан албан татварыг агуулна.';

  @override
  String get planCurrent => 'Одоогийн';

  @override
  String get planStartTrial => '7 хоногийн үнэ төлбөргүй туршилтыг эхлүүлэх';

  @override
  String get planChoose => 'Сонгох';

  @override
  String get plansAction => 'Захиалга: Pro ба Max';

  @override
  String get assistantTitle => 'Туслах';

  @override
  String get assistantGreeting => 'Сайн байна уу! Та юу хийхийг хүсч байна вэ?';

  @override
  String get assistantNewList => 'Шинэ жагсаалт';

  @override
  String get assistantVoiceList => 'Дуугаар жагсаалт';

  @override
  String get assistantTextList => 'Нэгэн өгүүлбэрээс жагсаалт';

  @override
  String get assistantScanReceipt => 'Зарын баримтыг сканнердах';

  @override
  String get assistantSpending => 'Миний зардал';

  @override
  String get assistantReceiptHint =>
      'Жагсаалтаа нээж, сканнердахын тулд зарын баримтын икон дээр товшино уу.';

  @override
  String get assistantToggleTitle => 'Туслахыг харуулах';

  @override
  String get assistantToggleSubtitle => 'Баруун доод буланд жижиг туслагч';

  @override
  String get scanPriceLabel => 'Үнийн шошгыг сканнердах';

  @override
  String get saveFailed =>
      'Хадгалах боломжгүй. Таны өөрчлөлт хадгалагдаагүй байна. Дахин оролдоно уу.';

  @override
  String get deleteItemConfirm =>
      'Энэ зүйлийг болон бүртгэгдсэн худалдаж авалтуудыг устгах уу?';

  @override
  String get clearPurchaseConfirm =>
      'Энэ зүйлийг тэмдэглэлтэй нь цуцлаж, бүртгэгдсэн худалдаж авалтыг устгах уу?';

  @override
  String get reportPdfAction => 'PDF тайланг хадгалах';

  @override
  String get reportNotInvoice =>
      'Худалдаж авалтын нийтлэг дүн; төлбөрийн баримт бичиг биш. Татварын хувь тодорхойгүй.';

  @override
  String get purchaseVisits => 'Худалдаж авах аялал';

  @override
  String get purchaseInterval => 'Худалдаж авах хоорондын дундаж өдрүүд';

  @override
  String get purchasedQuantity => 'Худалдаж авсан хэмжээ';

  @override
  String get purchaseAnalyticsHint =>
      'Худалдаж авалт нь хэрэглээг хэмждэггүй. Валют болон хэмжих нэгжийг тусад нь харуулна.';

  @override
  String get receiptReplaces =>
      'Холбогдсон хүлээн авалтын мөрүүд одоогийн худалдаж авалтыг орлох; холбогдоогүй мөрүүдийг нэмнэ.';

  @override
  String get voiceUnsupportedLanguage =>
      'Энэ хэлээр дуут оруулга энэ төхөөрөмжид боломжгүй. Та гарчилгаар оруулж болно.';

  @override
  String get voiceStopListening => 'Тэнцвэрлэхийг зогсоох';

  @override
  String get keepAwakeFailed =>
      'Дэлгэцийг идэвхтэй байлгаж чадсангүй. Дахин оролдоно уу.';

  @override
  String get purchaseHistoryHint =>
      'Бүх дууссан худалдаа. Буцаан олголт нийт дүнгий бууруулна. Огноо нь худалдааны дуусах хугацааг илэрхийлнэ. Нэг аялал дундаж завсрыг тооцоолоход хангалтгүй.';

  @override
  String get planLegacyRights =>
      'Одоо байгаа Pro болон Max захиалгууд анхны сар бүрийн AI хязгаарлалтаа хадгална. Шинэ сануултууд 100 ба 300 хүсэлт агуулна.';

  @override
  String get csvExportAction => 'CSV экспортлох';

  @override
  String get backupSizeWarning =>
      'JSON нь зураг файлуудыг агуулаагүй, бичлэгүүдийг агуулдаг. Импортлох хязгаар: 16 MB.';

  @override
  String get backupImportFailed =>
      'Энэ нөөцлөлтийг оруулж чадсангүй. Таны өгөгдөл өөрчлөгдөөгүй байна.';

  @override
  String get backupImported => 'Нөөц амжилттай импортлогдлоо.';

  @override
  String backupPreviewCounts(Object entries, Object items, Object lists) {
    return '$lists жагсаалт · $items зүйл · $entries худалдан авалт';
  }
}
