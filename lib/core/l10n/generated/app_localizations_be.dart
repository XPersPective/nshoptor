// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Belarusian (`be`).
class AppLocalizationsBe extends AppLocalizations {
  AppLocalizationsBe([String locale = 'be']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Плануй дома. Покупай па плане.';

  @override
  String get listsTitle => 'Спісы';

  @override
  String get listsTabActive => 'Актыўныя';

  @override
  String get listsTabCompleted => 'Выкананыя';

  @override
  String get listsTabArchived => 'Архіваваныя';

  @override
  String get newListButton => 'Новы спіс';

  @override
  String get listTitleHint => 'Назва (неабавязкова)';

  @override
  String get saveButton => 'Захаваць';

  @override
  String get cancelButton => 'Адмена';

  @override
  String get deleteButton => 'Выдаліць';

  @override
  String get editAction => 'Рэдагаваць';

  @override
  String get listDeleted => 'Спіс выдалены';

  @override
  String get invalidAmountError => 'Няправільная колькасць';

  @override
  String get duplicateAction => 'Дублікаваць';

  @override
  String get archiveAction => 'Архіваваць';

  @override
  String get unarchiveAction => 'Разархіваваць';

  @override
  String get deleteListConfirm =>
      'Выдаліць гэты спіс? Планаваныя пазіцыі таксама будуць выдалены.';

  @override
  String get undoButton => 'Адмяніць';

  @override
  String get searchListHint => 'Пошук спісаў';

  @override
  String get currencyLabel => 'Валюта';

  @override
  String get budgetLabel => 'Бюджэт (неабавязкова)';

  @override
  String get noteLabel => 'Заўвага (неабавязкова)';

  @override
  String get storeLabel => 'Крама';

  @override
  String get keepAmountsAction => 'Захаваць колькасці';

  @override
  String get resetAmountsAction => 'Скінуць колькасці';

  @override
  String get currencyChangeWarning =>
      'Валюта змяняецца. Што рабіць з існуючымі колькасцямі?';

  @override
  String get listsEmpty =>
      'Пакуль няма спісаў. Стварыце свой першы план пакупок.';

  @override
  String get statusDraft => 'Чарнавік';

  @override
  String get statusPlanned => 'Запланавана';

  @override
  String get statusShopping => 'У працэсе';

  @override
  String get statusCompleted => 'Выканана';

  @override
  String get statusArchived => 'Архівавана';

  @override
  String autoListTitle(String date) {
    return 'Пакупкі $date';
  }

  @override
  String get itemFormTitle => 'Дадаць тавар';

  @override
  String get itemNameLabel => 'Назва тавару';

  @override
  String get brandLabel => 'Брэнд / варыянт (неабавязкова)';

  @override
  String get categoryLabel => 'Катэгорыя';

  @override
  String get quantityLabel => 'Колькасць';

  @override
  String get unitLabel => 'Адзінка вымярэння';

  @override
  String get pricingModeLabel => 'Увод цаны';

  @override
  String get pricingModeUnitPrice => 'Цана за адзінку';

  @override
  String get pricingModeLineTotal => 'Агульная сума па радку';

  @override
  String get plannedPriceLabel => 'Запланаваная цана';

  @override
  String lineTotalCalculated(String value) {
    return 'Агульная сума: $value';
  }

  @override
  String get requiredItemToggle => 'Неабходны тавар';

  @override
  String get maxPriceLabel => 'Максімальная дапушчальная цана (неабавязкова)';

  @override
  String get itemNoteLabel => 'Заўвага (неабавязкова)';

  @override
  String get categoryProduce => 'Агародніна і фрукты';

  @override
  String get categoryDairy => 'Малочныя прадукты';

  @override
  String get categoryMeat => 'Мяса';

  @override
  String get categoryBakery => 'Выпечка';

  @override
  String get categoryDrinks => 'Напоі';

  @override
  String get categoryCleaning => 'Хімія для хаты';

  @override
  String get categoryPersonalCare => 'Сродкі гігіены';

  @override
  String get categoryHome => 'Тавары для дому';

  @override
  String get categoryOther => 'Іншае';

  @override
  String get invalidQuantityError => 'Няправільная колькасць';

  @override
  String get invalidPriceError => 'Няправільная цана';

  @override
  String get invalidNameError => 'Увядзіце назву';

  @override
  String unitPriceCalculated(String value) {
    return 'Цана за адзінку: $value';
  }

  @override
  String get shoppingTitle => 'Рэжым пакупак';

  @override
  String get summaryPlannedTotal => 'Запланавана';

  @override
  String get summaryInCart => 'У кошыку';

  @override
  String get summaryRemainingPlan => 'Засталося спланіраваць';

  @override
  String get summaryProjected => 'Ацэнка да аплаты';

  @override
  String get summaryBudgetRemaining => 'Бюджэт застаўся';

  @override
  String get summaryBudgetOver => 'Перавышэнне бюджэту';

  @override
  String itemsProgress(String done, String total) {
    return '$done з $total тавараў';
  }

  @override
  String get filterAll => 'Усе';

  @override
  String get filterToBuy => 'Купіць';

  @override
  String get filterInCart => 'У кошыку';

  @override
  String get filterNotFound => 'Не знойдзена';

  @override
  String get filterRequired => 'Неабходна';

  @override
  String get quickEntryTitle => 'Фактычная цана';

  @override
  String get actualQuantityLabel => 'Фактычная колькасць';

  @override
  String get actualPriceLabel => 'Фактычная цана';

  @override
  String get discountLabel => 'Зніжка (неабавязкова)';

  @override
  String get alternativeNameLabel =>
      'Назва альтэрнатыўнага тавару (неабавязкова)';

  @override
  String get savePurchaseButton => 'Дадаць у кошык';

  @override
  String get unplannedAddButton => 'Дадаць неспланаваны тавар';

  @override
  String get statusPending => 'Не ўзята';

  @override
  String get statusInCart => 'У кошыку';

  @override
  String get statusNotFound => 'Не знойдзена';

  @override
  String get statusGaveUp => 'Адмовіліся';

  @override
  String get statusAlternative => 'Куплена альтэрнатыва';

  @override
  String get keepScreenAwake => 'Трымаць экран уключаным';

  @override
  String get finishShopping => 'Завяршыць пакупкі';

  @override
  String get completionWarning =>
      'Ёсць прапушчаныя або неправераныя запісы. Вы ўсё роўна можаце завяршыць; вынік будзе іх адзначаць.';

  @override
  String get continueShoppingButton => 'Працягнуць пакупкі';

  @override
  String get resultTitle => 'Вынік';

  @override
  String get summarySection => 'Агульныя звесткі';

  @override
  String get plannedTotalLabel => 'Агульная планавая сума';

  @override
  String get actualTotalLabel => 'Агульная фактычная сума';

  @override
  String get varianceLabel => 'Розніца';

  @override
  String get varianceNotComputable => 'Нелька вылічыць';

  @override
  String get budgetStatusLabel => 'Бюджэт';

  @override
  String get savingsLabel => 'Эканомія ад плана';

  @override
  String get overspendLabel => 'Перавышэнне плана';

  @override
  String get unplannedTotalLabel => 'Агульная сума неспланаваных';

  @override
  String get unpurchasedLabel => 'Запланавана, але не куплена';

  @override
  String get totalDiscountLabel => 'Агульныя зніжкі';

  @override
  String get accuracyLabel => 'Дакладнасць ацэнкі';

  @override
  String get groupsSection => 'Тавары';

  @override
  String get groupPricier => 'Даражэй за запланаванае';

  @override
  String get groupCheaper => 'Дзейша за запланаванае';

  @override
  String get groupClose => 'Блізка да ацэнкі';

  @override
  String get groupNotTaken => 'Запланавана, не куплена';

  @override
  String get groupUnplanned => 'Куплена без плана';

  @override
  String get groupQuantityChanged => 'Зменена колькасць';

  @override
  String get groupUnverified => 'Не праверана';

  @override
  String get plannedQtyLabel => 'Запланаваная колькасць';

  @override
  String get actualQtyLabel => 'Фактычная колькасць';

  @override
  String get plannedUnitPriceLabel => 'Запланаваная цана за адзінку';

  @override
  String get actualUnitPriceLabel => 'Фактычная цана за адзінку';

  @override
  String get lineVarianceLabel => 'Розніца па радку';

  @override
  String get discountEffectLabel => 'Эфект зніжкі';

  @override
  String get notBoughtMark => 'не куплена';

  @override
  String get noPurchasesNote => 'Пакупкі не запісаны.';

  @override
  String get navHome => 'Галоўная';

  @override
  String get navLists => 'Спісы';

  @override
  String get navHistory => 'Гісторыя';

  @override
  String get navSettings => 'Налады';

  @override
  String get homeEmptyTitle => 'Плануйце пакупкі';

  @override
  String get homeEmptyBody =>
      'Стварыце свой першы спіс і параўнайце планаваныя і фактычныя выдаткі.';

  @override
  String get homeActiveSection => 'Актыўныя спісы';

  @override
  String get homeCompletedSection => 'Нядаўняе завяршэнне';

  @override
  String get homeMonthlySection => 'У гэтым месяцы';

  @override
  String get monthPlannedLabel => 'Планава';

  @override
  String get monthActualLabel => 'Фактычна';

  @override
  String get monthVarianceLabel => 'Розніца';

  @override
  String get continueShoppingLabel => 'Працягнуць пакупкі';

  @override
  String get historyEmpty =>
      'Завяршаных папрак яшчэ няма. Ваша гісторыя і аналітыка з\'явяцца тут.';

  @override
  String get aboutTabTitle => 'Пра NShoptor';

  @override
  String get aboutBody =>
      'NShoptor ад Crazy Penguin. Планавальнік папрак, які працуе афлайн. Ліцэнзія GPL-3.0.';

  @override
  String get startShoppingLabel => 'Пачаць пакупкі';

  @override
  String get finishAndSeeResult => 'Завяршыць і паглядзець вынік';

  @override
  String get settingsTitle => 'Налады';

  @override
  String get languageLabel => 'Мова';

  @override
  String get languageSystem => 'Сістэмная';

  @override
  String get languageTr => 'Турэцкая';

  @override
  String get languageEn => 'Англійская';

  @override
  String get themeLabel => 'Тэма';

  @override
  String get themeSystem => 'Сістэмная';

  @override
  String get themeLight => 'Светлая';

  @override
  String get themeDark => 'Цёмная';

  @override
  String get defaultCurrencyLabel => 'Валюта па змаўчанні';

  @override
  String get defaultUnitLabel => 'Адзінка вымярэння па змаўчанні';

  @override
  String get keepAwakeLabel => 'Не выключаць экран падчас папрак';

  @override
  String get backupSection => 'Рэзервовая копія';

  @override
  String get exportBackupLabel => 'Экспарт рэзервовай копіі';

  @override
  String get importBackupLabel => 'Імпарт рэзервовай копіі';

  @override
  String get mergeImportLabel => 'Дадаць да бягучых даных';

  @override
  String get separateImportLabel => 'Імпартаваць як асобную копію';

  @override
  String get importCancelled => 'Імпарт скасаваны.';

  @override
  String get backupExported => 'Рэзервовая копія паспяхова экспартавана.';

  @override
  String get deleteAllSection => 'Небяспечная зона';

  @override
  String get deleteAllLabel => 'Выдаліць усе даныя';

  @override
  String get deleteAllConfirm =>
      'Гэта выдаліць усе спісы, гісторыю, фота чекаў і кошты. Файлы, якія вы экспартавалі, застануцца на вашым дыску. Працягнуць?';

  @override
  String get deleteAllConfirm2 =>
      'Вы сапраўды ўпэўнены? Гэта дзеянне нельга адмяніць.';

  @override
  String get cancelAction => 'Адмена';

  @override
  String get confirmDelete => 'Выдаліць назаўжды';

  @override
  String get dataDeleted => 'Усе лакальныя даныя выдалены.';

  @override
  String get privacyInfoLabel => 'Прыватнасць';

  @override
  String get privacyInfoBody =>
      'Вашы спісы, кошты, чаки і фота захоўваюцца на прыладзе. Голас яе ніколі не пакідае. Калі ўключана дапамога AI, фота чакаў і цэннікаў (паменшаныя ў памеры) і тэкст, напрыклад прадыктаваныя пазіцыі, адпраўляюцца на наш сервер толькі для прачытання; яны апрацоўваюцца адразу і ніколі не захоўваюцца.';

  @override
  String get aboutSection => 'Пра праграму';

  @override
  String get aboutPublisher => 'Выдавец: Crazy Penguin';

  @override
  String get aboutLicenses => 'Ліцэнзіі (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Галасавы ўвод';

  @override
  String get voiceStatusUnknown => 'Сервіс: не правераны';

  @override
  String get permissionsLabel => 'Дазволы';

  @override
  String get permissionsBody =>
      'Камера, мікрафон і апавяшчэнні патрабуюцца толькі тады, калі вы сапраўды карыстаецеся гэтымі функцыямі.';

  @override
  String get unitsSection => 'Па змаўчанні';

  @override
  String get roundingNote =>
      'Акругленне грошай падпарадкоўваецца правілу: паловы акругляюцца ўбок ад нуля, прымяняецца адзін раз пры канвертаванні грошай.';

  @override
  String get voiceInputTitle => 'Галасавы ўвод';

  @override
  String get voiceStartListening => 'Пачаць слухаць';

  @override
  String get voiceTranscriptLabel => 'Транскрыпт';

  @override
  String get parseAction => 'Апрацаваць';

  @override
  String get receiptReviewTitle => 'Праверка чека';

  @override
  String get receiptTotal => 'Агульная сума па чеку';

  @override
  String get receiptTotalUnknown => 'Сума не вызначана';

  @override
  String get receiptDiff => 'Розніца';

  @override
  String get acceptLine => 'Прыняць радок';

  @override
  String get ignoreLine => 'Ігнараваць радок';

  @override
  String get receiptLineActions =>
      'Звязаць з таварам, раздзяліць або ігнараваць';

  @override
  String get receiptCommit => 'Прыняць усё';

  @override
  String get receiptCommitted => 'Чэк прымянёны.';

  @override
  String get priceHistoryTitle => 'Гісторыя цэн';

  @override
  String get noObservations => 'Пакуль няма назіранняў за цэнамі';

  @override
  String get templatesSection => 'Шаблоны';

  @override
  String get templateHint => 'Стварыць новы план на аснове папярэдняй пакупкі';

  @override
  String get scanReceiptAction => 'Сканаваць чэк';

  @override
  String get fromReceiptListButton => 'Са чэка';

  @override
  String get shelfLabelAction => 'Цана з палічкі';

  @override
  String get priceCandidatesTitle => 'Кандыдаты на цану';

  @override
  String get noPriceCandidates => 'Цэна не знойдзена; увядзіце яе ўручную.';

  @override
  String get voiceUnavailable =>
      'Галасовае распазнаванне недаступна; увядзіце ўручную.';

  @override
  String get linkToItem => 'Звязаць з таварам';

  @override
  String get splitLine => 'Раздзяліць на дзве часткі';

  @override
  String get mergeWithNext => 'Аб\'яднаць з наступным';

  @override
  String get ocrNoText => 'Тэкст не прачытаны; паспрабуйце яшчэ раз.';

  @override
  String get priceHistoryAction => 'Гісторыя цэн';

  @override
  String get itemsEmptyTitle => 'Пакуль няма тавараў';

  @override
  String get itemsEmptyBody =>
      'Дадайце свой першы тавар — рэальныя цэны вы будзеце ўводзіць тут у краме.';

  @override
  String get addItemTooltip => 'Дадаць тавар';

  @override
  String get unitAdet => 'шт.';

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
  String get unitKutu => 'каробка';

  @override
  String get unitSise => 'бутэля';

  @override
  String get unitKavanoz => 'банка';

  @override
  String get unitDemet => 'вязка';

  @override
  String get unitDuzine => 'дзясятка';

  @override
  String get unitMetre => 'м';

  @override
  String get unitCustom => 'Уласная';

  @override
  String get setReminderAction => 'Усталяваць напамін';

  @override
  String get reminderPermissionDenied =>
      'Для напамінаў патрэбна дазвол на апавяшчэнні. Вы можаце ўключыць яго ў наладах сістэмы.';

  @override
  String get reminderScheduled => 'Напамін усталяваны.';

  @override
  String get reminderCancelled => 'Напамін адменены.';

  @override
  String get reminderTitle => 'Напамін пра пакупкі';

  @override
  String reminderBody(Object title) {
    return 'Час праверыць ваш спіс: $title';
  }

  @override
  String get reminderPickDate => 'Абярыце дату';

  @override
  String get reminderPickTime => 'Абярыце час';

  @override
  String get itemDetailsSection => 'Дэталі';

  @override
  String get priceOptionalHint =>
      'Неабавязкова — рэальную цану вы ўвядзеце ў краме';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Запланавана: $total · $count тавараў';
  }

