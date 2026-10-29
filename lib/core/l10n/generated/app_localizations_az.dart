// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Azerbaijani (`az`).
class AppLocalizationsAz extends AppLocalizations {
  AppLocalizationsAz([String locale = 'az']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Evə planla. Plan üzrə alış et.';

  @override
  String get listsTitle => 'Siyahılar';

  @override
  String get listsTabActive => 'Aktiv';

  @override
  String get listsTabCompleted => 'Tamamlanmış';

  @override
  String get listsTabArchived => 'Arxivlənmiş';

  @override
  String get newListButton => 'Yeni siyahı';

  @override
  String get listTitleHint => 'Başlıq (istəyə bağlı)';

  @override
  String get saveButton => 'Saxla';

  @override
  String get cancelButton => 'Ləğv et';

  @override
  String get deleteButton => 'Sil';

  @override
  String get editAction => 'Düzəliş';

  @override
  String get listDeleted => 'Siyahı silindi';

  @override
  String get invalidAmountError => 'Yanlış məbləğ';

  @override
  String get duplicateAction => 'Kopyala';

  @override
  String get archiveAction => 'Arxivlə';

  @override
  String get unarchiveAction => 'Arxivdən çıxar';

  @override
  String get deleteListConfirm =>
      'Bu siyahını silmək istəyirsiniz? Planlaşdırılmış maddələr də silinəcək.';

  @override
  String get undoButton => 'Geri al';

  @override
  String get searchListHint => 'Siyahılarda axtar';

  @override
  String get currencyLabel => 'Valyuta';

  @override
  String get budgetLabel => 'Büdcə (istəyə bağlı)';

  @override
  String get noteLabel => 'Qeyd (istəyə bağlı)';

  @override
  String get storeLabel => 'Mağaza';

  @override
  String get keepAmountsAction => 'Məbləqləri saxla';

  @override
  String get resetAmountsAction => 'Məbləqləri sıfırla';

  @override
  String get currencyChangeWarning =>
      'Valyuta dəyişir. Mövcud məbləğlər nə olmalıdır?';

  @override
  String get listsEmpty =>
      'Hələ siyahı yoxdur. İlk alış-veriş planınızı yaradın.';

  @override
  String get statusDraft => 'Layihə';

  @override
  String get statusPlanned => 'Planlaşdırılmış';

  @override
  String get statusShopping => 'Alış-verişdə';

  @override
  String get statusCompleted => 'Tamamlandı';

  @override
  String get statusArchived => 'Arxivlənmiş';

  @override
  String autoListTitle(String date) {
    return '$date alış-verişi';
  }

  @override
  String get itemFormTitle => 'Məddə əlavə et';

  @override
  String get itemNameLabel => 'Məddə adı';

  @override
  String get brandLabel => 'Brend / variant (istəyə bağlı)';

  @override
  String get categoryLabel => 'Kateqoriya';

  @override
  String get quantityLabel => 'Miqdar';

  @override
  String get unitLabel => 'Vahid';

  @override
  String get pricingModeLabel => 'Qiymət girişi';

  @override
  String get pricingModeUnitPrice => 'Vahid qiyməti';

  @override
  String get pricingModeLineTotal => 'Sətir cəmi';

  @override
  String get plannedPriceLabel => 'Planlaşdırılan qiymət';

  @override
  String lineTotalCalculated(String value) {
    return 'Sətir cəmi: $value';
  }

  @override
  String get requiredItemToggle => 'Tələb olunan məddə';

  @override
  String get maxPriceLabel => 'Maksimum qəbul edilən qiymət (istəyə bağlı)';

  @override
  String get itemNoteLabel => 'Qeyd (istəyə bağlı)';

  @override
  String get categoryProduce => 'Meyvə və tərəvəz';

  @override
  String get categoryDairy => 'Süd məhsulları';

  @override
  String get categoryMeat => 'Ət';

  @override
  String get categoryBakery => 'Çörək məmulatları';

  @override
  String get categoryDrinks => 'İçkilər';

  @override
  String get categoryCleaning => 'Təmizlik';

  @override
  String get categoryPersonalCare => 'Şəxsi gigiyena';

  @override
  String get categoryHome => 'Ev';

  @override
  String get categoryOther => 'Digər';

  @override
  String get invalidQuantityError => 'Yanlış miqdar';

  @override
  String get invalidPriceError => 'Yanlış qiymət';

  @override
  String get invalidNameError => 'Ad daxil edin';

  @override
  String unitPriceCalculated(String value) {
    return 'Birim qiymət: $value';
  }

  @override
  String get shoppingTitle => 'Alış-veriş rejimi';

  @override
  String get summaryPlannedTotal => 'Planlaşdırılan';

  @override
  String get summaryInCart => 'Səbətdə';

  @override
  String get summaryRemainingPlan => 'Qalan plan';

  @override
  String get summaryProjected => 'Təxmini ödəniş';

  @override
  String get summaryBudgetRemaining => 'Qalan büdcə';

  @override
  String get summaryBudgetOver => 'Büdcədən artıq';

  @override
  String itemsProgress(String done, String total) {
    return '$total məhsuldan $done-i tamamlandı';
  }

  @override
  String get filterAll => 'Hamısı';

  @override
  String get filterToBuy => 'Alınacaq';

  @override
  String get filterInCart => 'Səbətdə';

  @override
  String get filterNotFound => 'Tapılmadı';

  @override
  String get filterRequired => 'Zəruri';

  @override
  String get quickEntryTitle => 'Həqiqi qiymət';

  @override
  String get actualQuantityLabel => 'Həqiqi miqdar';

  @override
  String get actualPriceLabel => 'Həqiqi qiymət';

  @override
  String get discountLabel => 'Endirim (istəyə görə)';

  @override
  String get alternativeNameLabel => 'Alternativ məhsul adı (istəyə görə)';

  @override
  String get savePurchaseButton => 'Səbətə əlavə et';

  @override
  String get unplannedAddButton => 'Planda olmayan məhsul əlavə et';

  @override
  String get statusPending => 'Alyanadək';

  @override
  String get statusInCart => 'Səbətdə';

  @override
  String get statusNotFound => 'Tapılmadı';

  @override
  String get statusGaveUp => 'Tərk edildi';

  @override
  String get statusAlternative => 'Alternativ alındı';

  @override
  String get keepScreenAwake => 'Ekranı oyada saxla';

  @override
  String get finishShopping => 'Alış-verişi bitir';

  @override
  String get completionWarning =>
      'Yoxlanılmamış və ya çatışmayan qeydlər var. Hələ də bitirə bilərsiniz; nəticədə bu barədə qeyd oluna bilər.';

  @override
  String get continueShoppingButton => 'Alış-verişə davam et';

  @override
  String get resultTitle => 'Nəticə';

  @override
  String get summarySection => 'Xülasə';

  @override
  String get plannedTotalLabel => 'Planlaşdırılan ümumi';

  @override
  String get actualTotalLabel => 'Həqiqi ümumi';

  @override
  String get varianceLabel => 'Fərq';

  @override
  String get varianceNotComputable => 'Hesablana bilmir';

  @override
  String get budgetStatusLabel => 'Büdcə';

  @override
  String get savingsLabel => 'Plandan aşağı';

  @override
  String get overspendLabel => 'Plandan yuxarı';

  @override
  String get unplannedTotalLabel => 'Planda olmayanların ümumi';

  @override
  String get unpurchasedLabel => 'Planlaşıb alınmamış';

  @override
  String get totalDiscountLabel => 'Ümumi endirimlər';

  @override
  String get accuracyLabel => 'Təxmini dəqiqlik';

  @override
  String get groupsSection => 'Məhsullar';

  @override
  String get groupPricier => 'Planlaşdırandan bahadır';

  @override
  String get groupCheaper => 'Planlaşdırandan ucuzdur';

  @override
  String get groupClose => 'Təxminə yaxındır';

  @override
  String get groupNotTaken => 'Planlaşıb, alınmayıb';

  @override
  String get groupUnplanned => 'Plansız alınmış';

  @override
  String get groupQuantityChanged => 'Miqdar dəyişib';

  @override
  String get groupUnverified => 'Yoxlanılmayıb';

  @override
  String get plannedQtyLabel => 'Planlaşdırılan miqdar';

  @override
  String get actualQtyLabel => 'Həqiqi miqdar';

  @override
  String get plannedUnitPriceLabel => 'Planlaşdırılan birim qiymət';

  @override
  String get actualUnitPriceLabel => 'Həqiqi birim qiymət';

  @override
  String get lineVarianceLabel => 'Sətir fərqi';

  @override
  String get discountEffectLabel => 'Endirim təsiri';

  @override
  String get notBoughtMark => 'alınmayıb';

  @override
  String get noPurchasesNote => 'Heç bir alış qeydə alınmayıb.';

  @override
  String get navHome => 'Əsas';

  @override
  String get navLists => 'Siyahılar';

  @override
  String get navHistory => 'Tarixçə';

  @override
  String get navSettings => 'Tənzimləmələr';

  @override
  String get homeEmptyTitle => 'Alış-veriş planını hazırla';

  @override
  String get homeEmptyBody =>
      'İlk siyahını yaradın və planlaşdırılan xərcləri faktiki xərclərlə müqayisə edin.';

  @override
  String get homeActiveSection => 'Aktiv siyahılar';

  @override
  String get homeCompletedSection => 'Yaxın zamanda tamamlanmış';

  @override
  String get homeMonthlySection => 'Bu ay';

  @override
  String get monthPlannedLabel => 'Planlaşdırılan';

  @override
  String get monthActualLabel => 'Faktiki';

  @override
  String get monthVarianceLabel => 'Fərq';

  @override
  String get continueShoppingLabel => 'Alış-verişə davam et';

  @override
  String get historyEmpty =>
      'Hələ tamamlanmış alış-veriş yoxdur. Tarixçəniz və təhlilləriniz burada görünəcək.';

  @override
  String get aboutTabTitle => 'NShoptor haqqında';

  @override
  String get aboutBody =>
      'Crazy Penguin tərəfindən hazırlanmış NShoptor. Oflayn-first alış-veriş planlayıcısı. GPL-3.0 lisenziyası ilə yayılır.';

  @override
  String get startShoppingLabel => 'Alış-verişə başla';

  @override
  String get finishAndSeeResult => 'Bitir və nəticəni gör';

  @override
  String get settingsTitle => 'Tənzimləmələr';

  @override
  String get languageLabel => 'Dil';

  @override
  String get languageSystem => 'Sistem';

  @override
  String get languageTr => 'Türkcə';

  @override
  String get languageEn => 'İngiliscə';

  @override
  String get themeLabel => 'Tema';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get themeLight => 'Açıq';

  @override
  String get themeDark => 'Qaranlıq';

  @override
  String get defaultCurrencyLabel => 'Standart valyuta';

  @override
  String get defaultUnitLabel => 'Standart vahid';

  @override
  String get keepAwakeLabel => 'Alış-veriş zamanı ekranı oyada saxla';

  @override
  String get backupSection => 'Yedək';

  @override
  String get exportBackupLabel => 'Yedeği ixrac et';

  @override
  String get importBackupLabel => 'Yedeği idxal et';

  @override
  String get mergeImportLabel => 'Cari məlumatlara birləşdir';

  @override
  String get separateImportLabel => 'Ayrı kopya kimi idxal et';

  @override
  String get importCancelled => 'Idxal ləğv edildi.';

  @override
  String get backupExported => 'Yedək uğurla ixrac edildi.';

  @override
  String get deleteAllSection => 'Təhlükəli zona';

  @override
  String get deleteAllLabel => 'Bütün məlumatları sil';

  @override
  String get deleteAllConfirm =>
      'Bu, bütün siyahıları, tarixçəni, qəbul şəkillərini və qiymətləri siləcək. Sizin tərəfinizdən ixrac edilmiş fayllar diskdə qalacaq. Davam etmək istəyirsiniz?';

  @override
  String get deleteAllConfirm2 =>
      'Tam əminsiniz? Bu əməliyyat geri qaytarıla bilməz.';

  @override
  String get cancelAction => 'Ləğv et';

  @override
  String get confirmDelete => 'Həmişəlik sil';

  @override
  String get dataDeleted => 'Bütün yerli məlumatlar silindi.';

  @override
  String get privacyInfoLabel => 'Məxfilik';

  @override
  String get privacyInfoBody =>
      'Siyahılarınız, qiymətləriniz, qəbullarınız və şəkilləriniz cihazınızda saxlanılır. Səs heç vaxt cihazdan çıxmır. AI kömək aktiv olduqda, qəbul və qiymət etiketi şəkilləri (ölçüsü azaldılmış) və diktə etdiyiniz maddələr kimi mətn yalnız oxunmaq üçün serverimizə göndərilir; dərhal emal olunur və heç vaxt saxlanılmır.';

  @override
  String get aboutSection => 'Haqqında';

  @override
  String get aboutPublisher => 'Nəşr edən: Crazy Penguin';

  @override
  String get aboutLicenses => 'Lisenziyalar (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Səsli giriş';

  @override
  String get voiceStatusUnknown => 'Xidmət: yoxlanılmayıb';

  @override
  String get permissionsLabel => 'İcazələr';

  @override
  String get permissionsBody =>
      'Kamera, mikrofon və bildirişlər yalnız həmin funksiyalardan istifadə edərkən tələb olunur.';

  @override
  String get unitsSection => 'Standartlar';

  @override
  String get roundingNote =>
      'Pul yuvarlaqlaşdırma bir qaydaya tabedir: yarım rəqəmlər sıfırdan uzağa doğru yuvarlaqlaşdırılır, bu yalnız Pul çevrilməsi zamanı tətbiq edilir.';

  @override
  String get voiceInputTitle => 'Səsli giriş';

  @override
  String get voiceStartListening => 'Dinləməyə başla';

  @override
  String get voiceTranscriptLabel => 'Transkript';

  @override
  String get parseAction => 'Emal et';

  @override
  String get receiptReviewTitle => 'Qəbulu nəzərdən keçir';

  @override
  String get receiptTotal => 'Çekilin cəmi';

  @override
  String get receiptTotalUnknown => 'Cəm aşkarlanmadı';

  @override
  String get receiptDiff => 'Fərq';

  @override
  String get acceptLine => 'Sətiri qəbul et';

  @override
  String get ignoreLine => 'Sətiri nəzərə alma';

  @override
  String get receiptLineActions =>
      'Məhsula birləşdir, ikiyə böl və ya nəzərə alma';

  @override
  String get receiptCommit => 'Hamısını qəbul et';

  @override
  String get receiptCommitted => 'Çeki tətbiq edildi.';

  @override
  String get priceHistoryTitle => 'Qiymət tarixçəsi';

  @override
  String get noObservations => 'Hələ qiymət müşahidəsi yoxdur';

  @override
  String get templatesSection => 'Şablonlar';

  @override
  String get templateHint => 'Əvvəlki alış səfərindən yeni plan yaradın';

  @override
  String get scanReceiptAction => 'Çeki skan et';

  @override
  String get fromReceiptListButton => 'Qəbzdən siyahı';

  @override
  String get shelfLabelAction => 'Raf etiketindən qiymət';

  @override
  String get priceCandidatesTitle => 'Qiymət namizədləri';

  @override
  String get noPriceCandidates => 'Qiymət tapılmadı; əl ilə daxil edin.';

  @override
  String get voiceUnavailable =>
      'Nitq tanınması əlçatan deyil; əl ilə daxil edin.';

  @override
  String get linkToItem => 'Məhsula birləşdir';

  @override
  String get splitLine => 'İkiyə böl';

  @override
  String get mergeWithNext => 'Növbəti ilə birləşdir';

  @override
  String get ocrNoText => 'Heç bir mətn oxunmadı; yenidən cəhd edin.';

  @override
  String get priceHistoryAction => 'Qiymət tarixçəsi';

  @override
  String get itemsEmptyTitle => 'Hələ heç bir məhsul yoxdur';

  @override
  String get itemsEmptyBody =>
      'İlk məhsulunuzu əlavə edin — mağazada real qiymətləri burada daxil edəcəksiniz.';

  @override
  String get addItemTooltip => 'Məhsul əlavə et';

  @override
  String get unitAdet => 'dsc';

  @override
  String get unitKilogram => 'kq';

  @override
  String get unitGram => 'q';

  @override
  String get unitLitre => 'L';

  @override
  String get unitMililitre => 'ml';

  @override
  String get unitPaket => 'paket';

  @override
  String get unitKutu => 'qutu';

  @override
  String get unitSise => 'şüşə';

  @override
  String get unitKavanoz => 'banka';

  @override
  String get unitDemet => 'demət';

  @override
  String get unitDuzine => 'düzinə';

  @override
  String get unitMetre => 'm';

  @override
  String get unitCustom => 'Xüsusi';

  @override
  String get setReminderAction => 'Xatırlatma təyin et';

  @override
  String get reminderPermissionDenied =>
      'Xatırlatmalar üçün bildiriş icazəsi lazımdır. Onu sistem parametrlərində aktivləşdirə bilərsiniz.';

  @override
  String get reminderScheduled => 'Xatırlatma təyin edildi.';

  @override
  String get reminderCancelled => 'Xatırlatma silindi.';

  @override
  String get reminderTitle => 'Alış-veriş xatırlatması';

  @override
  String reminderBody(Object title) {
    return 'Siyahınızı yoxlamaq vaxtı gəldi: $title';
  }

  @override
  String get reminderPickDate => 'Tarix seçin';

  @override
  String get reminderPickTime => 'Saat seçin';

  @override
  String get itemDetailsSection => 'Təfərrüatlar';

  @override
  String get priceOptionalHint =>
      'İxtiyari — real qiyməti mağazada daxil edəcəksiniz';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Planlaşdırılan: $total · $count məhsul';
  }

