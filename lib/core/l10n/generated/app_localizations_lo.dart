// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Lao (`lo`).
class AppLocalizationsLo extends AppLocalizations {
  AppLocalizationsLo([String locale = 'lo']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'ແຜນທີ່ເຮືອນ. ຊື້ຕາມແຜນ.';

  @override
  String get listsTitle => 'ລາຍການ';

  @override
  String get listsTabActive => 'ກຳລັງໃຊ້ງານ';

  @override
  String get listsTabCompleted => 'ສຳເລັດແລ້ວ';

  @override
  String get listsTabArchived => 'ບັນທຶກໄວ້';

  @override
  String get newListButton => 'ສ້າງລາຍການໃໝ່';

  @override
  String get listTitleHint => 'ຫົວຂໍ້ (ບໍ່ຈຳເປັນ)';

  @override
  String get saveButton => 'ບັນທຶກ';

  @override
  String get cancelButton => 'ຍົກເລີກ';

  @override
  String get deleteButton => 'ລຶບ';

  @override
  String get editAction => 'ແກ້ໄຂ';

  @override
  String get listDeleted => 'ລາຍການຖືກລຶບແລ້ວ';

  @override
  String get invalidAmountError => 'ຈຳນວນບໍ່ຖືກຕ້ອງ';

  @override
  String get duplicateAction => 'ສ້າງຊ້ຳ';

  @override
  String get archiveAction => 'ບັນທຶກໄວ້';

  @override
  String get unarchiveAction => 'ຟື້ນຄືນ';

  @override
  String get deleteListConfirm =>
      'ຕ້ອງການລຶບລາຍການນີ້ບໍ? ລາຍການທີ່ແຜນໄວ້ຈະຖືກລຶບຕາມ.';

  @override
  String get undoButton => 'ຍ້ອນກັບ';

  @override
  String get searchListHint => 'ຄົ້ນຫາລາຍການ';

  @override
  String get currencyLabel => 'ຫຼັກເງິນ';

  @override
  String get budgetLabel => 'ງົບປະມານ (ບໍ່ຈຳເປັນ)';

  @override
  String get noteLabel => 'ໝາຍເຫດ (ບໍ່ຈຳເປັນ)';

  @override
  String get storeLabel => 'ຮ້ານຄ້າ';

  @override
  String get keepAmountsAction => 'ຮັກສາຈຳນວນ';

  @override
  String get resetAmountsAction => 'ຕັ້ງຄ່າຈຳນວນໃໝ່';

  @override
  String get currencyChangeWarning =>
      'ກຳລັງປ່ຽນຫຼັກເງິນ. ຈຳນວນທີ່ມີຢູ່ຄວນເຮັດແນວໃດ?';

  @override
  String get listsEmpty => 'ຍັງບໍ່ມີລາຍການ. ສ້າງແຜນຊື້ຂອງທ່ານເລີຍ.';

  @override
  String get statusDraft => 'ແບບຮ່າງ';

  @override
  String get statusPlanned => 'ແຜນໄວ້';

  @override
  String get statusShopping => 'ກຳລັງຊື້';

  @override
  String get statusCompleted => 'ສຳເລັດແລ້ວ';

  @override
  String get statusArchived => 'ບັນທຶກໄວ້';

  @override
  String autoListTitle(String date) {
    return 'ຊື້ $date';
  }

  @override
  String get itemFormTitle => 'ເພີ່ມລາຍການ';

  @override
  String get itemNameLabel => 'ຊື່ລາຍການ';

  @override
  String get brandLabel => 'ຍີ່ຫໍ້ / ຮູບແບບ (ບໍ່ຈຳເປັນ)';

  @override
  String get categoryLabel => 'ປະເພດ';

  @override
  String get quantityLabel => 'ຈຳນວນ';

  @override
  String get unitLabel => 'ຫົວໜ່ວຍ';

  @override
  String get pricingModeLabel => 'ການປ້ອນລາຄາ';

  @override
  String get pricingModeUnitPrice => 'ລາຄາຕໍ່ຫົວໜ່ວຍ';

  @override
  String get pricingModeLineTotal => 'ລາຄາລວມແຖວ';

  @override
  String get plannedPriceLabel => 'ລາຄາທີ່ແຜນໄວ້';

  @override
  String lineTotalCalculated(String value) {
    return 'ລາຄາລວມແຖວ: $value';
  }

  @override
  String get requiredItemToggle => 'ລາຍການຈຳເປັນ';

  @override
  String get maxPriceLabel => 'ລາຄາສູງສຸດທີ່ຍອມຮັບໄດ້ (ບໍ່ຈຳເປັນ)';

  @override
  String get itemNoteLabel => 'ໝາຍເຫດ (ບໍ່ຈຳເປັນ)';

  @override
  String get categoryProduce => 'ຜັກ ແລະ ໝາກໄມ້';

  @override
  String get categoryDairy => 'ນົມ ແລະ ຜະລິດຕະພັນນົມ';

  @override
  String get categoryMeat => 'ຊີ້ນ';

  @override
  String get categoryBakery => 'ເຄື່ອງປັ້ນ';

  @override
  String get categoryDrinks => 'ເຄື່ອງດື່ມ';

  @override
  String get categoryCleaning => 'ສິນຄ້າຊຳລະ';

  @override
  String get categoryPersonalCare => 'ການດູແລສ່ວນຕົວ';

  @override
  String get categoryHome => 'ເຮືອນ';

  @override
  String get categoryOther => 'ອື່ນໆ';

  @override
  String get invalidQuantityError => 'ຈຳນວນບໍ່ຖືກຕ້ອງ';

  @override
  String get invalidPriceError => 'ລາຄາບໍ່ຖືກຕ້ອງ';

  @override
  String get invalidNameError => 'ໃສ່ຊື່ລາຍການ';

  @override
  String unitPriceCalculated(String value) {
    return 'ລາຄາຕໍ່ຫົວໜ່ວຍ: $value';
  }

  @override
  String get shoppingTitle => 'ໂໝດຊື້ຂອງ';

  @override
  String get summaryPlannedTotal => 'ທີ່ວາງແຜນ';

  @override
  String get summaryInCart => 'ໃນກະຕ່າ';

  @override
  String get summaryRemainingPlan => 'ແຜນທີ່ເຫຼືອ';

  @override
  String get summaryProjected => 'ປະມານລວມ';

  @override
  String get summaryBudgetRemaining => 'ງົບປະມານທີ່ເຫຼືອ';

  @override
  String get summaryBudgetOver => 'ເກີນງົບປະມານ';

  @override
  String itemsProgress(String done, String total) {
    return '$done ຈາກ $total ລາຍການ';
  }

  @override
  String get filterAll => 'ທັງໝົດ';

  @override
  String get filterToBuy => 'ຈະຊື້';

  @override
  String get filterInCart => 'ໃນກະຕ່າ';

  @override
  String get filterNotFound => 'ບໍ່ພົບ';

  @override
  String get filterRequired => 'ຈຳເປັນ';

  @override
  String get quickEntryTitle => 'ລາຄາຈິງ';

  @override
  String get actualQuantityLabel => 'ຈຳນວນຈິງ';

  @override
  String get actualPriceLabel => 'ລາຄາຈິງ';

  @override
  String get discountLabel => 'ສ່ວນຫຼຸດ (ບໍ່ຈຳເປັນ)';

  @override
  String get alternativeNameLabel => 'ຊື່ສິນຄ້າແທນ (ບໍ່ຈຳເປັນ)';

  @override
  String get savePurchaseButton => 'ເພີ່ມເຂົ້າກະຕ່າ';

  @override
  String get unplannedAddButton => 'ເພີ່ມລາຍການທີ່ບໍ່ໄດ້ວາງແຜນ';

  @override
  String get statusPending => 'ຍັງບໍ່ໄດ້ເອົາ';

  @override
  String get statusInCart => 'ໃນກະຕ່າ';

  @override
  String get statusNotFound => 'ບໍ່ພົບ';

  @override
  String get statusGaveUp => 'ຍົກເລີກ';

  @override
  String get statusAlternative => 'ຊື້ແທນທີ່';

  @override
  String get keepScreenAwake => 'ໃຫ້ໜ້າຈໍເປີດຕໍ່';

  @override
  String get finishShopping => 'ຈົບການຊື້ຂອງ';

  @override
  String get completionWarning =>
      'ມີຂໍ້ມູນທີ່ຂາດຫຼືຍັງບໍ່ໄດ້ກວດສອບ. ທ່ານຍັງສາມາດຈົບໄດ້; ຜົນລັບຈະລະບຸຂໍ້ມູນເຫຼົ່ານັ້ນ.';

  @override
  String get continueShoppingButton => 'ຕໍ່ການຊື້ຂອງ';

  @override
  String get resultTitle => 'ຜົນລັບ';

  @override
  String get summarySection => 'ສະຫຼຸບ';

  @override
  String get plannedTotalLabel => 'ລວມທີ່ວາງແຜນ';

  @override
  String get actualTotalLabel => 'ລວມຈິງ';

  @override
  String get varianceLabel => 'ຜົນຕ່າງ';

  @override
  String get varianceNotComputable => 'ບໍ່ສາມາດຄິດໄລ່ໄດ້';

  @override
  String get budgetStatusLabel => 'ງົບປະມານ';

  @override
  String get savingsLabel => 'ຕ່ຳກວ່າແຜນ';

  @override
  String get overspendLabel => 'ເກີນແຜນ';

  @override
  String get unplannedTotalLabel => 'ລວມລາຍການທີ່ບໍ່ໄດ້ວາງແຜນ';

  @override
  String get unpurchasedLabel => 'ວາງແຜນແຕ່ບໍ່ໄດ້ຊື້';

  @override
  String get totalDiscountLabel => 'ສ່ວນຫຼຸດລວມ';

  @override
  String get accuracyLabel => 'ຄວາມຖືກຕ້ອງຂອງການປະມານ';

  @override
  String get groupsSection => 'ລາຍການ';

  @override
  String get groupPricier => 'ແພງກວ່າທີ່ວາງແຜນ';

  @override
  String get groupCheaper => 'ຖືກກວ່າທີ່ວາງແຜນ';

  @override
  String get groupClose => 'ໃກ້ຄຽງກັບການປະມານ';

  @override
  String get groupNotTaken => 'ວາງແຜນ, ບໍ່ໄດ້ຊື້';

  @override
  String get groupUnplanned => 'ຊື້ໂດຍບໍ່ມີແຜນ';

  @override
  String get groupQuantityChanged => 'ຈຳນວນປ່ຽນແປງ';

  @override
  String get groupUnverified => 'ຍັງບໍ່ໄດ້ກວດສອບ';

  @override
  String get plannedQtyLabel => 'ຈຳນວນທີ່ວາງແຜນ';

  @override
  String get actualQtyLabel => 'ຈຳນວນຈິງ';

  @override
  String get plannedUnitPriceLabel => 'ລາຄາຕໍ່ຫົວໜ່ວຍທີ່ວາງແຜນ';

  @override
  String get actualUnitPriceLabel => 'ລາຄາຕໍ່ຫົວໜ່ວຍຈິງ';

  @override
  String get lineVarianceLabel => 'ຜົນຕ່າງຕໍ່ເສັ້ນ';

  @override
  String get discountEffectLabel => 'ຜົນກະທົບຈາກສ່ວນຫຼຸດ';

  @override
  String get notBoughtMark => 'ບໍ່ໄດ້ຊື້';

  @override
  String get noPurchasesNote => 'ບໍ່ມີການບັນທຶກການຊື້ຂອງ.';

  @override
  String get navHome => 'ໜ້າຫຼັກ';

  @override
  String get navLists => 'ລາຍການ';

  @override
  String get navHistory => 'ປະຫວັດ';

  @override
  String get navSettings => 'ຕັ້ງຄ່າ';

  @override
  String get homeEmptyTitle => 'ແຜນການຊື້ຂອງທ່ານ';

  @override
  String get homeEmptyBody =>
      'ສ້າງລາຍການທຳອິດຂອງທ່ານ ແລະ ປຽບທຽບຕົ້ນທຶນທີ່ແຜນໄວ້ກັບຈິງ.';

  @override
  String get homeActiveSection => 'ລາຍການທີ່ກຳລັງເຮັດ';

  @override
  String get homeCompletedSection => 'ສຳເລັດໃນໄວໆນີ້';

  @override
  String get homeMonthlySection => 'ເດືອນນີ້';

  @override
  String get monthPlannedLabel => 'ແຜນໄວ້';

  @override
  String get monthActualLabel => 'ຈິງ';

  @override
  String get monthVarianceLabel => 'ຜົນຕ່າງ';

  @override
  String get continueShoppingLabel => 'ຕໍ່ການຊື້';

  @override
  String get historyEmpty =>
      'ຍັງບໍ່ມີການຊື້ທີ່ສຳເລັດ. ປະຫວັດ ແລະ ຂໍ້ມູນວິເຄາະຈະປາກົດຢູ່ນີ້.';

  @override
  String get aboutTabTitle => 'ກ່ຽວກັບ NShoptor';

  @override
  String get aboutBody =>
      'NShoptor ໂດຍ Crazy Penguin. ແພລນເຟີແຊັບຊື້ທີ່ໃຊ້ງານໄດ້ໂດຍບໍ່ຕ້ອງໃຊ້ອິນເຕີເນັດ. ສະເພາະລິຂະສິດ GPL-3.0.';

  @override
  String get startShoppingLabel => 'ເລີ່ມຊື້';

  @override
  String get finishAndSeeResult => 'ສຳເລັດ & ເບິ່ງຜົນ';

  @override
  String get settingsTitle => 'ຕັ້ງຄ່າ';

  @override
  String get languageLabel => 'ພາສາ';

  @override
  String get languageSystem => 'ລະບົບ';

  @override
  String get languageTr => 'ຕວກກີ';

  @override
  String get languageEn => 'ອັງກິດ';

  @override
  String get themeLabel => 'ຮູບແບບ';

  @override
  String get themeSystem => 'ລະບົບ';

  @override
  String get themeLight => 'ສະຫວ່າງ';

  @override
  String get themeDark => 'ມືດ';

  @override
  String get defaultCurrencyLabel => 'ໂຕ້ແລກເງິນມາດຕະຖານ';

  @override
  String get defaultUnitLabel => 'ຫົວໜ່ວຍມາດຕະຖານ';

  @override
  String get keepAwakeLabel => 'ຄົງສະຫຼຸບໜ້າຈໍໃນລະຫວ່າງການຊື້';

  @override
  String get backupSection => 'ການສຳຮອງຂໍ້ມູນ';

  @override
  String get exportBackupLabel => 'ສົ່ງອອກການສຳຮອງຂໍ້ມູນ';

  @override
  String get importBackupLabel => 'ນຳເຂົ້າການສຳຮອງຂໍ້ມູນ';

  @override
  String get mergeImportLabel => 'ລວມເຂົ້າໃນຂໍ້ມູນປັດຈຸບັນ';

  @override
  String get separateImportLabel => 'ນຳເຂົ້າເປັນຊຸດແຍກ';

  @override
  String get importCancelled => 'ການນຳເຂົ້າຖືກຍົກເລີກ.';

  @override
  String get backupExported => 'ສົ່ງອອກການສຳຮອງຂໍ້ມູນສຳເລັດແລ້ວ.';

  @override
  String get backupSizeWarning =>
      'ການສຳຮອງຂໍ້ມູນໃຫຍ່: ໄຟລ໌ອາດຈະໃຫຍ່. ທ່ານຕ້ອງການລວມຮູບພາບບໍ?';

  @override
  String get deleteAllSection => 'ເຂດອັນຕະລາຍ';

  @override
  String get deleteAllLabel => 'ລຶບຂໍ້ມູນທັງໝົດ';

  @override
  String get deleteAllConfirm =>
      'ການກະທຳນີ້ຈະລຶບລາຍການ, ປະຫວັດ, ຮູບພາບໃບເກັບເງິນ ແລະ ລາຄາທັງໝົດ. ໄຟລ໌ທີ່ທ່ານສົ່ງອອກຈະຍັງຄົງຢູ່ໃນໄດຣ໌ຂອງທ່ານ. ຕໍ່ໄປບໍ?';

  @override
  String get deleteAllConfirm2 =>
      'ທ່ານແນ່ໃຈແທ້ບໍ? ການກະທຳນີ້ບໍ່ສາມາດຍ້ອນກັບໄດ້.';

  @override
  String get cancelAction => 'ຍົກເລີກ';

  @override
  String get confirmDelete => 'ລຶບຖາວອນ';

  @override
  String get dataDeleted => 'ຂໍ້ມູນທັງໝົດໃນเครื่องຖືກລຶບແລ້ວ.';

  @override
  String get privacyInfoLabel => 'ຄວາມເປັນສ່ວນຕົວ';

  @override
  String get privacyInfoBody =>
      'ລາຍການ, ລາຄາ, ໃບເກັບເງິນ ແລະ ຮູບພາບຂອງທ່ານຈະຢູ່ໃນອຸປະກອນຂອງທ່ານ. ຮູບພາບ ແລະ ສຽຍບໍ່ເຄີຍອອກຈາກອຸປະກອນ. ເມື່ອໃຊ້ AI help, ພຽງແຕ່ຂໍ້ຄວາມ (ເຊັ່ນ: ແຖວໃບເກັບເງິນ ຫຼື ສິ່ງທີ່ທ່ານບອກ) ຈະຖືກສົ່ງໄປຍັງເຊີເວີຂອງພວກເຮົາເພື່ອປະມວນຜົນ ແລະ ບໍ່ຖືກເກັບ.';

  @override
  String get aboutSection => 'ກ່ຽວກັບ';

  @override
  String get aboutPublisher => 'ຜູ້ອອກແບບ: Crazy Penguin';

  @override
  String get aboutLicenses => 'ລິຂະສິດ (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'ການປ້ອນຂໍ້ມູນດ້ວຍສຽຍ';

  @override
  String get voiceStatusUnknown => 'ບໍລິການ: ຍັງບໍ່ໄດ້ກວດສອບ';

  @override
  String get permissionsLabel => 'ສິດທິ';

  @override
  String get permissionsBody =>
      'ກ້ອງ, ໄມໂຄຣໂຟນ ແລະ ການແຈ້ງເຕືອນ ຖືກຂໍເມື່ອທ່ານໃຊ້ຟີເຈີເຫຼົ່ານັ້ນຈິງໆ.';

  @override
  String get unitsSection => 'ມາດຕະຖານ';

  @override
  String get roundingNote =>
      'ການປັດເງິນຈະຕາມກົດເກນດຽວ: ຈຳນວນເຄິ່ງຈະປັດອອກຈາກສູນ, ນຳໃຊ້ຄັ້ງດຽວໃນການປ່ຽນເງິນ.';

  @override
  String get voiceInputTitle => 'ການປ້ອນຂໍ້ມູນດ້ວຍສຽຍ';

  @override
  String get voiceStartListening => 'ເລີ່ມຟັງ';

  @override
  String get voiceTranscriptLabel => 'ຂໍ້ຄວາມ';

  @override
  String get parseAction => 'ແຍກຂໍ້ມູນ';

  @override
  String get receiptReviewTitle => 'ກວດສອບໃບເກັບເງິນ';

  @override
  String get receiptTotal => 'ລວມໃບເກັບເງິນ';

  @override
  String get receiptTotalUnknown => 'ບໍ່ສາມາດກວດຈັບລວມໄດ້';

  @override
  String get receiptDiff => 'ຜົນຕ່າງ';

  @override
  String get acceptLine => 'ຍອມຮັບແຖວນີ້';

  @override
  String get ignoreLine => 'ລະເລີຍແຖວນີ້';

  @override
  String get receiptLineActions => 'ເຊື່ອມຕໍ່ກັບສິນຄ້າ, ແບ່ງຫຼືລະເລີຍ';

  @override
  String get receiptCommit => 'ຍອມຮັບທັງໝົດ';

  @override
  String get receiptCommitted => 'ໃບເກັບເງິນຖືກນຳໃຊ້ແລ້ວ.';

  @override
  String get priceHistoryTitle => 'ປະຫວັດລາຄາ';

  @override
  String get noObservations => 'ຍັງບໍ່ມີການບັນທຶກລາຄາ';

  @override
  String get templatesSection => 'ແບບຟອມ';

  @override
  String get templateHint => 'ສ້າງແຜນໃໝ່ຈາກການຊື້ເຄື່ອງຄັ້ງກ່ອນ';

  @override
  String get scanReceiptAction => 'ສະແກນໃບເກັບເງິນ';

  @override
  String get shelfLabelAction => 'ລາຄາຈາກປ້າຍຢູ່ຫຼັງຂາຍ';

  @override
  String get priceCandidatesTitle => 'ລາຄາທີ່ເປັນໄປໄດ້';

  @override
  String get noPriceCandidates => 'ບໍ່ພົບລາຄາ; ລົງລາຄາເອງ.';

  @override
  String get voiceUnavailable => 'ການຮັບຮູ້ສຽງບໍ່ສາມາດໃຊ້ໄດ້; ລົງລາຄາເອງ.';

  @override
  String get linkToItem => 'ເຊື່ອມຕໍ່ກັບສິນຄ້າ';

  @override
  String get splitLine => 'ແບ່ງເປັນສອງສ່ວນ';

  @override
  String get mergeWithNext => 'ລວມກັບແຖວຖັດໄປ';

  @override
  String get ocrNoText => 'ບໍ່ອ່ານພາບໂຕໜັງສືໄດ້; ລອງໃໝ່.';

  @override
  String get priceHistoryAction => 'ປະຫວັດລາຄາ';

  @override
  String get itemsEmptyTitle => 'ຍັງບໍ່ມີສິນຄ້າ';

  @override
  String get itemsEmptyBody =>
      'ເພີ່ມສິນຄ້າອັນທຳອິດ — ທ່ານຈະລົງລາຄາຈິງຢູ່ນີ້ເມື່ອຢູ່ໂຮງແຮ່.';

  @override
  String get addItemTooltip => 'ເພີ່ມສິນຄ້າ';

  @override
  String get unitAdet => 'ອັນ';

  @override
  String get unitKilogram => 'ກ.ກ.';

  @override
  String get unitGram => 'ກ.';

  @override
  String get unitLitre => 'ລ.';

  @override
  String get unitMililitre => 'ມ.ລ.';

  @override
  String get unitPaket => 'ຊຸດ';

  @override
  String get unitKutu => 'ກ່ອງ';

  @override
  String get unitSise => 'ຂວດ';

  @override
  String get unitKavanoz => 'ໝໍ້';

  @override
  String get unitDemet => 'ຊັບ';

  @override
  String get unitDuzine => 'ໂຊນ';

  @override
  String get unitMetre => 'ແມັດ';

  @override
  String get unitCustom => 'ກຳນົດເອງ';

  @override
  String get setReminderAction => 'ຕັ້ງການຈື່ຈຳ';

  @override
  String get reminderPermissionDenied =>
      'ຕ້ອງການອະນຸຍາດການແຈ້ງເຕືອນສຳລັບການຈື່ຈຳ. ທ່ານສາມາດເປີດໃຊ້ໃນການຕັ້ງຄ່າລະບົບ.';

  @override
  String get reminderScheduled => 'ຕັ້ງການຈື່ຈຳແລ້ວ.';

  @override
  String get reminderCancelled => 'ລຶບການຈື່ຈຳແລ້ວ.';

  @override
  String get reminderTitle => 'ການຈື່ຈຳການຊື້ເຄື່ອງ';

  @override
  String reminderBody(Object title) {
    return 'ເວລາກວດສອບລາຍການ: $title';
  }

  @override
  String get reminderPickDate => 'ເລືອກວັນ';

  @override
  String get reminderPickTime => 'ເລືອກເວລາ';

  @override
  String get itemDetailsSection => 'ລາຍລະອຽດ';

  @override
  String get priceOptionalHint => 'ບໍ່ຈຳເປັນ — ທ່ານຈະລົງລາຄາຈິງໃນໂຮງແຮ່';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'ແຜນ: $total · $count ສິນຄ້າ';
  }

