// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Плануй вдома. Купуй за планом.';

  @override
  String get listsTitle => 'Списки';

  @override
  String get listsTabActive => 'Активні';

  @override
  String get listsTabCompleted => 'Завершені';

  @override
  String get listsTabArchived => 'Архівовані';

  @override
  String get newListButton => 'Новий список';

  @override
  String get listTitleHint => 'Назва (необов’язково)';

  @override
  String get saveButton => 'Зберегти';

  @override
  String get cancelButton => 'Скасувати';

  @override
  String get deleteButton => 'Видалити';

  @override
  String get editAction => 'Редагувати';

  @override
  String get listDeleted => 'Список видалено';

  @override
  String get invalidAmountError => 'Некоректна сума';

  @override
  String get duplicateAction => 'Дублювати';

  @override
  String get archiveAction => 'Архівувати';

  @override
  String get unarchiveAction => 'Розархівувати';

  @override
  String get deleteListConfirm =>
      'Видалити цей список? Заплановані товари також будуть видалені.';

  @override
  String get undoButton => 'Скасувати дію';

  @override
  String get searchListHint => 'Пошук списків';

  @override
  String get currencyLabel => 'Валюта';

  @override
  String get budgetLabel => 'Бюджет (необов’язково)';

  @override
  String get noteLabel => 'Примітка (необов’язково)';

  @override
  String get storeLabel => 'Магазин';

  @override
  String get keepAmountsAction => 'Зберегти суми';

  @override
  String get resetAmountsAction => 'Скинути суми';

  @override
  String get currencyChangeWarning =>
      'Валюта змінюється. Що робити з поточними сумами?';

  @override
  String get listsEmpty =>
      'Списків ще немає. Створіть свій перший план покупок.';

  @override
  String get statusDraft => 'Чернетка';

  @override
  String get statusPlanned => 'Заплановано';

  @override
  String get statusShopping => 'У процесі покупки';

  @override
  String get statusCompleted => 'Завершено';

  @override
  String get statusArchived => 'Архівовано';

  @override
  String autoListTitle(String date) {
    return 'Покупки від $date';
  }

  @override
  String get itemFormTitle => 'Додати товар';

  @override
  String get itemNameLabel => 'Назва товару';

  @override
  String get brandLabel => 'Бренд / варіант (необов’язково)';

  @override
  String get categoryLabel => 'Категорія';

  @override
  String get quantityLabel => 'Кількість';

  @override
  String get unitLabel => 'Одиниця виміру';

  @override
  String get pricingModeLabel => 'Тип ціни';

  @override
  String get pricingModeUnitPrice => 'Ціна за одиницю';

  @override
  String get pricingModeLineTotal => 'Загальна сума позиції';

  @override
  String get plannedPriceLabel => 'Запланована ціна';

  @override
  String lineTotalCalculated(String value) {
    return 'Загальна сума: $value';
  }

  @override
  String get requiredItemToggle => 'Обов’язковий товар';

  @override
  String get maxPriceLabel => 'Максимальна прийнятна ціна (необов’язково)';

  @override
  String get itemNoteLabel => 'Примітка (необов’язково)';

  @override
  String get categoryProduce => 'Фрукти та овочі';

  @override
  String get categoryDairy => 'Молочні продукти';

  @override
  String get categoryMeat => 'М’ясо';

  @override
  String get categoryBakery => 'Хлібобулочні вироби';

  @override
  String get categoryDrinks => 'Напої';

  @override
  String get categoryCleaning => 'Засоби для прибирання';

  @override
  String get categoryPersonalCare => 'Гігієна';

  @override
  String get categoryHome => 'Для дому';

  @override
  String get categoryOther => 'Інше';

  @override
  String get invalidQuantityError => 'Некоректна кількість';

  @override
  String get invalidPriceError => 'Некоректна ціна';

  @override
  String get invalidNameError => 'Введіть назву';

  @override
  String unitPriceCalculated(String value) {
    return 'Ціна за одиницю: $value';
  }

  @override
  String get shoppingTitle => 'Режим покупок';

  @override
  String get summaryPlannedTotal => 'Заплановано';

  @override
  String get summaryInCart => 'У кошику';

  @override
  String get summaryRemainingPlan => 'Залишок плану';

  @override
  String get summaryProjected => 'Очікувана сума';

  @override
  String get summaryBudgetRemaining => 'Бюджет залишився';

  @override
  String get summaryBudgetOver => 'Перевищення бюджету';

  @override
  String itemsProgress(String done, String total) {
    return '$done з $total товарів';
  }

  @override
  String get filterAll => 'Все';

  @override
  String get filterToBuy => 'Купити';

  @override
  String get filterInCart => 'У кошику';

  @override
  String get filterNotFound => 'Не знайдено';

  @override
  String get filterRequired => 'Обов’язково';

  @override
  String get quickEntryTitle => 'Фактична ціна';

  @override
  String get actualQuantityLabel => 'Фактична кількість';

  @override
  String get actualPriceLabel => 'Фактична ціна';

  @override
  String get discountLabel => 'Знижка (необов’язково)';

  @override
  String get alternativeNameLabel =>
      'Назва альтернативного товару (необов’язково)';

  @override
  String get savePurchaseButton => 'Додати до кошика';

  @override
  String get unplannedAddButton => 'Додати позаплановий товар';

  @override
  String get statusPending => 'Не взято';

  @override
  String get statusInCart => 'У кошику';

  @override
  String get statusNotFound => 'Не знайдено';

  @override
  String get statusGaveUp => 'Відмовлено';

  @override
  String get statusAlternative => 'Куплено альтернативу';

  @override
  String get keepScreenAwake => 'Не вимикати екран';

  @override
  String get finishShopping => 'Завершити покупки';

  @override
  String get completionWarning =>
      'Є пропущені або неперевірені записи. Ви все ще можете завершити; результат їх відзначить.';

  @override
  String get continueShoppingButton => 'Продовжити покупки';

  @override
  String get resultTitle => 'Результат';

  @override
  String get summarySection => 'Підсумок';

  @override
  String get plannedTotalLabel => 'Загальна запланована сума';

  @override
  String get actualTotalLabel => 'Фактична загальна сума';

  @override
  String get varianceLabel => 'Різниця';

  @override
  String get varianceNotComputable => 'Неможливо обчислити';

  @override
  String get budgetStatusLabel => 'Бюджет';

  @override
  String get savingsLabel => 'Економія';

  @override
  String get overspendLabel => 'Перевитрати';

  @override
  String get unplannedTotalLabel => 'Загальна позапланова сума';

  @override
  String get unpurchasedLabel => 'Заплановано, але не куплено';

  @override
  String get totalDiscountLabel => 'Загальні знижки';

  @override
  String get accuracyLabel => 'Точність оцінки';

  @override
  String get groupsSection => 'Товари';

  @override
  String get groupPricier => 'Дорожче запланованого';

  @override
  String get groupCheaper => 'Дешевше запланованого';

  @override
  String get groupClose => 'Близько до оцінки';

  @override
  String get groupNotTaken => 'Заплановано, не куплено';

  @override
  String get groupUnplanned => 'Куплено без плану';

  @override
  String get groupQuantityChanged => 'Змінено кількість';

  @override
  String get groupUnverified => 'Не перевірено';

  @override
  String get plannedQtyLabel => 'Запланована кількість';

  @override
  String get actualQtyLabel => 'Фактична кількість';

  @override
  String get plannedUnitPriceLabel => 'Запланована ціна за одиницю';

  @override
  String get actualUnitPriceLabel => 'Фактична ціна за одиницю';

  @override
  String get lineVarianceLabel => 'Різниця по рядку';

  @override
  String get discountEffectLabel => 'Ефект знижки';

  @override
  String get notBoughtMark => 'не куплено';

  @override
  String get noPurchasesNote => 'Покупки не зафіксовано.';

  @override
  String get navHome => 'Головна';

  @override
  String get navLists => 'Списки';

  @override
  String get navHistory => 'Історія';

  @override
  String get navSettings => 'Налаштування';

  @override
  String get homeEmptyTitle => 'Плануйте покупки';

  @override
  String get homeEmptyBody =>
      'Створіть свій перший список і порівняйте заплановані та фактичні витрати.';

  @override
  String get homeActiveSection => 'Активні списки';

  @override
  String get homeCompletedSection => 'Нещодавно завершено';

  @override
  String get homeMonthlySection => 'Цього місяця';

  @override
  String get monthPlannedLabel => 'Заплановано';

  @override
  String get monthActualLabel => 'Фактично';

  @override
  String get monthVarianceLabel => 'Різниця';

  @override
  String get continueShoppingLabel => 'Продовжити покупки';

  @override
  String get historyEmpty =>
      'Ще немає завершених покупок. Ваша історія та аналітика з’являться тут.';

  @override
  String get aboutTabTitle => 'Про NShoptor';

  @override
  String get aboutBody =>
      'NShoptor від Crazy Penguin. Офлайн-планувальник покупок. Ліцензія GPL-3.0.';

  @override
  String get startShoppingLabel => 'Розпочати покупки';

  @override
  String get finishAndSeeResult => 'Завершити й побачити результат';

  @override
  String get settingsTitle => 'Налаштування';

  @override
  String get languageLabel => 'Мова';

  @override
  String get languageSystem => 'Системна';

  @override
  String get languageTr => 'Турецька';

  @override
  String get languageEn => 'Англійська';

  @override
  String get themeLabel => 'Тема';

  @override
  String get themeSystem => 'Системна';

  @override
  String get themeLight => 'Світла';

  @override
  String get themeDark => 'Темна';

  @override
  String get defaultCurrencyLabel => 'Валюта за замовчуванням';

  @override
  String get defaultUnitLabel => 'Одиниця виміру за замовчуванням';

  @override
  String get keepAwakeLabel => 'Не вимикати екран під час покупок';

  @override
  String get backupSection => 'Резервне копіювання';

  @override
  String get exportBackupLabel => 'Експорт резервної копії';

  @override
  String get importBackupLabel => 'Імпорт резервної копії';

  @override
  String get mergeImportLabel => 'Об’єднати з поточними даними';

  @override
  String get separateImportLabel => 'Імпортувати як окрему копію';

  @override
  String get importCancelled => 'Імпорт скасовано.';

  @override
  String get backupExported => 'Резервну копію успішно експортовано.';

  @override
  String get backupSizeWarning =>
      'Великий файл резервної копії: він може бути значним. Додати фотографії?';

  @override
  String get deleteAllSection => 'Небезпечна зона';

  @override
  String get deleteAllLabel => 'Видалити всі дані';

  @override
  String get deleteAllConfirm =>
      'Це видалить усі списки, історію, фото чеки та ціни. Файли, які ви експортували, залишаться на вашому диску. Продовжити?';

  @override
  String get deleteAllConfirm2 => 'Ви впевнені? Цю дію неможливо скасувати.';

  @override
  String get cancelAction => 'Скасувати';

  @override
  String get confirmDelete => 'Видалити назавжди';

  @override
  String get dataDeleted => 'Усі локальні дані видалено.';

  @override
  String get privacyInfoLabel => 'Конфіденційність';

  @override
  String get privacyInfoBody =>
      'Ваші списки, ціни, чеки та фотографії залишаються на пристрої. Фотографії та голос ніколи не покидають його. Якщо увімкнено допомогу AI, лише текст (наприклад, рядки чека або те, що ви продиктували) надсилається на наш сервер для обробки й не зберігається.';

  @override
  String get aboutSection => 'Про додаток';

  @override
  String get aboutPublisher => 'Видавець: Crazy Penguin';

  @override
  String get aboutLicenses => 'Ліцензії (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Голосовий ввід';

  @override
  String get voiceStatusUnknown => 'Сервіс: не перевірено';

  @override
  String get permissionsLabel => 'Дозволи';

  @override
  String get permissionsBody =>
      'Камера, мікрофон і сповіщення запитуваються лише тоді, коли ви дійсно використовуєте ці функції.';

  @override
  String get unitsSection => 'За замовчуванням';

  @override
  String get roundingNote =>
      'Округлення грошей підпорядковується одному правилу: половини округлюються від нуля, застосовується один раз при конвертації грошей.';

  @override
  String get voiceInputTitle => 'Голосовий ввід';

  @override
  String get voiceStartListening => 'Почати прослуховування';

  @override
  String get voiceTranscriptLabel => 'Транскрипт';

  @override
  String get parseAction => 'Розпізнати';

  @override
  String get receiptReviewTitle => 'Переглянути чек';

  @override
  String get receiptTotal => 'Загальна сума чека';

  @override
  String get receiptTotalUnknown => 'Суму не виявлено';

  @override
  String get receiptDiff => 'Різниця';

  @override
  String get acceptLine => 'Прийняти рядок';

  @override
  String get ignoreLine => 'Ігнорувати рядок';

  @override
  String get receiptLineActions =>
      'Прив’язати до товару, розділити або ігнорувати';

  @override
  String get receiptCommit => 'Прийняти все';

  @override
  String get receiptCommitted => 'Чек застосовано.';

  @override
  String get priceHistoryTitle => 'Історія цін';

  @override
  String get noObservations => 'Поки що немає спостережень за цінами';

  @override
  String get templatesSection => 'Шаблони';

  @override
  String get templateHint =>
      'Створити новий план на основі попередньої покупки';

  @override
  String get scanReceiptAction => 'Сканувати чек';

  @override
  String get shelfLabelAction => 'Ціна з етикетки на полиці';

  @override
  String get priceCandidatesTitle => 'Кандидати на ціну';

  @override
  String get noPriceCandidates => 'Ціну не знайдено; введіть її вручну.';

  @override
  String get voiceUnavailable =>
      'Розпізнавання мовлення недоступне; введіть вручну.';

  @override
  String get linkToItem => 'Прив’язати до товару';

  @override
  String get splitLine => 'Розділити на два';

  @override
  String get mergeWithNext => 'Об’єднати з наступним';

  @override
  String get ocrNoText => 'Текст не зчитано; спробуйте ще раз.';

  @override
  String get priceHistoryAction => 'Історія цін';

  @override
  String get itemsEmptyTitle => 'Ще немає товарів';

  @override
  String get itemsEmptyBody =>
      'Додайте свій перший товар — тут ви вводитимете реальні ціни в магазині.';

  @override
  String get addItemTooltip => 'Додати товар';

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
  String get unitPaket => 'упак.';

  @override
  String get unitKutu => 'коробка';

  @override
  String get unitSise => 'пляшка';

  @override
  String get unitKavanoz => 'банка';

  @override
  String get unitDemet => 'в’язка';

  @override
  String get unitDuzine => 'дюжина';

  @override
  String get unitMetre => 'м';

  @override
  String get unitCustom => 'Власна';

  @override
  String get setReminderAction => 'Встановити нагадування';

  @override
  String get reminderPermissionDenied =>
      'Для нагадувань потрібен дозвіл на надсилання сповіщень. Ви можете увімкнути його в налаштуваннях системи.';

  @override
  String get reminderScheduled => 'Нагадування встановлено.';

  @override
  String get reminderCancelled => 'Нагадування видалено.';

  @override
  String get reminderTitle => 'Нагадування про покупки';

  @override
  String reminderBody(Object title) {
    return 'Час перевірити свій список: $title';
  }

  @override
  String get reminderPickDate => 'Оберіть дату';

  @override
  String get reminderPickTime => 'Оберіть час';

  @override
  String get itemDetailsSection => 'Деталі';

  @override
  String get priceOptionalHint =>
      'Не обов’язково — реальну ціну ви введете в магазині';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Заплановано: $total · $count товарів';
  }

  @override
  String get proActiveLabel => 'Pro активний — дякуємо!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Без реклами, більше AI, резервне копіювання · від невеликої щомісячної плати';

  @override
  String get proBenefitNoAds => 'Без реклами';

  @override
  String get proBenefitBackup => 'Резервне копіювання (експорт/імпортування)';

  @override
  String aboutVersion(Object version) {
    return 'Версія $version';
  }

  @override
  String get navDiscover => 'Огляд';

  @override
  String get shareAction => 'Поділитися додатком';

  @override
  String get rateAction => 'Оцінити нас';

  @override
  String get aboutOpenRow => 'Про додаток та open source';

  @override
  String get voiceAddItemAction => 'Додати голосом';

  @override
  String get formatLocaleLabel => 'Формат чисел і валюти';

  @override
  String get formatLocaleSystem => 'Системний (відповідає мові додатку)';

  @override
  String get formatLocaleTr => 'Турецький (1.234,56)';

  @override
  String get formatLocaleEn => 'Англійський (1,234.56)';

  @override
  String get aiToggleTitle => 'Допомога AI';

  @override
  String get aiToggleSubtitle =>
      'Зіставляє чеки, зчитує цінники та перетворює речення на списки. Фото й голос залишаються на вашому пристрої; обробляється лише текст.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Ви використали місячну квоту запитів до AI ($used/$limit). Оновіться для більшої кількості або продовжуйте без AI.';
  }

  @override
  String get aiOffline => 'Немає підключення — працюємо без AI.';

  @override
  String get aiFailed => 'AI зараз недоступний — працюємо без нього.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'Пристрій';

  @override
  String get quickListAction => 'Додати з речення';

  @override
  String get quickListTitle => 'Швидкий список';

  @override
  String get quickListHint => 'напр., 1 кг яблук 20, 2 хліби, півкіло сиру';

  @override
  String get quickListConvert => 'Перетворити на список';

  @override
  String quickListAdd(int count) {
    return 'Додати $count товарів';
  }

  @override
  String get quickListEmpty =>
      'Нічого не знайдено. Спробуйте перелічити товари через кому.';

  @override
  String get receiptAiMatched =>
      'AI зіставив чек із вашим списком. Перевірте посилання та підтвердьте.';

  @override
  String get receiptNeedsCheck => 'Перевірити це співпадіння';

  @override
  String get receiptDiscountLine => 'Знижка';

  @override
  String get compareItem => 'Товар';

  @override
  String get compareEstimated => 'Очікувана ціна';

  @override
  String get compareActual => 'Фактична ціна';

  @override
  String get compareDiff => 'Різниця';

  @override
  String get compareTotal => 'Разом';

  @override
  String get compareBudget => 'Бюджет';

  @override
  String get compareNotBought => 'не куплено';

  @override
  String get compareUnplanned => 'не планувалося';

  @override
  String get pricierItems => 'Коштували дорожче';

  @override
  String get cheaperItems => 'Коштували дешевше';

  @override
  String get compareAction => 'Порівняти';

  @override
  String get detailsSection => 'Деталі';

  @override
  String get spendingTitle => 'Витрати';

  @override
  String get spendingAction => 'Витрати';

  @override
  String get spendingMonthTotal => 'Цього місяця';

  @override
  String get spendingWeekly => 'Щотижневі витрати';

  @override
  String get spendingMonthly => 'Щомісячні витрати';

  @override
  String get monthlyLimitTitle => 'Місячний ліміт';

  @override
  String get monthlyLimitHelp =>
      'Скільки ви хочете витрачати на покупки щомісяця?';

  @override
  String get monthlyLimitRemove => 'Видалити';

  @override
  String get monthlyLimitSet => 'Встановити';

  @override
  String get monthlyLimitChange => 'Змінити';

  @override
  String get monthlyLimitNone =>
      'Встановіть місячний ліміт, щоб бачити, скільки залишилося.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount перевищено ліміт';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return '$amount залишилося цього місяця';
  }

  @override
  String get plansTitle => 'Плани';

  @override
  String get plansHeadline => 'Купуйте розумніше з AI';

  @override
  String get plansSubhead =>
      'Зіставлення чеків, зчитування цінників та створення списків із речення. Скасувати можна будь-коли.';

  @override
  String get plansMonthly => 'Щомісяця';

  @override
  String get plansYearly => 'Щороку';

  @override
  String get planFree => 'Безкоштовно';

  @override
  String get planFreePrice => 'Назавжди безкоштовно';

  @override
  String get planFreeAi => '15 запитів до AI на місяць';

  @override
  String get planFreeAds =>
      'Невеликі банерні реклами (перші 7 днів без реклами)';

  @override
  String get planCoreFeatures => 'Списки, ціни, чеки, графіки витрат';

  @override
  String get plansPerYear => '/ рік';

  @override
  String get plansPerMonth => '/ місяць';

  @override
  String get planTrial => '7 днів безкоштовно';

  @override
  String get planProAi => '200 запитів до AI на місяць';

  @override
  String get planNoAds => 'Без реклами';

  @override
  String get planBackup => 'Експорт і імпорт резервної копії';

  @override
  String get planMaxAi => '1000 запитів до ШІ на місяць';

  @override
  String get planMaxFamily => 'Для великої сімейної закупівлі';

  @override
  String get plansStoreUnavailable => 'Магазин зараз недоступний.';

  @override
  String get retryAction => 'Повторити';

  @override
  String get plansPurchaseFailed => 'Покупка не пройшла. Спробуйте ще раз.';

  @override
  String get planLifetimeTitle => 'Без реклами назавжди';

  @override
  String get planLifetimeSubtitle =>
      'Одноразова оплата: без реклами, резервні копії; ШІ залишається у безкоштовному ліміті';

  @override
  String get plansRestore => 'Відновити покупки';

  @override
  String get plansLegal =>
      'Підписки автоматично поновлюються, доки їх не скасовано. Скасувати можна будь-коли в Google Play › Платежі та підписки. Ціни включають податки, які відображає Google Play.';

  @override
  String get planCurrent => 'Поточна';

  @override
  String get planStartTrial => 'Розпочати безкоштовну пробну версію на 7 днів';

  @override
  String get planChoose => 'Обрати';

  @override
  String get plansAction => 'Тарифи: Pro та Max';

  @override
  String get assistantTitle => 'Асистент';

  @override
  String get assistantGreeting => 'Привіт! Що ви хотіли б зробити?';

  @override
  String get assistantNewList => 'Новий список';

  @override
  String get assistantVoiceList => 'Список голосом';

  @override
  String get assistantTextList => 'Список із речення';

  @override
  String get assistantScanReceipt => 'Сканувати чек';

  @override
  String get assistantSpending => 'Мої витрати';

  @override
  String get assistantReceiptHint =>
      'Відкрийте свій список і натисніть значок чека, щоб відсканувати його.';

  @override
  String get assistantToggleTitle => 'Показати асистента';

  @override
  String get assistantToggleSubtitle =>
      'Маленький помічник у правому нижньому куті';

  @override
  String get scanPriceLabel => 'Сканувати ціну';
}