  @override
  String get proActiveLabel => 'Pro aktivdir — təşəkkür!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Reklam yoxdur · Yedəkləmə ixrac və idxal · Illik';

  @override
  String get proBenefitNoAds => 'Reklamsız təcrübə';

  @override
  String get proBenefitBackup => 'Ehtiyat nüsxə (idxal/ixrac)';

  @override
  String aboutVersion(Object version) {
    return 'Versiya $version';
  }

  @override
  String get navDiscover => 'Kəşf et';

  @override
  String get shareAction => 'Tətbiqi paylaş';

  @override
  String get rateAction => 'Bizi qiymətləndirin';

  @override
  String get aboutOpenRow => 'Haqqında & açıq mənbə';

  @override
  String get voiceAddItemAction => 'Səslə əlavə et';

  @override
  String get formatLocaleLabel => 'Rəqəm və valyuta formatı';

  @override
  String get formatLocaleSystem =>
      'Cihaz formatı (Latın rəqəmləri; əks halda İngilis dili)';

  @override
  String get formatLocaleTr => 'Türkcə (1.234,56)';

  @override
  String get formatLocaleEn => 'İngiliscə (1,234.56)';

  @override
  String get aiToggleTitle => 'AI köməyi';

  @override
  String get aiToggleSubtitle =>
      'Şəkillərdən qəbulları və qiymət etiketlərini oxuyur, qəbulları uyğunlaşdırır və cümlələri siyahıya çevirir. Şəkillər yalnız oxunmaq üçün göndərilir və heç vaxt saxlanılmır.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Bu ay üçün AI sorğularınızı ($used/$limit) istifadə etmisiniz. Daha çox almaq üçün yeniləyin və ya AI olmadan davam edin.';
  }

  @override
  String get aiOffline => 'Bağlantı yoxdur — AI olmadan davam edilir.';

  @override
  String get aiFailed =>
      'AI hazırda əlçatan deyil — onun olmadan davam edilir.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'Cihaz';

  @override
  String get quickListAction => 'Cümlədən əlavə et';

  @override
  String get quickListTitle => 'Sürətli siyahı';

  @override
  String get quickListHint => 'məs. 1 kq alma 20, 2 çörək, yarım kilo pendir';

  @override
  String get quickListConvert => 'Siyahıya çevir';

  @override
  String quickListAdd(int count) {
    return '$count məhsul əlavə et';
  }

  @override
  String get quickListEmpty =>
      'Məhsul tapılmadı. Onları vergüllə ayıraraq sadalamağa cəhd edin.';

  @override
  String get receiptAiMatched =>
      'AI çeki siyahınıza uyğunlaşdırdı. Keçidləri yoxlayın və təsdiqləyin.';

  @override
  String get receiptNeedsCheck => 'Bu uyğunluğu yoxlayın';

  @override
  String get receiptDiscountLine => 'Endirim';

  @override
  String get compareItem => 'Məhsul';

  @override
  String get compareEstimated => 'Təxmini';

  @override
  String get compareActual => 'Həqiqi';

  @override
  String get compareDiff => 'Fərq';

  @override
  String get compareTotal => 'Ümumi';

  @override
  String get compareBudget => 'Büdcə';

  @override
  String get compareNotBought => 'alınmayıb';

  @override
  String get compareUnplanned => 'planlaşdırılmayıb';

  @override
  String get pricierItems => 'Daha bahalı oldu';

  @override
  String get cheaperItems => 'Daha ucuz oldu';

  @override
  String get compareAction => 'Müqayisə et';

  @override
  String get detailsSection => 'Ətraflı';

  @override
  String get spendingTitle => 'Xərclər';

  @override
  String get spendingAction => 'Xərclər';

  @override
  String get spendingMonthTotal => 'Bu ay';

  @override
  String get spendingWeekly => 'Həftəlik xərclər';

  @override
  String get spendingMonthly => 'Aylıq xərclər';

  @override
  String get monthlyLimitTitle => 'Aylıq limit';

  @override
  String get monthlyLimitHelp =>
      'Ay ərzində alış-verişə nə qədər xərcləmək istəyirsiniz?';

  @override
  String get monthlyLimitRemove => 'Sil';

  @override
  String get monthlyLimitSet => 'Təyin et';

  @override
  String get monthlyLimitChange => 'Dəyişdir';

  @override
  String get monthlyLimitNone =>
      'Qalan məbləği görmək üçün aylıq limit təyin edin.';

  @override
  String monthlyLimitOver(String amount) {
    return 'Limitdən $amount artıq';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return 'Bu ay $amount qalıb';
  }

  @override
  String get plansTitle => 'Planlar';

  @override
  String get plansHeadline => 'AI ilə ağıllı alış-veriş edin';

  @override
  String get plansSubhead =>
      'Çek uyğunluğu, qiymət etiketləri və cümlələrdən siyahılar. İstədiyiniz vaxt ləğv edə bilərsiniz.';

  @override
  String get plansMonthly => 'Aylıq';

  @override
  String get plansYearly => 'Illik';

  @override
  String get planFree => 'Pulsuz';

  @override
  String get planFreePrice => 'Həmişə pulsuz';

  @override
  String get planFreeAi => 'Ayda 10 AI sorğusu';

  @override
  String get planFreeAds => 'Kiçik banner reklam (ilk 7 gündə yoxdur)';

  @override
  String get planCoreFeatures =>
      'Siyahılar, qiymətlər, çeklər, xərcləmə diaqramları';

  @override
  String get plansPerYear => '/ il';

  @override
  String get plansPerMonth => '/ ay';

  @override
  String get planTrial => 'Pulsuz sınaq';

  @override
  String get planProAi => 'Ayda 100 AI sorğusu';

  @override
  String get planNoAds => 'Reklam yoxdur';

  @override
  String get planBackup => 'Yedəkləmə ixrac və idxal';

  @override
  String get planMaxAi => 'Ayda 300 AI sorğusu';

  @override
  String get planMaxFamily => 'Böyük ailə alışları üçün';

  @override
  String get plansStoreUnavailable => 'Mağaza hazırkı anda əlçatan deyil.';

  @override
  String get retryAction => 'Təkrar cəhd et';

  @override
  String get plansPurchaseFailed =>
      'Alış həyata keçirilmədi. Zəhmət olmasa, yenidən cəhd edin.';

  @override
  String get plansRestore => 'Alışları bərpa et';

  @override
  String get plansLegal =>
      'Pro ləğv edilənədək hər il avtomatik yenilənir və ayda 100 süni intellekt sorğusu daxildir. Baza qiyməti tətbiq olunan vergilərdən əvvəl ildə 1 ABŞ dollarıdır; alışı təsdiqləməzdən əvvəl mağazada yekun yerli qiyməti və vergiləri yoxlayın. Google Play-də idarə edin və ya ləğv edin.';

  @override
  String get planCurrent => 'Cari';

  @override
  String get planStartTrial => 'Pulsuz sınağa başla';

  @override
  String get planChoose => 'Seç';

  @override
  String get plansAction => 'Planlar: Pro';

  @override
  String get assistantTitle => 'Assistent';

  @override
  String get assistantGreeting => 'Salam! Nə etmək istəyirsiniz?';

  @override
  String get assistantNewList => 'Yeni siyahı';

  @override
  String get assistantVoiceList => 'Səs ilə siyahı';

  @override
  String get assistantTextList => 'Cümlədən siyahı';

  @override
  String get assistantScanReceipt => 'Çeki skan et';

  @override
  String get assistantSpending => 'Xərclərim';

  @override
  String get assistantReceiptHint =>
      'Siyahınızı açın və onu skan etmək üçün çek ikonuna toxunun.';

  @override
  String get assistantToggleTitle => 'Assidenti göstər';

  @override
  String get assistantToggleSubtitle => 'Sağ aşağı küncdəki kiçik köməkçi';

  @override
  String get scanPriceLabel => 'Qiymət etiketini skan et';

  @override
  String get saveFailed =>
      'Yadda saxlamaq mümkün olmadı. Dəyişiklikləriniz hələ də qalır. Zəhmət olmasa, yenidən cəhd edin.';

  @override
  String get deleteItemConfirm =>
      'Bu məhsulu və onun qeydə alınmış alışlarını silmək istəyirsiniz?';

  @override
  String get clearPurchaseConfirm =>
      'Bu məhsulun işarəsini silmək və onun qeydə alınmış alışlarını silmək istəyirsiniz?';

  @override
  String get reportPdfAction => 'PDF hesabatını saxla';

  @override
  String get reportNotInvoice =>
      'Alış xülasəsi, vergi fakturası deyil. Vergi dərəcələri naməlumdur.';

  @override
  String get purchaseVisits => 'Alış ziyarətləri';

  @override
  String get purchaseInterval => 'Alışlar arasındakı orta günlər';

  @override
  String get purchasedQuantity => 'Alınan miqdar';

  @override
  String get purchaseAnalyticsHint =>
      'Alışlar istehlakı ölçmür. Valyutalar və vahidlər ayrıca göstərilir.';

  @override
  String get receiptReplaces =>
      'Qiyməti olmayan məhsullar tamamlanır. Artıq bazar qiyməti olan məhsullar ayrıca alış kimi əlavə edilir.';

  @override
  String get receiptIncompleteHeader =>
      'Növbəti fotoya mağazanı, tarixi, saatı və çek nömrəsini daxil edin.';

  @override
  String get receiptIncompleteTail =>
      'Növbəti hissəni bir neçə üst-üstə düşən məhsul və yekun məbləğ görünəcək şəkildə çəkin.';

  @override
  String get receiptContinuationRejected =>
      'Bu foto çeki davam etdirmək üçün birləşdirilə bilmədi. Eyni çekdən üst-üstə düşən məhsullarla yenidən çəkin.';

  @override
  String get receiptDraftSaved =>
      'Çek qaralama kimi saxlanıldı. Sonra davam edə bilərsiniz.';

  @override
  String get receiptContinueAction => 'Çeki davam etdir';

  @override
  String get receiptDraftsTitle => 'Yarımçıq çeklər';

  @override
  String get receiptDuplicate => 'Bu çek artıq əlavə edilib.';

  @override
  String get receiptTotalMismatch =>
      'Məhsullar çekin yekun məbləği ilə uyğun gəlmir. Bütün çekin göründüyünü yoxlayın.';

  @override
  String get receiptSaveDraftAction => 'Sonra üçün saxla';

  @override
  String get receiptResolveLines =>
      'Saxlamazdan əvvəl hər məhsulu qəbul edin və ya nəzərə almayın.';

  @override
  String get receiptPartialConfirm =>
      'Yalnız seçilmiş məhsullar əlavə ediləcək. Bu qəbz idxal edilmiş kimi işarələnəcək. Davam edilsin?';

  @override
  String get voiceUnsupportedLanguage =>
      'Bu dil bu cihazda səsli giriş üçün mövcud deyil. Bunun əvəzinə yazmaq mümkündür.';

  @override
  String get voiceStopListening => 'Dinləməni dayandır';

  @override
  String get keepAwakeFailed =>
      'Ekranı oyuda saxlamaq mümkün olmadı. Zəhmət olmasa, yenidən cəhd edin.';

  @override
  String get purchaseHistoryHint =>
      'Tamamlanmış bütün alış-verişlər. Qaytarmalar ümumi məbləği azaldır. Tarixlər alış-verişin tamamlanmasına aiddir. Bir ziyarət orta intervalı hesablamaq üçün kifayət deyil.';

  @override
  String get planLegacyRights =>
      'Mövcud Pro və Max abunəlikləri ilkin aylıq AI limitini saxlayır.';

  @override
  String get csvExportAction => 'CSV ixracat et';

  @override
  String get reportSharePdf => 'PDF kimi paylaş';

  @override
  String get reportShareCsv => 'CSV kimi paylaş';

  @override
  String get reportPrintAction => 'Çap et';

  @override
  String get backupSizeWarning =>
      'JSON faylı şəkil faylları əvəzinə qeydlər daşıyır. İdxal həddi: 16 MB.';

  @override
  String get backupImportFailed =>
      'Bu ehtiyat nüsxəsini idxal etmək mümkün olmadı. Məlumatlarınız dəyişdirilmədi.';

  @override
  String get backupImported => 'Yedək uğurla idxal edildi.';

  @override
  String backupPreviewCounts(Object entries, Object items, Object lists) {
    return '$lists siyahı · $items məhsul · $entries alış';
  }

  @override
  String get voiceModelDownloading =>
      'Bu dil üçün səs modeli yüklənir. Bir dəqiqədən sonra yenidən cəhd edin.';

  @override
  String get historyThisWeek => 'Bu həftə';

  @override
  String get historyProductsSection => 'Alınan məhsullar';

  @override
  String get tipReceiptScan =>
      'Qəbzi skan edin və qiymətləri siyahınızla uyğunlaşdırın';

  @override
  String get tipVoiceAdd =>
      'Bir və ya bir neçə məhsulu səsləndirin, əlavə etməzdən əvvəl yoxlayın';

  @override
  String get tipShelfCamera => 'Kamera ilə rəf etiketindən qiyməti oxuyun';

  @override
  String get tipPlan =>
      'Planınız: təfərrüatlara baxın, abunə olun və ya yüksəldin';

  @override
  String get guideAddBody =>
      'Məhsul əlavə etmək üçün + basın. Planlaşdırılan qiyməti indi, bazar qiymətini kassada daxil edin.';

  @override
  String get guideVoiceBody =>
      'Mikrofona basın və məhsulları deyin, məsələn: \'1 kiloqram alma, 1 çörək\'.';

  @override
  String get guideReceiptBody =>
      'Qəbzi skan edərək qiymətləri siyahınızdakı məhsullarla uyğunlaşdırın.';

  @override
  String get guidePlanBody =>
      'Planınıza baxmaq, abunə olmaq və ya yüksəltmək üçün plan işarəsinə basın.';

  @override
  String get guideNext => 'Tamam';

  @override
  String get guideDone => 'Başla';

  @override
  String get paletteLabel => 'Rəng mövzusu';

  @override
  String get paletteForest => 'Meşə';

  @override
  String get paletteOcean => 'Okean';

  @override
  String get paletteSunset => 'Gün batımı';

  @override
  String get paletteLavender => 'Lavanda';

  @override
  String get darkBlackLabel => 'Qaranlıq mövzuda tam qara';

  @override
  String get spendingOverview => 'Ümumi baxış';

  @override
  String get spendingThisYear => 'Bu il';

  @override
  String get spendingYearly => 'İllik xərc';

  @override
  String get productSpending => 'Məhsullara görə xərc';

  @override
  String get spanWeek => 'Həftə';

  @override
  String get spanMonth => 'Ay';

  @override
  String get spanYear => 'İl';

  @override
  String get weeklyLimitTitle => 'Həftəlik limit';

  @override
  String get weeklyLimitHelp =>
      'Alış-verişə həftədə nə qədər xərcləmək istəyirsiniz?';

  @override
  String get weeklyLimitNone =>
      'Nə qədər qaldığını görmək üçün həftəlik limit təyin edin.';

  @override
  String weeklyLimitLeft(String amount) {
    return 'Bu həftə $amount qalıb';
  }

  @override
  String get shoppingLimitTitle => 'Hər alış-veriş üçün limit';

  @override
  String get shoppingLimitHelp => 'Yeni siyahılar bu büdcə ilə başlayır.';

  @override
  String get shoppingLimitNone =>
      'Hər yeni alış-veriş üçün standart büdcə təyin edin.';

  @override
  String get monthlyReportAction => 'Aylıq hesabat';

  @override
  String get reportShoppingColumn => 'Alış-veriş';

  @override
  String get reportDateColumn => 'Tarix';

  @override
  String get planUnavailable => 'Hazırda mağazada yoxdur';

  @override
  String get demoDataTitle => 'Nümunə məlumatlar';

  @override
  String get demoDataLoad => 'Nümunə məlumatlarla sınayın';

  @override
  String get demoDataLoadHelp =>
      'Tarixçəni, qrafikləri və qiymət tarixçəsini görmək üçün 12 aylıq nümunə alış-veriş əlavə edir.';

  @override
  String get demoDataRemove => 'Nümunə məlumatları silin';

  @override
  String get demoDataAdded => 'Nümunə məlumatlar əlavə edildi';

  @override
  String get demoDataRemoved => 'Nümunə məlumatlar silindi';

  @override
  String get demoProductApple => 'Alma';

  @override
  String get demoProductBread => 'Çörək';

  @override
  String get demoProductMilk => 'Süd';

  @override
  String get demoProductCheese => 'Pendir';

  @override
  String get demoProductTomato => 'Pomidor';

  @override
  String get demoProductEggs => 'Yumurta';

  @override
  String get demoProductCoffee => 'Qəhvə';

  @override
  String get demoProductDetergent => 'Yuyucu vasitə';

  @override
  String get sendAction => 'Send';

  @override
  String get previousMonthAction => 'Previous month';

  @override
  String get nextMonthAction => 'Next month';

  @override
  String get helpSection => 'Kömək və dəstək';

  @override
  String get howToUseLabel => 'İstifadə qaydası';

  @override
  String get guidePricesBody =>
      'Mağaza qiyməti daxil ediləndə məhsul alınmış sayılır; 0 da keçərlidir. Evdəki qiymət istəyə bağlıdır. İşarəni silmək üçün mağaza qiymətini silin.';

  @override
  String get shoppingDateLabel => 'Alış-veriş tarixi';

  @override
  String get shoppingDateNone => 'Tarix seçilməyib';

  @override
  String get clearShoppingDateAction => 'Tarixi sil';

  @override
  String get listSortLabel => 'Siyahı sırası';

  @override
  String get listSortDate => 'Alış-veriş tarixi';

  @override
  String get listSortAz => 'Ad (A–Z)';

  @override
  String get listSortManual => 'Əl ilə sırala';

  @override
  String get imageCameraAction => 'Foto çək';

  @override
  String get imageGalleryAction => 'Şəkillərdən seç';

  @override
  String get imageCaptureFailed =>
      'Kamera və ya şəkillər açıla bilmədi. Giriş icazəsini yoxlayıb yenidən cəhd edin.';

  @override
  String get imageRecognitionFailed =>
      'Şəkli emal etmək mümkün olmadı. Başqa şəkil sınayın.';

  @override
  String get receiptNoProducts =>
      'Mətn oxundu, lakin çekdə məhsullar tapılmadı. Məhsulları və yekun məbləği şəkilə daxil edin.';

  @override
  String get keepAwakeOn => 'Ekran açıq qalır';

  @override
  String get keepAwakeOff => 'Ekran sönə bilər';

  @override
  String get spanDay => 'Gün';

  @override
  String get spanCustom => 'Tarix aralığı';

  @override
  String get reportTotalSpent => 'Ümumi xərclənən';

  @override
  String get reportAddedAt => 'Əlavə edilib';

  @override
  String get reportReceiptNumber => 'Qəbz nömrəsi';

  @override
  String get reportPreview => 'Önizləmə';

  @override
  String get reportShareAction => 'Paylaş';

  @override
  String get previousPeriodAction => 'Əvvəlki dövr';

  @override
  String get nextPeriodAction => 'Növbəti dövr';

  @override
  String get reportSaved => 'Hesabat yadda saxlanıldı.';

  @override
  String get reportZoom => 'Böyüt';

  @override
  String planTrialDaysLeft(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days gün qalıb',
    );
    return '$_temp0';
  }

  @override
  String planTrialHoursLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours saat qalıb',
    );
    return '$_temp0';
  }

  @override
  String get planTrialEndedTitle => 'Pro sınaq müddətiniz bitdi';

  @override
  String get planTrialEndedBody =>
      'Siyahılardan, əl ilə daxil etmədən və cihazdakı səs funksiyasından pulsuz istifadə edə bilərsiniz. Pulsuz plana hər təqvim ayında 10 AI sorğusu daxildir. Ayda 100 AI sorğusu, reklamsız istifadə və ehtiyat nüsxələr üçün illik Pro seçin. Mövcud məlumatlarınız sizdə qalır.';

  @override
  String get planContinueFree => 'Pulsuz davam et';

  @override
  String get supportIdLabel => 'Dəstək ID-si';

  @override
  String get supportEmailLabel => 'E-poçtla dəstək';

  @override
  String get captureTipFirst =>
      'Ən yuxarıdan başlayın: mağazanın adı və tarix görünməlidir. Mümkün qədər çox məhsulu sığışdırın, qalanı növbəti fotoda olsun.';

  @override
  String get captureTipContinue =>
      'Eyni çek: əvvəlki fotodakı son məhsulu da daxil edin.';

  @override
  String get captureTipNeverShow => 'Bir daha göstərmə';

  @override
  String get captureTipOk => 'Anladım';

  @override
  String get captureTipsSetting => 'Çek çəkilişi məsləhətlərini göstər';

  @override
  String get receiptReadingProgress => 'Çek oxunur…';

  @override
  String get receiptReadInBackground => 'Arxa planda davam et';

  @override
  String get receiptReadDoneTitle => 'Çek oxundu';

  @override
  String get receiptReadDoneBody => 'Yoxlamaq və saxlamaq üçün toxunun.';

  @override
  String get receiptReadMoreTitle => 'Çekin qalan hissəsini çəkin';

  @override
  String get receiptReadFailedTitle => 'Çeki oxumaq mümkün olmadı';

  @override
  String get listReceiptsSection => 'Qəbzlər';

  @override
  String get receiptStateComplete => 'Tamamlandı';

  @override
  String get receiptStateIncomplete => 'Natamam';

  @override
  String get receiptStateFailed => 'Uğursuz';

  @override
  String get receiptStoreUnknown => 'Mağaza oxunmadı';

  @override
  String get receiptDeleteAction => 'Qəbzi sil';

  @override
  String get receiptDeleteConfirm =>
      'Bu qəbz və onun əlavə etdiyi məhsullar silinsin? Sonra yenidən idxal edə bilərsiniz.';

  @override
  String get receiptDeleted => 'Qəbz silindi.';

  @override
  String listReceiptsShowAll(int count) {
    return 'Hamısını göstər ($count)';
  }

  @override
  String get listReceiptsShowLess => 'Daha az göstər';

  @override
  String receiptDateLabel(String date) {
    return 'Qəbz tarixi: $date';
  }

  @override
  String get historyViewShopping => 'Alış-verişə görə';

  @override
  String get historyViewStore => 'Mağazaya görə';

  @override
  String get historyViewProduct => 'Məhsula görə';

  @override
  String get historyShareAll => 'Hamısını paylaş';

  @override
  String get historyUnknownStore => 'Naməlum mağaza';

  @override
  String get historyDailySpending => 'Gündəlik xərc';

  @override
  String get historyResetPeriod => 'Bu həftəyə qayıt';

  @override
  String get tourSkip => 'Keç';

  @override
  String get tourNewListBody =>
      'Alış-veriş siyahısı başladın və almaq istədiklərinizi əlavə edin.';

  @override
  String get tourFromReceiptBody =>
      'Artıq alış-veriş etmisiniz? Çeki qiymətləri ilə siyahıya çevirin.';

  @override
  String get tourReceiptFlowBody =>
      'Çekin yuxarısından başlayın: əvvəl mağaza və tarixi çəkin, sonra qalan sətirlərlə davam edin.';

  @override
  String get tourTabsBody =>
      'Aktiv, tamamlanmış və arxivlənmiş siyahılar arasında keçin. Sondakı düymə sıranı dəyişir.';

  @override
  String get tourDiscoverBody => 'Eyni tərtibatçının digər tətbiqlərinə baxın.';

  @override
  String get tourHelpBody =>
      'Bu bələdçini yenidən görmək üçün bura toxunun. Cəmlərin və məhsulların izahı üçün siyahı açın.';

  @override
  String get tourTotalsBody =>
      'Planlaşdırılan, faktiki cəm və fərq alış-veriş etdikcə yenilənir.';

  @override
  String get tourItemsBody =>
      'Məhsullarınız. Sıralarını burada dəyişin və ya axtarın.';
}
