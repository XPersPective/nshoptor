// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Burmese (`my`).
class AppLocalizationsMy extends AppLocalizations {
  AppLocalizationsMy([String locale = 'my']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'အိမ်မှာစီမံ။ စီမံထားသလိုဝယ်ယူပါ။';

  @override
  String get listsTitle => 'စာရင်းများ';

  @override
  String get listsTabActive => 'လက်ရှိ';

  @override
  String get listsTabCompleted => 'ပြီးဆုံး';

  @override
  String get listsTabArchived => 'သိုလှောင်ထား';

  @override
  String get newListButton => 'စာရင်းအသစ်';

  @override
  String get listTitleHint => 'ခေါင်းစဉ် (ရွေးချယ်စရာ)';

  @override
  String get saveButton => 'သိမ်းဆည်းမည်';

  @override
  String get cancelButton => 'ပယ်ဖျက်မည်';

  @override
  String get deleteButton => 'ဖျက်မည်';

  @override
  String get editAction => 'တည်းဖြတ်မည်';

  @override
  String get listDeleted => 'စာရင်းကို ဖျက်ပြီးပါပြီ';

  @override
  String get invalidAmountError => 'ပမာဏ မမှန်ကန်ပါ';

  @override
  String get duplicateAction => 'ထပ်ကူးမည်';

  @override
  String get archiveAction => 'သိုလှောင်မည်';

  @override
  String get unarchiveAction => 'သိုလှောင်မှု ပြန်ဖျက်မည်';

  @override
  String get deleteListConfirm =>
      'ဤစာရင်းကို ဖျက်မလား? စီမံထားသော အကြောင်းအရာများလည်း ပါဝင်ဖျက်သွားပါမည်။';

  @override
  String get undoButton => 'ပြန်လုပ်မည်';

  @override
  String get searchListHint => 'စာရင်းများ ရှာဖွေရန်';

  @override
  String get currencyLabel => 'ငွေကြေး';

  @override
  String get budgetLabel => 'ဘတ်ဂျက် (ရွေးချယ်စရာ)';

  @override
  String get noteLabel => 'မှတ်ချက် (ရွေးချယ်စရာ)';

  @override
  String get storeLabel => 'ဆိုင်';

  @override
  String get keepAmountsAction => 'ပမာဏများ ထားမည်';

  @override
  String get resetAmountsAction => 'ပမာဏများ ပြန်လည်သတ်မှတ်မည်';

  @override
  String get currencyChangeWarning =>
      'ငွေကြေး ပြောင်းလဲနေသည်။ လက်ရှိ ပမာဏများကို ဘာလုပ်မလဲ?';

  @override
  String get listsEmpty =>
      'စာရင်း မရှိသေးပါ။ ပထမဆုံး ဝယ်ယူရေး စီမံကိန်းကို ဖန်တီးပါ။';

  @override
  String get statusDraft => 'နမူနာ';

  @override
  String get statusPlanned => 'စီမံထားသည်';

  @override
  String get statusShopping => 'ဝယ်ယူနေသည်';

  @override
  String get statusCompleted => 'ပြီးဆုံးသည်';

  @override
  String get statusArchived => 'သိုလှောင်ထားသည်';

  @override
  String autoListTitle(String date) {
    return '$date ဝယ်ယူရေး';
  }

  @override
  String get itemFormTitle => 'အကြောင်းအရာ ထည့်ရန်';

  @override
  String get itemNameLabel => 'အကြောင်းအရာ နာမည်';

  @override
  String get brandLabel => 'အမှတ်တံဆိပ် / ကွဲပြားမှု (ရွေးချယ်စရာ)';

  @override
  String get categoryLabel => 'အမျိုးအစား';

  @override
  String get quantityLabel => 'ပမာဏ';

  @override
  String get unitLabel => 'ယူနစ်';

  @override
  String get pricingModeLabel => 'ဈေးနှုန်း ထည့်သွင်းခြင်း';

  @override
  String get pricingModeUnitPrice => 'ယူနစ်ဈေးနှုန်း';

  @override
  String get pricingModeLineTotal => 'စုစုပေါင်း';

  @override
  String get plannedPriceLabel => 'စီမံထားသော ဈေးနှုန်း';

  @override
  String lineTotalCalculated(String value) {
    return 'စုစုပေါင်း: $value';
  }

  @override
  String get requiredItemToggle => 'လိုအပ်သော အကြောင်းအရာ';

  @override
  String get maxPriceLabel => 'လက်ခံနိုင်သော အမြင့်ဆုံးဈေးနှုန်း (ရွေးချယ်စရာ)';

  @override
  String get itemNoteLabel => 'မှတ်ချက် (ရွေးချယ်စရာ)';

  @override
  String get categoryProduce => 'သီးနှံနှင့် အသီးအရွက်';

  @override
  String get categoryDairy => 'ဒိန်ခဲနှင့် ဒိန်ခဲထွက်ကုန်များ';

  @override
  String get categoryMeat => 'အသား';

  @override
  String get categoryBakery => 'အုန်းနို့နှင့် ဂျုံထွက်ကုန်များ';

  @override
  String get categoryDrinks => 'အချိုရည်များ';

  @override
  String get categoryCleaning => 'သန့်ရှင်းရေး';

  @override
  String get categoryPersonalCare => 'ကိုယ်ကျင့်တရား ကာကွယ်ရေး';

  @override
  String get categoryHome => 'အိမ်';

  @override
  String get categoryOther => 'အခြား';

  @override
  String get invalidQuantityError => 'ပမာဏ မမှန်ကန်ပါ';

  @override
  String get invalidPriceError => 'ဈေးနှုန်း မမှန်ကန်ပါ';

  @override
  String get invalidNameError => 'နာမည် တစ်ခုခု ထည့်သွင်းပါ';

  @override
  String unitPriceCalculated(String value) {
    return 'ယူနစ်ဈေးနှုန်း: $value';
  }

  @override
  String get shoppingTitle => 'ဆိုင်ဝယ်စရာ';

  @override
  String get summaryPlannedTotal => 'စီမံထားသော စုစုပေါင်း';

  @override
  String get summaryInCart => 'ကတ်ထဲတွင်ရှိသည်';

  @override
  String get summaryRemainingPlan => 'ကျန်ရှိသော စီမံချက်';

  @override
  String get summaryProjected => 'ခန့်မှန်း ငွေရှင်းလင်းမှု';

  @override
  String get summaryBudgetRemaining => 'ဘတ်ဂျက် ကျန်ရှိသည်';

  @override
  String get summaryBudgetOver => 'ဘတ်ဂျက် ကျော်လွန်';

  @override
  String itemsProgress(String done, String total) {
    return '$total ခုအနက် $done ခု ပြီးဆုံး';
  }

  @override
  String get filterAll => 'အားလုံး';

  @override
  String get filterToBuy => 'ဝယ်ရန်';

  @override
  String get filterInCart => 'ကတ်ထဲတွင်ရှိသည်';

  @override
  String get filterNotFound => 'မတွေ့ပါ';

  @override
  String get filterRequired => 'လိုအပ်သည်';

  @override
  String get quickEntryTitle => 'တကယ့်ဈေးနှုန်း';

  @override
  String get actualQuantityLabel => 'တကယ့် ပမာဏ';

  @override
  String get actualPriceLabel => 'တကယ့်ဈေးနှုန်း';

  @override
  String get discountLabel => 'လျှော့ဈေး (ရွေးချယ်စရာ)';

  @override
  String get alternativeNameLabel => 'အစားထိုး ထုတ်ကုန် အမည် (ရွေးချယ်စရာ)';

  @override
  String get savePurchaseButton => 'ကတ်ထဲသို့ ထည့်မည်';

  @override
  String get unplannedAddButton => 'စီမံမထားသော ပစ္စည်း ထည့်မည်';

  @override
  String get statusPending => 'ယူရန် ကျန်ရှိ';

  @override
  String get statusInCart => 'ကတ်ထဲတွင်ရှိသည်';

  @override
  String get statusNotFound => 'မတွေ့ပါ';

  @override
  String get statusGaveUp => 'စွန့်လွှတ်ပြီး';

  @override
  String get statusAlternative => 'အစားထိုး ဝယ်ယူပြီး';

  @override
  String get keepScreenAwake => 'စcrin မိတ်မထားရ';

  @override
  String get finishShopping => 'ဆိုင်ဝယ်ခြင်း ပြီးဆုံး';

  @override
  String get completionWarning =>
      'ပျောက်နေသော သို့မဟုတ် စစ်ဆေးမထားသော မှတ်တမ်းများ ရှိနေသည်။ ဆက်လက်ပြီးဆုံးနိုင်သော်လည်း ရလဒ်တွင် ၎င်းတို့ကို ဖော်ပြပါမည်။';

  @override
  String get continueShoppingButton => 'ဆက်လက်ဝယ်ယူမည်';

  @override
  String get resultTitle => 'ရလဒ်';

  @override
  String get summarySection => 'အနှစ်ချုပ်';

  @override
  String get plannedTotalLabel => 'စီမံထားသော စုစုပေါင်း';

  @override
  String get actualTotalLabel => 'တကယ့် စုစုပေါင်း';

  @override
  String get varianceLabel => 'ကွာခြားချက်';

  @override
  String get varianceNotComputable => 'တွက်ချက်၍ မရနိုင်ပါ';

  @override
  String get budgetStatusLabel => 'ဘတ်ဂျက်';

  @override
  String get savingsLabel => 'စီမံချက်ထက် လျော့နည်း';

  @override
  String get overspendLabel => 'စီမံချက်ထက် ကျော်လွန်';

  @override
  String get unplannedTotalLabel => 'စီမံမထားသော စုစုပေါင်း';

  @override
  String get unpurchasedLabel => 'စီမံထားသော်လည်း မဝယ်ရသေး';

  @override
  String get totalDiscountLabel => 'စုစုပေါင်း လျှော့ဈေး';

  @override
  String get accuracyLabel => 'ခန့်မှန်း တိကျမှု';

  @override
  String get groupsSection => 'ပစ္စည်းများ';

  @override
  String get groupPricier => 'စီမံထားသည်ထက် ပိုကြီး';

  @override
  String get groupCheaper => 'စီမံထားသည်ထက် ပိုသက်သာ';

  @override
  String get groupClose => 'ခန့်မှန်းချက်နှင့် နီးစပ်';

  @override
  String get groupNotTaken => 'စီမံထားသော်လည်း မဝယ်ရသေး';

  @override
  String get groupUnplanned => 'စီမံချက်မရှိဘဲ ဝယ်ယူခဲ့သည်';

  @override
  String get groupQuantityChanged => 'ပမာဏ ပြောင်းလဲခဲ့သည်';

  @override
  String get groupUnverified => 'စစ်ဆေးမထား';

  @override
  String get plannedQtyLabel => 'စီမံထားသော ပမာဏ';

  @override
  String get actualQtyLabel => 'တကယ့် ပမာဏ';

  @override
  String get plannedUnitPriceLabel => 'စီမံထားသော ယူနစ်ဈေးနှုန်း';

  @override
  String get actualUnitPriceLabel => 'တကယ့် ယူနစ်ဈေးနှုန်း';

  @override
  String get lineVarianceLabel => 'လိုင်း ကွာခြားချက်';

  @override
  String get discountEffectLabel => 'လျှော့ဈေး သက်ရောက်မှု';

  @override
  String get notBoughtMark => 'မဝယ်ရသေး';

  @override
  String get noPurchasesNote => 'ဝယ်ယူမှု မှတ်တမ်း မရှိပါ။';

  @override
  String get navHome => 'ပင်မစာမျက်နှာ';

  @override
  String get navLists => 'စာရင်းများ';

  @override
  String get navHistory => 'မှတ်တမ်း';

  @override
  String get navSettings => 'ဆက်တင်များ';

  @override
  String get homeEmptyTitle => 'ဝယ်ယူမှုကို စီစဉ်ပါ';

  @override
  String get homeEmptyBody =>
      'သင့်ပထမဆုံးစာရင်းကို ဖန်တီးပြီး ကြိုတင်ခန့်မှန်းထားသော ကုန်ကျစရိတ်နှင့် အမှန်တကယ် ကုန်ကျစရိတ်ကို နှိုင်းယှဉ်ပါ။';

  @override
  String get homeActiveSection => 'လက်ရှိအသုံးပြုနေသော စာရင်းများ';

  @override
  String get homeCompletedSection => 'အချိန်မရွေး ပြီးမြောက်ခဲ့သော စာရင်းများ';

  @override
  String get homeMonthlySection => 'ဤလ';

  @override
  String get monthPlannedLabel => 'ကြိုတင်စီစဉ်ထားသည်';

  @override
  String get monthActualLabel => 'အမှန်တကယ်';

  @override
  String get monthVarianceLabel => 'ကွာခြားချက်';

  @override
  String get continueShoppingLabel => 'ဝယ်ယူမှု ဆက်လုပ်ရန်';

  @override
  String get historyEmpty =>
      'ပြီးမြောက်ခဲ့သော ဝယ်ယူမှု မရှိသေးပါ။ သင့်၏ မှတ်တမ်းနှင့် သုံးသပ်ချက်များ ဤနေရာတွင် ပေါ်လာပါမည်။';

  @override
  String get aboutTabTitle => 'NShoptor အကြောင်း';

  @override
  String get aboutBody =>
      'Crazy Penguin ၏ NShoptor။ Offline-first ဝယ်ယူမှု စီစဉ်ကိရိယာ။ GPL-3.0 လိုင်စင်ဖြင့် ထုတ်ဝေထားသည်။';

  @override
  String get startShoppingLabel => 'ဝယ်ယူမှု စတင်ရန်';

  @override
  String get finishAndSeeResult => 'ပြီးဆုံးပြီး ရလဒ်ကို ကြည့်ရှုရန်';

  @override
  String get settingsTitle => 'ဆက်တင်များ';

  @override
  String get languageLabel => 'ဘာသာစကား';

  @override
  String get languageSystem => 'စနစ်';

  @override
  String get languageTr => 'Turkish';

  @override
  String get languageEn => 'English';

  @override
  String get themeLabel => 'Theme';

  @override
  String get themeSystem => 'စနစ်';

  @override
  String get themeLight => 'အလင်း';

  @override
  String get themeDark => 'အမှောင်';

  @override
  String get defaultCurrencyLabel => 'အလိုအလျောက်ငွေကြေး';

  @override
  String get defaultUnitLabel => 'အလိုအလျောက်တိုင်းတာမှုယူနစ်';

  @override
  String get keepAwakeLabel => 'ဝယ်ယူနေစဉ် အားလုံးကို ထိန်းသိမ်းရန်';

  @override
  String get backupSection => 'Backup';

  @override
  String get exportBackupLabel => 'Backup ထုတ်ယူရန်';

  @override
  String get importBackupLabel => 'Backup ဝင်ရောက်စေ့စပ်ရန်';

  @override
  String get mergeImportLabel => 'ရှိပြီးသားဒေတာထဲသို့ ပေါင်းထည့်ရန်';

  @override
  String get separateImportLabel =>
      'ကွဲပြားသော ကူးယူမှုအဖြစ် ဝင်ရောက်စေ့စပ်ရန်';

  @override
  String get importCancelled => 'ဝင်ရောက်စေ့စပ်ခြင်း ရုပ်သိမ်းပြီး။';

  @override
  String get backupExported => 'Backup အောင်မြင်စွာ ထုတ်ယူပြီးပါပြီ။';

  @override
  String get deleteAllSection => 'အန္တရာယ်ရှိသော နေရာ';

  @override
  String get deleteAllLabel => 'ဒေတာအားလုံး ဖျက်ပစ်ရန်';

  @override
  String get deleteAllConfirm =>
      'ဤသို့ပြုလုပ်ပါက စာရင်းများ၊ သမိုင်းကြောင်း၊ receipt ဓာတ်ပုံများနှင့် ဈေးနှုန်းများအားလုံး ဖျက်သွားမည်ဖြစ်ပါသည်။ သင် export လုပ်ထားသော ဖိုင်များမှာမူ သင့် drive တွင် ဆက်လက်ရှိနေမည်ဖြစ်ပါသည်။ ဆက်လက်လုပ်ဆောင်မည်လား?';

  @override
  String get deleteAllConfirm2 =>
      'သေချာစွာ မှန်ကန်ကြောင်း အတည်ပြုပါသလား? ဤလုပ်ဆောင်ချက်ကို ပြန်လည်ပြင်ဆင်၍ မရနိုင်ပါ။';

  @override
  String get cancelAction => 'Cancel';

  @override
  String get confirmDelete => 'အပြီးတိုင် ဖျက်ပစ်ရန်';

  @override
  String get dataDeleted => 'ဒေတာအားလုံး (local) ကို ဖျက်ပြီးပါပြီ။';

  @override
  String get privacyInfoLabel => 'Privacy';

  @override
  String get privacyInfoBody =>
      'သင့်စာရင်းများ၊ ဈေးနှုန်းများ၊ ပြေစာများနှင့် ဓာတ်ပုံများကို သင့်စက်ထဲတွင် သိမ်းဆည်းထားသည်။ အသံသည် စက်ထဲမှ ဘယ်သောအခါမျှ မထွက်ပါ။ AI အကူအညီ ဖွင့်ထားချိန်တွင် ပြေစာနှင့် ဈေးနှုန်းတံဆိပ်ဓာတ်ပုံများ (အရွယ်အစား ချုံ့ထားသည်) နှင့် ပြောဆိုရေးခိုင်းထားသော ပစ္စည်းများကဲ့သို့ စာသားကို ဖတ်ရန်သာ ကျွန်ုပ်တို့၏ဆာဗာသို့ ပို့ပေးသည်။ ၎င်းတို့ကို ချက်ချင်းလုပ်ဆောင်ပြီး ဘယ်သောအခါမျှ မသိမ်းဆည်းပါ။';

  @override
  String get aboutSection => 'About';

  @override
  String get aboutPublisher => 'ထုတ်ဝေသူ - Crazy Penguin';

  @override
  String get aboutLicenses => 'လိုင်စင်များ (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'အသံဖြင့် ထည့်သွင်းခြင်း';

  @override
  String get voiceStatusUnknown => 'Service: စစ်ဆေးခြင်း မရှိသေး';

  @override
  String get permissionsLabel => 'ခွင့်ပြုချက်များ';

  @override
  String get permissionsBody =>
      'Camera, microphone နှင့် notifications တို့ကို သင် ထို feature များကို အမှန်တကယ် အသုံးပြုသည့်အခါတွင်သာ တောင်းဆိုပါသည်။';

  @override
  String get unitsSection => 'အလိုအလျောက် သတ်မှတ်ချက်များ';

  @override
  String get roundingNote =>
      'ငွေကြေး ပြန်လည်တွက်ချက်ခြင်းသည် စည်းမျဉ်းတစ်ခုတည်းကို လိုက်နာပါသည် - သုံးသွက်ကိန်းများကို သုညမှ ဝေးရာသို့ ပြန်လည်တွက်ချက်ပြီး၊ Money conversion တွင် တစ်ကြိမ်သာ အသုံးပြုပါသည်။';

  @override
  String get voiceInputTitle => 'အသံဖြင့် ထည့်သွင်းခြင်း';

  @override
  String get voiceStartListening => 'ကျွန်ုပ်၏ အသံကို နားထောင်ရန် စတင်ပါ';

  @override
  String get voiceTranscriptLabel => 'စာသားပြန်လည်ရေးသားခြင်း';

  @override
  String get parseAction => 'Parse';

  @override
  String get receiptReviewTitle => 'Receipt ကို ပြန်လည်သုံးသပ်ခြင်း';

  @override
  String get receiptTotal => 'ရိတ်ထုပ်စုစုပေါင်း';

  @override
  String get receiptTotalUnknown => 'စုစုပေါင်း မတွေ့ရှိပါ';

  @override
  String get receiptDiff => 'ကွာခြားချက်';

  @override
  String get acceptLine => 'လက်ခံမည်';

  @override
  String get ignoreLine => 'ဖယ်ရှားမည်';

  @override
  String get receiptLineActions =>
      'ပစ္စည်းနှင့် ချိတ်ဆက်၊ ခွဲခြား သို့မဟုတ် ဖယ်ရှား';

  @override
  String get receiptCommit => 'အားလုံး လက်ခံမည်';

  @override
  String get receiptCommitted => 'ရိတ်ထုပ် အသုံးပြုပြီး။';

  @override
  String get priceHistoryTitle => 'ဈေးနှုန်း သမိုင်းကြောင်း';

  @override
  String get noObservations => 'ဈေးနှုန်း မှတ်တမ်း မရှိသေးပါ';

  @override
  String get templatesSection => 'နမူနာများ';

  @override
  String get templateHint =>
      'ရှေ့က ဆိုင်ဝယ်ခဲ့တဲ့ စာရင်းကို အခြေခံပြီး အသစ်တစ်ခု ဖန်တီးပါ';

  @override
  String get scanReceiptAction => 'ရိတ်ထုပ် စကင်ဖတ်မည်';

  @override
  String get fromReceiptListButton => 'ပြေစာမှ စာရင်း';

  @override
  String get shelfLabelAction => 'ခုံပေါ်က တံဆိပ်မှ ဈေးနှုန်း';

  @override
  String get priceCandidatesTitle => 'ဈေးနှုန်း ရွေးချယ်စရာများ';

  @override
  String get noPriceCandidates => 'ဈေးနှုန်း မတွေ့ပါ — လက်ဖြင့် ထည့်ပါ။';

  @override
  String get voiceUnavailable =>
      'အသံ ပြန်ဆိုမှု မရရှိနိုင်ပါ — လက်ဖြင့် ထည့်ပါ။';

  @override
  String get linkToItem => 'ပစ္စည်းနှင့် ချိတ်ဆက်မည်';

  @override
  String get splitLine => 'နှစ်ပိုင်း ခွဲမည်';

  @override
  String get mergeWithNext => 'နောက်တစ်ခုနှင့် ပေါင်းမည်';

  @override
  String get ocrNoText => 'စာသား မဖတ်မိပါ — ပြန်ကြိုးစားပါ။';

  @override
  String get priceHistoryAction => 'ဈေးနှုန်း သမိုင်းကြောင်း';

  @override
  String get itemsEmptyTitle => 'ပစ္စည်း မရှိသေးပါ';

  @override
  String get itemsEmptyBody =>
      'ပထမဆုံး ပစ္စည်းကို ထည့်ပါ — ဆိုင်မှာ ကိုယ်တိုင် ဈေးနှုန်း ထည့်မှာပါ။';

  @override
  String get addItemTooltip => 'ပစ္စည်း ထည့်မည်';

  @override
  String get unitAdet => 'လုံး';

  @override
  String get unitKilogram => 'kg';

  @override
  String get unitGram => 'g';

  @override
  String get unitLitre => 'L';

  @override
  String get unitMililitre => 'ml';

  @override
  String get unitPaket => 'ပက်ကက်';

  @override
  String get unitKutu => 'ဘူး';

  @override
  String get unitSise => 'ဘော်တယ်';

  @override
  String get unitKavanoz => 'ခွက်';

  @override
  String get unitDemet => 'စည်း';

  @override
  String get unitDuzine => 'ဒါဇင်';

  @override
  String get unitMetre => 'm';

  @override
  String get unitCustom => 'ကိုယ်ပိုင်';

  @override
  String get setReminderAction => 'အချိန်မှတ်ပေးမည်';

  @override
  String get reminderPermissionDenied =>
      'အချိန်မှတ်ပေးဖို့ Notification permission လိုအပ်ပါတယ်။ စနစ် Settings မှာ ဖွင့်ပေးနိုင်ပါတယ်။';

  @override
  String get reminderScheduled => 'အချိန်မှတ် ပြုလုပ်ပြီး။';

  @override
  String get reminderCancelled => 'အချိန်မှတ် ဖယ်ရှားပြီး။';

  @override
  String get reminderTitle => 'ဆိုင်ဝယ် အချိန်မှတ်';

  @override
  String reminderBody(Object title) {
    return 'စာရင်းကို စစ်ဆေးချိန် ဖြစ်ပါပြီ: $title';
  }

  @override
  String get reminderPickDate => 'ရက်စွဲ ရွေးပါ';

  @override
  String get reminderPickTime => 'အချိန် ရွေးပါ';

  @override
  String get itemDetailsSection => 'အသေးစိတ်';

  @override
  String get priceOptionalHint =>
      'မဖြစ်မနေ မလိုအပ်ပါ — ဆိုင်မှာ ကိုယ်တိုင် ဈေးနှုန်း ထည့်မှာပါ';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'စီစဉ်ထားတာ: $total · ပစ္စည်း $count ခု';
  }

