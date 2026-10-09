// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kirghiz Kyrgyz (`ky`).
class AppLocalizationsKy extends AppLocalizations {
  AppLocalizationsKy([String locale = 'ky']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Үйдө пландоо. Пландай сатып алуу.';

  @override
  String get listsTitle => 'Тизмелер';

  @override
  String get listsTabActive => 'Актaтивдүү';

  @override
  String get listsTabCompleted => 'Аяктаган';

  @override
  String get listsTabArchived => 'Архивделген';

  @override
  String get newListButton => 'Жаңы тизме';

  @override
  String get listTitleHint => 'Аталышы (каалоочу)';

  @override
  String get saveButton => 'Сактоо';

  @override
  String get cancelButton => 'Жокко чыгаруу';

  @override
  String get deleteButton => 'Өчүрүү';

  @override
  String get editAction => 'Оңдоо';

  @override
  String get listDeleted => 'Тизме өчүрүлдү';

  @override
  String get invalidAmountError => 'Туура эмес сумма';

  @override
  String get duplicateAction => 'Көчүрүү';

  @override
  String get archiveAction => 'Архивдөө';

  @override
  String get unarchiveAction => 'Архивден чыгаруу';

  @override
  String get deleteListConfirm =>
      'Бул тизмени өчүрөсүзбү? Анын пландалган элементтери дагы алынат.';

  @override
  String get undoButton => 'Кайтаруу';

  @override
  String get searchListHint => 'Тизмелерди издөө';

  @override
  String get currencyLabel => 'Валюта';

  @override
  String get budgetLabel => 'Бюджет (каалоочу)';

  @override
  String get noteLabel => 'Эскертме (каалоочу)';

  @override
  String get storeLabel => 'Дүкөн';

  @override
  String get keepAmountsAction => 'Суммаларды сактоо';

  @override
  String get resetAmountsAction => 'Суммаларды калыбына келтирүү';

  @override
  String get currencyChangeWarning =>
      'Валюта өзгөрүүдө. Бар болгон суммалар менен эмне кылышат?';

  @override
  String get listsEmpty =>
      'Азырынча тизме жок. Биринчи сатып алуу планыңызды түзүңүз.';

  @override
  String get statusDraft => 'Урна';

  @override
  String get statusPlanned => 'Пландалган';

  @override
  String get statusShopping => 'Сатып алууда';

  @override
  String get statusCompleted => 'Аяктаган';

  @override
  String get statusArchived => 'Архивделген';

  @override
  String autoListTitle(String date) {
    return '$date сатып алуу';
  }

  @override
  String get itemFormTitle => 'Элемент кошуу';

  @override
  String get itemNameLabel => 'Элементтин аталышы';

  @override
  String get brandLabel => 'Бренд / вариант (каалоочу)';

  @override
  String get categoryLabel => 'Категория';

  @override
  String get quantityLabel => 'Мөлшөр';

  @override
  String get unitLabel => 'Бирдик';

  @override
  String get pricingModeLabel => 'Баа киргизүү';

  @override
  String get pricingModeUnitPrice => 'Бирдик баасы';

  @override
  String get pricingModeLineTotal => 'Саптын жалпысы';

  @override
  String get plannedPriceLabel => 'Пландалган баа';

  @override
  String lineTotalCalculated(String value) {
    return 'Саптын жалпысы: $value';
  }

  @override
  String get requiredItemToggle => 'Зарыл элемент';

  @override
  String get maxPriceLabel => 'Максималдуу кабыл алуучу баа (каалоочу)';

  @override
  String get itemNoteLabel => 'Эскертме (каалоочу)';

  @override
  String get categoryProduce => 'Мөмө-жемиштер жана жашылчалар';

  @override
  String get categoryDairy => 'Сүт азыктары';

  @override
  String get categoryMeat => 'Эт';

  @override
  String get categoryBakery => 'Нан бышыруу';

  @override
  String get categoryDrinks => 'Ичимдиктер';

  @override
  String get categoryCleaning => 'Таза кармоо каражаттары';

  @override
  String get categoryPersonalCare => 'Жеке гигиена';

  @override
  String get categoryHome => 'Үй үчүн';

  @override
  String get categoryOther => 'Башка';

  @override
  String get invalidQuantityError => 'Туура эмес мөлшөр';

  @override
  String get invalidPriceError => 'Туура эмес баа';

  @override
  String get invalidNameError => 'Аталышты киргизиңиз';

  @override
  String unitPriceCalculated(String value) {
    return 'Бирдик баасы: $value';
  }

  @override
  String get shoppingTitle => 'Сатып алуу режими';

  @override
  String get summaryPlannedTotal => 'Жоспарланган';

  @override
  String get summaryInCart => 'Себетте';

  @override
  String get summaryRemainingPlan => 'Калган план';

  @override
  String get summaryProjected => 'Бааланган төлөм';

  @override
  String get summaryBudgetRemaining => 'Бюджет калды';

  @override
  String get summaryBudgetOver => 'Бюджеттен ашты';

  @override
  String itemsProgress(String done, String total) {
    return '$total нерсенин ичинен $done';
  }

  @override
  String get filterAll => 'Баары';

  @override
  String get filterToBuy => 'Сатып алууга';

  @override
  String get filterInCart => 'Себетте';

  @override
  String get filterNotFound => 'Табылган жок';

  @override
  String get filterRequired => 'Зарыл';

  @override
  String get quickEntryTitle => 'Чыныгы баасы';

  @override
  String get actualQuantityLabel => 'Чыныгы саны';

  @override
  String get actualPriceLabel => 'Чыныгы баасы';

  @override
  String get discountLabel => 'Арзандалуу (кошуумча)';

  @override
  String get alternativeNameLabel =>
      'Альтернативдүү продукттун аталышы (кошуумча)';

  @override
  String get savePurchaseButton => 'Себетке кошуу';

  @override
  String get unplannedAddButton => 'Плансыз нерсени кошуу';

  @override
  String get statusPending => 'Алынган эмес';

  @override
  String get statusInCart => 'Себетте';

  @override
  String get statusNotFound => 'Табылган жок';

  @override
  String get statusGaveUp => 'Ташталды';

  @override
  String get statusAlternative => 'Альтернатива сатылды';

  @override
  String get keepScreenAwake => 'Экран өчпөсүн кармоо';

  @override
  String get finishShopping => 'Сатып алууну бүтүрүү';

  @override
  String get completionWarning =>
      'Жетишсиз же текшерилбеген маалыматтар бар. Сиз дагы эле бүтүрө аласыз; натыйжа аларды белгилейт.';

  @override
  String get continueShoppingButton => 'Сатып алууну улантуу';

  @override
  String get resultTitle => 'Натыйжа';

  @override
  String get summarySection => 'Жыйынтык';

  @override
  String get plannedTotalLabel => 'Жоспарланган жалпы сумма';

  @override
  String get actualTotalLabel => 'Чыныгы жалпы сумма';

  @override
  String get varianceLabel => 'Айырма';

  @override
  String get varianceNotComputable => 'Эсептелбейт';

  @override
  String get budgetStatusLabel => 'Бюджет';

  @override
  String get savingsLabel => 'Пландан аз';

  @override
  String get overspendLabel => 'Пландан ашкан';

  @override
  String get unplannedTotalLabel => 'Плансыз жалпы сумма';

  @override
  String get unpurchasedLabel => 'Жоспарланган, бирок сатылган эмес';

  @override
  String get totalDiscountLabel => 'Жалпы арзандалуулар';

  @override
  String get accuracyLabel => 'Баалоо тактыгы';

  @override
  String get groupsSection => 'Нерселер';

  @override
  String get groupPricier => 'Жоспарлангандан кымбат';

  @override
  String get groupCheaper => 'Жоспарлангандан арзан';

  @override
  String get groupClose => 'Баалоого жакын';

  @override
  String get groupNotTaken => 'Жоспарланган, сатылган эмес';

  @override
  String get groupUnplanned => 'Плансыз сатылды';

  @override
  String get groupQuantityChanged => 'Саны өзгөрдү';

  @override
  String get groupUnverified => 'Текшерилген эмес';

  @override
  String get plannedQtyLabel => 'Жоспарланган саны';

  @override
  String get actualQtyLabel => 'Чыныгы саны';

  @override
  String get plannedUnitPriceLabel => 'Жоспарланган бирдик баасы';

  @override
  String get actualUnitPriceLabel => 'Чыныгы бирдик баасы';

  @override
  String get lineVarianceLabel => 'Сап айырмасы';

  @override
  String get discountEffectLabel => 'Арзандалуунун таасири';

  @override
  String get notBoughtMark => 'сатылган эмес';

  @override
  String get noPurchasesNote => 'Сатып алуулар катталган жок.';

  @override
  String get navHome => 'Башкы бет';

  @override
  String get navLists => 'Тизмелер';

  @override
  String get navHistory => 'Тарых';

  @override
  String get navSettings => 'Жөндөөлөр';

  @override
  String get homeEmptyTitle => 'Сатып алууну пландоо';

  @override
  String get homeEmptyBody =>
      'Биринчи тизмеңизди түзүп, пландалган жана чыныгы бааларды салыштырыңыз.';

  @override
  String get homeActiveSection => 'Азыркы тизмелер';

  @override
  String get homeCompletedSection => 'Акыркы аткарылгандар';

  @override
  String get homeMonthlySection => 'Бул ай';

  @override
  String get monthPlannedLabel => 'Пландалган';

  @override
  String get monthActualLabel => 'Чыныгы';

  @override
  String get monthVarianceLabel => 'Айырма';

  @override
  String get continueShoppingLabel => 'Сатып алууну улантуу';

  @override
  String get historyEmpty =>
      'Азырынча аткарылган сатып алуулар жок. Тарыхыңыз жана талдоолор бул жерде көрүнөт.';

  @override
  String get aboutTabTitle => 'NShoptor тууралуу';

  @override
  String get aboutBody =>
      'Crazy Penguin компаниясынан NShoptor. Офлайн-биринчи сатып алуу планоочусу. GPL-3.0 лицензиясы менен.';

  @override
  String get startShoppingLabel => 'Сатып алууну баштоо';

  @override
  String get finishAndSeeResult => 'Аяктоо жана натыйжаны көрүү';

  @override
  String get settingsTitle => 'Жөндөөлөр';

  @override
  String get languageLabel => 'Тил';

  @override
  String get languageSystem => 'Система';

  @override
  String get languageTr => 'Түркчө';

  @override
  String get languageEn => 'Англисче';

  @override
  String get themeLabel => 'Тема';

  @override
  String get themeSystem => 'Система';

  @override
  String get themeLight => 'Жарык';

  @override
  String get themeDark => 'Караңгы';

  @override
  String get defaultCurrencyLabel => 'Негизги валюта';

  @override
  String get defaultUnitLabel => 'Негизги бирдик';

  @override
  String get keepAwakeLabel => 'Сатып алууда экран өчпөсүн';

  @override
  String get backupSection => 'Резервдик көчүрмө';

  @override
  String get exportBackupLabel => 'Резервдик көчүрмөнү экспорттоо';

  @override
  String get importBackupLabel => 'Резервдик көчүрмөнү импорттоо';

  @override
  String get mergeImportLabel => 'Учурдагы маалыматтарга бириктирүү';

  @override
  String get separateImportLabel => 'Айрым көчүрмө катары импорттоо';

  @override
  String get importCancelled => 'Импорт токтотулду.';

  @override
  String get backupExported => 'Резервдик көчүрмө ийгиликтүү экспортталды.';

  @override
  String get backupSizeWarning =>
      'Чоң резервдик көчүрмө: файл чоң болушу мүмкүн. Сүрөттөрдү да кошосузбу?';

  @override
  String get deleteAllSection => 'Кооптуу зона';

  @override
  String get deleteAllLabel => 'Бардык маалыматты өчүрүү';

  @override
  String get deleteAllConfirm =>
      'Бул бардык тизмелерди, тарыхты, чектердин сүрөттөрүн жана бааларды өчүрөт. Сиз экспорттогон файлдар дискте сакталат. Улантасызбы?';

  @override
  String get deleteAllConfirm2 =>
      'Чын эле ишенесизби? Бул аракетти кайтарып болбойт.';

  @override
  String get cancelAction => 'Жокко чыгаруу';

  @override
  String get confirmDelete => 'Мүдүт өчүрүү';

  @override
  String get dataDeleted => 'Бардык жергиликтүү маалымат өчүрүлдү.';

  @override
  String get privacyInfoLabel => 'Купуялуулук';

  @override
  String get privacyInfoBody =>
      'Тизмелериңиз, баалар, чектер жана сүрөттөр түзмөгүңүздө сакталат. Сүрөттөр жана үн эч качан андан чыкпайт. AI жардамчы күйгүзүлгөндө, гана текст (мисалы, чек саптары же сиз айткан нерселер) иштетүү үчүн серверибизге жиберилет жана сакталбайт.';

  @override
  String get aboutSection => 'Тууралуу';

  @override
  String get aboutPublisher => 'Нашыр: Crazy Penguin';

  @override
  String get aboutLicenses => 'Лицензиялар (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Үн киргизүү';

  @override
  String get voiceStatusUnknown => 'Кызмат: текшерилген эмес';

  @override
  String get permissionsLabel => 'Уруксаттар';

  @override
  String get permissionsBody =>
      'Камера, микрофон жана билдирүүлөр сиз аларды чын эле колдонгондо гана суралат.';

  @override
  String get unitsSection => 'Негизгилер';

  @override
  String get roundingNote =>
      'Акча тегеректөө бир эрежеге баш ийет: жарымдар нөлден алыстай тегеректелет, акыркы жолу Акча конвертациясында колдонулат.';

  @override
  String get voiceInputTitle => 'Үн киргизүү';

  @override
  String get voiceStartListening => 'Угууну баштоо';

  @override
  String get voiceTranscriptLabel => 'Транскрипт';

  @override
  String get parseAction => 'Талдоо';

  @override
  String get receiptReviewTitle => 'Чекти карап чыгуу';

  @override
  String get receiptTotal => 'Чектин жалпы суммасы';

  @override
  String get receiptTotalUnknown => 'Жалпы сумма аныктала элек';

  @override
  String get receiptDiff => 'Айырма';

  @override
  String get acceptLine => 'Кабыл алуу';

  @override
  String get ignoreLine => 'Эске албоо';

  @override
  String get receiptLineActions => 'Буюмга шилтеме, бөлүү же эске албоо';

  @override
  String get receiptCommit => 'Баарын кабыл алуу';

  @override
  String get receiptCommitted => 'Чек колдонулду.';

  @override
  String get priceHistoryTitle => 'Баанын тарыхы';

  @override
  String get noObservations => 'Баа байкоолору дагы жок';

  @override
  String get templatesSection => 'Шаблондор';

  @override
  String get templateHint => 'Мурунку сатып алуудан жаңы тизме түзүү';

  @override
  String get scanReceiptAction => 'Чекти сканердөө';

  @override
  String get shelfLabelAction => 'Рафтан баа этикеткасы';

  @override
  String get priceCandidatesTitle => 'Баа варианттары';

  @override
  String get noPriceCandidates => 'Баа табыла элек; кол менен киргизиңиз.';

  @override
  String get voiceUnavailable => 'Үн таануу иштебейт; кол менен киргизиңиз.';

  @override
  String get linkToItem => 'Буюмга шилтеме';

  @override
  String get splitLine => 'Экиге бөлүү';

  @override
  String get mergeWithNext => 'Кийинкиси менен бириктирүү';

  @override
  String get ocrNoText => 'Текст окула элек; кайра аракет кылыңыз.';

  @override
  String get priceHistoryAction => 'Баанын тарыхы';

  @override
  String get itemsEmptyTitle => 'Дагы буюмдар жок';

  @override
  String get itemsEmptyBody =>
      'Биринчи буюмуңузду кошуңуз — дүкөндө чыныгы бааны ушул жерден киргизесиз.';

  @override
  String get addItemTooltip => 'Буюм кошуу';

  @override
  String get unitAdet => 'даана';

  @override
  String get unitKilogram => 'кг';

  @override
  String get unitGram => 'г';

  @override
  String get unitLitre => 'Л';

  @override
  String get unitMililitre => 'мл';

  @override
  String get unitPaket => 'упак';

  @override
  String get unitKutu => 'коробка';

  @override
  String get unitSise => 'шампан';

  @override
  String get unitKavanoz => 'банка';

  @override
  String get unitDemet => 'букет';

  @override
  String get unitDuzine => 'доцзина';

  @override
  String get unitMetre => 'м';

  @override
  String get unitCustom => 'Өзгөчө';

  @override
  String get setReminderAction => 'Эскертме коюу';

  @override
  String get reminderPermissionDenied =>
      'Эскертмелер үчүн билдирүү уруксаты керек. Сиз муну системдик параметрлерден күйгүзө аласыз.';

  @override
  String get reminderScheduled => 'Эскертме коюлду.';

  @override
  String get reminderCancelled => 'Эскертме алынды.';

  @override
  String get reminderTitle => 'Сатып алуу эскертмеси';

  @override
  String reminderBody(Object title) {
    return 'Тизмеңизди текшерүү убактысы: $title';
  }

  @override
  String get reminderPickDate => 'Дата тандоо';

  @override
  String get reminderPickTime => 'Убакыт тандоо';

  @override
  String get itemDetailsSection => 'Маалыматтар';

  @override
  String get priceOptionalHint =>
      'Милдеттүү эмес — чыныгы бааны дүкөндө киргизесиз';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Пландалган: $total · $count буюм';
  }

