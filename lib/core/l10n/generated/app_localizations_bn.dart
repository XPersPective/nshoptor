// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan =>
      'বাড়িতে পরিকল্পনা করুন। পরিকল্পনা অনুযায়ী কেনাকাটা করুন।';

  @override
  String get listsTitle => 'তালিকা';

  @override
  String get listsTabActive => 'সক্রিয়';

  @override
  String get listsTabCompleted => 'সম্পন্ন';

  @override
  String get listsTabArchived => 'আর্কাইভ করা';

  @override
  String get newListButton => 'নতুন তালিকা';

  @override
  String get listTitleHint => 'শিরোনাম (ঐচ্ছিক)';

  @override
  String get saveButton => 'সংরক্ষণ';

  @override
  String get cancelButton => 'বাতিল';

  @override
  String get deleteButton => 'মুছুন';

  @override
  String get editAction => 'এডিট';

  @override
  String get listDeleted => 'তালিকা মুছে ফেলা হয়েছে';

  @override
  String get invalidAmountError => 'অবৈধ পরিমাণ';

  @override
  String get duplicateAction => 'ডুপ্লিকেট করুন';

  @override
  String get archiveAction => 'আর্কাইভ করুন';

  @override
  String get unarchiveAction => 'আর্কাইভ থেকে বের করুন';

  @override
  String get deleteListConfirm =>
      'এই তালিকাটি মুছে ফেলবেন? এর পরিকল্পিত আইটেমগুলোও সরানো হবে।';

  @override
  String get undoButton => 'পূর্বাবস্থা';

  @override
  String get searchListHint => 'তালিকা খুঁজুন';

  @override
  String get currencyLabel => 'মুদ্রা';

  @override
  String get budgetLabel => 'বাজেট (ঐচ্ছিক)';

  @override
  String get noteLabel => 'নোট (ঐচ্ছিক)';

  @override
  String get storeLabel => 'দোকান';

  @override
  String get keepAmountsAction => 'পরিমাণ রাখুন';

  @override
  String get resetAmountsAction => 'পরিমাণ রিসেট করুন';

  @override
  String get currencyChangeWarning =>
      'মুদ্রা পরিবর্তন হচ্ছে। বিদ্যমান পরিমাণগুলোর সাথে কী ঘটবে?';

  @override
  String get listsEmpty =>
      'এখনো কোনো তালিকা নেই। আপনার প্রথম কেনাকাটার পরিকল্পনা তৈরি করুন।';

  @override
  String get statusDraft => 'খসড়া';

  @override
  String get statusPlanned => 'পরিকল্পিত';

  @override
  String get statusShopping => 'কেনাকাটা চলছে';

  @override
  String get statusCompleted => 'সম্পন্ন';

  @override
  String get statusArchived => 'আর্কাইভ করা';

  @override
  String autoListTitle(String date) {
    return '$date কেনাকাটা';
  }

  @override
  String get itemFormTitle => 'আইটেম যোগ করুন';

  @override
  String get itemNameLabel => 'আইটেমের নাম';

  @override
  String get brandLabel => 'ব্র্যান্ড / ভেরিয়েন্ট (ঐচ্ছিক)';

  @override
  String get categoryLabel => 'ক্যাটাগরি';

  @override
  String get quantityLabel => 'পরিমাণ';

  @override
  String get unitLabel => 'ইউনিট';

  @override
  String get pricingModeLabel => 'মূল্য ইনপুট';

  @override
  String get pricingModeUnitPrice => 'ইউনিট মূল্য';

  @override
  String get pricingModeLineTotal => 'লাইন মোট';

  @override
  String get plannedPriceLabel => 'পরিকল্পিত মূল্য';

  @override
  String lineTotalCalculated(String value) {
    return 'লাইন মোট: $value';
  }

  @override
  String get requiredItemToggle => 'প্রয়োজনীয় আইটেম';

  @override
  String get maxPriceLabel => 'স্বীকারযোগ্য সর্বোচ্চ মূল্য (ঐচ্ছিক)';

  @override
  String get itemNoteLabel => 'নোট (ঐচ্ছিক)';

  @override
  String get categoryProduce => 'ফল ও সবজি';

  @override
  String get categoryDairy => 'ডেয়ারি';

  @override
  String get categoryMeat => 'মাংস';

  @override
  String get categoryBakery => 'বেকারি';

  @override
  String get categoryDrinks => 'পানীয়';

  @override
  String get categoryCleaning => 'পরিষ্কার-পরিচ্ছন্নতা';

  @override
  String get categoryPersonalCare => 'ব্যক্তিগত যত্ন';

  @override
  String get categoryHome => 'ঘরোয়া';

  @override
  String get categoryOther => 'অন্যান্য';

  @override
  String get invalidQuantityError => 'অবৈধ পরিমাণ';

  @override
  String get invalidPriceError => 'অবৈধ মূল্য';

  @override
  String get invalidNameError => 'একটি নাম লিখুন';

  @override
  String unitPriceCalculated(String value) {
    return 'ইউনিট মূল্য: $value';
  }

  @override
  String get shoppingTitle => 'শপিং মোড';

  @override
  String get summaryPlannedTotal => 'পরিকল্পিত';

  @override
  String get summaryInCart => 'কার্টে আছে';

  @override
  String get summaryRemainingPlan => 'বাকি পরিকল্পনা';

  @override
  String get summaryProjected => 'আনুমানিক চেকআউট';

  @override
  String get summaryBudgetRemaining => 'বাজেট বাকি';

  @override
  String get summaryBudgetOver => 'বাজেটের বেশি';

  @override
  String itemsProgress(String done, String total) {
    return '$total আইটেমের মধ্যে $doneটি';
  }

  @override
  String get filterAll => 'সব';

  @override
  String get filterToBuy => 'কিনতে হবে';

  @override
  String get filterInCart => 'কার্টে আছে';

  @override
  String get filterNotFound => 'পাওয়া যায়নি';

  @override
  String get filterRequired => 'প্রয়োজনীয়';

  @override
  String get quickEntryTitle => 'বাস্তব মূল্য';

  @override
  String get actualQuantityLabel => 'বাস্তব পরিমাণ';

  @override
  String get actualPriceLabel => 'বাস্তব মূল্য';

  @override
  String get discountLabel => 'ছাড় (ঐচ্ছিক)';

  @override
  String get alternativeNameLabel => 'অল্টারনেটিভ পণ্যের নাম (ঐচ্ছিক)';

  @override
  String get savePurchaseButton => 'কার্টে যোগ করুন';

  @override
  String get unplannedAddButton => 'পরিকল্পিত নয় এমন আইটেম যোগ করুন';

  @override
  String get statusPending => 'নেনি নি';

  @override
  String get statusInCart => 'কার্টে আছে';

  @override
  String get statusNotFound => 'পাওয়া যায়নি';

  @override
  String get statusGaveUp => 'হাত ছেড়ে দিয়েছে';

  @override
  String get statusAlternative => 'অল্টারনেটিভ কিনেছে';

  @override
  String get keepScreenAwake => 'স্ক্রিন চালু রাখুন';

  @override
  String get finishShopping => 'শপিং শেষ করুন';

  @override
  String get completionWarning =>
      'কিছু রেকর্ড অনুপস্থিত বা যাচাই করা হয়নি। আপনি এখনও শেষ করতে পারবেন; ফলাফলে এগুলোর উল্লেখ থাকবে।';

  @override
  String get continueShoppingButton => 'শপিং চালিয়ে যান';

  @override
  String get resultTitle => 'ফলাফল';

  @override
  String get summarySection => 'সারাংশ';

  @override
  String get plannedTotalLabel => 'পরিকল্পিত মোট';

  @override
  String get actualTotalLabel => 'বাস্তব মোট';

  @override
  String get varianceLabel => 'পার্থক্য';

  @override
  String get varianceNotComputable => 'গণনা করা যায়নি';

  @override
  String get budgetStatusLabel => 'বাজেট';

  @override
  String get savingsLabel => 'পরিকল্পনার চেয়ে কম';

  @override
  String get overspendLabel => 'পরিকল্পনার চেয়ে বেশি';

  @override
  String get unplannedTotalLabel => 'পরিকল্পিত নয় এমন মোট';

  @override
  String get unpurchasedLabel => 'পরিকল্পিত কিন্তু কেনো হয়নি';

  @override
  String get totalDiscountLabel => 'মোট ছাড়';

  @override
  String get accuracyLabel => 'আনুমানিক নির্ভুলতা';

  @override
  String get groupsSection => 'আইটেম';

  @override
  String get groupPricier => 'পরিকল্পনার চেয়ে দামী';

  @override
  String get groupCheaper => 'পরিকল্পনার চেয়ে সস্তা';

  @override
  String get groupClose => 'আনুমানিকের কাছাকাছি';

  @override
  String get groupNotTaken => 'পরিকল্পিত, কিনা হয়নি';

  @override
  String get groupUnplanned => 'পরিকল্পনা ছাড়াই কেনা হয়েছে';

  @override
  String get groupQuantityChanged => 'পরিমাণ পরিবর্তন হয়েছে';

  @override
  String get groupUnverified => 'যাচাই করা হয়নি';

  @override
  String get plannedQtyLabel => 'পরিকল্পিত পরিমাণ';

  @override
  String get actualQtyLabel => 'বাস্তব পরিমাণ';

  @override
  String get plannedUnitPriceLabel => 'পরিকল্পিত ইউনিট মূল্য';

  @override
  String get actualUnitPriceLabel => 'বাস্তব ইউনিট মূল্য';

  @override
  String get lineVarianceLabel => 'লাইনের পার্থক্য';

  @override
  String get discountEffectLabel => 'ছাড়ের প্রভাব';

  @override
  String get notBoughtMark => 'কেনো হয়নি';

  @override
  String get noPurchasesNote => 'কোনো ক্রয় রেকর্ড করা হয়নি।';

  @override
  String get navHome => 'হোম';

  @override
  String get navLists => 'তালিকা';

  @override
  String get navHistory => 'ইতিহাস';

  @override
  String get navSettings => 'সেটিংস';

  @override
  String get homeEmptyTitle => 'আপনার কেনাকাটার পরিকল্পনা করুন';

  @override
  String get homeEmptyBody =>
      'আপনার প্রথম তালিকা তৈরি করুন এবং পরিকল্পিত ও প্রকৃত খরচের তুলনা করুন।';

  @override
  String get homeActiveSection => 'সক্রিয় তালিকা';

  @override
  String get homeCompletedSection => 'সাম্প্রতিক সম্পন্ন';

  @override
  String get homeMonthlySection => 'এই মাসে';

  @override
  String get monthPlannedLabel => 'পরিকল্পিত';

  @override
  String get monthActualLabel => 'প্রকৃত';

  @override
  String get monthVarianceLabel => 'পার্থক্য';

  @override
  String get continueShoppingLabel => 'কেনাকাটা চালিয়ে যান';

  @override
  String get historyEmpty =>
      'এখনো কোনো সম্পন্ন কেনাকাটা নেই। আপনার ইতিহাস ও অন্তর্দৃষ্টি এখানে দেখা যাবে।';

  @override
  String get aboutTabTitle => 'NShoptor সম্পর্কে';

  @override
  String get aboutBody =>
      'Crazy Penguin-এর তৈরি NShoptor। অফলাইন-ফার্স্ট শপিং প্ল্যানার। GPL-3.0 লাইসেন্সের আওতায়।';

  @override
  String get startShoppingLabel => 'কেনাকাটা শুরু করুন';

  @override
  String get finishAndSeeResult => 'শেষ করুন ও ফলাফল দেখুন';

  @override
  String get settingsTitle => 'সেটিংস';

  @override
  String get languageLabel => 'ভাষা';

  @override
  String get languageSystem => 'সিস্টেম';

  @override
  String get languageTr => 'তুর্কি';

  @override
  String get languageEn => 'ইংরেজি';

  @override
  String get themeLabel => 'থিম';

  @override
  String get themeSystem => 'সিস্টেম';

  @override
  String get themeLight => 'লাইট';

  @override
  String get themeDark => 'ডার্ক';

  @override
  String get defaultCurrencyLabel => 'ডিফল্ট মুদ্রা';

  @override
  String get defaultUnitLabel => 'ডিফল্ট ইউনিট';

  @override
  String get keepAwakeLabel => 'কেনাকাটার সময় স্ক্রিন জাগিয়ে রাখুন';

  @override
  String get backupSection => 'ব্যাকআপ';

  @override
  String get exportBackupLabel => 'ব্যাকআপ এক্সপোর্ট করুন';

  @override
  String get importBackupLabel => 'ব্যাকআপ আমদানি করুন';

  @override
  String get mergeImportLabel => 'বর্তমান ডেটার সাথে মার্জ করুন';

  @override
  String get separateImportLabel => 'আলাদা কপি হিসেবে আমদানি করুন';

  @override
  String get importCancelled => 'আমদানি বাতিল করা হয়েছে।';

  @override
  String get backupExported => 'ব্যাকআপ সফলভাবে এক্সপোর্ট হয়েছে।';

  @override
  String get backupSizeWarning =>
      'বড় ব্যাকআপ: ফাইলটি বড় হতে পারে। আপনি কি ছবিগুলোও অন্তর্ভুক্ত করতে চান?';

  @override
  String get deleteAllSection => 'খतरার জোন';

  @override
  String get deleteAllLabel => 'সব ডেটা মুছে ফেলুন';

  @override
  String get deleteAllConfirm =>
      'এতে সব তালিকা, ইতিহাস, রসিদ ছবি ও দাম মুছে যাবে। আপনার দ্বারা এক্সপোর্ট করা ফাইলগুলো আপনার ড্রাইভে থেকে যাবে। চালিয়ে যাবেন?';

  @override
  String get deleteAllConfirm2 =>
      'আপনি কি সম্পূর্ণ নিশ্চিত? এই কাজ আর বাতিল করা যাবে না।';

  @override
  String get cancelAction => 'বাতিল';

  @override
  String get confirmDelete => 'স্থায়ীভাবে মুছুন';

  @override
  String get dataDeleted => 'সব স্থানীয় ডেটা মুছে ফেলা হয়েছে।';

  @override
  String get privacyInfoLabel => 'গোপনীয়তা';

  @override
  String get privacyInfoBody =>
      'আপনার তালিকা, দাম, রসিদ ও ছবি আপনার ডিভাইসেই থাকে। ছবি ও ভয়েস কখনোই সেখান থেকে বের হয় না। AI সাহায্য সক্রিয় থাকলে, শুধুমাত্র টেক্সট (যেমন রসিদের লাইন বা আপনি যা বলেছেন) প্রক্রিয়া করার জন্য আমাদের সার্ভারে পাঠানো হয় এবং তা সংরক্ষণ করা হয় না।';

  @override
  String get aboutSection => 'সম্পর্কে';

  @override
  String get aboutPublisher => 'প্রকাশক: Crazy Penguin';

  @override
  String get aboutLicenses => 'লাইসেন্স (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'ভয়েস ইনপুট';

  @override
  String get voiceStatusUnknown => 'সার্ভিস: পরীক্ষা করা হয়নি';

  @override
  String get permissionsLabel => 'অনুমতি';

  @override
  String get permissionsBody =>
      'ক্যামেরা, মাইক্রোফোন ও নোটিফিকেশন শুধুমাত্র আপনি আসলে সেই ফিচারগুলো ব্যবহার করলেই অনুরোধ করা হয়।';

  @override
  String get unitsSection => 'ডিফল্ট';

  @override
  String get roundingNote =>
      'টাকার রাউন্ডিং একটি নিয়ম অনুসরণ করে: অর্ধেক সংখ্যাগুলো শূন্য থেকে দূরে রাউন্ড হয়, যা Money কনভার্শনে একবার প্রয়োগ করা হয়।';

  @override
  String get voiceInputTitle => 'ভয়েস ইনপুট';

  @override
  String get voiceStartListening => 'শোনা শুরু করুন';

  @override
  String get voiceTranscriptLabel => 'ট্রান্সক্রিপ্ট';

  @override
  String get parseAction => 'পার্স করুন';

  @override
  String get receiptReviewTitle => 'রসিদ পর্যালোচনা করুন';

  @override
  String get receiptTotal => 'রসিদ মোট';

  @override
  String get receiptTotalUnknown => 'মোট সনাক্ত করা হয়নি';

  @override
  String get receiptDiff => 'পার্থক্য';

  @override
  String get acceptLine => 'লাইন গ্রহণ করুন';

  @override
  String get ignoreLine => 'লাইন বাদ দিন';

  @override
  String get receiptLineActions => 'আইটেমের সাথে লিংক, বিভক্ত বা উপেক্ষা করুন';

  @override
  String get receiptCommit => 'সব গ্রহণ করুন';

  @override
  String get receiptCommitted => 'রসিদ প্রয়োগ করা হয়েছে।';

  @override
  String get priceHistoryTitle => 'মূল্য ইতিহাস';

  @override
  String get noObservations => 'এখনো কোনো মূল্য পর্যবেক্ষণ নেই';

  @override
  String get templatesSection => 'টেমপ্লেট';

  @override
  String get templateHint => 'আগের শপিং ট্রিপ থেকে একটি নতুন প্ল্যান তৈরি করুন';

  @override
  String get scanReceiptAction => 'রসিদ স্ক্যান করুন';

  @override
  String get shelfLabelAction => 'শেলফ লেবেল থেকে মূল্য';

  @override
  String get priceCandidatesTitle => 'মূল্য প্রার্থী';

  @override
  String get noPriceCandidates =>
      'কোনো মূল্য পাওয়া যায়নি; ম্যানুয়ালি লিখুন।';

  @override
  String get voiceUnavailable => 'ভয়েস রিকগনিশন অপ্রাপ্য; ম্যানুয়ালি লিখুন।';

  @override
  String get linkToItem => 'আইটেমের সাথে লিংক করুন';

  @override
  String get splitLine => 'দুই ভাগে বিভক্ত করুন';

  @override
  String get mergeWithNext => 'পরবর্তীর সাথে একত্রিত করুন';

  @override
  String get ocrNoText => 'কোনো টেক্সট পড়া হয়নি; আবার চেষ্টা করুন।';

  @override
  String get priceHistoryAction => 'মূল্য ইতিহাস';

  @override
  String get itemsEmptyTitle => 'এখনো কোনো আইটেম নেই';

  @override
  String get itemsEmptyBody =>
      'আপনার প্রথম আইটেম যোগ করুন — দোকানে গিয়ে আপনি এখানে আসল মূল্য লিখবেন।';

  @override
  String get addItemTooltip => 'আইটেম যোগ করুন';

  @override
  String get unitAdet => 'পিস';

  @override
  String get unitKilogram => 'কেজি';

  @override
  String get unitGram => 'গ্রাম';

  @override
  String get unitLitre => 'লিটার';

  @override
  String get unitMililitre => 'মিলি';

  @override
  String get unitPaket => 'প্যাক';

  @override
  String get unitKutu => 'বক্স';

  @override
  String get unitSise => 'বোতল';

  @override
  String get unitKavanoz => 'জার';

  @override
  String get unitDemet => 'গুচ্ছ';

  @override
  String get unitDuzine => 'ডজন';

  @override
  String get unitMetre => 'মিটার';

  @override
  String get unitCustom => 'কাস্টম';

  @override
  String get setReminderAction => 'রিমাইন্ডার সেট করুন';

  @override
  String get reminderPermissionDenied =>
      'রিমাইন্ডারের জন্য নোটিফিকেশন অনুমতি প্রয়োজন। আপনি সিস্টেম সেটিংসে এটি সক্রিয় করতে পারেন।';

  @override
  String get reminderScheduled => 'রিমাইন্ডার সেট করা হয়েছে।';

  @override
  String get reminderCancelled => 'রিমাইন্ডার সরানো হয়েছে।';

  @override
  String get reminderTitle => 'শপিং রিমাইন্ডার';

  @override
  String reminderBody(Object title) {
    return 'আপনার তালিকা পরীক্ষা করার সময়: $title';
  }

  @override
  String get reminderPickDate => 'একটি তারিখ নির্বাচন করুন';

  @override
  String get reminderPickTime => 'একটি সময় নির্বাচন করুন';

  @override
  String get itemDetailsSection => 'বিস্তারিত';

  @override
  String get priceOptionalHint => 'ঐচ্ছিক — দোকানে গিয়ে আপনি আসল মূল্য লিখবেন';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'পরিকল্পিত: $total · $count আইটেম';
  }

  @override
  String get proActiveLabel => 'Pro সক্রিয় — ধন্যবাদ!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'বিজ্ঞাপন মুক্ত, আরও AI, ব্যাকআপ · ছোট মাসিক মূল্য থেকে শুরু';

  @override
  String get proBenefitNoAds => 'বিজ্ঞাপন মুক্ত অভিজ্ঞতা';

  @override
  String get proBenefitBackup => 'ব্যাকআপ (এক্সপোর্ট/ইম্পোর্ট)';

  @override
  String aboutVersion(Object version) {
    return 'ভার্সন $version';
  }

  @override
  String get navDiscover => 'অনুসন্ধান';

  @override
  String get shareAction => 'অ্যাপটি শেয়ার করুন';

  @override
  String get rateAction => 'আমাদের রেট করুন';

  @override
  String get aboutOpenRow => 'সম্পর্কে ও ওপেন সোর্স';

  @override
  String get voiceAddItemAction => 'ভয়েস দিয়ে যোগ করুন';

  @override
  String get formatLocaleLabel => 'সংখ্যা ও মুদ্রার ফরম্যাট';

  @override
  String get formatLocaleSystem =>
      'ডিভাইস ফরম্যাট (ল্যাটিন ডিজিট; অন্যথায় ইংরেজি)';

  @override
  String get formatLocaleTr => 'তুর্কি (1.234,56)';

  @override
  String get formatLocaleEn => 'ইংরেজি (1,234.56)';

  @override
  String get aiToggleTitle => 'AI সাহায্য';

  @override
  String get aiToggleSubtitle =>
      'রসিদ মিলিয়ে নেয়, দামের লেবেল পড়ে এবং বাক্যকে তালিকায় পরিণত করে। ছবি ও ভয়েস আপনার ডিভাইসেই থাকে; শুধুমাত্র টেক্সট প্রক্রিয়া করা হয়।';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'এই মাসের AI অনুরোধ ($used/$limit) আপনি ব্যবহার করেছেন। আরও পেতে আপগ্রেড করুন অথবা AI ছাড়া চালিয়ে যান।';
  }

  @override
  String get aiOffline => 'কানেকশন নেই — AI ছাড়া চালিয়ে যাচ্ছি।';

  @override
  String get aiFailed => 'AI বর্তমানে উপলব্ধ নয় — এটি ছাড়া চালিয়ে যাচ্ছি।';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'ডিভাইস';

  @override
  String get quickListAction => 'একটি বাক্য থেকে যোগ করুন';

  @override
  String get quickListTitle => 'দ্রুত তালিকা';

  @override
  String get quickListHint => 'যেমন: ১ কেজি আপেল ২০, ২টি রুটি, অর্ধ কেজি পনির';

  @override
  String get quickListConvert => 'তালিকায় পরিণত করুন';

  @override
  String quickListAdd(int count) {
    return '$count আইটেম যোগ করুন';
  }

  @override
  String get quickListEmpty =>
      'কোনো আইটেম পাওয়া যায়নি। কমা দিয়ে আলাদা করে লিখতে চেষ্টা করুন।';

  @override
  String get receiptAiMatched =>
      'AI আপনার তালিকার সাথে রসিদ মিলিয়েছে। লিংকগুলো পরীক্ষা করুন এবং নিশ্চিত করুন।';

  @override
  String get receiptNeedsCheck => 'এই মিল পরীক্ষা করুন';

  @override
  String get receiptDiscountLine => 'ছাড়';

  @override
  String get compareItem => 'আইটেম';

  @override
  String get compareEstimated => 'আনুমানিক';

  @override
  String get compareActual => 'বাস্তব';

  @override
  String get compareDiff => 'পার্থক্য';

  @override
  String get compareTotal => 'মোট';

  @override
  String get compareBudget => 'বাজেট';

  @override
  String get compareNotBought => 'কেনা হয়নি';

  @override
  String get compareUnplanned => 'পরিকল্পনা করা হয়নি';

  @override
  String get pricierItems => 'বেশি খরচ হয়েছে';

  @override
  String get cheaperItems => 'কম খরচ হয়েছে';

  @override
  String get compareAction => 'তুলনা করুন';

  @override
  String get detailsSection => 'বিস্তারিত';

  @override
  String get spendingTitle => 'খরচ';

  @override
  String get spendingAction => 'খরচ';

  @override
  String get spendingMonthTotal => 'এই মাসে';

  @override
  String get spendingWeekly => 'সাপ্তাহিক খরচ';

  @override
  String get spendingMonthly => 'মাসিক খরচ';

  @override
  String get monthlyLimitTitle => 'মাসিক সীমা';

  @override
  String get monthlyLimitHelp =>
      'আপনি প্রতি মাসে কেনাকাটার জন্য কত খরচ করতে চান?';

  @override
  String get monthlyLimitRemove => 'সরান';

  @override
  String get monthlyLimitSet => 'সেট করুন';

  @override
  String get monthlyLimitChange => 'পরিবর্তন করুন';

  @override
  String get monthlyLimitNone =>
      'কত টাকা অবশিষ্ট আছে তা দেখতে একটি মাসিক সীমা সেট করুন।';

  @override
  String monthlyLimitOver(String amount) {
    return 'সীমার $amount বেশি';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return 'এই মাসে $amount অবশিষ্ট';
  }

  @override
  String get plansTitle => 'প্ল্যান';

  @override
  String get plansHeadline => 'AI দিয়ে স্মার্টভাবে কেনাকাটা করুন';

  @override
  String get plansSubhead =>
      'রসিদ মিলানো, দামের লেবেল এবং বাক্য থেকে তালিকা। যেকোনো সময় বাতিল করুন।';

  @override
  String get plansMonthly => 'মাসিক';

  @override
  String get plansYearly => 'বার্ষিক';

  @override
  String get planFree => 'ফ্রি';

  @override
  String get planFreePrice => 'সর্বদা ফ্রি';

  @override
  String get planFreeAi => 'প্রতি মাসে 10টি AI অনুরোধ';

  @override
  String get planFreeAds =>
      'ছোট ব্যানার বিজ্ঞাপন (প্রথম ৭ দিনে কোনো বিজ্ঞাপন নেই)';

  @override
  String get planCoreFeatures => 'তালিকা, দাম, রসিদ, খরচ চার্ট';

  @override
  String get plansPerYear => '/ বছর';

  @override
  String get plansPerMonth => '/ মাস';

  @override
  String get planTrial => '৭ দিন ফ্রি';

  @override
  String get planProAi => 'প্রতি মাসে 100টি AI অনুরোধ';

  @override
  String get planNoAds => 'কোনো বিজ্ঞাপন নেই';

  @override
  String get planBackup => 'ব্যাকআপ এক্সপোর্ট ও ইম্পোর্ট';

  @override
  String get planMaxAi => 'প্রতি মাসে 300টি AI রিকোয়েস্ট';

  @override
  String get planMaxFamily => 'বড় পরিবারের শপিংয়ের জন্য';

  @override
  String get plansStoreUnavailable => 'বর্তমানে দোকানটি পাওয়া যাচ্ছে না।';

  @override
  String get retryAction => 'আবার চেষ্টা করুন';

  @override
  String get plansPurchaseFailed =>
      'ক্রয় সম্পন্ন হয়নি। অনুগ্রহ করে আবার চেষ্টা করুন।';

  @override
  String get planLifetimeTitle => 'জীবনকাল জুড়ে বিজ্ঞাপনমুক্ত';

  @override
  String get planLifetimeSubtitle =>
      'এককালীন পেমেন্ট: কোনো বিজ্ঞাপন নেই, ব্যাকআপ; AI ফ্রি অ্যালোয়েন্সে চালু থাকবে';

  @override
  String get plansRestore => 'ক্রয় পুনরুদ্ধার করুন';

  @override
  String get plansLegal =>
      'সাবস্ক্রিপশন বাতিল না করা পর্যন্ত স্বয়ংক্রিয়ভাবে নবায়িত হবে। যেকোনো সময় Google Play › Payments & subscriptions থেকে বাতিল করুন। মূল্যে Google Play-এ প্রদর্শিত কর অন্তর্ভুক্ত।';

  @override
  String get planCurrent => 'বর্তমান';

  @override
  String get planStartTrial => '৭ দিনের ফ্রি ট্রায়াল শুরু করুন';

  @override
  String get planChoose => 'বাছাই করুন';

  @override
  String get plansAction => 'প্ল্যান: Pro এবং Max';

  @override
  String get assistantTitle => 'অ্যাসিস্ট্যান্ট';

  @override
  String get assistantGreeting => 'হ্যালো! আপনি কী করতে চান?';

  @override
  String get assistantNewList => 'নতুন তালিকা';

  @override
  String get assistantVoiceList => 'ভয়েস দিয়ে তালিকা';

  @override
  String get assistantTextList => 'একটি বাক্য থেকে তালিকা';

  @override
  String get assistantScanReceipt => 'রসিদ স্ক্যান করুন';

  @override
  String get assistantSpending => 'আমার খরচ';

  @override
  String get assistantReceiptHint =>
      'আপনার তালিকা খুলুন এবং এটি স্ক্যান করতে রসাইড আইকনে ট্যাপ করুন।';

  @override
  String get assistantToggleTitle => 'অ্যাসিস্ট্যান্ট দেখান';

  @override
  String get assistantToggleSubtitle => 'ডানদিকে নিচে ছোট্ট সহায়ক';

  @override
  String get scanPriceLabel => 'মূল্য লেবেল স্ক্যান করুন';

  @override
  String get saveFailed =>
      'সেভ করা যায়নি। আপনার পরিবর্তনগুলো এখনও আছে। অনুগ্রহ করে আবার চেষ্টা করুন।';

  @override
  String get deleteItemConfirm =>
      'এই আইটেমটি এবং এর রেকর্ডকৃত ক্রয় মুছে ফেলবেন?';

  @override
  String get clearPurchaseConfirm =>
      'এই আইটেমটি থেকে টিকচিহ্ন সরিয়ে এর রেকর্ডকৃত ক্রয় মুছে ফেলবেন?';

  @override
  String get reportPdfAction => 'PDF রিপোর্ট সেভ করুন';

  @override
  String get reportNotInvoice => 'শপিং সারাংশ, কর ইনভয়েস নয়। করের হার অজানা।';

  @override
  String get purchaseVisits => 'শপিং ভিজিট';

  @override
  String get purchaseInterval => 'ক্রয়ের মধ্যে গড় দিন';

  @override
  String get purchasedQuantity => 'ক্রয়কৃত পরিমাণ';

  @override
  String get purchaseAnalyticsHint =>
      'ক্রয় খরচ পরিমাপ করে না। মুদ্রা এবং একক আলাদাভাবে দেখানো হয়।';

  @override
  String get receiptReplaces =>
      'লিংকযুক্ত রসিদ লাইন বিদ্যমান ক্রয় প্রতিস্থাপন করে; অলিংকযুক্ত লাইন যোগ করা হয়।';

  @override
  String get voiceUnsupportedLanguage =>
      'এই ডিভাইসে ভয়েস ইনপুটের জন্য এই ভাষা উপলব্ধ নেই। আপনি টাইপ করতে পারেন।';

  @override
  String get voiceStopListening => 'শোনা বন্ধ করুন';

  @override
  String get keepAwakeFailed =>
      'স্ক্রিন জাগিয়ে রাখা যায়নি। অনুগ্রহ করে আবার চেষ্টা করুন।';

  @override
  String get purchaseHistoryHint =>
      'সমস্ত সম্পন্ন কেনাকাটা। রিটার্ন মোটের পরিমাণ কমায়। তারিখগুলো কেনাকাটা শেষ হওয়ার দিন নির্দেশ করে। গড় ব্যবধান বের করতে একটি ভিজিট যথেষ্ট নয়।';

  @override
  String get planLegacyRights =>
      'বর্তমান Pro এবং Max সাবস্ক্রিপশনগুলি তাদের মাসিক AI অ্যালোয়েন্স বজায় রাখবে। নতুন অফারে ১০০ এবং ৩০০ রিকোয়েস্ট রয়েছে।';
}