  @override
  String get proActiveLabel => 'Pro အသုံးပြုနေသည် — ကျေးဇူးတင်ပါတယ်!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Ads မရှိ · Backup ထုတ်ယူခြင်းနှင့် ဝင်ရောက်ခြင်း · တစ်နှစ်';

  @override
  String get proBenefitNoAds => 'ကြော်ငြာ မပါဝင်သော အတွေ့အကြုံ';

  @override
  String get proBenefitBackup => 'ဘက်အပ် (တင်သွင်း/ထုတ်ယူ)';

  @override
  String aboutVersion(Object version) {
    return 'ဗားရှင်း $version';
  }

  @override
  String get navDiscover => 'ရှာဖွေမည်';

  @override
  String get shareAction => 'App ကို မျှဝေမည်';

  @override
  String get rateAction => 'ကျွန်တော်တို့ကို အကဲဖြတ်မည်';

  @override
  String get aboutOpenRow => 'အကြောင်း & open source';

  @override
  String get voiceAddItemAction => 'အသံဖြင့် ပစ္စည်းထည့်မည်';

  @override
  String get formatLocaleLabel => 'အရေအတွက်နှင့် ငွေကြေးပုံစံ';

  @override
  String get formatLocaleSystem =>
      'စက်ပစ္စည်း ပုံစံ (လက်ရေးကိန်းဂဏန်းများ; အခြားအင်္ဂလိပ်)';

