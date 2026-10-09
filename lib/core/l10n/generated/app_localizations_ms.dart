// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class AppLocalizationsMs extends AppLocalizations {
  AppLocalizationsMs([String locale = 'ms']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Rancang di rumah. Beli ikut rancangan.';

  @override
  String get listsTitle => 'Senarai';

  @override
  String get listsTabActive => 'Aktif';

  @override
  String get listsTabCompleted => 'Selesai';

  @override
  String get listsTabArchived => 'Diarkibkan';

  @override
  String get newListButton => 'Senarai baru';

  @override
  String get listTitleHint => 'Tajuk (pilihan)';

  @override
  String get saveButton => 'Simpan';

  @override
  String get cancelButton => 'Batal';

  @override
  String get deleteButton => 'Padam';

  @override
  String get editAction => 'Sunting';

  @override
  String get listDeleted => 'Senarai dipadam';

  @override
  String get invalidAmountError => 'Jumlah tidak sah';

  @override
  String get duplicateAction => 'Salin';

  @override
  String get archiveAction => 'Arkibkan';

  @override
  String get unarchiveAction => 'Keluarkan dari arkib';

  @override
  String get deleteListConfirm =>
      'Padam senarai ini? Item yang dirancang juga akan dibuang.';

  @override
  String get undoButton => 'Buat asal';

  @override
  String get searchListHint => 'Cari senarai';

  @override
  String get currencyLabel => 'Mata wang';

  @override
  String get budgetLabel => 'Bajet (pilihan)';

  @override
  String get noteLabel => 'Nota (pilihan)';

  @override
  String get storeLabel => 'Kedai';

  @override
  String get keepAmountsAction => 'Kekalkan jumlah';

  @override
  String get resetAmountsAction => 'Set semula jumlah';

  @override
  String get currencyChangeWarning =>
      'Mata wang sedang ditukar. Apa yang perlu berlaku pada jumlah sedia ada?';

  @override
  String get listsEmpty =>
      'Belum ada senarai. Cipta pelan membeli-belah pertama anda.';

  @override
  String get statusDraft => 'Draf';

  @override
  String get statusPlanned => 'Dirancang';

  @override
  String get statusShopping => 'Membeli-belah';

  @override
  String get statusCompleted => 'Selesai';

  @override
  String get statusArchived => 'Diarkibkan';

  @override
  String autoListTitle(String date) {
    return 'membeli-belah $date';
  }

  @override
  String get itemFormTitle => 'Tambah item';

  @override
  String get itemNameLabel => 'Nama item';

  @override
  String get brandLabel => 'Jenama / varian (pilihan)';

  @override
  String get categoryLabel => 'Kategori';

  @override
  String get quantityLabel => 'Kuantiti';

  @override
  String get unitLabel => 'Unit';

  @override
  String get pricingModeLabel => 'Cara masukkan harga';

  @override
  String get pricingModeUnitPrice => 'Harga per unit';

  @override
  String get pricingModeLineTotal => 'Jumlah baris';

  @override
  String get plannedPriceLabel => 'Harga dirancang';

  @override
  String lineTotalCalculated(String value) {
    return 'Jumlah baris: $value';
  }

  @override
  String get requiredItemToggle => 'Item wajib';

  @override
  String get maxPriceLabel => 'Harga maksimum yang diterima (pilihan)';

  @override
  String get itemNoteLabel => 'Nota (pilihan)';

  @override
  String get categoryProduce => 'Buah & sayur';

  @override
  String get categoryDairy => 'Susu';

  @override
  String get categoryMeat => 'Daging';

  @override
  String get categoryBakery => 'Bakar';

  @override
  String get categoryDrinks => 'Minuman';

  @override
  String get categoryCleaning => 'Pembersihan';

  @override
  String get categoryPersonalCare => 'Penjagaan diri';

  @override
  String get categoryHome => 'Rumah';

  @override
  String get categoryOther => 'Lain-lain';

  @override
  String get invalidQuantityError => 'Kuantiti tidak sah';

  @override
  String get invalidPriceError => 'Harga tidak sah';

  @override
  String get invalidNameError => 'Masukkan nama';

  @override
  String unitPriceCalculated(String value) {
    return 'Harga unit: $value';
  }

  @override
  String get shoppingTitle => 'Mod membeli-belah';

  @override
  String get summaryPlannedTotal => 'Perancangan';

  @override
  String get summaryInCart => 'Dalam troli';

  @override
  String get summaryRemainingPlan => 'Rancangan baki';

  @override
  String get summaryProjected => 'Anggaran checkout';

  @override
  String get summaryBudgetRemaining => 'Baki bajet';

  @override
  String get summaryBudgetOver => 'Melebihi bajet';

  @override
  String itemsProgress(String done, String total) {
    return '$done daripada $total item';
  }

  @override
  String get filterAll => 'Semua';

  @override
  String get filterToBuy => 'Untuk dibeli';

  @override
  String get filterInCart => 'Dalam troli';

  @override
  String get filterNotFound => 'Tidak ditemui';

  @override
  String get filterRequired => 'Diperlukan';

  @override
  String get quickEntryTitle => 'Harga sebenar';

  @override
  String get actualQuantityLabel => 'Kuantiti sebenar';

  @override
  String get actualPriceLabel => 'Harga sebenar';

  @override
  String get discountLabel => 'Diskaun (pilihan)';

  @override
  String get alternativeNameLabel => 'Nama produk alternatif (pilihan)';

  @override
  String get savePurchaseButton => 'Tambah ke troli';

  @override
  String get unplannedAddButton => 'Tambah item tanpa perancangan';

  @override
  String get statusPending => 'Belum diambil';

  @override
  String get statusInCart => 'Dalam troli';

  @override
  String get statusNotFound => 'Tidak ditemui';

  @override
  String get statusGaveUp => 'Berhenti mencari';

  @override
  String get statusAlternative => 'Alternatif dibeli';

  @override
  String get keepScreenAwake => 'Kekalkan skrin hidup';

  @override
  String get finishShopping => 'Selesai membeli-belah';

  @override
  String get completionWarning =>
      'Terdapat rekod yang hilang atau belum disahkan. Anda masih boleh menyiapkan; keputusan akan mencatatkannya.';

  @override
  String get continueShoppingButton => 'Teruskan membeli-belah';

  @override
  String get resultTitle => 'Keputusan';

  @override
  String get summarySection => 'Ringkasan';

  @override
  String get plannedTotalLabel => 'Jumlah perancangan';

  @override
  String get actualTotalLabel => 'Jumlah sebenar';

  @override
  String get varianceLabel => 'Perbezaan';

  @override
  String get varianceNotComputable => 'Tidak dapat dikira';

  @override
  String get budgetStatusLabel => 'Bajet';

  @override
  String get savingsLabel => 'Di bawah rancangan';

  @override
  String get overspendLabel => 'Melebihi rancangan';

  @override
  String get unplannedTotalLabel => 'Jumlah tanpa perancangan';

  @override
  String get unpurchasedLabel => 'Direka tetapi tidak dibeli';

  @override
  String get totalDiscountLabel => 'Jumlah diskaun';

  @override
  String get accuracyLabel => 'Ketepatan anggaran';

  @override
  String get groupsSection => 'Item';

  @override
  String get groupPricier => 'Lebih mahal berbanding rancangan';

  @override
  String get groupCheaper => 'Lebih murah berbanding rancangan';

  @override
  String get groupClose => 'Hampir dengan anggaran';

  @override
  String get groupNotTaken => 'Direka, tidak dibeli';

  @override
  String get groupUnplanned => 'Dibeli tanpa perancangan';

  @override
  String get groupQuantityChanged => 'Kuantiti berubah';

  @override
  String get groupUnverified => 'Tidak disahkan';

  @override
  String get plannedQtyLabel => 'Kuantiti dirancang';

  @override
  String get actualQtyLabel => 'Kuantiti sebenar';

  @override
  String get plannedUnitPriceLabel => 'Harga unit dirancang';

  @override
  String get actualUnitPriceLabel => 'Harga unit sebenar';

  @override
  String get lineVarianceLabel => 'Perbezaan baris';

  @override
  String get discountEffectLabel => 'Kesan diskaun';

  @override
  String get notBoughtMark => 'tidak dibeli';

  @override
  String get noPurchasesNote => 'Tiada pembelian direkodkan.';

  @override
  String get navHome => 'Utama';

  @override
  String get navLists => 'Senarai';

  @override
  String get navHistory => 'Sejarah';

  @override
  String get navSettings => 'Tetapan';

  @override
  String get homeEmptyTitle => 'Rancang pembelian anda';

  @override
  String get homeEmptyBody =>
      'Cipta senarai pertama anda dan bandingkan kos yang dirancang vs sebenar.';

  @override
  String get homeActiveSection => 'Senarai aktif';

  @override
  String get homeCompletedSection => 'Baru-baru ini selesai';

  @override
  String get homeMonthlySection => 'Bulan ini';

  @override
  String get monthPlannedLabel => 'Dijangka';

  @override
  String get monthActualLabel => 'Sebenar';

  @override
  String get monthVarianceLabel => 'Perbezaan';

  @override
  String get continueShoppingLabel => 'Teruskan membeli-belah';

  @override
  String get historyEmpty =>
      'Belum ada pembelian selesai. Sejarah dan pandangan anda akan muncul di sini.';

  @override
  String get aboutTabTitle => 'Mengenai NShoptor';

  @override
  String get aboutBody =>
      'NShoptor oleh Crazy Penguin. Perancang pembelian luar talian. Dilesenkan di bawah GPL-3.0.';

  @override
  String get startShoppingLabel => 'Mula membeli-belah';

  @override
  String get finishAndSeeResult => 'Selesai & lihat hasil';

  @override
  String get settingsTitle => 'Tetapan';

  @override
  String get languageLabel => 'Bahasa';

  @override
  String get languageSystem => 'Sistem';

  @override
  String get languageTr => 'Turki';

  @override
  String get languageEn => 'Inggeris';

  @override
  String get themeLabel => 'Tema';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get themeLight => 'Cerah';

  @override
  String get themeDark => 'Gelap';

  @override
  String get defaultCurrencyLabel => 'Wang mata wang lalai';

  @override
  String get defaultUnitLabel => 'Unit lalai';

  @override
  String get keepAwakeLabel => 'Kekalkan skrin menyala semasa membeli-belah';

  @override
  String get backupSection => 'Sandaran';

  @override
  String get exportBackupLabel => 'Eksport sandaran';

  @override
  String get importBackupLabel => 'Import sandaran';

  @override
  String get mergeImportLabel => 'Gabungkan ke dalam data semasa';

  @override
  String get separateImportLabel => 'Import sebagai salinan berasingan';

  @override
  String get importCancelled => 'Import dibatalkan.';

  @override
  String get backupExported => 'Sandaran berjaya dieksport.';

  @override
  String get backupSizeWarning =>
      'Sandaran besar: fail mungkin besar. Adakah anda mahu termasuk foto juga?';

  @override
  String get deleteAllSection => 'Zon bahaya';

  @override
  String get deleteAllLabel => 'Padam semua data';

  @override
  String get deleteAllConfirm =>
      'Ini akan membuang semua senarai, sejarah, foto resit dan harga. Fail yang dieksport oleh anda kekal pada pemacu anda. Teruskan?';

  @override
  String get deleteAllConfirm2 =>
      'Adakah anda benar-benar pasti? Tindakan ini tidak boleh dibatalkan.';

  @override
  String get cancelAction => 'Batal';

  @override
  String get confirmDelete => 'Padam secara kekal';

  @override
  String get dataDeleted => 'Semua data tempatan telah dipadam.';

  @override
  String get privacyInfoLabel => 'Privasi';

  @override
  String get privacyInfoBody =>
      'Senarai, harga, resit dan foto anda kekal pada peranti anda. Foto dan suara tidak pernah keluar daripadanya. Apabila bantuan AI diaktifkan, hanya teks (contohnya baris resit atau apa yang anda ucapkan) dihantar ke pelayan kami untuk diproses dan tidak disimpan.';

  @override
  String get aboutSection => 'Mengenai';

  @override
  String get aboutPublisher => 'Penerbit: Crazy Penguin';

  @override
  String get aboutLicenses => 'Lesen (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Input suara';

  @override
  String get voiceStatusUnknown => 'Perkhidmatan: belum disemak';

  @override
  String get permissionsLabel => 'Kebenaran';

  @override
  String get permissionsBody =>
      'Kamera, mikrofon dan notifikasi dimohon hanya apabila anda sebenarnya menggunakan ciri-ciri tersebut.';

  @override
  String get unitsSection => 'Lalai';

  @override
  String get roundingNote =>
      'Pembundaran wang mengikut satu peraturan: separuh dibundarkan menjauhi sifar, digunakan sekali pada penukaran Wang.';

  @override
  String get voiceInputTitle => 'Input suara';

  @override
  String get voiceStartListening => 'Mula mendengar';

  @override
  String get voiceTranscriptLabel => 'Transkrip';

  @override
  String get parseAction => 'Huraikan';

  @override
  String get receiptReviewTitle => 'Semak resit';

  @override
  String get receiptTotal => 'Jumlah resit';

  @override
  String get receiptTotalUnknown => 'Jumlah tidak dikesan';

  @override
  String get receiptDiff => 'Perbezaan';

  @override
  String get acceptLine => 'Terima baris';

  @override
  String get ignoreLine => 'Abaikan baris';

  @override
  String get receiptLineActions => 'Paut ke item, bahagi atau abaikan';

  @override
  String get receiptCommit => 'Terima semua';

  @override
  String get receiptCommitted => 'Resit telah digunakan.';

  @override
  String get priceHistoryTitle => 'Sejarah harga';

  @override
  String get noObservations => 'Tiada pemerhatian harga lagi';

  @override
  String get templatesSection => 'Templat';

  @override
  String get templateHint =>
      'Cipta pelan baru daripada perjalanan membeli-belah sebelumnya';

  @override
  String get scanReceiptAction => 'Imbas resit';

  @override
  String get shelfLabelAction => 'Harga dari label rak';

  @override
  String get priceCandidatesTitle => 'Kandidat harga';

  @override
  String get noPriceCandidates =>
      'Tiada harga ditemui; masukkan secara manual.';

  @override
  String get voiceUnavailable =>
      'Pengecaman suara tidak tersedia; masukkan secara manual.';

  @override
  String get linkToItem => 'Paut ke item';

  @override
  String get splitLine => 'Bahagikan kepada dua';

  @override
  String get mergeWithNext => 'Gabung dengan seterusnya';

  @override
  String get ocrNoText => 'Tiada teks dibaca; cuba lagi.';

  @override
  String get priceHistoryAction => 'Sejarah harga';

  @override
  String get itemsEmptyTitle => 'Tiada item lagi';

  @override
  String get itemsEmptyBody =>
      'Tambah item pertama anda — anda akan memasukkan harga sebenar di sini semasa di kedai.';

  @override
  String get addItemTooltip => 'Tambah item';

  @override
  String get unitAdet => 'pcs';

  @override
  String get unitKilogram => 'kg';

  @override
  String get unitGram => 'g';

  @override
  String get unitLitre => 'L';

  @override
  String get unitMililitre => 'ml';

  @override
  String get unitPaket => 'pek';

  @override
  String get unitKutu => 'kotak';

  @override
  String get unitSise => 'botol';

  @override
  String get unitKavanoz => 'balang';

  @override
  String get unitDemet => 'ikat';

  @override
  String get unitDuzine => 'dus';

  @override
  String get unitMetre => 'm';

  @override
  String get unitCustom => 'Tersuai';

  @override
  String get setReminderAction => 'Tetapkan peringatan';

  @override
  String get reminderPermissionDenied =>
      'Kebenaran pemberitahuan diperlukan untuk peringatan. Anda boleh membolehkannya dalam tetapan sistem.';

  @override
  String get reminderScheduled => 'Peringatan ditetapkan.';

  @override
  String get reminderCancelled => 'Peringatan dibuang.';

  @override
  String get reminderTitle => 'Peringatan membeli-belah';

  @override
  String reminderBody(Object title) {
    return 'Masa untuk menyemak senarai anda: $title';
  }

  @override
  String get reminderPickDate => 'Pilih tarikh';

  @override
  String get reminderPickTime => 'Pilih masa';

  @override
  String get itemDetailsSection => 'Butiran';

  @override
  String get priceOptionalHint =>
      'Pilihan — anda akan memasukkan harga sebenar di kedai';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Rancangan: $total · $count item';
  }

  @override
  String get proActiveLabel => 'Pro aktif — terima kasih!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Tiada iklan, lebih AI, sandaran · bermula dari harga bulanan kecil';

  @override
  String get proBenefitNoAds => 'Pengalaman tanpa iklan';

  @override
  String get proBenefitBackup => 'Sandaran (eksport/import)';

  @override
  String aboutVersion(Object version) {
    return 'Versi $version';
  }

  @override
  String get navDiscover => 'Temui';

  @override
  String get shareAction => 'Kongsi aplikasi';

  @override
  String get rateAction => 'Beri kami penilaian';

  @override
  String get aboutOpenRow => 'Mengenai & sumber terbuka';

  @override
  String get voiceAddItemAction => 'Tambah melalui suara';

  @override
  String get formatLocaleLabel => 'Format nombor & mata wang';

  @override
  String get formatLocaleSystem => 'Sistem (mengikuti bahasa aplikasi)';

  @override
  String get formatLocaleTr => 'Turki (1.234,56)';

  @override
  String get formatLocaleEn => 'Inggeris (1,234.56)';

  @override
  String get aiToggleTitle => 'Bantuan AI';

  @override
  String get aiToggleSubtitle =>
      'Padankan resit, baca label harga dan tukar ayat menjadi senarai. Foto dan suara kekal pada peranti anda; hanya teks diproses.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Anda telah menggunakan permintaan AI bulanan ($used/$limit). Naik taraf untuk lebih banyak, atau teruskan tanpa AI.';
  }

  @override
  String get aiOffline => 'Tiada sambungan — meneruskan tanpa AI.';

  @override
  String get aiFailed => 'AI tidak tersedia sekarang — meneruskan tanpanya.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'Peranti';

  @override
  String get quickListAction => 'Tambah dari ayat';

  @override
  String get quickListTitle => 'Senarai pantas';

  @override
  String get quickListHint => 'cth. 1 kg epal 20, 2 roti, separuh kilo keju';

  @override
  String get quickListConvert => 'Tukar menjadi senarai';

  @override
  String quickListAdd(int count) {
    return 'Tambah $count item';
  }

  @override
  String get quickListEmpty =>
      'Tiada item ditemui. Cuba senaraikan dengan koma.';

  @override
  String get receiptAiMatched =>
      'AI telah memadankan resit dengan senarai anda. Semak pautan dan sahkan.';

  @override
  String get receiptNeedsCheck => 'Semak padanan ini';

  @override
  String get receiptDiscountLine => 'Diskaun';

  @override
  String get compareItem => 'Item';

  @override
  String get compareEstimated => 'Anggaran';

  @override
  String get compareActual => 'Sebenarnya';

  @override
  String get compareDiff => 'Perbezaan';

  @override
  String get compareTotal => 'Jumlah';

  @override
  String get compareBudget => 'Belanjawan';

  @override
  String get compareNotBought => 'tidak dibeli';

  @override
  String get compareUnplanned => 'tidak dirancang';

  @override
  String get pricierItems => 'Lebih mahal';

  @override
  String get cheaperItems => 'Lebih murah';

  @override
  String get compareAction => 'Bandingkan';

  @override
  String get detailsSection => 'Butiran';

  @override
  String get spendingTitle => 'Perbelanjaan';

  @override
  String get spendingAction => 'Perbelanjaan';

  @override
  String get spendingMonthTotal => 'Bulan ini';

  @override
  String get spendingWeekly => 'Perbelanjaan mingguan';

  @override
  String get spendingMonthly => 'Perbelanjaan bulanan';

  @override
  String get monthlyLimitTitle => 'Had bulanan';

  @override
  String get monthlyLimitHelp =>
      'Berapa yang ingin anda belanjakan untuk membeli-belah setiap bulan?';

  @override
  String get monthlyLimitRemove => 'Buang';

  @override
  String get monthlyLimitSet => 'Tetapkan';

  @override
  String get monthlyLimitChange => 'Tukar';

  @override
  String get monthlyLimitNone =>
      'Tetapkan had bulanan untuk melihat baki anda.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount melebihi had';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return '$amount tinggal bulan ini';
  }

  @override
  String get plansTitle => 'Pakej';

  @override
  String get plansHeadline => 'Beli-belah lebih bijak dengan AI';

  @override
  String get plansSubhead =>
      'Padanan resit, label harga dan senarai dari ayat. Boleh batalkan bila-bila masa.';

  @override
  String get plansMonthly => 'Bulanan';

  @override
  String get plansYearly => 'Tahunan';

  @override
  String get planFree => 'Percuma';

  @override
  String get planFreePrice => 'Selamanya percuma';

  @override
  String get planFreeAi => '15 permintaan AI sebulan';

  @override
  String get planFreeAds =>
      'Iklan banner kecil (tiada dalam 7 hari pertama anda)';

  @override
  String get planCoreFeatures => 'Senarai, harga, resit, carta perbelanjaan';

  @override
  String get plansPerYear => '/ tahun';

  @override
  String get plansPerMonth => '/ bulan';

  @override
  String get planTrial => '7 hari percuma';

  @override
  String get planProAi => '200 permintaan AI sebulan';

  @override
  String get planNoAds => 'Tiada iklan';

  @override
  String get planBackup => 'Eksport dan import sandaran';

  @override
  String get planMaxAi => '1000 permintaan AI sebulan';

  @override
  String get planMaxFamily => 'Untuk membeli-belah keluarga besar';

  @override
  String get plansStoreUnavailable =>
      'Kedai tidak dapat dicapai buat masa ini.';

  @override
  String get retryAction => 'Cuba lagi';

  @override
  String get plansPurchaseFailed => 'Pembelian gagal. Sila cuba lagi.';

  @override
  String get planLifetimeTitle => 'Bebas iklan selamanya';

  @override
  String get planLifetimeSubtitle =>
      'Bayaran sekali: tiada iklan, sandaran; AI kekal pada had percuma';

  @override
  String get plansRestore => 'Pulangkan pembelian';

  @override
  String get plansLegal =>
      'Langganan akan diperbaharui secara automatik sehingga dibatalkan. Boleh mana-mana masa di Google Play › Pembayaran & langganan. Harga termasuk cukai yang ditunjukkan oleh Google Play.';

  @override
  String get planCurrent => 'Semasa';

  @override
  String get planStartTrial => 'Mula percubaan percuma 7 hari';

  @override
  String get planChoose => 'Pilih';

  @override
  String get plansAction => 'Pelan: Pro dan Max';

  @override
  String get assistantTitle => 'Pembantu';

  @override
  String get assistantGreeting => 'Hai! Apa yang anda ingin lakukan?';

  @override
  String get assistantNewList => 'Senarai baru';

  @override
  String get assistantVoiceList => 'Senarai melalui suara';

  @override
  String get assistantTextList => 'Senarai daripada ayat';

  @override
  String get assistantScanReceipt => 'Imbas resit';

  @override
  String get assistantSpending => 'Perbelanjaan saya';

  @override
  String get assistantReceiptHint =>
      'Buka senarai anda dan ketik ikon resit untuk mengimbasnya.';

  @override
  String get assistantToggleTitle => 'Tunjukkan pembantu';

  @override
  String get assistantToggleSubtitle => 'Pembantu kecil di kanan bawah';

  @override
  String get scanPriceLabel => 'Imbas label harga';

  @override
  String get saveFailed =>
      'Gagal menyimpan. Perubahan anda masih ada. Sila cuba lagi.';

  @override
  String get deleteItemConfirm =>
      'Padam item ini dan pembelian yang direkodkan?';

  @override
  String get clearPurchaseConfirm =>
      'Nyahtanda item ini dan buang pembelian yang direkodkan?';

  @override
  String get reportPdfAction => 'Simpan laporan PDF';

  @override
  String get reportNotInvoice =>
      'Ringkasan membeli-belah, bukan invois cukai. Kadar cukai tidak diketahui.';

  @override
  String get purchaseVisits => 'Kunjungan membeli-belah';

  @override
  String get purchaseInterval => 'Purata hari antara pembelian';

  @override
  String get purchasedQuantity => 'Kuantiti dibeli';

  @override
  String get purchaseAnalyticsHint =>
      'Pembelian tidak mengukur penggunaan. Mata wang dan unit dipaparkan secara berasingan.';

  @override
  String get receiptReplaces =>
      'Baris resit yang disambungkan menggantikan pembelian sedia ada; baris yang tidak disambungkan akan ditambah.';

  @override
  String get voiceUnsupportedLanguage =>
      'Bahasa ini tidak tersedia untuk input suara pada peranti ini. Anda boleh menaip sebagai gantinya.';
}
