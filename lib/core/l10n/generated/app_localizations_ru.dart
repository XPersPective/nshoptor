// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Посчитано дома — сходится на кассе.';

  @override
  String get listsTitle => 'Списки';

  @override
  String get listsTabActive => 'Активные';

  @override
  String get listsTabCompleted => 'Завершённые';

  @override
  String get listsTabArchived => 'Архив';

  @override
  String get newListButton => 'Новый список';

  @override
  String get listTitleHint => 'Название (необязательно)';

  @override
  String get saveButton => 'Сохранить';

  @override
  String get cancelButton => 'Отмена';

  @override
  String get deleteButton => 'Удалить';

  @override
  String get editAction => 'Изменить';

  @override
  String get listDeleted => 'Список удалён';

  @override
  String get invalidAmountError => 'Неверная сумма';

  @override
  String get duplicateAction => 'Дублировать';

  @override
  String get archiveAction => 'В архив';

  @override
  String get unarchiveAction => 'Из архива';

  @override
  String get deleteListConfirm =>
      'Удалить этот список? Запланированные товары тоже будут удалены.';

  @override
  String get undoButton => 'Отменить';

  @override
  String get searchListHint => 'Поиск по спискам';

  @override
  String get currencyLabel => 'Валюта';

  @override
  String get budgetLabel => 'Бюджет (необязательно)';

  @override
  String get noteLabel => 'Заметка (необязательно)';

  @override
  String get storeLabel => 'Магазин';

  @override
  String get keepAmountsAction => 'Оставить суммы';

  @override
  String get resetAmountsAction => 'Сбросить суммы';

  @override
  String get currencyChangeWarning =>
      'Валюта меняется. Что сделать с текущими суммами?';

  @override
  String get listsEmpty =>
      'Списков пока нет. Создайте свой первый план покупок.';

  @override
  String get statusDraft => 'Черновик';

  @override
  String get statusPlanned => 'Запланирован';

  @override
  String get statusShopping => 'Идут покупки';

  @override
  String get statusCompleted => 'Завершён';

  @override
  String get statusArchived => 'В архиве';

  @override
  String autoListTitle(String date) {
    return 'Покупки $date';
  }

  @override
  String get itemFormTitle => 'Добавить товар';

  @override
  String get itemNameLabel => 'Название товара';

  @override
  String get brandLabel => 'Марка / вариант (необязательно)';

  @override
  String get categoryLabel => 'Категория';

  @override
  String get quantityLabel => 'Количество';

  @override
  String get unitLabel => 'Единица';

  @override
  String get pricingModeLabel => 'Ввод цены';

  @override
  String get pricingModeUnitPrice => 'Цена за единицу';

  @override
  String get pricingModeLineTotal => 'Итоговая цена';

  @override
  String get plannedPriceLabel => 'Плановая цена';

  @override
  String lineTotalCalculated(String value) {
    return 'Итого: $value';
  }

  @override
  String get requiredItemToggle => 'Обязательный товар';

  @override
  String get maxPriceLabel => 'Максимально допустимая цена (необязательно)';

  @override
  String get itemNoteLabel => 'Заметка (необязательно)';

  @override
  String get categoryProduce => 'Фрукты и овощи';

  @override
  String get categoryDairy => 'Молочные продукты';

  @override
  String get categoryMeat => 'Мясо';

  @override
  String get categoryBakery => 'Выпечка';

  @override
  String get categoryDrinks => 'Напитки';

  @override
  String get categoryCleaning => 'Бытовая химия';

  @override
  String get categoryPersonalCare => 'Личная гигиена';

  @override
  String get categoryHome => 'Для дома';

  @override
  String get categoryOther => 'Другое';

  @override
  String get invalidQuantityError => 'Неверное количество';

  @override
  String get invalidPriceError => 'Неверная цена';

  @override
  String get invalidNameError => 'Введите название';

  @override
  String unitPriceCalculated(String value) {
    return 'Цена за единицу: $value';
  }

  @override
  String get shoppingTitle => 'Режим покупок';

  @override
  String get summaryPlannedTotal => 'План';

  @override
  String get summaryInCart => 'В корзине';

  @override
  String get summaryRemainingPlan => 'Осталось по плану';

  @override
  String get summaryProjected => 'Ожидаемый чек';

  @override
  String get summaryBudgetRemaining => 'Остаток бюджета';

  @override
  String get summaryBudgetOver => 'Бюджет превышен';

  @override
  String itemsProgress(String done, String total) {
    return '$done из $total товаров';
  }

  @override
  String get filterAll => 'Все';

  @override
  String get filterToBuy => 'Купить';

  @override
  String get filterInCart => 'В корзине';

  @override
  String get filterNotFound => 'Не найдено';

  @override
  String get filterRequired => 'Обязательные';

  @override
  String get quickEntryTitle => 'Фактическая цена';

  @override
  String get actualQuantityLabel => 'Фактическое количество';

  @override
  String get actualPriceLabel => 'Фактическая цена';

  @override
  String get discountLabel => 'Скидка (необязательно)';

  @override
  String get alternativeNameLabel => 'Название замены (необязательно)';

  @override
  String get savePurchaseButton => 'В корзину';

  @override
  String get unplannedAddButton => 'Добавить незапланированный товар';

  @override
  String get statusPending => 'Не взят';

  @override
  String get statusInCart => 'В корзине';

  @override
  String get statusNotFound => 'Не найден';

  @override
  String get statusGaveUp => 'Отказались';

  @override
  String get statusAlternative => 'Куплена замена';

  @override
  String get keepScreenAwake => 'Не выключать экран';

  @override
  String get finishShopping => 'Завершить покупки';

  @override
  String get completionWarning =>
      'Есть пропущенные или непроверенные записи. Можно всё равно завершить — в результате это будет отмечено.';

  @override
  String get continueShoppingButton => 'Продолжить покупки';

  @override
  String get resultTitle => 'Итог';

  @override
  String get summarySection => 'Сводка';

  @override
  String get plannedTotalLabel => 'Итого по плану';

  @override
  String get actualTotalLabel => 'Итого фактически';

  @override
  String get varianceLabel => 'Разница';

  @override
  String get varianceNotComputable => 'Нельзя рассчитать';

  @override
  String get budgetStatusLabel => 'Бюджет';

  @override
  String get savingsLabel => 'Ниже плана';

  @override
  String get overspendLabel => 'Выше плана';

  @override
  String get unplannedTotalLabel => 'Незапланированные траты';

  @override
  String get unpurchasedLabel => 'Запланировано, но не куплено';

  @override
  String get totalDiscountLabel => 'Скидки всего';

  @override
  String get accuracyLabel => 'Точность оценки';

  @override
  String get groupsSection => 'Товары';

  @override
  String get groupPricier => 'Дороже плана';

  @override
  String get groupCheaper => 'Дешевле плана';

  @override
  String get groupClose => 'Близко к оценке';

  @override
  String get groupNotTaken => 'Запланировано, не куплено';

  @override
  String get groupUnplanned => 'Куплено без плана';

  @override
  String get groupQuantityChanged => 'Изменилось количество';

  @override
  String get groupUnverified => 'Не проверено';

  @override
  String get plannedQtyLabel => 'Плановое количество';

  @override
  String get actualQtyLabel => 'Фактическое количество';

  @override
  String get plannedUnitPriceLabel => 'Плановая цена за единицу';

  @override
  String get actualUnitPriceLabel => 'Фактическая цена за единицу';

  @override
  String get lineVarianceLabel => 'Разница';

  @override
  String get discountEffectLabel => 'Эффект скидки';

  @override
  String get notBoughtMark => 'не куплено';

  @override
  String get noPurchasesNote => 'Покупки не записаны.';

  @override
  String get navHome => 'Главная';

  @override
  String get navLists => 'Списки';

  @override
  String get navHistory => 'История';

  @override
  String get navSettings => 'Настройки';

  @override
  String get homeEmptyTitle => 'Спланируйте покупки';

  @override
  String get homeEmptyBody =>
      'Создайте первый список и сравните план с реальными тратами.';

  @override
  String get homeActiveSection => 'Активные списки';

  @override
  String get homeCompletedSection => 'Недавно завершённые';

  @override
  String get homeMonthlySection => 'Этот месяц';

  @override
  String get monthPlannedLabel => 'План';

  @override
  String get monthActualLabel => 'Факт';

  @override
  String get monthVarianceLabel => 'Разница';

  @override
  String get continueShoppingLabel => 'Продолжить покупки';

  @override
  String get historyEmpty =>
      'Завершённых покупок пока нет. Здесь появятся история и аналитика.';

  @override
  String get aboutTabTitle => 'О NShoptor';

  @override
  String get aboutBody =>
      'NShoptor от Crazy Penguin. Планировщик покупок, работающий офлайн. Лицензия GPL-3.0.';

  @override
  String get startShoppingLabel => 'Начать покупки';

  @override
  String get finishAndSeeResult => 'Завершить и посмотреть итог';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get languageLabel => 'Язык';

  @override
  String get languageSystem => 'Системный';

  @override
  String get languageTr => 'Турецкий';

  @override
  String get languageEn => 'Английский';

  @override
  String get themeLabel => 'Тема';

  @override
  String get themeSystem => 'Системная';

  @override
  String get themeLight => 'Светлая';

  @override
  String get themeDark => 'Тёмная';

  @override
  String get defaultCurrencyLabel => 'Валюта по умолчанию';

  @override
  String get defaultUnitLabel => 'Единица по умолчанию';

  @override
  String get keepAwakeLabel => 'Не выключать экран во время покупок';

  @override
  String get backupSection => 'Резервная копия';

  @override
  String get exportBackupLabel => 'Экспорт копии';

  @override
  String get importBackupLabel => 'Импорт копии';

  @override
  String get mergeImportLabel => 'Объединить с текущими данными';

  @override
  String get separateImportLabel => 'Импортировать отдельной копией';

  @override
  String get importCancelled => 'Импорт отменён.';

  @override
  String get backupExported => 'Копия успешно экспортирована.';

  @override
  String get deleteAllSection => 'Опасная зона';

  @override
  String get deleteAllLabel => 'Удалить все данные';

  @override
  String get deleteAllConfirm =>
      'Будут удалены все списки, история, фото чеков и цены. Экспортированные вами файлы останутся. Продолжить?';

  @override
  String get deleteAllConfirm2 =>
      'Вы точно уверены? Это действие нельзя отменить.';

  @override
  String get cancelAction => 'Отмена';

  @override
  String get confirmDelete => 'Удалить навсегда';

  @override
  String get dataDeleted => 'Все локальные данные удалены.';

  @override
  String get privacyInfoLabel => 'Конфиденциальность';

  @override
  String get privacyInfoBody =>
      'Ваши списки, цены, чеки и фото хранятся на устройстве. Голос его никогда не покидает. Когда помощь ИИ включена, фото чеков и ценников (уменьшенные) и текст, например надиктованные товары, отправляются на наш сервер только для считывания; они обрабатываются сразу и никогда не сохраняются.';

  @override
  String get aboutSection => 'О приложении';

  @override
  String get aboutPublisher => 'Издатель: Crazy Penguin';

  @override
  String get aboutLicenses => 'Лицензии (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Голосовой ввод';

  @override
  String get voiceStatusUnknown => 'Сервис: не проверен';

  @override
  String get permissionsLabel => 'Разрешения';

  @override
  String get permissionsBody =>
      'Камера, микрофон и уведомления запрашиваются только когда вы пользуетесь этими функциями.';

  @override
  String get unitsSection => 'По умолчанию';

  @override
  String get roundingNote =>
      'Суммы округляются по одному правилу: половины — от нуля, один раз при пересчёте.';

  @override
  String get voiceInputTitle => 'Голосовой ввод';

  @override
  String get voiceStartListening => 'Начать слушать';

  @override
  String get voiceTranscriptLabel => 'Расшифровка';

  @override
  String get parseAction => 'Разобрать';

  @override
  String get receiptReviewTitle => 'Проверка чека';

  @override
  String get receiptTotal => 'Сумма чека';

  @override
  String get receiptTotalUnknown => 'Сумма не распознана';

  @override
  String get receiptDiff => 'Разница';

  @override
  String get acceptLine => 'Принять строку';

  @override
  String get ignoreLine => 'Пропустить строку';

  @override
  String get receiptLineActions =>
      'Связать с товаром, разделить или пропустить';

  @override
  String get receiptCommit => 'Принять всё';

  @override
  String get receiptCommitted => 'Чек применён.';

  @override
  String get priceHistoryTitle => 'История цен';

  @override
  String get noObservations => 'Цен пока нет';

  @override
  String get templatesSection => 'Шаблоны';

  @override
  String get templateHint => 'Создать новый план на основе прошлой покупки';

  @override
  String get scanReceiptAction => 'Сканировать чек';

  @override
  String get fromReceiptListButton => 'Из чека';

  @override
  String get shelfLabelAction => 'Цена с ценника';

  @override
  String get priceCandidatesTitle => 'Варианты цены';

  @override
  String get noPriceCandidates => 'Цена не найдена; введите её вручную.';

  @override
  String get voiceUnavailable =>
      'Распознавание речи недоступно; введите вручную.';

  @override
  String get linkToItem => 'Связать с товаром';

  @override
  String get splitLine => 'Разделить на две';

  @override
  String get mergeWithNext => 'Объединить со следующей';

  @override
  String get ocrNoText => 'Текст не распознан; попробуйте ещё раз.';

  @override
  String get priceHistoryAction => 'История цен';

  @override
  String get itemsEmptyTitle => 'Товаров пока нет';

  @override
  String get itemsEmptyBody =>
      'Добавьте первый товар — в магазине вы будете вносить сюда реальные цены.';

  @override
  String get addItemTooltip => 'Добавить товар';

  @override
  String get unitAdet => 'шт';

  @override
  String get unitKilogram => 'кг';

  @override
  String get unitGram => 'г';

  @override
  String get unitLitre => 'л';

  @override
  String get unitMililitre => 'мл';

  @override
  String get unitPaket => 'уп';

  @override
  String get unitKutu => 'коробка';

  @override
  String get unitSise => 'бутылка';

  @override
  String get unitKavanoz => 'банка';

  @override
  String get unitDemet => 'пучок';

  @override
  String get unitDuzine => 'дюжина';

  @override
  String get unitMetre => 'м';

  @override
  String get unitCustom => 'Своя';

  @override
  String get setReminderAction => 'Напоминание';

  @override
  String get reminderPermissionDenied =>
      'Для напоминаний нужно разрешение на уведомления. Его можно включить в настройках системы.';

  @override
  String get reminderScheduled => 'Напоминание установлено.';

  @override
  String get reminderCancelled => 'Напоминание удалено.';

  @override
  String get reminderTitle => 'Напоминание о покупках';

  @override
  String reminderBody(Object title) {
    return 'Пора проверить список: $title';
  }

  @override
  String get reminderPickDate => 'Выберите дату';

  @override
  String get reminderPickTime => 'Выберите время';

  @override
  String get itemDetailsSection => 'Подробнее';

  @override
  String get priceOptionalHint => 'Цена в магазине (необязательно)';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'План: $total · $count товаров';
  }

  @override
  String get proActiveLabel => 'Pro активен — спасибо!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine => 'Без рекламы · Экспорт и импорт копии · Год';

  @override
  String get proBenefitNoAds => 'Без рекламы';

  @override
  String get proBenefitBackup => 'Резервная копия (экспорт/импорт)';

  @override
  String aboutVersion(Object version) {
    return 'Версия $version';
  }

  @override
  String get navDiscover => 'Ещё';

  @override
  String get shareAction => 'Поделиться приложением';

  @override
  String get rateAction => 'Оценить';

  @override
  String get aboutOpenRow => 'О приложении и открытый код';

  @override
  String get voiceAddItemAction => 'Добавить голосом';

  @override
  String get formatLocaleLabel => 'Формат чисел и валюты';

  @override
  String get formatLocaleSystem => 'Формат устройства';

  @override
  String get formatLocaleTr => 'Турецкий (1.234,56)';

  @override
  String get formatLocaleEn => 'Английский (1,234.56)';

  @override
  String get aiToggleTitle => 'Помощь ИИ';

  @override
  String get aiToggleSubtitle =>
      'Считывает чеки и ценники с фото, сопоставляет чеки и превращает предложения в списки. Фото отправляются только для считывания и никогда не сохраняются.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Запросы к ИИ на этот месяц исчерпаны ($used/$limit). Перейдите на другой план или продолжайте без ИИ.';
  }

  @override
  String get aiOffline => 'Нет подключения — продолжаем без ИИ.';

  @override
  String get aiFailed => 'ИИ сейчас недоступен — продолжаем без него.';

  @override
  String get aiSourceLabel => 'ИИ';

  @override
  String get deviceSourceLabel => 'Устройство';

  @override
  String get quickListAction => 'Добавить из фразы';

  @override
  String get quickListTitle => 'Быстрый список';

  @override
  String get quickListHint => 'напр.: 1 кг яблок 150, 2 батона, полкило сыра';

  @override
  String get quickListConvert => 'Превратить в список';

  @override
  String quickListAdd(int count) {
    return 'Добавить товаров: $count';
  }

  @override
  String get quickListEmpty =>
      'Товары не найдены. Перечислите их через запятую.';

  @override
  String get receiptAiMatched =>
      'ИИ сопоставил чек с вашим списком. Проверьте связи и подтвердите.';

  @override
  String get receiptNeedsCheck => 'Проверьте это сопоставление';

  @override
  String get receiptDiscountLine => 'Скидка';

  @override
  String get compareItem => 'Товар';

  @override
  String get compareEstimated => 'Домашняя цена';

  @override
  String get compareActual => 'Цена в магазине';

  @override
  String get compareDiff => 'Разница';

  @override
  String get compareTotal => 'Итого';

  @override
  String get compareBudget => 'Бюджет';

  @override
  String get compareNotBought => 'не куплено';

  @override
  String get compareUnplanned => 'вне плана';

  @override
  String get pricierItems => 'Дороже';

  @override
  String get cheaperItems => 'Дешевле';

  @override
  String get compareAction => 'Сравнить';

  @override
  String get detailsSection => 'Подробнее';

  @override
  String get spendingTitle => 'Расходы';

  @override
  String get spendingAction => 'Расходы';

  @override
  String get spendingMonthTotal => 'Этот месяц';

  @override
  String get spendingWeekly => 'Расходы по неделям';

  @override
  String get spendingMonthly => 'Расходы по месяцам';

  @override
  String get monthlyLimitTitle => 'Месячный лимит';

  @override
  String get monthlyLimitHelp =>
      'Сколько вы хотите тратить на покупки в месяц?';

  @override
  String get monthlyLimitRemove => 'Убрать';

  @override
  String get monthlyLimitSet => 'Задать';

  @override
  String get monthlyLimitChange => 'Изменить';

  @override
  String get monthlyLimitNone =>
      'Задайте месячный лимит, чтобы видеть, сколько осталось.';

  @override
  String monthlyLimitOver(String amount) {
    return 'Лимит превышен на $amount';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return 'В этом месяце осталось $amount';
  }

  @override
  String get plansTitle => 'Тарифы';

  @override
  String get plansHeadline => 'Покупайте умнее с ИИ';

  @override
  String get plansSubhead =>
      'Сопоставление чеков, ценники и списки из фразы. Отменить можно в любой момент.';

  @override
  String get plansMonthly => 'Месяц';

  @override
  String get plansYearly => 'Год';

  @override
  String get planFree => 'Бесплатно';

  @override
  String get planFreePrice => 'Бесплатно навсегда';

  @override
  String get planFreeAi => '10 запросов к ИИ в месяц';

  @override
  String get planFreeAds => 'Небольшие баннеры (первые 7 дней без рекламы)';

  @override
  String get planCoreFeatures => 'Списки, цены, чеки, графики расходов';

  @override
  String get plansPerYear => '/ год';

  @override
  String get plansPerMonth => '/ мес.';

  @override
  String get planTrial => 'Бесплатный пробный период';

  @override
  String get planProAi => '100 запросов к ИИ в месяц';

  @override
  String get planNoAds => 'Без рекламы';

  @override
  String get planBackup => 'Экспорт и импорт копии';

  @override
  String get planMaxAi => '300 запросов к ИИ в месяц';

  @override
  String get planMaxFamily => 'Для больших семейных покупок';

  @override
  String get plansStoreUnavailable => 'Магазин сейчас недоступен.';

  @override
  String get retryAction => 'Повторить';

  @override
  String get plansPurchaseFailed => 'Покупка не прошла. Попробуйте ещё раз.';

  @override
  String get plansRestore => 'Восстановить покупки';

  @override
  String get plansLegal =>
      'Pro автоматически продлевается каждый год до отмены и включает 100 запросов к ИИ в месяц. Базовая цена — 1 доллар США в год без применимых налогов; перед подтверждением покупки проверьте окончательную местную цену и налоги в магазине. Управляйте подпиской или отмените её в Google Play.';

  @override
  String get planCurrent => 'Текущий';

  @override
  String get planStartTrial => 'Начать бесплатный пробный период';

  @override
  String get planChoose => 'Выбрать';

  @override
  String get plansAction => 'Тарифы: Pro';

  @override
  String get assistantTitle => 'Помощник';

  @override
  String get assistantGreeting => 'Привет! Что вы хотите сделать?';

  @override
  String get assistantNewList => 'Новый список';

  @override
  String get assistantVoiceList => 'Список голосом';

  @override
  String get assistantTextList => 'Список из фразы';

  @override
  String get assistantScanReceipt => 'Сканировать чек';

  @override
  String get assistantSpending => 'Мои расходы';

  @override
  String get assistantReceiptHint =>
      'Откройте список и нажмите на значок чека, чтобы отсканировать его.';

  @override
  String get assistantToggleTitle => 'Показывать помощника';

  @override
  String get assistantToggleSubtitle =>
      'Маленький помощник в правом нижнем углу';

  @override
  String get scanPriceLabel => 'Сканировать ценник';

  @override
  String get saveFailed =>
      'Не удалось сохранить. Ваши изменения остались. Попробуйте ещё раз.';

  @override
  String get deleteItemConfirm => 'Удалить этот товар и его записи о покупках?';

  @override
  String get clearPurchaseConfirm =>
      'Снять отметку с этого товара и удалить его записи о покупках?';

  @override
  String get reportPdfAction => 'Сохранить PDF-отчёт';

  @override
  String get reportNotInvoice =>
      'Итоги покупок, не налоговый счёт. Ставки налогов неизвестны.';

  @override
  String get purchaseVisits => 'Походы за покупками';

  @override
  String get purchaseInterval => 'Среднее число дней между покупками';

  @override
  String get purchasedQuantity => 'Купленное количество';

  @override
  String get purchaseAnalyticsHint =>
      'Покупки не измеряют потребление. Валюты и единицы показаны отдельно.';

  @override
  String get receiptReplaces =>
      'Цены товаров без цены будут заполнены. Товары с рыночной ценой добавляются как отдельные покупки.';

  @override
  String get receiptIncompleteHeader =>
      'Укажите магазин, дату, время и номер чека на следующем фото.';

  @override
  String get receiptIncompleteTail =>
      'Сфотографируйте следующую часть так, чтобы несколько товаров перекрывались и была видна итоговая сумма.';

  @override
  String get receiptContinuationRejected =>
      'Не удалось объединить это фото. Переснимите его с перекрывающимися товарами из того же чека.';

  @override
  String get receiptDraftSaved =>
      'Чек сохранён как черновик. Вы можете продолжить позже.';

  @override
  String get receiptContinueAction => 'Продолжить чек';

  @override
  String get receiptDraftsTitle => 'Незавершённые чеки';

  @override
  String get receiptDuplicate => 'Этот чек уже добавлен.';

  @override
  String get receiptTotalMismatch =>
      'Сумма товаров не совпадает с итогом чека. Проверьте, что чек виден целиком.';

  @override
  String get receiptSaveDraftAction => 'Сохранить на потом';

  @override
  String get receiptResolveLines =>
      'Перед сохранением примите или проигнорируйте каждый товар.';

  @override
  String get receiptPartialConfirm =>
      'Будут добавлены только выбранные товары. Этот чек будет отмечен как импортированный. Продолжить?';

  @override
  String get voiceUnsupportedLanguage =>
      'Этот язык недоступен для голосового ввода на этом устройстве. Можно ввести текст.';

  @override
  String get voiceStopListening => 'Прекратить прослушивание';

  @override
  String get keepAwakeFailed =>
      'Не удалось удерживать экран включённым. Попробуйте ещё раз.';

  @override
  String get purchaseHistoryHint =>
      'Все завершённые покупки. Возвраты уменьшают итоговую сумму. Даты указывают на завершение покупок. Одного визита недостаточно для расчёта среднего интервала.';

  @override
  String get planLegacyRights =>
      'Действующие подписки Pro и Max сохраняют свой исходный ежемесячный лимит запросов к ИИ.';

  @override
  String get csvExportAction => 'Экспорт CSV';

  @override
  String get reportSharePdf => 'Поделиться в PDF';

  @override
  String get reportShareCsv => 'Поделиться в CSV';

  @override
  String get reportPrintAction => 'Печать';

  @override
  String get backupSizeWarning =>
      'JSON содержит записи, а не файлы фотографий. Лимит импорта: 16 МБ.';

  @override
  String get backupImportFailed =>
      'Не удалось импортировать эту резервную копию. Ваши данные не были изменены.';

  @override
  String get backupImported => 'Резервная копия успешно импортирована.';

  @override
  String backupPreviewCounts(Object entries, Object items, Object lists) {
    return '$lists списков · $items товаров · $entries покупок';
  }

  @override
  String get voiceModelDownloading =>
      'Загружается голосовая модель для этого языка. Повторите попытку через минуту.';

  @override
  String get historyThisWeek => 'Эта неделя';

  @override
  String get historyProductsSection => 'Купленные товары';

  @override
  String get tipReceiptScan =>
      'Отсканируйте чек, чтобы сопоставить цены со списком';

  @override
  String get tipVoiceAdd =>
      'Назовите один или несколько товаров и проверьте их перед добавлением';

  @override
  String get tipShelfCamera => 'Считайте цену с ценника на полке камерой';

  @override
  String get tipPlan =>
      'Ваш тариф: смотреть подробности, оформить подписку или перейти на другой';

  @override
  String get guideAddBody =>
      'Нажмите +, чтобы добавить товар. Введите плановую цену сейчас, а рыночную — на кассе.';

  @override
  String get guideVoiceBody =>
      'Нажмите микрофон и назовите товары, например: «1 кг яблок, батон».';

  @override
  String get guideReceiptBody =>
      'Отсканируйте чек, чтобы сопоставить его цены с товарами в списке.';

  @override
  String get guidePlanBody =>
      'Нажмите значок тарифа, чтобы посмотреть тариф, оформить подписку или перейти на другой.';

  @override
  String get guideNext => 'ОК';

  @override
  String get guideDone => 'Начать';

  @override
  String get paletteLabel => 'Цветовая тема';

  @override
  String get paletteForest => 'Лес';

  @override
  String get paletteOcean => 'Океан';

  @override
  String get paletteSunset => 'Закат';

  @override
  String get paletteLavender => 'Лаванда';

  @override
  String get darkBlackLabel => 'Чистый чёрный в тёмной теме';

  @override
  String get spendingOverview => 'Обзор';

  @override
  String get spendingThisYear => 'Этот год';

  @override
  String get spendingYearly => 'Расходы за год';

  @override
  String get productSpending => 'Расходы по товарам';

  @override
  String get spanWeek => 'Неделя';

  @override
  String get spanMonth => 'Месяц';

  @override
  String get spanYear => 'Год';

  @override
  String get weeklyLimitTitle => 'Недельный лимит';

  @override
  String get weeklyLimitHelp =>
      'Сколько вы хотите тратить на покупки в неделю?';

  @override
  String get weeklyLimitNone =>
      'Задайте недельный лимит, чтобы видеть, сколько осталось.';

  @override
  String weeklyLimitLeft(String amount) {
    return 'На этой неделе осталось $amount';
  }

  @override
  String get shoppingLimitTitle => 'Лимит на одну покупку';

  @override
  String get shoppingLimitHelp => 'Новые списки начинаются с этим бюджетом.';

  @override
  String get shoppingLimitNone =>
      'Задайте бюджет по умолчанию для каждой новой покупки.';

  @override
  String get monthlyReportAction => 'Отчёт за месяц';

  @override
  String get reportShoppingColumn => 'Покупка';

  @override
  String get reportDateColumn => 'Дата';

  @override
  String get planUnavailable => 'Сейчас недоступно в магазине';

  @override
  String get demoDataTitle => 'Пример данных';

  @override
  String get demoDataLoad => 'Попробовать с примером данных';

  @override
  String get demoDataLoadHelp =>
      'Добавляет примеры покупок за 12 месяцев, чтобы увидеть историю, графики и историю цен.';

  @override
  String get demoDataRemove => 'Удалить пример данных';

  @override
  String get demoDataAdded => 'Пример данных добавлен';

  @override
  String get demoDataRemoved => 'Пример данных удалён';

  @override
  String get demoProductApple => 'Яблоки';

  @override
  String get demoProductBread => 'Хлеб';

  @override
  String get demoProductMilk => 'Молоко';

  @override
  String get demoProductCheese => 'Сыр';

  @override
  String get demoProductTomato => 'Помидоры';

  @override
  String get demoProductEggs => 'Яйца';

  @override
  String get demoProductCoffee => 'Кофе';

  @override
  String get demoProductDetergent => 'Стиральный порошок';

  @override
  String get sendAction => 'Send';

  @override
  String get previousMonthAction => 'Previous month';

  @override
  String get nextMonthAction => 'Next month';

  @override
  String get helpSection => 'Помощь и поддержка';

  @override
  String get howToUseLabel => 'Как пользоваться';

  @override
  String get guidePricesBody =>
      'Цена в магазине отмечает товар как купленный; 0 тоже учитывается. Домашняя цена необязательна. Удалите цену в магазине, чтобы снять отметку.';

  @override
  String get shoppingDateLabel => 'Дата покупок';

  @override
  String get shoppingDateNone => 'Дата не выбрана';

  @override
  String get clearShoppingDateAction => 'Удалить дату';

  @override
  String get listSortLabel => 'Порядок списка';

  @override
  String get listSortDate => 'Дата покупок';

  @override
  String get listSortAz => 'Название (А–Я)';

  @override
  String get listSortManual => 'Ручной порядок';

  @override
  String get imageCameraAction => 'Сделать фото';

  @override
  String get imageGalleryAction => 'Выбрать из фото';

  @override
  String get imageCaptureFailed =>
      'Не удалось открыть камеру или фото. Проверьте разрешение на доступ и попробуйте снова.';

  @override
  String get imageRecognitionFailed =>
      'Не удалось обработать фото. Попробуйте другое фото.';

  @override
  String get receiptNoProducts =>
      'Текст прочитан, но товары в чеке не найдены. Включите в фото товары и итоговую сумму.';

  @override
  String get keepAwakeOn => 'Экран остаётся включённым';

  @override
  String get keepAwakeOff => 'Экран может выключиться';

  @override
  String get spanDay => 'День';

  @override
  String get spanCustom => 'Диапазон дат';

  @override
  String get reportTotalSpent => 'Всего потрачено';

  @override
  String get reportAddedAt => 'Дата добавления';

  @override
  String get reportReceiptNumber => 'Номер чека';

  @override
  String get reportPreview => 'Предпросмотр';

  @override
  String get reportShareAction => 'Поделиться';

  @override
  String get previousPeriodAction => 'Предыдущий период';

  @override
  String get nextPeriodAction => 'Следующий период';

  @override
  String get reportSaved => 'Отчёт сохранён.';

  @override
  String get reportZoom => 'Увеличить';

  @override
  String planTrialDaysLeft(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days дня осталось',
      many: '$days дней осталось',
      few: '$days дня осталось',
      one: '$days день остался',
    );
    return '$_temp0';
  }

  @override
  String planTrialHoursLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours часа осталось',
      many: '$hours часов осталось',
      few: '$hours часа осталось',
      one: '$hours час остался',
    );
    return '$_temp0';
  }

  @override
  String get planTrialEndedTitle => 'Пробный период Pro завершён';

  @override
  String get planTrialEndedBody =>
      'Вы можете и дальше бесплатно пользоваться списками, ручным вводом и голосом на устройстве. Бесплатный план включает 10 запросов к ИИ за календарный месяц. Выберите годовой Pro, чтобы получать 100 запросов к ИИ в месяц, без рекламы и с резервными копиями. Ваши данные останутся с вами.';

  @override
  String get planContinueFree => 'Продолжить бесплатно';

  @override
  String get supportIdLabel => 'Идентификатор поддержки';

  @override
  String get supportEmailLabel => 'Поддержка по электронной почте';

  @override
  String get captureTipFirst =>
      'Начните с самого верха: название магазина и дата должны быть видны. Захватите как можно больше позиций, остальное будет на следующем фото.';

  @override
  String get captureTipContinue =>
      'Тот же чек: включите последнюю позицию с предыдущего фото.';

  @override
  String get captureTipNeverShow => 'Больше не показывать';

  @override
  String get captureTipOk => 'Понятно';

  @override
  String get captureTipsSetting => 'Показывать советы по съёмке чека';

  @override
  String get receiptReadingProgress => 'Чек читается…';

  @override
  String get receiptReadInBackground => 'Продолжить в фоне';

  @override
  String get receiptReadDoneTitle => 'Чек прочитан';

  @override
  String get receiptReadDoneBody => 'Нажмите, чтобы проверить и сохранить.';

  @override
  String get receiptReadMoreTitle => 'Сфотографируйте остальную часть чека';

  @override
  String get receiptReadFailedTitle => 'Не удалось прочитать чек';

  @override
  String get listReceiptsSection => 'Чеки';

  @override
  String get receiptStateComplete => 'Завершён';

  @override
  String get receiptStateIncomplete => 'Не завершён';

  @override
  String get receiptStateFailed => 'Ошибка';

  @override
  String get receiptStoreUnknown => 'Магазин не распознан';

  @override
  String get receiptDeleteAction => 'Удалить чек';

  @override
  String get receiptDeleteConfirm =>
      'Удалить этот чек и добавленные им товары? Позже его можно будет импортировать снова.';

  @override
  String get receiptDeleted => 'Чек удалён.';

  @override
  String listReceiptsShowAll(int count) {
    return 'Показать все ($count)';
  }

  @override
  String get listReceiptsShowLess => 'Показать меньше';

  @override
  String receiptDateLabel(String date) {
    return 'Дата чека: $date';
  }

  @override
  String get historyViewShopping => 'По покупкам';

  @override
  String get historyViewStore => 'По магазинам';

  @override
  String get historyViewProduct => 'По товарам';

  @override
  String get historyShareAll => 'Поделиться всем';

  @override
  String get historyUnknownStore => 'Неизвестный магазин';

  @override
  String get historyDailySpending => 'Расходы по дням';

  @override
  String get historyResetPeriod => 'Вернуться к этой неделе';

  @override
  String get tourSkip => 'Пропустить';

  @override
  String get tourNewListBody =>
      'Создайте список покупок и добавьте то, что планируете купить.';

  @override
  String get tourFromReceiptBody =>
      'Уже сходили в магазин? Превратите чек в список с ценами.';

  @override
  String get tourReceiptFlowBody =>
      'Начните с верха чека: сначала снимите магазин и дату, затем продолжайте остальными строками.';

  @override
  String get tourTabsBody =>
      'Переключайтесь между активными, завершёнными и архивными списками. Кнопка в конце меняет порядок.';

  @override
  String get tourDiscoverBody => 'Другие приложения того же разработчика.';

  @override
  String get tourHelpBody =>
      'Нажмите здесь, чтобы снова посмотреть руководство. Откройте список, чтобы узнать о его итогах и товарах.';

  @override
  String get tourTotalsBody =>
      'Итоги по плану, факту и разнице обновляются во время покупок.';

  @override
  String get tourItemsBody =>
      'Ваши товары. Меняйте их порядок или ищите их здесь.';

  @override
  String budgetAlertNear(String percent) {
    return 'Использовано $percent% лимита';
  }
}