  @override
  String get proActiveLabel => 'Pro ກຳລັງໃຊ້ — ຂອບໃຈ!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'ບໍ່ມີໂຄສະນາ, AI ຫຼາຍຂຶ້ນ, ບັກອັບ · ຈາກລາຄາຕໍ່ເດືອນທີ່ນ້ອຍ';

  @override
  String get proBenefitNoAds => 'ປະສົບການບໍ່ມີໂຄສະນາ';

  @override
  String get proBenefitBackup => 'ບັກອັບ (ສົ່ງອອກ/ນຳເຂົ້າ)';

  @override
  String aboutVersion(Object version) {
    return 'ເວີຊັນ $version';
  }

  @override
  String get navDiscover => 'ຄົ້ນພົບ';

  @override
  String get shareAction => 'ແບ່ງປັນແອັບ';

  @override
  String get rateAction => 'ໃຫ້ຄະແນນພວກເຮົາ';

  @override
  String get aboutOpenRow => 'ກ່ຽວກັບ & ເປີດແຫຼ່ງ';

  @override
  String get voiceAddItemAction => 'ເພີ່ມດ້ວຍສຽງ';

  @override
  String get formatLocaleLabel => 'ຮູບແບບຕົວເລກ ແລະ ສັນຍາລັກເງິນ';

