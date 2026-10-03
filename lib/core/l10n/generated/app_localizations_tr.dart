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
  String get listsTabActive => 'Aktif';

  @override
  String get listsTabCompleted => 'Tamamlanan';

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
  String get backupSizeWarning =>
      'Büyük yedek: dosya büyük olabilir. Fotoğrafları da dahil mi etsin';

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
      'NShoptor çevrimdışı çalışır. Fişler ve fotoğraflar varsayılan olarak cihazında kalır; internette saklanmaz.';

  @override
  String get aboutSection => 'Hakkında';

  @override
  String get aboutPublisher => 'Yayınlayıcı: Crazy Penguin';

  @override
  String get aboutLicenses => 'Lisans: MIT';

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
  String get scanReceiptAction => 'Fiş tara';

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
  String get priceOptionalHint =>
      'İsteğe bağlı — mağazada gerçek fiyatı gireceksin';

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
      'Reklamsız kullanım + yedekleme · tek ödeme, abonelik yok';

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
}
