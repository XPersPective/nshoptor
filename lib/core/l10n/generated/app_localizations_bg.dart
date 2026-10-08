// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bulgarian (`bg`).
class AppLocalizationsBg extends AppLocalizations {
  AppLocalizationsBg([String locale = 'bg']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Планирай у дома. Пазарувай по план.';

  @override
  String get listsTitle => 'Списъци';

  @override
  String get listsTabActive => 'Активни';

  @override
  String get listsTabCompleted => 'Завършени';

  @override
  String get listsTabArchived => 'Архивирани';

  @override
  String get newListButton => 'Нов списък';

  @override
  String get listTitleHint => 'Заглавие (по избор)';

  @override
  String get saveButton => 'Запази';

  @override
  String get cancelButton => 'Отказ';

  @override
  String get deleteButton => 'Изтрий';

  @override
  String get editAction => 'Редактирай';

  @override
  String get listDeleted => 'Списъкът е изтрит';

  @override
  String get invalidAmountError => 'Невалидно количество';

  @override
  String get duplicateAction => 'Дублирай';

  @override
  String get archiveAction => 'Архивирай';

  @override
  String get unarchiveAction => 'Разархивирай';

  @override
  String get deleteListConfirm =>
      'Да изтрия ли този списък? Планираните артикули също ще бъдат премахнати.';

  @override
  String get undoButton => 'Отмени';

  @override
  String get searchListHint => 'Търсене на списъци';

  @override
  String get currencyLabel => 'Валута';

  @override
  String get budgetLabel => 'Бюджет (по избор)';

  @override
  String get noteLabel => 'Бележка (по избор)';

  @override
  String get storeLabel => 'Магазин';

  @override
  String get keepAmountsAction => 'Запази количествата';

  @override
  String get resetAmountsAction => 'Нулирай количествата';

  @override
  String get currencyChangeWarning =>
      'Валутата се променя. Какво да стане със съществуващите количества?';

  @override
  String get listsEmpty =>
      'Все още няма списъци. Създай първия си план за пазаруване.';

  @override
  String get statusDraft => 'Чернова';

  @override
  String get statusPlanned => 'Планирано';

  @override
  String get statusShopping => 'Пазаруване';

  @override
  String get statusCompleted => 'Завършено';

  @override
  String get statusArchived => 'Архивирано';

  @override
  String autoListTitle(String date) {
    return 'Пазаруване на $date';
  }

  @override
  String get itemFormTitle => 'Добави артикул';

  @override
  String get itemNameLabel => 'Име на артикула';

  @override
  String get brandLabel => 'Марка / вариант (по избор)';

  @override
  String get categoryLabel => 'Категория';

  @override
  String get quantityLabel => 'Количество';

  @override
  String get unitLabel => 'Мерна единица';

  @override
  String get pricingModeLabel => 'Начин на въвеждане на цена';

  @override
  String get pricingModeUnitPrice => 'Цена на единица';

  @override
  String get pricingModeLineTotal => 'Общо за реда';

  @override
  String get plannedPriceLabel => 'Планирана цена';

  @override
  String lineTotalCalculated(String value) {
    return 'Общо за реда: $value';
  }

  @override
  String get requiredItemToggle => 'Задължителен артикул';

  @override
  String get maxPriceLabel => 'Максимална приемлива цена (по избор)';

  @override
  String get itemNoteLabel => 'Бележка (по избор)';

  @override
  String get categoryProduce => 'Плодове и зеленчуци';

  @override
  String get categoryDairy => 'Млечни продукти';

  @override
  String get categoryMeat => 'Меса';

  @override
  String get categoryBakery => 'Хлебни изделия';

  @override
  String get categoryDrinks => 'Напитки';

  @override
  String get categoryCleaning => 'За почистване';

  @override
  String get categoryPersonalCare => 'Лична хигиена';

  @override
  String get categoryHome => 'За дома';

  @override
  String get categoryOther => 'Други';

  @override
  String get invalidQuantityError => 'Невалидно количество';

  @override
  String get invalidPriceError => 'Невалидна цена';

  @override
  String get invalidNameError => 'Въведи име';

  @override
  String unitPriceCalculated(String value) {
    return 'Единична цена: $value';
  }

  @override
  String get shoppingTitle => 'Режим пазаруване';

  @override
  String get summaryPlannedTotal => 'Планирано';

  @override
  String get summaryInCart => 'В количката';

  @override
  String get summaryRemainingPlan => 'Оставащ план';

  @override
  String get summaryProjected => 'Прогноза за касата';

  @override
  String get summaryBudgetRemaining => 'Остатък от бюджета';

  @override
  String get summaryBudgetOver => 'Над бюджета';

  @override
  String itemsProgress(String done, String total) {
    return '$done от $total артикула';
  }

  @override
  String get filterAll => 'Всички';

  @override
  String get filterToBuy => 'За покупка';

  @override
  String get filterInCart => 'В количката';

  @override
  String get filterNotFound => 'Не са намерени';

  @override
  String get filterRequired => 'Задължителни';

  @override
  String get quickEntryTitle => 'Реална цена';

  @override
  String get actualQuantityLabel => 'Реално количество';

  @override
  String get actualPriceLabel => 'Реална цена';

  @override
  String get discountLabel => 'Отстъпка (по избор)';

  @override
  String get alternativeNameLabel => 'Име на алтернативен продукт (по избор)';

  @override
  String get savePurchaseButton => 'Добави към количката';

  @override
  String get unplannedAddButton => 'Добави непредвиден артикул';

  @override
  String get statusPending => 'Не е взет';

  @override
  String get statusInCart => 'В количката';

  @override
  String get statusNotFound => 'Не е намерен';

  @override
  String get statusGaveUp => 'Отказан';

  @override
  String get statusAlternative => 'Купен алтернативен';

  @override
  String get keepScreenAwake => 'Поддържане на екрана активен';

  @override
  String get finishShopping => 'Завърши пазаруването';

  @override
  String get completionWarning =>
      'Има липсващи или непроверени записи. Можете да завършите; резултатът ще ги отбележи.';

  @override
  String get continueShoppingButton => 'Продължи пазаруването';

  @override
  String get resultTitle => 'Резултат';

  @override
  String get summarySection => 'Обобщение';

  @override
  String get plannedTotalLabel => 'Планирана сума';

  @override
  String get actualTotalLabel => 'Реална сума';

  @override
  String get varianceLabel => 'Разлика';

  @override
  String get varianceNotComputable => 'Не може да се изчисли';

  @override
  String get budgetStatusLabel => 'Бюджет';

  @override
  String get savingsLabel => 'Под плана';

  @override
  String get overspendLabel => 'Над плана';

  @override
  String get unplannedTotalLabel => 'Сума на непредвидените';

  @override
  String get unpurchasedLabel => 'Планирани, но не купени';

  @override
  String get totalDiscountLabel => 'Общо отстъпки';

  @override
  String get accuracyLabel => 'Точност на оценката';

  @override
  String get groupsSection => 'Артикули';

  @override
  String get groupPricier => 'По-скъпи от планираното';

  @override
  String get groupCheaper => 'По-евтини от планираното';

  @override
  String get groupClose => 'Близки до оценката';

  @override
  String get groupNotTaken => 'Планирани, но не купени';

  @override
  String get groupUnplanned => 'Купени без план';

  @override
  String get groupQuantityChanged => 'Променено количество';

  @override
  String get groupUnverified => 'Непроверени';

  @override
  String get plannedQtyLabel => 'Планирано количество';

  @override
  String get actualQtyLabel => 'Реално количество';

  @override
  String get plannedUnitPriceLabel => 'Планирана единична цена';

  @override
  String get actualUnitPriceLabel => 'Реална единична цена';

  @override
  String get lineVarianceLabel => 'Разлика по ред';

  @override
  String get discountEffectLabel => 'Ефект от отстъпката';

  @override
  String get notBoughtMark => 'не е купен';

  @override
  String get noPurchasesNote => 'Няма направени покупки.';

  @override
  String get navHome => 'Начало';

  @override
  String get navLists => 'Списъци';

  @override
  String get navHistory => 'История';

  @override
  String get navSettings => 'Настройки';

  @override
  String get homeEmptyTitle => 'Планирайте пазаруването си';

  @override
  String get homeEmptyBody =>
      'Създайте първия си списък и сравнете планираните с реалните разходи.';

  @override
  String get homeActiveSection => 'Активни списъци';

  @override
  String get homeCompletedSection => 'Завършени наскоро';

  @override
  String get homeMonthlySection => 'Този месец';

  @override
  String get monthPlannedLabel => 'Планирано';

  @override
  String get monthActualLabel => 'Реално';

  @override
  String get monthVarianceLabel => 'Разлика';

  @override
  String get continueShoppingLabel => 'Продължи пазаруването';

  @override
  String get historyEmpty =>
      'Все още няма завършено пазаруване. Вашата история и анализи ще се появят тук.';

  @override
  String get aboutTabTitle => 'За NShoptor';

  @override
  String get aboutBody =>
      'NShoptor от Crazy Penguin. Офлайн-първо приложение за планиране на пазаруване. Лицензирано под GPL-3.0.';

  @override
  String get startShoppingLabel => 'Започни пазаруването';

  @override
  String get finishAndSeeResult => 'Завърши и виж резултата';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get languageLabel => 'Език';

  @override
  String get languageSystem => 'Системен';

  @override
  String get languageTr => 'Турски';

  @override
  String get languageEn => 'Английски';

  @override
  String get themeLabel => 'Тема';

  @override
  String get themeSystem => 'Системен';

  @override
  String get themeLight => 'Светла';

  @override
  String get themeDark => 'Тъмна';

  @override
  String get defaultCurrencyLabel => 'Валута по подразбиране';

  @override
  String get defaultUnitLabel => 'Мерна единица по подразбиране';

  @override
  String get keepAwakeLabel =>
      'Поддържай екрана включен по време на пазаруване';

  @override
  String get backupSection => 'Архивиране';

  @override
  String get exportBackupLabel => 'Експортирай архив';

  @override
  String get importBackupLabel => 'Импортирай архив';

  @override
  String get mergeImportLabel => 'Обедини в текущите данни';

  @override
  String get separateImportLabel => 'Импортирай като отделно копие';

  @override
  String get importCancelled => 'Импортирането е отменено.';

  @override
  String get backupExported => 'Архивът е експортиран успешно.';

  @override
  String get backupSizeWarning =>
      'Голям архив: файлът може да е голям. Искате ли да включите и снимки?';

  @override
  String get deleteAllSection => 'Опасна зона';

  @override
  String get deleteAllLabel => 'Изтрий всички данни';

  @override
  String get deleteAllConfirm =>
      'Това ще премахне всички списъци, история, снимки на касови бележки и цени. Файловете, които сте експортирали, остават във вашето хранилище. Продължавате?';

  @override
  String get deleteAllConfirm2 =>
      'Напълно ли сте сигурни? Това действие не може да бъде отменено.';

  @override
  String get cancelAction => 'Отказ';

  @override
  String get confirmDelete => 'Изтрий трайно';

  @override
  String get dataDeleted => 'Всички локални данни бяха изтрити.';

  @override
  String get privacyInfoLabel => 'Поверителност';

  @override
  String get privacyInfoBody =>
      'Вашите списъци, цени, касови бележки и снимки остават на устройството ви. Снимките и гласът никога не напускат устройството. Когато помощта с AI е активирана, само текст (например редове от касовата бележка или това, което сте продиктували) се изпраща до нашия сървър за обработка и не се съхранява.';

  @override
  String get aboutSection => 'Относно';

  @override
  String get aboutPublisher => 'Издател: Crazy Penguin';

  @override
  String get aboutLicenses => 'Лицензи (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Гласов въвеждане';

  @override
  String get voiceStatusUnknown => 'Услуга: не е проверена';

  @override
  String get permissionsLabel => 'Разрешения';

  @override
  String get permissionsBody =>
      'Камера, микрофон и известия се искат само когато действително използвате тези функции.';

  @override
  String get unitsSection => 'По подразбиране';

  @override
  String get roundingNote =>
      'Закръглянето на парите следва едно правило: половинките се закръглят към нулата, прилага се веднъж при конвертиране на пари.';

  @override
  String get voiceInputTitle => 'Гласов въвеждане';

  @override
  String get voiceStartListening => 'Започни слушането';

  @override
  String get voiceTranscriptLabel => 'Транскрипт';

  @override
  String get parseAction => 'Разпознай';

  @override
  String get receiptReviewTitle => 'Преглед на касова бележка';

  @override
  String get receiptTotal => 'Общо по касов бонус';

  @override
  String get receiptTotalUnknown => 'Не е открито общо';

  @override
  String get receiptDiff => 'Разлика';

  @override
  String get acceptLine => 'Приеми ред';

  @override
  String get ignoreLine => 'Игнорирай ред';

  @override
  String get receiptLineActions => 'Връзка с продукт, разделяне или игнориране';

  @override
  String get receiptCommit => 'Приеми всички';

  @override
  String get receiptCommitted => 'Касовият бонус е приложен.';

  @override
  String get priceHistoryTitle => 'История на цените';

  @override
  String get noObservations => 'Все още няма наблюдения за цени';

  @override
  String get templatesSection => 'Шаблони';

  @override
  String get templateHint => 'Създай нов списък от предишна покупка';

  @override
  String get scanReceiptAction => 'Сканирай касов бонус';

  @override
  String get shelfLabelAction => 'Цена от етикет на рафта';

  @override
  String get priceCandidatesTitle => 'Кандидати за цена';

  @override
  String get noPriceCandidates => 'Няма намерена цена; въведете я ръчно.';

  @override
  String get voiceUnavailable =>
      'Гласовото разпознаване не е налично; въведете ръчно.';

  @override
  String get linkToItem => 'Връзка с продукт';

  @override
  String get splitLine => 'Раздели на два';

  @override
  String get mergeWithNext => 'Обедини със следващия';

  @override
  String get ocrNoText => 'Няма разпознат текст; опитайте отново.';

  @override
  String get priceHistoryAction => 'История на цените';

  @override
  String get itemsEmptyTitle => 'Все още няма продукти';

  @override
  String get itemsEmptyBody =>
      'Добавете първия си продукт — тук ще въвеждате реалните цени в магазина.';

  @override
  String get addItemTooltip => 'Добави продукт';

  @override
  String get unitAdet => 'бр.';

  @override
  String get unitKilogram => 'кг';

  @override
  String get unitGram => 'г';

  @override
  String get unitLitre => 'л';

  @override
  String get unitMililitre => 'мл';

  @override
  String get unitPaket => 'уп.';

  @override
  String get unitKutu => 'кутия';

  @override
  String get unitSise => 'бутилka';

  @override
  String get unitKavanoz => ' буркан';

  @override
  String get unitDemet => 'сноп';

  @override
  String get unitDuzine => 'дюзина';

  @override
  String get unitMetre => 'м';

  @override
  String get unitCustom => 'По избор';

  @override
  String get setReminderAction => 'Задай напомняне';

  @override
  String get reminderPermissionDenied =>
      'Изисква се разрешение за известия за напомнянията. Можете да го активирате в системните настройки.';

  @override
  String get reminderScheduled => 'Напомнянето е зададено.';

  @override
  String get reminderCancelled => 'Напомнянето е премахнато.';

  @override
  String get reminderTitle => 'Напомняне за пазаруване';

  @override
  String reminderBody(Object title) {
    return 'Време е да проверите списъка си: $title';
  }

  @override
  String get reminderPickDate => 'Избери дата';

  @override
  String get reminderPickTime => 'Избери час';

  @override
  String get itemDetailsSection => 'Подробности';

  @override
  String get priceOptionalHint =>
      'По желание — реалната цена ще въведете в магазина';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Планирано: $total · $count продукта';
  }

