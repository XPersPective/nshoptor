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
  String get backupSizeWarning =>
      'Велика резервна копија: фајл може бити велик. Да ли желите да укључите и фотографије?';

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
      'Ваше листе, цене, рачуни и фотографије остају на вашем уређају. Фотографије и глас никада не напуштају уређај. Када је помоћ AI укључена, само текст (на пример, ставке са рачуна или оно што стеDictated) се шаље на наш сервер ради обраде и не чува се.';

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
      'Без реклама, више AI, резервне копије · од мале месечне цене';

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
      'Упоређује рачуне, чита ознаке цена и претвара реченице у листе. Фотографије и глас остају на вашем уређају; обрађује се само текст.';

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
  String get planFreeAi => '15 AI захтева месечно';

  @override
  String get planFreeAds => 'Мале банер рекламе (без реклама првих 7 дана)';

  @override
  String get planCoreFeatures => 'Листе, цене, рачуни, графикони расхода';

  @override
  String get plansPerYear => '/ година';

  @override
  String get plansPerMonth => '/ месец';

  @override
  String get planTrial => '7 дана бесплатно';

  @override
  String get planProAi => '200 AI захтева месечно';

  @override
  String get planNoAds => 'Без реклама';

  @override
  String get planBackup => 'Извоз и увоз резервне копије';

  @override
  String get planMaxAi => '1000 AI захтева месечно';

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
  String get planLifetimeTitle => 'Без реклама доживотно';

  @override
  String get planLifetimeSubtitle =>
      'Једнократна уплата: без реклама, резервна копија; AI остаје на бесплатном лимиту';

  @override
  String get plansRestore => 'Врати купљене ставке';

  @override
  String get plansLegal =>
      'Претплате се аутоматски обнављају до отказивања. Откажите у било ком тренутку у Google Play › Плаћања и претплате. Цена укључује порезе приказане од стране Google Play-ја.';

  @override
  String get planCurrent => 'Тренутни';

  @override
  String get planStartTrial => 'Покрени 7-дневно бесплатно пробно раздобље';

  @override
  String get planChoose => 'Изабери';

  @override
  String get plansAction => 'Планови: Pro и Max';

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
      'Линкови повезаних рачуна замењују постојеће куповине; непојединачне линије се додају.';

  @override
  String get voiceUnsupportedLanguage =>
      'Овај језик није доступан за гласовни унос на овом уређају. Можете куцати уместо тога.';

  @override
  String get voiceStopListening => 'Престани да слушаш';

  @override
  String get keepAwakeFailed =>
      'Нисмо успели да одржимо екран укљученим. Молимо вас, покушајте поново.';
}
