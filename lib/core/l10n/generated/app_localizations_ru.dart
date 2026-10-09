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
  String get slogan => 'Планируйте дома. Покупайте по плану.';

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
  String get backupSizeWarning =>
      'Большая копия: файл может быть объёмным. Включить и фотографии?';

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
      'Ваши списки, цены, чеки и фото остаются на устройстве. Фото и голос никогда его не покидают. Когда включена помощь ИИ, на наш сервер для обработки отправляется только текст (например, строки чека или то, что вы продиктовали), и он не сохраняется.';

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
  String get priceOptionalHint =>
      'Необязательно — реальную цену внесёте в магазине';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'План: $total · $count товаров';
  }

  @override
  String get proActiveLabel => 'Pro активен — спасибо!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Без рекламы, больше ИИ, резервная копия · за небольшую ежемесячную плату';

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
  String get formatLocaleSystem => 'Системный (как язык)';

  @override
  String get formatLocaleTr => 'Турецкий (1.234,56)';

  @override
  String get formatLocaleEn => 'Английский (1,234.56)';

  @override
  String get aiToggleTitle => 'Помощь ИИ';

  @override
  String get aiToggleSubtitle =>
      'Сопоставляет чеки, читает ценники и превращает фразы в списки. Фото и голос остаются на устройстве; обрабатывается только текст.';

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
  String get compareEstimated => 'План';

  @override
  String get compareActual => 'Факт';

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
  String get planFreeAi => '15 запросов к ИИ в месяц';

  @override
  String get planFreeAds => 'Небольшие баннеры (первые 7 дней без рекламы)';

  @override
  String get planCoreFeatures => 'Списки, цены, чеки, графики расходов';

  @override
  String get plansPerYear => '/ год';

  @override
  String get plansPerMonth => '/ мес.';

  @override
  String get planTrial => '7 дней бесплатно';

  @override
  String get planProAi => '200 запросов к ИИ в месяц';

  @override
  String get planNoAds => 'Без рекламы';

  @override
  String get planBackup => 'Экспорт и импорт копии';

  @override
  String get planMaxAi => '1000 запросов к ИИ в месяц';

  @override
  String get planMaxFamily => 'Для больших семейных покупок';

  @override
  String get plansStoreUnavailable => 'Магазин сейчас недоступен.';

  @override
  String get retryAction => 'Повторить';

  @override
  String get plansPurchaseFailed => 'Покупка не прошла. Попробуйте ещё раз.';

  @override
  String get planLifetimeTitle => 'Без рекламы навсегда';

  @override
  String get planLifetimeSubtitle =>
      'Разовый платёж: без рекламы, резервная копия; ИИ — в бесплатном лимите';

  @override
  String get plansRestore => 'Восстановить покупки';

  @override
  String get plansLegal =>
      'Подписки продлеваются автоматически до отмены. Отменить можно в любое время в Google Play › Платежи и подписки. Цены включают налоги, указанные Google Play.';

  @override
  String get planCurrent => 'Текущий';

  @override
  String get planStartTrial => '7 дней бесплатно';

  @override
  String get planChoose => 'Выбрать';

  @override
  String get plansAction => 'Тарифы: Pro и Max';

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
      'Строки привязанного чека заменяют существующие покупки; непривязанные строки добавляются.';

  @override
  String get voiceUnsupportedLanguage =>
      'Этот язык недоступен для голосового ввода на этом устройстве. Можно ввести текст.';
}
