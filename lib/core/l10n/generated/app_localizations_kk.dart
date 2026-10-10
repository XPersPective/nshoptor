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
  String get backupSizeWarning =>
      'Үлкен сақтандыру: файл үлкен болуы мүмкін. Суреттерді де қосу керек пе?';

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
      'Сіздің тізімдеріңіз, бағалар, чектер және суреттер құрылғыңызда қалады. Суреттер мен дауыс ешқашан одан шықпайды. AI көмегі қосылғанда, тек мәтін (мысалы, чек жолдары немесе сіз айтқан нәрсе) серверге жіберіледі және сақталмайды.';

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
  String get proBenefitsLine =>
      'Жарсыз, көбірек AI, резервтік көшірме · ай сайынғы шағы бағамен';

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
      'Чектерді сәйкестендіреді, баға жапсырмаларын оқиды және сөйлемдерден тізім жасайды. Суреттер мен дауыс құрылғыңызда қалады; тек мәтін өңделеді.';

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
  String get planTrial => '7 күн тегін';

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
  String get planLifetimeTitle => 'Өмір бойы жарсыз';

  @override
  String get planLifetimeSubtitle =>
      'Бір реттік төлем: жарсыз, сақтау; AI тегін лимитте қалады';

  @override
  String get plansRestore => 'Сатылымдарды қалпына келтіру';

  @override
  String get plansLegal =>
      'Тапсырыстар жойылғанша автоматты түрде жаңартылады. Кез келген уақытта Google Play › Төлемдер мен тапсырыстар бөлімінде тоқтата аласыз. Бағаларға Google Play көрсеткен салықтар кіреді.';

  @override
  String get planCurrent => 'Ағымдағы';

  @override
  String get planStartTrial => '7 күндік тегін сынақты бастау';

  @override
  String get planChoose => 'Таңдау';

  @override
  String get plansAction => 'Жоспарлар: Pro және Max';

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
      'Тіркетілген чек жолдары бар сатылымдарды алмастырады; тіркелмеген жолдар қосылады.';

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
      'Ескі Pro және Max жазылымдары өздерінің айлық AI шектеуін сақтайды. Жаңа ұсыныстар 100 және 300 сұраныс береді.';
}
