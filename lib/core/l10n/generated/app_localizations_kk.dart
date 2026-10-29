// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kazakh (`kk`).
class AppLocalizationsKk extends AppLocalizations {
  AppLocalizationsKk([String locale = 'kk']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Үйде жоспарла. Жоспар бойынша сатып ал.';

  @override
  String get listsTitle => 'Тізімдер';

  @override
  String get listsTabActive => 'Белсенді';

  @override
  String get listsTabCompleted => 'Аяқталған';

  @override
  String get listsTabArchived => 'Архивтелген';

  @override
  String get newListButton => 'Жаңа тізім';

  @override
  String get listTitleHint => 'Тақырып (міндетті емес)';

  @override
  String get saveButton => 'Сақтау';

  @override
  String get cancelButton => 'Болдырмау';

  @override
  String get deleteButton => 'Жою';

  @override
  String get editAction => 'Өңдеу';

  @override
  String get listDeleted => 'Тізім жойылды';

  @override
  String get invalidAmountError => 'Қате мөлшер';

  @override
  String get duplicateAction => 'Көшіру';

  @override
  String get archiveAction => 'Архивтеу';

  @override
  String get unarchiveAction => 'Архивтен шығару';

  @override
  String get deleteListConfirm =>
      'Бұл тізімді жою керек пе? Оның жоспарланған заттары да алынып тасталады.';

  @override
  String get undoButton => 'Алға қайтару';

  @override
  String get searchListHint => 'Тізімдерден іздеу';

  @override
  String get currencyLabel => 'Валюта';

  @override
  String get budgetLabel => 'Бюджет (міндетті емес)';

  @override
  String get noteLabel => 'Ескерту (міндетті емес)';

  @override
  String get storeLabel => 'Дүкен';

  @override
  String get keepAmountsAction => 'Мөлшерлерді сақтау';

  @override
  String get resetAmountsAction => 'Мөлшерлерді қалпына келтіру';

  @override
  String get currencyChangeWarning =>
      'Валюта өзгеруде. Барлық мөлшерлермен не істеу керек?';

  @override
  String get listsEmpty => 'Әлі тізім жоқ. Алғашқы сауда жоспарыңызды жасаңыз.';

  @override
  String get statusDraft => 'Жоба';

  @override
  String get statusPlanned => 'Жоспарланған';

  @override
  String get statusShopping => 'Сатып алу';

  @override
  String get statusCompleted => 'Аяқталған';

  @override
  String get statusArchived => 'Архивтелген';

  @override
  String autoListTitle(String date) {
    return '$date сауда';
  }

  @override
  String get itemFormTitle => 'Зат қосу';

  @override
  String get itemNameLabel => 'Зат атауы';

  @override
  String get brandLabel => 'Бренд / нұсқа (міндетті емес)';

  @override
  String get categoryLabel => 'Санат';

  @override
  String get quantityLabel => 'Мөлшер';

  @override
  String get unitLabel => 'Өлшем бірлік';

  @override
  String get pricingModeLabel => 'Баға енгізу';

  @override
  String get pricingModeUnitPrice => 'Бірлік бағасы';

  @override
  String get pricingModeLineTotal => 'Жол соммасы';

  @override
  String get plannedPriceLabel => 'Жоспарланған баға';

  @override
  String lineTotalCalculated(String value) {
    return 'Жол сомасы: $value';
  }

  @override
  String get requiredItemToggle => 'Міндетті зат';

  @override
  String get maxPriceLabel => 'Максималды қабылданатын баға (міндетті емес)';

  @override
  String get itemNoteLabel => 'Ескерту (міндетті емес)';

  @override
  String get categoryProduce => 'Жемістер мен көкөністер';

  @override
  String get categoryDairy => 'Сүт өнімдері';

  @override
  String get categoryMeat => 'Ет';

  @override
  String get categoryBakery => 'Нан пісіру';

  @override
  String get categoryDrinks => 'Сусындар';

  @override
  String get categoryCleaning => 'Тазалау құралдары';

  @override
  String get categoryPersonalCare => 'Жеке күтім';

  @override
  String get categoryHome => 'Үй';

  @override
  String get categoryOther => 'Басқа';

  @override
  String get invalidQuantityError => 'Қате мөлшер';

  @override
  String get invalidPriceError => 'Қате баға';

  @override
  String get invalidNameError => 'Атауын енгізіңіз';

  @override
  String unitPriceCalculated(String value) {
    return 'Бірлік баға: $value';
  }

  @override
  String get shoppingTitle => 'Сатып алу режимі';

  @override
  String get summaryPlannedTotal => 'Жоспарланған';

  @override
  String get summaryInCart => 'Себетте';

  @override
  String get summaryRemainingPlan => 'Қалған жоспар';

  @override
  String get summaryProjected => 'Бағаланған төлем';

  @override
  String get summaryBudgetRemaining => 'Қалған бюджет';

  @override
  String get summaryBudgetOver => 'Бюджеттен асып кетті';

  @override
  String itemsProgress(String done, String total) {
    return '$total заттың $done-і';
  }

  @override
  String get filterAll => 'Барлығы';

  @override
  String get filterToBuy => 'Сатып алу керек';

  @override
  String get filterInCart => 'Себетте';

  @override
  String get filterNotFound => 'Табылмады';

  @override
  String get filterRequired => 'Міндетті';

  @override
  String get quickEntryTitle => 'Нақты баға';

  @override
  String get actualQuantityLabel => 'Нақты мөлшері';

  @override
  String get actualPriceLabel => 'Нақты баға';

  @override
  String get discountLabel => 'Арзан түсу (міндетті емес)';

  @override
  String get alternativeNameLabel => 'Альтернативті өнім атауы (міндетті емес)';

  @override
  String get savePurchaseButton => 'Себетке қосу';

  @override
  String get unplannedAddButton => 'Жоспарланбаған зат қосу';

  @override
  String get statusPending => 'Алынбады';

  @override
  String get statusInCart => 'Себетте';

  @override
  String get statusNotFound => 'Табылмады';

  @override
  String get statusGaveUp => 'Бас тартылды';

  @override
  String get statusAlternative => 'Альтернатива сатып алынды';

  @override
  String get keepScreenAwake => 'Экранды ұйықтатпау';

  @override
  String get finishShopping => 'Сатып алуды аяқтау';

  @override
  String get completionWarning =>
      'Жетіспейтін немесе расталмаған деректер бар. Сіз әлі де аяқтай аласыз; нәтижесінде олар туралы ескертіледі.';

  @override
  String get continueShoppingButton => 'Сатып алуды жалғастыру';

  @override
  String get resultTitle => 'Нәтиже';

  @override
  String get summarySection => 'Түйін';

  @override
  String get plannedTotalLabel => 'Жоспарланған сома';

  @override
  String get actualTotalLabel => 'Нақты сома';

  @override
  String get varianceLabel => 'Айырмашылық';

  @override
  String get varianceNotComputable => 'Есептеле алмайды';

  @override
  String get budgetStatusLabel => 'Бюджет';

  @override
  String get savingsLabel => 'Жоспардан арзан';

  @override
  String get overspendLabel => 'Жоспардан асып кетті';

  @override
  String get unplannedTotalLabel => 'Жоспарланбаған сома';

  @override
  String get unpurchasedLabel => 'Жоспарланған, бірақ сатып алынбаған';

  @override
  String get totalDiscountLabel => 'Жалпы арзан түсулер';

  @override
  String get accuracyLabel => 'Бағалау дәлдігі';

  @override
  String get groupsSection => 'Заттар';

  @override
  String get groupPricier => 'Жоспарланғандан қымбат';

  @override
  String get groupCheaper => 'Жоспарланғандан арзан';

  @override
  String get groupClose => 'Бағалауға жақын';

  @override
  String get groupNotTaken => 'Жоспарланған, сатып алынбаған';

  @override
  String get groupUnplanned => 'Жоспарсыз сатып алынған';

  @override
  String get groupQuantityChanged => 'Мөлшері өзгертілді';

  @override
  String get groupUnverified => 'Расталмаған';

  @override
  String get plannedQtyLabel => 'Жоспарланған мөлшері';

  @override
  String get actualQtyLabel => 'Нақты мөлшері';

  @override
  String get plannedUnitPriceLabel => 'Жоспарланған бірлік баға';

  @override
  String get actualUnitPriceLabel => 'Нақты бірлік баға';

  @override
  String get lineVarianceLabel => 'Жол айырмашылығы';

  @override
  String get discountEffectLabel => 'Арзан түсу әсері';

  @override
  String get notBoughtMark => 'сатып алынбады';

  @override
  String get noPurchasesNote => 'Сатып алулар тіркелмеді.';

  @override
  String get navHome => 'Басты бет';

  @override
  String get navLists => 'Тізімдер';

  @override
  String get navHistory => 'Тарих';

  @override
  String get navSettings => 'Баптаулар';

  @override
  String get homeEmptyTitle => 'Дәмхана жоспарыңызды құрыңыз';

  @override
  String get homeEmptyBody =>
      'Бірінші тізіміңізді жасап, жоспарланған шығындар мен нақты шығындарды салыстырыңыз.';

  @override
  String get homeActiveSection => 'Белсенді тізімдер';

  @override
  String get homeCompletedSection => 'Жақында аяқталғандар';

  @override
  String get homeMonthlySection => 'Бұл ай';

  @override
  String get monthPlannedLabel => 'Жоспарланған';

  @override
  String get monthActualLabel => 'Нақты';

  @override
  String get monthVarianceLabel => 'Айырмашылық';

  @override
  String get continueShoppingLabel => 'Сатып алуды жалғастыру';

  @override
  String get historyEmpty =>
      'Әлі аяқталған сатып алу жоқ. Тарих пен талдау осында көрсетіледі.';

  @override
  String get aboutTabTitle => 'NShoptor туралы';

  @override
  String get aboutBody =>
      'Crazy Penguin компаниясының NShoptor. Офлайн-бірінші дәмхана жоспарлаушысы. GPL-3.0 лицензиясымен қолжетімді.';

  @override
  String get startShoppingLabel => 'Сатып алуды бастау';

  @override
  String get finishAndSeeResult => 'Аяқтау және нәтижені көру';

  @override
  String get settingsTitle => 'Баптаулар';

  @override
  String get languageLabel => 'Тіл';

  @override
  String get languageSystem => 'Жүйе';

  @override
  String get languageTr => 'Түрікше';

  @override
  String get languageEn => 'Англисше';

  @override
  String get themeLabel => 'Тақырып';

  @override
  String get themeSystem => 'Жүйе';

  @override
  String get themeLight => 'Жарық';

  @override
  String get themeDark => 'Қараңғы';

  @override
  String get defaultCurrencyLabel => 'Әдепкі валюта';

  @override
  String get defaultUnitLabel => 'Әдепкі өлшем бірлігі';

  @override
  String get keepAwakeLabel => 'Сатып алған кезде экранды ұстау';

  @override
  String get backupSection => 'Сақтандыру';

  @override
  String get exportBackupLabel => 'Сақтандыруды экспорттау';

  @override
  String get importBackupLabel => 'Сақтандыруды импорттау';

  @override
  String get mergeImportLabel => 'Ағымдағы деректерге біріктіру';

  @override
  String get separateImportLabel => 'Бөлек көшірме ретінде импорттау';

  @override
  String get importCancelled => 'Импорт тоқтатылды.';

  @override
  String get backupExported => 'Сақтандыру сәтті экспортталды.';

  @override
  String get deleteAllSection => 'Қауіпті аймақ';

  @override
  String get deleteAllLabel => 'Барлық деректерді жою';

  @override
  String get deleteAllConfirm =>
      'Бұл барлық тізімдерді, тарихты, чек суреттері мен бағаларды жояды. Сіз экспорттаған файлдар дискіңізде қалады. Жалғастырасыз ба?';

  @override
  String get deleteAllConfirm2 =>
      'Сіз шын мәнінде сенімдісіз бе? Бұл әрекетті қайтару мүмкін емес.';

  @override
  String get cancelAction => 'Болдырмау';

  @override
  String get confirmDelete => 'Мәңгілікке жою';

  @override
  String get dataDeleted => 'Барлық жергілікті деректер жойылды.';

  @override
  String get privacyInfoLabel => 'Құпиялылық';

  @override
  String get privacyInfoBody =>
      'Тізімдеріңіз, бағалар, чектер және суреттер құрылғыңызда сақталады. Дауыс одан ешқашан шықпайды. AI көмегі қосулы кезде чектер мен баға жапсырмаларының суреттері (кішірейтілген) және мәтін, мысалы, айтып жаздырылған тауарлар серверімізге тек оқу үшін жіберіледі; олар бірден өңделеді және ешқашан сақталмайды.';

  @override
  String get aboutSection => 'Туралы';

  @override
  String get aboutPublisher => 'Нашір: Crazy Penguin';

  @override
  String get aboutLicenses => 'Лицензиялар (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Дауыс кірісі';

  @override
  String get voiceStatusUnknown => 'Қызмет: тексерілмеді';

  @override
  String get permissionsLabel => 'Рұқсаттар';

  @override
  String get permissionsBody =>
      'Камера, микрофон және хабарламалар тек сол функцияларды нақты пайдаланғанда сұралатын болады.';

  @override
  String get unitsSection => 'Әдепкілер';

  @override
  String get roundingNote =>
      'Ақша дөңгелектеуі бір ережеге бағынады: жартылар нөлден алыстата дөңгелектенеді, Ақша конверсиясында бір рет қолданылады.';

  @override
  String get voiceInputTitle => 'Дауыс кірісі';

  @override
  String get voiceStartListening => 'Тыңдай бастау';

  @override
  String get voiceTranscriptLabel => 'Транскрипт';

  @override
  String get parseAction => 'Талдау';

  @override
  String get receiptReviewTitle => 'Чекті шолу';

  @override
  String get receiptTotal => 'Чектегі жалпы сома';

  @override
  String get receiptTotalUnknown => 'Жалпы сома анықталмады';

  @override
  String get receiptDiff => 'Айырмашылық';

  @override
  String get acceptLine => 'Қатарды қабылдау';

  @override
  String get ignoreLine => 'Қатарды елемеу';

  @override
  String get receiptLineActions => 'Тауарға сілтеме, бөлу немесе елемеу';

  @override
  String get receiptCommit => 'Барлығын қабылдау';

  @override
  String get receiptCommitted => 'Чек қолданылды.';

  @override
  String get priceHistoryTitle => 'Баға тарихы';

  @override
  String get noObservations => 'Әлі баға деректері жоқ';

  @override
  String get templatesSection => 'Үлгілер';

  @override
  String get templateHint => 'Алдыңғы дүкен сапарынан жаңа тізім жасаңыз';

  @override
  String get scanReceiptAction => 'Чекті сканерлеу';

  @override
  String get fromReceiptListButton => 'Түбіртектен';

  @override
  String get shelfLabelAction => 'Сөрелік таңбадағы баға';

  @override
  String get priceCandidatesTitle => 'Баға нұсқаулары';

  @override
  String get noPriceCandidates => 'Баға табылмады; қолмен енгізіңіз.';

  @override
  String get voiceUnavailable => 'Дауысты тану мүмкін емес; қолмен енгізіңіз.';

  @override
  String get linkToItem => 'Тауарға сілтеме';

  @override
  String get splitLine => 'Екіге бөлу';

  @override
  String get mergeWithNext => 'Келесімен біріктіру';

  @override
  String get ocrNoText => 'Мәтін оқылмады; қайталап көріңіз.';

  @override
  String get priceHistoryAction => 'Баға тарихы';

  @override
  String get itemsEmptyTitle => 'Әлі тауарлар жоқ';

  @override
  String get itemsEmptyBody =>
      'Бірінші тауарды қосыңыз — нақты бағаларды дүкенде осында енгізесіз.';

  @override
  String get addItemTooltip => 'Тауар қосу';

  @override
  String get unitAdet => 'дана';

  @override
  String get unitKilogram => 'кг';

  @override
  String get unitGram => 'г';

  @override
  String get unitLitre => 'л';

  @override
  String get unitMililitre => 'мл';

  @override
  String get unitPaket => 'пакет';

  @override
  String get unitKutu => 'қорап';

  @override
  String get unitSise => 'бөтелке';

  @override
  String get unitKavanoz => 'банка';

  @override
  String get unitDemet => 'шоқ';

  @override
  String get unitDuzine => 'ондық';

  @override
  String get unitMetre => 'м';

  @override
  String get unitCustom => 'Арнайы';

  @override
  String get setReminderAction => 'Еске салу орнату';

  @override
  String get reminderPermissionDenied =>
      'Еске салу үшін хабарлама рұқсаты қажет. Оны жүйе параметрлерінде қосуға болады.';

  @override
  String get reminderScheduled => 'Еске салу орнатылды.';

  @override
  String get reminderCancelled => 'Еске салу алынды.';

  @override
  String get reminderTitle => 'Дүкенге еске салу';

  @override
  String reminderBody(Object title) {
    return 'Тізіміңізді тексеру уақыты келді: $title';
  }

  @override
  String get reminderPickDate => 'Күнді таңдаңыз';

  @override
  String get reminderPickTime => 'Уақытты таңдаңыз';

  @override
  String get itemDetailsSection => 'Толығырақ';

  @override
  String get priceOptionalHint =>
      'Міндетті емес — нақты бағаны дүкенде енгізесіз';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Жоспарланған: $total · $count тауар';
  }

