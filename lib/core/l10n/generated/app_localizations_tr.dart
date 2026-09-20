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
}
