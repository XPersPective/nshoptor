// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => '집에서 계획하고, 계획대로 쇼핑하세요.';

  @override
  String get listsTitle => '리스트';

  @override
  String get listsTabActive => '활성';

  @override
  String get listsTabCompleted => '완료됨';

  @override
  String get listsTabArchived => '보관함';

  @override
  String get newListButton => '새 리스트';

  @override
  String get listTitleHint => '제목 (선택사항)';

  @override
  String get saveButton => '저장';

  @override
  String get cancelButton => '취소';

  @override
  String get deleteButton => '삭제';

  @override
  String get editAction => '편집';

  @override
  String get listDeleted => '리스트가 삭제되었습니다';

  @override
  String get invalidAmountError => '금액이 유효하지 않습니다';

  @override
  String get duplicateAction => '복제';

  @override
  String get archiveAction => '보관';

  @override
  String get unarchiveAction => '보관 해제';

  @override
  String get deleteListConfirm => '이 리스트를 삭제하시겠습니까? 계획된 항목도 함께 제거됩니다.';

  @override
  String get undoButton => '실행 취소';

  @override
  String get searchListHint => '리스트 검색';

  @override
  String get currencyLabel => '통화';

  @override
  String get budgetLabel => '예산 (선택사항)';

  @override
  String get noteLabel => '메모 (선택사항)';

  @override
  String get storeLabel => '매장';

  @override
  String get keepAmountsAction => '금액 유지';

  @override
  String get resetAmountsAction => '금액 초기화';

  @override
  String get currencyChangeWarning => '통화가 변경됩니다. 기존 금액은 어떻게 처리할까요?';

  @override
  String get listsEmpty => '아직 리스트가 없습니다. 첫 번째 쇼핑 계획을 만들어보세요.';

  @override
  String get statusDraft => '임시 저장';

  @override
  String get statusPlanned => '계획됨';

  @override
  String get statusShopping => '쇼핑 중';

  @override
  String get statusCompleted => '완료됨';

  @override
  String get statusArchived => '보관됨';

  @override
  String autoListTitle(String date) {
    return '$date 쇼핑';
  }

  @override
  String get itemFormTitle => '항목 추가';

  @override
  String get itemNameLabel => '상품명';

  @override
  String get brandLabel => '브랜드 / 변형 (선택사항)';

  @override
  String get categoryLabel => '카테고리';

  @override
  String get quantityLabel => '수량';

  @override
  String get unitLabel => '단위';

  @override
  String get pricingModeLabel => '가격 입력 방식';

  @override
  String get pricingModeUnitPrice => '단가';

  @override
  String get pricingModeLineTotal => '합계';

  @override
  String get plannedPriceLabel => '예상 가격';

  @override
  String lineTotalCalculated(String value) {
    return '합계: $value';
  }

  @override
  String get requiredItemToggle => '필수 항목';

  @override
  String get maxPriceLabel => '최대 허용 가격 (선택사항)';

  @override
  String get itemNoteLabel => '메모 (선택사항)';

  @override
  String get categoryProduce => '과일 및 채소';

  @override
  String get categoryDairy => '유제품';

  @override
  String get categoryMeat => '육류';

  @override
  String get categoryBakery => '베이커리';

  @override
  String get categoryDrinks => '음료';

  @override
  String get categoryCleaning => '청소용품';

  @override
  String get categoryPersonalCare => '개인 위생용품';

  @override
  String get categoryHome => '가정용품';

  @override
  String get categoryOther => '기타';

  @override
  String get invalidQuantityError => '수량이 유효하지 않습니다';

  @override
  String get invalidPriceError => '가격이 유효하지 않습니다';

  @override
  String get invalidNameError => '이름을 입력하세요';

  @override
  String unitPriceCalculated(String value) {
    return '단가: $value';
  }

  @override
  String get shoppingTitle => '쇼핑 모드';

  @override
  String get summaryPlannedTotal => '예상 금액';

  @override
  String get summaryInCart => '장바구니';

  @override
  String get summaryRemainingPlan => '남은 계획';

  @override
  String get summaryProjected => '예상 결제 금액';

  @override
  String get summaryBudgetRemaining => '예산 남음';

  @override
  String get summaryBudgetOver => '예산 초과';

  @override
  String itemsProgress(String done, String total) {
    return '$total개 중 $done개 완료';
  }

  @override
  String get filterAll => '전체';

  @override
  String get filterToBuy => '구매 예정';

  @override
  String get filterInCart => '장바구니';

  @override
  String get filterNotFound => '미발견';

  @override
  String get filterRequired => '필수';

  @override
  String get quickEntryTitle => '실제 가격';

  @override
  String get actualQuantityLabel => '실제 수량';

  @override
  String get actualPriceLabel => '실제 가격';

  @override
  String get discountLabel => '할인 (선택)';

  @override
  String get alternativeNameLabel => '대체 제품명 (선택)';

  @override
  String get savePurchaseButton => '장바구니에 추가';

  @override
  String get unplannedAddButton => '계획 외 항목 추가';

  @override
  String get statusPending => '미구매';

  @override
  String get statusInCart => '장바구니';

  @override
  String get statusNotFound => '미발견';

  @override
  String get statusGaveUp => '포기';

  @override
  String get statusAlternative => '대체 구매';

  @override
  String get keepScreenAwake => '화면 켜짐 유지';

  @override
  String get finishShopping => '쇼핑 종료';

  @override
  String get completionWarning => '누락 또는 미확인 기록이 있습니다. 계속 진행하면 결과에 반영됩니다.';

  @override
  String get continueShoppingButton => '쇼핑 계속하기';

  @override
  String get resultTitle => '결과';

  @override
  String get summarySection => '요약';

  @override
  String get plannedTotalLabel => '예상 총액';

  @override
  String get actualTotalLabel => '실제 총액';

  @override
  String get varianceLabel => '차액';

  @override
  String get varianceNotComputable => '계산 불가';

  @override
  String get budgetStatusLabel => '예산';

  @override
  String get savingsLabel => '예산 절약';

  @override
  String get overspendLabel => '예산 초과';

  @override
  String get unplannedTotalLabel => '계획 외 지출';

  @override
  String get unpurchasedLabel => '구매하지 않은 계획 항목';

  @override
  String get totalDiscountLabel => '총 할인액';

  @override
  String get accuracyLabel => '예상 정확도';

  @override
  String get groupsSection => '항목';

  @override
  String get groupPricier => '예상보다 비쌈';

  @override
  String get groupCheaper => '예상보다 저렴함';

  @override
  String get groupClose => '예상과 유사함';

  @override
  String get groupNotTaken => '구매하지 않음';

  @override
  String get groupUnplanned => '계획 없이 구매';

  @override
  String get groupQuantityChanged => '수량 변경';

  @override
  String get groupUnverified => '미확인';

  @override
  String get plannedQtyLabel => '예상 수량';

  @override
  String get actualQtyLabel => '실제 수량';

  @override
  String get plannedUnitPriceLabel => '예상 단가';

  @override
  String get actualUnitPriceLabel => '실제 단가';

  @override
  String get lineVarianceLabel => '라인 차액';

  @override
  String get discountEffectLabel => '할인 효과';

  @override
  String get notBoughtMark => '미구매';

  @override
  String get noPurchasesNote => '구매 내역이 없습니다.';

  @override
  String get navHome => '홈';

  @override
  String get navLists => '리스트';

  @override
  String get navHistory => '기록';

  @override
  String get navSettings => '설정';

  @override
  String get homeEmptyTitle => '장보기 계획하기';

  @override
  String get homeEmptyBody => '첫 번째 리스트를 만들고 예상 비용과 실제 비용을 비교하세요.';

  @override
  String get homeActiveSection => '진행 중인 리스트';

  @override
  String get homeCompletedSection => '최근 완료';

  @override
  String get homeMonthlySection => '이번 달';

  @override
  String get monthPlannedLabel => '예상';

  @override
  String get monthActualLabel => '실제';

  @override
  String get monthVarianceLabel => '차이';

  @override
  String get continueShoppingLabel => '쇼핑 계속하기';

  @override
  String get historyEmpty => '완료된 장보기가 없습니다. 기록과 인사이트가 여기에 표시됩니다.';

  @override
  String get aboutTabTitle => 'NShoptor 소개';

  @override
  String get aboutBody =>
      'Crazy Penguin의 NShoptor. 오프라인 우선 장보기 플래너. GPL-3.0 라이선스.';

  @override
  String get startShoppingLabel => '쇼핑 시작하기';

  @override
  String get finishAndSeeResult => '완료 및 결과 보기';

  @override
  String get settingsTitle => '설정';

  @override
  String get languageLabel => '언어';

  @override
  String get languageSystem => '시스템';

  @override
  String get languageTr => '터키어';

  @override
  String get languageEn => '영어';

  @override
  String get themeLabel => '테마';

  @override
  String get themeSystem => '시스템';

  @override
  String get themeLight => '밝게';

  @override
  String get themeDark => '어둡게';

  @override
  String get defaultCurrencyLabel => '기본 통화';

  @override
  String get defaultUnitLabel => '기본 단위';

  @override
  String get keepAwakeLabel => '쇼핑 중 화면 켜기 유지';

  @override
  String get backupSection => '백업';

  @override
  String get exportBackupLabel => '백업 내보내기';

  @override
  String get importBackupLabel => '백업 가져오기';

  @override
  String get mergeImportLabel => '현재 데이터에 병합';

  @override
  String get separateImportLabel => '별도 사본으로 가져오기';

  @override
  String get importCancelled => '가져오기가 취소되었습니다.';

  @override
  String get backupExported => '백업이 성공적으로 내보냈습니다.';

  @override
  String get backupSizeWarning => '대용량 백업: 파일이 클 수 있습니다. 사진도 포함하시겠습니까?';

  @override
  String get deleteAllSection => '위험 구역';

  @override
  String get deleteAllLabel => '모든 데이터 삭제';

  @override
  String get deleteAllConfirm =>
      '모든 리스트, 기록, 영수증 사진 및 가격이 제거됩니다. 사용자가 내보낸 파일은 저장소에 그대로 남아 있습니다. 계속하시겠습니까?';

  @override
  String get deleteAllConfirm2 => '정말 확실한가요? 이 작업은 되돌릴 수 없습니다.';

  @override
  String get cancelAction => '취소';

  @override
  String get confirmDelete => '영구 삭제';

  @override
  String get dataDeleted => '모든 로컬 데이터가 삭제되었습니다.';

  @override
  String get privacyInfoLabel => '개인정보처리방침';

  @override
  String get privacyInfoBody =>
      '리스트, 가격, 영수증 및 사진은 모두 기기에 보관됩니다. 사진과 음성은 절대 외부로 전송되지 않습니다. AI 도움이 활성화되면 텍스트(예: 영수증 항목 또는 음성 입력 내용)만 처리를 위해 서버로 전송되며 저장되지 않습니다.';

  @override
  String get aboutSection => '소개';

  @override
  String get aboutPublisher => '발행자: Crazy Penguin';

  @override
  String get aboutLicenses => '라이선스 (GPL-3.0)';

  @override
  String get voiceSettingsLabel => '음성 입력';

  @override
  String get voiceStatusUnknown => '서비스: 확인 안 함';

  @override
  String get permissionsLabel => '권한';

  @override
  String get permissionsBody => '카메라, 마이크 및 알림 권한은 해당 기능을 실제로 사용할 때에만 요청됩니다.';

  @override
  String get unitsSection => '기본값';

  @override
  String get roundingNote =>
      '금액 반올림은 하나의 규칙을 따릅니다: .5는 0에서 멀리는 방향으로 반올림되며, Money 변환 시 한 번만 적용됩니다.';

  @override
  String get voiceInputTitle => '음성 입력';

  @override
  String get voiceStartListening => '듣기 시작';

  @override
  String get voiceTranscriptLabel => '변환된 텍스트';

  @override
  String get parseAction => '분석';

  @override
  String get receiptReviewTitle => '영수증 검토';

  @override
  String get receiptTotal => '영수증 합계';

  @override
  String get receiptTotalUnknown => '합계 감지 안 됨';

  @override
  String get receiptDiff => '차이';

  @override
  String get acceptLine => '항목 승인';

  @override
  String get ignoreLine => '항목 무시';

  @override
  String get receiptLineActions => '아이템 연결, 분할 또는 무시';

  @override
  String get receiptCommit => '모두 승인';

  @override
  String get receiptCommitted => '영수증이 적용되었습니다.';

  @override
  String get priceHistoryTitle => '가격 이력';

  @override
  String get noObservations => '아직 가격 기록이 없습니다';

  @override
  String get templatesSection => '템플릿';

  @override
  String get templateHint => '이전 장보기에서 새 계획 만들기';

  @override
  String get scanReceiptAction => '영수증 스캔';

  @override
  String get shelfLabelAction => '선반 라벨 가격';

  @override
  String get priceCandidatesTitle => '가격 후보';

  @override
  String get noPriceCandidates => '가격을 찾지 못했습니다. 직접 입력하세요.';

  @override
  String get voiceUnavailable => '음성 인식을 사용할 수 없습니다. 직접 입력하세요.';

  @override
  String get linkToItem => '아이템에 연결';

  @override
  String get splitLine => '두 개로 분할';

  @override
  String get mergeWithNext => '다음 항목과 병합';

  @override
  String get ocrNoText => '텍스트를 읽지 못했습니다. 다시 시도하세요.';

  @override
  String get priceHistoryAction => '가격 이력';

  @override
  String get itemsEmptyTitle => '아직 아이템이 없습니다';

  @override
  String get itemsEmptyBody => '첫 번째 아이템을 추가하세요. 매장에서 실제 가격을 여기에 입력합니다.';

  @override
  String get addItemTooltip => '아이템 추가';

  @override
  String get unitAdet => '개';

  @override
  String get unitKilogram => 'kg';

  @override
  String get unitGram => 'g';

  @override
  String get unitLitre => 'L';

  @override
  String get unitMililitre => 'ml';

  @override
  String get unitPaket => '팩';

  @override
  String get unitKutu => '박스';

  @override
  String get unitSise => '병';

  @override
  String get unitKavanoz => '통';

  @override
  String get unitDemet => '단';

  @override
  String get unitDuzine => '조';

  @override
  String get unitMetre => 'm';

  @override
  String get unitCustom => '사용자 지정';

  @override
  String get setReminderAction => '알림 설정';

  @override
  String get reminderPermissionDenied =>
      '알림을 사용하려면 알림 권한이 필요합니다. 시스템 설정에서 활성화할 수 있습니다.';

  @override
  String get reminderScheduled => '알림이 설정되었습니다.';

  @override
  String get reminderCancelled => '알림이 제거되었습니다.';

  @override
  String get reminderTitle => '장보기 알림';

  @override
  String reminderBody(Object title) {
    return '리스트 확인 시간: $title';
  }

  @override
  String get reminderPickDate => '날짜 선택';

  @override
  String get reminderPickTime => '시간 선택';

  @override
  String get itemDetailsSection => '세부 정보';

  @override
  String get priceOptionalHint => '선택 사항 — 매장에서 실제 가격을 입력합니다';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return '예상: $total · $count개 항목';
  }

  @override
  String get proActiveLabel => 'Pro 활성 — 감사합니다!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine => '광고 없음, AI 기능 강화, 백업 · 월 소액 요금부터';

  @override
  String get proBenefitNoAds => '광고 없는 경험';

  @override
  String get proBenefitBackup => '백업 (내보내기/가져오기)';

  @override
  String aboutVersion(Object version) {
    return '버전 $version';
  }

  @override
  String get navDiscover => '발견하기';

  @override
  String get shareAction => '앱 공유하기';

  @override
  String get rateAction => '평가하기';

  @override
  String get aboutOpenRow => '정보 및 오픈소스';

  @override
  String get voiceAddItemAction => '음성으로 추가';

  @override
  String get formatLocaleLabel => '숫자 및 통화 형식';

  @override
  String get formatLocaleSystem => '시스템 (앱 언어 따름)';

  @override
  String get formatLocaleTr => '터키어 (1.234,56)';

  @override
  String get formatLocaleEn => '영어 (1,234.56)';

  @override
  String get aiToggleTitle => 'AI 도움말';

  @override
  String get aiToggleSubtitle =>
      '영수증을 매칭하고 가격 라벨을 읽으며 문장을 목록으로 변환합니다. 사진과 음성은 기기 내부에 저장되며 텍스트만 처리됩니다.';

  @override
  String aiQuotaReached(int used, int limit) {
    return '이번 달 AI 요청 한도($used/$limit)를 모두 사용했습니다. 더 많은 사용을 위해 업그레이드하거나, AI 없이 계속 진행하세요.';
  }

  @override
  String get aiOffline => '연결 없음 — AI 없이 계속 진행합니다.';

  @override
  String get aiFailed => '현재 AI를 사용할 수 없습니다 — AI 없이 계속 진행합니다.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => '기기';

  @override
  String get quickListAction => '문장으로 추가';

  @override
  String get quickListTitle => '빠른 목록';

  @override
  String get quickListHint => '예: 사과 1kg 20원, 빵 2개, 치즈 반 kg';

  @override
  String get quickListConvert => '목록으로 변환';

  @override
  String quickListAdd(int count) {
    return '$count개 항목 추가';
  }

  @override
  String get quickListEmpty => '항목을 찾지 못했습니다. 쉼표로 구분하여 나열해 보세요.';

  @override
  String get receiptAiMatched => 'AI가 영수증을 목록과 매칭했습니다. 링크를 확인하고 승인하세요.';

  @override
  String get receiptNeedsCheck => '이 매칭 확인하기';

  @override
  String get receiptDiscountLine => '할인';

  @override
  String get compareItem => '항목';

  @override
  String get compareEstimated => '예상';

  @override
  String get compareActual => '실제';

  @override
  String get compareDiff => '차이';

  @override
  String get compareTotal => '합계';

  @override
  String get compareBudget => '예산';

  @override
  String get compareNotBought => '구매 안 함';

  @override
  String get compareUnplanned => '계획 안 함';

  @override
  String get pricierItems => '더 비쌈';

  @override
  String get cheaperItems => '더 저렴함';

  @override
  String get compareAction => '비교';

  @override
  String get detailsSection => '세부 정보';

  @override
  String get spendingTitle => '지출';

  @override
  String get spendingAction => '지출';

  @override
  String get spendingMonthTotal => '이번 달';

  @override
  String get spendingWeekly => '주간 지출';

  @override
  String get spendingMonthly => '월간 지출';

  @override
  String get monthlyLimitTitle => '월간 한도';

  @override
  String get monthlyLimitHelp => '매월 장보기에 얼마를 쓰려 하시나요?';

  @override
  String get monthlyLimitRemove => '삭제';

  @override
  String get monthlyLimitSet => '설정';

  @override
  String get monthlyLimitChange => '변경';

  @override
  String get monthlyLimitNone => '남은 금액을 보려면 월간 한도를 설정하세요.';

  @override
  String monthlyLimitOver(String amount) {
    return '한도 $amount 초과';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return '이번 달 $amount 남음';
  }

  @override
  String get plansTitle => '플랜';

  @override
  String get plansHeadline => 'AI로 smarter 쇼핑';

  @override
  String get plansSubhead => '영수증 매칭, 가격 라벨 인식, 문장 기반 목록 생성. 언제든지 취소 가능.';

  @override
  String get plansMonthly => '월간';

  @override
  String get plansYearly => '연간';

  @override
  String get planFree => '무료';

  @override
  String get planFreePrice => '영구 무료';

  @override
  String get planFreeAi => '월 15회 AI 요청';

  @override
  String get planFreeAds => '소형 배너 광고 (첫 7일 동안 없음)';

  @override
  String get planCoreFeatures => '목록, 가격, 영수증, 지출 차트';

  @override
  String get plansPerYear => '/ 년';

  @override
  String get plansPerMonth => '/ 월';

  @override
  String get planTrial => '7일 무료 체험';

  @override
  String get planProAi => '월 200회 AI 요청';

  @override
  String get planNoAds => '광고 없음';

  @override
  String get planBackup => '백업 내보내기 및 가져오기';

  @override
  String get planMaxAi => '월 1000회 AI 요청';

  @override
  String get planMaxFamily => '대가족 쇼핑용';

  @override
  String get plansStoreUnavailable => '현재 매장에 연결할 수 없습니다.';

  @override
  String get retryAction => '다시 시도';

  @override
  String get plansPurchaseFailed => '구매가 완료되지 않았습니다. 다시 시도해 주세요.';

  @override
  String get planLifetimeTitle => '평생 광고 없음';

  @override
  String get planLifetimeSubtitle =>
      '일시불: 광고 제거, 백업 지원; AI는 무료 요금제 범위 내에서 사용 가능';

  @override
  String get plansRestore => '구독 복원';

  @override
  String get plansLegal =>
      '구독은 취소하기 전까지 자동으로 갱신됩니다. Google Play › 결제 및 구독에서 언제든지 취소할 수 있습니다. 가격은 Google Play에 표시된 세금이 포함된 가격입니다.';

  @override
  String get planCurrent => '현재';

  @override
  String get planStartTrial => '7일 무료 체험 시작';

  @override
  String get planChoose => '선택';

  @override
  String get plansAction => '플랜: Pro 및 Max';

  @override
  String get assistantTitle => '어시스턴트';

  @override
  String get assistantGreeting => '안녕하세요! 무엇을 도와드릴까요?';

  @override
  String get assistantNewList => '새 목록';

  @override
  String get assistantVoiceList => '음성으로 목록 만들기';

  @override
  String get assistantTextList => '문장으로 목록 만들기';

  @override
  String get assistantScanReceipt => '영수증 스캔';

  @override
  String get assistantSpending => '내 지출 현황';

  @override
  String get assistantReceiptHint => '목록을 열고 영수증 아이콘을 탭하여 스캔하세요.';

  @override
  String get assistantToggleTitle => '어시스턴트 표시';

  @override
  String get assistantToggleSubtitle => '오른쪽 하단의 작은 도우미';
}
