// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Armenian (`hy`).
class AppLocalizationsHy extends AppLocalizations {
  AppLocalizationsHy([String locale = 'hy']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Պլանավորեք տանը։ Գնումներ կատարեք ըստ պլանի։';

  @override
  String get listsTitle => 'Ցուցակներ';

  @override
  String get listsTabActive => 'Ակտիվ';

  @override
  String get listsTabCompleted => 'Ավարտված';

  @override
  String get listsTabArchived => 'Արխիվացված';

  @override
  String get newListButton => 'Նոր ցուցակ';

  @override
  String get listTitleHint => 'Վերնագիր (ըստ ցանկության)';

  @override
  String get saveButton => 'Պահպանել';

  @override
  String get cancelButton => 'Չեղարկել';

  @override
  String get deleteButton => 'Ջնջել';

  @override
  String get editAction => 'Խմբագրել';

  @override
  String get listDeleted => 'Ցուցակը ջնջված է';

  @override
  String get invalidAmountError => 'Սխալ գումար';

  @override
  String get duplicateAction => 'Կրկնօրինակել';

  @override
  String get archiveAction => 'Արխիվացնել';

  @override
  String get unarchiveAction => 'Հանել արխիվից';

  @override
  String get deleteListConfirm =>
      'Ուզու՞մ եք ջնջել այս ցուցակը։ Դրա պլանավորված առարկաները նույնպես կհեռացվեն։';

  @override
  String get undoButton => 'Վերականգնել';

  @override
  String get searchListHint => 'Փնտրել ցուցակներում';

  @override
  String get currencyLabel => 'Արժույթ';

  @override
  String get budgetLabel => 'Բյուջե (ըստ ցանկության)';

  @override
  String get noteLabel => 'Նշում (ըստ ցանկության)';

  @override
  String get storeLabel => 'Խանութ';

  @override
  String get keepAmountsAction => 'Պահպանել գումարները';

  @override
  String get resetAmountsAction => 'Վերականգնել գումարները';

  @override
  String get currencyChangeWarning =>
      'Արժույթը փոխվում է։ Ի՞նչ պետք է անել գոյություն ունեցող գումարների հետ։';

  @override
  String get listsEmpty =>
      'Դեռևս չկան ցուցակներ։ Ստեղծեք ձեր առաջին գնումների պլանը։';

  @override
  String get statusDraft => 'Նախագիծ';

  @override
  String get statusPlanned => 'Պլանավորված';

  @override
  String get statusShopping => 'Գնումների ընթացքում';

  @override
  String get statusCompleted => 'Ավարտված';

  @override
  String get statusArchived => 'Արխիվացված';

  @override
  String autoListTitle(String date) {
    return '$date գնումներ';
  }

  @override
  String get itemFormTitle => 'Ավելացնել առարկա';

  @override
  String get itemNameLabel => 'Առարկայի անուն';

  @override
  String get brandLabel => 'Բրենդ / տարբերակ (ըստ ցանկության)';

  @override
  String get categoryLabel => 'Կատեգորիա';

  @override
  String get quantityLabel => 'Քանակ';

  @override
  String get unitLabel => 'Միավոր';

  @override
  String get pricingModeLabel => 'Գնի մուտքագրում';

  @override
  String get pricingModeUnitPrice => 'Միավորի գին';

  @override
  String get pricingModeLineTotal => 'Ընդհանուր գումար';

  @override
  String get plannedPriceLabel => 'Պլանավորված գին';

  @override
  String lineTotalCalculated(String value) {
    return 'Ընդհանուր գումար՝ $value';
  }

  @override
  String get requiredItemToggle => 'Պարտադիր առարկա';

  @override
  String get maxPriceLabel => 'Մաքսիմալ ընդունելի գին (ըստ ցանկության)';

  @override
  String get itemNoteLabel => 'Նշում (ըստ ցանկության)';

  @override
  String get categoryProduce => 'Պտուղներ և բանջարեղեն';

  @override
  String get categoryDairy => 'Կաթնամթերք';

  @override
  String get categoryMeat => 'Մսամթերք';

  @override
  String get categoryBakery => 'Հացաբուլկեղեն';

  @override
  String get categoryDrinks => 'Խմիչքներ';

  @override
  String get categoryCleaning => 'Մաքրում';

  @override
  String get categoryPersonalCare => 'Անձնական խնամք';

  @override
  String get categoryHome => 'Տնային';

  @override
  String get categoryOther => 'Այլ';

  @override
  String get invalidQuantityError => 'Սխալ քանակ';

  @override
  String get invalidPriceError => 'Սխալ գին';

  @override
  String get invalidNameError => 'Մուտքագրեք անուն';

  @override
  String unitPriceCalculated(String value) {
    return 'Միավոր գինը՝ $value';
  }

  @override
  String get shoppingTitle => 'Գնումների ռեժիմ';

  @override
  String get summaryPlannedTotal => 'Պլանավորված';

  @override
  String get summaryInCart => 'Կոռզայում';

  @override
  String get summaryRemainingPlan => 'Մնացած պլանը';

  @override
  String get summaryProjected => 'Մոտավոր վճարում';

  @override
  String get summaryBudgetRemaining => 'Բյուջեի մնացորդ';

  @override
  String get summaryBudgetOver => 'Բյուջեից դուրս';

  @override
  String itemsProgress(String done, String total) {
    return '$done/$total ապրանք';
  }

  @override
  String get filterAll => 'Բոլորը';

  @override
  String get filterToBuy => 'Գնելու';

  @override
  String get filterInCart => 'Կոռզայում';

  @override
  String get filterNotFound => 'Գտնված չէ';

  @override
  String get filterRequired => 'Անհրաժեշտ';

  @override
  String get quickEntryTitle => 'Իրական գին';

  @override
  String get actualQuantityLabel => 'Իրական քանակ';

  @override
  String get actualPriceLabel => 'Իրական գին';

  @override
  String get discountLabel => 'Հատկացում (ըստ ցանկության)';

  @override
  String get alternativeNameLabel =>
      'Այլընտրանքային ապրանքի անուն (ըստ ցանկության)';

  @override
  String get savePurchaseButton => 'Ավելացնել կոռզա';

  @override
  String get unplannedAddButton => 'Ավելացնել ոչ պլանավորված ապրանք';

  @override
  String get statusPending => 'Չէր վերցվել';

  @override
  String get statusInCart => 'Կոռզայում';

  @override
  String get statusNotFound => 'Գտնված չէ';

  @override
  String get statusGaveUp => 'Հրաժարվել ենք';

  @override
  String get statusAlternative => 'Ընտրվել է այլընտրանք';

  @override
  String get keepScreenAwake => 'Պահել էկրանը միացված';

  @override
  String get finishShopping => 'Ավարտել գնումները';

  @override
  String get completionWarning =>
      'Կան բաց թողնված կամ ստուգված չգրառումներ։ Դուք կարող եք ավարտել. արդյունքում նշված կլինեն դրանք։';

  @override
  String get continueShoppingButton => 'Շարունակել գնումները';

  @override
  String get resultTitle => 'Արդյունք';

  @override
  String get summarySection => 'Ամփոփում';

  @override
  String get plannedTotalLabel => 'Պլանավորված ընդհանուր';

  @override
  String get actualTotalLabel => 'Իրական ընդհանուր';

  @override
  String get varianceLabel => 'Տարբերություն';

  @override
  String get varianceNotComputable => 'Հնարավոր չէ հաշվել';

  @override
  String get budgetStatusLabel => 'Բյուջե';

  @override
  String get savingsLabel => 'Պլանից ցածր';

  @override
  String get overspendLabel => 'Պլանից բարձր';

  @override
  String get unplannedTotalLabel => 'Ոչ պլանավորված ընդհանուր';

  @override
  String get unpurchasedLabel => 'Պլանավորված, բայց չի գնվել';

  @override
  String get totalDiscountLabel => 'Ընդհանուր հատկացումներ';

  @override
  String get accuracyLabel => 'Գնահատման ճշգրտություն';

  @override
  String get groupsSection => 'Ապրանքներ';

  @override
  String get groupPricier => 'Գնով ավելի թանկ, քան պլանավորված էր';

  @override
  String get groupCheaper => 'Գնով ավելի էժան, քան պլանավորված էր';

  @override
  String get groupClose => 'Մոտ է գնահատականին';

  @override
  String get groupNotTaken => 'Պլանավորված, բայց չի վերցվել';

  @override
  String get groupUnplanned => 'Գնվել է առանց պլանի';

  @override
  String get groupQuantityChanged => 'Փոխվել է քանակը';

  @override
  String get groupUnverified => 'Ստուգված չէ';

  @override
  String get plannedQtyLabel => 'Պլանավորված քանակ';

  @override
  String get actualQtyLabel => 'Իրական քանակ';

  @override
  String get plannedUnitPriceLabel => 'Պլանավորված միավոր գին';

  @override
  String get actualUnitPriceLabel => 'Իրական միավոր գին';

  @override
  String get lineVarianceLabel => 'Տողի տարբերություն';

  @override
  String get discountEffectLabel => 'Հատկացման ազդեցություն';

  @override
  String get notBoughtMark => 'չի գնվել';

  @override
  String get noPurchasesNote => 'Գնումներ չեն գրանցվել։';

  @override
  String get navHome => 'Գլխավոր';

  @override
  String get navLists => 'Ցուցակներ';

  @override
  String get navHistory => 'Պատմություն';

  @override
  String get navSettings => 'Կարգավորումներ';

  @override
  String get homeEmptyTitle => 'Պլանավորեք ձեր գնումները';

  @override
  String get homeEmptyBody =>
      'Ստեղծեք ձեր առաջին ցուցակը և համեմատեք պլանավորված ու իրական արժեքները։';

  @override
  String get homeActiveSection => 'Ակտիվ ցուցակներ';

  @override
  String get homeCompletedSection => 'Վերջերս ավարտված';

  @override
  String get homeMonthlySection => 'Այս ամիս';

  @override
  String get monthPlannedLabel => 'Պլանավորված';

  @override
  String get monthActualLabel => 'Իրական';

  @override
  String get monthVarianceLabel => 'Տարբերություն';

  @override
  String get continueShoppingLabel => 'Շարունակել գնումները';

  @override
  String get historyEmpty =>
      'Դեռևս չկան ավարտված գնումներ։ Ձեր պատմությունն ու վերլուծությունները կհայտնվեն այստեղ։';

  @override
  String get aboutTabTitle => 'NShoptor-ի մասին';

  @override
  String get aboutBody =>
      'NShoptor-ը Crazy Penguin-ի կողմից։ Առցանց/առցանց չէ գնումների պլանավորիչ։ Լիցենզավորված է GPL-3.0-ով։';

  @override
  String get startShoppingLabel => 'Սկսել գնումները';

  @override
  String get finishAndSeeResult => 'Ավարտել և տեսնել արդյունքը';

  @override
  String get settingsTitle => 'Կարգավորումներ';

  @override
  String get languageLabel => 'Լեզու';

  @override
  String get languageSystem => 'Համակարգ';

  @override
  String get languageTr => 'Թուրքերեն';

  @override
  String get languageEn => 'Անգլերեն';

  @override
  String get themeLabel => 'Թեմա';

  @override
  String get themeSystem => 'Համակարգ';

  @override
  String get themeLight => 'Բաց';

  @override
  String get themeDark => 'Մութ';

  @override
  String get defaultCurrencyLabel => 'Ենթադրյալ արժույթ';

  @override
  String get defaultUnitLabel => 'Ենթադրյալ չափման միավոր';

  @override
  String get keepAwakeLabel =>
      'Պահպանել էկրանի ակտիվությունը գնումների ընթացքում';

  @override
  String get backupSection => 'Պատճենահանում';

  @override
  String get exportBackupLabel => 'Արտահանել պատճենահանումը';

  @override
  String get importBackupLabel => 'Ներմուծել պատճենահանումը';

  @override
  String get mergeImportLabel => 'Միախառնել ներկայիս տվյալների հետ';

  @override
  String get separateImportLabel => 'Ներմուծել որպես առանձին պատճեն';

  @override
  String get importCancelled => 'Ներմուծումը չեղարկվել է։';

  @override
  String get backupExported => 'Պատճենահանումը հաջողությամբ արտահանվել է։';

  @override
  String get backupSizeWarning =>
      'Մեծ պատճենահանում․ ֆայլը կարող է լինել մեծ։ Ցանկանո՞ւմ եք ներառել նաև լուսանկարները։';

  @override
  String get deleteAllSection => 'Վտանգավիր գոտի';

  @override
  String get deleteAllLabel => 'Ջնջել բոլոր տվյալները';

  @override
  String get deleteAllConfirm =>
      'Սա կջնջի բոլոր ցուցակները, պատմությունը, զեկույցների լուսանկարները և գները։ Ձեր կողմից արտահանված ֆայլերը կմնան ձեր սարքում։ Շարունակե՞լ։';

  @override
  String get deleteAllConfirm2 =>
      'Արդյո՞ք լիովին համոզված եք։ Այս գործողությունը հետ չի կարող լինել։';

  @override
  String get cancelAction => 'Չեղարկել';

  @override
  String get confirmDelete => 'Մշտապես ջնջել';

  @override
  String get dataDeleted => 'Բոլոր տեղական տվյալները ջնջվել են։';

  @override
  String get privacyInfoLabel => 'Գաղտնիություն';

  @override
  String get privacyInfoBody =>
      'Ձեր ցուցակները, գները, զեկույցները և լուսանկարները մնում են ձեր սարքում։ Լուսանկարները և ձայնը երբեք դուրս չեն գալիս։ Երբ AI օգնությունը միացված է, միայն տեքստը (օրինակ՝ զեկույցի տողերը կամ ձեր ասածը) է ուղարկվում մեր սերվեր՝ մշակման համար և չի պահվում։';

  @override
  String get aboutSection => 'Մասին';

  @override
  String get aboutPublisher => 'Հրատարակիչ՝ Crazy Penguin';

  @override
  String get aboutLicenses => 'Լիցենզիաներ (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Խոսքի մուտքագրում';

  @override
  String get voiceStatusUnknown => 'Ծառայություն՝ ստուգված չէ';

  @override
  String get permissionsLabel => 'Թույլտվություններ';

  @override
  String get permissionsBody =>
      'Տեսախցիկը, միկրոֆոնը և ծանուցումները խնդրվում են միայն այն դեպքում, երբ դուք իրականում օգտագործում եք այդ հատկանիշները։';

  @override
  String get unitsSection => 'Ենթադրյալներ';

  @override
  String get roundingNote =>
      'Գումարի կլորացումը հետևում է մեկ կանոնի՝ կեսերը կլորացվում են զրոյից հեռու, կիրառվում է մեկ անգամ՝ Գումարի փոխարկման ժամանակ։';

  @override
  String get voiceInputTitle => 'Խոսքի մուտքագրում';

  @override
  String get voiceStartListening => 'Սկսել լսելը';

  @override
  String get voiceTranscriptLabel => 'Տեքստային տարբերակ';

  @override
  String get parseAction => 'Վերլուծել';

  @override
  String get receiptReviewTitle => 'Զեկույցի վերանայում';

  @override
  String get receiptTotal => 'Վավերացման գումար';

  @override
  String get receiptTotalUnknown => 'Գումարը չի հայտնաբերվել';

  @override
  String get receiptDiff => 'Տարբերություն';

  @override
  String get acceptLine => 'Հաստատել տողը';

  @override
  String get ignoreLine => 'Անտեսել տողը';

  @override
  String get receiptLineActions => 'Ուղղորդել ապրանքին, բաժանել կամ անտեսել';

  @override
  String get receiptCommit => 'Հաստատել բոլորը';

  @override
  String get receiptCommitted => 'Վավերացումը կիրառված է։';

  @override
  String get priceHistoryTitle => 'Գների պատմություն';

  @override
  String get noObservations => 'Գների դիտարկումներ դեռ չկան';

  @override
  String get templatesSection => 'Շաբլոններ';

  @override
  String get templateHint => 'Ստեղծել նոր պլան նախկին գնումներից';

  @override
  String get scanReceiptAction => 'Սկանավորել վավերացումը';

  @override
  String get shelfLabelAction => 'Գինը տախտակակալից';

  @override
  String get priceCandidatesTitle => 'Գների թեկնածուներ';

  @override
  String get noPriceCandidates => 'Գին չի գտնվել; մուտքագրեք ձեռքով։';

  @override
  String get voiceUnavailable =>
      'Ձայնային ճանաչումը հասանելի չէ; մուտքագրեք ձեռքով։';

  @override
  String get linkToItem => 'Ուղղորդել ապրանքին';

  @override
  String get splitLine => 'Բաժանել երկուսի';

  @override
  String get mergeWithNext => 'Միավորել հաջորդի հետ';

  @override
  String get ocrNoText => 'Տեքստ չի կարդացվել; փորձեք նորից։';

  @override
  String get priceHistoryAction => 'Գների պատմություն';

  @override
  String get itemsEmptyTitle => 'Դեռ ապրանքներ չկան';

  @override
  String get itemsEmptyBody =>
      'Ավելացրեք ձեր առաջին ապրանքը — խանութում այստեղ կմուտքագրեք իրական գները։';

  @override
  String get addItemTooltip => 'Ավելացնել ապրանք';

  @override
  String get unitAdet => 'հատ';

  @override
  String get unitKilogram => 'կգ';

  @override
  String get unitGram => 'գ';

  @override
  String get unitLitre => 'լ';

  @override
  String get unitMililitre => 'մլ';

  @override
  String get unitPaket => 'փաթեթ';

  @override
  String get unitKutu => 'կաթոց';

  @override
  String get unitSise => 'շիշ';

  @override
  String get unitKavanoz => 'կարաս';

  @override
  String get unitDemet => 'կապ';

  @override
  String get unitDuzine => 'տասներկու';

  @override
  String get unitMetre => 'մ';

  @override
  String get unitCustom => 'Հատուկ';

  @override
  String get setReminderAction => 'Սահմանել հիշեցում';

  @override
  String get reminderPermissionDenied =>
      'Հիշեցումների համար անհրաժեշտ է ծանուցումների թույլտվություն։ Կարող եք այն միացնել համակարգի կարգավորումներում։';

  @override
  String get reminderScheduled => 'Հիշեցումը սահմանված է։';

  @override
  String get reminderCancelled => 'Հիշեցումը հեռացված է։';

  @override
  String get reminderTitle => 'Գնումների հիշեցում';

  @override
  String reminderBody(Object title) {
    return 'Ժամանակն է ստուգել ձեր ցանկը՝ $title';
  }

  @override
  String get reminderPickDate => 'Ընտրել ամսաթիվ';

  @override
  String get reminderPickTime => 'Ընտրել ժամ';

  @override
  String get itemDetailsSection => 'Մանրամասներ';

  @override
  String get priceOptionalHint =>
      'Ըստ ցանկության — իրական գինը կմուտքագրեք խանութում';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Պլանավորված՝ $total · $count ապրանք';
  }