  @override
  String get proActiveLabel => 'Pro актыўны — дзякуем!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Без рэкламы · Рэзервовая копія: экспарт і імпорт · Штогод';

  @override
  String get proBenefitNoAds => 'Выкарыстанне без рэкламы';

  @override
  String get proBenefitBackup => 'Рэзервовая копія (экспарт/імпарт)';

  @override
  String aboutVersion(Object version) {
    return 'Версія $version';
  }

  @override
  String get navDiscover => 'Адкрыццё';

  @override
  String get shareAction => 'Падзяліцца прыкладаннем';

  @override
  String get rateAction => 'Ацаніць нас';

  @override
  String get aboutOpenRow => 'Пра прыкладанне і адкрыты код';

  @override
  String get voiceAddItemAction => 'Дадаць голасам';

  @override
  String get formatLocaleLabel => 'Фармат лічбаў і валюты';

  @override
  String get formatLocaleSystem =>
      'Фармат сістэмы (лічбы лацінскія; інакш англійская)';

  @override
  String get formatLocaleTr => 'Турэцкі (1.234,56)';

  @override
  String get formatLocaleEn => 'Англійскі (1,234.56)';

  @override
  String get aiToggleTitle => 'Даведка AI';

  @override
  String get aiToggleSubtitle =>
      'Чытае чакі і цэннікі з фота, супастаўляе чакі і ператварае сказы ў спісы. Фота адпраўляюцца толькі для прачытання і ніколі не захоўваюцца.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Вы выкарысталі месячную квоту запытаў AI ($used/$limit). Абнавіце падпіску для большых магчымасцей або працягвайце без AI.';
  }

  @override
  String get aiOffline => 'Няма злучэння — працуем без AI.';

  @override
  String get aiFailed => 'AI зараз недаступны — працуем без яго.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'Прылада';

  @override
  String get quickListAction => 'Дадаць з сказа';

  @override
  String get quickListTitle => 'Хуткі спіс';

  @override
  String get quickListHint =>
      'напр. 1 кг яблыкаў 20, 2 хлебцы, палова кіла сыру';

  @override
  String get quickListConvert => 'Пераўтварыць у спіс';

  @override
  String quickListAdd(int count) {
    return 'Дадаць $count элементаў';
  }

  @override
  String get quickListEmpty =>
      'Элементаў не знойдзена. Паспрабуйце пералічыць іх праз коску.';

  @override
  String get receiptAiMatched =>
      'AI знайшоў супадзенне чека са спісам. Праверце спасылкі і пацвердзіце.';

  @override
  String get receiptNeedsCheck => 'Праверыць гэтае супадзенне';

  @override
  String get receiptDiscountLine => 'Зніжка';

  @override
  String get compareItem => 'Тавар';

  @override
  String get compareEstimated => 'Планавана';

  @override
  String get compareActual => 'Фактычна';

  @override
  String get compareDiff => 'Розніца';

  @override
  String get compareTotal => 'Усяго';

  @override
  String get compareBudget => 'Бюджэт';

  @override
  String get compareNotBought => 'не куплена';

  @override
  String get compareUnplanned => 'не планавалася';

  @override
  String get pricierItems => 'Дарожэй';

  @override
  String get cheaperItems => 'Дзейней';

  @override
  String get compareAction => 'Параўнаць';

  @override
  String get detailsSection => 'Дэталі';

  @override
  String get spendingTitle => 'Расходы';

  @override
  String get spendingAction => 'Расходы';

  @override
  String get spendingMonthTotal => 'Гэта месяц';

  @override
  String get spendingWeekly => 'Штодзённыя расходы';

  @override
  String get spendingMonthly => 'Штомесячныя расходы';

  @override
  String get monthlyLimitTitle => 'Месячны ліміт';

  @override
  String get monthlyLimitHelp => 'Колькі хочаце траціць на закупкі ў месяц?';

  @override
  String get monthlyLimitRemove => 'Выдаліць';

  @override
  String get monthlyLimitSet => 'Усталяваць';

  @override
  String get monthlyLimitChange => 'Змяніць';

  @override
  String get monthlyLimitNone =>
      'Усталяйце месячны ліміт, каб бачыць, колькі засталося.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount вышэй за ліміт';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return '$amount засталося ў гэтым месяцы';
  }

  @override
  String get plansTitle => 'Планы';

  @override
  String get plansHeadline => 'Покупайце разумней з AI';

  @override
  String get plansSubhead =>
      'Супадзенне чекаў, цэннікі і спісы з сказа. Адмяніць можна ў любы час.';

  @override
  String get plansMonthly => 'Штомесяц';

  @override
  String get plansYearly => 'Штогод';

  @override
  String get planFree => 'Бясплатны';

  @override
  String get planFreePrice => 'Заўсёды бясплатна';

  @override
  String get planFreeAi => '10 запытаў AI у месяц';

  @override
  String get planFreeAds => 'Невялікія банерныя рэкламы (няма ў першыя 7 дзён)';

  @override
  String get planCoreFeatures => 'Спісы, цэны, чеки, графікі расходаў';

  @override
  String get plansPerYear => '/ год';

  @override
  String get plansPerMonth => '/ месяц';

  @override
  String get planTrial => 'Бясплатны пробны перыяд';

  @override
  String get planProAi => '100 запытаў AI у месяц';

  @override
  String get planNoAds => 'Без рэкламы';

  @override
  String get planBackup => 'Рэзервовая копія: экспарт і імпорт';

  @override
  String get planMaxAi => '300 запытаў AI у месяц';

  @override
  String get planMaxFamily => 'Для вялікай сямейнай закупкі';

  @override
  String get plansStoreUnavailable => 'Крама зараз недаступная.';

  @override
  String get retryAction => 'Паўтарыць';

  @override
  String get plansPurchaseFailed =>
      'Пакупка не адбылася. Калі ласка, паспрабуйце яшчэ раз.';

  @override
  String get plansRestore => 'Аднавіць пакупкі';

  @override
  String get plansLegal =>
      'Pro аўтаматычна падаўжаецца штогод да скасавання і ўключае 100 запытаў да ШІ штомесяц. Базавая цана — 1 долар ЗША за год без уліку адпаведных падаткаў; перад пацвярджэннем пакупкі праверце канчатковую мясцовую цану і падаткі ў краме. Кіруйце падпіскай або скасуйце яе ў Google Play.';

  @override
  String get planCurrent => 'Бягучая';

  @override
  String get planStartTrial => 'Пачаць бясплатны пробны перыяд';

  @override
  String get planChoose => 'Выбраць';

  @override
  String get plansAction => 'Планы: Pro';

  @override
  String get assistantTitle => 'Асістэнт';

  @override
  String get assistantGreeting => 'Прывітанне! Што хочаце зрабіць?';

  @override
  String get assistantNewList => 'Новы спіс';

  @override
  String get assistantVoiceList => 'Спіс голасам';

  @override
  String get assistantTextList => 'Спіс з сказа';

  @override
  String get assistantScanReceipt => 'Сканаваць чэк';

  @override
  String get assistantSpending => 'Мае выдаткі';

  @override
  String get assistantReceiptHint =>
      'Адкрыйце свой спіс і націсніце значок чэка, каб сканаваць яго.';

  @override
  String get assistantToggleTitle => 'Паказаць асістэнта';

  @override
  String get assistantToggleSubtitle =>
      'Маленькі памочнік у правым ніжнім куце';

  @override
  String get scanPriceLabel => 'Сканаваць цану';

  @override
  String get saveFailed =>
      'Не ўдалося захаваць. Вашы змены захаваны. Паўтарыце спробу.';

  @override
  String get deleteItemConfirm =>
      'Выдаліць гэты пункт і яго запісаныя пакупкі?';

  @override
  String get clearPurchaseConfirm =>
      'Зняць адзнаку з гэтага пункта і выдаліць яго запісаныя пакупкі?';

  @override
  String get reportPdfAction => 'Захаваць PDF-звіт';

  @override
  String get reportNotInvoice =>
      'Агульная інфармацыя пра пакупкі, не падатковы рахунак. Стаўкі податку невядомыя.';

  @override
  String get purchaseVisits => 'Колькасць візітаў у краму';

  @override
  String get purchaseInterval => 'Сярэдняя колькасць дзён паміж пакупкамі';

  @override
  String get purchasedQuantity => 'Колькасць набытага';

  @override
  String get purchaseAnalyticsHint =>
      'Пакупкі не вымяраюць спажыванне. Валюты і адзінкі вымярэння паказваюцца асобна.';

  @override
  String get receiptReplaces =>
      'Для тавараў без цаны яна будзе запоўнена. Тавары, у якіх ужо ёсць рынкавая цана, дадаюцца як асобныя пакупкі.';

  @override
  String get receiptIncompleteHeader =>
      'Уключыце ў наступны здымак назву крамы, дату, час і нумар чэка.';

  @override
  String get receiptIncompleteTail =>
      'Сфатаграфуйце наступную частку так, каб было бачна некалькі тавараў з перакрыццем і выніковая сума.';

  @override
  String get receiptContinuationRejected =>
      'Не ўдалося злучыць гэты здымак з чэкам. Пераздыміце яго з перакрыццем тавараў з таго ж чэка.';

  @override
  String get receiptDraftSaved =>
      'Чэк захаваны як чарнавік. Вы можаце працягнуць пазней.';

  @override
  String get receiptContinueAction => 'Працягнуць чэк';

  @override
  String get receiptDraftsTitle => 'Незавершаныя чэкі';

  @override
  String get receiptDuplicate => 'Гэты чэк ужо дададзены.';

  @override
  String get receiptTotalMismatch =>
      'Сума тавараў не супадае з выніковай сумай чэка. Праверце, ці бачны ўвесь чэк.';

  @override
  String get receiptSaveDraftAction => 'Захаваць на потым';

  @override
  String get receiptResolveLines =>
      'Перад захаваннем прыміце або адхіліце кожны тавар.';

  @override
  String get receiptPartialConfirm =>
      'Будуць дададзены толькі выбраныя тавары. Гэтая квітанцыя будзе пазначана як імпартавана. Працягнуць?';

  @override
  String get voiceUnsupportedLanguage =>
      'Гэтая мова не даступная для голасавога ўводу на гэтым прыладзе. Вы можаце пісаць тэкстам.';

  @override
  String get voiceStopListening => 'Спыніць слуханне';

  @override
  String get keepAwakeFailed =>
      'Не ўдалося захаваць экран уключаным. Калі ласка, паспрабуйце яшчэ раз.';

  @override
  String get purchaseHistoryHint =>
      'Усе завершаныя пакупкі. Вяртанні змяншаюць агульную суму. Даты адносяцца да дня завяршэння пакупак. Адной наведвання недастаткова для разліку сярэдняга інтэрвалу.';

  @override
  String get planLegacyRights =>
      'Дзеючыя падпіскі Pro і Max захоўваюць свае першапачатковыя месячныя ліміты на запыты AI.';

  @override
  String get csvExportAction => 'Экспарт CSV';

  @override
  String get reportSharePdf => 'Абагуліць як PDF';

  @override
  String get reportShareCsv => 'Абагуліць як CSV';

  @override
  String get reportPrintAction => 'Друкаваць';

  @override
  String get backupSizeWarning =>
      'JSON утрымлівае запісы, а не файлы фатаграфій. Ліміт імпарту: 16 МБ.';

  @override
  String get backupImportFailed =>
      'Не ўдалося імпартаваць гэтую рэзервовую копію. Вашы даныя не зменены.';

  @override
  String get backupImported => 'Рэзервовая копія паспяхова імпартавана.';

  @override
  String backupPreviewCounts(Object entries, Object items, Object lists) {
    return '$lists спісы · $items прадукты · $entries пакупкі';
  }

  @override
  String get voiceModelDownloading =>
      'Галасавая мадэль для гэтай мовы спампоўваецца. Паспрабуйце праз хвіліну.';

  @override
  String get historyThisWeek => 'Гэты тыдзень';

  @override
  String get historyProductsSection => 'Купленыя тавары';

  @override
  String get tipReceiptScan =>
      'Адсканіруйце чэк, каб супаставіць цэны са спісам';

  @override
  String get tipVoiceAdd =>
      'Прагаварыце адзін або некалькі тавараў і праверце іх перад даданнем';

  @override
  String get tipShelfCamera => 'Счытайце цану з цэнніка на паліцы камерай';

  @override
  String get tipPlan =>
      'Ваш план: глядзіце падрабязнасці, падпішыцеся або павялічце';

  @override
  String get guideAddBody =>
      'Націсніце +, каб дадаць тавар. Увядзіце плануемую цану зараз, а рыначную — на касе.';

  @override
  String get guideVoiceBody =>
      'Націсніце мікрафон і назавіце тавары, напрыклад: «кілаграм яблыкаў, батон».';

  @override
  String get guideReceiptBody =>
      'Адсканіруйце чэк, каб супаставіць цэны з таварамі вашага спісу.';

  @override
  String get guidePlanBody =>
      'Націсніце значок плана, каб убачыць план, падпісацца або павялічыць.';

  @override
  String get guideNext => 'Добра';

  @override
  String get guideDone => 'Пачаць';

  @override
  String get paletteLabel => 'Каляровая тэма';

  @override
  String get paletteForest => 'Лес';

  @override
  String get paletteOcean => 'Акіян';

  @override
  String get paletteSunset => 'Захад сонца';

  @override
  String get paletteLavender => 'Лаванда';

  @override
  String get darkBlackLabel => 'Чыста чорны ў цёмнай тэме';

  @override
  String get spendingOverview => 'Агляд';

  @override
  String get spendingThisYear => 'Гэты год';

  @override
  String get spendingYearly => 'Выдаткі за год';

  @override
  String get productSpending => 'Выдаткі па таварах';

  @override
  String get spanWeek => 'Тыдзень';

  @override
  String get spanMonth => 'Месяц';

  @override
  String get spanYear => 'Год';

  @override
  String get weeklyLimitTitle => 'Тыднёвы ліміт';

  @override
  String get weeklyLimitHelp =>
      'Колькі вы хочаце траціць на пакупкі за тыдзень?';

  @override
  String get weeklyLimitNone =>
      'Устанавіце тыднёвы ліміт, каб бачыць, колькі засталося.';

  @override
  String weeklyLimitLeft(String amount) {
    return 'На гэтым тыдні засталося $amount';
  }

  @override
  String get shoppingLimitTitle => 'Ліміт на адну пакупку';

  @override
  String get shoppingLimitHelp => 'Новыя спісы пачынаюцца з гэтым бюджэтам.';

  @override
  String get shoppingLimitNone =>
      'Задайце бюджэт па змаўчанні для кожнай новай пакупкі.';

  @override
  String get monthlyReportAction => 'Месячная справаздача';

  @override
  String get reportShoppingColumn => 'Пакупка';

  @override
  String get reportDateColumn => 'Дата';

  @override
  String get planUnavailable => 'Зараз недаступна ў краме';

  @override
  String get demoDataTitle => 'Прыкладныя даныя';

  @override
  String get demoDataLoad => 'Паспрабаваць з прыкладнымі данымі';

  @override
  String get demoDataLoadHelp =>
      'Дадае пакупкі за 12 месяцаў, каб убачыць гісторыю, графікі і гісторыю цэн.';

  @override
  String get demoDataRemove => 'Выдаліць прыкладныя даныя';

  @override
  String get demoDataAdded => 'Прыкладныя даныя дададзены';

  @override
  String get demoDataRemoved => 'Прыкладныя даныя выдалены';

  @override
  String get demoProductApple => 'Яблыкі';

  @override
  String get demoProductBread => 'Хлеб';

  @override
  String get demoProductMilk => 'Малако';

  @override
  String get demoProductCheese => 'Сыр';

  @override
  String get demoProductTomato => 'Памідоры';

  @override
  String get demoProductEggs => 'Яйкі';

  @override
  String get demoProductCoffee => 'Кава';

  @override
  String get demoProductDetergent => 'Мыйны сродак';

  @override
  String get sendAction => 'Send';

  @override
  String get previousMonthAction => 'Previous month';

  @override
  String get nextMonthAction => 'Next month';

  @override
  String get helpSection => 'Дапамога і падтрымка';

  @override
  String get howToUseLabel => 'Як карыстацца';

  @override
  String get guidePricesBody =>
      'Цана ў краме пазначае тавар як набыты; 0 таксама лічыцца. Хатняя цана неабавязковая. Выдаліце цану ў краме, каб зняць пазнаку.';

  @override
  String get shoppingDateLabel => 'Дата пакупак';

  @override
  String get shoppingDateNone => 'Дата не выбрана';

  @override
  String get clearShoppingDateAction => 'Выдаліць дату';

  @override
  String get listSortLabel => 'Парадак спіса';

  @override
  String get listSortDate => 'Дата пакупак';

  @override
  String get listSortAz => 'Назва (А–Я)';

  @override
  String get listSortManual => 'Ручны парадак';

  @override
  String get imageCameraAction => 'Зрабіць фота';

  @override
  String get imageGalleryAction => 'Выбраць з фота';

  @override
  String get imageCaptureFailed =>
      'Не ўдалося адкрыць камеру або фота. Праверце дазвол на доступ і паспрабуйце яшчэ раз.';

  @override
  String get imageRecognitionFailed =>
      'Не ўдалося апрацаваць фота. Паспрабуйце іншае фота.';

  @override
  String get receiptNoProducts =>
      'Тэкст прачытаны, але тавары ў чэку не знойдзены. Уключыце ў фота тавары і агульную суму.';

  @override
  String get keepAwakeOn => 'Экран застаецца ўключаным';

  @override
  String get keepAwakeOff => 'Экран можа выключыцца';

  @override
  String get spanDay => 'Дзень';

  @override
  String get spanCustom => 'Дыяпазон дат';

  @override
  String get reportTotalSpent => 'Усяго выдаткавана';

  @override
  String get reportAddedAt => 'Дададзена';

  @override
  String get reportReceiptNumber => 'Нумар чэка';

  @override
  String get reportPreview => 'Папярэдні прагляд';

  @override
  String get reportShareAction => 'Падзяліцца';

  @override
  String get previousPeriodAction => 'Папярэдні перыяд';

  @override
  String get nextPeriodAction => 'Наступны перыяд';

  @override
  String get reportSaved => 'Справаздача захавана.';

  @override
  String get reportZoom => 'Павялічыць';

  @override
  String planTrialDaysLeft(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days дня засталося',
      many: '$days дзён засталося',
      few: '$days дні засталіся',
      one: '$days дзень застаўся',
    );
    return '$_temp0';
  }

  @override
  String planTrialHoursLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours гадзіны засталося',
      many: '$hours гадзін засталося',
      few: '$hours гадзіны засталіся',
      one: '$hours гадзіна засталася',
    );
    return '$_temp0';
  }

  @override
  String get planTrialEndedTitle => 'Пробны перыяд Pro скончыўся';

  @override
  String get planTrialEndedBody =>
      'Вы можаце бясплатна карыстацца спісамі, ручным уводам і апрацоўкай голасу на прыладзе. Бясплатны план уключае 10 запытаў да AI за каляндарны месяц. Абярыце гадавы Pro, каб атрымліваць 100 запытаў да AI штомесяц, без рэкламы і з рэзервовымі копіямі. Вашы даныя застануцца з вамі.';

  @override
  String get planContinueFree => 'Працягнуць бясплатна';

  @override
  String get supportIdLabel => 'Ідэнтыфікатар падтрымкі';

  @override
  String get supportEmailLabel => 'Падтрымка па электроннай пошце';

  @override
  String get captureTipFirst =>
      'Пачніце са самага верху: назва крамы і дата павінны быць бачныя. Змясціце як мага больш пазіцый, астатняе будзе ў наступным здымку.';

  @override
  String get captureTipContinue =>
      'Той жа чэк: уключыце апошнюю пазіцыю з папярэдняга здымка.';

  @override
  String get captureTipNeverShow => 'Больш не паказваць';

  @override
  String get captureTipOk => 'Зразумела';

  @override
  String get captureTipsSetting => 'Паказваць парады па здымцы чэка';

  @override
  String get receiptReadingProgress => 'Reading the receipt…';

  @override
  String get receiptReadInBackground => 'Continue in background';

  @override
  String get receiptReadDoneTitle => 'Receipt read';

  @override
  String get receiptReadDoneBody => 'Tap to review and save it.';

  @override
  String get receiptReadMoreTitle => 'Photograph the rest of the receipt';

  @override
  String get receiptReadFailedTitle => 'The receipt could not be read';

  @override
  String get listReceiptsSection => 'Чэкі';

  @override
  String get receiptStateComplete => 'Завершаны';

  @override
  String get receiptStateIncomplete => 'Незавершаны';

  @override
  String get receiptStateFailed => 'Памылка';

  @override
  String get receiptStoreUnknown => 'Крама не прачытана';

  @override
  String get receiptDeleteAction => 'Выдаліць чэк';

  @override
  String get receiptDeleteConfirm =>
      'Выдаліць гэты чэк і тавары, якія ён дадаў? Пазней вы зможаце імпартаваць яго зноў.';

  @override
  String get receiptDeleted => 'Чэк выдалены.';

  @override
  String listReceiptsShowAll(int count) {
    return 'Паказаць усе ($count)';
  }

  @override
  String get listReceiptsShowLess => 'Паказаць менш';

  @override
  String receiptDateLabel(String date) {
    return 'Дата чэка: $date';
  }
}
