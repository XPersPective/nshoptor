// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Georgian (`ka`).
class AppLocalizationsKa extends AppLocalizations {
  AppLocalizationsKa([String locale = 'ka']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'გეგმეთ სახლში. იყიდეთ გეგმის მიხედვით.';

  @override
  String get listsTitle => 'სიები';

  @override
  String get listsTabActive => 'აქტიური';

  @override
  String get listsTabCompleted => 'დასრულებული';

  @override
  String get listsTabArchived => 'არქივი';

  @override
  String get newListButton => 'ახალი სია';

  @override
  String get listTitleHint => 'სათაური (სურვილისამებრ)';

  @override
  String get saveButton => 'შენახვა';

  @override
  String get cancelButton => 'გაუქმება';

  @override
  String get deleteButton => 'წაშლა';

  @override
  String get editAction => 'რედაქტირება';

  @override
  String get listDeleted => 'სია წაიშალა';

  @override
  String get invalidAmountError => 'არასწორი რაოდენობა';

  @override
  String get duplicateAction => 'დუბლირება';

  @override
  String get archiveAction => 'არქივირება';

  @override
  String get unarchiveAction => 'არქივიდან ამოღება';

  @override
  String get deleteListConfirm =>
      'ნამდვილად გსურთ ამ სიის წაშლა? დაგეგმილი ნივთებიც წაიშლება.';

  @override
  String get undoButton => 'უკან დაბრუნება';

  @override
  String get searchListHint => 'ძიება სიებში';

  @override
  String get currencyLabel => 'ვალუტა';

  @override
  String get budgetLabel => 'ბიუჯეტი (სურვილისამებრ)';

  @override
  String get noteLabel => 'შენიშვნა (სურვილისამებრ)';

  @override
  String get storeLabel => 'მაღაზია';

  @override
  String get keepAmountsAction => 'რაოდენობების შენარჩუნება';

  @override
  String get resetAmountsAction => 'რაოდენობების განულება';

  @override
  String get currencyChangeWarning =>
      'ვალუტა იცვლება. რა მოხდება არსებულ რაოდენობებთან?';

  @override
  String get listsEmpty =>
      'ჯერჯერობით სიები არ არის. შექმენით თქვენი პირველი ყიდვის გეგმა.';

  @override
  String get statusDraft => 'პროექტი';

  @override
  String get statusPlanned => 'დაგეგმილი';

  @override
  String get statusShopping => 'ყიდვა';

  @override
  String get statusCompleted => 'დასრულებული';

  @override
  String get statusArchived => 'არქივი';

  @override
  String autoListTitle(String date) {
    return '$date-ის ყიდვა';
  }

  @override
  String get itemFormTitle => 'ნივთის დამატება';

  @override
  String get itemNameLabel => 'ნივთის სახელი';

  @override
  String get brandLabel => 'ბრენდი / ვარიანტი (სურვილისამებრ)';

  @override
  String get categoryLabel => 'კატეგორია';

  @override
  String get quantityLabel => 'რაოდენობა';

  @override
  String get unitLabel => 'ერთეული';

  @override
  String get pricingModeLabel => 'ფასის შეყვანის რეჟიმი';

  @override
  String get pricingModeUnitPrice => 'ერთეულის ფასი';

  @override
  String get pricingModeLineTotal => 'სტრიქონის ჯამი';

  @override
  String get plannedPriceLabel => 'დაგეგმილი ფასი';

  @override
  String lineTotalCalculated(String value) {
    return 'სტრიქონის ჯამი: $value';
  }

  @override
  String get requiredItemToggle => 'სავალდებულო ნივთი';

  @override
  String get maxPriceLabel => 'მაქსიმალური დასაშვები ფასი (სურვილისამებრ)';

  @override
  String get itemNoteLabel => 'შენიშვნა (სურვილისამებრ)';

  @override
  String get categoryProduce => 'ხილი და ბოსტნეული';

  @override
  String get categoryDairy => 'რძის პროდუქტები';

  @override
  String get categoryMeat => 'ხორცი';

  @override
  String get categoryBakery => 'საკონდიტრო';

  @override
  String get categoryDrinks => 'სასმელები';

  @override
  String get categoryCleaning => 'საყოფაცხოვრებო ქიმია';

  @override
  String get categoryPersonalCare => 'პირადი ჰიგიენა';

  @override
  String get categoryHome => 'სახლისთვის';

  @override
  String get categoryOther => 'სხვა';

  @override
  String get invalidQuantityError => 'არასწორი რაოდენობა';

  @override
  String get invalidPriceError => 'არასწორი ფასი';

  @override
  String get invalidNameError => 'შეიყვანეთ სახელი';

  @override
  String unitPriceCalculated(String value) {
    return 'ერთეულის ფასი: $value';
  }

  @override
  String get shoppingTitle => 'ყიდვის რეჟიმი';

  @override
  String get summaryPlannedTotal => 'დაგეგმილი';

  @override
  String get summaryInCart => 'კალათაში';

  @override
  String get summaryRemainingPlan => 'დარჩენილი გეგმა';

  @override
  String get summaryProjected => 'მიახლოებით ჯამი';

  @override
  String get summaryBudgetRemaining => 'ბიუჯეტის დარჩენილი ნაწილი';

  @override
  String get summaryBudgetOver => 'ბიუჯეტს გადაჭარბებული';

  @override
  String itemsProgress(String done, String total) {
    return '$done / $total პროდუქტი';
  }

  @override
  String get filterAll => 'ყველა';

  @override
  String get filterToBuy => 'ყიდვა';

  @override
  String get filterInCart => 'კალათაშია';

  @override
  String get filterNotFound => 'ნაპოვნია';

  @override
  String get filterRequired => 'საჭიროა';

  @override
  String get quickEntryTitle => 'რეალური ფასი';

  @override
  String get actualQuantityLabel => 'რეალური რაოდენობა';

  @override
  String get actualPriceLabel => 'რეალური ფასი';

  @override
  String get discountLabel => 'ფასდაკლება (სურვილისამებრ)';

  @override
  String get alternativeNameLabel =>
      'ალტერნატიული პროდუქტის სახელი (სურვილისამებრ)';

  @override
  String get savePurchaseButton => 'კალათაში დამატება';

  @override
  String get unplannedAddButton => 'დაგეგმილი არყოფილი პროდუქტის დამატება';

  @override
  String get statusPending => 'არ არის აღებული';

  @override
  String get statusInCart => 'კალათაშია';

  @override
  String get statusNotFound => 'ნაპოვნია';

  @override
  String get statusGaveUp => 'თავი მოვაცილე';

  @override
  String get statusAlternative => 'ალტერნატიული შევიძინე';

  @override
  String get keepScreenAwake => 'ეკრანის გაღვივება';

  @override
  String get finishShopping => 'ყიდვის დასრულება';

  @override
  String get completionWarning =>
      'არის გამოუკვლევ ან დაუდასტურებელი ჩანაწერები. შეგიძლიათ მაინც დაასრულოთ; შედეგში ეს მითითდება.';

  @override
  String get continueShoppingButton => 'ყიდვის გაგრძელება';

  @override
  String get resultTitle => 'შედეგი';

  @override
  String get summarySection => 'შეჯამება';

  @override
  String get plannedTotalLabel => 'დაგეგმილი ჯამი';

  @override
  String get actualTotalLabel => 'რეალური ჯამი';

  @override
  String get varianceLabel => 'სხვაობა';

  @override
  String get varianceNotComputable => 'გამოთვლა შეუძლებელია';

  @override
  String get budgetStatusLabel => 'ბიუჯეტი';

  @override
  String get savingsLabel => 'გეგმაზე ნაკლები';

  @override
  String get overspendLabel => 'გეგმაზე მეტი';

  @override
  String get unplannedTotalLabel => 'დაგეგმილი არყოფილი ჯამი';

  @override
  String get unpurchasedLabel => 'დაგეგმილი, მაგრამ არ შევიძინეთ';

  @override
  String get totalDiscountLabel => 'ჯამური ფასდაკლებები';

  @override
  String get accuracyLabel => 'მიახლოების სიზუსტე';

  @override
  String get groupsSection => 'პროდუქტები';

  @override
  String get groupPricier => 'დაგეგმილზე ძვირი';

  @override
  String get groupCheaper => 'დაგეგმილზე იაფი';

  @override
  String get groupClose => 'მიახლოებითი';

  @override
  String get groupNotTaken => 'დაგეგმილი, მაგრამ არ შევიძინეთ';

  @override
  String get groupUnplanned => 'დაგეგმილი არყოფილი შევიძინეთ';

  @override
  String get groupQuantityChanged => 'რაოდენობა შეიცვალა';

  @override
  String get groupUnverified => 'დაუდასტურებელი';

  @override
  String get plannedQtyLabel => 'დაგეგმილი რაოდენობა';

  @override
  String get actualQtyLabel => 'რეალური რაოდენობა';

  @override
  String get plannedUnitPriceLabel => 'დაგეგმილი ერთეულის ფასი';

  @override
  String get actualUnitPriceLabel => 'რეალური ერთეულის ფასი';

  @override
  String get lineVarianceLabel => 'სტრიქონის სხვაობა';

  @override
  String get discountEffectLabel => 'ფასდაკლების ეფექტი';

  @override
  String get notBoughtMark => 'არ შევიძინეთ';

  @override
  String get noPurchasesNote => 'ყიდვები არ ჩანს.';

  @override
  String get navHome => 'მთავარი';

  @override
  String get navLists => 'სიები';

  @override
  String get navHistory => 'ისტორია';

  @override
  String get navSettings => 'პარამეტრები';

  @override
  String get homeEmptyTitle => 'გეგმეთ ყიდვები';

  @override
  String get homeEmptyBody =>
      'შექმენით პირველი სია და შეადარეთ გეგმიური და რეალური ხარჯები.';

  @override
  String get homeActiveSection => 'აქტიური სიები';

  @override
  String get homeCompletedSection => 'ბოლოს დასრულებული';

  @override
  String get homeMonthlySection => 'ამ თვეში';

  @override
  String get monthPlannedLabel => 'გეგმიური';

  @override
  String get monthActualLabel => 'რეალური';

  @override
  String get monthVarianceLabel => 'სხვაობა';

  @override
  String get continueShoppingLabel => 'ყიდვის გაგრძელება';

  @override
  String get historyEmpty =>
      'ჯერ არცერთი ყიდვა არ დაგიდურებიათ. ისტორია და ანალიტიკა აქ გამოჩნდება.';

  @override
  String get aboutTabTitle => 'NShoptor-ის შესახებ';

  @override
  String get aboutBody =>
      'NShoptor Crazy Penguin-ისგან. ოფლაინ-პირველი ყიდვების გეგმარი. ლიცენზირებულია GPL-3.0-ით.';

  @override
  String get startShoppingLabel => 'ყიდვის დაწყება';

  @override
  String get finishAndSeeResult => 'დასრულება და შედეგის ნახვა';

  @override
  String get settingsTitle => 'პარამეტრები';

  @override
  String get languageLabel => 'ენა';

  @override
  String get languageSystem => 'სისტემის';

  @override
  String get languageTr => 'თურქული';

  @override
  String get languageEn => 'ინგლისური';

  @override
  String get themeLabel => 'თემა';

  @override
  String get themeSystem => 'სისტემის';

  @override
  String get themeLight => 'ღია';

  @override
  String get themeDark => 'მუქი';

  @override
  String get defaultCurrencyLabel => 'ვალუტა ნაგულისხმევად';

  @override
  String get defaultUnitLabel => 'ერთეული ნაგულისხმევად';

  @override
  String get keepAwakeLabel => 'ეკრანის გათიშვის თავიდან აცილება ყიდვის დროს';

  @override
  String get backupSection => 'ბექაპი';

  @override
  String get exportBackupLabel => 'ბექაპის ექსპორტი';

  @override
  String get importBackupLabel => 'ბექაპის იმპორტი';

  @override
  String get mergeImportLabel => 'მიმდინარე მონაცემებთან შერწყმა';

  @override
  String get separateImportLabel => 'იმპორტი ცალკე კოპიად';

  @override
  String get importCancelled => 'იმპორტი გაუქმდა.';

  @override
  String get backupExported => 'ბექაპ წარმატებით ექსპორტირდა.';

  @override
  String get deleteAllSection => 'საშიში ზონა';

  @override
  String get deleteAllLabel => 'ყველა მონაცემის წაშლა';

  @override
  String get deleteAllConfirm =>
      'ეს ქმედება წაშლის ყველა სიას, ისტორიას, ქვითრების ფოტოებსა და ფასებს. თქვენს მიერ ექსპორტირებული ფაილები თქვენს საცავში დარჩება. გსურთ გაგრძელება?';

  @override
  String get deleteAllConfirm2 =>
      'ნამდვილად ხართ დარწმუნებული? ამ მოქმედების უკან დაბრუნება შეუძლებელია.';

  @override
  String get cancelAction => 'გაუქმება';

  @override
  String get confirmDelete => 'მუდმივად წაშლა';

  @override
  String get dataDeleted => 'ყველა ადგილობრივი მონაცემი წაიშალა.';

  @override
  String get privacyInfoLabel => 'კონფიდენციალურობა';

  @override
  String get privacyInfoBody =>
      'თქვენი სიები, ფასები, ჩეკები და ფოტოები ინახება თქვენს მოწყობილობაზე. ხმა მას არასოდეს ტოვებს. როცა AI დახმარება ჩართულია, ჩეკებისა და ფასების ეტიკეტების ფოტოები (შემცირებული ზომით) და ტექსტი, მაგალითად, კარნახით შეყვანილი ნივთები, იგზავნება ჩვენს სერვერზე მხოლოდ წასაკითხად; ისინი მუშავდება დაუყოვნებლივ და არასოდეს ინახება.';

  @override
  String get aboutSection => 'შესახებ';

  @override
  String get aboutPublisher => 'გამომცემელი: Crazy Penguin';

  @override
  String get aboutLicenses => 'ლიცენზიები (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'ხმოვანი შეყვანა';

  @override
  String get voiceStatusUnknown => 'სერვისი: შემოწმებული არ არის';

  @override
  String get permissionsLabel => 'ნებართვები';

  @override
  String get permissionsBody =>
      'კამერა, მიკროფონი და შეტყობინებები ითხოვება მხოლოდ მაშინ, როდესაც ამ ფუნქციებს სინამდვილეში იყენებთ.';

  @override
  String get unitsSection => 'ნაგულისხმევები';

  @override
  String get roundingNote =>
      'ფულის შეკრულება ერთი წესის მიხედვით ხდება: ნახევრები ნულს შორდება, ერთხელ მოქმედებს ფულის კონვერტაციისას.';

  @override
  String get voiceInputTitle => 'ხმოვანი შეყვანა';

  @override
  String get voiceStartListening => 'უსმენის დაწყება';

  @override
  String get voiceTranscriptLabel => 'ტრანსკრიპტი';

  @override
  String get parseAction => 'ანალიზი';

  @override
  String get receiptReviewTitle => 'ჩეკის გადახედვა';

  @override
  String get receiptTotal => 'შეკვეთის ჯამი';

  @override
  String get receiptTotalUnknown => 'ჯამი არ არის განსაზღვრული';

  @override
  String get receiptDiff => 'სხვაობა';

  @override
  String get acceptLine => 'დადასტურება';

  @override
  String get ignoreLine => 'გამოტოვება';

  @override
  String get receiptLineActions => 'დააკავშირე პროდუქტთან, გაყავი ან გამოტოვე';

  @override
  String get receiptCommit => 'ყველას დადასტურება';

  @override
  String get receiptCommitted => 'შეკვეთა დამუშავდა.';

  @override
  String get priceHistoryTitle => 'ფასების ისტორია';

  @override
  String get noObservations => 'ფასების მონაცემები ჯერ არ არის';

  @override
  String get templatesSection => 'შაბლონები';

  @override
  String get templateHint => 'შექმენი ახალი სია წინა ყიდვის მიხედვით';

  @override
  String get scanReceiptAction => 'შეკვეთის სკანირება';

  @override
  String get fromReceiptListButton => 'ქვითრიდან';

  @override
  String get shelfLabelAction => 'ფასი ეტიკეტიდან';

  @override
  String get priceCandidatesTitle => 'ფასის ვარიანტები';

  @override
  String get noPriceCandidates => 'ფასი ვერ მოიძებნა; შეიყვანეთ ხელით.';

  @override
  String get voiceUnavailable => 'ხმოვანი აღქმა შეუძლებელია; შეიყვანეთ ხელით.';

  @override
  String get linkToItem => 'დააკავშირე პროდუქტთან';

  @override
  String get splitLine => 'გაყოფა ორად';

  @override
  String get mergeWithNext => 'ერთიანება შემდეგთან';

  @override
  String get ocrNoText => 'ტექსტი ვერ იკითხა; სცადეთ თავიდან.';

  @override
  String get priceHistoryAction => 'ფასების ისტორია';

  @override
  String get itemsEmptyTitle => 'ჯერ არ არის პროდუქტები';

  @override
  String get itemsEmptyBody =>
      'დაამატეთ პირველი პროდუქტი — მაღაზიაში ნამდვილ ფასებს აქ შეიყვანთ.';

  @override
  String get addItemTooltip => 'პროდუქტის დამატება';

  @override
  String get unitAdet => 'ტომი';

  @override
  String get unitKilogram => 'კგ';

  @override
  String get unitGram => 'გრ';

  @override
  String get unitLitre => 'ლ';

  @override
  String get unitMililitre => 'მლ';

  @override
  String get unitPaket => 'პაკეტი';

  @override
  String get unitKutu => ' ყუთი';

  @override
  String get unitSise => 'შუშის ბოთლი';

  @override
  String get unitKavanoz => 'კონსერვა';

  @override
  String get unitDemet => 'სხივი';

  @override
  String get unitDuzine => 'დუზინი';

  @override
  String get unitMetre => 'მ';

  @override
  String get unitCustom => 'საკუთარი';

  @override
  String get setReminderAction => 'შეხსენების დაყენება';

  @override
  String get reminderPermissionDenied =>
      'შეხსენებებისთვის საჭიროა შეტყობინებების ნებართვა. შეგიძლიათ ჩართოთ სისტემის პარამეტრებში.';

  @override
  String get reminderScheduled => 'შეხსენება დაყენდა.';

  @override
  String get reminderCancelled => 'შეხსენება გაუქმდა.';

  @override
  String get reminderTitle => 'ყიდვის შეხსენება';

  @override
  String reminderBody(Object title) {
    return 'დროა შეამოწმოთ სია: $title';
  }

  @override
  String get reminderPickDate => 'აირჩიეთ თარიღი';

  @override
  String get reminderPickTime => 'აირჩიეთ დრო';

  @override
  String get itemDetailsSection => 'დეტალები';

  @override
  String get priceOptionalHint =>
      'არასავალდებულო — ნამდვილი ფასი მაღაზიაში შეიყვანეთ';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'გეგმიური: $total · $count პროდუქტი';
  }

