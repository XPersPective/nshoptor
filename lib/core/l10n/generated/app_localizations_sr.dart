// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Serbian (`sr`).
class AppLocalizationsSr extends AppLocalizations {
  AppLocalizationsSr([String locale = 'sr']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Планирајте код куће. Купујте по плану.';

  @override
  String get listsTitle => 'Листе';

  @override
  String get listsTabActive => 'Активне';

  @override
  String get listsTabCompleted => 'Завршене';

  @override
  String get listsTabArchived => 'Архивирane';

  @override
  String get newListButton => 'Нова листа';

  @override
  String get listTitleHint => 'Наслов (опционо)';

  @override
  String get saveButton => 'Сачувај';

  @override
  String get cancelButton => 'Откажи';

  @override
  String get deleteButton => 'Обриши';

  @override
  String get editAction => 'Уреди';

  @override
  String get listDeleted => 'Листа обрисана';

  @override
  String get invalidAmountError => 'Неисправан износ';

  @override
  String get duplicateAction => 'Дуплирај';

  @override
  String get archiveAction => 'Архивирај';

  @override
  String get unarchiveAction => 'Деархивирај';

  @override
  String get deleteListConfirm =>
      'Обрисати ову листу? Планиране ставке ће такође бити уклоњене.';

  @override
  String get undoButton => 'Врати';

  @override
  String get searchListHint => 'Претрага листа';

  @override
  String get currencyLabel => 'Валута';

  @override
  String get budgetLabel => 'Буџет (опционо)';

  @override
  String get noteLabel => 'Напомена (опционо)';

  @override
  String get storeLabel => 'Продавница';

  @override
  String get keepAmountsAction => 'Задржи износе';

  @override
  String get resetAmountsAction => 'Ресетуј износе';

  @override
  String get currencyChangeWarning =>
      'Валута се мења. Шта да радимо са постојећим износима?';

  @override
  String get listsEmpty => 'Још нема листа. Направите свој први план куповине.';

  @override
  String get statusDraft => 'Нацрт';

  @override
  String get statusPlanned => 'Планирано';

  @override
  String get statusShopping => 'Куповина';

  @override
  String get statusCompleted => 'Завршено';

  @override
  String get statusArchived => 'Архивирано';

  @override
  String autoListTitle(String date) {
    return 'Куповина $date';
  }

  @override
  String get itemFormTitle => 'Додај ставку';

  @override
  String get itemNameLabel => 'Назив ставке';

  @override
  String get brandLabel => 'Бренд / варијанта (опционо)';

  @override
  String get categoryLabel => 'Категорија';

  @override
  String get quantityLabel => 'Количина';

  @override
  String get unitLabel => 'Јединица';

  @override
  String get pricingModeLabel => 'Режим уноса цене';

  @override
  String get pricingModeUnitPrice => 'Цена по јединици';

  @override
  String get pricingModeLineTotal => 'Укупна цена линије';

  @override
  String get plannedPriceLabel => 'Планирана цена';

  @override
  String lineTotalCalculated(String value) {
    return 'Укупна цена линије: $value';
  }

  @override
  String get requiredItemToggle => 'Обавезна ставка';

  @override
  String get maxPriceLabel => 'Максимална прихватљива цена (опционо)';

  @override
  String get itemNoteLabel => 'Напомена (опционо)';

  @override
  String get categoryProduce => 'Воће и поврће';

  @override
  String get categoryDairy => 'Млечни производи';

  @override
  String get categoryMeat => 'Месо';

  @override
  String get categoryBakery => 'Пекарски производи';

  @override
  String get categoryDrinks => 'Пића';

  @override
  String get categoryCleaning => 'Хемија за домаћинство';

  @override
  String get categoryPersonalCare => 'Лична хигијена';

  @override
  String get categoryHome => 'Домаћинство';

  @override
  String get categoryOther => 'Остало';

  @override
  String get invalidQuantityError => 'Неисправна количина';

  @override
  String get invalidPriceError => 'Неисправна цена';

  @override
  String get invalidNameError => 'Унесите назив';

  @override
  String unitPriceCalculated(String value) {
    return 'Јединична цена: $value';
  }

  @override
  String get shoppingTitle => 'Режим куповине';

  @override
  String get summaryPlannedTotal => 'Планирано';

  @override
  String get summaryInCart => 'У колу';

  @override
  String get summaryRemainingPlan => 'Преостали план';

  @override
  String get summaryProjected => 'Процењена укупна цена';

  @override
  String get summaryBudgetRemaining => 'Остатак буџета';

  @override
  String get summaryBudgetOver => 'Прелази буџет';

  @override
  String itemsProgress(String done, String total) {
    return '$done од $total ставки';
  }

  @override
  String get filterAll => 'Све';

  @override
  String get filterToBuy => 'За куповину';

  @override
  String get filterInCart => 'У колу';

  @override
  String get filterNotFound => 'Није пронађено';

  @override
  String get filterRequired => 'Обавезно';

  @override
  String get quickEntryTitle => 'Стварна цена';

  @override
  String get actualQuantityLabel => 'Стварна количина';

  @override
  String get actualPriceLabel => 'Стварна цена';

  @override
  String get discountLabel => 'Попуст (необавезно)';

  @override
  String get alternativeNameLabel =>
      'Назив алтернативног производа (необавезно)';

  @override
  String get savePurchaseButton => 'Додај у корпу';

  @override
  String get unplannedAddButton => 'Додај непредвиђену ставку';

  @override
  String get statusPending => 'Није узето';

  @override
  String get statusInCart => 'У колу';

  @override
  String get statusNotFound => 'Није пронађено';

  @override
  String get statusGaveUp => 'Одустао';

  @override
  String get statusAlternative => 'Купљена алтернатива';

  @override
  String get keepScreenAwake => 'Одржи екран укљученим';

  @override
  String get finishShopping => 'Заврши куповину';

  @override
  String get completionWarning =>
      'Постоје недостајуће или непроверене ставке. И даље можете завршити; резултат ће их навести.';

  @override
  String get continueShoppingButton => 'Настави куповину';

  @override
  String get resultTitle => 'Резултат';

  @override
  String get summarySection => 'Преглед';

  @override
  String get plannedTotalLabel => 'Укупно планирано';

  @override
  String get actualTotalLabel => 'Укупно стварно';

  @override
  String get varianceLabel => 'Разлика';

  @override
  String get varianceNotComputable => 'Не може се израчунати';

  @override
  String get budgetStatusLabel => 'Буџет';

  @override
  String get savingsLabel => 'Испод плана';

  @override
  String get overspendLabel => 'Изван плана';

  @override
  String get unplannedTotalLabel => 'Укупно непредвиђено';

  @override
  String get unpurchasedLabel => 'Планирано, али није купљено';

  @override
  String get totalDiscountLabel => 'Укупни попусти';

  @override
  String get accuracyLabel => 'Тачност процене';

  @override
  String get groupsSection => 'Ставке';

  @override
  String get groupPricier => 'Скупо од планираног';

  @override
  String get groupCheaper => 'Јефтино од планираног';

  @override
  String get groupClose => 'Близу процене';

  @override
  String get groupNotTaken => 'Планирано, није купљено';

  @override
  String get groupUnplanned => 'Купљено без плана';

  @override
  String get groupQuantityChanged => 'Количина промењена';

  @override
  String get groupUnverified => 'Није проверено';

  @override
  String get plannedQtyLabel => 'Планирана количина';

  @override
  String get actualQtyLabel => 'Стварна количина';

  @override
  String get plannedUnitPriceLabel => 'Планирана јединична цена';

  @override
  String get actualUnitPriceLabel => 'Стварна јединична цена';

  @override
  String get lineVarianceLabel => 'Разлика по линији';

  @override
  String get discountEffectLabel => 'Ефекат попута';

  @override
  String get notBoughtMark => 'није купљено';

  @override
  String get noPurchasesNote => 'Нема забележених куповина.';

  @override
  String get navHome => 'Почетна';

  @override
  String get navLists => 'Листе';

  @override
  String get navHistory => 'Историја';

  @override
  String get navSettings => 'Подешавања';

  @override
  String get homeEmptyTitle => 'Планирајте куповину';

  @override
  String get homeEmptyBody =>
      'Направите своју прву листу и упоредите планиране и стварне трошкове.';

  @override
  String get homeActiveSection => 'Активне листе';

  @override
  String get homeCompletedSection => 'Недавно завршене';

  @override
  String get homeMonthlySection => 'Овог месеца';

  @override
  String get monthPlannedLabel => 'Планирано';

  @override
  String get monthActualLabel => 'Стварно';

  @override
  String get monthVarianceLabel => 'Разлика';

  @override
  String get continueShoppingLabel => 'Настави куповину';

  @override
  String get historyEmpty =>
      'Још увек нема завршених куповина. Ваша историја и увиди ће се појавити овде.';

  @override
  String get aboutTabTitle => 'О апликацији NShoptor';

  @override
  String get aboutBody =>
      'NShoptor од Crazy Penguin. Планинер за куповину који ради офлајн. Лиценциран под GPL-3.0.';

  @override
  String get startShoppingLabel => 'Започни куповину';

  @override
  String get finishAndSeeResult => 'Заврши и види резултат';

  @override
  String get settingsTitle => 'Подешавања';

  @override
  String get languageLabel => 'Језик';

  @override
  String get languageSystem => 'Системски';

  @override
  String get languageTr => 'Турски';

  @override
  String get languageEn => 'Енглески';

  @override
  String get themeLabel => 'Тема';

  @override
  String get themeSystem => 'Системска';

  @override
  String get themeLight => 'Светла';

  @override
  String get themeDark => 'Тамна';

  @override
  String get defaultCurrencyLabel => 'Основна валута';

  @override
  String get defaultUnitLabel => 'Основна јединица';

  @override
  String get keepAwakeLabel => 'Одржавај екран укљученим током куповине';

  @override
  String get backupSection => 'Резервна копија';

  @override
  String get exportBackupLabel => 'Извези резервну копију';

  @override
  String get importBackupLabel => 'Увези резервну копију';

  @override
  String get mergeImportLabel => 'Споји са тренутним подацима';

  @override
  String get separateImportLabel => 'Увези као посебну копију';

  @override
  String get importCancelled => 'Увоз је отказан.';

  @override
  String get backupExported => 'Резервна копија је успешно извезена.';

  @override
  String get deleteAllSection => 'Зона опасности';

  @override
  String get deleteAllLabel => 'Обриши све податке';

  @override
  String get deleteAllConfirm =>
      'Ово ће уклонити све листе, историју, фотографије рачуна и цене. Фајлове које сте извезли остају на вашем диску. Наставити?';

  @override
  String get deleteAllConfirm2 =>
      'Да ли сте потпуно сигурни? Ова акција се не може вратити.';

  @override
  String get cancelAction => 'Откажи';

  @override
  String get confirmDelete => 'Бриши трајно';

  @override
  String get dataDeleted => 'Сви локални подаци су обрисани.';

  @override
  String get privacyInfoLabel => 'Приватност';

  @override
  String get privacyInfoBody =>
      'Ваше листе, цене, рачуни и фотографије чувају се на вашем уређају. Глас га никада не напушта. Када је AI помоћ укључена, фотографије рачуна и ценовних налепница (смањене величине) и текст, попут издиктираних ставки, шаљу се на наш сервер само ради читања; обрађују се одмах и никада се не чувају.';

  @override
  String get aboutSection => 'О апликацији';

  @override
  String get aboutPublisher => 'Издавач: Crazy Penguin';

  @override
  String get aboutLicenses => 'Лиценце (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Гласовни унос';

  @override
  String get voiceStatusUnknown => 'Услуга: није проверено';

  @override
  String get permissionsLabel => 'Дозволе';

  @override
  String get permissionsBody =>
      'Камера, микрофон и обавештења се захтевају само када стварно користите те функције.';

  @override
  String get unitsSection => 'Подразумевано';

  @override
  String get roundingNote =>
      'Заокруживање новца следи једно правило: половине се заокружују удаљавајући од нуле, примењује се једном при конверзији новца.';

  @override
  String get voiceInputTitle => 'Гласовни унос';

  @override
  String get voiceStartListening => 'Започни слушање';

  @override
  String get voiceTranscriptLabel => 'Транскрипт';

  @override
  String get parseAction => 'Парсирај';

  @override
  String get receiptReviewTitle => 'Преглед рачуна';

  @override
  String get receiptTotal => 'Укупно за рачун';

  @override
  String get receiptTotalUnknown => 'Укупно није препознато';

  @override
  String get receiptDiff => 'Разлика';

  @override
  String get acceptLine => 'Прихвати ставку';

  @override
  String get ignoreLine => 'Занемари ставку';

  @override
  String get receiptLineActions => 'Повези са ставком, подели или занемари';

  @override
  String get receiptCommit => 'Прихвати све';

  @override
  String get receiptCommitted => 'Рачун је примењен.';

  @override
  String get priceHistoryTitle => 'Историја цена';

  @override
  String get noObservations => 'Још нема забележених цена';

  @override
  String get templatesSection => 'Шаблони';

  @override
  String get templateHint => 'Креирај нови списак на основу претходне куповине';

  @override
  String get scanReceiptAction => 'Скенирај рачун';

  @override
  String get fromReceiptListButton => 'Са рачуна';

  @override
  String get shelfLabelAction => 'Цена са етикете на полицама';

  @override
  String get priceCandidatesTitle => 'Кандидати за цену';

  @override
  String get noPriceCandidates => 'Није пронађена цена; унесите је ручно.';

  @override
  String get voiceUnavailable =>
      'Препознавање гласа није доступно; унесите ручно.';

  @override
  String get linkToItem => 'Повези са ставком';

  @override
  String get splitLine => 'Подели на две';

  @override
  String get mergeWithNext => 'Споји са следећом';

  @override
  String get ocrNoText => 'Није прочитан текст; покушајте поново.';

  @override
  String get priceHistoryAction => 'Историја цена';

  @override
  String get itemsEmptyTitle => 'Још нема ставки';

  @override
  String get itemsEmptyBody =>
      'Додајте своју прву ставку — овде ћете уносити стварне цене у продавници.';

  @override
  String get addItemTooltip => 'Додај ставку';

  @override
  String get unitAdet => 'ком';

  @override
  String get unitKilogram => 'кг';

  @override
  String get unitGram => 'г';

  @override
  String get unitLitre => 'Л';

  @override
  String get unitMililitre => 'мл';

  @override
  String get unitPaket => 'пакет';

  @override
  String get unitKutu => 'кутија';

  @override
  String get unitSise => 'боца';

  @override
  String get unitKavanoz => 'тегла';

  @override
  String get unitDemet => 'сноп';

  @override
  String get unitDuzine => 'десетина';

  @override
  String get unitMetre => 'м';

  @override
  String get unitCustom => 'Прилагођено';

  @override
  String get setReminderAction => 'Постави подсетник';

  @override
  String get reminderPermissionDenied =>
      'За подсетнике је потребна дозвола за обавештења. Можете је укључити у системским подешавањима.';

  @override
  String get reminderScheduled => 'Подсетник је постављен.';

  @override
  String get reminderCancelled => 'Подсетник је уклоњен.';

  @override
  String get reminderTitle => 'Подсетник за куповину';

  @override
  String reminderBody(Object title) {
    return 'Време је да проверите свој списак: $title';
  }

  @override
  String get reminderPickDate => 'Изаберите датум';

  @override
  String get reminderPickTime => 'Изаберите време';

  @override
  String get itemDetailsSection => 'Детаљи';

  @override
  String get priceOptionalHint =>
      'Опционо — стварну цену ћете унети у продавници';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'План: $total · $count ставки';
  }