  @override
  String get formatLocaleTr => 'တူရကီ (1.234,56)';

  @override
  String get formatLocaleEn => 'အင်္ဂလိပ် (1,234.56)';

  @override
  String get aiToggleTitle => 'AI အကူအညီ';

  @override
  String get aiToggleSubtitle =>
      'ဓာတ်ပုံများမှ ပြေစာနှင့် ဈေးနှုန်းတံဆိပ်များကို ဖတ်ပေးပြီး ပြေစာများကို တိုက်ဆိုင်ပေးကာ ဝါကျများကို စာရင်းများအဖြစ် ပြောင်းပေးသည်။ ဓာတ်ပုံများကို ဖတ်ရန်သာ ပို့ပြီး ဘယ်သောအခါမျှ မသိမ်းဆည်းပါ။';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'ဤလအတွက် AI တောင်းဆိုမှုများကို သင်အသုံးပြုပြီးပါပြီ ($used/$limit)။ ပိုမိုရရှိရန် Upgrade လုပ်ပါ သို့မဟုတ် AI မပါဘဲ ဆက်လက်အသုံးပြုပါ။';
  }

  @override
  String get aiOffline => 'ကွန်ရက်မရှိ - AI မပါဘဲ ဆက်လက်လုပ်ဆောင်နေသည်။';

  @override
  String get aiFailed =>
      'AI ယခုအချိန်တွင် အသုံးမပြုနိုင်ပါ - ၎င်းမပါဘဲ ဆက်လက်လုပ်ဆောင်နေသည်။';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'စက်';

  @override
  String get quickListAction => 'စာသားမှ ထည့်ရန်';

  @override
  String get quickListTitle => 'မြန်ဆန်သောစာရင်း';

  @override
  String get quickListHint =>
      'ဥပမာ - ၁ ကီလို အထူးသီးနှံ ၂၀၊ ၂ လုံးသား၊ နှက်ကီလို ချစ်စ်';

  @override
  String get quickListConvert => 'စာရင်းအဖြစ် ပြောင်းရန်';

  @override
  String quickListAdd(int count) {
    return '$count ခု ထည့်ရန်';
  }

  @override
  String get quickListEmpty => 'ဝတ္ထုမတွေ့ပါ။ Comma ဖြင့်ခွဲရေးကြည့်ပါ။';

  @override
  String get receiptAiMatched =>
      'AI က ရီးဆစ်ကို သင့်စာရင်းနှင့် ကိုက်ညီစေခဲ့သည်။ ဆက်သွယ်မှုများကို စစ်ဆေးပြီး အတည်ပြုပါ။';

  @override
  String get receiptNeedsCheck => 'ဤကိုက်ညီမှုကို စစ်ဆေးရန်';

  @override
  String get receiptDiscountLine => 'လျှော့ဈေး';

  @override
  String get compareItem => 'ဝတ္ထု';

  @override
  String get compareEstimated => 'ခန့်မှန်း';

  @override
  String get compareActual => 'အမှန်တကယ်';

  @override
  String get compareDiff => 'ကွာခြားချက်';

  @override
  String get compareTotal => 'စုစုပေါင်း';

  @override
  String get compareBudget => 'ဘတ်ဂျက်';

  @override
  String get compareNotBought => 'မဝယ်ရသေး';

  @override
  String get compareUnplanned => 'မစီစဉ်ရသေး';

  @override
  String get pricierItems => 'ဈေးပိုကြီး';

  @override
  String get cheaperItems => 'ဈေးပိုသက်သာ';

  @override
  String get compareAction => 'နှိုင်းယှဉ်ရန်';

  @override
  String get detailsSection => 'အသေးစိတ်';

  @override
  String get spendingTitle => 'ကုန်ကျစရိတ်';

  @override
  String get spendingAction => 'ကုန်ကျစရိတ်';

  @override
  String get spendingMonthTotal => 'ဤလ';

  @override
  String get spendingWeekly => 'တစ်ပတ် ကုန်ကျစရိတ်';

  @override
  String get spendingMonthly => 'တစ်လ ကုန်ကျစရိတ်';

  @override
  String get monthlyLimitTitle => 'တစ်လတာ ကန့်သတ်ချက်';

  @override
  String get monthlyLimitHelp =>
      'တစ်လလျှင် ဈေးဝယ်ရာတွင် ဘယ်လောက်ကုန်ချင်ပါသလဲ?';

  @override
  String get monthlyLimitRemove => 'ဖယ်ရှားရန်';

  @override
  String get monthlyLimitSet => 'သတ်မှတ်ရန်';

  @override
  String get monthlyLimitChange => 'ပြောင်းရန်';

  @override
  String get monthlyLimitNone =>
      'ကျန်ရှိသေးသော ပမာဏကို ကြည့်ရှုရန် တစ်လတာ ကန့်သတ်ချက် သတ်မှတ်ပါ။';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount ကန့်သတ်ချက်ထက် ကျော်လွန်';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return 'ဤလတွင် $amount ကျန်ရှိ';
  }

  @override
  String get plansTitle => 'အစီအစဉ်များ';

  @override
  String get plansHeadline => 'AI ဖြင့် ပိုကောင်းမွန်စွာ ဝယ်ယူပါ';

  @override
  String get plansSubhead =>
      'ရီးဆစ်ကိုက်ညီမှု၊ ဈေးနှုန်းစတicker များနှင့် စာသားမှစာရင်း။ မည်သည့်အချိန်တွင်မဆို ဖျက်သိမ်းနိုင်ပါသည်။';

  @override
  String get plansMonthly => 'တစ်လ';

  @override
  String get plansYearly => 'တစ်နှစ်';

  @override
  String get planFree => 'အခမဲ့';

  @override
  String get planFreePrice => 'အမြဲတမ်း အခမဲ့';

  @override
  String get planFreeAi => 'တစ်လလျှင် AI တောင်းဆိုမှု 10 ခု';

  @override
  String get planFreeAds => 'Banner ads (ပထမ ၇ ရက်တွင် မရှိပါ)';

  @override
  String get planCoreFeatures =>
      'စာရင်းများ၊ ဈေးနှုန်းများ၊ ရီးဆစ်များ၊ ကုန်ကျစရိတ် ဇယားများ';

  @override
  String get plansPerYear => '/ နှစ်';

  @override
  String get plansPerMonth => '/ လ';

  @override
  String get planTrial => 'အခမဲ့ အစမ်းသုံးခြင်း';

  @override
  String get planProAi => 'တစ်လလျှင် AI တောင်းဆိုမှု 100';

  @override
  String get planNoAds => 'Ads မရှိ';

  @override
  String get planBackup => 'Backup ထုတ်ယူခြင်းနှင့် ဝင်ရောက်ခြင်း';

  @override
  String get planMaxAi => 'လစဉ် AI တောင်းဆိုမှု 300';

  @override
  String get planMaxFamily => 'မိသားစုကြီးများအတွက် အစားအစာဝယ်ခြင်း';

  @override
  String get plansStoreUnavailable => 'ဆိုင်ကို လက်ရှိတွင် မရရှိနိုင်ပါ။';

  @override
  String get retryAction => 'ပြန်လုပ်မည်';

  @override
  String get plansPurchaseFailed =>
      'ဝယ်ယူမှု မအောင်မြင်ပါ။ ကျေးဇူးပြု၍ ပြန်လည်ကြိုးစားပါ။';

  @override
  String get plansRestore => 'ဝယ်ယူမှုများကို ပြန်လည်ထူထောင်ခြင်း';

  @override
  String get plansLegal =>
      'မပယ်ဖျက်မချင်း Pro ကို နှစ်စဉ် အလိုအလျောက် သက်တမ်းတိုးပြီး တစ်လလျှင် AI တောင်းဆိုမှု ၁၀၀ ပါဝင်သည်။ သက်ဆိုင်ရာအခွန်များ မပါဝင်မီ အခြေခံဈေးနှုန်းမှာ တစ်နှစ်လျှင် အမေရိကန်ဒေါ်လာ ၁ ဖြစ်သည်။ ဝယ်ယူမှုကို အတည်မပြုမီ စတိုးတွင် နောက်ဆုံးဒေသတွင်းဈေးနှုန်းနှင့် အခွန်များကို စစ်ဆေးပါ။ Google Play တွင် စာရင်းသွင်းမှုကို စီမံရန် သို့မဟုတ် ပယ်ဖျက်ရန် ပြုလုပ်နိုင်သည်။';

  @override
  String get planCurrent => 'လက်ရှိ';

  @override
  String get planStartTrial => 'အခမဲ့ အစမ်းသုံးရန်';

  @override
  String get planChoose => 'ရွေးချယ်ပါ';

  @override
  String get plansAction => 'အစီအစဉ်များ: Pro';

  @override
  String get assistantTitle => 'အကူအညီ';

  @override
  String get assistantGreeting => 'ဟယ်လို! ဘာလုပ်ချင်လဲ?';

  @override
  String get assistantNewList => 'New list';

  @override
  String get assistantVoiceList => 'အသံဖြင့် စာရင်း';

  @override
  String get assistantTextList => 'စာကြောင်းမှ စာရင်း';

  @override
  String get assistantScanReceipt => 'လက်ခံငွေပေးချေမှုစာရွက်ကို စကင်န်လုပ်ပါ';

  @override
  String get assistantSpending => 'ကျွန်ုပ်၏ ကုန်ကျစရိတ်';

  @override
  String get assistantReceiptHint =>
      'သင့်စာရင်းကိုဖွင့်ပြီး လက်ခံငွေပေးချေမှုစာရွက်ကို စကင်န်လုပ်ရန် အိုင်ကွန်ကို နှိပ်ပါ။';

  @override
  String get assistantToggleTitle => 'အကူအညီကို ပြပါ';

  @override
  String get assistantToggleSubtitle => 'ညာဘက်အောက်ခြေရှိ အကူအညီပေးသူ';

  @override
  String get scanPriceLabel => 'ဈေးနှုန်းလိပ်စာကို စကင်န်ပါ';

  @override
  String get saveFailed =>
      'သိမ်းဆည်းရန် မအောင်မြင်ပါ။ သင့်ပြောင်းလဲမှုများ ကျန်ရှိနေဆဲဖြစ်သည်။ ပြန်လည်ကြိုးစားပါ။';

  @override
  String get deleteItemConfirm =>
      'ဤပစ္စည်းနှင့် ၎င်း၏ မှတ်တမ်းတင်ဝယ်ယူမှုများကို ဖျက်ပစ်မည်မှာ အတည်ပြုပါသလား?';

  @override
  String get clearPurchaseConfirm =>
      'ဤပစ္စည်းမှ တicked (ရွေးချယ်ထားခြင်း) ကို ဖယ်ရှားပြီး ၎င်း၏ မှတ်တမ်းတင်ဝယ်ယူမှုများကို ဖျက်ပစ်မည်မှာ အတည်ပြုပါသလား?';

  @override
  String get reportPdfAction => 'PDF အစီရင်ခံစာကို သိမ်းဆည်းပါ';

  @override
  String get reportNotInvoice =>
      'ဝယ်ယူမှု စုစည်းချက်၊ ဘဏ္ဍာရေးအခွန် လက်မှတ် မဟုတ်ပါ။ ဘဏ္ဍာရေးအခွန်နှုန်းထားများ မသိရှိနိုင်ပါ။';

  @override
  String get purchaseVisits => 'ဝယ်ယူမှု ခရီးစဉ်များ';

  @override
  String get purchaseInterval => 'ဝယ်ယူမှုများကြား ပျမ်းမျှ ရက်အရေအတွက်';

  @override
  String get purchasedQuantity => 'ဝယ်ယူလိုက်သော ပမာဏ';

  @override
  String get purchaseAnalyticsHint =>
      'ဝယ်ယူမှုများသည် စားသုံးမှုကို တိုင်းတာခြင်း မဟုတ်ပါ။ ငွေကြေးနှင့် ယူနစ်များကို သီးခြားစီ ပြသထားပါသည်။';

  @override
  String get receiptReplaces =>
      'ဈေးမရှိသော ပစ္စည်းများ၏ဈေးကို ဖြည့်ပေးမည်။ ဈေးကွက်ဈေးရှိပြီးသား ပစ္စည်းများကို သီးခြားဝယ်ယူမှုအဖြစ် ထည့်မည်။';

  @override
  String get receiptIncompleteHeader =>
      'နောက်ဓာတ်ပုံတွင် ဆိုင်၊ ရက်စွဲ၊ အချိန်နှင့် ပြေစာနံပါတ်တို့ ပါဝင်ပါစေ။';

  @override
  String get receiptIncompleteTail =>
      'နောက်အပိုင်းကို ပစ္စည်းအချို့ ထပ်နေပြီး နောက်ဆုံးစုစုပေါင်းပါအောင် ဓာတ်ပုံရိုက်ပါ။';

  @override
  String get receiptContinuationRejected =>
      'ဤဓာတ်ပုံကို ပေါင်းစည်း၍မရပါ။ ပြေစာတစ်ခုတည်းမှ ပစ္စည်းများ ထပ်နေအောင် ပြန်ရိုက်ပါ။';

  @override
  String get receiptDraftSaved =>
      'ပြေစာကို မူကြမ်းအဖြစ် သိမ်းပြီးပါပြီ။ နောက်မှ ဆက်လုပ်နိုင်သည်။';

  @override
  String get receiptContinueAction => 'ပြေစာ ဆက်လုပ်ရန်';

  @override
  String get receiptDraftsTitle => 'မပြီးသေးသော ပြေစာများ';

  @override
  String get receiptDuplicate => 'ဤပြေစာကို ထည့်ပြီးသားဖြစ်သည်။';

  @override
  String get receiptTotalMismatch =>
      'ပစ္စည်းစုစုပေါင်းသည် ပြေစာစုစုပေါင်းနှင့် မကိုက်ညီပါ။ ပြေစာတစ်ခုလုံး မြင်ရကြောင်း စစ်ဆေးပါ။';

  @override
  String get receiptSaveDraftAction => 'နောက်မှ သိမ်းရန်';

  @override
  String get receiptResolveLines =>
      'မသိမ်းမီ ပစ္စည်းတစ်ခုစီကို လက်ခံပါ သို့မဟုတ် လျစ်လျူရှုပါ။';

  @override
  String get receiptPartialConfirm =>
      'ရွေးထားသောပစ္စည်းများသာ ထည့်ပါမည်။ ဤပြေစာကို တင်သွင်းပြီးဟု မှတ်သားပါမည်။ ဆက်လုပ်မလား။';

  @override
  String get voiceUnsupportedLanguage =>
      'ဤဘာသာစကားကို ဤစက်ပစ္စည်းတွင် အသံဖြင့် ထည့်သွင်းရန် မရရှိနိုင်ပါ။ အစားထိုး၍ ရိုက်ထည့်နိုင်ပါသည်။';

  @override
  String get voiceStopListening => 'နားထောင်ခြင်း ရပ်မည်';

  @override
  String get keepAwakeFailed =>
      'မျက်နှာပြင်ကို မပိတ်အောင် ထား၍ မရပါ။ ထပ်မံကြိုးစားပါ။';

  @override
  String get purchaseHistoryHint =>
      'ပြီးပြည့်စုံသော ဈေးဝယ်မှုအားလုံးပါဝင်သည်။ ပြန်လည်ပေးချေမှုများသည် စုစုပေါင်းကို လျှော့ချပေးသည်။ ရက်စွဲများသည် ဈေးဝယ်မှု ပြီးဆုံးချိန်ကို ဆိုလိုသည်။ တစ်ကြိမ်တည်း ဝယ်ယူခြင်းသည် ပျမ်းမျှကာလကို တွက်ချက်ရန် မလုံလောက်ပါ။';

  @override
  String get planLegacyRights =>
      'ရှိပြီးသား Pro နှင့် Max ဆက်တိုက်ဝယ်ယူသူများသည် မူလ လစဉ် AI အခွင့်အရေးကို ဆက်လက်ရရှိမည်။';

  @override
  String get csvExportAction => 'CSV ထုတ်ယူရန်';

  @override
  String get reportSharePdf => 'PDF အဖြစ် မျှဝေရန်';

  @override
  String get reportShareCsv => 'CSV အဖြစ် မျှဝေရန်';

  @override
  String get reportPrintAction => 'ပုံနှိပ်ရန်';

  @override
  String get backupSizeWarning =>
      'JSON တွင် photo file များမပါဝင်ဘဲ record များသာ ပါရှိသည်။ Import လုပ်နိုင်သော အများဆုံးအရွယ်အစားမှာ 16 MB ဖြစ်သည်။';

  @override
  String get backupImportFailed =>
      'ဤ backup ကို import လုပ်၍မရပါ။ သင့် data များ ပြောင်းလဲခြင်း မရှိပါ။';

  @override
  String get backupImported => 'Backup ကို အောင်မြင်စွာ ဝင်ရောက်ပြီးပါပြီ။';

  @override
  String backupPreviewCounts(Object entries, Object items, Object lists) {
    return '$lists စာရင်းများ · $items ပစ္စည်းများ · $entries ဝယ်ယူမှုများ';
  }

  @override
  String get voiceModelDownloading =>
      'ဤဘာသာစကားအတွက် အသံမော်ဒယ်ကို ဒေါင်းလုဒ်လုပ်နေသည်။ တစ်မိနစ်အကြာတွင် ထပ်ကြိုးစားပါ။';

  @override
  String get historyThisWeek => 'ဤအပတ်';

  @override
  String get historyProductsSection => 'ဝယ်ယူခဲ့သော ပစ္စည်းများ';

  @override
  String get tipReceiptScan =>
      'ဖောင်ကို စကင်ဖတ်ပြီး ဈေးနှုန်းများကို သင့်စာရင်းနှင့် ကိုက်ညီအောင် လုပ်ပါ';

  @override
  String get tipVoiceAdd =>
      'ပစ္စည်းတစ်ခု သို့မဟုတ် တစ်ခုထက်ပို ပြောပြီး ထည့်မည့်အကြိုတွင် စစ်ဆေးပါ';

  @override
  String get tipShelfCamera => 'ကင်မရာဖြင့် ရဖ်လိပ်ဆင်းမှ စျေးနှုန်းကို ဖတ်ပါ';

  @override
  String get tipPlan =>
      'သင့်အစီအစဉ်: အသေးစိတ်ကြည့်ရန်၊ စာရင်းသွင်းရန် သို့မဟုတ် အဆင့်မြှင့်ရန်';

  @override
  String get guideAddBody =>
      'ပစ္စည်းထည့်ရန် + ကို နှိပ်ပါ။ စီစဉ်ထားသောစျေးကို ယခု၊ ဈေးကွက်စျေးကို ငွေရှင်းတွင် ထည့်ပါ။';

  @override
  String get guideVoiceBody =>
      'မိုက်ခရိုဖုန်းကို နှိပ်ပြီး ပစ္စည်းများ ပြောပါ၊ ဥပမာ: \'၁ ကီလို ပန်းသီး၊ ပေါင်မုန့် ၁ ခု\'။';

  @override
  String get guideReceiptBody =>
      'ဖောင်ကို စကင်ဖတ်ပြီး စျေးနှုန်းများကို သင့်စာရင်းရှိ ပစ္စည်းများနှင့် ကိုက်ညီအောင် လုပ်ပါ။';

  @override
  String get guidePlanBody =>
      'အစီအစဉ်ကို ကြည့်ရန်၊ စာရင်းသွင်းရန် သို့မဟုတ် အဆင့်မြှင့်ရန် အစီအစဉ်အိုင်ကွန်ကို နှိပ်ပါ။';

  @override
  String get guideNext => 'အိုကေ';

  @override
  String get guideDone => 'စတင်';

  @override
  String get paletteLabel => 'အရောင် ပုံစံ';

  @override
  String get paletteForest => 'သစ်တော';

  @override
  String get paletteOcean => 'သမုဒ္ဒရာ';

  @override
  String get paletteSunset => 'နေဝင်ချိန်';

  @override
  String get paletteLavender => 'လာဗင်ဒါ';

  @override
  String get darkBlackLabel => 'အမှောင်ပုံစံတွင် အနက်ရောင်အပြည့်';

  @override
  String get spendingOverview => 'ခြုံငုံသုံးသပ်ချက်';

  @override
  String get spendingThisYear => 'ယခုနှစ်';

  @override
  String get spendingYearly => 'နှစ်စဉ် အသုံးစရိတ်';

  @override
  String get productSpending => 'ပစ္စည်းအလိုက် အသုံးစရိတ်';

  @override
  String get spanWeek => 'အပတ်';

  @override
  String get spanMonth => 'လ';

  @override
  String get spanYear => 'နှစ်';

  @override
  String get weeklyLimitTitle => 'အပတ်စဉ် ကန့်သတ်ချက်';

  @override
  String get weeklyLimitHelp => 'တစ်ပတ်လျှင် ဈေးဝယ်ရန် ဘယ်လောက်သုံးချင်ပါသလဲ?';

  @override
  String get weeklyLimitNone =>
      'ကျန်ငွေကို ကြည့်ရန် အပတ်စဉ် ကန့်သတ်ချက် သတ်မှတ်ပါ။';

  @override
  String weeklyLimitLeft(String amount) {
    return 'ဤအပတ် $amount ကျန်';
  }

  @override
  String get shoppingLimitTitle => 'ဈေးဝယ်တစ်ကြိမ်ချင်း ကန့်သတ်ချက်';

  @override
  String get shoppingLimitHelp => 'စာရင်းအသစ်များ ဤဘတ်ဂျက်ဖြင့် စတင်သည်။';

  @override
  String get shoppingLimitNone => 'ဈေးဝယ်အသစ်တိုင်းအတွက် မူလဘတ်ဂျက် သတ်မှတ်ပါ။';

  @override
  String get monthlyReportAction => 'လစဉ် အစီရင်ခံစာ';

  @override
  String get reportShoppingColumn => 'ဈေးဝယ်ခြင်း';

  @override
  String get reportDateColumn => 'ရက်စွဲ';

  @override
  String get planUnavailable => 'ယခု စတိုးတွင် မရနိုင်ပါ';

  @override
  String get demoDataTitle => 'နမူနာဒေတာ';

  @override
  String get demoDataLoad => 'နမူနာဒေတာဖြင့် စမ်းကြည့်ရန်';

  @override
  String get demoDataLoadHelp =>
      'မှတ်တမ်း၊ ဇယားနှင့် စျေးနှုန်းမှတ်တမ်းကို ကြည့်ရန် ၁၂ လစာ နမူနာဈေးဝယ်မှုများ ထည့်ပေးသည်။';

  @override
  String get demoDataRemove => 'နမူနာဒေတာ ဖျက်ရန်';

  @override
  String get demoDataAdded => 'နမူနာဒေတာ ထည့်ပြီး';

  @override
  String get demoDataRemoved => 'နမူနာဒေတာ ဖျက်ပြီး';

  @override
  String get demoProductApple => 'ပန်းသီး';

  @override
  String get demoProductBread => 'ပေါင်မုန့်';

  @override
  String get demoProductMilk => 'နွားနို့';

  @override
  String get demoProductCheese => 'ဒိန်ခဲ';

  @override
  String get demoProductTomato => 'ခရမ်းချဉ်သီး';

  @override
  String get demoProductEggs => 'ကြက်ဥ';

  @override
  String get demoProductCoffee => 'ကော်ဖီ';

  @override
  String get demoProductDetergent => 'ဆပ်ပြာမှုန့်';

  @override
  String get sendAction => 'Send';

  @override
  String get previousMonthAction => 'Previous month';

  @override
  String get nextMonthAction => 'Next month';

  @override
  String get helpSection => 'အကူအညီနှင့် ပံ့ပိုးမှု';

  @override
  String get howToUseLabel => 'အသုံးပြုပုံ';

  @override
  String get guidePricesBody =>
      'ဆိုင်ဈေးနှုန်းထည့်လျှင် ပစ္စည်းကို ဝယ်ပြီးဟု မှတ်သားသည်။ 0 လည်း အကျုံးဝင်သည်။ အိမ်ဈေးနှုန်းသည် မဖြစ်မနေမဟုတ်ပါ။ အမှန်ခြစ်ဖြုတ်ရန် ဆိုင်ဈေးနှုန်းကို ဖျက်ပါ။';

  @override
  String get shoppingDateLabel => 'ဈေးဝယ်ရက်';

  @override
  String get shoppingDateNone => 'ရက်စွဲ မရွေးရသေးပါ';

  @override
  String get clearShoppingDateAction => 'ရက်စွဲ ဖယ်ရှားရန်';

  @override
  String get listSortLabel => 'စာရင်းအစီအစဉ်';

  @override
  String get listSortDate => 'ဈေးဝယ်ရက်';

  @override
  String get listSortAz => 'အမည် (က–အ)';

  @override
  String get listSortManual => 'ကိုယ်တိုင် စီစဉ်ရန်';

  @override
  String get imageCameraAction => 'ဓာတ်ပုံရိုက်ရန်';

  @override
  String get imageGalleryAction => 'ဓာတ်ပုံများမှ ရွေးရန်';

  @override
  String get imageCaptureFailed =>
      'ကင်မရာ သို့မဟုတ် ဓာတ်ပုံများကို ဖွင့်၍မရပါ။ ဝင်ရောက်အသုံးပြုခွင့်ကို စစ်ဆေးပြီး ထပ်စမ်းကြည့်ပါ။';

  @override
  String get imageRecognitionFailed =>
      'ဓာတ်ပုံကို လုပ်ဆောင်၍မရပါ။ အခြားဓာတ်ပုံဖြင့် စမ်းကြည့်ပါ။';

  @override
  String get receiptNoProducts =>
      'စာသားကို ဖတ်ရှုပြီးသော်လည်း ပြေစာရှိ ပစ္စည်းများကို မတွေ့ပါ။ ဓာတ်ပုံတွင် ပစ္စည်းများနှင့် စုစုပေါင်းငွေပမာဏ ပါဝင်ပါစေ။';

  @override
  String get keepAwakeOn => 'မျက်နှာပြင်ကို ဖွင့်ထားမည်';

  @override
  String get keepAwakeOff => 'မျက်နှာပြင် ပိတ်သွားနိုင်သည်';

  @override
  String get spanDay => 'နေ့';

  @override
  String get spanCustom => 'ရက်စွဲအပိုင်းအခြား';

  @override
  String get reportTotalSpent => 'စုစုပေါင်းသုံးငွေ';

  @override
  String get reportAddedAt => 'ထည့်သွင်းသည့်ရက်';

  @override
  String get reportReceiptNumber => 'ပြေစာနံပါတ်';

  @override
  String get reportPreview => 'အစမ်းကြည့်ရန်';

  @override
  String get reportShareAction => 'မျှဝေရန်';

  @override
  String get previousPeriodAction => 'ယခင်ကာလ';

  @override
  String get nextPeriodAction => 'နောက်ကာလ';

  @override
  String get reportSaved => 'အစီရင်ခံစာကို သိမ်းဆည်းပြီးပါပြီ။';

  @override
  String get reportZoom => 'ချဲ့ရန်';

  @override
  String planTrialDaysLeft(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days ရက်ကျန်',
    );
    return '$_temp0';
  }

  @override
  String planTrialHoursLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours နာရီကျန်',
    );
    return '$_temp0';
  }

  @override
  String get planTrialEndedTitle => 'သင်၏ Pro အစမ်းသုံးကာလ ကုန်ဆုံးသွားပါပြီ';

  @override
  String get planTrialEndedBody =>
      'စာရင်းများ၊ ကိုယ်တိုင်ထည့်သွင်းခြင်းနှင့် စက်ပေါ်ရှိ အသံလုပ်ဆောင်ချက်ကို အခမဲ့ ဆက်လက်အသုံးပြုနိုင်ပါသည်။ အခမဲ့အစီအစဉ်တွင် ပြက္ခဒိန်တစ်လလျှင် AI တောင်းဆိုမှု ၁၀ ခု ပါဝင်သည်။ တစ်လလျှင် AI တောင်းဆိုမှု ၁၀၀ ခု၊ ကြော်ငြာမပါဘဲ အသုံးပြုမှုနှင့် အရန်သိမ်းဆည်းမှုများအတွက် နှစ်စဉ် Pro ကို ရွေးပါ။ သင့်ဒေတာများကို ဆက်လက်ထိန်းသိမ်းထားမည်။';

  @override
  String get planContinueFree => 'အခမဲ့ ဆက်လုပ်ရန်';

  @override
  String get supportIdLabel => 'ပံ့ပိုးမှု ID';

  @override
  String get supportEmailLabel => 'အီးမေးလ်ဖြင့် ပံ့ပိုးမှု';

  @override
  String get captureTipFirst =>
      'အပေါ်ဆုံးကစပါ- ဆိုင်အမည်နှင့် ရက်စွဲ မြင်ရရမည်။ ပစ္စည်းများကို တတ်နိုင်သမျှ ထည့်ပါ၊ ကျန်တာကို နောက်ဓာတ်ပုံတွင် ထည့်ပါ။';

  @override
  String get captureTipContinue =>
      'ပြေစာတစ်ခုတည်း- ယခင်ဓာတ်ပုံ၏ နောက်ဆုံးပစ္စည်းကို ထည့်ပါ။';

  @override
  String get captureTipNeverShow => 'ထပ်မပြပါနှင့်';

  @override
  String get captureTipOk => 'နားလည်ပြီ';

  @override
  String get captureTipsSetting => 'ပြေစာရိုက်ယူရန် အကြံပြုချက်များ ပြပါ';

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
  String get listReceiptsSection => 'ပြေစာများ';

  @override
  String get receiptStateComplete => 'ပြီးဆုံး';

  @override
  String get receiptStateIncomplete => 'မပြည့်စုံ';

  @override
  String get receiptStateFailed => 'မအောင်မြင်';

  @override
  String get receiptStoreUnknown => 'ဆိုင်ကို မဖတ်နိုင်ပါ';

  @override
  String get receiptDeleteAction => 'ပြေစာ ဖျက်ရန်';

  @override
  String get receiptDeleteConfirm =>
      'ဤပြေစာနှင့် ၎င်းထည့်ခဲ့သော ပစ္စည်းများကို ဖျက်မလား။ နောက်မှ ပြန်တင်သွင်းနိုင်ပါသည်။';

  @override
  String get receiptDeleted => 'ပြေစာ ဖျက်ပြီးပါပြီ။';

  @override
  String listReceiptsShowAll(int count) {
    return 'အားလုံးပြရန် ($count)';
  }

  @override
  String get listReceiptsShowLess => 'နည်းနည်းပြရန်';

  @override
  String receiptDateLabel(String date) {
    return 'ပြေစာ ရက်စွဲ- $date';
  }

  @override
  String get historyViewShopping => 'ဈေးဝယ်မှုအလိုက်';

  @override
  String get historyViewStore => 'ဆိုင်အလိုက်';

  @override
  String get historyViewProduct => 'ကုန်ပစ္စည်းအလိုက်';

  @override
  String get historyShareAll => 'အားလုံးမျှဝေရန်';

  @override
  String get historyUnknownStore => 'မသိသောဆိုင်';

  @override
  String get historyDailySpending => 'နေ့စဉ်အသုံးစရိတ်';

  @override
  String get historyResetPeriod => 'ဤအပတ်သို့ ပြန်သွားရန်';

  @override
  String get tourSkip => 'ကျော်ရန်';

  @override
  String get tourNewListBody =>
      'ဈေးဝယ်စာရင်းတစ်ခု စတင်ပြီး ဝယ်မည့်အရာများကို ထည့်ပါ။';

  @override
  String get tourFromReceiptBody =>
      'ဝယ်ပြီးပြီလား။ ပြေစာကို ဈေးနှုန်းများနှင့်အတူ စာရင်းအဖြစ် ပြောင်းပါ။';

  @override
  String get tourReceiptFlowBody =>
      'ပြေစာ၏ အပေါ်ဆုံးမှ စပါ- ဦးစွာ ဆိုင်နှင့် ရက်စွဲကို ရိုက်ပြီး ကျန်လိုင်းများဖြင့် ဆက်လုပ်ပါ။';

  @override
  String get tourTabsBody =>
      'အသုံးပြုဆဲ၊ ပြီးဆုံးပြီး နှင့် သိမ်းဆည်းထားသော စာရင်းများကြား ပြောင်းပါ။ အဆုံးရှိ ခလုတ်သည် အစီအစဉ်ကို ပြောင်းသည်။';

  @override
  String get tourDiscoverBody =>
      'တူညီသော ဆော့ဖ်ဝဲရေးသူ၏ အခြားအက်ပ်များကို ကြည့်ပါ။';

  @override
  String get tourHelpBody =>
      'ဤလမ်းညွှန်ကို ထပ်ကြည့်ရန် ဤနေရာကို တို့ပါ။ စုစုပေါင်းနှင့် ပစ္စည်းများ ရှင်းလင်းချက်အတွက် စာရင်းတစ်ခု ဖွင့်ပါ။';

  @override
  String get tourTotalsBody =>
      'စီစဉ်ထားသော၊ အမှန်တကယ် စုစုပေါင်းနှင့် ကွာခြားချက်များ ဈေးဝယ်နေစဉ် အပ်ဒိတ်ဖြစ်သည်။';

  @override
  String get tourItemsBody =>
      'သင့်ပစ္စည်းများ။ ဤနေရာတွင် အစီအစဉ်ပြောင်းပါ သို့မဟုတ် ရှာပါ။';
}
