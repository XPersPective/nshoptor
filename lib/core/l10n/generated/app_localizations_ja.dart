// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => '家で作戦、店では計画通り。';

  @override
  String get listsTitle => 'リスト';

  @override
  String get listsTabActive => 'アクティブ';

  @override
  String get listsTabCompleted => '完了';

  @override
  String get listsTabArchived => 'アーカイブ';

  @override
  String get newListButton => '新しいリスト';

  @override
  String get listTitleHint => 'タイトル（任意）';

  @override
  String get saveButton => '保存';

  @override
  String get cancelButton => 'キャンセル';

  @override
  String get deleteButton => '削除';

  @override
  String get editAction => '編集';

  @override
  String get listDeleted => 'リストが削除されました';

  @override
  String get invalidAmountError => '数量が無効です';

  @override
  String get duplicateAction => '複製';

  @override
  String get archiveAction => 'アーカイブ';

  @override
  String get unarchiveAction => 'アーカイブ解除';

  @override
  String get deleteListConfirm => 'このリストを削除しますか？予定されていたアイテムもすべて削除されます。';

  @override
  String get undoButton => '元に戻す';

  @override
  String get searchListHint => 'リストを検索';

  @override
  String get currencyLabel => '通貨';

  @override
  String get budgetLabel => '予算（任意）';

  @override
  String get noteLabel => 'メモ（任意）';

  @override
  String get storeLabel => '店舗';

  @override
  String get keepAmountsAction => '数量を維持';

  @override
  String get resetAmountsAction => '数量をリセット';

  @override
  String get currencyChangeWarning => '通貨を変更します。既存の数量はどうしますか？';

  @override
  String get listsEmpty => 'リストがありません。最初の買い物プランを作成しましょう。';

  @override
  String get statusDraft => '下書き';

  @override
  String get statusPlanned => '計画済み';

  @override
  String get statusShopping => '購入中';

  @override
  String get statusCompleted => '完了';

  @override
  String get statusArchived => 'アーカイブ済み';

  @override
  String autoListTitle(String date) {
    return '$dateの買い物';
  }

  @override
  String get itemFormTitle => 'アイテムを追加';

  @override
  String get itemNameLabel => '商品名';

  @override
  String get brandLabel => 'ブランド／バリエーション（任意）';

  @override
  String get categoryLabel => 'カテゴリ';

  @override
  String get quantityLabel => '数量';

  @override
  String get unitLabel => '単位';

  @override
  String get pricingModeLabel => '価格入力モード';

  @override
  String get pricingModeUnitPrice => '単価';

  @override
  String get pricingModeLineTotal => '行合計';

  @override
  String get plannedPriceLabel => '予定価格';

  @override
  String lineTotalCalculated(String value) {
    return '行合計: $value';
  }

  @override
  String get requiredItemToggle => '必須アイテム';

  @override
  String get maxPriceLabel => '許容最大価格（任意）';

  @override
  String get itemNoteLabel => 'メモ（任意）';

  @override
  String get categoryProduce => '果物・野菜';

  @override
  String get categoryDairy => '乳製品';

  @override
  String get categoryMeat => '肉類';

  @override
  String get categoryBakery => 'パン・ベーカリー';

  @override
  String get categoryDrinks => '飲料';

  @override
  String get categoryCleaning => '清掃用品';

  @override
  String get categoryPersonalCare => 'パーソナルケア';

  @override
  String get categoryHome => 'ホーム用品';

  @override
  String get categoryOther => 'その他';

  @override
  String get invalidQuantityError => '数量が無効です';

  @override
  String get invalidPriceError => '価格が無効です';

  @override
  String get invalidNameError => '名前を入力してください';

  @override
  String unitPriceCalculated(String value) {
    return '単価: $value';
  }

  @override
  String get shoppingTitle => 'ショッピングモード';

  @override
  String get summaryPlannedTotal => '予定合計';

  @override
  String get summaryInCart => 'カート内';

  @override
  String get summaryRemainingPlan => '残り計画';

  @override
  String get summaryProjected => '予想チェックアウト';

  @override
  String get summaryBudgetRemaining => '予算残額';

  @override
  String get summaryBudgetOver => '予算超過';

  @override
  String itemsProgress(String done, String total) {
    return '$total個中$done個完了';
  }

  @override
  String get filterAll => 'すべて';

  @override
  String get filterToBuy => '購入予定';

  @override
  String get filterInCart => 'カート内';

  @override
  String get filterNotFound => '未発見';

  @override
  String get filterRequired => '必須';

  @override
  String get quickEntryTitle => '実際の価格';

  @override
  String get actualQuantityLabel => '実際の数量';

  @override
  String get actualPriceLabel => '実際の価格';

  @override
  String get discountLabel => '割引（任意）';

  @override
  String get alternativeNameLabel => '代替商品名（任意）';

  @override
  String get savePurchaseButton => 'カートに追加';

  @override
  String get unplannedAddButton => '予定外のアイテムを追加';

  @override
  String get statusPending => '未所持';

  @override
  String get statusInCart => 'カート内';

  @override
  String get statusNotFound => '未発見';

  @override
  String get statusGaveUp => '購入中止';

  @override
  String get statusAlternative => '代替品を購入';

  @override
  String get keepScreenAwake => '画面を点灯したままにする';

  @override
  String get finishShopping => '買い物を終了';

  @override
  String get completionWarning => '未記入または未確認のレコードがあります。続行できますが、結果にそれらが記載されます。';

  @override
  String get continueShoppingButton => '買い物を続ける';

  @override
  String get resultTitle => '結果';

  @override
  String get summarySection => '概要';

  @override
  String get plannedTotalLabel => '予定合計';

  @override
  String get actualTotalLabel => '実際合計';

  @override
  String get varianceLabel => '差額';

  @override
  String get varianceNotComputable => '計算不可';

  @override
  String get budgetStatusLabel => '予算';

  @override
  String get savingsLabel => '予算内';

  @override
  String get overspendLabel => '予算超過';

  @override
  String get unplannedTotalLabel => '予定外合計';

  @override
  String get unpurchasedLabel => '計画あり但未購入';

  @override
  String get totalDiscountLabel => '合計割引額';

  @override
  String get accuracyLabel => '見積精度';

  @override
  String get groupsSection => 'アイテム';

  @override
  String get groupPricier => '予定より高い';

  @override
  String get groupCheaper => '予定より安い';

  @override
  String get groupClose => '見積に近い';

  @override
  String get groupNotTaken => '計画あり但未購入';

  @override
  String get groupUnplanned => '計画なしで購入';

  @override
  String get groupQuantityChanged => '数量変更';

  @override
  String get groupUnverified => '未確認';

  @override
  String get plannedQtyLabel => '計画数量';

  @override
  String get actualQtyLabel => '実際数量';

  @override
  String get plannedUnitPriceLabel => '計画単価';

  @override
  String get actualUnitPriceLabel => '実際単価';

  @override
  String get lineVarianceLabel => '行差額';

  @override
  String get discountEffectLabel => '割引効果';

  @override
  String get notBoughtMark => '未購入';

  @override
  String get noPurchasesNote => '購入記録はありません。';

  @override
  String get navHome => 'ホーム';

  @override
  String get navLists => 'リスト';

  @override
  String get navHistory => '履歴';

  @override
  String get navSettings => '設定';

  @override
  String get homeEmptyTitle => '買い物プランを立てよう';

  @override
  String get homeEmptyBody => '最初のリストを作成して、予定額と実際のかかった金額を比較しましょう。';

  @override
  String get homeActiveSection => '進行中のリスト';

  @override
  String get homeCompletedSection => '最近完了したリスト';

  @override
  String get homeMonthlySection => '今月';

  @override
  String get monthPlannedLabel => '予定';

  @override
  String get monthActualLabel => '実際';

  @override
  String get monthVarianceLabel => '差額';

  @override
  String get continueShoppingLabel => '買い物を続ける';

  @override
  String get historyEmpty => '完了した買い物はまだありません。履歴や分析結果はここに表示されます。';

  @override
  String get aboutTabTitle => 'NShoptorについて';

  @override
  String get aboutBody =>
      'Crazy Penguin制作のNShoptor。オフライン対応のショッピングプランナー。GPL-3.0ライセンス。';

  @override
  String get startShoppingLabel => '買い物を始める';

  @override
  String get finishAndSeeResult => '完了して結果を見る';

  @override
  String get settingsTitle => '設定';

  @override
  String get languageLabel => '言語';

  @override
  String get languageSystem => 'システム設定に合わせる';

  @override
  String get languageTr => 'トルコ語';

  @override
  String get languageEn => '英語';

  @override
  String get themeLabel => 'テーマ';

  @override
  String get themeSystem => 'システム設定に合わせる';

  @override
  String get themeLight => 'ライト';

  @override
  String get themeDark => 'ダーク';

  @override
  String get defaultCurrencyLabel => 'デフォルト通貨';

  @override
  String get defaultUnitLabel => 'デフォルト単位';

  @override
  String get keepAwakeLabel => '買い物の間、画面を点けっぱなしにする';

  @override
  String get backupSection => 'バックアップ';

  @override
  String get exportBackupLabel => 'バックアップをエクスポート';

  @override
  String get importBackupLabel => 'バックアップをインポート';

  @override
  String get mergeImportLabel => '現在のデータに統合してインポート';

  @override
  String get separateImportLabel => '別のコピーとしてインポート';

  @override
  String get importCancelled => 'インポートがキャンセルされました。';

  @override
  String get backupExported => 'バックアップのエクスポートに成功しました。';

  @override
  String get deleteAllSection => '危険ゾーン';

  @override
  String get deleteAllLabel => 'すべてのデータを削除';

  @override
  String get deleteAllConfirm =>
      'すべてのリスト、履歴、レシート写真、価格情報が削除されます。あなたがエクスポートしたファイルはデバイスに残ります。続行しますか？';

  @override
  String get deleteAllConfirm2 => '本当に削除してもよろしいですか？この操作は元に戻せません。';

  @override
  String get cancelAction => 'キャンセル';

  @override
  String get confirmDelete => '完全に削除する';

  @override
  String get dataDeleted => 'ローカルのデータがすべて削除されました。';

  @override
  String get privacyInfoLabel => 'プライバシー';

  @override
  String get privacyInfoBody =>
      'リスト、価格、レシート、写真はデバイスに保存されます。音声がデバイスの外に出ることはありません。AIヘルプがオンの場合、レシートや値札の写真（サイズを縮小したもの）と、音声入力した品目などのテキストは、読み取りのためだけにサーバーへ送信されます。送信されたデータはすぐに処理され、保存されることはありません。';

  @override
  String get aboutSection => 'アプリ情報';

  @override
  String get aboutPublisher => '開発者: Crazy Penguin';

  @override
  String get aboutLicenses => 'ライセンス (GPL-3.0)';

  @override
  String get voiceSettingsLabel => '音声入力';

  @override
  String get voiceStatusUnknown => 'サービス: 未確認';

  @override
  String get permissionsLabel => '権限';

  @override
  String get permissionsBody => 'カメラ、マイク、通知のアクセス許可は、実際にそれらの機能を使用した場合にのみ求められます。';

  @override
  String get unitsSection => 'デフォルト値';

  @override
  String get roundingNote =>
      '金額の端数処理は1つのルールに従います：0.5はゼロから遠ざかる方向に丸められ、Money変換時に1回適用されます。';

  @override
  String get voiceInputTitle => '音声入力';

  @override
  String get voiceStartListening => '録音を開始';

  @override
  String get voiceTranscriptLabel => '文字起こし';

  @override
  String get parseAction => '解析';

  @override
  String get receiptReviewTitle => 'レシートの確認';

  @override
  String get receiptTotal => 'レシートの合計';

  @override
  String get receiptTotalUnknown => '合計が検出されません';

  @override
  String get receiptDiff => '差額';

  @override
  String get acceptLine => 'この行を承認';

  @override
  String get ignoreLine => 'この行を無視';

  @override
  String get receiptLineActions => 'アイテムにリンク、分割、または無視';

  @override
  String get receiptCommit => 'すべて承認';

  @override
  String get receiptCommitted => 'レシートが適用されました。';

  @override
  String get priceHistoryTitle => '価格履歴';

  @override
  String get noObservations => '価格の記録はまだありません';

  @override
  String get templatesSection => 'テンプレート';

  @override
  String get templateHint => '前回の買い物から新しいプランを作成';

  @override
  String get scanReceiptAction => 'レシートをスキャン';

  @override
  String get fromReceiptListButton => 'レシートから';

  @override
  String get shelfLabelAction => '棚札の価格を入力';

  @override
  String get priceCandidatesTitle => '価格候補';

  @override
  String get noPriceCandidates => '価格が見つかりません。手動で入力してください。';

  @override
  String get voiceUnavailable => '音声認識が無効です。手動で入力してください。';

  @override
  String get linkToItem => 'アイテムにリンク';

  @override
  String get splitLine => '2つに分割';

  @override
  String get mergeWithNext => '次の行と結合';

  @override
  String get ocrNoText => 'テキストが読み取れません。もう一度お試しください。';

  @override
  String get priceHistoryAction => '価格履歴';

  @override
  String get itemsEmptyTitle => 'まだアイテムがありません';

  @override
  String get itemsEmptyBody => '最初のアイテムを追加しましょう — 店舗で実際の価格を入力します。';

  @override
  String get addItemTooltip => 'アイテムを追加';

  @override
  String get unitAdet => '個';

  @override
  String get unitKilogram => 'kg';

  @override
  String get unitGram => 'g';

  @override
  String get unitLitre => 'L';

  @override
  String get unitMililitre => 'ml';

  @override
  String get unitPaket => 'パック';

  @override
  String get unitKutu => '箱';

  @override
  String get unitSise => 'ボトル';

  @override
  String get unitKavanoz => '瓶';

  @override
  String get unitDemet => '束';

  @override
  String get unitDuzine => 'ダース';

  @override
  String get unitMetre => 'm';

  @override
  String get unitCustom => 'カスタム';

  @override
  String get setReminderAction => 'リマインダーを設定';

  @override
  String get reminderPermissionDenied => 'リマインダーには通知許可が必要です。システム設定で有効にできます。';

  @override
  String get reminderScheduled => 'リマインダーが設定されました。';

  @override
  String get reminderCancelled => 'リマインダーが削除されました。';

  @override
  String get reminderTitle => 'ショッピングリマインダー';

  @override
  String reminderBody(Object title) {
    return 'リストを確認する時間です: $title';
  }

  @override
  String get reminderPickDate => '日付を選択';

  @override
  String get reminderPickTime => '時刻を選択';

  @override
  String get itemDetailsSection => '詳細';

  @override
  String get priceOptionalHint => 'オプション — 店舗で実際の価格を入力します';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return '予定: $total · $count個のアイテム';
  }

  @override
  String get proActiveLabel => 'Pro 有効中 — ありがとうございました！';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine => '広告なし · バックアップのエクスポートとインポート · 年額';

  @override
  String get proBenefitNoAds => '広告なし体験';

  @override
  String get proBenefitBackup => 'バックアップ（エクスポート/インポート）';

  @override
  String aboutVersion(Object version) {
    return 'バージョン $version';
  }

  @override
  String get navDiscover => '発見';

  @override
  String get shareAction => 'アプリを共有';

  @override
  String get rateAction => '評価する';

  @override
  String get aboutOpenRow => '概要 & オープンソース';

  @override
  String get voiceAddItemAction => '音声で追加';

  @override
  String get formatLocaleLabel => '数字と通貨の形式';

  @override
  String get formatLocaleSystem => 'デバイスの形式（ラテン数字の場合、それ以外は英語）';

  @override
  String get formatLocaleTr => 'トルコ語 (1.234,56)';

  @override
  String get formatLocaleEn => '英語 (1,234.56)';

  @override
  String get aiToggleTitle => 'AIヘルプ';

  @override
  String get aiToggleSubtitle =>
      '写真からレシートや値札を読み取り、レシートを照合し、文章をリストに変換します。写真は読み取りのためだけに送信され、保存されることはありません。';

  @override
  String aiQuotaReached(int used, int limit) {
    return '今月のAIリクエスト枠 ($used/$limit) を使い切りました。アップグレードして枠を増やすか、AIなしで続行してください。';
  }

  @override
  String get aiOffline => '接続できません — AIなしで続行しています。';

  @override
  String get aiFailed => '現在AIを利用できません — AIなしで続行しています。';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'デバイス';

  @override
  String get quickListAction => '文章から追加';

  @override
  String get quickListTitle => 'クイックリスト';

  @override
  String get quickListHint => '例: りんご1kg 20円、パン2個、チーズ半キロ';

  @override
  String get quickListConvert => 'リストに変換';

  @override
  String quickListAdd(int count) {
    return '$count個を追加';
  }

  @override
  String get quickListEmpty => 'アイテムが見つかりませんでした。カンマ区切りで入力してみてください。';

  @override
  String get receiptAiMatched => 'AIがレシートをリストにマッチさせました。リンクを確認して確定してください。';

  @override
  String get receiptNeedsCheck => 'このマッチを確認する';

  @override
  String get receiptDiscountLine => '割引';

  @override
  String get compareItem => '商品';

  @override
  String get compareEstimated => '予想額';

  @override
  String get compareActual => '実際額';

  @override
  String get compareDiff => '差額';

  @override
  String get compareTotal => '合計';

  @override
  String get compareBudget => '予算';

  @override
  String get compareNotBought => '未購入';

  @override
  String get compareUnplanned => '未計画';

  @override
  String get pricierItems => '高くなったもの';

  @override
  String get cheaperItems => '安くなったもの';

  @override
  String get compareAction => '比較';

  @override
  String get detailsSection => '詳細';

  @override
  String get spendingTitle => '支出';

  @override
  String get spendingAction => '支出';

  @override
  String get spendingMonthTotal => '今月';

  @override
  String get spendingWeekly => '週別支出';

  @override
  String get spendingMonthly => '月別支出';

  @override
  String get monthlyLimitTitle => '月間上限';

  @override
  String get monthlyLimitHelp => '月にどのくらい買い物に費やしたいですか？';

  @override
  String get monthlyLimitRemove => '削除';

  @override
  String get monthlyLimitSet => '設定';

  @override
  String get monthlyLimitChange => '変更';

  @override
  String get monthlyLimitNone => '残額を確認するには月間上限を設定してください。';

  @override
  String monthlyLimitOver(String amount) {
    return '上限を$amount超えています';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return '今月は$amount残っています';
  }

  @override
  String get plansTitle => 'プラン';

  @override
  String get plansHeadline => 'AIで賢くお買い物';

  @override
  String get plansSubhead => 'レシートのマッチング、価格ラベルの読み取り、文章からのリスト作成。いつでも解約できます。';

  @override
  String get plansMonthly => '月額';

  @override
  String get plansYearly => '年額';

  @override
  String get planFree => '無料';

  @override
  String get planFreePrice => '永久無料';

  @override
  String get planFreeAi => '月10回のAIリクエスト';

  @override
  String get planFreeAds => 'バナー広告あり（最初の7日間はなし）';

  @override
  String get planCoreFeatures => 'リスト、価格、レシート、支出グラフ';

  @override
  String get plansPerYear => '/ 年';

  @override
  String get plansPerMonth => '/ 月';

  @override
  String get planTrial => '無料体験';

  @override
  String get planProAi => '月100回のAIリクエスト';

  @override
  String get planNoAds => '広告なし';

  @override
  String get planBackup => 'バックアップのエクスポートとインポート';

  @override
  String get planMaxAi => '月間AIリクエスト300回';

  @override
  String get planMaxFamily => '大家族の買い物に最適';

  @override
  String get plansStoreUnavailable => '現在、ストアに接続できません。';

  @override
  String get retryAction => '再試行';

  @override
  String get plansPurchaseFailed => '購入が完了しませんでした。もう一度お試しください。';

  @override
  String get plansRestore => '購入を復元';

  @override
  String get plansLegal =>
      'Proは解約するまで毎年自動更新され、AIリクエストを毎月100回利用できます。基本価格は適用される税金を含まず年額1米ドルです。購入を確定する前に、ストアで現地の最終価格と税金をご確認ください。定期購入の管理や解約はGoogle Playで行えます。';

  @override
  String get planCurrent => '現在';

  @override
  String get planStartTrial => '無料体験を開始';

  @override
  String get planChoose => '選択';

  @override
  String get plansAction => 'プラン: Pro';

  @override
  String get assistantTitle => 'アシスタント';

  @override
  String get assistantGreeting => 'こんにちは！何を行いますか？';

  @override
  String get assistantNewList => '新しいリスト';

  @override
  String get assistantVoiceList => '音声でリスト作成';

  @override
  String get assistantTextList => '文章からリスト作成';

  @override
  String get assistantScanReceipt => 'レシートをスキャン';

  @override
  String get assistantSpending => '私の支出';

  @override
  String get assistantReceiptHint => 'リストを開き、レシートアイコンをタップしてスキャンしてください。';

  @override
  String get assistantToggleTitle => 'アシスタントを表示';

  @override
  String get assistantToggleSubtitle => '右下の小さなヘルパー';

  @override
  String get scanPriceLabel => '価格ラベルをスキャン';

  @override
  String get saveFailed => '保存できませんでした。変更内容は保持されています。もう一度お試しください。';

  @override
  String get deleteItemConfirm => 'この商品と記録された購入履歴を削除しますか？';

  @override
  String get clearPurchaseConfirm => 'この商品のチェックを外し、記録された購入履歴を削除しますか？';

  @override
  String get reportPdfAction => 'PDFレポートを保存';

  @override
  String get reportNotInvoice => 'ショッピングのまとめであり、税務請求書ではありません。税率は不明です。';

  @override
  String get purchaseVisits => '買い物回数';

  @override
  String get purchaseInterval => '平均的な購入間隔（日）';

  @override
  String get purchasedQuantity => '購入数量';

  @override
  String get purchaseAnalyticsHint => '購入データは消費量を直接示すものではありません。通貨と単位は別に表示されます。';

  @override
  String get receiptReplaces => '価格のない商品は補完されます。市場価格がある商品は別の購入として追加されます。';

  @override
  String get receiptIncompleteHeader => '次の写真に店名、日付、時刻、レシート番号を含めてください。';

  @override
  String get receiptIncompleteTail => '次の部分を、数点の商品が重なるようにして最終合計額と一緒に撮影してください。';

  @override
  String get receiptContinuationRejected =>
      'この写真を結合できませんでした。同じレシートの商品が重なるように撮り直してください。';

  @override
  String get receiptDraftSaved => 'レシートを下書きとして保存しました。後で続けられます。';

  @override
  String get receiptContinueAction => 'レシートを続ける';

  @override
  String get receiptDraftsTitle => '未完了のレシート';

  @override
  String get receiptDuplicate => 'このレシートはすでに追加されています。';

  @override
  String get receiptTotalMismatch =>
      '商品合計がレシートの合計と一致しません。レシート全体が写っているか確認してください。';

  @override
  String get receiptSaveDraftAction => '後で保存';

  @override
  String get receiptResolveLines => '保存する前に、各商品を承認するか無視してください。';

  @override
  String get receiptPartialConfirm =>
      '選択した商品だけが追加されます。このレシートはインポート済みとして記録されます。続行しますか？';

  @override
  String get voiceUnsupportedLanguage =>
      'このデバイスでは、この言語での音声入力はサポートされていません。代わりにテキスト入力してください。';

  @override
  String get voiceStopListening => '録音を停止';

  @override
  String get keepAwakeFailed => '画面を点灯したままにできませんでした。もう一度お試しください。';

  @override
  String get purchaseHistoryHint =>
      'すべての完了したショッピング履歴。返品は合計額を減らします。日付はショッピングの完了日を指します。1回の訪問では平均間隔を計算するには不十分です。';

  @override
  String get planLegacyRights => '既存のProおよびMaxサブスクリプションは、従来の月間AI利用枠を維持します。';

  @override
  String get csvExportAction => 'CSVをエクスポート';

  @override
  String get reportSharePdf => 'PDFで共有';

  @override
  String get reportShareCsv => 'CSVで共有';

  @override
  String get reportPrintAction => '印刷';

  @override
  String get backupSizeWarning =>
      'JSONにはレコードが含まれており、写真ファイルは含まれていません。インポート制限：16 MB。';

  @override
  String get backupImportFailed => 'このバックアップはインポートできませんでした。データは変更されていません。';

  @override
  String get backupImported => 'バックアップが正常にインポートされました。';

  @override
  String backupPreviewCounts(Object entries, Object items, Object lists) {
    return '$lists件のリスト · $items個のアイテム · $entries件の購入';
  }

  @override
  String get voiceModelDownloading =>
      'この言語の音声モデルをダウンロードしています。1 分後にもう一度お試しください。';

  @override
  String get historyThisWeek => '今週';

  @override
  String get historyProductsSection => '購入した商品';

  @override
  String get tipReceiptScan => 'レシートを読み取って、価格をリストと照合';

  @override
  String get tipVoiceAdd => '商品を一つ以上話し、追加する前に確認';

  @override
  String get tipShelfCamera => 'カメラで棚札の価格を読み取る';

  @override
  String get tipPlan => 'あなたのプラン：詳細を見る、購読、アップグレード';

  @override
  String get guideAddBody => '+ を押して商品を追加。予定価格は今、店頭価格はレジで入力します。';

  @override
  String get guideVoiceBody => 'マイクを押して商品を話してください。例：「りんご1kg、パン1つ」';

  @override
  String get guideReceiptBody => 'レシートを読み取り、価格をリストの商品と照合します。';

  @override
  String get guidePlanBody => 'プランアイコンを押して、プランの確認、購読、アップグレードができます。';

  @override
  String get guideNext => 'OK';

  @override
  String get guideDone => '始める';

  @override
  String get paletteLabel => 'カラーテーマ';

  @override
  String get paletteForest => 'フォレスト';

  @override
  String get paletteOcean => 'オーシャン';

  @override
  String get paletteSunset => 'サンセット';

  @override
  String get paletteLavender => 'ラベンダー';

  @override
  String get darkBlackLabel => 'ダークテーマで完全な黒';

  @override
  String get spendingOverview => '概要';

  @override
  String get spendingThisYear => '今年';

  @override
  String get spendingYearly => '年間支出';

  @override
  String get productSpending => '商品別の支出';

  @override
  String get spanWeek => '週';

  @override
  String get spanMonth => '月';

  @override
  String get spanYear => '年';

  @override
  String get weeklyLimitTitle => '週の上限';

  @override
  String get weeklyLimitHelp => '1週間に買い物にいくら使いますか？';

  @override
  String get weeklyLimitNone => '週の上限を設定すると残額が分かります。';

  @override
  String weeklyLimitLeft(String amount) {
    return '今週の残り $amount';
  }

  @override
  String get shoppingLimitTitle => '1回の買い物の上限';

  @override
  String get shoppingLimitHelp => '新しいリストはこの予算で始まります。';

  @override
  String get shoppingLimitNone => '新しい買い物ごとの既定の予算を設定します。';

  @override
  String get monthlyReportAction => '月次レポート';

  @override
  String get reportShoppingColumn => '買い物';

  @override
  String get reportDateColumn => '日付';

  @override
  String get planUnavailable => '現在ストアで利用できません';

  @override
  String get demoDataTitle => 'サンプルデータ';

  @override
  String get demoDataLoad => 'サンプルデータで試す';

  @override
  String get demoDataLoadHelp => '履歴・グラフ・価格履歴を確認できるよう、12か月分のサンプル買い物を追加します。';

  @override
  String get demoDataRemove => 'サンプルデータを削除';

  @override
  String get demoDataAdded => 'サンプルデータを追加しました';

  @override
  String get demoDataRemoved => 'サンプルデータを削除しました';

  @override
  String get demoProductApple => 'りんご';

  @override
  String get demoProductBread => 'パン';

  @override
  String get demoProductMilk => '牛乳';

  @override
  String get demoProductCheese => 'チーズ';

  @override
  String get demoProductTomato => 'トマト';

  @override
  String get demoProductEggs => '卵';

  @override
  String get demoProductCoffee => 'コーヒー';

  @override
  String get demoProductDetergent => '洗剤';

  @override
  String get sendAction => 'Send';

  @override
  String get previousMonthAction => 'Previous month';

  @override
  String get nextMonthAction => 'Next month';

  @override
  String get helpSection => 'ヘルプとサポート';

  @override
  String get howToUseLabel => '使い方';

  @override
  String get guidePricesBody =>
      '店頭価格を入力すると購入済みになります。0も有効です。自宅での予定価格は任意です。店頭価格を消すとチェックが外れます。';

  @override
  String get shoppingDateLabel => '買い物の日付';

  @override
  String get shoppingDateNone => '日付未選択';

  @override
  String get clearShoppingDateAction => '日付をクリア';

  @override
  String get listSortLabel => 'リストの順序';

  @override
  String get listSortDate => '買い物の日付';

  @override
  String get listSortAz => '名前順（A–Z）';

  @override
  String get listSortManual => '手動の順序';

  @override
  String get imageCameraAction => '写真を撮る';

  @override
  String get imageGalleryAction => '写真から選ぶ';

  @override
  String get imageCaptureFailed => 'カメラまたは写真を開けませんでした。アクセス権限を確認して、もう一度お試しください。';

  @override
  String get imageRecognitionFailed => '写真を処理できませんでした。別の写真をお試しください。';

  @override
  String get receiptNoProducts =>
      '文字は読み取れましたが、レシートの商品が見つかりませんでした。商品と合計金額が写真に入るようにしてください。';

  @override
  String get keepAwakeOn => '画面は点灯したままです';

  @override
  String get keepAwakeOff => '画面が消灯することがあります';

  @override
  String get spanDay => '日';

  @override
  String get spanCustom => '期間';

  @override
  String get reportTotalSpent => '支出合計';

  @override
  String get reportAddedAt => '追加日';

  @override
  String get reportReceiptNumber => 'レシート番号';

  @override
  String get reportPreview => 'プレビュー';

  @override
  String get reportShareAction => '共有';

  @override
  String get previousPeriodAction => '前の期間';

  @override
  String get nextPeriodAction => '次の期間';

  @override
  String get reportSaved => 'レポートを保存しました。';

  @override
  String get reportZoom => '拡大';

  @override
  String planTrialDaysLeft(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days 日残っています',
    );
    return '$_temp0';
  }

  @override
  String planTrialHoursLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours 時間残っています',
    );
    return '$_temp0';
  }

  @override
  String get planTrialEndedTitle => 'Pro のトライアル期間が終了しました';

  @override
  String get planTrialEndedBody =>
      'リスト、手動入力、端末内の音声機能は引き続き無料で利用できます。Free では暦月ごとに AI リクエストを 10 回利用できます。年間 Pro を選ぶと、月 100 回の AI リクエスト、広告なし、バックアップが利用できます。既存のデータはそのまま残ります。';

  @override
  String get planContinueFree => 'Free で続ける';

  @override
  String get supportIdLabel => 'サポート ID';

  @override
  String get supportEmailLabel => 'メールサポート';

  @override
  String get captureTipFirst =>
      'いちばん上から撮影してください。店名と日付が写っている必要があります。できるだけ多くの商品を収め、残りは次の写真に写してください。';

  @override
  String get captureTipContinue => '同じレシートです。前の写真の最後の商品を含めてください。';

  @override
  String get captureTipNeverShow => '今後表示しない';

  @override
  String get captureTipOk => '了解';

  @override
  String get captureTipsSetting => 'レシート撮影のヒントを表示';

  @override
  String get listReceiptsSection => 'レシート';

  @override
  String get receiptStateComplete => '完了';

  @override
  String get receiptStateIncomplete => '未完了';

  @override
  String get receiptStateFailed => '失敗';

  @override
  String get receiptStoreUnknown => '店舗を読み取れません';

  @override
  String get receiptDeleteAction => 'レシートを削除';

  @override
  String get receiptDeleteConfirm => 'このレシートと追加された商品を削除しますか？後で再度取り込むことができます。';

  @override
  String get receiptDeleted => 'レシートを削除しました。';

  @override
  String listReceiptsShowAll(int count) {
    return 'すべて表示（$count）';
  }

  @override
  String get listReceiptsShowLess => '表示を減らす';

  @override
  String receiptDateLabel(String date) {
    return 'レシートの日付: $date';
  }
}