  @override
  String get formatLocaleSystem =>
      'ຕົວຢ່າງຂອງອຸປະກອນ (ຕົວເລກ Latin; ຖ້າບໍ່ແມ່ນ English)';

  @override
  String get formatLocaleTr => 'ຕວກກີ (1.234,56)';

  @override
  String get formatLocaleEn => 'ອັງກິດ (1,234.56)';

  @override
  String get aiToggleTitle => 'ຊ່ວຍເຫຼືອໂດຍ AI';

  @override
  String get aiToggleSubtitle =>
      'ຈັບຄູ່ໃບບິນ, ອ່ານປ້າຍລາຄາ ແລະ ປ່ຽນຂໍ້ຄວາມເປັນລາຍການ. ຮູບ ແລະ ສຽງຈະຖືກເກັບໄວ້ໃນອຸປະກອນຂອງທ່ານ; ມີແຕ່ຂໍ້ຄວາມທີ່ຖືກປະມວນຜົນເທົ່ານັ້ນ.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'ທ່ານໄດ້ໃຊ້ຄຳຮ້ອງຂໍ AI ໃນເດືອນນີ້ແລ້ວ ($used/$limit). ຂຶ້ນກຣຸດເພື່ອໃຫ້ໄດ້ຫຼາຍຂຶ້ນ, ຫຼື ທຳງານຕໍ່ໂດຍບໍ່ໃຊ້ AI.';
  }

  @override
  String get aiOffline => 'ບໍ່ມີການເຊື່ອມຕໍ່ — ດຳເນີນງານຕໍ່ໂດຍບໍ່ໃຊ້ AI.';

  @override
  String get aiFailed =>
      'AI ບໍ່ສາມາດໃຊ້ງານໄດ້ໃນຕອນນີ້ — ດຳເນີນງານຕໍ່ໂດຍບໍ່ໃຊ້ມັນ.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'ອຸປະກອນ';

  @override
  String get quickListAction => 'ເພີ່ມຈາກຂໍ້ຄວາມ';

  @override
  String get quickListTitle => 'ລາຍການໄວ';

  @override
  String get quickListHint =>
      'ຕົວຢ່າງ: ໝາກໄມ້ 1 kg 20, ເຂົ້າໜ້ອຍ 2 ລູກ, ຊີ້ນໄຂ້ວ ½ ກິໂລ';

  @override
  String get quickListConvert => 'ປ່ຽນເປັນລາຍການ';

  @override
  String quickListAdd(int count) {
    return 'ເພີ່ມ $count ລາຍການ';
  }

  @override
  String get quickListEmpty =>
      'ບໍ່ພົບລາຍການ. ລອງລາຍງານພວກມັນໂດຍແຍກດ້ວຍຈຸດຈ້ອນ.';

  @override
  String get receiptAiMatched =>
      'AI ໄດ້ຈັບຄູ່ໃບບິນກັບລາຍການຂອງທ່ານແລ້ວ. ກວດສອບການເຊື່ອມຕໍ່ ແລະ ຢືນຢັນ.';

  @override
  String get receiptNeedsCheck => 'ກວດສອບການຈັບຄູ່ນີ້';

  @override
  String get receiptDiscountLine => 'ສ່ວນຫຼຸດ';

  @override
  String get compareItem => 'ລາຍການ';

  @override
  String get compareEstimated => 'ຄາດຄະເນ';

  @override
  String get compareActual => 'ຈິງ';

  @override
  String get compareDiff => 'ຜົນຕ່າງ';

  @override
  String get compareTotal => 'ລວມ';

  @override
  String get compareBudget => 'ງົບປະມານ';

  @override
  String get compareNotBought => 'ບໍ່ໄດ້ຊື້';

  @override
  String get compareUnplanned => 'ບໍ່ໄດ້ແຜ່ນໄວ້';

  @override
  String get pricierItems => 'ແພງກວ່າ';

  @override
  String get cheaperItems => 'ຖືກກວ່າ';

  @override
  String get compareAction => 'ປຽບທຽບ';

  @override
  String get detailsSection => 'ລາຍລະອຽດ';

  @override
  String get spendingTitle => 'ການໃຊ້ຈ່າຍ';

  @override
  String get spendingAction => 'ການໃຊ້ຈ່າຍ';

  @override
  String get spendingMonthTotal => 'ເດືອນນີ້';

  @override
  String get spendingWeekly => 'ການໃຊ້ຈ່າຍຕໍ່ອາທິດ';

  @override
  String get spendingMonthly => 'ການໃຊ້ຈ່າຍຕໍ່ເດືອນ';

  @override
  String get monthlyLimitTitle => 'ຂອບເຂດຕໍ່ເດືອນ';

  @override
  String get monthlyLimitHelp =>
      'ທ່ານຕ້ອງການຈະໃຊ້ຈ່າຍກັບການຊື້ຂອງເທົ່າໃດຕໍ່ເດືອນ?';

  @override
  String get monthlyLimitRemove => 'ລຶບ';

  @override
  String get monthlyLimitSet => 'ຕັ້ງ';

  @override
  String get monthlyLimitChange => 'ປ່ຽນ';

  @override
  String get monthlyLimitNone =>
      'ຕັ້ງຂອບເຂດຕໍ່ເດືອນເພື່ອເບິ່ງວ່າທ່ານຍັງເຫຼືອເທົ່າໃດ.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount ເກີນຂອບເຂດ';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return '$amount ເຫຼືອໃນເດືອນນີ້';
  }

  @override
  String get plansTitle => 'ແຜນ';

  @override
  String get plansHeadline => 'ຊື້ຂອງປັນຍາຊີວິດດ້ວຍ AI';

  @override
  String get plansSubhead =>
      'ການຈັບຄູ່ໃບບິນ, ປ້າຍລາຄາ ແລະ ລາຍການຈາກຂໍ້ຄວາມ. ຍົກເລີກໄດ້ທຸກເວລາ.';

  @override
  String get plansMonthly => 'ຕໍ່ເດືອນ';

  @override
  String get plansYearly => 'ຕໍ່ປີ';

  @override
  String get planFree => 'ຟຣີ';

  @override
  String get planFreePrice => 'ຟຣີຕະຫຼອດໄປ';

  @override
  String get planFreeAi => '15 ຄຳຮ້ອງຂໍ AI ຕໍ່ເດືອນ';

  @override
  String get planFreeAds => 'ໂຄສະນາແບນເນີຂະໜາດນ້ອຍ (ບໍ່ມີໃນ 7 ວັນທຳອິດຂອງທ່ານ)';

  @override
  String get planCoreFeatures => 'ລາຍການ, ລາຄາ, ໃບບິນ, ກຣາຟການໃຊ້ຈ່າຍ';

  @override
  String get plansPerYear => '/ ປີ';

  @override
  String get plansPerMonth => '/ ເດືອນ';

  @override
  String get planTrial => 'ຟຣີ 7 ວັນ';

  @override
  String get planProAi => '200 ຄຳຮ້ອງຂໍ AI ຕໍ່ເດືອນ';

  @override
  String get planNoAds => 'ບໍ່ມີໂຄສະນາ';

  @override
  String get planBackup => 'ສົ່ງອອກ ແລະ ນຳເຂົ້າຂໍ້ມູນ';

  @override
  String get planMaxAi => '1000 ຄຳຖາມ AI ຕໍ່ເດືອນ';

  @override
  String get planMaxFamily => 'ສຳລັບການຊື້ຂອງໃຫຍ່ໃນຄອບຄົວ';

  @override
  String get plansStoreUnavailable => 'ລະບົບບໍ່ສາມາດເຊື່ອມຕໍ່ໄດ້ໃນປັດຈຸບັນ.';

  @override
  String get retryAction => 'ລອງໃໝ່';

  @override
  String get plansPurchaseFailed => 'ການຊື້ບໍ່ສຳເລັດ. ກະລຸນາລອງໃໝ່.';

  @override
  String get planLifetimeTitle => 'ບໍ່ມີໂຄສະນາ ສຳລັບຊີວິດ';

  @override
  String get planLifetimeSubtitle =>
      'ຈ່າຍຄ່າທຶນຄັ້ງດຽວ: ບໍ່ມີໂຄສະນາ, ສະໜັບສະໜູນການສົ່ງອອກ; ການໃຊ້ AI ຍັງຢູ່ໃນຂອບເຂດອິດສະຫຼະ';

  @override
  String get plansRestore => 'ກູ້ຄືນການຊື້';

  @override
  String get plansLegal =>
      'ການສະໝັກຮັບຈະແພ່ພັນໂດຍອັດຕະໂນມັດຈົນກວ່າຈະຢຸດ. ສາມາດຢຸດໄດ້ທຸກເວລາໃນ Google Play › ການຈ່າຍເງິນ ແລະ ການສະໝັກຮັບ. ລາຄາລວມພາສີທີ່ Google Play ສະແດງ.';

  @override
  String get planCurrent => 'ປັດຈຸບັນ';

  @override
  String get planStartTrial => 'ເລີ່ມລອງໃຊ້ຟຣີ 7 ວັນ';

  @override
  String get planChoose => 'ເລືອກ';

  @override
  String get plansAction => 'ແຜນ: Pro ແລະ Max';

  @override
  String get assistantTitle => 'ຜູ້ຊ່ວຍ';

  @override
  String get assistantGreeting => 'ສະບາຍດີ! ທ່ານຕ້ອງການ做什么?';

  @override
  String get assistantNewList => 'ລາຍການໃໝ່';

  @override
  String get assistantVoiceList => 'ລາຍການໂດຍສຽງ';

  @override
  String get assistantTextList => 'ລາຍການຈາກຂໍ້ຄວາມ';

  @override
  String get assistantScanReceipt => 'ສະແກນໃບເກັບເງິນ';

  @override
  String get assistantSpending => 'ການໃຊ້ຈ່າຍຂ້ອຍ';

  @override
  String get assistantReceiptHint =>
      'ເປີດລາຍການຂອງທ່ານ ແລະ ກົດໄອຄອນໃບເກັບເງິນເພື່ອສະແກນ.';

  @override
  String get assistantToggleTitle => 'ສະແດງຜູ້ຊ່ວຍ';

  @override
  String get assistantToggleSubtitle => 'ຜູ້ຊ່ວຍນ້ອຍໆຢູ່ມຸມຂວາລຸ່ມ';

  @override
  String get scanPriceLabel => 'ສະແກນປ້າຍລາຄາ';

  @override
  String get saveFailed =>
      'ບັນທຶກລົ້ມເຫຼວ. ການປ່ຽນແປງຂອງທ່ານຍັງຄົງຢູ່. ກະລຸນາລອງໃໝ່.';

  @override
  String get deleteItemConfirm => 'ລຶບອຸປະກອນນີ້ ແລະ ການຊື້ທີ່ບັນທຶກໄວ້?';

  @override
  String get clearPurchaseConfirm =>
      'ລະເລີຍການກວດສອບອຸປະກອນນີ້ ແລະ ລຶບການຊື້ທີ່ບັນທຶກໄວ້?';

  @override
  String get reportPdfAction => 'ບັນທຶກລາຍງານ PDF';

  @override
  String get reportNotInvoice =>
      'ສະຫຼຸບການຊື້, ບໍ່ແມ່ນໃບເກັບເງິນພາສີ. ອັດຕາພາສີບໍ່ຮູ້ຈັກ.';

  @override
  String get purchaseVisits => 'ການໄປຊື້';

  @override
  String get purchaseInterval => 'ຈຳນວນວັນສະເລ່ຍລະຫວ່າງການຊື້';

  @override
  String get purchasedQuantity => 'ຈຳນວນທີ່ຊື້';

  @override
  String get purchaseAnalyticsHint =>
      'ການຊື້ບໍ່ວັດແທກການບໍລິໂພກ. ສະກຸນເງິນ ແລະ ຫົວໜ່ວຍຈະສະແດງແຍກກັນ.';

  @override
  String get receiptReplaces =>
      'ແຖບໃບເກັບເງິນທີ່ເຊື່ອມຕໍ່ຈະແທນທີ່ການຊື້ທີ່ມີຢູ່; ແຖບທີ່ບໍ່ເຊື່ອມຕໍ່ຈະຖືກເພີ່ມເຂົ້າໄປ.';

  @override
  String get voiceUnsupportedLanguage =>
      'ພາສານີ້ບໍ່ສາມາດໃຊ້ສຳລັບການປ້ອນຂໍ້ຄວາມດ້ວຍສຽງໃນອຸປະກອນນີ້. ທ່ານສາມາດພິມແທນໄດ້.';

  @override
  String get voiceStopListening => 'ຢຸດການຟັງ';

  @override
  String get keepAwakeFailed => 'ບໍ່ສາມາດຮັກສາໜ້າຈໍໃຫ້ຕົດໄດ້. ກະລຸນາລອງໃໝ່.';
}