  @override
  String get proActiveLabel => 'Pro активен — благодаря!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Без реклами, повече AI, архив · от малка месечна цена';

  @override
  String get proBenefitNoAds => 'Опит без реклами';

  @override
  String get proBenefitBackup => 'Архив (експорт/импорт)';

  @override
  String aboutVersion(Object version) {
    return 'Версия $version';
  }

  @override
  String get navDiscover => 'Откриване';

  @override
  String get shareAction => 'Сподели приложението';

  @override
  String get rateAction => 'Оцени ни';

  @override
  String get aboutOpenRow => 'Относно и отворен код';

  @override
  String get voiceAddItemAction => 'Добави с глас';

  @override
  String get formatLocaleLabel => 'Формат за числа и валута';

  @override
  String get formatLocaleSystem => 'Система (спазва езика на приложението)';

  @override
  String get formatLocaleTr => 'Турски (1.234,56)';

  @override
  String get formatLocaleEn => 'Английски (1,234.56)';

  @override
  String get aiToggleTitle => 'AI помощ';

  @override
  String get aiToggleSubtitle =>
      'Съпоставя касови бележки, разчита етикети с цени и превръща изречения в списъци. Снимки и глас остават на устройството ви; обработва се само текст.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Използвали сте месечния лимит AI заявки ($used/$limit). Надградете за повече или продължете без AI.';
  }

  @override
  String get aiOffline => 'Няма връзка — продължаваме без AI.';

  @override
  String get aiFailed => 'AI не е наличен в момента — продължаваме без него.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'Устройство';

  @override
  String get quickListAction => 'Добави от изречение';

  @override
  String get quickListTitle => 'Бърз списък';

  @override
  String get quickListHint =>
      'напр. 1 кг ябълки 20, 2 хляба, половин кило сирене';

  @override
  String get quickListConvert => 'Преобразувай в списък';

  @override
  String quickListAdd(int count) {
    return 'Добави $count артикула';
  }

  @override
  String get quickListEmpty =>
      'Не са намерени артикули. Опитайте да ги изброите, разделени със запетая.';

  @override
  String get receiptAiMatched =>
      'AI съпостави касовата бележка със списъка ви. Проверете връзките и потвърдете.';

  @override
  String get receiptNeedsCheck => 'Проверете това съответствие';

  @override
  String get receiptDiscountLine => 'Отстъпка';

  @override
  String get compareItem => 'Артикул';

  @override
  String get compareEstimated => 'Очаквана';

  @override
  String get compareActual => 'Реална';

  @override
  String get compareDiff => 'Разлика';

  @override
  String get compareTotal => 'Общо';

  @override
  String get compareBudget => 'Бюджет';

  @override
  String get compareNotBought => 'не е купено';

  @override
  String get compareUnplanned => 'не е планирано';

  @override
  String get pricierItems => 'По-скъпи';

  @override
  String get cheaperItems => 'По-евтини';

  @override
  String get compareAction => 'Сравняване';

  @override
  String get detailsSection => 'Подробности';

  @override
  String get spendingTitle => 'Разходи';

  @override
  String get spendingAction => 'Разходи';

  @override
  String get spendingMonthTotal => 'Този месец';

  @override
  String get spendingWeekly => 'Седмични разходи';

  @override
  String get spendingMonthly => 'Месечни разходи';

  @override
  String get monthlyLimitTitle => 'Месечен лимит';

  @override
  String get monthlyLimitHelp =>
      'Колко искате да похарчите за пазаруване на месец?';

  @override
  String get monthlyLimitRemove => 'Премахни';

  @override
  String get monthlyLimitSet => 'Задай';

  @override
  String get monthlyLimitChange => 'Промени';

  @override
  String get monthlyLimitNone =>
      'Задайте месечен лимит, за да видите колко ви остава.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount над лимита';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return '$amount остават този месец';
  }

  @override
  String get plansTitle => 'Планове';

  @override
  String get plansHeadline => 'Пазарувайте по-умно с AI';

  @override
  String get plansSubhead =>
      'Съпоставяне на касови бележки, етикети с цени и списъци от изречение. Отказвайте по всяко време.';

  @override
  String get plansMonthly => 'Месечно';

  @override
  String get plansYearly => 'Годишно';

  @override
  String get planFree => 'Безплатен';

  @override
  String get planFreePrice => 'Винаги безплатно';

  @override
  String get planFreeAi => '15 AI заявки на месец';

  @override
  String get planFreeAds => 'Малки банерни реклами (няма през първите 7 дни)';

  @override
  String get planCoreFeatures =>
      'Списъци, цени, касови бележки, графики на разходите';

  @override
  String get plansPerYear => '/ година';

  @override
  String get plansPerMonth => '/ месец';

  @override
  String get planTrial => '7 дни безплатно';

  @override
  String get planProAi => '200 AI заявки на месец';

  @override
  String get planNoAds => 'Без реклами';

  @override
  String get planBackup => 'Архивиране на експорт и импорт';

  @override
  String get planMaxAi => '1000 AI заявки месечно';

  @override
  String get planMaxFamily => 'За големи семейни пазарувания';

  @override
  String get plansStoreUnavailable => 'Магазинът в момента не е достъпен.';

  @override
  String get retryAction => 'Опитай отново';

  @override
  String get plansPurchaseFailed =>
      'Покупката не беше успешна. Моля, опитайте отново.';

  @override
  String get planLifetimeTitle => 'Без реклами за цял живот';

  @override
  String get planLifetimeSubtitle =>
      'Еднократно плащане: без реклами, архивиране; AI остава в рамките на безплатния лимит';

  @override
  String get plansRestore => 'Възстановяване на покупки';

  @override
  String get plansLegal =>
      'Абонаментите се обновяват автоматично, докато не бъдат отменени. Можете да отмените по всяко време в Google Play › Плащания и абонаменти. Цените включват данъците, показани от Google Play.';

  @override
  String get planCurrent => 'Текущ';

  @override
  String get planStartTrial => 'Започнете 7-дневен безплатен пробен период';

  @override
  String get planChoose => 'Избери';

  @override
  String get plansAction => 'Планове: Pro и Max';

  @override
  String get assistantTitle => 'Асистент';

  @override
  String get assistantGreeting => 'Здравей! Какво бихте искали да направите?';

  @override
  String get assistantNewList => 'Нова листа';

  @override
  String get assistantVoiceList => 'Листа с глас';

  @override
  String get assistantTextList => 'Листа от изречение';

  @override
  String get assistantScanReceipt => 'Сканиране на касова бележка';

  @override
  String get assistantSpending => 'Моите разходи';

  @override
  String get assistantReceiptHint =>
      'Отворете вашата листа и натиснете иконата за касова бележка, за да я сканирате.';

  @override
  String get assistantToggleTitle => 'Показване на асистента';

  @override
  String get assistantToggleSubtitle => 'Малкият помощник в долния десен ъгъл';
}