  @override
  String get proActiveLabel => 'Pro-ն ակտիվ է — շնորհակալություն!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Առանց գովազդի, ավելի շատ AI, պահեստավորում · փոքր ամսական գնից';

  @override
  String get proBenefitNoAds => 'Առանց գովազդի փորձառություն';

  @override
  String get proBenefitBackup => 'Պահեստավորում (արտահանում/ներմուծում)';

  @override
  String aboutVersion(Object version) {
    return 'Տարբերակ $version';
  }

  @override
  String get navDiscover => 'Գտնել';

  @override
  String get shareAction => 'Կիսվել հավելվածով';

  @override
  String get rateAction => 'Գնահատել մեզ';

  @override
  String get aboutOpenRow => 'Մասին և բաց կոդ';

  @override
  String get voiceAddItemAction => 'Ավելացնել ձայնով';

  @override
  String get formatLocaleLabel => 'Թվերի և արժույթի ձևաչափ';

  @override
  String get formatLocaleSystem => 'Համակարգ (հետևում է հավելվածի լեզվին)';

  @override
  String get formatLocaleTr => 'Թուրքերեն (1.234,56)';

  @override
  String get formatLocaleEn => 'Անգլերեն (1,234.56)';

  @override
  String get aiToggleTitle => 'AI օգնություն';

