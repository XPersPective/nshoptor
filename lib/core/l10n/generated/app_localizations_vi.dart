// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Lên kế hoạch tại nhà. Đi mua sắm theo kế hoạch.';

  @override
  String get listsTitle => 'Danh sách';

  @override
  String get listsTabActive => 'Đang hoạt động';

  @override
  String get listsTabCompleted => 'Hoàn thành';

  @override
  String get listsTabArchived => 'Đã lưu trữ';

  @override
  String get newListButton => 'Tạo danh sách mới';

  @override
  String get listTitleHint => 'Tiêu đề (không bắt buộc)';

  @override
  String get saveButton => 'Lưu';

  @override
  String get cancelButton => 'Hủy';

  @override
  String get deleteButton => 'Xóa';

  @override
  String get editAction => 'Chỉnh sửa';

  @override
  String get listDeleted => 'Đã xóa danh sách';

  @override
  String get invalidAmountError => 'Số lượng không hợp lệ';

  @override
  String get duplicateAction => 'Sao chép';

  @override
  String get archiveAction => 'Lưu trữ';

  @override
  String get unarchiveAction => 'Bỏ lưu trữ';

  @override
  String get deleteListConfirm =>
      'Xóa danh sách này? Các mục đã lên kế hoạch trong đó cũng sẽ bị xóa.';

  @override
  String get undoButton => 'Hoàn tác';

  @override
  String get searchListHint => 'Tìm kiếm danh sách';

  @override
  String get currencyLabel => 'Đơn vị tiền tệ';

  @override
  String get budgetLabel => 'Ngân sách (không bắt buộc)';

  @override
  String get noteLabel => 'Ghi chú (không bắt buộc)';

  @override
  String get storeLabel => 'Cửa hàng';

  @override
  String get keepAmountsAction => 'Giữ nguyên số lượng';

  @override
  String get resetAmountsAction => 'Đặt lại số lượng';

  @override
  String get currencyChangeWarning =>
      'Đang thay đổi đơn vị tiền tệ. Bạn muốn xử lý các số lượng hiện có như thế nào?';

  @override
  String get listsEmpty =>
      'Chưa có danh sách nào. Hãy tạo kế hoạch mua sắm đầu tiên của bạn.';

  @override
  String get statusDraft => 'Nháp';

  @override
  String get statusPlanned => 'Đã lên kế hoạch';

  @override
  String get statusShopping => 'Đang mua sắm';

  @override
  String get statusCompleted => 'Hoàn thành';

  @override
  String get statusArchived => 'Đã lưu trữ';

  @override
  String autoListTitle(String date) {
    return 'Mua sắm $date';
  }

  @override
  String get itemFormTitle => 'Thêm mục';

  @override
  String get itemNameLabel => 'Tên mục';

  @override
  String get brandLabel => 'Thương hiệu / biến thể (không bắt buộc)';

  @override
  String get categoryLabel => 'Danh mục';

  @override
  String get quantityLabel => 'Số lượng';

  @override
  String get unitLabel => 'Đơn vị';

  @override
  String get pricingModeLabel => 'Cách nhập giá';

  @override
  String get pricingModeUnitPrice => 'Giá trên một đơn vị';

  @override
  String get pricingModeLineTotal => 'Tổng dòng';

  @override
  String get plannedPriceLabel => 'Giá dự kiến';

  @override
  String lineTotalCalculated(String value) {
    return 'Tổng dòng: $value';
  }

  @override
  String get requiredItemToggle => 'Mục bắt buộc';

  @override
  String get maxPriceLabel => 'Giá tối đa chấp nhận được (không bắt buộc)';

  @override
  String get itemNoteLabel => 'Ghi chú (không bắt buộc)';

  @override
  String get categoryProduce => 'Trái cây & rau củ';

  @override
  String get categoryDairy => 'Sản phẩm từ sữa';

  @override
  String get categoryMeat => 'Thịt';

  @override
  String get categoryBakery => 'Bánh mì';

  @override
  String get categoryDrinks => 'Đồ uống';

  @override
  String get categoryCleaning => 'Vệ sinh';

  @override
  String get categoryPersonalCare => 'Chăm sóc cá nhân';

  @override
  String get categoryHome => 'Gia dụng';

  @override
  String get categoryOther => 'Khác';

  @override
  String get invalidQuantityError => 'Số lượng không hợp lệ';

  @override
  String get invalidPriceError => 'Giá không hợp lệ';

  @override
  String get invalidNameError => 'Vui lòng nhập tên';

  @override
  String unitPriceCalculated(String value) {
    return 'Đơn giá: $value';
  }

  @override
  String get shoppingTitle => 'Chế độ mua sắm';

  @override
  String get summaryPlannedTotal => 'Đã lên kế hoạch';

  @override
  String get summaryInCart => 'Trong giỏ';

  @override
  String get summaryRemainingPlan => 'Kế hoạch còn lại';

  @override
  String get summaryProjected => 'Dự kiến thanh toán';

  @override
  String get summaryBudgetRemaining => 'Ngân sách còn lại';

  @override
  String get summaryBudgetOver => 'Vượt ngân sách';

  @override
  String itemsProgress(String done, String total) {
    return '$done trong tổng số $total món';
  }

  @override
  String get filterAll => 'Tất cả';

  @override
  String get filterToBuy => 'Cần mua';

  @override
  String get filterInCart => 'Trong giỏ';

  @override
  String get filterNotFound => 'Không tìm thấy';

  @override
  String get filterRequired => 'Bắt buộc';

  @override
  String get quickEntryTitle => 'Giá thực tế';

  @override
  String get actualQuantityLabel => 'Số lượng thực tế';

  @override
  String get actualPriceLabel => 'Giá thực tế';

  @override
  String get discountLabel => 'Giảm giá (tùy chọn)';

  @override
  String get alternativeNameLabel => 'Tên sản phẩm thay thế (tùy chọn)';

  @override
  String get savePurchaseButton => 'Thêm vào giỏ';

  @override
  String get unplannedAddButton => 'Thêm món ngoài kế hoạch';

  @override
  String get statusPending => 'Chưa lấy';

  @override
  String get statusInCart => 'Trong giỏ';

  @override
  String get statusNotFound => 'Không tìm thấy';

  @override
  String get statusGaveUp => 'Từ bỏ';

  @override
  String get statusAlternative => 'Đã mua hàng thay thế';

  @override
  String get keepScreenAwake => 'Giữ màn hình sáng';

  @override
  String get finishShopping => 'Kết thúc mua sắm';

  @override
  String get completionWarning =>
      'Có mục thiếu hoặc chưa xác minh. Bạn vẫn có thể hoàn tất; kết quả sẽ ghi chú các mục này.';

  @override
  String get continueShoppingButton => 'Tiếp tục mua sắm';

  @override
  String get resultTitle => 'Kết quả';

  @override
  String get summarySection => 'Tổng quan';

  @override
  String get plannedTotalLabel => 'Tổng đã lên kế hoạch';

  @override
  String get actualTotalLabel => 'Tổng thực tế';

  @override
  String get varianceLabel => 'Chênh lệch';

  @override
  String get varianceNotComputable => 'Không thể tính';

  @override
  String get budgetStatusLabel => 'Ngân sách';

  @override
  String get savingsLabel => 'Dưới mức dự kiến';

  @override
  String get overspendLabel => 'Quá mức dự kiến';

  @override
  String get unplannedTotalLabel => 'Tổng ngoài kế hoạch';

  @override
  String get unpurchasedLabel => 'Đã lên kế hoạch nhưng chưa mua';

  @override
  String get totalDiscountLabel => 'Tổng giảm giá';

  @override
  String get accuracyLabel => 'Độ chính xác ước tính';

  @override
  String get groupsSection => 'Món hàng';

  @override
  String get groupPricier => 'Đắt hơn dự kiến';

  @override
  String get groupCheaper => 'Rẻ hơn dự kiến';

  @override
  String get groupClose => 'Sát với ước tính';

  @override
  String get groupNotTaken => 'Đã lên kế hoạch, chưa mua';

  @override
  String get groupUnplanned => 'Mua mà không có kế hoạch';

  @override
  String get groupQuantityChanged => 'Thay đổi số lượng';

  @override
  String get groupUnverified => 'Chưa xác minh';

  @override
  String get plannedQtyLabel => 'Số lượng dự kiến';

  @override
  String get actualQtyLabel => 'Số lượng thực tế';

  @override
  String get plannedUnitPriceLabel => 'Đơn giá dự kiến';

  @override
  String get actualUnitPriceLabel => 'Đơn giá thực tế';

  @override
  String get lineVarianceLabel => 'Chênh lệch dòng';

  @override
  String get discountEffectLabel => 'Hiệu ứng giảm giá';

  @override
  String get notBoughtMark => 'chưa mua';

  @override
  String get noPurchasesNote => 'Không có giao dịch nào được ghi nhận.';

  @override
  String get navHome => 'Trang chủ';

  @override
  String get navLists => 'Danh sách';

  @override
  String get navHistory => 'Lịch sử';

  @override
  String get navSettings => 'Cài đặt';

  @override
  String get homeEmptyTitle => 'Lên kế hoạch mua sắm';

  @override
  String get homeEmptyBody =>
      'Tạo danh sách đầu tiên và so sánh chi phí dự kiến với thực tế.';

  @override
  String get homeActiveSection => 'Danh sách đang hoạt động';

  @override
  String get homeCompletedSection => 'Hoàn thành gần đây';

  @override
  String get homeMonthlySection => 'Tháng này';

  @override
  String get monthPlannedLabel => 'Dự kiến';

  @override
  String get monthActualLabel => 'Thực tế';

  @override
  String get monthVarianceLabel => 'Chênh lệch';

  @override
  String get continueShoppingLabel => 'Tiếp tục mua sắm';

  @override
  String get historyEmpty =>
      'Chưa có lần mua sắm nào hoàn tất. Lịch sử và phân tích của bạn sẽ hiển thị ở đây.';

  @override
  String get aboutTabTitle => 'Giới thiệu về NShoptor';

  @override
  String get aboutBody =>
      'NShoptor bởi Crazy Penguin. Ứng dụng lên kế hoạch mua sắm hoạt động ngoại tuyến. Cấp phép theo GPL-3.0.';

  @override
  String get startShoppingLabel => 'Bắt đầu mua sắm';

  @override
  String get finishAndSeeResult => 'Hoàn tất & xem kết quả';

  @override
  String get settingsTitle => 'Cài đặt';

  @override
  String get languageLabel => 'Ngôn ngữ';

  @override
  String get languageSystem => 'Hệ thống';

  @override
  String get languageTr => 'Tiếng Thổ Nhĩ Kỳ';

  @override
  String get languageEn => 'Tiếng Anh';

  @override
  String get themeLabel => 'Giao diện';

  @override
  String get themeSystem => 'Hệ thống';

  @override
  String get themeLight => 'Sáng';

  @override
  String get themeDark => 'Tối';

  @override
  String get defaultCurrencyLabel => 'Đơn vị tiền tệ mặc định';

  @override
  String get defaultUnitLabel => 'Đơn vị đo mặc định';

  @override
  String get keepAwakeLabel => 'Giữ màn hình sáng khi mua sắm';

  @override
  String get backupSection => 'Sao lưu';

  @override
  String get exportBackupLabel => 'Xuất bản sao lưu';

  @override
  String get importBackupLabel => 'Nhập bản sao lưu';

  @override
  String get mergeImportLabel => 'Hợp nhất vào dữ liệu hiện tại';

  @override
  String get separateImportLabel => 'Nhập dưới dạng bản sao riêng biệt';

  @override
  String get importCancelled => 'Đã hủy nhập.';

  @override
  String get backupExported => 'Sao lưu đã được xuất thành công.';

  @override
  String get backupSizeWarning =>
      'Bản sao lưu lớn: tệp có thể khá nặng. Bạn có muốn bao gồm cả ảnh không?';

  @override
  String get deleteAllSection => 'Khu vực nguy hiểm';

  @override
  String get deleteAllLabel => 'Xóa toàn bộ dữ liệu';

  @override
  String get deleteAllConfirm =>
      'Điều này sẽ xóa tất cả danh sách, lịch sử, ảnh biên lai và giá. Các tệp do bạn xuất vẫn nằm trên ổ đĩa của bạn. Tiếp tục?';

  @override
  String get deleteAllConfirm2 =>
      'Bạn có chắc chắn hoàn toàn không? Hành động này không thể hoàn tác.';

  @override
  String get cancelAction => 'Hủy';

  @override
  String get confirmDelete => 'Xóa vĩnh viễn';

  @override
  String get dataDeleted => 'Tất cả dữ liệu cục bộ đã bị xóa.';

  @override
  String get privacyInfoLabel => 'Quyền riêng tư';

  @override
  String get privacyInfoBody =>
      'Danh sách, giá cả, biên lai và ảnh của bạn đều lưu trên thiết bị. Ảnh và giọng nói không bao giờ rời khỏi thiết bị của bạn. Khi tính năng AI trợ giúp được bật, chỉ văn bản (ví dụ: dòng từ biên lai hoặc nội dung bạn nói) được gửi đến máy chủ của chúng tôi để xử lý và không được lưu trữ.';

  @override
  String get aboutSection => 'Giới thiệu';

  @override
  String get aboutPublisher => 'Nhà phát hành: Crazy Penguin';

  @override
  String get aboutLicenses => 'Giấy phép (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Nhập bằng giọng nói';

  @override
  String get voiceStatusUnknown => 'Dịch vụ: chưa kiểm tra';

  @override
  String get permissionsLabel => 'Quyền truy cập';

  @override
  String get permissionsBody =>
      'Camera, microphone và thông báo chỉ được yêu cầu khi bạn thực sự sử dụng các tính năng đó.';

  @override
  String get unitsSection => 'Mặc định';

  @override
  String get roundingNote =>
      'Làm tròn tiền tuân theo một quy tắc: số nửa làm tròn ra xa số 0, áp dụng một lần khi chuyển đổi sang Tiền.';

  @override
  String get voiceInputTitle => 'Nhập bằng giọng nói';

  @override
  String get voiceStartListening => 'Bắt đầu nghe';

  @override
  String get voiceTranscriptLabel => 'Nội dung đã nhận';

  @override
  String get parseAction => 'Phân tích';

  @override
  String get receiptReviewTitle => 'Kiểm tra biên lai';

  @override
  String get receiptTotal => 'Tổng hóa đơn';

  @override
  String get receiptTotalUnknown => 'Chưa xác định được tổng';

  @override
  String get receiptDiff => 'Chênh lệch';

  @override
  String get acceptLine => 'Chấp nhận dòng này';

  @override
  String get ignoreLine => 'Bỏ qua dòng này';

  @override
  String get receiptLineActions => 'Liên kết với mục, chia nhỏ hoặc bỏ qua';

  @override
  String get receiptCommit => 'Chấp nhận tất cả';

  @override
  String get receiptCommitted => 'Đã áp dụng hóa đơn.';

  @override
  String get priceHistoryTitle => 'Lịch sử giá';

  @override
  String get noObservations => 'Chưa có dữ liệu giá nào';

  @override
  String get templatesSection => 'Mẫu';

  @override
  String get templateHint => 'Tạo kế hoạch mới từ chuyến mua sắm trước đó';

  @override
  String get scanReceiptAction => 'Quét hóa đơn';

  @override
  String get shelfLabelAction => 'Giá từ nhãn kệ hàng';

  @override
  String get priceCandidatesTitle => 'Các mức giá gợi ý';

  @override
  String get noPriceCandidates => 'Không tìm thấy giá; vui lòng nhập thủ công.';

  @override
  String get voiceUnavailable =>
      'Nhận diện giọng nói không khả dụng; vui lòng nhập thủ công.';

  @override
  String get linkToItem => 'Liên kết với mục';

  @override
  String get splitLine => 'Chia thành hai';

  @override
  String get mergeWithNext => 'Gộp với dòng tiếp theo';

  @override
  String get ocrNoText => 'Không đọc được văn bản; vui lòng thử lại.';

  @override
  String get priceHistoryAction => 'Lịch sử giá';

  @override
  String get itemsEmptyTitle => 'Chưa có mục nào';

  @override
  String get itemsEmptyBody =>
      'Thêm mục đầu tiên — bạn sẽ nhập giá thực tế tại cửa hàng ở đây.';

  @override
  String get addItemTooltip => 'Thêm mục';

  @override
  String get unitAdet => 'cái';

  @override
  String get unitKilogram => 'kg';

  @override
  String get unitGram => 'g';

  @override
  String get unitLitre => 'L';

  @override
  String get unitMililitre => 'ml';

  @override
  String get unitPaket => 'gói';

  @override
  String get unitKutu => 'hộp';

  @override
  String get unitSise => 'chai';

  @override
  String get unitKavanoz => 'lọ';

  @override
  String get unitDemet => 'bó';

  @override
  String get unitDuzine => 'tr dozen';

  @override
  String get unitMetre => 'm';

  @override
  String get unitCustom => 'Tùy chỉnh';

  @override
  String get setReminderAction => 'Đặt nhắc nhở';

  @override
  String get reminderPermissionDenied =>
      'Cần quyền thông báo để sử dụng tính năng nhắc nhở. Bạn có thể bật trong cài đặt hệ thống.';

  @override
  String get reminderScheduled => 'Đã đặt nhắc nhở.';

  @override
  String get reminderCancelled => 'Đã hủy nhắc nhở.';

  @override
  String get reminderTitle => 'Nhắc nhở mua sắm';

  @override
  String reminderBody(Object title) {
    return 'Đã đến lúc kiểm tra danh sách của bạn: $title';
  }

  @override
  String get reminderPickDate => 'Chọn ngày';

  @override
  String get reminderPickTime => 'Chọn giờ';

  @override
  String get itemDetailsSection => 'Chi tiết';

  @override
  String get priceOptionalHint =>
      'Tùy chọn — bạn sẽ nhập giá thực tế tại cửa hàng';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Dự kiến: $total · $count mục';
  }

  @override
  String get proActiveLabel => 'Pro đang hoạt động — cảm ơn bạn!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Không quảng cáo, nhiều AI hơn, sao lưu · từ một khoản phí hàng tháng nhỏ';

  @override
  String get proBenefitNoAds => 'Trải nghiệm không quảng cáo';

  @override
  String get proBenefitBackup => 'Sao lưu (xuất/nhập)';

  @override
  String aboutVersion(Object version) {
    return 'Phiên bản $version';
  }

  @override
  String get navDiscover => 'Khám phá';

  @override
  String get shareAction => 'Chia sẻ ứng dụng';

  @override
  String get rateAction => 'Đánh giá chúng tôi';

  @override
  String get aboutOpenRow => 'Giới thiệu & mã nguồn mở';

  @override
  String get voiceAddItemAction => 'Thêm bằng giọng nói';

  @override
  String get formatLocaleLabel => 'Định dạng số & tiền tệ';

  @override
  String get formatLocaleSystem =>
      'Định dạng thiết bị (chữ số Latin; nếu không thì tiếng Anh)';

  @override
  String get formatLocaleTr => 'Tiếng Thổ Nhĩ Kỳ (1.234,56)';

  @override
  String get formatLocaleEn => 'Tiếng Anh (1,234.56)';

  @override
  String get aiToggleTitle => 'Trợ lý AI';

  @override
  String get aiToggleSubtitle =>
      'So khớp hóa đơn, đọc nhãn giá và chuyển câu thành danh sách. Ảnh và giọng nói được lưu trên thiết bị của bạn; chỉ có văn bản được xử lý.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Bạn đã dùng hết lượt yêu cầu AI trong tháng này ($used/$limit). Nâng cấp để có thêm lượt, hoặc tiếp tục mà không cần AI.';
  }

  @override
  String get aiOffline => 'Không có kết nối — đang tiếp tục mà không dùng AI.';

  @override
  String get aiFailed =>
      'AI hiện không khả dụng — đang tiếp tục mà không dùng nó.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'Thiết bị';

  @override
  String get quickListAction => 'Thêm từ một câu';

  @override
  String get quickListTitle => 'Danh sách nhanh';

  @override
  String get quickListHint => 'vd: 1 kg táo 20, 2 ổ bánh mì, nửa ký phô mai';

  @override
  String get quickListConvert => 'Chuyển thành danh sách';

  @override
  String quickListAdd(int count) {
    return 'Thêm $count mục';
  }

  @override
  String get quickListEmpty =>
      'Không tìm thấy mục nào. Hãy thử liệt kê chúng cách nhau bởi dấu phẩy.';

  @override
  String get receiptAiMatched =>
      'AI đã so khớp hóa đơn với danh sách của bạn. Hãy kiểm tra các liên kết và xác nhận.';

  @override
  String get receiptNeedsCheck => 'Kiểm tra sự so khớp này';

  @override
  String get receiptDiscountLine => 'Giảm giá';

  @override
  String get compareItem => 'Mục';

  @override
  String get compareEstimated => 'Ước tính';

  @override
  String get compareActual => 'Thực tế';

  @override
  String get compareDiff => 'Chênh lệch';

  @override
  String get compareTotal => 'Tổng cộng';

  @override
  String get compareBudget => 'Ngân sách';

  @override
  String get compareNotBought => 'chưa mua';

  @override
  String get compareUnplanned => 'chưa lên kế hoạch';

  @override
  String get pricierItems => 'Đắt hơn';

  @override
  String get cheaperItems => 'Rẻ hơn';

  @override
  String get compareAction => 'So sánh';

  @override
  String get detailsSection => 'Chi tiết';

  @override
  String get spendingTitle => 'Chi tiêu';

  @override
  String get spendingAction => 'Chi tiêu';

  @override
  String get spendingMonthTotal => 'Tháng này';

  @override
  String get spendingWeekly => 'Chi tiêu hàng tuần';

  @override
  String get spendingMonthly => 'Chi tiêu hàng tháng';

  @override
  String get monthlyLimitTitle => 'Hạn mức hàng tháng';

  @override
  String get monthlyLimitHelp =>
      'Bạn muốn chi bao nhiêu cho việc mua sắm mỗi tháng?';

  @override
  String get monthlyLimitRemove => 'Xóa';

  @override
  String get monthlyLimitSet => 'Đặt';

  @override
  String get monthlyLimitChange => 'Thay đổi';

  @override
  String get monthlyLimitNone =>
      'Đặt hạn mức hàng tháng để xem số tiền còn lại.';

  @override
  String monthlyLimitOver(String amount) {
    return 'Vượt hạn mức $amount';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return '$amount còn lại trong tháng này';
  }

  @override
  String get plansTitle => 'Gói dịch vụ';

  @override
  String get plansHeadline => 'Mua sắm thông minh hơn với AI';

  @override
  String get plansSubhead =>
      'So khớp hóa đơn, đọc nhãn giá và tạo danh sách từ một câu. Hủy bất cứ lúc nào.';

  @override
  String get plansMonthly => 'Hàng tháng';

  @override
  String get plansYearly => 'Hàng năm';

  @override
  String get planFree => 'Miễn phí';

  @override
  String get planFreePrice => 'Miễn phí mãi mãi';

  @override
  String get planFreeAi => '15 lượt yêu cầu AI mỗi tháng';

  @override
  String get planFreeAds =>
      'Quảng cáo biểu ngữ nhỏ (không quảng cáo trong 7 ngày đầu tiên của bạn)';

  @override
  String get planCoreFeatures => 'Danh sách, giá cả, hóa đơn, biểu đồ chi tiêu';

  @override
  String get plansPerYear => '/ năm';

  @override
  String get plansPerMonth => '/ tháng';

  @override
  String get planTrial => 'Dùng thử miễn phí 7 ngày';

  @override
  String get planProAi => '200 lượt yêu cầu AI mỗi tháng';

  @override
  String get planNoAds => 'Không quảng cáo';

  @override
  String get planBackup => 'Sao lưu, xuất và nhập';

  @override
  String get planMaxAi => '1000 yêu cầu AI mỗi tháng';

  @override
  String get planMaxFamily => 'Dành cho mua sắm gia đình đông người';

  @override
  String get plansStoreUnavailable => 'Cửa hàng hiện không thể truy cập.';

  @override
  String get retryAction => 'Thử lại';

  @override
  String get plansPurchaseFailed =>
      'Giao dịch chưa thành công. Vui lòng thử lại.';

  @override
  String get planLifetimeTitle => 'Không quảng cáo trọn đời';

  @override
  String get planLifetimeSubtitle =>
      'Thanh toán một lần: không quảng cáo, sao lưu; AI vẫn dùng gói miễn phí';

  @override
  String get plansRestore => 'Khôi phục giao dịch';

  @override
  String get plansLegal =>
      'Gói đăng ký tự động gia hạn đến khi bạn hủy. Hủy bất cứ lúc nào trong Google Play › Thanh toán & gói đăng ký. Giá đã bao gồm thuế do Google Play hiển thị.';

  @override
  String get planCurrent => 'Đang dùng';

  @override
  String get planStartTrial => 'Bắt đầu dùng thử 7 ngày miễn phí';

  @override
  String get planChoose => 'Chọn';

  @override
  String get plansAction => 'Gói: Pro và Max';

  @override
  String get assistantTitle => 'Trợ lý';

  @override
  String get assistantGreeting => 'Chào! Bạn muốn làm gì?';

  @override
  String get assistantNewList => 'Danh sách mới';

  @override
  String get assistantVoiceList => 'Nhập danh sách bằng giọng nói';

  @override
  String get assistantTextList => 'Nhập danh sách từ câu văn';

  @override
  String get assistantScanReceipt => 'Quét hóa đơn';

  @override
  String get assistantSpending => 'Chi tiêu của tôi';

  @override
  String get assistantReceiptHint =>
      'Mở danh sách của bạn và nhấn vào biểu tượng hóa đơn để quét.';

  @override
  String get assistantToggleTitle => 'Hiển thị trợ lý';

  @override
  String get assistantToggleSubtitle => 'Trợ lý nhỏ ở góc dưới bên phải';

  @override
  String get scanPriceLabel => 'Quét giá';

  @override
  String get saveFailed =>
      'Không thể lưu. Thay đổi của bạn vẫn còn ở đây. Vui lòng thử lại.';

  @override
  String get deleteItemConfirm => 'Xóa mục này và các lần mua đã ghi nhận?';

  @override
  String get clearPurchaseConfirm =>
      'Bỏ chọn mục này và xóa các lần mua đã ghi nhận?';

  @override
  String get reportPdfAction => 'Lưu báo cáo PDF';

  @override
  String get reportNotInvoice =>
      'Tóm tắt mua sắm, không phải hóa đơn thuế. Không rõ mức thuế.';

  @override
  String get purchaseVisits => 'Lần mua hàng';

  @override
  String get purchaseInterval => 'Số ngày trung bình giữa các lần mua';

  @override
  String get purchasedQuantity => 'Số lượng đã mua';

  @override
  String get purchaseAnalyticsHint =>
      'Mua hàng không đo lường mức tiêu thụ. Đơn vị tiền tệ và đơn vị tính được hiển thị riêng biệt.';

  @override
  String get receiptReplaces =>
      'Các dòng hóa đơn liên kết sẽ thay thế các lần mua hiện có; các dòng không liên kết sẽ được thêm vào.';

  @override
  String get voiceUnsupportedLanguage =>
      'Ngôn ngữ này không hỗ trợ nhập giọng nói trên thiết bị này. Bạn có thể gõ văn bản thay thế.';
}
