// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Evdeki hesap çarşıya uyar.';

  @override
  String get listsTitle => 'Listeler';

  @override
  String get listsTabActive => 'Liste';

  @override
  String get listsTabCompleted => 'Tamamlananlar';

  @override
  String get listsTabArchived => 'Arşiv';

  @override
  String get newListButton => 'Yeni liste';

  @override
  String get listTitleHint => 'Başlık (isteğe bağlı)';

  @override
  String get saveButton => 'Kaydet';

  @override
  String get cancelButton => 'Vazgeç';

  @override
  String get deleteButton => 'Sil';

  @override
  String get editAction => 'Düzenle';

  @override
  String get listDeleted => 'Liste silindi';

  @override
  String get invalidAmountError => 'Geçersiz tutar';

  @override
  String get duplicateAction => 'Çoğalt';

  @override
  String get archiveAction => 'Arşivle';

  @override
  String get unarchiveAction => 'Arşivden çıkar';

  @override
  String get deleteListConfirm =>
      'Bu liste silinsin mi? Planlanan ürünler de kaldırılacak.';

  @override
  String get undoButton => 'Geri al';

  @override
  String get searchListHint => 'Listelerde ara';

  @override
  String get currencyLabel => 'Para birimi';

  @override
  String get budgetLabel => 'Bütçe (isteğe bağlı)';

  @override
  String get noteLabel => 'Not (isteğe bağlı)';

  @override
  String get storeLabel => 'Mağaza';

  @override
  String get keepAmountsAction => 'Rakamları koru';

  @override
  String get resetAmountsAction => 'Rakamları sıfırla';

  @override
  String get currencyChangeWarning =>
      'Para birimi değişiyor. Mevcut tutarlar ne yapılsın?';

  @override
  String get listsEmpty => 'Henüz liste yok. İlk alışveriş planını oluştur.';

  @override
  String get statusDraft => 'Taslak';

  @override
  String get statusPlanned => 'Planlandı';

  @override
  String get statusShopping => 'Alışverişte';

  @override
  String get statusCompleted => 'Tamamlandı';

  @override
  String get statusArchived => 'Arşivlendi';

  @override
  String autoListTitle(String date) {
    return '$date alışverişi';
  }

  @override
  String get itemFormTitle => 'Ürün ekle';

  @override
  String get itemNameLabel => 'Ürün adı';

  @override
  String get brandLabel => 'Marka / varyant (isteğe bağlı)';

  @override
  String get categoryLabel => 'Kategori';

  @override
  String get quantityLabel => 'Miktar';

  @override
  String get unitLabel => 'Birim';

  @override
  String get pricingModeLabel => 'Fiyat girişi';

  @override
  String get pricingModeUnitPrice => 'Birim fiyat';

  @override
  String get pricingModeLineTotal => 'Satır toplamı';

  @override
  String get plannedPriceLabel => 'Planlanan fiyat';

  @override
  String lineTotalCalculated(String value) {
    return 'Satır toplamı: $value';
  }

  @override
  String get requiredItemToggle => 'Zorunlu ürün';

  @override
  String get maxPriceLabel => 'En fazla kabul edilebilir fiyat (isteğe bağlı)';

  @override
  String get itemNoteLabel => 'Not (isteğe bağlı)';

  @override
  String get categoryProduce => 'Meyve-sebze';

  @override
  String get categoryDairy => 'Süt ürünleri';

  @override
  String get categoryMeat => 'Et';

  @override
  String get categoryBakery => 'Fırın';

  @override
  String get categoryDrinks => 'İçecek';

  @override
  String get categoryCleaning => 'Temizlik';

  @override
  String get categoryPersonalCare => 'Kişisel bakım';

  @override
  String get categoryHome => 'Ev';

  @override
  String get categoryOther => 'Diğer';

  @override
  String get invalidQuantityError => 'Geçersiz miktar';

  @override
  String get invalidPriceError => 'Geçersiz fiyat';

  @override
  String get invalidNameError => 'Ad gerekli';

  @override
  String unitPriceCalculated(String value) {
    return 'Birim fiyat: $value';
  }

  @override
  String get shoppingTitle => 'Alışveriş modu';

  @override
  String get summaryPlannedTotal => 'Planlanan';

  @override
  String get summaryInCart => 'Sepette';

  @override
  String get summaryRemainingPlan => 'Kalan plan';

  @override
  String get summaryProjected => 'Tahmini kasa';

  @override
  String get summaryBudgetRemaining => 'Bütçeden kalan';

  @override
  String get summaryBudgetOver => 'Bütçe aşımı';

  @override
  String itemsProgress(String done, String total) {
    return '$total üründen $done';
  }

  @override
  String get filterAll => 'Tümü';

  @override
  String get filterToBuy => 'Alınacaklar';

  @override
  String get filterInCart => 'Sepette';

  @override
  String get filterNotFound => 'Bulunamayanlar';

  @override
  String get filterRequired => 'Zorunlular';

  @override
  String get quickEntryTitle => 'Gerçek fiyat';

  @override
  String get actualQuantityLabel => 'Gerçek miktar';

  @override
  String get actualPriceLabel => 'Gerçek fiyat';

  @override
  String get discountLabel => 'İndirim (isteğe bağlı)';

  @override
  String get alternativeNameLabel => 'Alternatif ürün adı (isteğe bağlı)';

  @override
  String get savePurchaseButton => 'Sepete ekle';

  @override
  String get unplannedAddButton => 'Plansız ürün ekle';

  @override
  String get statusPending => 'Alınmadı';

  @override
  String get statusInCart => 'Sepette';

  @override
  String get statusNotFound => 'Bulunamadı';

  @override
  String get statusGaveUp => 'Vazgeçildi';

  @override
  String get statusAlternative => 'Alternatif alındı';

  @override
  String get keepScreenAwake => 'Ekranı açık tut';

  @override
  String get finishShopping => 'Alışverişi bitir';

  @override
  String get completionWarning =>
      'Eksik veya doğrulanmamış kayıtlar var. Yine de bitirebilirsiniz; sonuçta belirtilir.';

  @override
  String get continueShoppingButton => 'Alışverişe devam et';

  @override
  String get resultTitle => 'Sonuç';

  @override
  String get summarySection => 'Özet';

  @override
  String get plannedTotalLabel => 'Planlanan toplam';

  @override
  String get actualTotalLabel => 'Gerçek toplam';

  @override
  String get varianceLabel => 'Fark';

  @override
  String get varianceNotComputable => 'Hesaplanamaz';

  @override
  String get budgetStatusLabel => 'Bütçe';

  @override
  String get savingsLabel => 'Planın altında';

  @override
  String get overspendLabel => 'Planın üstünde';

  @override
  String get unplannedTotalLabel => 'Plansız toplam';

  @override
  String get unpurchasedLabel => 'Planlanıp alınmayan';

  @override
  String get totalDiscountLabel => 'Toplam indirim';

  @override
  String get accuracyLabel => 'Tahmin doğruluk oranı';

  @override
  String get groupsSection => 'Ürünler';

  @override
  String get groupPricier => 'Planlanandan pahalı';

  @override
  String get groupCheaper => 'Planlanandan ucuz';

  @override
  String get groupClose => 'Tahmine yakın';

  @override
  String get groupNotTaken => 'Planlanıp alınmayan';

  @override
  String get groupUnplanned => 'Plansız alınan';

  @override
  String get groupQuantityChanged => 'Miktarı değişen';

  @override
  String get groupUnverified => 'Doğrulanmamış';

  @override
  String get plannedQtyLabel => 'Planlanan miktar';

  @override
  String get actualQtyLabel => 'Gerçek miktar';

  @override
  String get plannedUnitPriceLabel => 'Planlanan birim fiyat';

  @override
  String get actualUnitPriceLabel => 'Gerçek birim fiyat';

  @override
  String get lineVarianceLabel => 'Satır farkı';

  @override
  String get discountEffectLabel => 'İndirim etkisi';

  @override
  String get notBoughtMark => 'alınmadı';

  @override
  String get noPurchasesNote => 'Kayıtlı satın alım yok.';

  @override
  String get navHome => 'Ana Sayfa';

  @override
  String get navLists => 'Listeler';

  @override
  String get navHistory => 'Geçmiş';

  @override
  String get navSettings => 'Ayarlar';

  @override
  String get homeEmptyTitle => 'Alışverişini planla';

  @override
  String get homeEmptyBody =>
      'İlk listeni oluştur; planladığın ile gerçek harcamanı karşılaştır.';

  @override
  String get homeActiveSection => 'Aktif listeler';

  @override
  String get homeCompletedSection => 'Son tamamlananlar';

  @override
  String get homeMonthlySection => 'Bu ay';

  @override
  String get monthPlannedLabel => 'Planlanan';

  @override
  String get monthActualLabel => 'Gerçekleşen';

  @override
  String get monthVarianceLabel => 'Fark';

  @override
  String get continueShoppingLabel => 'Alışverişe devam et';

  @override
  String get historyEmpty =>
      'Henüz tamamlanmış alışveriş yok. Geçmişin ve içgörülerin burada görünecek.';

  @override
  String get aboutTabTitle => 'NShoptor Hakkında';

  @override
  String get aboutBody =>
      'Crazy Penguin imzalı NShoptor. Çevrimdışı çalışan alışveriş planlayıcı. GPL-3.0 lisanslıdır.';

  @override
  String get startShoppingLabel => 'Alışverişi başlat';

  @override
  String get finishAndSeeResult => 'Bitir ve sonuca geç';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get languageLabel => 'Dil';

  @override
  String get languageSystem => 'Sistem';

  @override
  String get languageTr => 'Türkçe';

  @override
  String get languageEn => 'English';

  @override
  String get themeLabel => 'Tema';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get themeLight => 'Açık';

  @override
  String get themeDark => 'Koyu';

  @override
  String get defaultCurrencyLabel => 'Varsayılan para birimi';

  @override
  String get defaultUnitLabel => 'Varsayılan ölçü birimi';

  @override
  String get keepAwakeLabel => 'Alışveriş modunda ekranı açık tut';

  @override
  String get backupSection => 'Yedekleme';

  @override
  String get exportBackupLabel => 'Yedek dışa aktar';

  @override
  String get importBackupLabel => 'Yedek içe aktar';

  @override
  String get mergeImportLabel => 'Mevcut veriye birleştir';

  @override
  String get separateImportLabel => 'Ayrı kopya olarak içe aktar';

  @override
  String get importCancelled => 'İçe aktarma iptal edildi.';

  @override
  String get backupExported => 'Yedek başarıyla dışa aktarıldı.';

  @override
  String get deleteAllSection => 'Tehlikeli alan';

  @override
  String get deleteAllLabel => 'Tüm verileri sil';

  @override
  String get deleteAllConfirm =>
      'Bu, tüm listeleri, geçmişi, fişleri ve fiyatları siler. Dışa aktardığın dosyalar telefonunda kalır. Devam et?';

  @override
  String get deleteAllConfirm2 => 'Tamamen emin misin? Bu geri alınamaz.';

  @override
  String get cancelAction => 'Vazgeç';

  @override
  String get confirmDelete => 'Kalıcı olarak sil';

  @override
  String get dataDeleted => 'Tüm veriler silindi.';

  @override
  String get privacyInfoLabel => 'Gizlilik';

  @override
  String get privacyInfoBody =>
      'Listelerin, fiyatların, fişlerin ve fotoğrafların cihazında saklanır. Ses asla cihazdan çıkmaz. Yapay zekâ yardımı açıkken fiş ve fiyat etiketi fotoğrafları (küçültülmüş) ile sesli girdiğin ürünler gibi metinler yalnızca okunmak üzere sunucumuza gönderilir; anında işlenir ve asla saklanmaz.';

  @override
  String get aboutSection => 'Hakkında';

  @override
  String get aboutPublisher => 'Yayınlayıcı: Crazy Penguin';

  @override
  String get aboutLicenses => 'Lisanslar (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Sesli giriş';

  @override
  String get voiceStatusUnknown => 'Servis: kontrol edilmedi';

  @override
  String get permissionsLabel => 'İzinler';

  @override
  String get permissionsBody =>
      'Kamera, mikrofon ve bildirim izni yalnızca kullanım sırasında istenir. İzin reddedilirse uygulama çalışmaya devam eder.';

  @override
  String get unitsSection => 'Varsayılanlar';

  @override
  String get roundingNote =>
      'Parasal yuvarlama tek kurala uyar: yarım ve üzeri sıfırdan uzağa yuvarlanır, yalnızca Money dönüşümünde bir kez uygulanır.';

  @override
  String get voiceInputTitle => 'Sesle giriş';

  @override
  String get voiceStartListening => 'Dinlemeye başla';

  @override
  String get voiceTranscriptLabel => 'Transkript';

  @override
  String get parseAction => 'Ayrıştır';

  @override
  String get receiptReviewTitle => 'Fiş inceleme';

  @override
  String get receiptTotal => 'Fiş toplamı';

  @override
  String get receiptTotalUnknown => 'Toplam algılanmadı';

  @override
  String get receiptDiff => 'Fark';

  @override
  String get acceptLine => 'Satırı kabul et';

  @override
  String get ignoreLine => 'Satırı yok say';

  @override
  String get receiptLineActions => 'Ürünle bağla, birleştir veya atla';

  @override
  String get receiptCommit => 'Tümünü onayla';

  @override
  String get receiptCommitted => 'Fiş uygulandı.';

  @override
  String get priceHistoryTitle => 'Fiyat geçmişi';

  @override
  String get noObservations => 'Bu ürün için henüz gözlem yok';

  @override
  String get templatesSection => 'Şablonlar';

  @override
  String get templateHint => 'Önceki alışverişten yeni plan oluştur';

  @override
  String get scanReceiptAction => 'Fiş okut';

  @override
  String get fromReceiptListButton => 'Fişten liste';

  @override
  String get shelfLabelAction => 'Raf etiketinden fiyat';

  @override
  String get priceCandidatesTitle => 'Fiyat adayları';

  @override
  String get noPriceCandidates => 'Fiyat bulunamadı; elle girin.';

  @override
  String get voiceUnavailable => 'Ses tanıma kullanılamıyor; elle girin.';

  @override
  String get linkToItem => 'Ürünle bağla';

  @override
  String get splitLine => 'İkiye ayır';

  @override
  String get mergeWithNext => 'Sonrakiyle birleştir';

  @override
  String get ocrNoText => 'Metin okunamadı; tekrar deneyin.';

  @override
  String get priceHistoryAction => 'Fiyat geçmişi';

  @override
  String get itemsEmptyTitle => 'Bu liste henüz boş';

  @override
  String get itemsEmptyBody =>
      'İlk ürününü ekle — mağazada gerçek fiyatları buradan gireceksin.';

  @override
  String get addItemTooltip => 'Ürün ekle';

  @override
  String get unitAdet => 'adet';

  @override
  String get unitKilogram => 'kg';

  @override
  String get unitGram => 'g';

  @override
  String get unitLitre => 'L';

  @override
  String get unitMililitre => 'ml';

  @override
  String get unitPaket => 'paket';

  @override
  String get unitKutu => 'kutu';

  @override
  String get unitSise => 'şişe';

  @override
  String get unitKavanoz => 'kavanoz';

  @override
  String get unitDemet => 'demet';

  @override
  String get unitDuzine => 'düzine';

  @override
  String get unitMetre => 'm';

  @override
  String get unitCustom => 'Özel';

  @override
  String get setReminderAction => 'Hatırlatma kur';

  @override
  String get reminderPermissionDenied =>
      'Hatırlatmalar için bildirim izni gerekir. Sistem ayarlarından açabilirsin.';

  @override
  String get reminderScheduled => 'Hatırlatma kuruldu.';

  @override
  String get reminderCancelled => 'Hatırlatma kaldırıldı.';

  @override
  String get reminderTitle => 'Alışveriş hatırlatması';

  @override
  String reminderBody(Object title) {
    return 'Listenin zamanı geldi: $title';
  }

  @override
  String get reminderPickDate => 'Tarih seç';

  @override
  String get reminderPickTime => 'Saat seç';

  @override
  String get itemDetailsSection => 'Ayrıntılar';

  @override
  String get priceOptionalHint => 'Çarşı Fiyatı (İsteğe bağlı)';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Planlanan: $total · $count ürün';
  }

  @override
  String get proActiveLabel => 'Pro etkin — teşekkürler!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Reklamsız · Yedeği dışa ve içe aktarma · Yıllık';

  @override
  String get proBenefitNoAds => 'Reklamsız kullanım';

  @override
  String get proBenefitBackup => 'Yedekleme (dışa/içe aktarma)';

  @override
  String aboutVersion(Object version) {
    return 'Sürüm $version';
  }

  @override
  String get navDiscover => 'Keşfet';

  @override
  String get shareAction => 'Uygulamayı paylaş';

  @override
  String get rateAction => 'Puan ver';

  @override
  String get aboutOpenRow => 'Hakkında ve açık kaynak';

  @override
  String get voiceAddItemAction => 'Sesle ekle';

  @override
  String get formatLocaleLabel => 'Sayı ve para biçimi';

  @override
  String get formatLocaleSystem =>
      'Cihaz biçimi (Latin rakamlar; diğerlerinde İngilizce)';

  @override
  String get formatLocaleTr => 'Türkçe (1.234,56)';

  @override
  String get formatLocaleEn => 'İngilizce (1,234.56)';

  @override
  String get aiToggleTitle => 'Yapay zekâ yardımı';

  @override
  String get aiToggleSubtitle =>
      'Fotoğraflardan fişleri ve fiyat etiketlerini okur, fişleri eşleştirir ve cümleleri listeye dönüştürür. Fotoğraflar yalnızca okunmak üzere gönderilir ve asla saklanmaz.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Bu ayın yapay zekâ hakkını kullandın ($used/$limit). Daha fazlası için yükselt ya da yapay zekâsız devam et.';
  }

  @override
  String get aiOffline => 'Bağlantı yok — yapay zekâsız devam ediliyor.';

  @override
  String get aiFailed =>
      'Yapay zekâ şu an kullanılamıyor — onsuz devam ediliyor.';

  @override
  String get aiSourceLabel => 'Yapay zekâ';

  @override
  String get deviceSourceLabel => 'Cihaz';

  @override
  String get quickListAction => 'Cümleyle ekle';

  @override
  String get quickListTitle => 'Hızlı liste';

  @override
  String get quickListHint =>
      'Örn: 1 kilo elma 20 lira, 2 ekmek, yarım kilo peynir';

  @override
  String get quickListConvert => 'Listeye dönüştür';

  @override
  String quickListAdd(int count) {
    return '$count ürünü ekle';
  }

  @override
  String get quickListEmpty =>
      'Ürün bulunamadı. Virgülle ayırarak yazmayı dene.';

  @override
  String get receiptAiMatched =>
      'Yapay zekâ fişi listenle eşleştirdi. Bağlantıları kontrol edip onayla.';

  @override
  String get receiptNeedsCheck => 'Bu eşleşmeyi kontrol et';

  @override
  String get receiptDiscountLine => 'İndirim';

  @override
  String get compareItem => 'Ürün';

  @override
  String get compareEstimated => 'Evdeki Fiyat';

  @override
  String get compareActual => 'Çarşıdaki Fiyat';

  @override
  String get compareDiff => 'Fark';

  @override
  String get compareTotal => 'Toplam';

  @override
  String get compareBudget => 'Bütçe';

  @override
  String get compareNotBought => 'alınmadı';

  @override
  String get compareUnplanned => 'plan dışı';

  @override
  String get pricierItems => 'Pahalı çıkanlar';

  @override
  String get cheaperItems => 'Ucuza aldıkların';

  @override
  String get compareAction => 'Karşılaştır';

  @override
  String get detailsSection => 'Ayrıntılar';

  @override
  String get spendingTitle => 'Harcamalar';

  @override
  String get spendingAction => 'Harcamalar';

  @override
  String get spendingMonthTotal => 'Bu ay';

  @override
  String get spendingWeekly => 'Haftalık harcama';

  @override
  String get spendingMonthly => 'Aylık harcama';

  @override
  String get monthlyLimitTitle => 'Aylık limit';

  @override
  String get monthlyLimitHelp =>
      'Alışverişe ayda ne kadar harcamak istiyorsun?';

  @override
  String get monthlyLimitRemove => 'Kaldır';

  @override
  String get monthlyLimitSet => 'Belirle';

  @override
  String get monthlyLimitChange => 'Değiştir';

  @override
  String get monthlyLimitNone =>
      'Ne kadar kaldığını görmek için aylık bir limit belirle.';

  @override
  String monthlyLimitOver(String amount) {
    return 'Limit $amount aşıldı';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return 'Bu ay $amount kaldı';
  }

  @override
  String get plansTitle => 'Planlar';

  @override
  String get plansHeadline => 'Yapay zekâyla daha akıllı alışveriş';

  @override
  String get plansSubhead =>
      'Fiş eşleştirme, raf etiketi ve cümleden liste. İstediğin zaman iptal et.';

  @override
  String get plansMonthly => 'Aylık';

  @override
  String get plansYearly => 'Yıllık';

  @override
  String get planFree => 'Ücretsiz';

  @override
  String get planFreePrice => 'Her zaman ücretsiz';

  @override
  String get planFreeAi => 'Ayda 10 yapay zekâ isteği';

  @override
  String get planFreeAds => 'Küçük banner reklam (ilk 7 gün reklamsız)';

  @override
  String get planCoreFeatures =>
      'Listeler, fiyatlar, fişler, harcama grafikleri';

  @override
  String get plansPerYear => '/ yıl';

  @override
  String get plansPerMonth => '/ ay';

  @override
  String get planTrial => 'Ücretsiz deneme';

  @override
  String get planProAi => 'Ayda 100 yapay zekâ isteği';

  @override
  String get planNoAds => 'Reklamsız';

  @override
  String get planBackup => 'Yedeği dışa ve içe aktarma';

  @override
  String get planMaxAi => 'Ayda 300 yapay zekâ isteği';

  @override
  String get planMaxFamily => 'Büyük aile alışverişleri için';

  @override
  String get plansStoreUnavailable => 'Mağazaya şu an ulaşılamıyor.';

  @override
  String get retryAction => 'Tekrar dene';

  @override
  String get plansPurchaseFailed =>
      'Satın alma tamamlanmadı. Lütfen tekrar dene.';

  @override
  String get plansRestore => 'Satın alımları geri yükle';

  @override
  String get plansLegal =>
      'Pro, iptal edilene kadar her yıl otomatik yenilenir ve her ay 100 YZ isteği içerir. Temel fiyat, geçerli vergiler hariç yıllık 1 ABD dolarıdır; satın almayı onaylamadan önce mağazada nihai yerel fiyatı ve vergileri kontrol edin. Aboneliğinizi Google Play üzerinden yönetebilir veya iptal edebilirsiniz.';

  @override
  String get planCurrent => 'Mevcut';

  @override
  String get planStartTrial => 'Ücretsiz denemeyi başlat';

  @override
  String get planChoose => 'Seç';

  @override
  String get plansAction => 'Planlar: Pro';

  @override
  String get assistantTitle => 'Asistan';

  @override
  String get assistantGreeting => 'Merhaba! Ne yapmak istiyorsun?';

  @override
  String get assistantNewList => 'Yeni liste';

  @override
  String get assistantVoiceList => 'Sesle liste';

  @override
  String get assistantTextList => 'Cümleden liste';

  @override
  String get assistantScanReceipt => 'Fiş okut';

  @override
  String get assistantSpending => 'Harcamalarım';

  @override
  String get assistantReceiptHint =>
      'Listeni aç ve fiş simgesine dokunarak fişini okut.';

  @override
  String get assistantToggleTitle => 'Asistanı göster';

  @override
  String get assistantToggleSubtitle => 'Sağ alttaki küçük yardımcı';

  @override
  String get scanPriceLabel => 'Fiyat etiketini okut';

  @override
  String get saveFailed =>
      'Kaydedilemedi. Değişikliklerin burada duruyor. Lütfen tekrar dene.';

  @override
  String get deleteItemConfirm =>
      'Bu ürünü ve kayıtlı alımlarını silmek istiyor musun?';

  @override
  String get clearPurchaseConfirm =>
      'Bu ürünün tikini ve kayıtlı alımlarını kaldırmak istiyor musun?';

  @override
  String get reportPdfAction => 'PDF raporunu kaydet';

  @override
  String get reportNotInvoice =>
      'Alışveriş özetidir, vergi faturası değildir. Vergi oranları bilinmiyor.';

  @override
  String get purchaseVisits => 'Alışveriş sayısı';

  @override
  String get purchaseInterval => 'Alımlar arası ortalama gün';

  @override
  String get purchasedQuantity => 'Satın alınan miktar';

  @override
  String get purchaseAnalyticsHint =>
      'Satın alımlar tüketimi ölçmez. Para ve birimler ayrı gösterilir.';

  @override
  String get receiptReplaces =>
      'Market fiyatı boş ürünler doldurulur. Önceden fiyatlı ürünler ayrı satın alma olarak eklenir.';

  @override
  String get receiptIncompleteHeader =>
      'Sonraki fotoğrafa mağaza, tarih, saat ve fiş numarasını dahil edin.';

  @override
  String get receiptIncompleteTail =>
      'Önceki fotoğrafla birkaç ortak ürün ve son toplam görünecek şekilde devamını çekin.';

  @override
  String get receiptContinuationRejected =>
      'Bu fotoğraf birleştirilemedi. Aynı fişin ortak ürünleri görünecek şekilde yeniden çekin.';

  @override
  String get receiptDraftSaved =>
      'Fiş taslak olarak kaydedildi. Daha sonra devam edebilirsiniz.';

  @override
  String get receiptContinueAction => 'Fişe devam et';

  @override
  String get receiptDraftsTitle => 'Yarım kalan fişler';

  @override
  String get receiptDuplicate => 'Bu fiş daha önce eklendi.';

  @override
  String get receiptTotalMismatch =>
      'Ürünler fiş toplamıyla uyuşmuyor. Fişin tamamının göründüğünü kontrol edin.';

  @override
  String get receiptSaveDraftAction => 'Sonra devam et';

  @override
  String get receiptResolveLines =>
      'Kaydetmeden önce her ürünü kabul edin veya yok sayın.';

  @override
  String get receiptPartialConfirm =>
      'Yalızca seçilen ürünler eklenecek. Fiş işlenmiş olarak kaydedilecek. Devam edilsin mi?';

  @override
  String get voiceUnsupportedLanguage =>
      'Bu cihazda bu dil için sesli giriş yok. Bunun yerine yazabilirsin.';

  @override
  String get voiceStopListening => 'Dinlemeyi durdur';

  @override
  String get keepAwakeFailed =>
      'Ekran açık tutulamadı. Lütfen yeniden deneyin.';

  @override
  String get purchaseHistoryHint =>
      'Tüm tamamlanan alışverişler. İadeler toplamdan düşülür. Tarihler alışverişin tamamlanmasını gösterir. Ortalama aralık için tek alışveriş yeterli değildir.';

  @override
  String get planLegacyRights =>
      'Mevcut Pro ve Max abonelikleri önceki aylık YZ haklarını korur.';

  @override
  String get csvExportAction => 'CSV dışa aktar';

  @override
  String get backupSizeWarning =>
      'JSON yalnız kayıtları içerir; fotoğraf dosyalarını içermez. İçe aktarma sınırı: 16 MB.';

  @override
  String get backupImportFailed =>
      'Bu yedek içe aktarılamadı. Verileriniz değiştirilmedi.';

  @override
  String get backupImported => 'Yedek başarıyla içe aktarıldı.';

  @override
  String backupPreviewCounts(Object entries, Object items, Object lists) {
    return '$lists liste · $items ürün · $entries satın alım';
  }

  @override
  String get voiceModelDownloading =>
      'Bu dil için ses modeli indiriliyor. Bir dakika sonra tekrar dene.';

  @override
  String get historyThisWeek => 'Bu hafta';

  @override
  String get historyProductsSection => 'Alınan ürünler';

  @override
  String get tipReceiptScan =>
      'Fiş tara: fişteki fiyatları listendeki ürünlerle eşleştirir';

  @override
  String get tipVoiceAdd =>
      'Birden çok ürünü sesle söyle; eklemeden önce kontrol et';

  @override
  String get tipShelfCamera => 'Raf etiketindeki fiyatı kamerayla oku';

  @override
  String get tipPlan => 'Planını gör; abone ol ya da yükselt';

  @override
  String get guideAddBody =>
      '+ ile ürün ekle. Planlanan fiyatı şimdi, çarşıdaki fiyatı kasada gir.';

  @override
  String get guideVoiceBody =>
      'Mikrofona dokun ve ürünleri söyle, örneğin: \'1 kilo elma, 1 ekmek\'.';

  @override
  String get guideReceiptBody =>
      'Fişi tara; fiyatlar listendeki ürünlerle eşleşsin.';

  @override
  String get guidePlanBody =>
      'Plan simgesine dokunarak planını gör, abone ol ya da yükselt.';

  @override
  String get guideNext => 'Tamam';

  @override
  String get guideDone => 'Başla';

  @override
  String get paletteLabel => 'Renk teması';

  @override
  String get paletteForest => 'Orman';

  @override
  String get paletteOcean => 'Okyanus';

  @override
  String get paletteSunset => 'Gün batımı';

  @override
  String get paletteLavender => 'Lavanta';

  @override
  String get darkBlackLabel => 'Koyu temada tam siyah';

  @override
  String get spendingOverview => 'Genel bakış';

  @override
  String get spendingThisYear => 'Bu yıl';

  @override
  String get spendingYearly => 'Yıllık harcama';

  @override
  String get productSpending => 'Ürünlere göre harcama';

  @override
  String get spanWeek => 'Hafta';

  @override
  String get spanMonth => 'Ay';

  @override
  String get spanYear => 'Yıl';

  @override
  String get weeklyLimitTitle => 'Haftalık limit';

  @override
  String get weeklyLimitHelp =>
      'Alışverişe haftada ne kadar harcamak istiyorsun?';

  @override
  String get weeklyLimitNone =>
      'Ne kadar kaldığını görmek için haftalık bir limit belirle.';

  @override
  String weeklyLimitLeft(String amount) {
    return 'Bu hafta $amount kaldı';
  }

  @override
  String get shoppingLimitTitle => 'Alışveriş başına limit';

  @override
  String get shoppingLimitHelp => 'Yeni listeler bu bütçeyle başlar.';

  @override
  String get shoppingLimitNone =>
      'Her yeni alışveriş için varsayılan bir bütçe belirle.';

  @override
  String get monthlyReportAction => 'Aylık rapor';

  @override
  String get reportShoppingColumn => 'Alışveriş';

  @override
  String get reportDateColumn => 'Tarih';

  @override
  String get planUnavailable => 'Şu an mağazada yok';

  @override
  String get demoDataTitle => 'Örnek veriler';

  @override
  String get demoDataLoad => 'Örnek verilerle dene';

  @override
  String get demoDataLoadHelp =>
      'Geçmişi, grafikleri ve fiyat geçmişini görmek için 12 aylık örnek alışveriş ekler.';

  @override
  String get demoDataRemove => 'Örnek verileri sil';

  @override
  String get demoDataAdded => 'Örnek veriler eklendi';

  @override
  String get demoDataRemoved => 'Örnek veriler silindi';

  @override
  String get demoProductApple => 'Elma';

  @override
  String get demoProductBread => 'Ekmek';

  @override
  String get demoProductMilk => 'Süt';

  @override
  String get demoProductCheese => 'Peynir';

  @override
  String get demoProductTomato => 'Domates';

  @override
  String get demoProductEggs => 'Yumurta';

  @override
  String get demoProductCoffee => 'Kahve';

  @override
  String get demoProductDetergent => 'Deterjan';

  @override
  String get sendAction => 'Gönder';

  @override
  String get previousMonthAction => 'Önceki ay';

  @override
  String get nextMonthAction => 'Sonraki ay';

  @override
  String get helpSection => 'Yardım ve destek';

  @override
  String get howToUseLabel => 'Nasıl kullanılır?';

  @override
  String get guidePricesBody =>
      'Market fiyatı girilince ürün tiklenir; 0 da geçerlidir. Evdeki fiyat isteğe bağlıdır. Market fiyatını silince tik kalkar.';

  @override
  String get shoppingDateLabel => 'Alışveriş tarihi';

  @override
  String get shoppingDateNone => 'Tarih belirlenmedi';

  @override
  String get clearShoppingDateAction => 'Tarihi kaldır';

  @override
  String get listSortLabel => 'Liste sıralaması';

  @override
  String get listSortDate => 'Alışveriş tarihine göre';

  @override
  String get listSortAz => 'Ada göre (A–Z)';

  @override
  String get listSortManual => 'Elle sırala';

  @override
  String get imageCameraAction => 'Fotoğraf çek';

  @override
  String get imageGalleryAction => 'Fotoğraflardan seç';

  @override
  String get imageCaptureFailed =>
      'Kamera veya fotoğraflar açılamadı. Erişim iznini kontrol edip tekrar deneyin.';

  @override
  String get imageRecognitionFailed =>
      'Fotoğraf işlenemedi. Başka bir fotoğraf deneyin.';

  @override
  String get receiptNoProducts =>
      'Metin okundu ancak fiş ürünleri bulunamadı. Ürünleri ve toplamı fotoğrafa dahil edin.';

  @override
  String get keepAwakeOn => 'Ekran açık tutuluyor';

  @override
  String get keepAwakeOff => 'Ekran kapanabilir';

  @override
  String get spanDay => 'Gün';

  @override
  String get spanCustom => 'Tarih aralığı';

  @override
  String get reportTotalSpent => 'Toplam harcanan';

  @override
  String get reportAddedAt => 'Eklenme tarihi';

  @override
  String get reportReceiptNumber => 'Fiş numarası';

  @override
  String get reportPreview => 'Önizleme';

  @override
  String get reportShareAction => 'Paylaş';

  @override
  String get previousPeriodAction => 'Önceki dönem';

  @override
  String get nextPeriodAction => 'Sonraki dönem';

  @override
  String get reportSaved => 'Rapor kaydedildi.';

  @override
  String get reportZoom => 'Büyüt';

  @override
  String planTrialDaysLeft(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days gün kaldı',
    );
    return '$_temp0';
  }

  @override
  String planTrialHoursLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours saat kaldı',
    );
    return '$_temp0';
  }

  @override
  String get planTrialEndedTitle => 'Pro denemen sona erdi';

  @override
  String get planTrialEndedBody =>
      'Listeleri, elle giriş yapmayı ve cihazda çalışan ses özelliğini ücretsiz kullanmaya devam edebilirsin. Ücretsiz planda takvim ayı başına 10 yapay zekâ isteği bulunur. Ayda 100 yapay zekâ isteği, reklamsız kullanım ve yedekleme için yıllık Pro’yu seç. Mevcut verilerin sende kalır.';

  @override
  String get planContinueFree => 'Ücretsiz devam et';

  @override
  String get supportIdLabel => 'Destek kimliği';

  @override
  String get supportEmailLabel => 'E-posta ile destek';
}