  @override
  String get aiToggleSubtitle =>
      'Համապատասխանեցնում է զեկույցները, կարդում է գների պիտակները և նախադասությունները վերածում ցուցակների։ Ֆոտոները և ձայնը մնում են ձեր սարքում; մշակվում է միայն տեքստը։';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Դուք օգտագործել եք այս ամսվա AI հարցումները ($used/$limit)։ Առաջընթաց ունենալու համար բարձրացրեք պլանը կամ շարունակեք առանց AI-ի։';
  }

  @override
  String get aiOffline => 'Միացում չկա — շարունակում ենք առանց AI-ի։';

  @override
  String get aiFailed =>
      'AI-ն այս պահին հասանելի չէ — շարունակում ենք առանց դրա։';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'Սարք';

  @override
  String get quickListAction => 'Ավելացնել նախադասությունից';

  @override
  String get quickListTitle => 'Արագ ցուցակ';

  @override
  String get quickListHint => 'օր․՝ 1 կգ խնձոր 20, 2 հաց, կես կգ պանիր';

  @override
  String get quickListConvert => 'Վերածել ցուցակի';

  @override
  String quickListAdd(int count) {
    return 'Ավելացնել $count տարր';
  }

  @override
  String get quickListEmpty =>
      'Տարրեր չեն գտնվել։ Փորձեք թվարկել ստորակետերով բաժանված։';

  @override
  String get receiptAiMatched =>
      'AI-ն համապատասխանեցրել է զեկույցը ձեր ցուցակին։ Ստուգեղ հղումները և հաստատեք։';

  @override
  String get receiptNeedsCheck => 'Ստուգել այս համապատասխանությունը';

  @override
  String get receiptDiscountLine => 'Զեղչ';

  @override
  String get compareItem => 'Տարր';

  @override
  String get compareEstimated => 'Գնահատական';

  @override
  String get compareActual => 'Իրական';

  @override
  String get compareDiff => 'Տարբերություն';

  @override
  String get compareTotal => 'Ընդհանուր';

  @override
  String get compareBudget => 'Բյուջե';

  @override
  String get compareNotBought => 'չի գնվել';

  @override
  String get compareUnplanned => 'չի պլանավորվել';

  @override
  String get pricierItems => 'Թանկ է';

  @override
  String get cheaperItems => 'Արժեքավոր';

  @override
  String get compareAction => 'Համեմատել';

  @override
  String get detailsSection => 'Մանրամասներ';

  @override
  String get spendingTitle => 'Ծախսեր';

  @override
  String get spendingAction => 'Ծախսեր';

  @override
  String get spendingMonthTotal => 'Այս ամիս';

  @override
  String get spendingWeekly => 'Շաբաթական ծախսեր';

  @override
  String get spendingMonthly => 'Ամսական ծախսեր';

  @override
  String get monthlyLimitTitle => 'Ամսական սահմանաչափ';

  @override
  String get monthlyLimitHelp =>
      'Քանի՞ գումար եք ցանկանում ծախսել շاپավորումների վրա ամիսը մեկ:';

  @override
  String get monthlyLimitRemove => 'Հեռացնել';

  @override
  String get monthlyLimitSet => 'Սահմանել';

  @override
  String get monthlyLimitChange => 'Փոխել';

  @override
  String get monthlyLimitNone =>
      'Սահմանեք ամսական սահմանաչափ՝ տեսնելու, թե քանի է մնացել։';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount սահմանաչափից բարձր';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return '$amount մնաց այս ամսվա համար';
  }

  @override
  String get plansTitle => 'Պլաններ';

  @override
  String get plansHeadline => 'Գնեք խելացիորեն AI-ով';

  @override
  String get plansSubhead =>
      'Զեկույցների համապատասխանեցում, գների պիտակներ և ցուցակներ նախադասությունից։ Կարող եք չեղարկել ցանկացած պահի։';

  @override
  String get plansMonthly => 'Ամսական';

  @override
  String get plansYearly => 'Տարեկան';

  @override
  String get planFree => 'Անվճար';

  @override
  String get planFreePrice => 'Հավերժ անվճար';

  @override
  String get planFreeAi => '15 AI հարցում ամիսը';

  @override
  String get planFreeAds => 'Փոքր բաններ (առաջին 7 օրերին՝ առանց)';

  @override
  String get planCoreFeatures =>
      'Ցուցակներ, գներ, զեկույցներ, ծախսերի գրաֆիկներ';

  @override
  String get plansPerYear => '/ տարի';

  @override
  String get plansPerMonth => '/ ամիս';

  @override
  String get planTrial => '7 օր անվճար';

  @override
  String get planProAi => '200 AI հարցում ամիսը';

  @override
  String get planNoAds => 'Առանց գովազդի';

  @override
  String get planBackup => 'Պատճենահանում և ներմուծում';

  @override
  String get planMaxAi => '1000 AI հարցում ամիսը';

  @override
  String get planMaxFamily => 'Ընտանեկան խոշոր գնումների համար';

  @override
  String get plansStoreUnavailable => 'Խանութը այս պահին հասանելի չէ:';

  @override
  String get retryAction => 'Կրկին փորձել';

  @override
  String get plansPurchaseFailed =>
      'Գնումը չհաջողվեց: Խնդրում ենք կրկին փորձել:';

  @override
  String get planLifetimeTitle => 'Առանց գովազդի միշտ';

  @override
  String get planLifetimeSubtitle =>
      'Մեկանգամյա վճարում. առանց գովազդի, պատճենահանում; AI-ն մնում է անվճար սահմանաչափով';

  @override
  String get plansRestore => 'Վերականգնել գնումները';

  @override
  String get plansLegal =>
      'Ուղեկցումները ավտոմատ երկարաձգվում են մինչև չեղարկումը: Կարող եք ցանկացած պահի չեղարկել Google Play › Վճարումներ և ուղեկցումներ բաժնում: Գները ներառում են Google Play-ի կողմից ցուցադրվող հարկերը:';

  @override
  String get planCurrent => 'Ընթացիկ';

  @override
  String get planStartTrial => 'Սկսել 7-օրյա անվճար փորձաշրջանը';

  @override
  String get planChoose => 'Ընտրել';

  @override
  String get plansAction => 'Պլաններ՝ Pro և Max';

  @override
  String get assistantTitle => 'Ասիստենտ';

  @override
  String get assistantGreeting => 'Ողջույն! Ինչպե՞ս կարող եմ օգնել:';

  @override
  String get assistantNewList => 'Նոր ցանկ';

  @override
  String get assistantVoiceList => 'Ցանկ ձայնով';

  @override
  String get assistantTextList => 'Ցանկ նախադասությունից';

  @override
  String get assistantScanReceipt => 'Սկանել հաշիվ';

  @override
  String get assistantSpending => 'Իմ ծախսերը';

  @override
  String get assistantReceiptHint =>
      'Բացեք ձեր ցանկը և սեղմեք հաշվի իկոնկան՝ այն սկանելու համար:';

  @override
  String get assistantToggleTitle => 'Ցույց տալ ասիստենտը';

  @override
  String get assistantToggleSubtitle => 'Փոքրիկ օգնականը աջ ներքևի անկյունում';

  @override
  String get scanPriceLabel => 'Սկանավորեք գնի փոստը';
}