  @override
  String get proActiveLabel => 'Pro белсенді — рахмет!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine => 'Жарнамасыз · Сақтау және импорттау · Жылдық';

  @override
  String get proBenefitNoAds => 'Жарсыз тәжірибе';

  @override
  String get proBenefitBackup => 'Резервтік көшірме (экспорт/импорт)';

  @override
  String aboutVersion(Object version) {
    return 'Нұсқа $version';
  }

  @override
  String get navDiscover => 'Зерттеу';

  @override
  String get shareAction => 'Қосымшаны бөлісу';

  @override
  String get rateAction => 'Баға беріңіз';

  @override
  String get aboutOpenRow => 'Қосымша туралы & ашық бастапқы код';

  @override
  String get voiceAddItemAction => 'Дауыспен қосу';

  @override
  String get formatLocaleLabel => 'Сандар мен валюта форматы';

  @override
  String get formatLocaleSystem =>
      'Құрылғы форматы (Латын цифрлары; әйтпесе ағылшынша)';

  @override
  String get formatLocaleTr => 'Түрікше (1.234,56)';

  @override
  String get formatLocaleEn => 'Ағылшынша (1,234.56)';

  @override
  String get aiToggleTitle => 'AI көмегі';

  @override
  String get aiToggleSubtitle =>
      'Суреттерден чектер мен баға жапсырмаларын оқиды, чектерді сәйкестендіреді және сөйлемдерді тізімге айналдырады. Суреттер тек оқу үшін жіберіледі және ешқашан сақталмайды.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Бұл айдың AI сұраныстарын ($used/$limit) пайдаландыңыз. Көбірек алу үшін жаңартыңыз немесе AI-сыз жалғастырыңыз.';
  }

  @override
  String get aiOffline => 'Байланыс жоқ — AI-сыз жалғастыру.';

  @override
  String get aiFailed => 'AI қазір қолжетімсіз — онысыз жалғастыру.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'Құрылғы';

  @override
  String get quickListAction => 'Сөйлемнен қосу';

  @override
  String get quickListTitle => 'Жылдам тізім';

  @override
  String get quickListHint => 'мысалы, 1 кг алма 20, 2 нан, сырдың жарты кило';

  @override
  String get quickListConvert => 'Тізімге айналдыру';

  @override
  String quickListAdd(int count) {
    return '$count затты қосу';
  }

  @override
  String get quickListEmpty =>
      'Ешбір зат табылмады. Оларды үтірмен бөліп жазып көріңіз.';

  @override
  String get receiptAiMatched =>
      'AI чекті сіздің тізіміңізбен сәйкестендірді. Сілтемелерді тексеріп, растаңыз.';

  @override
  String get receiptNeedsCheck => 'Бұл сәйкестікті тексеру';

  @override
  String get receiptDiscountLine => 'Арзандату';

  @override
  String get compareItem => 'Зат';

  @override
  String get compareEstimated => 'Бааланған';

  @override
  String get compareActual => 'Шын мәнінде';

  @override
  String get compareDiff => 'Айырмашылық';

  @override
  String get compareTotal => 'Барлығы';

  @override
  String get compareBudget => 'Бюджет';

  @override
  String get compareNotBought => 'сатып алынбаған';

  @override
  String get compareUnplanned => 'жоспарланбаған';

  @override
  String get pricierItems => 'Қымбат түсті';

  @override
  String get cheaperItems => 'Арзан түсті';

  @override
  String get compareAction => 'Салыстыру';

  @override
  String get detailsSection => 'Мәліметтер';

  @override
  String get spendingTitle => 'Шығындар';

  @override
  String get spendingAction => 'Шығындар';

  @override
  String get spendingMonthTotal => 'Бұл ай';

  @override
  String get spendingWeekly => 'Аптасына шығындар';

  @override
  String get spendingMonthly => 'Айына шығындар';

  @override
  String get monthlyLimitTitle => 'Айлық шектеу';

  @override
  String get monthlyLimitHelp =>
      'Ай сайын дәмханаға неше сом жұмсағыңыз келеді?';

  @override
  String get monthlyLimitRemove => 'Жою';

  @override
  String get monthlyLimitSet => 'Орнату';

  @override
  String get monthlyLimitChange => 'Өзгерту';

  @override
  String get monthlyLimitNone =>
      'Қанша қалғанын көру үшін айлық шектеу орнатыңыз.';

  @override
  String monthlyLimitOver(String amount) {
    return 'Шектен $amount асып кетті';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return 'Бұл айда $amount қалды';
  }

  @override
  String get plansTitle => 'Жоспарлар';

  @override
  String get plansHeadline => 'AI арқылы ақылдырақ сауда жасаңыз';

  @override
  String get plansSubhead =>
      'Чектерді сәйкестендіру, баға жапсырмалары және сөйлемнен тізім. Кез келген уақытта бас тартуға болады.';

  @override
  String get plansMonthly => 'Айлық';

  @override
  String get plansYearly => 'Жылдық';

  @override
  String get planFree => 'Тегін';

  @override
  String get planFreePrice => 'Мәңгілік тегін';

  @override
  String get planFreeAi => 'Айына 10 AI сұраныс';

  @override
  String get planFreeAds =>
      'Кішігірім баннер жарнамалары (алғашқы 7 күнде жарнама жоқ)';

  @override
  String get planCoreFeatures =>
      'Тізімдер, бағалар, чектер, шығындар диаграммалары';

  @override
  String get plansPerYear => '/ жыл';

  @override
  String get plansPerMonth => '/ ай';

  @override
  String get planTrial => 'Тегін сынақ';

  @override
  String get planProAi => 'Айына 100 AI сұраныс';

  @override
  String get planNoAds => 'Жарнамасыз';

  @override
  String get planBackup => 'Сақтау және импорттау';

  @override
  String get planMaxAi => 'Айына 300 AI сұраныс';

  @override
  String get planMaxFamily => 'Үлкен отбасының шопингіне арналған';

  @override
  String get plansStoreUnavailable => 'Дүкен қазір қолжетімсіз.';

  @override
  String get retryAction => 'Қайталау';

  @override
  String get plansPurchaseFailed => 'Сатып алу орындалмады. Қайталап көріңіз.';

  @override
  String get plansRestore => 'Сатылымдарды қалпына келтіру';

  @override
  String get plansLegal =>
      'Pro тоқтатылғанға дейін жыл сайын автоматты түрде жаңартылады және ай сайын 100 ЖИ сұрауын қамтиды. Қолданылатын салықтарсыз базалық баға жылына 1 АҚШ доллары; сатып алуды растау алдында дүкендегі соңғы жергілікті баға мен салықтарды тексеріңіз. Жазылымды Google Play арқылы басқарыңыз немесе тоқтатыңыз.';

  @override
  String get planCurrent => 'Ағымдағы';

  @override
  String get planStartTrial => 'Тегін сынақты бастау';

  @override
  String get planChoose => 'Таңдау';

  @override
  String get plansAction => 'Жоспарлар: Pro';

  @override
  String get assistantTitle => 'Көмекші';

  @override
  String get assistantGreeting => 'Сәлем! Не істегің келеді?';

  @override
  String get assistantNewList => 'Жаңа тізім';

  @override
  String get assistantVoiceList => 'Дауыспен тізім';

  @override
  String get assistantTextList => 'Сөйлемнен тізім';

  @override
  String get assistantScanReceipt => 'Шекті сканерлеу';

  @override
  String get assistantSpending => 'Менің шығындарым';

  @override
  String get assistantReceiptHint =>
      'Тізіміңізді ашып, сканерлеу үшін шек белгішесін басыңыз.';

  @override
  String get assistantToggleTitle => 'Көмекшіні көрсету';

  @override
  String get assistantToggleSubtitle => 'Оң жақ төмендегі кішкентай көмекші';

  @override
  String get scanPriceLabel => 'Баға жапсырмасын сканерлеу';

  @override
  String get saveFailed =>
      'Сақтау сәтсіз аяқталды. Өзгерістеріңіз сақталған. Қайталап көріңіз.';

  @override
  String get deleteItemConfirm =>
      'Бұл тауар мен оның тіркелген сатылымдарын жою керек пе?';

  @override
  String get clearPurchaseConfirm =>
      'Бұл тауардың белгісін алып, оның тіркелген сатылымдарын жойғыңыз келе ме?';

  @override
  String get reportPdfAction => 'PDF есепті сақтау';

  @override
  String get reportNotInvoice =>
      'Сатып алу қорытындысы, салықтық шот емес. Салық мөлшерлемелері белгісіз.';

  @override
  String get purchaseVisits => 'Дүкенге барулар';

  @override
  String get purchaseInterval => 'Сатып алулар арасындағы орташа күндер саны';

  @override
  String get purchasedQuantity => 'Сатып алынған мөлшер';

  @override
  String get purchaseAnalyticsHint =>
      'Сатып алулар тұтыну көлемін өлшемейді. Валюталар мен бірліктер жеке көрсетіледі.';

  @override
  String get receiptReplaces =>
      'Бағасы жоқ тауарлардың бағасы толтырылады. Нарықтық бағасы бар тауарлар бөлек сатып алулар ретінде қосылады.';

  @override
  String get receiptIncompleteHeader =>
      'Келесі фотода дүкенді, күнді, уақытты және түбіртек нөмірін көрсетіңіз.';

  @override
  String get receiptIncompleteTail =>
      'Келесі бөлікті бірнеше қабаттасқан тауармен және соңғы сомамен бірге түсіріңіз.';

  @override
  String get receiptContinuationRejected =>
      'Бұл фотосуретті біріктіру мүмкін болмады. Сол түбіртектегі қабаттасқан тауарлармен қайта түсіріңіз.';

  @override
  String get receiptDraftSaved =>
      'Түбіртек жоба ретінде сақталды. Кейін жалғастыра аласыз.';

  @override
  String get receiptContinueAction => 'Түбіртекті жалғастыру';

  @override
  String get receiptDraftsTitle => 'Аяқталмаған түбіртектер';

  @override
  String get receiptDuplicate => 'Бұл түбіртек әлдеқашан қосылған.';

  @override
  String get receiptTotalMismatch =>
      'Тауарлар сомасы түбіртектегі жалпы сомаға сәйкес емес. Түбіртектің толық көрінгенін тексеріңіз.';

  @override
  String get receiptSaveDraftAction => 'Кейін сақтау';

  @override
  String get receiptResolveLines =>
      'Сақтамас бұрын әр тауарды қабылдаңыз немесе елемеңіз.';

  @override
  String get receiptPartialConfirm =>
      'Тек таңдалған тауарлар қосылады. Бұл чек импортталған деп белгіленеді. Жалғастыру керек пе?';

  @override
  String get voiceUnsupportedLanguage =>
      'Бұл тіл бұл құрылғыда дауыспен енгізу үшін қолжетімсіз. Оның орнына мәтінмен теруге болады.';

  @override
  String get voiceStopListening => 'Тыңдауды тоқтату';

  @override
  String get keepAwakeFailed =>
      'Экранды ұйықтамау режимінде ұстау мүмкін болмады. Қайталап көріңіз.';

  @override
  String get purchaseHistoryHint =>
      'Барлық аяқталған сатып алулар. Қайтарымдар жалпы соманы азайтады. Күндер сатып алу аяқталған күнмен байланысты. Бір реттік сапар орташа аралықты есептеу үшін жеткіліксіз.';

  @override
  String get planLegacyRights =>
      'Ескі Pro және Max жазылымдары өздерінің айлық AI шектеуін сақтайды.';

  @override
  String get csvExportAction => 'CSV экспорттау';

  @override
  String get reportSharePdf => 'PDF ретінде бөлісу';

  @override
  String get reportShareCsv => 'CSV ретінде бөлісу';

  @override
  String get reportPrintAction => 'Басып шығару';

  @override
  String get backupSizeWarning =>
      'JSON сурет файлдарын қамтиды, жазбаларды емес. Импорттау шегі: 16 МБ.';

  @override
  String get backupImportFailed =>
      'Бұл резервтік көшірмені импорттау мүмкін болмады. Деректеріңіз өзгертілмеді.';

  @override
  String get backupImported => 'Сақтық көшірме сәтті импортталды.';

  @override
  String backupPreviewCounts(Object entries, Object items, Object lists) {
    return '$lists тізім · $items тауар · $entries сатылым';
  }

  @override
  String get voiceModelDownloading =>
      'Бұл тілдің дауыс моделі жүктелуде. Бір минуттан кейін қайталап көріңіз.';

  @override
  String get historyThisWeek => 'Осы апта';

  @override
  String get historyProductsSection => 'Сатып алынған тауарлар';

  @override
  String get tipReceiptScan =>
      'Чекті сканерлеп, бағаларды тізіммен салыстырыңыз';

  @override
  String get tipVoiceAdd =>
      'Бір немесе бірнеше тауарды айтып, қосар алдында тексеріңіз';

  @override
  String get tipShelfCamera => 'Камерамен сөреге жапсырылған бағаны оқыңыз';

  @override
  String get tipPlan =>
      'Сіздің жоспарыңыз: мәліметтерді көріңіз, жазылыңыз немесе жоғарылатыңыз';

  @override
  String get guideAddBody =>
      'Тауар қосу үшін + басыңыз. Жоспарланған бағаны қазір, нарық бағасын кассада енгізіңіз.';

  @override
  String get guideVoiceBody =>
      'Микрофонды басып, тауарларды айтыңыз, мысалы: «1 кг алма, 1 нан».';

  @override
  String get guideReceiptBody =>
      'Чекті сканерлеп, оның бағаларын тізімдегі тауарлармен салыстырыңыз.';

  @override
  String get guidePlanBody =>
      'Жоспарды көру, жазылу немесе жоғарылату үшін жоспар белгішесін басыңыз.';

  @override
  String get guideNext => 'Жарайды';

  @override
  String get guideDone => 'Бастау';

  @override
  String get paletteLabel => 'Түс тақырыбы';

  @override
  String get paletteForest => 'Орман';

  @override
  String get paletteOcean => 'Мұхит';

  @override
  String get paletteSunset => 'Күн батуы';

  @override
  String get paletteLavender => 'Лаванда';

  @override
  String get darkBlackLabel => 'Қараңғы тақырыпта таза қара';

  @override
  String get spendingOverview => 'Шолу';

  @override
  String get spendingThisYear => 'Биыл';

  @override
  String get spendingYearly => 'Жылдық шығын';

  @override
  String get productSpending => 'Тауар бойынша шығын';

  @override
  String get spanWeek => 'Апта';

  @override
  String get spanMonth => 'Ай';

  @override
  String get spanYear => 'Жыл';

  @override
  String get weeklyLimitTitle => 'Апталық лимит';

  @override
  String get weeklyLimitHelp =>
      'Аптасына сауда-саттыққа қанша жұмсағыңыз келеді?';

  @override
  String get weeklyLimitNone =>
      'Қанша қалғанын көру үшін апталық лимит орнатыңыз.';

  @override
  String weeklyLimitLeft(String amount) {
    return 'Осы аптада $amount қалды';
  }

  @override
  String get shoppingLimitTitle => 'Әр сауда лимиті';

  @override
  String get shoppingLimitHelp => 'Жаңа тізімдер осы бюджетпен басталады.';

  @override
  String get shoppingLimitNone => 'Әр жаңа сауда үшін әдепкі бюджет орнатыңыз.';

  @override
  String get monthlyReportAction => 'Айлық есеп';

  @override
  String get reportShoppingColumn => 'Сауда';

  @override
  String get reportDateColumn => 'Күні';

  @override
  String get planUnavailable => 'Қазір дүкенде жоқ';

  @override
  String get demoDataTitle => 'Үлгі деректер';

  @override
  String get demoDataLoad => 'Үлгі деректермен байқап көру';

  @override
  String get demoDataLoadHelp =>
      'Тарихты, графиктерді және баға тарихын көру үшін 12 айлық үлгі сауданы қосады.';

  @override
  String get demoDataRemove => 'Үлгі деректерді жою';

  @override
  String get demoDataAdded => 'Үлгі деректер қосылды';

  @override
  String get demoDataRemoved => 'Үлгі деректер жойылды';

  @override
  String get demoProductApple => 'Алма';

  @override
  String get demoProductBread => 'Нан';

  @override
  String get demoProductMilk => 'Сүт';

  @override
  String get demoProductCheese => 'Ірімшік';

  @override
  String get demoProductTomato => 'Қызанақ';

  @override
  String get demoProductEggs => 'Жұмыртқа';

  @override
  String get demoProductCoffee => 'Кофе';

  @override
  String get demoProductDetergent => 'Жуғыш зат';

  @override
  String get sendAction => 'Send';

  @override
  String get previousMonthAction => 'Previous month';

  @override
  String get nextMonthAction => 'Next month';

  @override
  String get helpSection => 'Көмек және қолдау';

  @override
  String get howToUseLabel => 'Қалай пайдалану керек';

  @override
  String get guidePricesBody =>
      'Дүкен бағасы енгізілсе, тауар сатып алынған деп белгіленеді; 0 да есептеледі. Үйдегі баға міндетті емес. Белгіні алып тастау үшін дүкен бағасын өшіріңіз.';

  @override
  String get shoppingDateLabel => 'Сатып алу күні';

  @override
  String get shoppingDateNone => 'Күн таңдалмаған';

  @override
  String get clearShoppingDateAction => 'Күнді өшіру';

  @override
  String get listSortLabel => 'Тізім реті';

  @override
  String get listSortDate => 'Сатып алу күні';

  @override
  String get listSortAz => 'Атауы (А–Я)';

  @override
  String get listSortManual => 'Қолмен реттеу';

  @override
  String get imageCameraAction => 'Фото түсіру';

  @override
  String get imageGalleryAction => 'Фотолардан таңдау';

  @override
  String get imageCaptureFailed =>
      'Камераны немесе фотоларды ашу мүмкін болмады. Қол жеткізу рұқсатын тексеріп, қайталап көріңіз.';

  @override
  String get imageRecognitionFailed =>
      'Фотоны өңдеу мүмкін болмады. Басқа фотоны қолданып көріңіз.';

  @override
  String get receiptNoProducts =>
      'Мәтін оқылды, бірақ чектегі тауарлар табылмады. Фотоға тауарлар мен жалпы соманы қосыңыз.';

  @override
  String get keepAwakeOn => 'Экран қосулы тұрады';

  @override
  String get keepAwakeOff => 'Экран өшуі мүмкін';

  @override
  String get spanDay => 'Күн';

  @override
  String get spanCustom => 'Күндер аралығы';

  @override
  String get reportTotalSpent => 'Жалпы шығын';

  @override
  String get reportAddedAt => 'Қосылған күні';

  @override
  String get reportReceiptNumber => 'Чек нөмірі';

  @override
  String get reportPreview => 'Алдын ала қарау';

  @override
  String get reportShareAction => 'Бөлісу';

  @override
  String get previousPeriodAction => 'Алдыңғы кезең';

  @override
  String get nextPeriodAction => 'Келесі кезең';

  @override
  String get reportSaved => 'Есеп сақталды.';

  @override
  String get reportZoom => 'Үлкейту';

  @override
  String planTrialDaysLeft(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days күн қалды',
    );
    return '$_temp0';
  }

  @override
  String planTrialHoursLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours сағат қалды',
    );
    return '$_temp0';
  }

  @override
  String get planTrialEndedTitle => 'Pro сынақ мерзімі аяқталды';

  @override
  String get planTrialEndedBody =>
      'Тізімдерді, қолмен енгізуді және құрылғыдағы дауысты тегін пайдалана беруге болады. Тегін жоспар әр күнтізбелік айда 10 AI сұрауын қамтиды. Айына 100 AI сұрауы, жарнамасыз пайдалану және сақтық көшірмелер үшін жылдық Pro таңдаңыз. Қолданыстағы деректеріңіз сақталады.';

  @override
  String get planContinueFree => 'Тегін жалғастыру';

  @override
  String get supportIdLabel => 'Қолдау ID-і';

  @override
  String get supportEmailLabel => 'Электрондық пошта арқылы қолдау';

  @override
  String get captureTipFirst =>
      'Ең жоғарыдан бастаңыз: дүкен атауы мен күн көрінуі керек. Мүмкіндігінше көп тауарды қамтыңыз, қалғаны келесі фотода болады.';

  @override
  String get captureTipContinue =>
      'Сол түбіртек: алдыңғы фотодағы соңғы тауарды қосыңыз.';

  @override
  String get captureTipNeverShow => 'Қайта көрсетпеу';

  @override
  String get captureTipOk => 'Түсіндім';

  @override
  String get captureTipsSetting => 'Түбіртек түсіру кеңестерін көрсету';

  @override
  String get receiptReadingProgress => 'Түбіртек оқылуда…';

  @override
  String get receiptReadInBackground => 'Фонда жалғастыру';

  @override
  String get receiptReadDoneTitle => 'Түбіртек оқылды';

  @override
  String get receiptReadDoneBody => 'Тексеріп, сақтау үшін түртіңіз.';

  @override
  String get receiptReadMoreTitle =>
      'Түбіртектің қалған бөлігін суретке түсіріңіз';

  @override
  String get receiptReadFailedTitle => 'Түбіртекті оқу мүмкін болмады';

  @override
  String get listReceiptsSection => 'Чектер';

  @override
  String get receiptStateComplete => 'Аяқталды';

  @override
  String get receiptStateIncomplete => 'Толық емес';

  @override
  String get receiptStateFailed => 'Сәтсіз';

  @override
  String get receiptStoreUnknown => 'Дүкен оқылмады';

  @override
  String get receiptDeleteAction => 'Чекті жою';

  @override
  String get receiptDeleteConfirm =>
      'Осы чекті және ол қосқан тауарларды жою керек пе? Кейін оны қайта импорттай аласыз.';

  @override
  String get receiptDeleted => 'Чек жойылды.';

  @override
  String listReceiptsShowAll(int count) {
    return 'Барлығын көрсету ($count)';
  }

  @override
  String get listReceiptsShowLess => 'Азырақ көрсету';

  @override
  String receiptDateLabel(String date) {
    return 'Чек күні: $date';
  }

  @override
  String get historyViewShopping => 'Сатып алу бойынша';

  @override
  String get historyViewStore => 'Дүкен бойынша';

  @override
  String get historyViewProduct => 'Тауар бойынша';

  @override
  String get historyShareAll => 'Барлығын бөлісу';

  @override
  String get historyUnknownStore => 'Белгісіз дүкен';

  @override
  String get historyDailySpending => 'Күнделікті шығын';

  @override
  String get historyResetPeriod => 'Осы аптаға оралу';

  @override
  String get tourSkip => 'Өткізу';

  @override
  String get tourNewListBody =>
      'Сатып алу тізімін бастап, алатын заттарыңызды қосыңыз.';

  @override
  String get tourFromReceiptBody =>
      'Сатып алып қойдыңыз ба? Чекті бағаларымен тізімге айналдырыңыз.';

  @override
  String get tourReceiptFlowBody =>
      'Чектің жоғарғы жағынан бастаңыз: алдымен дүкен мен күнді түсіріп, содан кейін қалған жолдармен жалғастырыңыз.';

  @override
  String get tourTabsBody =>
      'Белсенді, аяқталған және мұрағаттағы тізімдер арасында ауысыңыз. Соңындағы түйме ретті өзгертеді.';

  @override
  String get tourDiscoverBody => 'Сол әзірлеушінің басқа қолданбалары.';

  @override
  String get tourHelpBody =>
      'Нұсқаулықты қайта көру үшін осында түртіңіз. Сомалар мен тауарлардың түсіндірмесі үшін тізім ашыңыз.';

  @override
  String get tourTotalsBody =>
      'Жоспарланған, нақты сома және айырма сатып алу кезінде жаңарады.';

  @override
  String get tourItemsBody =>
      'Тауарларыңыз. Олардың ретін осында өзгертіңіз немесе іздеңіз.';
}
