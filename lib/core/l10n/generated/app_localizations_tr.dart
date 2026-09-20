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
}