  @override
  String get proActiveLabel => 'Pro активдүү — рахмат!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Жарнамасыз, көбүрөөк AI, резервдик көчүрмө · ай сайын аз баадан';

  @override
  String get proBenefitNoAds => 'Жарнамасыз тажрыйба';

  @override
  String get proBenefitBackup => 'Резервдик көчүрмө (экспорт/импорт)';

  @override
  String aboutVersion(Object version) {
    return 'Версия $version';
  }

  @override
  String get navDiscover => 'Табуу';

  @override
  String get shareAction => 'Приложениени бөлүшүү';

  @override
  String get rateAction => 'Баалоо';

  @override
  String get aboutOpenRow => 'Тууралуу жана ачык булак';

  @override
  String get voiceAddItemAction => 'Үн аркылуу кошуу';

  @override
  String get formatLocaleLabel => 'Сандар жана валюта форматы';

  @override
  String get formatLocaleSystem =>
      'Түзмөктүн форматы (Латин цифралары; башка учурларда англисче)';

  @override
  String get formatLocaleTr => 'Түрк (1.234,56)';

  @override
  String get formatLocaleEn => 'Англис (1,234.56)';

  @override
  String get aiToggleTitle => 'AI жардамчысы';

  @override
  String get aiToggleSubtitle =>
      'Кварталдарды дал келтирет, баа этикеткаларын окуйт жана сүйлөмдөрдү тизмеге айландырат. Сүрөттөр жана үн түзүлүштө сакталат; текст гана иштелет.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Бул айдагы AI сурамдарыңыз ($used/$limit) бүттү. Көбүрөөк мүмкүнчүлүк үчүн акы төлөңүз же AIсыз улантыңыз.';
  }

  @override
  String get aiOffline => 'Баглануу жок — AIсыз улантылууда.';

  @override
  String get aiFailed => 'AI учурда жеткиликтүү эмес — анысыз улантылууда.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'Түзүлүш';

  @override
  String get quickListAction => 'Сүйлөмдөн кошуу';

  @override
  String get quickListTitle => 'Тез тизме';

  @override
  String get quickListHint => 'мисалы: 1 кг алма 20, 2 нан, жарым кг сыр';

  @override
  String get quickListConvert => 'Тизмеге айландыруу';

  @override
  String quickListAdd(int count) {
    return '$count элементти кошуу';
  }

  @override
  String get quickListEmpty =>
      'Эч нерсе табылган жок. Аларды үтүр менен бөлүп жазып көрүңүз.';

  @override
  String get receiptAiMatched =>
      'AI чекти сиздин тизмеңизге дал келтирди. Шилтемелерди текшерип, ырастоо керек.';

  @override
  String get receiptNeedsCheck => 'Бул дал келүүнү текшерүү';

  @override
  String get receiptDiscountLine => 'Арзандалуу';

  @override
  String get compareItem => 'Элемент';

  @override
  String get compareEstimated => 'Болжолдуу';

  @override
  String get compareActual => 'Чыныгы';

  @override
  String get compareDiff => 'Айырма';

  @override
  String get compareTotal => 'Жалпы сумма';

  @override
  String get compareBudget => 'Бюджет';

  @override
  String get compareNotBought => 'сатылып алынган эмес';

  @override
  String get compareUnplanned => 'пландалбаган';

  @override
  String get pricierItems => 'Кымбат болду';

  @override
  String get cheaperItems => 'Арзан болду';

  @override
  String get compareAction => 'Салыштыруу';

  @override
  String get detailsSection => 'Маалыматтар';

  @override
  String get spendingTitle => 'Чыгымдар';

  @override
  String get spendingAction => 'Чыгымдар';

  @override
  String get spendingMonthTotal => 'Бул ай';

  @override
  String get spendingWeekly => 'Жумалык чыгымдар';

  @override
  String get spendingMonthly => 'Айлык чыгымдар';

  @override
  String get monthlyLimitTitle => 'Айлык лимит';

  @override
  String get monthlyLimitHelp => 'Сиз ай сайын канча каражат короткуңуз келет?';

  @override
  String get monthlyLimitRemove => 'Алып салуу';

  @override
  String get monthlyLimitSet => 'Орнотуу';

  @override
  String get monthlyLimitChange => 'Өзгөртүү';

  @override
  String get monthlyLimitNone =>
      'Калган сумманы көрүү үчүн айлык лимитти орнотуңуз.';

  @override
  String monthlyLimitOver(String amount) {
    return 'Лимиттен $amount ашып кетти';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return 'Бул айда $amount калды';
  }

  @override
  String get plansTitle => 'Пландар';

  @override
  String get plansHeadline => 'AI менен акылдуу сатып алыңыз';

  @override
  String get plansSubhead =>
      'Чектерди дал келтирүү, баа этикеткалары жана сүйлөмдөн тизмелер. Каалаган убакта токтотсоңуз болот.';

  @override
  String get plansMonthly => 'Айлык';

  @override
  String get plansYearly => 'Жылдык';

  @override
  String get planFree => 'Акысыз';

  @override
  String get planFreePrice => 'Мүмкүнчүлүккө чейин акысыз';

  @override
  String get planFreeAi => 'Айына 15 AI сурамы';

  @override
  String get planFreeAds => 'Кичине баннердик жарнамалар (биринчи 7 күндө жок)';

  @override
  String get planCoreFeatures =>
      'Тизмелер, баалар, чектер, чыгым диаграммалары';

  @override
  String get plansPerYear => '/ жыл';

  @override
  String get plansPerMonth => '/ ай';

  @override
  String get planTrial => '7 күн акысыз';

  @override
  String get planProAi => 'Айына 200 AI сурамы';

  @override
  String get planNoAds => 'Жарнама жок';

  @override
  String get planBackup => 'Колдоо экспорттоо жана импорттоо';

  @override
  String get planMaxAi => 'Айына 1000 AI сураныч';

  @override
  String get planMaxFamily => 'Чоң үй-бүлө сатып алуу үчүн';

  @override
  String get plansStoreUnavailable => 'Дүкөн учурда жеткиликтүү эмес.';

  @override
  String get retryAction => 'Кайталоо';

  @override
  String get plansPurchaseFailed =>
      'Сатып алуу ишке ашпады. Кайра аракет кылыңыз.';

  @override
  String get planLifetimeTitle => 'Өмүр бою жарнамасыз';

  @override
  String get planLifetimeSubtitle =>
      'Бир жолку төлөм: жарнасыз, колдоо; AI акысыз мүмкүнчүлүктө калат';

  @override
  String get plansRestore => 'Сатып алууну калыбына келтирүү';

  @override
  String get plansLegal =>
      'Жазылуулар токтотулганга чейин автоматтык түрдө жаңыртылат. Google Play › Төлөмдөр жана жазылуулар аркылуу каалаган убакта токтото аласыз. Багаларга Google Play көрсөткөн салыктар кирет.';

  @override
  String get planCurrent => 'Учурдагы';

  @override
  String get planStartTrial => '7 күндүк акысык сынакты баштоо';

  @override
  String get planChoose => 'Тандоо';

  @override
  String get plansAction => 'Пландар: Pro жана Max';

  @override
  String get assistantTitle => 'Ассистент';

  @override
  String get assistantGreeting => 'Салам! Эмне кылгыңыз келет?';

  @override
  String get assistantNewList => 'Жаңы тизме';

  @override
  String get assistantVoiceList => 'Үн менен тизме';

  @override
  String get assistantTextList => 'Сүйлөмдөн тизме';

  @override
  String get assistantScanReceipt => 'Чекти сканерлөө';

  @override
  String get assistantSpending => 'Менин чыгымдарым';

  @override
  String get assistantReceiptHint =>
      'Тизмеңизди ачып, сканерлөө үчүн чек белгисине басыңыз.';

  @override
  String get assistantToggleTitle => 'Ассистентти көрсөтүү';

  @override
  String get assistantToggleSubtitle =>
      'Оң жактын ылдыйкы бурчундагы кичинекей жардамчы';

  @override
  String get scanPriceLabel => 'Баа этикеткесин сканерлөө';

  @override
  String get saveFailed =>
      'Сакталбады. Сиздин өзгөртүүлөр сакталып калды. Кайра аракет кылып көрүңүз.';

  @override
  String get deleteItemConfirm =>
      'Бул товарды жана анын сатып алуу тарыхын өчүрүү керекпи?';

  @override
  String get clearPurchaseConfirm =>
      'Бул товардын тандоосун алып салып, анын сатып алуу тарыхын өчүрүү керекпи?';

  @override
  String get reportPdfAction => 'PDF отчетту сактоо';

  @override
  String get reportNotInvoice =>
      'Сатып алуунун жалпысы, салык чеки эмес. Салык ставкалары белгисиз.';

  @override
  String get purchaseVisits => 'Сатып алуу сапарлары';

  @override
  String get purchaseInterval => 'Сатып алуулар ортосундагы орточо күндөр';

  @override
  String get purchasedQuantity => 'Сатып алынган өлчөм';

  @override
  String get purchaseAnalyticsHint =>
      'Сатып алууларды эсептөө колдонууну билдирбейт. Валюталар жана бирдиктер бөлөк көрсөтүлөт.';

  @override
  String get receiptReplaces =>
      'Шилтемеленген чек саптары бар болгон сатып алууларды алмаштырат; шилтемеленбегендер кошулат.';

  @override
  String get voiceUnsupportedLanguage =>
      'Бул түзмөктө бул тил үчүн үн киргизүү мүмкүн эмес. Ордуна терип жазсаңыз болот.';

  @override
  String get voiceStopListening => 'Угуп алууну токтотуу';

  @override
  String get keepAwakeFailed =>
      'Экранды өчпөй турган кылуу ишке ашкан жок. Кайра аракет кылып көрүңүз.';
}
