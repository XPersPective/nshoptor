// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => '在家规划，按计划购物。';

  @override
  String get listsTitle => '清单';

  @override
  String get listsTabActive => '进行中';

  @override
  String get listsTabCompleted => '已完成';

  @override
  String get listsTabArchived => '已归档';

  @override
  String get newListButton => '新建清单';

  @override
  String get listTitleHint => '标题（可选）';

  @override
  String get saveButton => '保存';

  @override
  String get cancelButton => '取消';

  @override
  String get deleteButton => '删除';

  @override
  String get editAction => '编辑';

  @override
  String get listDeleted => '清单已删除';

  @override
  String get invalidAmountError => '金额无效';

  @override
  String get duplicateAction => '复制';

  @override
  String get archiveAction => '归档';

  @override
  String get unarchiveAction => '取消归档';

  @override
  String get deleteListConfirm => '确定要删除此清单吗？其中的计划商品也将被移除。';

  @override
  String get undoButton => '撤销';

  @override
  String get searchListHint => '搜索清单';

  @override
  String get currencyLabel => '货币';

  @override
  String get budgetLabel => '预算（可选）';

  @override
  String get noteLabel => '备注（可选）';

  @override
  String get storeLabel => '商店';

  @override
  String get keepAmountsAction => '保留现有金额';

  @override
  String get resetAmountsAction => '重置金额';

  @override
  String get currencyChangeWarning => '货币正在更改。现有的金额该如何处理？';

  @override
  String get listsEmpty => '暂无清单。创建您的第一个购物计划吧。';

  @override
  String get statusDraft => '草稿';

  @override
  String get statusPlanned => '已计划';

  @override
  String get statusShopping => '购物中';

  @override
  String get statusCompleted => '已完成';

  @override
  String get statusArchived => '已归档';

  @override
  String autoListTitle(String date) {
    return '$date 购物';
  }

  @override
  String get itemFormTitle => '添加商品';

  @override
  String get itemNameLabel => '商品名称';

  @override
  String get brandLabel => '品牌/规格（可选）';

  @override
  String get categoryLabel => '分类';

  @override
  String get quantityLabel => '数量';

  @override
  String get unitLabel => '单位';

  @override
  String get pricingModeLabel => '价格录入方式';

  @override
  String get pricingModeUnitPrice => '单价';

  @override
  String get pricingModeLineTotal => '小计';

  @override
  String get plannedPriceLabel => '计划价格';

  @override
  String lineTotalCalculated(String value) {
    return '小计：$value';
  }

  @override
  String get requiredItemToggle => '必需商品';

  @override
  String get maxPriceLabel => '最高接受价格（可选）';

  @override
  String get itemNoteLabel => '备注（可选）';

  @override
  String get categoryProduce => '果蔬';

  @override
  String get categoryDairy => '乳制品';

  @override
  String get categoryMeat => '肉类';

  @override
  String get categoryBakery => '烘焙';

  @override
  String get categoryDrinks => '饮料';

  @override
  String get categoryCleaning => '清洁用品';

  @override
  String get categoryPersonalCare => '个人护理';

  @override
  String get categoryHome => '家居';

  @override
  String get categoryOther => '其他';

  @override
  String get invalidQuantityError => '数量无效';

  @override
  String get invalidPriceError => '价格无效';

  @override
  String get invalidNameError => '请输入名称';

  @override
  String unitPriceCalculated(String value) {
    return '单价：$value';
  }

  @override
  String get shoppingTitle => '购物模式';

  @override
  String get summaryPlannedTotal => '计划总额';

  @override
  String get summaryInCart => '已加入购物车';

  @override
  String get summaryRemainingPlan => '剩余计划';

  @override
  String get summaryProjected => '预计结账金额';

  @override
  String get summaryBudgetRemaining => '预算剩余';

  @override
  String get summaryBudgetOver => '超出预算';

  @override
  String itemsProgress(String done, String total) {
    return '$done/$total 件商品';
  }

  @override
  String get filterAll => '全部';

  @override
  String get filterToBuy => '待购';

  @override
  String get filterInCart => '已加购';

  @override
  String get filterNotFound => '未找到';

  @override
  String get filterRequired => '必买';

  @override
  String get quickEntryTitle => '实际价格';

  @override
  String get actualQuantityLabel => '实际数量';

  @override
  String get actualPriceLabel => '实际价格';

  @override
  String get discountLabel => '折扣（可选）';

  @override
  String get alternativeNameLabel => '替代商品名称（可选）';

  @override
  String get savePurchaseButton => '加入购物车';

  @override
  String get unplannedAddButton => '添加未计划商品';

  @override
  String get statusPending => '未购买';

  @override
  String get statusInCart => '已加购';

  @override
  String get statusNotFound => '未找到';

  @override
  String get statusGaveUp => '放弃';

  @override
  String get statusAlternative => '已买替代品';

  @override
  String get keepScreenAwake => '保持屏幕常亮';

  @override
  String get finishShopping => '结束购物';

  @override
  String get completionWarning => '存在缺失或未核实的记录。您仍可完成；结果将标注这些情况。';

  @override
  String get continueShoppingButton => '继续购物';

  @override
  String get resultTitle => '结果';

  @override
  String get summarySection => '汇总';

  @override
  String get plannedTotalLabel => '计划总额';

  @override
  String get actualTotalLabel => '实际总额';

  @override
  String get varianceLabel => '差额';

  @override
  String get varianceNotComputable => '无法计算';

  @override
  String get budgetStatusLabel => '预算状态';

  @override
  String get savingsLabel => '节省';

  @override
  String get overspendLabel => '超支';

  @override
  String get unplannedTotalLabel => '未计划支出';

  @override
  String get unpurchasedLabel => '计划但未购买';

  @override
  String get totalDiscountLabel => '总折扣';

  @override
  String get accuracyLabel => '预估准确度';

  @override
  String get groupsSection => '商品';

  @override
  String get groupPricier => '比计划贵';

  @override
  String get groupCheaper => '比计划便宜';

  @override
  String get groupClose => '接近预估价';

  @override
  String get groupNotTaken => '计划但未购买';

  @override
  String get groupUnplanned => '未计划但已购买';

  @override
  String get groupQuantityChanged => '数量变更';

  @override
  String get groupUnverified => '未核实';

  @override
  String get plannedQtyLabel => '计划数量';

  @override
  String get actualQtyLabel => '实际数量';

  @override
  String get plannedUnitPriceLabel => '计划单价';

  @override
  String get actualUnitPriceLabel => '实际单价';

  @override
  String get lineVarianceLabel => '行差额';

  @override
  String get discountEffectLabel => '折扣影响';

  @override
  String get notBoughtMark => '未购买';

  @override
  String get noPurchasesNote => '未记录任何购买。';

  @override
  String get navHome => '首页';

  @override
  String get navLists => '清单';

  @override
  String get navHistory => '历史';

  @override
  String get navSettings => '设置';

  @override
  String get homeEmptyTitle => '规划您的购物';

  @override
  String get homeEmptyBody => '创建您的第一份清单，并对比计划与实际花费。';

  @override
  String get homeActiveSection => '进行中清单';

  @override
  String get homeCompletedSection => '最近完成';

  @override
  String get homeMonthlySection => '本月';

  @override
  String get monthPlannedLabel => '计划';

  @override
  String get monthActualLabel => '实际';

  @override
  String get monthVarianceLabel => '差异';

  @override
  String get continueShoppingLabel => '继续购物';

  @override
  String get historyEmpty => '暂无已完成的购物记录。您的历史记录和洞察将在此显示。';

  @override
  String get aboutTabTitle => '关于 NShoptor';

  @override
  String get aboutBody =>
      'NShoptor by Crazy Penguin。优先离线使用的购物规划器。遵循 GPL-3.0 许可协议。';

  @override
  String get startShoppingLabel => '开始购物';

  @override
  String get finishAndSeeResult => '完成并查看结果';

  @override
  String get settingsTitle => '设置';

  @override
  String get languageLabel => '语言';

  @override
  String get languageSystem => '系统';

  @override
  String get languageTr => '土耳其语';

  @override
  String get languageEn => '英语';

  @override
  String get themeLabel => '主题';

  @override
  String get themeSystem => '系统';

  @override
  String get themeLight => '浅色';

  @override
  String get themeDark => '深色';

  @override
  String get defaultCurrencyLabel => '默认货币';

  @override
  String get defaultUnitLabel => '默认单位';

  @override
  String get keepAwakeLabel => '购物时保持屏幕常亮';

  @override
  String get backupSection => '备份';

  @override
  String get exportBackupLabel => '导出备份';

  @override
  String get importBackupLabel => '导入备份';

  @override
  String get mergeImportLabel => '合并到当前数据';

  @override
  String get separateImportLabel => '作为独立副本导入';

  @override
  String get importCancelled => '导入已取消。';

  @override
  String get backupExported => '备份已成功导出。';

  @override
  String get backupSizeWarning => '备份文件较大：文件可能很大。您是否要包含照片？';

  @override
  String get deleteAllSection => '危险区域';

  @override
  String get deleteAllLabel => '删除所有数据';

  @override
  String get deleteAllConfirm => '这将移除所有清单、历史记录、收据照片和价格。您导出的文件仍保留在您的驱动器中。继续吗？';

  @override
  String get deleteAllConfirm2 => '您确定吗？此操作无法撤销。';

  @override
  String get cancelAction => '取消';

  @override
  String get confirmDelete => '永久删除';

  @override
  String get dataDeleted => '所有本地数据已删除。';

  @override
  String get privacyInfoLabel => '隐私';

  @override
  String get privacyInfoBody =>
      '您的清单、价格、收据和照片均保存在您的设备上。照片和语音永远不会离开您的设备。当开启 AI 帮助时，仅发送文本（例如收据行或您口述的内容）到我们的服务器进行处理，且不会被存储。';

  @override
  String get aboutSection => '关于';

  @override
  String get aboutPublisher => '发布者：Crazy Penguin';

  @override
  String get aboutLicenses => '许可证 (GPL-3.0)';

  @override
  String get voiceSettingsLabel => '语音输入';

  @override
  String get voiceStatusUnknown => '服务：未检查';

  @override
  String get permissionsLabel => '权限';

  @override
  String get permissionsBody => '仅在您实际使用这些功能时，才会请求相机、麦克风和通知权限。';

  @override
  String get unitsSection => '默认值';

  @override
  String get roundingNote => '金钱舍入遵循一条规则：半值向远离零的方向舍入，仅在货币转换时应用一次。';

  @override
  String get voiceInputTitle => '语音输入';

  @override
  String get voiceStartListening => '开始监听';

  @override
  String get voiceTranscriptLabel => '转录内容';

  @override
  String get parseAction => '解析';

  @override
  String get receiptReviewTitle => '审查收据';

  @override
  String get receiptTotal => '收据总额';

  @override
  String get receiptTotalUnknown => '未检测到总额';

  @override
  String get receiptDiff => '差额';

  @override
  String get acceptLine => '接受该行';

  @override
  String get ignoreLine => '忽略该行';

  @override
  String get receiptLineActions => '关联商品、拆分或忽略';

  @override
  String get receiptCommit => '全部接受';

  @override
  String get receiptCommitted => '收据已应用。';

  @override
  String get priceHistoryTitle => '价格历史';

  @override
  String get noObservations => '暂无价格记录';

  @override
  String get templatesSection => '模板';

  @override
  String get templateHint => '基于上次购物创建新计划';

  @override
  String get scanReceiptAction => '扫描收据';

  @override
  String get shelfLabelAction => '货架标签价格';

  @override
  String get priceCandidatesTitle => '价格候选项';

  @override
  String get noPriceCandidates => '未找到价格；请手动输入。';

  @override
  String get voiceUnavailable => '语音识别不可用；请手动输入。';

  @override
  String get linkToItem => '关联到商品';

  @override
  String get splitLine => '拆分为两行';

  @override
  String get mergeWithNext => '与下一行合并';

  @override
  String get ocrNoText => '未读取到文本；请重试。';

  @override
  String get priceHistoryAction => '价格历史';

  @override
  String get itemsEmptyTitle => '暂无商品';

  @override
  String get itemsEmptyBody => '添加你的第一个商品——在商店里将在此处输入实际价格。';

  @override
  String get addItemTooltip => '添加商品';

  @override
  String get unitAdet => '个';

  @override
  String get unitKilogram => '千克';

  @override
  String get unitGram => '克';

  @override
  String get unitLitre => '升';

  @override
  String get unitMililitre => '毫升';

  @override
  String get unitPaket => '包';

  @override
  String get unitKutu => '盒';

  @override
  String get unitSise => '瓶';

  @override
  String get unitKavanoz => '罐';

  @override
  String get unitDemet => '把';

  @override
  String get unitDuzine => '打';

  @override
  String get unitMetre => '米';

  @override
  String get unitCustom => '自定义';

  @override
  String get setReminderAction => '设置提醒';

  @override
  String get reminderPermissionDenied => '需要通知权限才能设置提醒。你可以在系统设置中开启。';

  @override
  String get reminderScheduled => '提醒已设置。';

  @override
  String get reminderCancelled => '提醒已取消。';

  @override
  String get reminderTitle => '购物提醒';

  @override
  String reminderBody(Object title) {
    return '该查看清单了：$title';
  }

  @override
  String get reminderPickDate => '选择日期';

  @override
  String get reminderPickTime => '选择时间';

  @override
  String get itemDetailsSection => '详情';

  @override
  String get priceOptionalHint => '可选——在商店中输入实际价格';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return '预计：$total · $count 件商品';
  }

  @override
  String get proActiveLabel => 'Pro 已激活——谢谢！';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine => '无广告、更多 AI 功能、备份 · 每月仅需少量费用';

  @override
  String get proBenefitNoAds => '无广告体验';

  @override
  String get proBenefitBackup => '备份（导出/导入）';

  @override
  String aboutVersion(Object version) {
    return '版本 $version';
  }

  @override
  String get navDiscover => '发现';

  @override
  String get shareAction => '分享应用';

  @override
  String get rateAction => '给我们评分';

  @override
  String get aboutOpenRow => '关于 & 开源';

  @override
  String get voiceAddItemAction => '语音添加商品';

  @override
  String get formatLocaleLabel => '数字与货币格式';

  @override
  String get formatLocaleSystem => '设备格式（拉丁数字；否则为英文）';

  @override
  String get formatLocaleTr => '土耳其语 (1.234,56)';

  @override
  String get formatLocaleEn => '英语 (1,234.56)';

  @override
  String get aiToggleTitle => 'AI 帮助';

  @override
  String get aiToggleSubtitle => '匹配收据、读取价格标签并将句子转为列表。照片和语音保留在您的设备上；仅处理文本。';

  @override
  String aiQuotaReached(int used, int limit) {
    return '您本月已用完 AI 请求额度 ($used/$limit)。升级以获取更多，或继续使用无 AI 功能。';
  }

  @override
  String get aiOffline => '无网络连接 — 正在不使用 AI 的情况下继续。';

  @override
  String get aiFailed => 'AI 暂时不可用 — 正在不使用 AI 的情况下继续。';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => '设备';

  @override
  String get quickListAction => '从句子添加';

  @override
  String get quickListTitle => '快速列表';

  @override
  String get quickListHint => '例如：1 kg 苹果 20，2 条面包，半公斤奶酪';

  @override
  String get quickListConvert => '转为列表';

  @override
  String quickListAdd(int count) {
    return '添加 $count 项';
  }

  @override
  String get quickListEmpty => '未找到任何项目。请尝试用逗号分隔列出它们。';

  @override
  String get receiptAiMatched => 'AI 已将收据与您的列表匹配。请检查链接并确认。';

  @override
  String get receiptNeedsCheck => '检查此匹配结果';

  @override
  String get receiptDiscountLine => '折扣';

  @override
  String get compareItem => '商品';

  @override
  String get compareEstimated => '预估';

  @override
  String get compareActual => '实际';

  @override
  String get compareDiff => '差额';

  @override
  String get compareTotal => '总计';

  @override
  String get compareBudget => '预算';

  @override
  String get compareNotBought => '未购买';

  @override
  String get compareUnplanned => '未计划';

  @override
  String get pricierItems => '花费更多';

  @override
  String get cheaperItems => '花费更少';

  @override
  String get compareAction => '对比';

  @override
  String get detailsSection => '详情';

  @override
  String get spendingTitle => '支出';

  @override
  String get spendingAction => '支出';

  @override
  String get spendingMonthTotal => '本月';

  @override
  String get spendingWeekly => '每周支出';

  @override
  String get spendingMonthly => '每月支出';

  @override
  String get monthlyLimitTitle => '月度限额';

  @override
  String get monthlyLimitHelp => '您希望每月在购物上花费多少？';

  @override
  String get monthlyLimitRemove => '移除';

  @override
  String get monthlyLimitSet => '设置';

  @override
  String get monthlyLimitChange => '更改';

  @override
  String get monthlyLimitNone => '设置月度限额以查看剩余金额。';

  @override
  String monthlyLimitOver(String amount) {
    return '超出限额 $amount';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return '本月剩余 $amount';
  }

  @override
  String get plansTitle => '方案';

  @override
  String get plansHeadline => '用 AI 更聪明地购物';

  @override
  String get plansSubhead => '收据匹配、价格标签识别及从句子生成列表。随时取消。';

  @override
  String get plansMonthly => '月付';

  @override
  String get plansYearly => '年付';

  @override
  String get planFree => '免费';

  @override
  String get planFreePrice => '永久免费';

  @override
  String get planFreeAi => '每月 15 次 AI 请求';

  @override
  String get planFreeAds => '少量横幅广告（前 7 天无广告）';

  @override
  String get planCoreFeatures => '列表、价格、收据、支出图表';

  @override
  String get plansPerYear => '/ 年';

  @override
  String get plansPerMonth => '/ 月';

  @override
  String get planTrial => '7 天免费试用';

  @override
  String get planProAi => '每月 200 次 AI 请求';

  @override
  String get planNoAds => '无广告';

  @override
  String get planBackup => '备份导出与导入';

  @override
  String get planMaxAi => '每月 1000 次 AI 请求';

  @override
  String get planMaxFamily => '适合大家庭购物';

  @override
  String get plansStoreUnavailable => '商店当前无法访问。';

  @override
  String get retryAction => '重试';

  @override
  String get plansPurchaseFailed => '购买未成功，请再试一次。';

  @override
  String get planLifetimeTitle => '终身免广告';

  @override
  String get planLifetimeSubtitle => '一次性付费：无广告、支持备份；AI 使用仍受免费额度限制';

  @override
  String get plansRestore => '恢复购买';

  @override
  String get plansLegal =>
      '订阅将自动续订，直到取消为止。可随时在 Google Play › 付款与订阅中取消。价格包含 Google Play 显示的各项税费。';

  @override
  String get planCurrent => '当前';

  @override
  String get planStartTrial => '开始 7 天免费试用';

  @override
  String get planChoose => '选择';

  @override
  String get plansAction => '计划：Pro 和 Max';

  @override
  String get assistantTitle => '助手';

  @override
  String get assistantGreeting => '你好！你想做什么？';

  @override
  String get assistantNewList => '新建清单';

  @override
  String get assistantVoiceList => '语音录入清单';

  @override
  String get assistantTextList => '从句子生成清单';

  @override
  String get assistantScanReceipt => '扫描小票';

  @override
  String get assistantSpending => '我的支出';

  @override
  String get assistantReceiptHint => '打开你的清单，点击小票图标进行扫描。';

  @override
  String get assistantToggleTitle => '显示助手';

  @override
  String get assistantToggleSubtitle => '右下角的小帮手';

  @override
  String get scanPriceLabel => '扫描价格标签';

  @override
  String get saveFailed => '保存失败。您的更改仍在，请重试。';

  @override
  String get deleteItemConfirm => '删除此项及其已记录的消费？';

  @override
  String get clearPurchaseConfirm => '取消勾选此项并移除其已记录的消费？';

  @override
  String get reportPdfAction => '保存 PDF 报告';

  @override
  String get reportNotInvoice => '购物汇总，非税务发票。税率未知。';

  @override
  String get purchaseVisits => '购物次数';

  @override
  String get purchaseInterval => '平均购买间隔天数';

  @override
  String get purchasedQuantity => '购买数量';

  @override
  String get purchaseAnalyticsHint => '消费数据不反映实际消耗量。货币和单位将分别显示。';

  @override
  String get receiptReplaces => '关联的收据行将替换现有消费记录；未关联的行将被添加。';

  @override
  String get voiceUnsupportedLanguage => '此设备不支持该语言的语音输入。您可以改为手动输入。';

  @override
  String get voiceStopListening => '停止聆听';

  @override
  String get keepAwakeFailed => '无法保持屏幕常亮，请重试。';
}
