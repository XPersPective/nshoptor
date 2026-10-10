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
  String get backupSizeWarning =>
      'Backup အရွယ်အစား ကြီးမားနေသည် - ဖိုင်သည် ကြီးမားနိုင်ပါသည်။ ဓာတ်ပုံများကိုပါ ထည့်သွင်းမည်လား?';

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
      'သင့်စာရင်းများ၊ ဈေးနှုန်းများ၊ receipts နှင့် ဓာတ်ပုံများသည် သင့်ဖုန်းတွင်သာ ရှိနေမည်ဖြစ်ပါသည်။ ဓာတ်ပုံများနှင့် အသံများသည် ဖုန်းမှ မထွက်ခွာပါ။ AI help ကို အသုံးပြုနေပါက စာသားများ (ဥပမာ - receipt များ သို့မဟုတ် သင်ပြောဆိုခဲ့သော စာသားများ) ကိုသာ server သို့ ပို့ဆောင်ပြီး ပြုပြင်လုပ်ဆောင်ကာ သိမ်းဆည်းထားခြင်း မရှိပါ။';

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
      'ကြော်ငြာ မရှိ၊ AI ပိုများ၊ Backup · လစဉ် ဈေးနှုန်းနည်းနည်းလေးကနေ';

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
      'ရီးဆစ်များကို ကိုက်ညီစေပြီး၊ ဈေးနှုန်းစတicker များကိုဖတ်ကာ စာသားများကို စာရင်းအဖြစ်ပြောင်းပေးသည်။ ဓာတ်ပုံနှင့်အသံများသည် သင့်စက်တွင်ရှိနေပါမည် - စာသားသာ ပြန်လည်သုံးသပ်ခြင်းဖြစ်သည်။';

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
  String get planFreeAi => 'တစ်လလျှင် AI တောင်းဆိုမှု ၁၅ ခု';

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
  String get planTrial => '၇ ရက် အခမဲ့';

  @override
  String get planProAi => 'တစ်လလျှင် AI တောင်းဆိုမှု ၂၀၀';

  @override
  String get planNoAds => 'Ads မရှိ';

  @override
  String get planBackup => 'Backup ထုတ်ယူခြင်းနှင့် ဝင်ရောက်ခြင်း';

  @override
  String get planMaxAi => 'လစဉ် AI တောင်းဆိုမှု ၁၀၀၀';

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
  String get planLifetimeTitle => 'ဘဝတစ်လျှောက်လုံး အော်ဂဲနစ်မဲ့';

  @override
  String get planLifetimeSubtitle =>
      'တစ်ကြိမ်သာပေးချေရန်: အော်ဂဲနစ်မဲ့၊ backup; AI သည် အခမဲ့အကန့်အသတ်တွင် ရှိနေမည်';

  @override
  String get plansRestore => 'ဝယ်ယူမှုများကို ပြန်လည်ထူထောင်ခြင်း';

  @override
  String get plansLegal =>
      'Subscription များသည် ဖျက်သိမ်းသည်အထိ အလိုအလျောက် ပြန်လည်ဖြစ်ပေါ်ပါသည်။ Google Play › Payments & subscriptions တွင် မည်သည့်အချိန်တွင်မဆို ဖျက်သိမ်းနိုင်ပါသည်။ ဈေးနှုန်းများတွင် Google Play ကပြထားသော နှစ်စဉ်ခွန်များ ပါဝင်ပါသည်။';

  @override
  String get planCurrent => 'လက်ရှိ';

  @override
  String get planStartTrial => 'ရက် ၇ ရက် အခမဲ့ စမ်းသပ်မှုကို စတင်ပါ';

  @override
  String get planChoose => 'ရွေးချယ်ပါ';

  @override
  String get plansAction => 'စီမံချက်များ: Pro နှင့် Max';

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
      'ချိတ်ဆက်ထားသော လက်မှတ်လိုင်းများသည် ရှိပြီးသား ဝယ်ယူမှုများကို အစားထိုးပြီး၊ မချိတ်ဆက်ထားသော လိုင်းများကို ထည့်သွင်းပါသည်။';

  @override
  String get voiceUnsupportedLanguage =>
      'ဤဘာသာစကားကို ဤစက်ပစ္စည်းတွင် အသံဖြင့် ထည့်သွင်းရန် မရရှိနိုင်ပါ။ အစားထိုး၍ ရိုက်ထည့်နိုင်ပါသည်။';

  @override
  String get voiceStopListening => 'နားထောင်ခြင်း ရပ်မည်';

  @override
  String get keepAwakeFailed => 'စکرဉ်ကို မိတ်ဆက်မရပါ။ ပြန်လည်ကြိုးစားပါ။';

  @override
  String get purchaseHistoryHint =>
      'ပြီးပြည့်စုံသော ဈေးဝယ်မှုအားလုံးပါဝင်သည်။ ပြန်လည်ပေးချေမှုများသည် စုစုပေါင်းကို လျှော့ချပေးသည်။ ရက်စွဲများသည် ဈေးဝယ်မှု ပြီးဆုံးချိန်ကို ဆိုလိုသည်။ တစ်ကြိမ်တည်း ဝယ်ယူခြင်းသည် ပျမ်းမျှကာလကို တွက်ချက်ရန် မလုံလောက်ပါ။';
}