  @override
  String get proActiveLabel => 'НШоптор Про активан — хвала!';

  @override
  String get proBuyLabel => 'НШоптор Про';

  @override
  String get proBenefitsLine =>
      'Без реклама · Извоз и увоз резервне копије · Годишње';

  @override
  String get proBenefitNoAds => 'Искуство без реклама';

  @override
  String get proBenefitBackup => 'Резервна копија (извоз/увоз)';

  @override
  String aboutVersion(Object version) {
    return 'Верзија $version';
  }

  @override
  String get navDiscover => 'Откриј';

  @override
  String get shareAction => 'Подели апликацију';

  @override
  String get rateAction => 'Оцените нас';

  @override
  String get aboutOpenRow => 'О апликацији и отворени код';

  @override
  String get voiceAddItemAction => 'Додај гласом';

  @override
  String get formatLocaleLabel => 'Формат бројева и валуте';

  @override
  String get formatLocaleSystem =>
      'Формат уређаја (Латиничке цифре; иначе енглески)';

  @override
  String get formatLocaleTr => 'Турски (1.234,56)';

  @override
  String get formatLocaleEn => 'Енглески (1,234.56)';

  @override
  String get aiToggleTitle => 'AI помоћ';

  @override
  String get aiToggleSubtitle =>
      'Чита рачуне и ценовне налепнице са фотографија, упарује рачуне и претвара реченице у листе. Фотографије се шаљу само ради читања и никада се не чувају.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Искористили сте месечни лимит AI захтева ($used/$limit). Надградите за више или наставите без AI.';
  }

  @override
  String get aiOffline => 'Нема везе — настављамо без AI.';

  @override
  String get aiFailed => 'AI тренутно није доступан — настављамо без њега.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'Уређај';

  @override
  String get quickListAction => 'Додај из реченице';

  @override
  String get quickListTitle => 'Брза листа';

  @override
  String get quickListHint => 'нпр. 1 кг јабука 20, 2 леба, пола кило сира';

  @override
  String get quickListConvert => 'Претвори у листу';

  @override
  String quickListAdd(int count) {
    return 'Додај $count ставки';
  }

  @override
  String get quickListEmpty =>
      'Није пронађена ниједна ставка. Покушајте да их наведете одвојене зарезима.';

  @override
  String get receiptAiMatched =>
      'AI је упарио рачун са вашом листом. Проверите повезивање и потврдите.';

  @override
  String get receiptNeedsCheck => 'Проверите ово упаривање';

  @override
  String get receiptDiscountLine => 'Попуст';

  @override
  String get compareItem => 'Ставка';

  @override
  String get compareEstimated => 'Процена';

  @override
  String get compareActual => 'Стварно';

  @override
  String get compareDiff => 'Разлика';

  @override
  String get compareTotal => 'Укупно';

  @override
  String get compareBudget => 'Буџет';

  @override
  String get compareNotBought => 'није купљено';

  @override
  String get compareUnplanned => 'није планирано';

  @override
  String get pricierItems => 'Скупо';

  @override
  String get cheaperItems => 'Јефтино';

  @override
  String get compareAction => 'Пореди';

  @override
  String get detailsSection => 'Детаљи';

  @override
  String get spendingTitle => 'Расходи';

  @override
  String get spendingAction => 'Расходи';

  @override
  String get spendingMonthTotal => 'Ове месеца';

  @override
  String get spendingWeekly => 'Недељни расходи';

  @override
  String get spendingMonthly => 'Месечни расходи';

  @override
  String get monthlyLimitTitle => 'Месечни лимит';

  @override
  String get monthlyLimitHelp =>
      'Колико желите да трошите на куповину месечно?';

  @override
  String get monthlyLimitRemove => 'Уклони';

  @override
  String get monthlyLimitSet => 'Подеси';

  @override
  String get monthlyLimitChange => 'Промени';

  @override
  String get monthlyLimitNone =>
      'Подесите месечни лимит да бисте видели колико вам преостаје.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount преко лимита';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return '$amount преостаје овог месеца';
  }

  @override
  String get plansTitle => 'Планови';

  @override
  String get plansHeadline => 'Купујте паметније уз AI';

  @override
  String get plansSubhead =>
      'Упаривање рачуна, ознаке цена и листе из реченице. Откажите када год желите.';

  @override
  String get plansMonthly => 'Месечно';

  @override
  String get plansYearly => 'Годишње';

  @override
  String get planFree => 'Бесплатно';

  @override
  String get planFreePrice => 'Бесплатно увек';

  @override
  String get planFreeAi => '10 AI захтева месечно';

  @override
  String get planFreeAds => 'Мале банер рекламе (без реклама првих 7 дана)';

  @override
  String get planCoreFeatures => 'Листе, цене, рачуни, графикони расхода';

  @override
  String get plansPerYear => '/ година';

  @override
  String get plansPerMonth => '/ месец';

  @override
  String get planTrial => 'Бесплатни пробни период';

  @override
  String get planProAi => '100 AI захтева месечно';

  @override
  String get planNoAds => 'Без реклама';

  @override
  String get planBackup => 'Извоз и увоз резервне копије';

  @override
  String get planMaxAi => '300 AI захтева месечно';

  @override
  String get planMaxFamily => 'За велику породичну куповину';

  @override
  String get plansStoreUnavailable => 'Продавница тренутно није доступна.';

  @override
  String get retryAction => 'Покушај поново';

  @override
  String get plansPurchaseFailed =>
      'Куповина није успела. Молимо покушајте поново.';

  @override
  String get plansRestore => 'Врати купљене ставке';

  @override
  String get plansLegal =>
      'Pro се аутоматски обнавља сваке године до отказивања и укључује 100 AI захтева месечно. Основна цена је 1 амерички долар годишње пре применљивих пореза; проверите коначну локалну цену и порезе у продавници пре потврде куповине. Управљајте претплатом или је откажите у Google Play-у.';

  @override
  String get planCurrent => 'Тренутни';

  @override
  String get planStartTrial => 'Започни бесплатни пробни период';

  @override
  String get planChoose => 'Изабери';

  @override
  String get plansAction => 'Планови: Pro';

  @override
  String get assistantTitle => 'Асистент';

  @override
  String get assistantGreeting => 'Здраво! Шта желите да урадите?';

  @override
  String get assistantNewList => 'Нова листа';

  @override
  String get assistantVoiceList => 'Листа преко гласа';

  @override
  String get assistantTextList => 'Листа из реченице';

  @override
  String get assistantScanReceipt => 'Скенирајте рачун';

  @override
  String get assistantSpending => 'Моји трошкови';

  @override
  String get assistantReceiptHint =>
      'Отворите своју листу и додирните икону рачуна да бисте је скенирали.';

  @override
  String get assistantToggleTitle => 'Прикажи асистента';

  @override
  String get assistantToggleSubtitle => 'Мали помоћник у доњем десном углу';

  @override
  String get scanPriceLabel => 'Скенирај ознаку цене';

  @override
  String get saveFailed =>
      'Није могуће сачувати. Промене су и даље овде. Молимо покушајте поново.';

  @override
  String get deleteItemConfirm =>
      'Обрисати ову ставку и њене забележене куповине?';

  @override
  String get clearPurchaseConfirm =>
      'Поништити ову ставку и уклонити њене забележене куповине?';

  @override
  String get reportPdfAction => 'Сачувај ПДФ извештај';

  @override
  String get reportNotInvoice =>
      'Преглед куповине, није пореска рачуна. Пореске стопе су непознате.';

  @override
  String get purchaseVisits => 'Посете куповини';

  @override
  String get purchaseInterval => 'Просечан број дана између куповина';

  @override
  String get purchasedQuantity => 'Количина купљеног';

  @override
  String get purchaseAnalyticsHint =>
      'Куповине не мере потрошњу. Валуте и јединице приказане су одвојено.';

  @override
  String get receiptReplaces =>
      'Попуњавају се цене артикала без цене. Артикли са тржишном ценом додају се као засебне куповине.';

  @override
  String get receiptIncompleteHeader =>
      'На следећој фотографији наведите продавницу, датум, време и број рачуна.';

  @override
  String get receiptIncompleteTail =>
      'Фотографишите следећи део тако да се неколико артикала преклапа и да се види коначан износ.';

  @override
  String get receiptContinuationRejected =>
      'Ова фотографија није могла да се споји. Поново је снимите са преклопљеним артиклима са истог рачуна.';

  @override
  String get receiptDraftSaved =>
      'Рачун је сачуван као нацрт. Можете наставити касније.';

  @override
  String get receiptContinueAction => 'Настави рачун';

  @override
  String get receiptDraftsTitle => 'Недовршени рачуни';

  @override
  String get receiptDuplicate => 'Овај рачун је већ додат.';

  @override
  String get receiptTotalMismatch =>
      'Збир артикала се не поклапа са укупним износом на рачуну. Проверите да ли се види цео рачун.';

  @override
  String get receiptSaveDraftAction => 'Сачувај за касније';

  @override
  String get receiptResolveLines =>
      'Прихватите или занемарите сваку ставку пре чувања.';

  @override
  String get receiptPartialConfirm =>
      'Биће додате само изабране ставке. Овај рачун ће бити означен као увезен. Наставити?';

  @override
  String get voiceUnsupportedLanguage =>
      'Овај језик није доступан за гласовни унос на овом уређају. Можете куцати уместо тога.';

  @override
  String get voiceStopListening => 'Престани да слушаш';

  @override
  String get keepAwakeFailed =>
      'Нисмо успели да одржимо екран укљученим. Молимо вас, покушајте поново.';

  @override
  String get purchaseHistoryHint =>
      'Сви завршени куповини. Поврати смањују укупне износе. Датуми се односе на датуме завршетка куповине. Једна посета није довољна за израчунавање просечног интервала.';

  @override
  String get planLegacyRights =>
      'Постојеће Pro и Max претплате задржавају свој оригинални месечни AI лимит.';

  @override
  String get csvExportAction => 'Извези CSV';

  @override
  String get backupSizeWarning =>
      'JSON садржи записе, а не фајлове фотографија. Ограничење увоза: 16 MB.';

  @override
  String get backupImportFailed =>
      'Нисмо успели да увеземо ову резервну копију. Ваша подаци нису промењени.';

  @override
  String get backupImported => 'Бекап је успешно увезен.';

  @override
  String backupPreviewCounts(Object entries, Object items, Object lists) {
    return '$lists листи · $items ставки · $entries куповине';
  }

  @override
  String get voiceModelDownloading =>
      'Гласовни модел за овај језик се преузима. Покушајте поново за минут.';

  @override
  String get historyThisWeek => 'Ова недеља';

  @override
  String get historyProductsSection => 'Купљени производи';

  @override
  String get tipReceiptScan =>
      'Skenirajte račun da uskladite cene sa vašom listom';

  @override
  String get tipVoiceAdd =>
      'Izgovorite jedan ili više artikala i proverite ih pre dodavanja';

  @override
  String get tipShelfCamera => 'Pročitajte cenu sa etikete na polici kamerom';

  @override
  String get tipPlan =>
      'Vaš plan: pogledajte detalje, pretplatite se ili nadogradite';

  @override
  String get guideAddBody =>
      'Dodirnite + da dodate artikal. Unesite planiranu cenu sada, a tržišnu na kasi.';

  @override
  String get guideVoiceBody =>
      'Dodirnite mikrofon i izgovorite artikle, na primer: „1 kg jabuka, 1 hleb“.';

  @override
  String get guideReceiptBody =>
      'Skenirajte račun da uskladite njegove cene sa artiklima na listi.';

  @override
  String get guidePlanBody =>
      'Dodirnite ikonu plana da vidite plan, pretplatite se ili nadogradite.';

  @override
  String get guideNext => 'U redu';

  @override
  String get guideDone => 'Počni';

  @override
  String get paletteLabel => 'Tema boja';

  @override
  String get paletteForest => 'Šuma';

  @override
  String get paletteOcean => 'Okean';

  @override
  String get paletteSunset => 'Zalazak sunca';

  @override
  String get paletteLavender => 'Lavanda';

  @override
  String get darkBlackLabel => 'Potpuno crna u tamnoj temi';

  @override
  String get spendingOverview => 'Pregled';

  @override
  String get spendingThisYear => 'Ove godine';

  @override
  String get spendingYearly => 'Godišnja potrošnja';

  @override
  String get productSpending => 'Potrošnja po proizvodu';

  @override
  String get spanWeek => 'Nedelja';

  @override
  String get spanMonth => 'Mesec';

  @override
  String get spanYear => 'Godina';

  @override
  String get weeklyLimitTitle => 'Nedeljni limit';

  @override
  String get weeklyLimitHelp =>
      'Koliko želite da trošite na kupovinu nedeljno?';

  @override
  String get weeklyLimitNone =>
      'Postavite nedeljni limit da vidite koliko je ostalo.';

  @override
  String weeklyLimitLeft(String amount) {
    return 'Ove nedelje ostalo $amount';
  }

  @override
  String get shoppingLimitTitle => 'Limit po kupovini';

  @override
  String get shoppingLimitHelp => 'Nove liste počinju sa ovim budžetom.';

  @override
  String get shoppingLimitNone =>
      'Postavite podrazumevani budžet za svaku novu kupovinu.';

  @override
  String get monthlyReportAction => 'Mesečni izveštaj';

  @override
  String get reportShoppingColumn => 'Kupovina';

  @override
  String get reportDateColumn => 'Datum';

  @override
  String get planUnavailable => 'Trenutno nije dostupno u prodavnici';

  @override
  String get demoDataTitle => 'Primer podataka';

  @override
  String get demoDataLoad => 'Isprobajte sa primerom podataka';

  @override
  String get demoDataLoadHelp =>
      'Dodaje 12 meseci primera kupovina da vidite istoriju, grafikone i istoriju cena.';

  @override
  String get demoDataRemove => 'Ukloni primer podataka';

  @override
  String get demoDataAdded => 'Primer podataka dodat';

  @override
  String get demoDataRemoved => 'Primer podataka uklonjen';

  @override
  String get demoProductApple => 'Jabuke';

  @override
  String get demoProductBread => 'Hleb';

  @override
  String get demoProductMilk => 'Mleko';

  @override
  String get demoProductCheese => 'Sir';

  @override
  String get demoProductTomato => 'Paradajz';

  @override
  String get demoProductEggs => 'Jaja';

  @override
  String get demoProductCoffee => 'Kafa';

  @override
  String get demoProductDetergent => 'Deterdžent';

  @override
  String get sendAction => 'Send';

  @override
  String get previousMonthAction => 'Previous month';

  @override
  String get nextMonthAction => 'Next month';

  @override
  String get helpSection => 'Помоћ и подршка';

  @override
  String get howToUseLabel => 'Како користити';

  @override
  String get guidePricesBody =>
      'Цена у продавници означава производ као купљен; рачуна се и 0. Кућна цена није обавезна. Избришите цену у продавници да уклоните ознаку.';

  @override
  String get shoppingDateLabel => 'Датум куповине';

  @override
  String get shoppingDateNone => 'Датум није изабран';

  @override
  String get clearShoppingDateAction => 'Уклони датум';

  @override
  String get listSortLabel => 'Редослед списка';

  @override
  String get listSortDate => 'Датум куповине';

  @override
  String get listSortAz => 'Назив (А–Ш)';

  @override
  String get listSortManual => 'Ручни редослед';

  @override
  String get imageCameraAction => 'Фотографиши';

  @override
  String get imageGalleryAction => 'Изабери из фотографија';

  @override
  String get imageCaptureFailed =>
      'Није могуће отворити камеру или фотографије. Проверите дозволу за приступ и покушајте поново.';

  @override
  String get imageRecognitionFailed =>
      'Фотографију није могуће обрадити. Покушајте са другом фотографијом.';

  @override
  String get receiptNoProducts =>
      'Текст је прочитан, али ставке рачуна нису пронађене. На фотографији обухватите ставке и укупан износ.';

  @override
  String get keepAwakeOn => 'Екран остаје укључен';

  @override
  String get keepAwakeOff => 'Екран се може искључити';

  @override
  String get spanDay => 'Дан';

  @override
  String get spanCustom => 'Распон датума';

  @override
  String get reportTotalSpent => 'Укупно потрошено';

  @override
  String get reportAddedAt => 'Датум додавања';

  @override
  String get reportReceiptNumber => 'Број рачуна';

  @override
  String get reportPreview => 'Преглед';

  @override
  String get reportShareAction => 'Подели';

  @override
  String get previousPeriodAction => 'Претходни период';

  @override
  String get nextPeriodAction => 'Следећи период';

  @override
  String get reportSaved => 'Извештај је сачуван.';

  @override
  String get reportZoom => 'Увећај';

  @override
  String planTrialDaysLeft(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days дана преостало',
      few: '$days дана преостала',
      one: '$days дан преостао',
    );
    return '$_temp0';
  }

  @override
  String planTrialHoursLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours сати преостало',
      few: '$hours сата преостала',
      one: '$hours сат преостао',
    );
    return '$_temp0';
  }

  @override
  String get planTrialEndedTitle => 'Пробни период Pro је истекао';

  @override
  String get planTrialEndedBody =>
      'Можете и даље бесплатно да користите листе, ручни унос и глас на уређају. Бесплатни план укључује 10 AI захтева по календарском месецу. Изаберите годишњи Pro за 100 AI захтева месечно, без огласа и уз резервне копије. Ваши постојећи подаци остају уз вас.';

  @override
  String get planContinueFree => 'Настави бесплатно';

  @override
  String get supportIdLabel => 'ID подршке';

  @override
  String get supportEmailLabel => 'Подршка путем е-поште';
}
