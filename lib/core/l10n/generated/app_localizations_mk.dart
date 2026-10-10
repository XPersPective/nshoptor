// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Macedonian (`mk`).
class AppLocalizationsMk extends AppLocalizations {
  AppLocalizationsMk([String locale = 'mk']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Планирај дома. Купувај според планот.';

  @override
  String get listsTitle => 'Списоци';

  @override
  String get listsTabActive => 'Активни';

  @override
  String get listsTabCompleted => 'Завршени';

  @override
  String get listsTabArchived => 'Архивирани';

  @override
  String get newListButton => 'Нов список';

  @override
  String get listTitleHint => 'Наслов (опционално)';

  @override
  String get saveButton => 'Зачувај';

  @override
  String get cancelButton => 'Откажи';

  @override
  String get deleteButton => 'Избриши';

  @override
  String get editAction => 'Уреди';

  @override
  String get listDeleted => 'Списокот е избришан';

  @override
  String get invalidAmountError => 'Невалидно количество';

  @override
  String get duplicateAction => 'Дублирај';

  @override
  String get archiveAction => 'Архивирај';

  @override
  String get unarchiveAction => 'Деархивирај';

  @override
  String get deleteListConfirm =>
      'Да го избришам овој список? Планираните ставки исто така ќе бидат отстранети.';

  @override
  String get undoButton => 'Врати';

  @override
  String get searchListHint => 'Пребарај списоци';

  @override
  String get currencyLabel => 'Валута';

  @override
  String get budgetLabel => 'Буджет (опционално)';

  @override
  String get noteLabel => 'Забелешка (опционално)';

  @override
  String get storeLabel => 'Продавница';

  @override
  String get keepAmountsAction => 'Задржи ги количините';

  @override
  String get resetAmountsAction => 'Ресетирај ги количините';

  @override
  String get currencyChangeWarning =>
      'Валутата се менува. Што да се случи со постоечките количини?';

  @override
  String get listsEmpty =>
      'Нема списоци уште. Направи го својот прв шопинг план.';

  @override
  String get statusDraft => 'Нацрт';

  @override
  String get statusPlanned => 'Планирано';

  @override
  String get statusShopping => 'Шопинг';

  @override
  String get statusCompleted => 'Завршено';

  @override
  String get statusArchived => 'Архивирano';

  @override
  String autoListTitle(String date) {
    return 'Шопинг на $date';
  }

  @override
  String get itemFormTitle => 'Додај ставка';

  @override
  String get itemNameLabel => 'Име на ставка';

  @override
  String get brandLabel => 'Бренд / варијанта (опционално)';

  @override
  String get categoryLabel => 'Категорија';

  @override
  String get quantityLabel => 'Количество';

  @override
  String get unitLabel => 'Единица';

  @override
  String get pricingModeLabel => 'Режим на внес на цена';

  @override
  String get pricingModeUnitPrice => 'Цена по единица';

  @override
  String get pricingModeLineTotal => 'Вкупно за ред';

  @override
  String get plannedPriceLabel => 'Планирана цена';

  @override
  String lineTotalCalculated(String value) {
    return 'Вкупно за ред: $value';
  }

  @override
  String get requiredItemToggle => 'Обврзана ставка';

  @override
  String get maxPriceLabel => 'Максимална прифатлива цена (опционално)';

  @override
  String get itemNoteLabel => 'Забелешка (опционално)';

  @override
  String get categoryProduce => 'Плодови и зеленчук';

  @override
  String get categoryDairy => 'Млечни производи';

  @override
  String get categoryMeat => 'Месо';

  @override
  String get categoryBakery => 'Пекарски производи';

  @override
  String get categoryDrinks => 'Пијалоци';

  @override
  String get categoryCleaning => 'Чистење';

  @override
  String get categoryPersonalCare => 'Лична хигиена';

  @override
  String get categoryHome => 'Домаќинство';

  @override
  String get categoryOther => 'Останато';

  @override
  String get invalidQuantityError => 'Невалидно количество';

  @override
  String get invalidPriceError => 'Невалидна цена';

  @override
  String get invalidNameError => 'Внесете име';

  @override
  String unitPriceCalculated(String value) {
    return 'Единечна цена: $value';
  }

  @override
  String get shoppingTitle => 'Режим за купување';

  @override
  String get summaryPlannedTotal => 'Планирано';

  @override
  String get summaryInCart => 'Во кошничка';

  @override
  String get summaryRemainingPlan => 'Преостанато од планот';

  @override
  String get summaryProjected => 'Проценета сума';

  @override
  String get summaryBudgetRemaining => 'Остаток на буџетот';

  @override
  String get summaryBudgetOver => 'Над буџетот';

  @override
  String itemsProgress(String done, String total) {
    return '$done од $total артикли';
  }

  @override
  String get filterAll => 'Сите';

  @override
  String get filterToBuy => 'За купување';

  @override
  String get filterInCart => 'Во кошничка';

  @override
  String get filterNotFound => 'Не е најден';

  @override
  String get filterRequired => 'Потребно';

  @override
  String get quickEntryTitle => 'Вистинска цена';

  @override
  String get actualQuantityLabel => 'Вистинска количина';

  @override
  String get actualPriceLabel => 'Вистинска цена';

  @override
  String get discountLabel => 'Попуст (по избор)';

  @override
  String get alternativeNameLabel =>
      'Алтернативно име на производот (по избор)';

  @override
  String get savePurchaseButton => 'Додај во кошничка';

  @override
  String get unplannedAddButton => 'Додај непредвиден артикл';

  @override
  String get statusPending => 'Не е земено';

  @override
  String get statusInCart => 'Во кошничка';

  @override
  String get statusNotFound => 'Не е најден';

  @override
  String get statusGaveUp => 'Откажано';

  @override
  String get statusAlternative => 'Купена алтернатива';

  @override
  String get keepScreenAwake => 'Зачувај го екранот активен';

  @override
  String get finishShopping => 'Заврши со купување';

  @override
  String get completionWarning =>
      'Има недостасувачки или непроверени записи. Сепак можете да завршите; резултатот ќе ги забележи.';

  @override
  String get continueShoppingButton => 'Продолжи со купување';

  @override
  String get resultTitle => 'Резултат';

  @override
  String get summarySection => 'Преглед';

  @override
  String get plannedTotalLabel => 'Вкупно планирано';

  @override
  String get actualTotalLabel => 'Вкупно вистинско';

  @override
  String get varianceLabel => 'Разлика';

  @override
  String get varianceNotComputable => 'Не може да се пресмета';

  @override
  String get budgetStatusLabel => 'Буџет';

  @override
  String get savingsLabel => 'Под планот';

  @override
  String get overspendLabel => 'Над планот';

  @override
  String get unplannedTotalLabel => 'Вкупно непредвидено';

  @override
  String get unpurchasedLabel => 'Планирано, но не е купено';

  @override
  String get totalDiscountLabel => 'Вкупни попусти';

  @override
  String get accuracyLabel => 'Точност на проценката';

  @override
  String get groupsSection => 'Артикли';

  @override
  String get groupPricier => 'Поскапи од планираното';

  @override
  String get groupCheaper => 'Појефтино од планираното';

  @override
  String get groupClose => 'Близу до проценката';

  @override
  String get groupNotTaken => 'Планирано, не е купено';

  @override
  String get groupUnplanned => 'Купено без план';

  @override
  String get groupQuantityChanged => 'Количината е променета';

  @override
  String get groupUnverified => 'Непроверено';

  @override
  String get plannedQtyLabel => 'Планирана количина';

  @override
  String get actualQtyLabel => 'Вистинска количина';

  @override
  String get plannedUnitPriceLabel => 'Планирана единечна цена';

  @override
  String get actualUnitPriceLabel => 'Вистинска единечна цена';

  @override
  String get lineVarianceLabel => 'Разлика по ред';

  @override
  String get discountEffectLabel => 'Ефект од попустот';

  @override
  String get notBoughtMark => 'не е купено';

  @override
  String get noPurchasesNote => 'Не беа забележани никакви покупки.';

  @override
  String get navHome => 'Дома';

  @override
  String get navLists => 'Листи';

  @override
  String get navHistory => 'Историја';

  @override
  String get navSettings => 'Поставки';

  @override
  String get homeEmptyTitle => 'Планирајте го купувањето';

  @override
  String get homeEmptyBody =>
      'Креирајте ја вашата прва листа и споредете планирани vs. реални трошоци.';

  @override
  String get homeActiveSection => 'Активни листи';

  @override
  String get homeCompletedSection => 'Неодамна завршени';

  @override
  String get homeMonthlySection => 'Овој месец';

  @override
  String get monthPlannedLabel => 'Планирано';

  @override
  String get monthActualLabel => 'Реално';

  @override
  String get monthVarianceLabel => 'Разлика';

  @override
  String get continueShoppingLabel => 'Продолжи со купување';

  @override
  String get historyEmpty =>
      'Сè уште нема завршено купување. Вашата историја и увид ќе се појават тука.';

  @override
  String get aboutTabTitle => 'За NShoptor';

  @override
  String get aboutBody =>
      'NShoptor од Crazy Penguin. Планирач за купување кој работи офлајн. Лиценциран под GPL-3.0.';

  @override
  String get startShoppingLabel => 'Започни со купување';

  @override
  String get finishAndSeeResult => 'Заврши & види резултат';

  @override
  String get settingsTitle => 'Поставки';

  @override
  String get languageLabel => 'Јазик';

  @override
  String get languageSystem => 'Системски';

  @override
  String get languageTr => 'Турски';

  @override
  String get languageEn => 'Англиски';

  @override
  String get themeLabel => 'Тема';

  @override
  String get themeSystem => 'Системска';

  @override
  String get themeLight => 'Светла';

  @override
  String get themeDark => 'Темна';

  @override
  String get defaultCurrencyLabel => 'Стандардна валута';

  @override
  String get defaultUnitLabel => 'Стандардна единица';

  @override
  String get keepAwakeLabel => 'Одржувај го екранот активен додека купувате';

  @override
  String get backupSection => 'Архива';

  @override
  String get exportBackupLabel => 'Извези архива';

  @override
  String get importBackupLabel => 'Увези архива';

  @override
  String get mergeImportLabel => 'Обедини во моменталните податоци';

  @override
  String get separateImportLabel => 'Увези како посебна копија';

  @override
  String get importCancelled => 'Увозот е откажан.';

  @override
  String get backupExported => 'Архивата успешно е извезена.';

  @override
  String get backupSizeWarning =>
      'Голема архива: датотеката може да биде голема. Дали сакате да ги вклучите и фотографиите?';

  @override
  String get deleteAllSection => 'Опасна зона';

  @override
  String get deleteAllLabel => 'Избриши ги сите податоци';

  @override
  String get deleteAllConfirm =>
      'Ова ќе ги отстрани сите листи, историја, фотографии од сметки и цени. Датотеките што вие сте ги извезени остануваат на вашиот диск. Продолжете?';

  @override
  String get deleteAllConfirm2 =>
      'Дали сте целосно сигурни? Ова дејство не може да се поништи.';

  @override
  String get cancelAction => 'Откажи';

  @override
  String get confirmDelete => 'Избриши трајно';

  @override
  String get dataDeleted => 'Сите локални податоци беа избришани.';

  @override
  String get privacyInfoLabel => 'Приватност';

  @override
  String get privacyInfoBody =>
      'Вашите листи, цени, сметки и фотографии остануваат на уредот. Фотографиите и гласот никогаш не излегуваат од него. Кога AI помошта е вклучена, само текст (на пример, линии од сметка или она што го диктиравте) се испраќа на нашиот сервер за обработка и не се чува.';

  @override
  String get aboutSection => 'За';

  @override
  String get aboutPublisher => 'Издавач: Crazy Penguin';

  @override
  String get aboutLicenses => 'Лиценци (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Гласовен внес';

  @override
  String get voiceStatusUnknown => 'Услуга: не проверено';

  @override
  String get permissionsLabel => 'Доверби';

  @override
  String get permissionsBody =>
      'Камера, микрофон и известувања се бараат само кога всушност ги користите тие функции.';

  @override
  String get unitsSection => 'Стандарди';

  @override
  String get roundingNote =>
      'Занесувањето на парите следи едно правило: половинките се занесуваат надолу/нагоре од нулата, применето еднаш при конверзија на пари.';

  @override
  String get voiceInputTitle => 'Гласовен внес';

  @override
  String get voiceStartListening => 'Започни со слушање';

  @override
  String get voiceTranscriptLabel => 'Транскрипт';

  @override
  String get parseAction => 'Анализирај';

  @override
  String get receiptReviewTitle => 'Преглед на сметка';

  @override
  String get receiptTotal => 'Вкупно од бележката';

  @override
  String get receiptTotalUnknown => 'Вкупното не е детектирано';

  @override
  String get receiptDiff => 'Разлика';

  @override
  String get acceptLine => 'Прифати ставка';

  @override
  String get ignoreLine => 'Игнорирај ставка';

  @override
  String get receiptLineActions => 'Поврзи со артикл, подели или игнорирај';

  @override
  String get receiptCommit => 'Прифати ги сите';

  @override
  String get receiptCommitted => 'Бележката е применета.';

  @override
  String get priceHistoryTitle => 'Историја на цени';

  @override
  String get noObservations => 'Сè уште нема забелешки за цени';

  @override
  String get templatesSection => 'Шаблони';

  @override
  String get templateHint => 'Креирај нов план од претходна купување';

  @override
  String get scanReceiptAction => 'Скенирај бележка';

  @override
  String get shelfLabelAction => 'Цена од етикета на полица';

  @override
  String get priceCandidatesTitle => 'Кандидати за цена';

  @override
  String get noPriceCandidates => 'Не е пронајдена цена; внесете ја рачно.';

  @override
  String get voiceUnavailable =>
      'Гласовното препознавање не е достапно; внесете рачно.';

  @override
  String get linkToItem => 'Поврзи со артикл';

  @override
  String get splitLine => 'Подели на две';

  @override
  String get mergeWithNext => 'Обедини со следната';

  @override
  String get ocrNoText => 'Не е прочитан текст; пробајте повторно.';

  @override
  String get priceHistoryAction => 'Историја на цени';

  @override
  String get itemsEmptyTitle => 'Сè уште нема артикли';

  @override
  String get itemsEmptyBody =>
      'Додадете го вашиот прв артикл — тука ќе ги внесувате вистинските цени во продавницата.';

  @override
  String get addItemTooltip => 'Додади артикл';

  @override
  String get unitAdet => 'парче';

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
  String get unitSise => 'бутилка';

  @override
  String get unitKavanoz => 'тегла';

  @override
  String get unitDemet => 'сноп';

  @override
  String get unitDuzine => 'десетка';

  @override
  String get unitMetre => 'м';

  @override
  String get unitCustom => 'Прилагодено';

  @override
  String get setReminderAction => 'Постави потсетник';

  @override
  String get reminderPermissionDenied =>
      'За потсетници се потребни дозволи за известувања. Можете да ги овозможите во системските поставки.';

  @override
  String get reminderScheduled => 'Потсетникот е поставен.';

  @override
  String get reminderCancelled => 'Потсетникот е отстранет.';

  @override
  String get reminderTitle => 'Потсетник за пазарување';

  @override
  String reminderBody(Object title) {
    return 'Време е да ја проверите вашата листа: $title';
  }

  @override
  String get reminderPickDate => 'Изберете датум';

  @override
  String get reminderPickTime => 'Изберете време';

  @override
  String get itemDetailsSection => 'Детали';

  @override
  String get priceOptionalHint =>
      'Опционално — вистинската цена ќе ја внесете во продавницата';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'План: $total · $count артикли';
  }