  @override
  String get proActiveLabel => 'Pro აქტიურია — გმადლობთ!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'რეკლამის გარეშე · ბექაპის ექსპორტი და იმპორტი · წლიური';

  @override
  String get proBenefitNoAds => 'რეკლამის გარეშე გამოცდილება';

  @override
  String get proBenefitBackup => 'ბექაფი (ექსპორტი/იმპორტი)';

  @override
  String aboutVersion(Object version) {
    return 'ვერსია $version';
  }

  @override
  String get navDiscover => 'აღმოჩენა';

  @override
  String get shareAction => 'აპის გაზიარება';

  @override
  String get rateAction => 'გამოგვწერეთ';

  @override
  String get aboutOpenRow => 'შესახ და ღია კოდი';

  @override
  String get voiceAddItemAction => 'ხმით დამატება';

  @override
  String get formatLocaleLabel => 'რიცხვების და ვალუტის ფორმატი';

  @override
  String get formatLocaleSystem =>
      'მოწყობილობის ფორმატი (ლათინური ციფრები; სხვა შემთხვევაში ინგლისურად)';

  @override
  String get formatLocaleTr => 'თურქული (1.234,56)';

  @override
  String get formatLocaleEn => 'ინგლისური (1,234.56)';

  @override
  String get aiToggleTitle => 'AI დახმარება';

