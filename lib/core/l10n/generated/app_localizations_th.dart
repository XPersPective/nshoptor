// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'วางแผนที่บ้าน ช้อปตามแผน';

  @override
  String get listsTitle => 'รายการ';

  @override
  String get listsTabActive => 'กำลังใช้งาน';

  @override
  String get listsTabCompleted => 'เสร็จสิ้น';

  @override
  String get listsTabArchived => 'เก็บถาวร';

  @override
  String get newListButton => 'สร้างรายการใหม่';

  @override
  String get listTitleHint => 'ชื่อ (ไม่บังคับ)';

  @override
  String get saveButton => 'บันทึก';

  @override
  String get cancelButton => 'ยกเลิก';

  @override
  String get deleteButton => 'ลบ';

  @override
  String get editAction => 'แก้ไข';

  @override
  String get listDeleted => 'ลบลิสต์แล้ว';

  @override
  String get invalidAmountError => 'จำนวนไม่ถูกต้อง';

  @override
  String get duplicateAction => 'ทำซ้ำ';

  @override
  String get archiveAction => 'เก็บถาวร';

  @override
  String get unarchiveAction => 'เลิกเก็บถาวร';

  @override
  String get deleteListConfirm =>
      'ต้องการลิสต์นี้ใช่ไหม? รายการที่วางแผนไว้จะถูกลบด้วย';

  @override
  String get undoButton => 'ย้อนกลับ';

  @override
  String get searchListHint => 'ค้นหารายการ';

  @override
  String get currencyLabel => 'สกุลเงิน';

  @override
  String get budgetLabel => 'งบประมาณ (ไม่บังคับ)';

  @override
  String get noteLabel => 'หมายเหตุ (ไม่บังคับ)';

  @override
  String get storeLabel => 'ร้านค้า';

  @override
  String get keepAmountsAction => 'คงจำนวนเดิม';

  @override
  String get resetAmountsAction => 'รีเซ็ตจำนวน';

  @override
  String get currencyChangeWarning =>
      'สกุลเงินกำลังเปลี่ยนไป จำนวนที่มีอยู่ควรจัดการอย่างไร?';

  @override
  String get listsEmpty => 'ยังไม่มีรายการ สร้างแผนช้อปปิ้งแรกของคุณเลย';

  @override
  String get statusDraft => 'ร่าง';

  @override
  String get statusPlanned => 'วางแผนแล้ว';

  @override
  String get statusShopping => 'กำลังช้อป';

  @override
  String get statusCompleted => 'เสร็จสิ้น';

  @override
  String get statusArchived => 'เก็บถาวร';

  @override
  String autoListTitle(String date) {
    return 'ช้อปปิ้ง $date';
  }

  @override
  String get itemFormTitle => 'เพิ่มสินค้า';

  @override
  String get itemNameLabel => 'ชื่อสินค้า';

  @override
  String get brandLabel => 'แบรนด์ / รุ่น (ไม่บังคับ)';

  @override
  String get categoryLabel => 'หมวดหมู่';

  @override
  String get quantityLabel => 'ปริมาณ';

  @override
  String get unitLabel => 'หน่วย';

  @override
  String get pricingModeLabel => 'รูปแบบการกรอกราคา';

  @override
  String get pricingModeUnitPrice => 'ราคาต่อหน่วย';

  @override
  String get pricingModeLineTotal => 'ราคารวมบรรทัด';

  @override
  String get plannedPriceLabel => 'ราคาที่วางแผนไว้';

  @override
  String lineTotalCalculated(String value) {
    return 'ราคารวม: $value';
  }

  @override
  String get requiredItemToggle => 'สินค้าจำเป็น';

  @override
  String get maxPriceLabel => 'ราคาสูงสุดที่ยอมรับได้ (ไม่บังคับ)';

  @override
  String get itemNoteLabel => 'หมายเหตุ (ไม่บังคับ)';

  @override
  String get categoryProduce => 'ผลไม้และผัก';

  @override
  String get categoryDairy => 'ผลิตภัณฑ์นม';

  @override
  String get categoryMeat => 'เนื้อสัตว์';

  @override
  String get categoryBakery => 'เบเกอรี่';

  @override
  String get categoryDrinks => 'เครื่องดื่ม';

  @override
  String get categoryCleaning => 'เครื่องทำความสะอาด';

  @override
  String get categoryPersonalCare => 'ดูแลส่วนบุคคล';

  @override
  String get categoryHome => 'ของใช้ในบ้าน';

  @override
  String get categoryOther => 'อื่นๆ';

  @override
  String get invalidQuantityError => 'ปริมาณไม่ถูกต้อง';

  @override
  String get invalidPriceError => 'ราคาไม่ถูกต้อง';

  @override
  String get invalidNameError => 'กรุณาใส่ชื่อ';

  @override
  String unitPriceCalculated(String value) {
    return 'ราคาต่อหน่วย: $value';
  }

  @override
  String get shoppingTitle => 'โหมดช้อปปิ้ง';

  @override
  String get summaryPlannedTotal => 'ที่วางแผนไว้';

  @override
  String get summaryInCart => 'ในตะกร้า';

  @override
  String get summaryRemainingPlan => 'แผนที่เหลือ';

  @override
  String get summaryProjected => 'ยอดรวมโดยประมาณ';

  @override
  String get summaryBudgetRemaining => 'งบประมาณคงเหลือ';

  @override
  String get summaryBudgetOver => 'เกินงบประมาณ';

  @override
  String itemsProgress(String done, String total) {
    return '$done จาก $total รายการ';
  }

  @override
  String get filterAll => 'ทั้งหมด';

  @override
  String get filterToBuy => 'ต้องซื้อ';

  @override
  String get filterInCart => 'ในตะกร้า';

  @override
  String get filterNotFound => 'ไม่พบ';

  @override
  String get filterRequired => 'จำเป็น';

  @override
  String get quickEntryTitle => 'ราคาจริง';

  @override
  String get actualQuantityLabel => 'จำนวนจริง';

  @override
  String get actualPriceLabel => 'ราคาจริง';

  @override
  String get discountLabel => 'ส่วนลด (ไม่บังคับ)';

  @override
  String get alternativeNameLabel => 'ชื่อสินค้าสำรอง (ไม่บังคับ)';

  @override
  String get savePurchaseButton => 'เพิ่มลงตะกร้า';

  @override
  String get unplannedAddButton => 'เพิ่มรายการที่ไม่ได้วางแผน';

  @override
  String get statusPending => 'ยังไม่ได้หยิบ';

  @override
  String get statusInCart => 'ในตะกร้า';

  @override
  String get statusNotFound => 'ไม่พบ';

  @override
  String get statusGaveUp => 'ยกเลิก';

  @override
  String get statusAlternative => 'ซื้อสินค้าตัวอื่นแทน';

  @override
  String get keepScreenAwake => 'เปิดหน้าจอไว้';

  @override
  String get finishShopping => 'เสร็จสิ้นการช้อปปิ้ง';

  @override
  String get completionWarning =>
      'มีข้อมูลที่ยังขาดหรือยังไม่ตรวจสอบ คุณสามารถจบกระบวนการได้; ผลลัพธ์จะบันทึกสถานะเหล่านั้นไว้';

  @override
  String get continueShoppingButton => 'ช้อปต่อ';

  @override
  String get resultTitle => 'ผลลัพธ์';

  @override
  String get summarySection => 'สรุปผล';

  @override
  String get plannedTotalLabel => 'ยอดรวมที่วางแผน';

  @override
  String get actualTotalLabel => 'ยอดรวมจริง';

  @override
  String get varianceLabel => 'ส่วนต่าง';

  @override
  String get varianceNotComputable => 'ไม่สามารถคำนวณได้';

  @override
  String get budgetStatusLabel => 'งบประมาณ';

  @override
  String get savingsLabel => 'ต่ำกว่าแผน';

  @override
  String get overspendLabel => 'สูงกว่าแผน';

  @override
  String get unplannedTotalLabel => 'ยอดรวมรายการนอกแผน';

  @override
  String get unpurchasedLabel => 'วางแผนแต่ไม่ได้ซื้อ';

  @override
  String get totalDiscountLabel => 'ส่วนลดรวม';

  @override
  String get accuracyLabel => 'ความแม่นยำของการประมาณการ';

  @override
  String get groupsSection => 'รายการสินค้า';

  @override
  String get groupPricier => 'แพงกว่าที่คาดไว้';

  @override
  String get groupCheaper => 'ถูกกว่าที่คาดไว้';

  @override
  String get groupClose => 'ใกล้เคียงกับการประมาณการ';

  @override
  String get groupNotTaken => 'วางแผนแต่ไม่ได้ซื้อ';

  @override
  String get groupUnplanned => 'ซื้อมาโดยไม่มีในแผน';

  @override
  String get groupQuantityChanged => 'จำนวนเปลี่ยนแปลง';

  @override
  String get groupUnverified => 'ยังไม่ตรวจสอบ';

  @override
  String get plannedQtyLabel => 'จำนวนที่วางแผน';

  @override
  String get actualQtyLabel => 'จำนวนจริง';

  @override
  String get plannedUnitPriceLabel => 'ราคาต่อหน่วยที่วางแผน';

  @override
  String get actualUnitPriceLabel => 'ราคาต่อหน่วยจริง';

  @override
  String get lineVarianceLabel => 'ส่วนต่างของรายการ';

  @override
  String get discountEffectLabel => 'ผลกระทบจากส่วนลด';

  @override
  String get notBoughtMark => 'ไม่ได้ซื้อ';

  @override
  String get noPurchasesNote => 'ไม่มีการบันทึกการซื้อ';

  @override
  String get navHome => 'หน้าแรก';

  @override
  String get navLists => 'รายการ';

  @override
  String get navHistory => 'ประวัติ';

  @override
  String get navSettings => 'การตั้งค่า';

  @override
  String get homeEmptyTitle => 'วางแผนช้อปปิ้งของคุณ';

  @override
  String get homeEmptyBody =>
      'สร้างรายการแรกของคุณและเปรียบเทียบค่าใช้จ่ายที่วางแผนไว้กับค่าใช้จ่ายจริง';

  @override
  String get homeActiveSection => 'รายการที่กำลังทำอยู่';

  @override
  String get homeCompletedSection => 'เสร็จสิ้นเมื่อเร็วๆ นี้';

  @override
  String get homeMonthlySection => 'เดือนนี้';

  @override
  String get monthPlannedLabel => 'วางแผนไว้';

  @override
  String get monthActualLabel => 'จริง';

  @override
  String get monthVarianceLabel => 'ส่วนต่าง';

  @override
  String get continueShoppingLabel => 'ช้อปต่อ';

  @override
  String get historyEmpty =>
      'ยังไม่มีรายการช้อปปิ้งที่เสร็จสิ้น ประวัติและข้อมูลเชิงลึกจะแสดงที่นี่';

  @override
  String get aboutTabTitle => 'เกี่ยวกับ NShoptor';

  @override
  String get aboutBody =>
      'NShoptor โดย Crazy Penguin ตัววางแผนช้อปปิ้งแบบออฟไลน์เป็นอันดับแรก อนุญาตภายใต้ GPL-3.0';

  @override
  String get startShoppingLabel => 'เริ่มช้อปปิ้ง';

  @override
  String get finishAndSeeResult => 'เสร็จสิ้น & ดูผลลัพธ์';

  @override
  String get settingsTitle => 'การตั้งค่า';

  @override
  String get languageLabel => 'ภาษา';

  @override
  String get languageSystem => 'ระบบ';

  @override
  String get languageTr => 'ตุรกี';

  @override
  String get languageEn => 'อังกฤษ';

  @override
  String get themeLabel => 'ธีม';

  @override
  String get themeSystem => 'ระบบ';

  @override
  String get themeLight => 'สว่าง';

  @override
  String get themeDark => 'มืด';

  @override
  String get defaultCurrencyLabel => 'สกุลเงินเริ่มต้น';

  @override
  String get defaultUnitLabel => 'หน่วยเริ่มต้น';

  @override
  String get keepAwakeLabel => 'คงหน้าจอเปิดขณะช้อปปิ้ง';

  @override
  String get backupSection => 'สำรองข้อมูล';

  @override
  String get exportBackupLabel => 'ส่งออกการสำรองข้อมูล';

  @override
  String get importBackupLabel => 'นำเข้าการสำรองข้อมูล';

  @override
  String get mergeImportLabel => 'รวมเข้ากับข้อมูลปัจจุบัน';

  @override
  String get separateImportLabel => 'นำเข้าเป็นสำเนาแยกต่างหาก';

  @override
  String get importCancelled => 'ยกเลิกการนำเข้าแล้ว';

  @override
  String get backupExported => 'ส่งออกการสำรองข้อมูลสำเร็จ';

  @override
  String get backupSizeWarning =>
      'ไฟล์สำรองข้อมูลขนาดใหญ่: ไฟล์อาจมีขนาดใหญ่อยากที่จะรวมรูปภาพด้วยหรือไม่?';

  @override
  String get deleteAllSection => 'โซนอันตราย';

  @override
  String get deleteAllLabel => 'ลบข้อมูลทั้งหมด';

  @override
  String get deleteAllConfirm =>
      'สิ่งนี้จะลบทุกรายการ ประวัติ รูปภาพใบเสร็จ และราคา ไฟล์ที่คุณส่งออกจะยังคงอยู่บนไดรฟ์ของคุณ ดำเนินการต่อหรือไม่?';

  @override
  String get deleteAllConfirm2 =>
      'คุณแน่ใจจริงๆ หรือไม่? การกระทำนี้ไม่สามารถย้อนกลับได้';

  @override
  String get cancelAction => 'ยกเลิก';

  @override
  String get confirmDelete => 'ลบถาวร';

  @override
  String get dataDeleted => 'ลบข้อมูลในเครื่องทั้งหมดแล้ว';

  @override
  String get privacyInfoLabel => 'ความเป็นส่วนตัว';

  @override
  String get privacyInfoBody =>
      'รายการ ราคา ใบเสร็จ และรูปภาพของคุณจะอยู่ในอุปกรณ์ของคุณเท่านั้น รูปภาพและเสียงจะไม่ออกนอกอุปกรณ์ เมื่อเปิดใช้งาน AI ช่วยเหลือ จะส่งเฉพาะข้อความ (เช่น รายการในใบเสร็จหรือสิ่งที่คุณพูด) ไปยังเซิร์ฟเวอร์ของเราเพื่อประมวลผลและไม่มีการเก็บรักษา';

  @override
  String get aboutSection => 'เกี่ยวกับ';

  @override
  String get aboutPublisher => 'ผู้เผยแพร่: Crazy Penguin';

  @override
  String get aboutLicenses => 'ใบอนุญาต (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'การป้อนข้อมูลด้วยเสียง';

  @override
  String get voiceStatusUnknown => 'บริการ: ยังไม่ได้ตรวจสอบ';

  @override
  String get permissionsLabel => 'สิทธิ์';

  @override
  String get permissionsBody =>
      'กล้อง ไมโครโฟน และการแจ้งเตือนจะขอใช้ก็ต่อเมื่อคุณใช้งานฟีเจอร์เหล่านั้นจริงๆ เท่านั้น';

  @override
  String get unitsSection => 'ค่าเริ่มต้น';

  @override
  String get roundingNote =>
      'การปัดเศษเงินปฏิบัติตามกฎเดียวคือครึ่งหนึ่งจะปัดขึ้นเสมอ ใช้เพียงครั้งเดียวในการแปลงเงิน';

  @override
  String get voiceInputTitle => 'การป้อนข้อมูลด้วยเสียง';

  @override
  String get voiceStartListening => 'เริ่มฟัง';

  @override
  String get voiceTranscriptLabel => 'คำบรรยาย';

  @override
  String get parseAction => 'วิเคราะห์';

  @override
  String get receiptReviewTitle => 'ตรวจสอบใบเสร็จ';

  @override
  String get receiptTotal => 'ยอดรวมใบเสร็จ';

  @override
  String get receiptTotalUnknown => 'ไม่พบยอดรวม';

  @override
  String get receiptDiff => 'ส่วนต่าง';

  @override
  String get acceptLine => 'ยอมรับรายการนี้';

  @override
  String get ignoreLine => 'ข้ามรายการนี้';

  @override
  String get receiptLineActions => 'เชื่อมโยงกับสินค้า, แยก หรือข้าม';

  @override
  String get receiptCommit => 'ยอมรับทั้งหมด';

  @override
  String get receiptCommitted => 'นำข้อมูลใบเสร็จมาใช้แล้ว';

  @override
  String get priceHistoryTitle => 'ประวัติราคา';

  @override
  String get noObservations => 'ยังไม่มีข้อมูลราคา';

  @override
  String get templatesSection => 'แม่แบบ';

  @override
  String get templateHint => 'สร้างแผนใหม่จากรายการซื้อครั้งก่อน';

  @override
  String get scanReceiptAction => 'สแกนใบเสร็จ';

  @override
  String get shelfLabelAction => 'ราคาจากป้ายราคาบนชั้น';

  @override
  String get priceCandidatesTitle => 'ตัวเลือกราคา';

  @override
  String get noPriceCandidates => 'ไม่พบราคา; กรุณากรอกเอง';

  @override
  String get voiceUnavailable =>
      'ระบบแปลงเสียงเป็นข้อความใช้งานไม่ได้; กรุณากรอกเอง';

  @override
  String get linkToItem => 'เชื่อมโยงกับสินค้า';

  @override
  String get splitLine => 'แยกเป็นสองรายการ';

  @override
  String get mergeWithNext => 'รวมกับรายการถัดไป';

  @override
  String get ocrNoText => 'ไม่พบข้อความ; ลองอีกครั้ง';

  @override
  String get priceHistoryAction => 'ประวัติราคา';

  @override
  String get itemsEmptyTitle => 'ยังไม่มีรายการ';

  @override
  String get itemsEmptyBody =>
      'เพิ่มรายการแรกของคุณ — คุณจะกรอกราคาจริงที่นี่เมื่ออยู่ในร้าน';

  @override
  String get addItemTooltip => 'เพิ่มรายการ';

  @override
  String get unitAdet => 'ชิ้น';

  @override
  String get unitKilogram => 'กก.';

  @override
  String get unitGram => 'กรัม';

  @override
  String get unitLitre => 'ลิตร';

  @override
  String get unitMililitre => 'มล.';

  @override
  String get unitPaket => 'แพ็ก';

  @override
  String get unitKutu => 'กล่อง';

  @override
  String get unitSise => 'ขวด';

  @override
  String get unitKavanoz => 'โหล';

  @override
  String get unitDemet => 'กำ';

  @override
  String get unitDuzine => 'ดือน';

  @override
  String get unitMetre => 'เมตร';

  @override
  String get unitCustom => 'กำหนดเอง';

  @override
  String get setReminderAction => 'ตั้งการแจ้งเตือน';

  @override
  String get reminderPermissionDenied =>
      'จำเป็นต้องอนุญาตการแจ้งเตือนสำหรับการเตือน คุณสามารถเปิดใช้งานในการตั้งค่าระบบ';

  @override
  String get reminderScheduled => 'ตั้งการแจ้งเตือนแล้ว';

  @override
  String get reminderCancelled => 'ลบการแจ้งเตือนแล้ว';

  @override
  String get reminderTitle => 'การแจ้งเตือนช้อปปิ้ง';

  @override
  String reminderBody(Object title) {
    return 'ถึงเวลาตรวจสอบรายการของคุณ: $title';
  }

  @override
  String get reminderPickDate => 'เลือกวันที่';

  @override
  String get reminderPickTime => 'เลือกเวลา';

  @override
  String get itemDetailsSection => 'รายละเอียด';

  @override
  String get priceOptionalHint =>
      'ไม่บังคับ — คุณจะสามารถกรอกราคาจริงในร้านได้';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'วางแผนไว้: $total · $count รายการ';
  }

  @override
  String get proActiveLabel => 'Pro เปิดใช้งานแล้ว — ขอบคุณ!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'ไม่มีโฆษณา, AI มากขึ้น, สำรองข้อมูล · เริ่มต้นที่ราคาต่อเดือนเล็กน้อย';

  @override
  String get proBenefitNoAds => 'ประสบการณ์ไร้โฆษณา';

  @override
  String get proBenefitBackup => 'สำรองข้อมูล (ส่งออก/นำเข้า)';

  @override
  String aboutVersion(Object version) {
    return 'เวอร์ชัน $version';
  }

  @override
  String get navDiscover => 'ค้นพบ';

  @override
  String get shareAction => 'แชร์แอป';

  @override
  String get rateAction => 'ให้คะแนนเรา';

  @override
  String get aboutOpenRow => 'เกี่ยวกับ & โอเพนซอร์ส';

  @override
  String get voiceAddItemAction => 'เพิ่มด้วยเสียง';

  @override
  String get formatLocaleLabel => 'รูปแบบตัวเลขและสกุลเงิน';

  @override
  String get formatLocaleSystem =>
      'รูปแบบของอุปกรณ์ (ตัวเลขละติน; หากไม่ใช่เป็นภาษาอังกฤษ)';

  @override
  String get formatLocaleTr => 'ตุรกี (1.234,56)';

  @override
  String get formatLocaleEn => 'อังกฤษ (1,234.56)';

  @override
  String get aiToggleTitle => 'ช่วยเหลือโดย AI';

  @override
  String get aiToggleSubtitle =>
      'จับคู่ใบเสร็จ อ่านป้ายราคา และแปลงประโยคเป็นรายการ รูปภาพและเสียงจะอยู่ในอุปกรณ์ของคุณเท่านั้น มีเพียงข้อความเท่านั้นที่ถูกประมวลผล';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'คุณใช้คำขอ AI ประจำเดือนหมดแล้ว ($used/$limit) อัปเกรดเพื่อใช้งานเพิ่มเติม หรือดำเนินการต่อโดยไม่ใช้ AI';
  }

  @override
  String get aiOffline => 'ไม่มีอินเทอร์เน็ต — ดำเนินการต่อโดยไม่ใช้ AI';

  @override
  String get aiFailed =>
      'AI ไม่สามารถใช้งานได้ชั่วคราว — ดำเนินการต่อโดยไม่ใช้ AI';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'อุปกรณ์';

  @override
  String get quickListAction => 'เพิ่มจากประโยค';

  @override
  String get quickListTitle => 'รายการด่วน';

  @override
  String get quickListHint =>
      'เช่น แอปเปิล 1 กก. 20 บาท ขนมปัง 2 ห่อ ชีสครึ่งกิโล';

  @override
  String get quickListConvert => 'แปลงเป็นรายการ';

  @override
  String quickListAdd(int count) {
    return 'เพิ่ม $count รายการ';
  }

  @override
  String get quickListEmpty => 'ไม่พบรายการ ลองเขียนแยกด้วยเครื่องหมายจุลภาค';

  @override
  String get receiptAiMatched =>
      'AI จับคู่ใบเสร็จกับรายการของคุณแล้ว ตรวจสอบลิงก์และยืนยัน';

  @override
  String get receiptNeedsCheck => 'ตรวจสอบการจับคู่นี้';

  @override
  String get receiptDiscountLine => 'ส่วนลด';

  @override
  String get compareItem => 'สินค้า';

  @override
  String get compareEstimated => 'ประมาณการ';

  @override
  String get compareActual => 'จริง';

  @override
  String get compareDiff => 'ส่วนต่าง';

  @override
  String get compareTotal => 'รวม';

  @override
  String get compareBudget => 'งบประมาณ';

  @override
  String get compareNotBought => 'ไม่ได้ซื้อ';

  @override
  String get compareUnplanned => 'ไม่ได้วางแผนไว้';

  @override
  String get pricierItems => 'แพงกว่า';

  @override
  String get cheaperItems => 'ถูกกว่า';

  @override
  String get compareAction => 'เปรียบเทียบ';

  @override
  String get detailsSection => 'รายละเอียด';

  @override
  String get spendingTitle => 'ค่าใช้จ่าย';

  @override
  String get spendingAction => 'ค่าใช้จ่าย';

  @override
  String get spendingMonthTotal => 'เดือนนี้';

  @override
  String get spendingWeekly => 'รายสัปดาห์';

  @override
  String get spendingMonthly => 'รายเดือน';

  @override
  String get monthlyLimitTitle => 'จำกัดรายเดือน';

  @override
  String get monthlyLimitHelp =>
      'คุณต้องการใช้จ่ายกับการช้อปปิ้งต่อเดือนเท่าไหร่?';

  @override
  String get monthlyLimitRemove => 'ลบ';

  @override
  String get monthlyLimitSet => 'ตั้ง';

  @override
  String get monthlyLimitChange => 'เปลี่ยน';

  @override
  String get monthlyLimitNone => 'ตั้งวงเงินรายเดือนเพื่อดูยอดคงเหลือ';

  @override
  String monthlyLimitOver(String amount) {
    return 'เกินวงเงินอยู่ $amount';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return 'เหลือ $amount ในเดือนนี้';
  }

  @override
  String get plansTitle => 'แพ็กเกจ';

  @override
  String get plansHeadline => 'ช้อปฉลาดขึ้นด้วย AI';

  @override
  String get plansSubhead =>
      'จับคู่ใบเสร็จ อ่านป้ายราคา และสร้างจากรายการประโยค ยกเลิกได้ทุกเมื่อ';

  @override
  String get plansMonthly => 'รายเดือน';

  @override
  String get plansYearly => 'รายปี';

  @override
  String get planFree => 'ฟรี';

  @override
  String get planFreePrice => 'ฟรีตลอดไป';

  @override
  String get planFreeAi => '15 คำขอ AI ต่อเดือน';

  @override
  String get planFreeAds => 'โฆษณาแบนเนอร์เล็กน้อย (ไม่มีใน 7 วันแรก)';

  @override
  String get planCoreFeatures => 'รายการ ราคา ใบเสร็จ กราฟค่าใช้จ่าย';

  @override
  String get plansPerYear => '/ ปี';

  @override
  String get plansPerMonth => '/ เดือน';

  @override
  String get planTrial => 'ทดลองใช้ฟรี 7 วัน';

  @override
  String get planProAi => '200 คำขอ AI ต่อเดือน';

  @override
  String get planNoAds => 'ไม่มีโฆษณา';

  @override
  String get planBackup => 'สำรองและนำเข้าข้อมูล';

  @override
  String get planMaxAi => 'ใช้ AI ได้ 1000 ครั้งต่อเดือน';

  @override
  String get planMaxFamily => 'เหมาะสำหรับการช้อปสำหรับครอบครัวใหญ่';

  @override
  String get plansStoreUnavailable => 'ขณะนี้ไม่สามารถเข้าถึงร้านค้าได้';

  @override
  String get retryAction => 'ลองอีกครั้ง';

  @override
  String get plansPurchaseFailed => 'การซื้อไม่สำเร็จ กรุณาลองอีกครั้ง';

  @override
  String get planLifetimeTitle => 'ไม่มีโฆษณาตลอดชีพ';

  @override
  String get planLifetimeSubtitle =>
      'จ่ายครั้งเดียว: ไม่มีโฆษณา, สำรองข้อมูล; ใช้ AI ตามโควตาฟรี';

  @override
  String get plansRestore => 'คืนค่าการซื้อ';

  @override
  String get plansLegal =>
      'การสมัครสมาชิกจะต่ออายุอัตโนมัติจนกว่าจะยกเลิก ยกเลิกได้ทุกเมื่อที่ Google Play › การชำระเงินและการสมัครสมาชิก ราคาประกอบด้วยภาษีตามที่แสดงโดย Google Play';

  @override
  String get planCurrent => 'ปัจจุบัน';

  @override
  String get planStartTrial => 'เริ่มทดลองใช้ฟรี 7 วัน';

  @override
  String get planChoose => 'เลือก';

  @override
  String get plansAction => 'แผน: Pro และ Max';

  @override
  String get assistantTitle => 'ผู้ช่วย';

  @override
  String get assistantGreeting => 'สวัสดี! คุณต้องการทำอะไร?';

  @override
  String get assistantNewList => 'สร้างรายการใหม่';

  @override
  String get assistantVoiceList => 'สร้างรายการด้วยเสียง';

  @override
  String get assistantTextList => 'สร้างรายการจากข้อความ';

  @override
  String get assistantScanReceipt => 'สแกนใบเสร็จ';

  @override
  String get assistantSpending => 'ค่าใช้จ่ายของฉัน';

  @override
  String get assistantReceiptHint =>
      'เปิดรายการของคุณแล้วแตะไอคอนใบเสร็จเพื่อสแกน';

  @override
  String get assistantToggleTitle => 'แสดงผู้ช่วย';

  @override
  String get assistantToggleSubtitle => 'ตัวช่วยเล็กๆ ที่มุมขวาล่าง';

  @override
  String get scanPriceLabel => 'สแกนราคาสินค้า';

  @override
  String get saveFailed =>
      'บันทึกไม่สำเร็จ การเปลี่ยนแปลงของคุณยังคงอยู่ กรุณาลองอีกครั้ง';

  @override
  String get deleteItemConfirm =>
      'ต้องการลบรายการนี้และประวัติการซื้อที่บันทึกไว้หรือไม่?';

  @override
  String get clearPurchaseConfirm =>
      'ต้องการยกเลิกเลือกสินค้านี้และลบประวัติการซื้อที่บันทึกไว้หรือไม่?';

  @override
  String get reportPdfAction => 'บันทึกรายงานเป็น PDF';

  @override
  String get reportNotInvoice =>
      'สรุปยอดการช้อปปิ้ง ไม่ใช่ใบกำกับภาษี อัตราภาษีจึงยังไม่ทราบ';

  @override
  String get purchaseVisits => 'จำนวนครั้งในการช้อปปิ้ง';

  @override
  String get purchaseInterval => 'จำนวนวันเฉลี่ยระหว่างการซื้อ';

  @override
  String get purchasedQuantity => 'ปริมาณที่ซื้อ';

  @override
  String get purchaseAnalyticsHint =>
      'การซื้อไม่ได้วัดการบริโภค สกุลเงินและหน่วยจะแสดงแยกกัน';

  @override
  String get receiptReplaces =>
      'บรรทัดในใบเสร็จที่เชื่อมโยงจะแทนที่การซื้อที่มีอยู่; บรรทัดที่ไม่ได้เชื่อมโยงจะถูกเพิ่มเข้าไป';

  @override
  String get voiceUnsupportedLanguage =>
      'ภาษานี้ไม่รองรับการป้อนข้อมูลด้วยเสียงบนอุปกรณ์นี้ คุณสามารถพิมพ์แทนได้';

  @override
  String get voiceStopListening => 'หยุดฟัง';
}
