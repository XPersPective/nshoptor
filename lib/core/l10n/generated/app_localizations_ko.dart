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
      '리스트, 가격, 영수증 및 사진은 기기에 저장됩니다. 음성은 기기 밖으로 나가지 않습니다. AI 도움말이 켜져 있으면 영수증과 가격표 사진(크기를 줄인 것)과 받아쓰기한 항목 같은 텍스트가 읽기 목적으로만 서버로 전송되며, 즉시 처리된 후 저장되지 않습니다.';

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
  String get fromReceiptListButton => '영수증에서';

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
  String get proBenefitsLine => '광고 없음 · 백업 내보내기 및 가져오기 · 연간';

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
  String get formatLocaleSystem => '기기 설정 (숫자는 아라비아 숫자; 나머지는 영어)';

  @override
  String get formatLocaleTr => '터키어 (1.234,56)';

  @override
  String get formatLocaleEn => '영어 (1,234.56)';

  @override
  String get aiToggleTitle => 'AI 도움말';

  @override
  String get aiToggleSubtitle =>
      '사진에서 영수증과 가격표를 읽고, 영수증을 매칭하고, 문장을 리스트로 바꿔 줍니다. 사진은 읽기 위해서만 전송되며 저장되지 않습니다.';

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
  String get planFreeAi => '월 10회 AI 요청';

  @override
  String get planFreeAds => '소형 배너 광고 (첫 7일 동안 없음)';

  @override
  String get planCoreFeatures => '목록, 가격, 영수증, 지출 차트';

  @override
  String get plansPerYear => '/ 년';

  @override
  String get plansPerMonth => '/ 월';

  @override
  String get planTrial => '무료 체험';

  @override
  String get planProAi => '월 100회 AI 요청';

  @override
  String get planNoAds => '광고 없음';

  @override
  String get planBackup => '백업 내보내기 및 가져오기';

  @override
  String get planMaxAi => '월 300회 AI 요청';

  @override
  String get planMaxFamily => '대가족 쇼핑용';

  @override
  String get plansStoreUnavailable => '현재 매장에 연결할 수 없습니다.';

  @override
  String get retryAction => '다시 시도';

  @override
  String get plansPurchaseFailed => '구매가 완료되지 않았습니다. 다시 시도해 주세요.';

  @override
  String get plansRestore => '구독 복원';

  @override
  String get plansLegal =>
      'Pro는 해지할 때까지 매년 자동 갱신되며 매월 AI 요청 100회가 포함됩니다. 기본 가격은 해당 세금 별도로 연간 미화 1달러입니다. 구매를 확정하기 전에 스토어에서 최종 현지 가격과 세금을 확인하세요. Google Play에서 구독을 관리하거나 해지할 수 있습니다.';

  @override
  String get planCurrent => '현재';

  @override
  String get planStartTrial => '무료 체험 시작';

  @override
  String get planChoose => '선택';

  @override
  String get plansAction => '플랜: Pro';

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

  @override
  String get scanPriceLabel => '가격 라벨 스캔';

  @override
  String get saveFailed => '저장하지 못했습니다. 변경 사항은 그대로 유지됩니다. 다시 시도해 주세요.';

  @override
  String get deleteItemConfirm => '이 항목과 기록된 구매 내역을 삭제하시겠습니까?';

  @override
  String get clearPurchaseConfirm => '이 항목의 체크를 해제하고 기록된 구매 내역을 삭제하시겠습니까?';

  @override
  String get reportPdfAction => 'PDF 보고서 저장';

  @override
  String get reportNotInvoice => '쇼핑 요약 정보이며 세금 계산서가 아닙니다. 세율은 알 수 없습니다.';

  @override
  String get purchaseVisits => '쇼핑 횟수';

  @override
  String get purchaseInterval => '구매 간 평균 일수';

  @override
  String get purchasedQuantity => '구매 수량';

  @override
  String get purchaseAnalyticsHint =>
      '구매 데이터는 소비량을 측정하지 않습니다. 통화와 단위는 별도로 표시됩니다.';

  @override
  String get receiptReplaces =>
      '가격이 없는 품목은 가격이 채워집니다. 시장 가격이 있는 품목은 별도 구매로 추가됩니다.';

  @override
  String get receiptIncompleteHeader => '다음 사진에 매장, 날짜, 시간, 영수증 번호를 포함하세요.';

  @override
  String get receiptIncompleteTail => '몇 개의 품목이 겹치고 최종 합계가 보이도록 다음 부분을 촬영하세요.';

  @override
  String get receiptContinuationRejected =>
      '이 사진을 이어 붙일 수 없습니다. 같은 영수증의 품목이 겹치도록 다시 촬영하세요.';

  @override
  String get receiptDraftSaved => '영수증을 임시 저장했습니다. 나중에 계속할 수 있습니다.';

  @override
  String get receiptContinueAction => '영수증 계속하기';

  @override
  String get receiptDraftsTitle => '미완료 영수증';

  @override
  String get receiptDuplicate => '이 영수증은 이미 추가되었습니다.';

  @override
  String get receiptTotalMismatch =>
      '품목 합계가 영수증 총액과 일치하지 않습니다. 영수증 전체가 보이는지 확인하세요.';

  @override
  String get receiptSaveDraftAction => '나중에 저장';

  @override
  String get receiptResolveLines => '저장하기 전에 각 항목을 승인하거나 무시하세요.';

  @override
  String get receiptPartialConfirm =>
      '선택한 항목만 추가됩니다. 이 영수증은 가져온 항목으로 표시됩니다. 계속할까요?';

  @override
  String get voiceUnsupportedLanguage =>
      '이 기기는 음성 입력을 지원하지 않는 언어입니다. 대신 텍스트로 입력할 수 있습니다.';

  @override
  String get voiceStopListening => '듣기 중지';

  @override
  String get keepAwakeFailed => '화면을 켜두지 못했습니다. 다시 시도해 주세요.';

  @override
  String get purchaseHistoryHint =>
      '완료된 모든 쇼핑 내역입니다. 반품 시 총액이 감소합니다. 날짜는 쇼핑 완료일을 기준으로 합니다. 한 번의 방문만으로는 평균 간격을 계산할 수 없습니다.';

  @override
  String get planLegacyRights => '기존 Pro 및 Max 구독은 원래 월간 AI 할당량을 유지합니다.';

  @override
  String get csvExportAction => 'CSV 내보내기';

  @override
  String get reportSharePdf => 'PDF로 공유';

  @override
  String get reportShareCsv => 'CSV로 공유';

  @override
  String get reportPrintAction => '인쇄';

  @override
  String get backupSizeWarning =>
      'JSON에는 레코드가 포함되어 있으며 사진 파일은 포함되지 않습니다. 가져오기 제한: 16MB.';

  @override
  String get backupImportFailed => '이 백업을 가져올 수 없습니다. 데이터는 변경되지 않았습니다.';

  @override
  String get backupImported => '백업이 성공적으로 가져왔습니다.';

  @override
  String backupPreviewCounts(Object entries, Object items, Object lists) {
    return '$lists 목록 · $items 항목 · $entries 구매';
  }

  @override
  String get voiceModelDownloading =>
      '이 언어의 음성 모델을 다운로드하는 중입니다. 1분 후에 다시 시도하세요.';

  @override
  String get historyThisWeek => '이번 주';

  @override
  String get historyProductsSection => '구매한 상품';

  @override
  String get tipReceiptScan => '영수증을 스캔해 가격을 목록과 맞추세요';

  @override
  String get tipVoiceAdd => '품목을 하나 이상 말하고 추가하기 전에 확인하세요';

  @override
  String get tipShelfCamera => '카메라로 진열대 라벨의 가격을 읽으세요';

  @override
  String get tipPlan => '내 요금제: 자세히 보기, 구독 또는 업그레이드';

  @override
  String get guideAddBody => '+를 눌러 품목을 추가하세요. 계획 가격은 지금, 시장 가격은 계산대에서 입력하세요.';

  @override
  String get guideVoiceBody => '마이크를 누르고 품목을 말하세요. 예: \'사과 1kg, 빵 1개\'';

  @override
  String get guideReceiptBody => '영수증을 스캔해 가격을 목록의 품목과 맞추세요.';

  @override
  String get guidePlanBody => '요금제 아이콘을 눌러 요금제를 보고, 구독하거나 업그레이드하세요.';

  @override
  String get guideNext => '확인';

  @override
  String get guideDone => '시작';

  @override
  String get paletteLabel => '색상 테마';

  @override
  String get paletteForest => '포레스트';

  @override
  String get paletteOcean => '오션';

  @override
  String get paletteSunset => '선셋';

  @override
  String get paletteLavender => '라벤더';

  @override
  String get darkBlackLabel => '다크 테마에서 완전한 검정';

  @override
  String get spendingOverview => '개요';

  @override
  String get spendingThisYear => '올해';

  @override
  String get spendingYearly => '연간 지출';

  @override
  String get productSpending => '상품별 지출';

  @override
  String get spanWeek => '주';

  @override
  String get spanMonth => '월';

  @override
  String get spanYear => '년';

  @override
  String get weeklyLimitTitle => '주간 한도';

  @override
  String get weeklyLimitHelp => '일주일에 장보기에 얼마를 쓰고 싶나요?';

  @override
  String get weeklyLimitNone => '남은 금액을 보려면 주간 한도를 설정하세요.';

  @override
  String weeklyLimitLeft(String amount) {
    return '이번 주 $amount 남음';
  }

  @override
  String get shoppingLimitTitle => '장보기당 한도';

  @override
  String get shoppingLimitHelp => '새 목록은 이 예산으로 시작합니다.';

  @override
  String get shoppingLimitNone => '새 장보기마다 기본 예산을 설정하세요.';

  @override
  String get monthlyReportAction => '월간 보고서';

  @override
  String get reportShoppingColumn => '장보기';

  @override
  String get reportDateColumn => '날짜';

  @override
  String get planUnavailable => '현재 스토어에서 이용할 수 없음';

  @override
  String get demoDataTitle => '샘플 데이터';

  @override
  String get demoDataLoad => '샘플 데이터로 사용해 보기';

  @override
  String get demoDataLoadHelp => '기록, 차트, 가격 기록을 볼 수 있도록 12개월치 샘플 장보기를 추가합니다.';

  @override
  String get demoDataRemove => '샘플 데이터 삭제';

  @override
  String get demoDataAdded => '샘플 데이터를 추가했습니다';

  @override
  String get demoDataRemoved => '샘플 데이터를 삭제했습니다';

  @override
  String get demoProductApple => '사과';

  @override
  String get demoProductBread => '빵';

  @override
  String get demoProductMilk => '우유';

  @override
  String get demoProductCheese => '치즈';

  @override
  String get demoProductTomato => '토마토';

  @override
  String get demoProductEggs => '달걀';

  @override
  String get demoProductCoffee => '커피';

  @override
  String get demoProductDetergent => '세제';

  @override
  String get sendAction => 'Send';

  @override
  String get previousMonthAction => 'Previous month';

  @override
  String get nextMonthAction => 'Next month';

  @override
  String get helpSection => '도움말 및 지원';

  @override
  String get howToUseLabel => '사용 방법';

  @override
  String get guidePricesBody =>
      '매장 가격을 입력하면 구매한 것으로 표시되며 0도 유효합니다. 집에서 예상한 가격은 선택 사항입니다. 매장 가격을 지우면 체크가 해제됩니다.';

  @override
  String get shoppingDateLabel => '쇼핑 날짜';

  @override
  String get shoppingDateNone => '선택한 날짜 없음';

  @override
  String get clearShoppingDateAction => '날짜 지우기';

  @override
  String get listSortLabel => '목록 순서';

  @override
  String get listSortDate => '쇼핑 날짜';

  @override
  String get listSortAz => '이름(A–Z)';

  @override
  String get listSortManual => '수동 순서';

  @override
  String get imageCameraAction => '사진 촬영';

  @override
  String get imageGalleryAction => '사진에서 선택';

  @override
  String get imageCaptureFailed => '카메라나 사진을 열 수 없습니다. 접근 권한을 확인하고 다시 시도하세요.';

  @override
  String get imageRecognitionFailed => '사진을 처리할 수 없습니다. 다른 사진으로 시도하세요.';

  @override
  String get receiptNoProducts =>
      '텍스트는 읽었지만 영수증의 상품을 찾지 못했습니다. 상품과 합계가 사진에 나오도록 해주세요.';

  @override
  String get keepAwakeOn => '화면이 계속 켜져 있습니다';

  @override
  String get keepAwakeOff => '화면이 꺼질 수 있습니다';

  @override
  String get spanDay => '일';

  @override
  String get spanCustom => '기간';

  @override
  String get reportTotalSpent => '총 지출';

  @override
  String get reportAddedAt => '추가 날짜';

  @override
  String get reportReceiptNumber => '영수증 번호';

  @override
  String get reportPreview => '미리보기';

  @override
  String get reportShareAction => '공유';

  @override
  String get previousPeriodAction => '이전 기간';

  @override
  String get nextPeriodAction => '다음 기간';

  @override
  String get reportSaved => '보고서가 저장되었습니다.';

  @override
  String get reportZoom => '확대';

  @override
  String planTrialDaysLeft(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days일 남음',
    );
    return '$_temp0';
  }

  @override
  String planTrialHoursLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours시간 남음',
    );
    return '$_temp0';
  }

  @override
  String get planTrialEndedTitle => 'Pro 체험 기간이 종료되었습니다';

  @override
  String get planTrialEndedBody =>
      '목록, 직접 입력, 기기 내 음성 기능은 계속 무료로 이용할 수 있습니다. Free에는 월별 10회의 AI 요청이 포함됩니다. 연간 Pro를 선택하면 매월 AI 요청 100회, 광고 제거, 백업을 이용할 수 있습니다. 기존 데이터는 그대로 유지됩니다.';

  @override
  String get planContinueFree => 'Free로 계속하기';

  @override
  String get supportIdLabel => '지원 ID';

  @override
  String get supportEmailLabel => '이메일 지원';

  @override
  String get captureTipFirst =>
      '맨 위부터 시작하세요. 매장 이름과 날짜가 보여야 합니다. 가능한 한 많은 품목을 담고, 나머지는 다음 사진에 담으세요.';

  @override
  String get captureTipContinue => '같은 영수증입니다. 이전 사진의 마지막 품목을 포함하세요.';

  @override
  String get captureTipNeverShow => '다시 표시하지 않음';

  @override
  String get captureTipOk => '확인';

  @override
  String get captureTipsSetting => '영수증 촬영 팁 표시';

  @override
  String get receiptReadingProgress => '영수증을 읽는 중…';

  @override
  String get receiptReadInBackground => '백그라운드에서 계속';

  @override
  String get receiptReadDoneTitle => '영수증을 읽었습니다';

  @override
  String get receiptReadDoneBody => '탭하여 확인하고 저장하세요.';

  @override
  String get receiptReadMoreTitle => '영수증의 나머지 부분을 촬영하세요';

  @override
  String get receiptReadFailedTitle => '영수증을 읽을 수 없습니다';

  @override
  String get listReceiptsSection => '영수증';

  @override
  String get receiptStateComplete => '완료';

  @override
  String get receiptStateIncomplete => '미완료';

  @override
  String get receiptStateFailed => '실패';

  @override
  String get receiptStoreUnknown => '매장을 읽지 못함';

  @override
  String get receiptDeleteAction => '영수증 삭제';

  @override
  String get receiptDeleteConfirm => '이 영수증과 추가된 항목을 삭제할까요? 나중에 다시 가져올 수 있습니다.';

  @override
  String get receiptDeleted => '영수증이 삭제되었습니다.';

  @override
  String listReceiptsShowAll(int count) {
    return '모두 보기($count)';
  }

  @override
  String get listReceiptsShowLess => '간단히 보기';

  @override
  String receiptDateLabel(String date) {
    return '영수증 날짜: $date';
  }

  @override
  String get historyViewShopping => '장보기별';

  @override
  String get historyViewStore => '매장별';

  @override
  String get historyViewProduct => '상품별';

  @override
  String get historyShareAll => '모두 공유';

  @override
  String get historyUnknownStore => '알 수 없는 매장';

  @override
  String get historyDailySpending => '일별 지출';

  @override
  String get historyResetPeriod => '이번 주로 돌아가기';

  @override
  String get tourSkip => '건너뛰기';

  @override
  String get tourNewListBody => '장보기 목록을 만들고 살 물건을 추가하세요.';

  @override
  String get tourFromReceiptBody => '이미 장을 보셨나요? 영수증을 가격이 포함된 목록으로 바꾸세요.';

  @override
  String get tourReceiptFlowBody =>
      '영수증 맨 위부터 시작하세요. 먼저 매장과 날짜를 찍고 나머지 줄을 이어서 찍으세요.';

  @override
  String get tourTabsBody => '진행 중, 완료, 보관된 목록 사이를 전환합니다. 끝의 버튼으로 정렬 순서를 바꿉니다.';

  @override
  String get tourDiscoverBody => '같은 개발자의 다른 앱을 살펴보세요.';

  @override
  String get tourHelpBody =>
      '여기를 탭하면 이 안내를 다시 볼 수 있습니다. 목록을 열면 합계와 품목 설명을 볼 수 있습니다.';

  @override
  String get tourTotalsBody => '계획, 실제 합계와 차액이 장을 보는 동안 업데이트됩니다.';

  @override
  String get tourItemsBody => '내 품목입니다. 여기에서 순서를 바꾸거나 검색하세요.';

  @override
  String budgetAlertNear(String percent) {
    return '$percent% of the limit used';
  }
}