  @override
  String get proActiveLabel => 'Pro активно — ви благодариме!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Без реклами, повеќе AI, резервно копирање · од мала месечна цена';

  @override
  String get proBenefitNoAds => 'Искуство без реклами';

  @override
  String get proBenefitBackup => 'Резервно копирање (извоз/увоз)';

  @override
  String aboutVersion(Object version) {
    return 'Верзија $version';
  }

  @override
  String get navDiscover => 'Откриј';

  @override
  String get shareAction => 'Сподели ја апликацијата';

  @override
  String get rateAction => 'Оценете нè';

  @override
  String get aboutOpenRow => 'За нас и отворен код';

  @override
  String get voiceAddItemAction => 'Додај преку глас';

  @override
  String get formatLocaleLabel => 'Формат на број и валута';

  @override
  String get formatLocaleSystem =>
      'Формат на уредата (Латинички цифри; инаку англиски)';

  @override
  String get formatLocaleTr => 'Турски (1.234,56)';

  @override
  String get formatLocaleEn => 'Англиски (1,234.56)';

  @override
  String get aiToggleTitle => 'AI помош';

  @override
  String get aiToggleSubtitle =>
      'Ги совпаѓа сметките, ги чита етикетите со цени и претвора реченици во листи. Сликите и гласот остануваат на вашиот уред; обработува се само текст.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Ги искористивте месечните AI барања ($used/$limit). Надградете за повеќе или продолжете без AI.';
  }

  @override
  String get aiOffline => 'Нема врска — продолжуваме без AI.';

  @override
  String get aiFailed => 'AI моментално не е достапен — продолжуваме без него.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'Уред';

  @override
  String get quickListAction => 'Додај од реченица';

  @override
  String get quickListTitle => 'Брз список';

  @override
  String get quickListHint =>
      'на пр. 1 кг яболови 20, 2 лебови, половина кило сирење';

  @override
  String get quickListConvert => 'Претвори во список';

  @override
  String quickListAdd(int count) {
    return 'Додај $count ставки';
  }

  @override
  String get quickListEmpty =>
      'Не се најдени ставки. Обидете се да ги наведете разделени со запирки.';

  @override
  String get receiptAiMatched =>
      'AI ја совпадна сметката со вашиот список. Проверете ги врските и потврдете.';

  @override
  String get receiptNeedsCheck => 'Проверете го овој совпад';

  @override
  String get receiptDiscountLine => 'Попуст';

  @override
  String get compareItem => 'Ставка';

  @override
  String get compareEstimated => 'Проценка';

  @override
  String get compareActual => 'Вистинска цена';

  @override
  String get compareDiff => 'Разлика';

  @override
  String get compareTotal => 'Вкупно';

  @override
  String get compareBudget => 'Буџет';

  @override
  String get compareNotBought => 'не е купено';

  @override
  String get compareUnplanned => 'не е планирано';

  @override
  String get pricierItems => 'Поскапи';

  @override
  String get cheaperItems => 'Појефтини';

  @override
  String get compareAction => 'Спореди';

  @override
  String get detailsSection => 'Детали';

  @override
  String get spendingTitle => 'Расходи';

  @override
  String get spendingAction => 'Расходи';

  @override
  String get spendingMonthTotal => 'Овој месец';

  @override
  String get spendingWeekly => 'Неделни расходи';

  @override
  String get spendingMonthly => 'Месечни расходи';

  @override
  String get monthlyLimitTitle => 'Месечен лимит';

  @override
  String get monthlyLimitHelp =>
      'Колку сакате да трошите на пазарување месечно?';

  @override
  String get monthlyLimitRemove => 'Отстрани';

  @override
  String get monthlyLimitSet => 'Постави';

  @override
  String get monthlyLimitChange => 'Промени';

  @override
  String get monthlyLimitNone =>
      'Поставете месечен лимит за да видите колку ви преостанува.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount над лимитот';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return '$amount преостанува овој месец';
  }

  @override
  String get plansTitle => 'Планови';

  @override
  String get plansHeadline => 'Пазарувајте поумно со AI';

  @override
  String get plansSubhead =>
      'Совпаѓање на сметки, етикети со цени и списоци од реченица. Откажете во секое време.';

  @override
  String get plansMonthly => 'Месечно';

  @override
  String get plansYearly => 'Годишно';

  @override
  String get planFree => 'Бесплатно';

  @override
  String get planFreePrice => 'Засекогаш бесплатно';

  @override
  String get planFreeAi => '10 AI барања месечно';

  @override
  String get planFreeAds =>
      'Мали банер реклами (без ниту една во првите 7 дена)';

  @override
  String get planCoreFeatures => 'Списоци, цени, сметки, дијаграми на расходи';

  @override
  String get plansPerYear => '/ година';

  @override
  String get plansPerMonth => '/ месец';

  @override
  String get planTrial => '7 дена бесплатно';

  @override
  String get planProAi => '100 AI барања месечно';

  @override
  String get planNoAds => 'Без реклами';

  @override
  String get planBackup => 'Експорт и увоз на резервна копија';

  @override
  String get planMaxAi => '300 AI барања месечно';

  @override
  String get planMaxFamily => 'За купување за голема фамилија';

  @override
  String get plansStoreUnavailable => 'Продавницата моментално не е достапна.';

  @override
  String get retryAction => 'Обиди се повторно';

  @override
  String get plansPurchaseFailed =>
      'Купувањето не беше успешно. Ве молиме обидете се повторно.';

  @override
  String get planLifetimeTitle => 'Без реклами засекогаш';

  @override
  String get planLifetimeSubtitle =>
      'Еднократно плаќање: без реклами, резервна копија; AI останува во бесплатниот лимит';

  @override
  String get plansRestore => 'Врати ги купените функции';

  @override
  String get plansLegal =>
      'Претплатите автоматски се обновуваат до откажување. Откажете го во било кое време преку Google Play › Плаќања и претплати. Цените ги вклучуваат даноците прикажани од Google Play.';

  @override
  String get planCurrent => 'Тековна';

  @override
  String get planStartTrial => 'Започни 7-дневна бесплатна проба';

  @override
  String get planChoose => 'Избери';

  @override
  String get plansAction => 'Планови: Pro и Max';

  @override
  String get assistantTitle => 'Асистент';

  @override
  String get assistantGreeting => 'Здраво! Што сакате да направите?';

  @override
  String get assistantNewList => 'Нова листа';

  @override
  String get assistantVoiceList => 'Листа со глас';

  @override
  String get assistantTextList => 'Листа од реченица';

  @override
  String get assistantScanReceipt => 'Скенирај фискална';

  @override
  String get assistantSpending => 'Моите трошоци';

  @override
  String get assistantReceiptHint =>
      'Отворете ја вашата листа и допрете ја иконата за фискална за да скенирате.';

  @override
  String get assistantToggleTitle => 'Прикажи асистент';

  @override
  String get assistantToggleSubtitle => 'Малиот помошник во долниот десен агол';

  @override
  String get scanPriceLabel => 'Скенирај ја цената';

  @override
  String get saveFailed =>
      'Не успеа да се зачува. Вашите промени сè уште се тука. Ве молиме обидете се повторно.';

  @override
  String get deleteItemConfirm =>
      'Да го избришам овој артикл и неговите забележани купувања?';

  @override
  String get clearPurchaseConfirm =>
      'Да го отстранам означувањето на овој артикл и да ги избришам неговите забележани купувања?';

  @override
  String get reportPdfAction => 'Зачувај PDF извештај';

  @override
  String get reportNotInvoice =>
      'Резиме на пазарување, не е даночна фактура. Данските стапки се непознати.';

  @override
  String get purchaseVisits => 'Посети при пазарување';

  @override
  String get purchaseInterval => 'Просечни денови помеѓу купувањата';

  @override
  String get purchasedQuantity => 'Количина купена';

  @override
  String get purchaseAnalyticsHint =>
      'Купувањата не ја мерат потрошувачката. Валутите и единиците се прикажани одделно.';

  @override
  String get receiptReplaces =>
      'Линиите од поврзаното претходно уплатување ги заменуваат постоечките купувања; линиите без поврзување се додаваат.';

  @override
  String get voiceUnsupportedLanguage =>
      'Овој јазик не е достапен за гласовен ввод на ова уред. Можете да пишувате наместо тоа.';

  @override
  String get voiceStopListening => 'Престани со слушање';

  @override
  String get keepAwakeFailed =>
      'Не може да се одржи екранот активен. Обидете се повторно.';

  @override
  String get purchaseHistoryHint =>
      'Сите завршени купувања. Повратите ги намалуваат вкупните суми. Датумите се однесуваат на завршување на купувањето. Една посета не е доволна за пресметка на просечен интервал.';

  @override
  String get planLegacyRights =>
      'Постоечтите Pro и Max претплати ги задржуваат оригиналните месечни AI дозволи. Новите понуди имаат 100 и 300 барања.';

  @override
  String get csvExportAction => 'Извези CSV';
}