  @override
  String get aiToggleSubtitle =>
      'კითხულობს ჩეკებსა და ფასების ეტიკეტებს ფოტოებიდან, ადარებს ჩეკებს და წინადადებებს სიებად აქცევს. ფოტოები იგზავნება მხოლოდ წასაკითხად და არასოდეს ინახება.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'ამ თვის AI მოთხოვნები ამოწურული გაქვთ ($used/$limit). მეტითვის განაახლეთ ან გააგრძელეთ AI-ის გარეშე.';
  }

  @override
  String get aiOffline => 'კავშირი არ არის — AI-ის გარეშე გრძელდება.';

  @override
  String get aiFailed => 'AI ამჟამად შეუძლებელია — მის გარეშე გრძელდება.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'მოწყობილობა';

  @override
  String get quickListAction => 'დამატება წინადადებიდან';

  @override
  String get quickListTitle => 'სწრაფი სია';

  @override
  String get quickListHint => 'მაგ. 1 კგ ქლიავი 20, 2 პური, ნახევარი კგ ყველი';

  @override
  String get quickListConvert => 'გარდაქმნა სიად';

  @override
  String quickListAdd(int count) {
    return '$count ელემენტის დამატება';
  }

  @override
  String get quickListEmpty =>
      'ელემენტები ვერ მოიძებნა. სცადეთ მათ მძიმეებით გამოყოფა.';

  @override
  String get receiptAiMatched =>
      'AI-მა ჩიზი თქვენს სიას შეუსაბამა. გადაამოწმეთ ბმულები და დაადასტურეთ.';

  @override
  String get receiptNeedsCheck => 'შეამოწმეთ ეს შესაბამისობა';

  @override
  String get receiptDiscountLine => 'დარღვევა';

  @override
  String get compareItem => 'ელემენტი';

  @override
  String get compareEstimated => 'მოსალოდნელი';

  @override
  String get compareActual => 'რეალური';

  @override
  String get compareDiff => 'სხვაობა';

  @override
  String get compareTotal => 'ჯამი';

  @override
  String get compareBudget => 'ბიუჯეტი';

  @override
  String get compareNotBought => 'ყიდულა';

  @override
  String get compareUnplanned => 'გეგმიდან გარეთ';

  @override
  String get pricierItems => 'უფრო ძვირი';

  @override
  String get cheaperItems => 'უფრო იაფი';

  @override
  String get compareAction => 'შედარება';

  @override
  String get detailsSection => 'დეტალები';

  @override
  String get spendingTitle => 'ხარჯები';

  @override
  String get spendingAction => 'ხარჯები';

  @override
  String get spendingMonthTotal => 'ამ თვეს';

  @override
  String get spendingWeekly => 'კვირეული ხარჯები';

  @override
  String get spendingMonthly => 'თვიური ხარჯები';

  @override
  String get monthlyLimitTitle => 'თვიური ლიმიტი';

  @override
  String get monthlyLimitHelp => 'რამდენი ხარჯვა გსურთ ყიდვაზე თვეში?';

  @override
  String get monthlyLimitRemove => 'წაშლა';

  @override
  String get monthlyLimitSet => 'დაყენება';

  @override
  String get monthlyLimitChange => 'ცვლა';

  @override
  String get monthlyLimitNone =>
      'დააყენეთ თვიური ლიმიტი, რომ იხილოთ რამდენი გაქვთ დარჩენილი.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount ლიმიტს აღემატება';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return '$amount დარჩა ამ თვეში';
  }

  @override
  String get plansTitle => 'პაკეტები';

  @override
  String get plansHeadline => 'უკეთ იყიდე AI-ით';

  @override
  String get plansSubhead =>
      'ჩიზების შესაბამისობა, ფასის ლეიბლები და სიები წინადადებიდან. გაუქმება ნებისმიერ დროს.';

  @override
  String get plansMonthly => 'თვიური';

  @override
  String get plansYearly => 'წლიური';

  @override
  String get planFree => 'უფასო';

  @override
  String get planFreePrice => 'უფასო სამუდამოდ';

  @override
  String get planFreeAi => '10 AI მოთხოვნა თვეში';

  @override
  String get planFreeAds => 'მცირე ბანერული რეკლამა (პირველ 7 დღეში არ არის)';

  @override
  String get planCoreFeatures => 'სიები, ფასები, ჩიზები, ხარჯების გრაფიკები';

  @override
  String get plansPerYear => '/ წელიწადში';

  @override
  String get plansPerMonth => '/ თვეში';

  @override
  String get planTrial => 'უფასო საცდელი პერიოდი';

  @override
  String get planProAi => '100 AI მოთხოვნა თვეში';

  @override
  String get planNoAds => 'რეკლამის გარეშე';

  @override
  String get planBackup => 'ბექაპის ექსპორტი და იმპორტი';

  @override
  String get planMaxAi => '300 AI მოთხოვნა თვეში';

  @override
  String get planMaxFamily => 'დიდი ოჯახის ყიდვებისთვის';

  @override
  String get plansStoreUnavailable => 'დღესდღეობით მაღაზია მიუწვდომელია.';

  @override
  String get retryAction => 'გამეცადინება';

  @override
  String get plansPurchaseFailed =>
      'ყიდვა ვერ შესრულდა. გთხოვთ, სცადოთ თავიდან.';

  @override
  String get plansRestore => 'ყიდვების აღდგენა';

  @override
  String get plansLegal =>
      'Pro ავტომატურად განახლდება ყოველწლიურად გაუქმებამდე და მოიცავს თვეში 100 AI მოთხოვნას. საბაზო ფასი არის წელიწადში 1 აშშ დოლარი შესაბამისი გადასახადების გარეშე; შესყიდვის დადასტურებამდე მაღაზიაში შეამოწმეთ საბოლოო ადგილობრივი ფასი და გადასახადები. მართეთ ან გააუქმეთ გამოწერა Google Play-ში.';

  @override
  String get planCurrent => 'მიმდინარე';

  @override
  String get planStartTrial => 'უფასო საცდელი პერიოდის დაწყება';

  @override
  String get planChoose => 'აირჩიეთ';

  @override
  String get plansAction => 'პაკეტები: Pro';

  @override
  String get assistantTitle => 'დამხმარე';

  @override
  String get assistantGreeting => 'გამარჯობა! რის კეთებას ისურვებდით?';

  @override
  String get assistantNewList => 'ახალი სია';

  @override
  String get assistantVoiceList => 'სია ხმით';

  @override
  String get assistantTextList => 'სია წინადადებიდან';

  @override
  String get assistantScanReceipt => 'შემოსავლების ბარათის სკანირება';

  @override
  String get assistantSpending => 'ჩემი ხარჯები';

  @override
  String get assistantReceiptHint =>
      'გახსენით თქვენი სია და დააჭირეთ შემოსავლების ბარათის ხატულას მის სკანირებისთვის.';

  @override
  String get assistantToggleTitle => 'დამხმარის ჩვენება';

  @override
  String get assistantToggleSubtitle => 'მცირე დამხმარე მარჯვენა ქვედა კუთხეში';

  @override
  String get scanPriceLabel => 'ფასის სკანირება';

  @override
  String get saveFailed =>
      'შენახვა ვერ მოხერხდა. თქვენი ცვლილებები ჯერ კიდევ ინახება. გთხოვთ, სცადოთ თავიდან.';

  @override
  String get deleteItemConfirm =>
      'წაშალოთ ეს პროდუქტი და მისი ჩანაწერი შენაძენები?';

  @override
  String get clearPurchaseConfirm =>
      'ამოიღოთ მონიშვნა ამ პროდუქტიდან და წაშალოთ მისი ჩანაწერი შენაძენები?';

  @override
  String get reportPdfAction => 'PDF ანგარიშის შენახვა';

  @override
  String get reportNotInvoice =>
      'ყიდვების მიმოხილვა, არა საგადასახადო ფაქტურა. გადასახადის მაჩვენებლები უცნობია.';

  @override
  String get purchaseVisits => 'ყიდვის ვიზიტები';

  @override
  String get purchaseInterval => 'შენაძენებს შორის საშუალო დღეები';

  @override
  String get purchasedQuantity => 'შეძენილი რაოდენობა';

  @override
  String get purchaseAnalyticsHint =>
      'შეძენები არ ასახავს მოხმარებას. ვალუტები და ერთეულები ცალ-ცალკეა ნაჩვენები.';

  @override
  String get receiptReplaces =>
      'ფასის არმქონე პროდუქტების ფასები ივსება. საბაზრო ფასის მქონე პროდუქტები ცალკე შესყიდვებად ემატება.';

  @override
  String get receiptIncompleteHeader =>
      'შემდეგ ფოტოში მიუთითეთ მაღაზია, თარიღი, დრო და ქვითრის ნომერი.';

  @override
  String get receiptIncompleteTail =>
      'გადაიღეთ შემდეგი ნაწილი რამდენიმე გადაფარული პროდუქტითა და საბოლოო ჯამით.';

  @override
  String get receiptContinuationRejected =>
      'ეს ფოტო ვერ გაერთიანდა. ხელახლა გადაიღეთ იმავე ქვითრის გადაფარული პროდუქტებით.';

  @override
  String get receiptDraftSaved =>
      'ქვითარი მონახაზად შეინახა. მოგვიანებით შეგიძლიათ გააგრძელოთ.';

  @override
  String get receiptContinueAction => 'ქვითრის გაგრძელება';

  @override
  String get receiptDraftsTitle => 'დაუსრულებელი ქვითრები';

  @override
  String get receiptDuplicate => 'ეს ქვითარი უკვე დამატებულია.';

  @override
  String get receiptTotalMismatch =>
      'პროდუქტების ჯამი ქვითრის ჯამს არ ემთხვევა. შეამოწმეთ, ჩანს თუ არა მთელი ქვითარი.';

  @override
  String get receiptSaveDraftAction => 'მოგვიანებით შესანახად';

  @override
  String get receiptResolveLines =>
      'შენახვამდე მიიღეთ ან უგულებელყავით თითოეული პროდუქტი.';

  @override
  String get receiptPartialConfirm =>
      'დაემატება მხოლოდ არჩეული პროდუქტები. ეს ქვითარი იმპორტირებულად მოინიშნება. გავაგრძელოთ?';

  @override
  String get voiceUnsupportedLanguage =>
      'ეს ენა ამ მოწყობილობაზე ხმოვანი შეყვანისთვის არ არის ხელმისაწვდომი. შეგიძლიათ, ტექსტით ჩაწეროთ.';

  @override
  String get voiceStopListening => 'ჩვენება შეწყვეტა';

  @override
  String get keepAwakeFailed =>
      'ეკრანის გათიშვის თავიდან აცილება ვერ მოხერხდა. გთხოვთ, სცადოთ ხელახლა.';

  @override
  String get purchaseHistoryHint =>
      'ყველა დასრულებული ყიდვა. დაბრუნებები ამცირებს ჯამურ თანხას. თარიღები შეესაბამება ყიდვის დასრულების დროს. ერთი ვიზიტი საკმარისი არ არსად საშუალო ინტერვალის გამოსათვლელად.';

  @override
  String get planLegacyRights =>
      'არსებული Pro და Max სუბსკრიფციები ინარჩუნებენ თავდაპირველ თვიურ AI ლიმიტს.';

  @override
  String get csvExportAction => 'CSV-ის ექსპორტი';

  @override
  String get backupSizeWarning =>
      'JSON-ში ჩანაწერებია, არა ფოტოფაილები. იმპორტის ლიმიტი: 16 MB.';

  @override
  String get backupImportFailed =>
      'ბექაპის იმპორტი ვერ მოხერხდა. თქვენი მონაცემები არ შეცვლილა.';

  @override
  String get backupImported => 'ბექაპი წარმატებით იმპორტირდა.';

  @override
  String backupPreviewCounts(Object entries, Object items, Object lists) {
    return '$lists სია · $items ნივთი · $entries შენაძენი';
  }

  @override
  String get voiceModelDownloading =>
      'ამ ენის ხმოვანი მოდელი იტვირთება. სცადეთ ერთ წუთში.';

  @override
  String get historyThisWeek => 'ეს კვირა';

  @override
  String get historyProductsSection => 'ნაყიდი პროდუქტები';

  @override
  String get tipReceiptScan =>
      'ჩეკის სკანირება, რათა ფასები თქვენს სიას შეადაროთ';

  @override
  String get tipVoiceAdd =>
      'თქვით ერთი ან მეტი პროდუქტი და შეამოწმეთ დამატებამდე';

  @override
  String get tipShelfCamera => 'კამერით წაიკითხეთ ფასი თაროს ეტიკეტიდან';

  @override
  String get tipPlan => 'თქვენი გეგმა: ნახეთ დეტალები, გამოიწერეთ ან განაახლეთ';

  @override
  String get guideAddBody =>
      'შეეხეთ +-ს პროდუქტის დასამატებლად. დაგეგმილი ფასი ახლა შეიყვანეთ, ბაზრის ფასი — სალაროსთან.';

  @override
  String get guideVoiceBody =>
      'შეეხეთ მიკროფონს და თქვით პროდუქტები, მაგალითად: \'1 კგ ვაშლი, 1 პური\'.';

  @override
  String get guideReceiptBody =>
      'ჩეკის სკანირება, რათა მისი ფასები თქვენი სიის პროდუქტებს შეადაროთ.';

  @override
  String get guidePlanBody =>
      'შეეხეთ გეგმის ხატულას გეგმის სანახავად, გამოსაწერად ან განსაახლებლად.';

  @override
  String get guideNext => 'კარგი';

  @override
  String get guideDone => 'დაწყება';

  @override
  String get paletteLabel => 'ფერის თემა';

  @override
  String get paletteForest => 'ტყე';

  @override
  String get paletteOcean => 'ოკეანე';

  @override
  String get paletteSunset => 'მზის ჩასვლა';

  @override
  String get paletteLavender => 'ლავანდა';

  @override
  String get darkBlackLabel => 'სუფთა შავი მუქ თემაში';

  @override
  String get spendingOverview => 'მიმოხილვა';

  @override
  String get spendingThisYear => 'წელს';

  @override
  String get spendingYearly => 'წლიური ხარჯი';

  @override
  String get productSpending => 'ხარჯი პროდუქტების მიხედვით';

  @override
  String get spanWeek => 'კვირა';

  @override
  String get spanMonth => 'თვე';

  @override
  String get spanYear => 'წელი';

  @override
  String get weeklyLimitTitle => 'კვირის ლიმიტი';

  @override
  String get weeklyLimitHelp => 'რამდენის დახარჯვა გსურთ საყიდლებზე კვირაში?';

  @override
  String get weeklyLimitNone =>
      'დააყენეთ კვირის ლიმიტი, რომ ნახოთ რამდენი დარჩა.';

  @override
  String weeklyLimitLeft(String amount) {
    return 'ამ კვირას დარჩა $amount';
  }

  @override
  String get shoppingLimitTitle => 'ლიმიტი თითო ყიდვაზე';

  @override
  String get shoppingLimitHelp => 'ახალი სიები ამ ბიუჯეტით იწყება.';

  @override
  String get shoppingLimitNone =>
      'დააყენეთ ნაგულისხმევი ბიუჯეტი ყოველი ახალი ყიდვისთვის.';

  @override
  String get monthlyReportAction => 'თვის ანგარიში';

  @override
  String get reportShoppingColumn => 'ყიდვა';

  @override
  String get reportDateColumn => 'თარიღი';

  @override
  String get planUnavailable => 'ახლა მაღაზიაში არ არის ხელმისაწვდომი';

  @override
  String get demoDataTitle => 'სანიმუშო მონაცემები';

  @override
  String get demoDataLoad => 'სანიმუშო მონაცემებით ცდა';

  @override
  String get demoDataLoadHelp =>
      'ამატებს 12 თვის სანიმუშო ყიდვებს ისტორიის, გრაფიკებისა და ფასების ისტორიის სანახავად.';

  @override
  String get demoDataRemove => 'სანიმუშო მონაცემების წაშლა';

  @override
  String get demoDataAdded => 'სანიმუშო მონაცემები დაემატა';

  @override
  String get demoDataRemoved => 'სანიმუშო მონაცემები წაიშალა';

  @override
  String get demoProductApple => 'ვაშლი';

  @override
  String get demoProductBread => 'პური';

  @override
  String get demoProductMilk => 'რძე';

  @override
  String get demoProductCheese => 'ყველი';

  @override
  String get demoProductTomato => 'პომიდორი';

  @override
  String get demoProductEggs => 'კვერცხი';

  @override
  String get demoProductCoffee => 'ყავა';

  @override
  String get demoProductDetergent => 'სარეცხი საშუალება';

  @override
  String get sendAction => 'Send';

  @override
  String get previousMonthAction => 'Previous month';

  @override
  String get nextMonthAction => 'Next month';

  @override
  String get helpSection => 'დახმარება და მხარდაჭერა';

  @override
  String get howToUseLabel => 'როგორ გამოვიყენოთ';

  @override
  String get guidePricesBody =>
      'მაღაზიის ფასის შეყვანისას პროდუქტი ნაყიდად მოინიშნება; 0-იც ითვლება. სახლის ფასი არასავალდებულოა. მონიშვნის მოსახსნელად წაშალეთ მაღაზიის ფასი.';

  @override
  String get shoppingDateLabel => 'საყიდლების თარიღი';

  @override
  String get shoppingDateNone => 'თარიღი არჩეული არ არის';

  @override
  String get clearShoppingDateAction => 'თარიღის გასუფთავება';

  @override
  String get listSortLabel => 'სიის რიგი';

  @override
  String get listSortDate => 'საყიდლების თარიღი';

  @override
  String get listSortAz => 'სახელი (ა–ჰ)';

  @override
  String get listSortManual => 'ხელით დალაგება';

  @override
  String get imageCameraAction => 'ფოტოს გადაღება';

  @override
  String get imageGalleryAction => 'ფოტოებიდან არჩევა';

  @override
  String get imageCaptureFailed =>
      'კამერა ან ფოტოები ვერ გაიხსნა. შეამოწმეთ წვდომის ნებართვა და სცადეთ ხელახლა.';

  @override
  String get imageRecognitionFailed =>
      'ფოტოს დამუშავება ვერ მოხერხდა. სცადეთ სხვა ფოტო.';

  @override
  String get receiptNoProducts =>
      'ტექსტი წაკითხულია, მაგრამ ქვითრის პროდუქტები ვერ მოიძებნა. ფოტოში ჩანდეს პროდუქტები და ჯამური თანხა.';

  @override
  String get keepAwakeOn => 'ეკრანი ჩართული დარჩება';

  @override
  String get keepAwakeOff => 'ეკრანი შეიძლება გამოირთოს';

  @override
  String get spanDay => 'დღე';

  @override
  String get spanCustom => 'თარიღების დიაპაზონი';

  @override
  String get reportTotalSpent => 'სულ დახარჯული';

  @override
  String get reportAddedAt => 'დამატების თარიღი';

  @override
  String get reportReceiptNumber => 'ქვითრის ნომერი';

  @override
  String get reportPreview => 'წინასწარი ნახვა';

  @override
  String get reportShareAction => 'გაზიარება';

  @override
  String get previousPeriodAction => 'წინა პერიოდი';

  @override
  String get nextPeriodAction => 'შემდეგი პერიოდი';

  @override
  String get reportSaved => 'ანგარიში შენახულია.';

  @override
  String get reportZoom => 'გადიდება';

  @override
  String planTrialDaysLeft(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days დღე დარჩა',
    );
    return '$_temp0';
  }

  @override
  String planTrialHoursLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours საათი დარჩა',
    );
    return '$_temp0';
  }

  @override
  String get planTrialEndedTitle => 'Pro-ის საცდელი პერიოდი დასრულდა';

  @override
  String get planTrialEndedBody =>
      'შეგიძლიათ უფასოდ გააგრძელოთ სიების, ხელით შეყვანისა და მოწყობილობაზე ხმის ფუნქციის გამოყენება. უფასო გეგმა კალენდარულ თვეში 10 AI მოთხოვნას მოიცავს. აირჩიეთ წლიური Pro თვეში 100 AI მოთხოვნის, რეკლამების გარეშე გამოყენებისა და სარეზერვო ასლებისთვის. თქვენი არსებული მონაცემები თქვენთან დარჩება.';

  @override
  String get planContinueFree => 'უფასოდ გაგრძელება';

  @override
  String get supportIdLabel => 'მხარდაჭერის ID';

  @override
  String get supportEmailLabel => 'ელფოსტით მხარდაჭერა';
}
