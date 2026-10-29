// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Rencanakan di rumah. Belanja sesuai rencana.';

  @override
  String get listsTitle => 'Daftar';

  @override
  String get listsTabActive => 'Aktif';

  @override
  String get listsTabCompleted => 'Selesai';

  @override
  String get listsTabArchived => 'Arsip';

  @override
  String get newListButton => 'Daftar baru';

  @override
  String get listTitleHint => 'Judul (opsional)';

  @override
  String get saveButton => 'Simpan';

  @override
  String get cancelButton => 'Batal';

  @override
  String get deleteButton => 'Hapus';

  @override
  String get editAction => 'Edit';

  @override
  String get listDeleted => 'Daftar dihapus';

  @override
  String get invalidAmountError => 'Jumlah tidak valid';

  @override
  String get duplicateAction => 'Duplikat';

  @override
  String get archiveAction => 'Arsipkan';

  @override
  String get unarchiveAction => 'Buka arsip';

  @override
  String get deleteListConfirm =>
      'Hapus daftar ini? Item yang direncanakan juga akan dihapus.';

  @override
  String get undoButton => 'Urungkan';

  @override
  String get searchListHint => 'Cari daftar';

  @override
  String get currencyLabel => 'Mata uang';

  @override
  String get budgetLabel => 'Anggaran (opsional)';

  @override
  String get noteLabel => 'Catatan (opsional)';

  @override
  String get storeLabel => 'Toko';

  @override
  String get keepAmountsAction => 'Pertahankan jumlah';

  @override
  String get resetAmountsAction => 'Atur ulang jumlah';

  @override
  String get currencyChangeWarning =>
      'Mata uang berubah. Apa yang harus terjadi pada jumlah yang sudah ada?';

  @override
  String get listsEmpty => 'Belum ada daftar. Buat rencana belanja pertamamu.';

  @override
  String get statusDraft => 'Draf';

  @override
  String get statusPlanned => 'Direncanakan';

  @override
  String get statusShopping => 'Berbelanja';

  @override
  String get statusCompleted => 'Selesai';

  @override
  String get statusArchived => 'Diarsipkan';

  @override
  String autoListTitle(String date) {
    return 'Belanja $date';
  }

  @override
  String get itemFormTitle => 'Tambah item';

  @override
  String get itemNameLabel => 'Nama item';

  @override
  String get brandLabel => 'Merek / varian (opsional)';

  @override
  String get categoryLabel => 'Kategori';

  @override
  String get quantityLabel => 'Jumlah';

  @override
  String get unitLabel => 'Satuan';

  @override
  String get pricingModeLabel => 'Masuk harga';

  @override
  String get pricingModeUnitPrice => 'Harga satuan';

  @override
  String get pricingModeLineTotal => 'Total baris';

  @override
  String get plannedPriceLabel => 'Harga rencana';

  @override
  String lineTotalCalculated(String value) {
    return 'Total baris: $value';
  }

  @override
  String get requiredItemToggle => 'Item wajib';

  @override
  String get maxPriceLabel => 'Harga maksimal yang dapat diterima (opsional)';

  @override
  String get itemNoteLabel => 'Catatan (opsional)';

  @override
  String get categoryProduce => 'Buah & sayur';

  @override
  String get categoryDairy => 'Produk susu';

  @override
  String get categoryMeat => 'Daging';

  @override
  String get categoryBakery => 'Roti & kue';

  @override
  String get categoryDrinks => 'Minuman';

  @override
  String get categoryCleaning => 'Pembersih';

  @override
  String get categoryPersonalCare => 'Perawatan pribadi';

  @override
  String get categoryHome => 'Rumah tangga';

  @override
  String get categoryOther => 'Lainnya';

  @override
  String get invalidQuantityError => 'Jumlah tidak valid';

  @override
  String get invalidPriceError => 'Harga tidak valid';

  @override
  String get invalidNameError => 'Masukkan nama';

  @override
  String unitPriceCalculated(String value) {
    return 'Harga satuan: $value';
  }

  @override
  String get shoppingTitle => 'Mode belanja';

  @override
  String get summaryPlannedTotal => 'Direncanakan';

  @override
  String get summaryInCart => 'Dalam keranjang';

  @override
  String get summaryRemainingPlan => 'Sisa rencana';

  @override
  String get summaryProjected => 'Estimasi checkout';

  @override
  String get summaryBudgetRemaining => 'Sisa anggaran';

  @override
  String get summaryBudgetOver => 'Melebihi anggaran';

  @override
  String itemsProgress(String done, String total) {
    return '$done dari $total item';
  }

  @override
  String get filterAll => 'Semua';

  @override
  String get filterToBuy => 'Akan dibeli';

  @override
  String get filterInCart => 'Dalam keranjang';

  @override
  String get filterNotFound => 'Tidak ditemukan';

  @override
  String get filterRequired => 'Wajib';

  @override
  String get quickEntryTitle => 'Harga aktual';

  @override
  String get actualQuantityLabel => 'Jumlah aktual';

  @override
  String get actualPriceLabel => 'Harga aktual';

  @override
  String get discountLabel => 'Diskon (opsional)';

  @override
  String get alternativeNameLabel => 'Nama produk alternatif (opsional)';

  @override
  String get savePurchaseButton => 'Tambah ke keranjang';

  @override
  String get unplannedAddButton => 'Tambah item tanpa rencana';

  @override
  String get statusPending => 'Belum diambil';

  @override
  String get statusInCart => 'Dalam keranjang';

  @override
  String get statusNotFound => 'Tidak ditemukan';

  @override
  String get statusGaveUp => 'Ditinggalkan';

  @override
  String get statusAlternative => 'Alternatif dibeli';

  @override
  String get keepScreenAwake => 'Tetap nyalakan layar';

  @override
  String get finishShopping => 'Selesai belanja';

  @override
  String get completionWarning =>
      'Ada catatan yang hilang atau belum diverifikasi. Anda tetap bisa menyelesaikan; hasilnya akan mencatat hal tersebut.';

  @override
  String get continueShoppingButton => 'Lanjutkan belanja';

  @override
  String get resultTitle => 'Hasil';

  @override
  String get summarySection => 'Ringkasan';

  @override
  String get plannedTotalLabel => 'Total direncanakan';

  @override
  String get actualTotalLabel => 'Total aktual';

  @override
  String get varianceLabel => 'Selisih';

  @override
  String get varianceNotComputable => 'Tidak dapat dihitung';

  @override
  String get budgetStatusLabel => 'Anggaran';

  @override
  String get savingsLabel => 'Di bawah rencana';

  @override
  String get overspendLabel => 'Di atas rencana';

  @override
  String get unplannedTotalLabel => 'Total tanpa rencana';

  @override
  String get unpurchasedLabel => 'Direncanakan tapi tidak dibeli';

  @override
  String get totalDiscountLabel => 'Total diskon';

  @override
  String get accuracyLabel => 'Akurasi estimasi';

  @override
  String get groupsSection => 'Item';

  @override
  String get groupPricier => 'Lebih mahal dari rencana';

  @override
  String get groupCheaper => 'Lebih murah dari rencana';

  @override
  String get groupClose => 'Mendekati estimasi';

  @override
  String get groupNotTaken => 'Direncanakan, tidak dibeli';

  @override
  String get groupUnplanned => 'Dibeli tanpa rencana';

  @override
  String get groupQuantityChanged => 'Jumlah berubah';

  @override
  String get groupUnverified => 'Belum diverifikasi';

  @override
  String get plannedQtyLabel => 'Jumlah direncanakan';

  @override
  String get actualQtyLabel => 'Jumlah aktual';

  @override
  String get plannedUnitPriceLabel => 'Harga satuan direncanakan';

  @override
  String get actualUnitPriceLabel => 'Harga satuan aktual';

  @override
  String get lineVarianceLabel => 'Selisih per baris';

  @override
  String get discountEffectLabel => 'Efek diskon';

  @override
  String get notBoughtMark => 'tidak dibeli';

  @override
  String get noPurchasesNote => 'Tidak ada pembelian yang tercatat.';

  @override
  String get navHome => 'Beranda';

  @override
  String get navLists => 'Daftar';

  @override
  String get navHistory => 'Riwayat';

  @override
  String get navSettings => 'Pengaturan';

  @override
  String get homeEmptyTitle => 'Rencanakan belanja Anda';

  @override
  String get homeEmptyBody =>
      'Buat daftar pertama Anda dan bandingkan biaya yang direncanakan vs aktual.';

  @override
  String get homeActiveSection => 'Daftar aktif';

  @override
  String get homeCompletedSection => 'Baru saja selesai';

  @override
  String get homeMonthlySection => 'Bulan ini';

  @override
  String get monthPlannedLabel => 'Direncanakan';

  @override
  String get monthActualLabel => 'Aktual';

  @override
  String get monthVarianceLabel => 'Selisih';

  @override
  String get continueShoppingLabel => 'Lanjutkan belanja';

  @override
  String get historyEmpty =>
      'Belum ada belanja yang selesai. Riwayat dan wawasan Anda akan muncul di sini.';

  @override
  String get aboutTabTitle => 'Tentang NShoptor';

  @override
  String get aboutBody =>
      'NShoptor oleh Crazy Penguin. Perencana belanja offline-first. Berlisensi di bawah GPL-3.0.';

  @override
  String get startShoppingLabel => 'Mulai belanja';

  @override
  String get finishAndSeeResult => 'Selesai & lihat hasil';

  @override
  String get settingsTitle => 'Pengaturan';

  @override
  String get languageLabel => 'Bahasa';

  @override
  String get languageSystem => 'Sistem';

  @override
  String get languageTr => 'Turki';

  @override
  String get languageEn => 'Inggris';

  @override
  String get themeLabel => 'Tema';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get themeLight => 'Terang';

  @override
  String get themeDark => 'Gelap';

  @override
  String get defaultCurrencyLabel => 'Mata uang default';

  @override
  String get defaultUnitLabel => 'Satuan default';

  @override
  String get keepAwakeLabel => 'Tetap hidupkan layar saat belanja';

  @override
  String get backupSection => 'Cadangan';

  @override
  String get exportBackupLabel => 'Ekspor cadangan';

  @override
  String get importBackupLabel => 'Impor cadangan';

  @override
  String get mergeImportLabel => 'Gabungkan ke data saat ini';

  @override
  String get separateImportLabel => 'Impor sebagai salinan terpisah';

  @override
  String get importCancelled => 'Impor dibatalkan.';

  @override
  String get backupExported => 'Cadangan berhasil diekspor.';

  @override
  String get deleteAllSection => 'Zona bahaya';

  @override
  String get deleteAllLabel => 'Hapus semua data';

  @override
  String get deleteAllConfirm =>
      'Ini akan menghapus semua daftar, riwayat, foto struk, dan harga. File yang Anda ekspor tetap berada di drive Anda. Lanjutkan?';

  @override
  String get deleteAllConfirm2 =>
      'Apakah Anda benar-benar yakin? Tindakan ini tidak dapat dibatalkan.';

  @override
  String get cancelAction => 'Batal';

  @override
  String get confirmDelete => 'Hapus secara permanen';

  @override
  String get dataDeleted => 'Semua data lokal telah dihapus.';

  @override
  String get privacyInfoLabel => 'Privasi';

  @override
  String get privacyInfoBody =>
      'Daftar, harga, struk, dan foto Anda disimpan di perangkat Anda. Suara tidak pernah meninggalkannya. Saat bantuan AI aktif, foto struk dan label harga (ukurannya diperkecil) serta teks seperti item yang didiktekan dikirim ke server kami hanya untuk dibaca; semuanya langsung diproses dan tidak pernah disimpan.';

  @override
  String get aboutSection => 'Tentang';

  @override
  String get aboutPublisher => 'Penerbit: Crazy Penguin';

  @override
  String get aboutLicenses => 'Lisensi (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Input suara';

  @override
  String get voiceStatusUnknown => 'Layanan: belum diperiksa';

  @override
  String get permissionsLabel => 'Izin';

  @override
  String get permissionsBody =>
      'Kamera, mikrofon, dan notifikasi hanya diminta ketika Anda benar-benar menggunakan fitur tersebut.';

  @override
  String get unitsSection => 'Default';

  @override
  String get roundingNote =>
      'Pembulatan uang mengikuti satu aturan: setengah dibulatkan menjauhi nol, diterapkan sekali pada konversi Uang.';

  @override
  String get voiceInputTitle => 'Input suara';

  @override
  String get voiceStartListening => 'Mulai mendengarkan';

  @override
  String get voiceTranscriptLabel => 'Transkrip';

  @override
  String get parseAction => 'Analisis';

  @override
  String get receiptReviewTitle => 'Periksa struk';

  @override
  String get receiptTotal => 'Total struk';

  @override
  String get receiptTotalUnknown => 'Total tidak terdeteksi';

  @override
  String get receiptDiff => 'Selisih';

  @override
  String get acceptLine => 'Terima baris';

  @override
  String get ignoreLine => 'Abaikan baris';

  @override
  String get receiptLineActions => 'Tautkan ke item, bagi, atau abaikan';

  @override
  String get receiptCommit => 'Terima semua';

  @override
  String get receiptCommitted => 'Struk diterapkan.';

  @override
  String get priceHistoryTitle => 'Riwayat harga';

  @override
  String get noObservations => 'Belum ada pengamatan harga';

  @override
  String get templatesSection => 'Templat';

  @override
  String get templateHint =>
      'Buat rencana baru dari perjalanan belanja sebelumnya';

  @override
  String get scanReceiptAction => 'Pindai struk';

  @override
  String get fromReceiptListButton => 'Dari struk';

  @override
  String get shelfLabelAction => 'Harga dari label rak';

  @override
  String get priceCandidatesTitle => 'Kandidat harga';

  @override
  String get noPriceCandidates => 'Tidak ditemukan; masukkan secara manual.';

  @override
  String get voiceUnavailable =>
      'Pengenalan suara tidak tersedia; masukkan secara manual.';

  @override
  String get linkToItem => 'Tautkan ke item';

  @override
  String get splitLine => 'Bagi dua';

  @override
  String get mergeWithNext => 'Gabung dengan berikutnya';

  @override
  String get ocrNoText => 'Tidak ada teks terbaca; coba lagi.';

  @override
  String get priceHistoryAction => 'Riwayat harga';

  @override
  String get itemsEmptyTitle => 'Belum ada item';

  @override
  String get itemsEmptyBody =>
      'Tambahkan item pertama Anda — Anda akan memasukkan harga asli di sini saat berada di toko.';

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
  String get unitPaket => 'pack';

  @override
  String get unitKutu => 'box';

  @override
  String get unitSise => 'botol';

  @override
  String get unitKavanoz => 'toples';

  @override
  String get unitDemet => 'ikat';

  @override
  String get unitDuzine => 'lusin';

  @override
  String get unitMetre => 'm';

  @override
  String get unitCustom => 'Kustom';

  @override
  String get setReminderAction => 'Atur pengingat';

  @override
  String get reminderPermissionDenied =>
      'Izin notifikasi diperlukan untuk pengingat. Anda dapat mengaktifkannya di pengaturan sistem.';

  @override
  String get reminderScheduled => 'Pengingat diatur.';

  @override
  String get reminderCancelled => 'Pengingat dihapus.';

  @override
  String get reminderTitle => 'Pengingat belanja';

  @override
  String reminderBody(Object title) {
    return 'Saatnya periksa daftar Anda: $title';
  }

  @override
  String get reminderPickDate => 'Pilih tanggal';

  @override
  String get reminderPickTime => 'Pilih waktu';

  @override
  String get itemDetailsSection => 'Detail';

  @override
  String get priceOptionalHint =>
      'Opsional — Anda akan memasukkan harga asli di toko';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Direncanakan: $total · $count item';
  }

  @override
  String get proActiveLabel => 'Pro aktif — terima kasih!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Tanpa iklan · Cadangan, ekspor, dan impor · Tahunan';

  @override
  String get proBenefitNoAds => 'Pengalaman tanpa iklan';

  @override
  String get proBenefitBackup => 'Cadangan (ekspor/impor)';

  @override
  String aboutVersion(Object version) {
    return 'Versi $version';
  }

  @override
  String get navDiscover => 'Jelajahi';

  @override
  String get shareAction => 'Bagikan aplikasi';

  @override
  String get rateAction => 'Beri kami peringkat';

  @override
  String get aboutOpenRow => 'Tentang & sumber terbuka';

  @override
  String get voiceAddItemAction => 'Tambah via suara';

  @override
  String get formatLocaleLabel => 'Format angka & mata uang';

  @override
  String get formatLocaleSystem =>
      'Format perangkat (angka Latin; jika tidak, bahasa Inggris)';

  @override
  String get formatLocaleTr => 'Turki (1.234,56)';

  @override
  String get formatLocaleEn => 'Inggris (1,234.56)';

  @override
  String get aiToggleTitle => 'Bantuan AI';

  @override
  String get aiToggleSubtitle =>
      'Membaca struk dan label harga dari foto, mencocokkan struk, dan mengubah kalimat menjadi daftar. Foto dikirim hanya untuk dibaca dan tidak pernah disimpan.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Anda telah menggunakan permintaan AI bulan ini ($used/$limit). Tingkatkan untuk mendapatkan lebih banyak, atau lanjutkan tanpa AI.';
  }

  @override
  String get aiOffline => 'Tidak ada koneksi — melanjutkan tanpa AI.';

  @override
  String get aiFailed => 'AI tidak tersedia saat ini — melanjutkan tanpanya.';

  @override
  String get aiSourceLabel => 'AI';

  @override
  String get deviceSourceLabel => 'Perangkat';

  @override
  String get quickListAction => 'Tambah dari kalimat';

  @override
  String get quickListTitle => 'Daftar cepat';

  @override
  String get quickListHint => 'mis. 1 kg apel 20, 2 roti, setengah kilo keju';

  @override
  String get quickListConvert => 'Ubah menjadi daftar';

  @override
  String quickListAdd(int count) {
    return 'Tambah $count item';
  }

  @override
  String get quickListEmpty =>
      'Tidak ada item ditemukan. Coba daftarkan dengan dipisahkan koma.';

  @override
  String get receiptAiMatched =>
      'AI mencocokkan struk ke daftar Anda. Periksa tautan dan konfirmasi.';

  @override
  String get receiptNeedsCheck => 'Periksa pencocokan ini';

  @override
  String get receiptDiscountLine => 'Diskon';

  @override
  String get compareItem => 'Item';

  @override
  String get compareEstimated => 'Estimasi';

  @override
  String get compareActual => 'Aktual';

  @override
  String get compareDiff => 'Selisih';

  @override
  String get compareTotal => 'Total';

  @override
  String get compareBudget => 'Anggaran';

  @override
  String get compareNotBought => 'tidak dibeli';

  @override
  String get compareUnplanned => 'tidak direncanakan';

  @override
  String get pricierItems => 'Lebih mahal';

  @override
  String get cheaperItems => 'Lebih murah';

  @override
  String get compareAction => 'Bandingkan';

  @override
  String get detailsSection => 'Detail';

  @override
  String get spendingTitle => 'Pengeluaran';

  @override
  String get spendingAction => 'Pengeluaran';

  @override
  String get spendingMonthTotal => 'Bulan ini';

  @override
  String get spendingWeekly => 'Pengeluaran mingguan';

  @override
  String get spendingMonthly => 'Pengeluaran bulanan';

  @override
  String get monthlyLimitTitle => 'Batas bulanan';

  @override
  String get monthlyLimitHelp => 'Berapa yang ingin Anda belanjakan per bulan?';

  @override
  String get monthlyLimitRemove => 'Hapus';

  @override
  String get monthlyLimitSet => 'Atur';

  @override
  String get monthlyLimitChange => 'Ubah';

  @override
  String get monthlyLimitNone =>
      'Atur batas bulanan untuk melihat sisa anggaran Anda.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount melebihi batas';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return '$amount tersisa bulan ini';
  }

  @override
  String get plansTitle => 'Paket';

  @override
  String get plansHeadline => 'Belanja lebih cerdas dengan AI';

  @override
  String get plansSubhead =>
      'Pencocokan struk, label harga, dan daftar dari kalimat. Batalkan kapan saja.';

  @override
  String get plansMonthly => 'Bulanan';

  @override
  String get plansYearly => 'Tahunan';

  @override
  String get planFree => 'Gratis';

  @override
  String get planFreePrice => 'Gratis selamanya';

  @override
  String get planFreeAi => '10 permintaan AI per bulan';

  @override
  String get planFreeAds =>
      'Iklan banner kecil (tidak ada dalam 7 hari pertama Anda)';

  @override
  String get planCoreFeatures => 'Daftar, harga, struk, grafik pengeluaran';

  @override
  String get plansPerYear => '/ tahun';

  @override
  String get plansPerMonth => '/ bulan';

  @override
  String get planTrial => 'Uji coba gratis';

  @override
  String get planProAi => '100 permintaan AI per bulan';

  @override
  String get planNoAds => 'Tanpa iklan';

  @override
  String get planBackup => 'Cadangan, ekspor, dan impor';

  @override
  String get planMaxAi => '300 permintaan AI per bulan';

  @override
  String get planMaxFamily => 'Untuk belanja keluarga besar';

  @override
  String get plansStoreUnavailable =>
      'Toko sedang tidak dapat diakses saat ini.';

  @override
  String get retryAction => 'Coba lagi';

  @override
  String get plansPurchaseFailed => 'Pembelian gagal. Silakan coba lagi.';

  @override
  String get plansRestore => 'Pulihkan pembelian';

  @override
  String get plansLegal =>
      'Pro diperpanjang otomatis setiap tahun hingga dibatalkan dan mencakup 100 permintaan AI setiap bulan. Harga dasar adalah 1 dolar AS per tahun sebelum pajak yang berlaku; periksa harga lokal akhir dan pajak di toko sebelum mengonfirmasi pembelian. Kelola atau batalkan di Google Play.';

  @override
  String get planCurrent => 'Berlaku';

  @override
  String get planStartTrial => 'Mulai uji coba gratis';

  @override
  String get planChoose => 'Pilih';

  @override
  String get plansAction => 'Paket: Pro';

  @override
  String get assistantTitle => 'Asisten';

  @override
  String get assistantGreeting => 'Hai! Mau melakukan apa?';

  @override
  String get assistantNewList => 'Daftar baru';

  @override
  String get assistantVoiceList => 'Daftar lewat suara';

  @override
  String get assistantTextList => 'Daftar dari kalimat';

  @override
  String get assistantScanReceipt => 'Pindai struk';

  @override
  String get assistantSpending => 'Pengeluaranku';

  @override
  String get assistantReceiptHint =>
      'Buka daftar kamu dan ketuk ikon struk untuk memindainya.';

  @override
  String get assistantToggleTitle => 'Tampilkan asisten';

  @override
  String get assistantToggleSubtitle => 'Si kecil pembantu di kanan bawah';

  @override
  String get scanPriceLabel => 'Pindai label harga';

  @override
  String get saveFailed =>
      'Gagal menyimpan. Perubahan Anda masih ada. Silakan coba lagi.';

  @override
  String get deleteItemConfirm => 'Hapus item ini dan riwayat pembeliannya?';

  @override
  String get clearPurchaseConfirm =>
      'Batal centang item ini dan hapus riwayat pembeliannya?';

  @override
  String get reportPdfAction => 'Simpan laporan PDF';

  @override
  String get reportNotInvoice =>
      'Ringkasan belanja, bukan faktur pajak. Tarif pajak tidak diketahui.';

  @override
  String get purchaseVisits => 'Kunjungan belanja';

  @override
  String get purchaseInterval => 'Rata-rata hari antar pembelian';

  @override
  String get purchasedQuantity => 'Jumlah yang dibeli';

  @override
  String get purchaseAnalyticsHint =>
      'Pembelian tidak mengukur konsumsi. Mata uang dan satuan ditampilkan secara terpisah.';

  @override
  String get receiptReplaces =>
      'Item tanpa harga akan diisi. Item yang sudah memiliki harga pasar ditambahkan sebagai pembelian terpisah.';

  @override
  String get receiptIncompleteHeader =>
      'Sertakan toko, tanggal, waktu, dan nomor struk di foto berikutnya.';

  @override
  String get receiptIncompleteTail =>
      'Foto bagian berikutnya dengan beberapa item yang saling tumpang tindih dan total akhir.';

  @override
  String get receiptContinuationRejected =>
      'Foto ini tidak dapat digabungkan. Ambil ulang dengan item yang tumpang tindih dari struk yang sama.';

  @override
  String get receiptDraftSaved =>
      'Struk disimpan sebagai draf. Anda dapat melanjutkannya nanti.';

  @override
  String get receiptContinueAction => 'Lanjutkan struk';

  @override
  String get receiptDraftsTitle => 'Struk belum selesai';

  @override
  String get receiptDuplicate => 'Struk ini sudah ditambahkan.';

  @override
  String get receiptTotalMismatch =>
      'Jumlah item tidak cocok dengan total struk. Pastikan seluruh struk terlihat.';

  @override
  String get receiptSaveDraftAction => 'Simpan untuk nanti';

  @override
  String get receiptResolveLines =>
      'Terima atau abaikan setiap barang sebelum menyimpan.';

  @override
  String get receiptPartialConfirm =>
      'Hanya barang yang dipilih yang akan ditambahkan. Struk ini akan ditandai sebagai diimpor. Lanjutkan?';

  @override
  String get voiceUnsupportedLanguage =>
      'Bahasa ini tidak tersedia untuk input suara di perangkat ini. Anda bisa mengetik sebagai gantinya.';

  @override
  String get voiceStopListening => 'Berhenti mendengarkan';

  @override
  String get keepAwakeFailed =>
      'Layar tidak dapat tetap menyala. Silakan coba lagi.';

  @override
  String get purchaseHistoryHint =>
      'Semua belanja yang sudah selesai. Pengembalian barang mengurangi total. Tanggal mengacu pada penyelesaian belanja. Satu kunjungan tidak cukup untuk menghitung interval rata-rata.';

  @override
  String get planLegacyRights =>
      'Langganan Pro dan Max yang sudah ada tetap mempertahankan kuota AI bulanan aslinya.';

  @override
  String get csvExportAction => 'Ekspor CSV';

  @override
  String get reportSharePdf => 'Bagikan sebagai PDF';

  @override
  String get reportShareCsv => 'Bagikan sebagai CSV';

  @override
  String get reportPrintAction => 'Cetak';

  @override
  String get backupSizeWarning =>
      'JSON mencakup catatan, bukan file foto. Batas impor: 16 MB.';

  @override
  String get backupImportFailed =>
      'Gagal mengimpor cadangan ini. Data Anda tidak berubah.';

  @override
  String get backupImported => 'Cadangan berhasil diimpor.';

  @override
  String backupPreviewCounts(Object entries, Object items, Object lists) {
    return '$lists daftar · $items item · $entries pembelian';
  }

  @override
  String get voiceModelDownloading =>
      'Model suara untuk bahasa ini sedang diunduh. Coba lagi dalam satu menit.';

  @override
  String get historyThisWeek => 'Minggu ini';

  @override
  String get historyProductsSection => 'Produk yang dibeli';

  @override
  String get tipReceiptScan =>
      'Pindai struk untuk mencocokkan harga dengan daftar Anda';

  @override
  String get tipVoiceAdd =>
      'Ucapkan satu atau lebih barang, lalu periksa sebelum menambahkan';

  @override
  String get tipShelfCamera => 'Baca harga dari label rak dengan kamera';

  @override
  String get tipPlan =>
      'Paket Anda: lihat detail, berlangganan, atau tingkatkan';

  @override
  String get guideAddBody =>
      'Ketuk + untuk menambah barang. Isi harga rencana sekarang dan harga pasar saat di kasir.';

  @override
  String get guideVoiceBody =>
      'Ketuk mikrofon dan ucapkan barangnya, misalnya: \'1 kg apel, 1 roti\'.';

  @override
  String get guideReceiptBody =>
      'Pindai struk untuk mencocokkan harganya dengan barang di daftar Anda.';

  @override
  String get guidePlanBody =>
      'Ketuk ikon paket untuk melihat paket Anda, berlangganan, atau meningkatkan.';

  @override
  String get guideNext => 'OK';

  @override
  String get guideDone => 'Mulai';

  @override
  String get paletteLabel => 'Tema warna';

  @override
  String get paletteForest => 'Hutan';

  @override
  String get paletteOcean => 'Samudra';

  @override
  String get paletteSunset => 'Senja';

  @override
  String get paletteLavender => 'Lavender';

  @override
  String get darkBlackLabel => 'Hitam pekat di tema gelap';

  @override
  String get spendingOverview => 'Ringkasan';

  @override
  String get spendingThisYear => 'Tahun ini';

  @override
  String get spendingYearly => 'Pengeluaran tahunan';

  @override
  String get productSpending => 'Pengeluaran per produk';

  @override
  String get spanWeek => 'Minggu';

  @override
  String get spanMonth => 'Bulan';

  @override
  String get spanYear => 'Tahun';

  @override
  String get weeklyLimitTitle => 'Batas mingguan';

  @override
  String get weeklyLimitHelp =>
      'Berapa yang ingin Anda belanjakan setiap minggu?';

  @override
  String get weeklyLimitNone => 'Atur batas mingguan untuk melihat sisanya.';

  @override
  String weeklyLimitLeft(String amount) {
    return 'Sisa $amount minggu ini';
  }

  @override
  String get shoppingLimitTitle => 'Batas per belanja';

  @override
  String get shoppingLimitHelp => 'Daftar baru dimulai dengan anggaran ini.';

  @override
  String get shoppingLimitNone =>
      'Atur anggaran bawaan untuk setiap belanja baru.';

  @override
  String get monthlyReportAction => 'Laporan bulanan';

  @override
  String get reportShoppingColumn => 'Belanja';

  @override
  String get reportDateColumn => 'Tanggal';

  @override
  String get planUnavailable => 'Belum tersedia di toko saat ini';

  @override
  String get demoDataTitle => 'Data contoh';

  @override
  String get demoDataLoad => 'Coba dengan data contoh';

  @override
  String get demoDataLoadHelp =>
      'Menambahkan 12 bulan belanja contoh agar Anda bisa melihat riwayat, grafik, dan riwayat harga.';

  @override
  String get demoDataRemove => 'Hapus data contoh';

  @override
  String get demoDataAdded => 'Data contoh ditambahkan';

  @override
  String get demoDataRemoved => 'Data contoh dihapus';

  @override
  String get demoProductApple => 'Apel';

  @override
  String get demoProductBread => 'Roti';

  @override
  String get demoProductMilk => 'Susu';

  @override
  String get demoProductCheese => 'Keju';

  @override
  String get demoProductTomato => 'Tomat';

  @override
  String get demoProductEggs => 'Telur';

  @override
  String get demoProductCoffee => 'Kopi';

  @override
  String get demoProductDetergent => 'Deterjen';

  @override
  String get sendAction => 'Send';

  @override
  String get previousMonthAction => 'Previous month';

  @override
  String get nextMonthAction => 'Next month';

  @override
  String get helpSection => 'Bantuan dan dukungan';

  @override
  String get howToUseLabel => 'Cara menggunakan';

  @override
  String get guidePricesBody =>
      'Harga toko menandai barang sebagai dibeli; 0 juga berlaku. Harga di rumah opsional. Hapus harga toko untuk menghilangkan tanda centang.';

  @override
  String get shoppingDateLabel => 'Tanggal belanja';

  @override
  String get shoppingDateNone => 'Belum ada tanggal dipilih';

  @override
  String get clearShoppingDateAction => 'Hapus tanggal';

  @override
  String get listSortLabel => 'Urutan daftar';

  @override
  String get listSortDate => 'Tanggal belanja';

  @override
  String get listSortAz => 'Nama (A–Z)';

  @override
  String get listSortManual => 'Urutan manual';

  @override
  String get imageCameraAction => 'Ambil foto';

  @override
  String get imageGalleryAction => 'Pilih dari foto';

  @override
  String get imageCaptureFailed =>
      'Kamera atau foto tidak dapat dibuka. Periksa izin akses dan coba lagi.';

  @override
  String get imageRecognitionFailed =>
      'Foto tidak dapat diproses. Coba foto lain.';

  @override
  String get receiptNoProducts =>
      'Teks terbaca, tetapi barang pada struk tidak ditemukan. Sertakan barang dan total dalam foto.';

  @override
  String get keepAwakeOn => 'Layar tetap menyala';

  @override
  String get keepAwakeOff => 'Layar dapat mati';

  @override
  String get spanDay => 'Hari';

  @override
  String get spanCustom => 'Rentang tanggal';

  @override
  String get reportTotalSpent => 'Total pengeluaran';

  @override
  String get reportAddedAt => 'Ditambahkan';

  @override
  String get reportReceiptNumber => 'Nomor struk';

  @override
  String get reportPreview => 'Pratinjau';

  @override
  String get reportShareAction => 'Bagikan';

  @override
  String get previousPeriodAction => 'Periode sebelumnya';

  @override
  String get nextPeriodAction => 'Periode berikutnya';

  @override
  String get reportSaved => 'Laporan tersimpan.';

  @override
  String get reportZoom => 'Perbesar';

  @override
  String planTrialDaysLeft(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days hari tersisa',
    );
    return '$_temp0';
  }

  @override
  String planTrialHoursLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours jam tersisa',
    );
    return '$_temp0';
  }

  @override
  String get planTrialEndedTitle => 'Masa uji coba Pro Anda berakhir';

  @override
  String get planTrialEndedBody =>
      'Anda tetap dapat menggunakan daftar, input manual, dan suara di perangkat secara gratis. Paket Gratis mencakup 10 permintaan AI per bulan kalender. Pilih Pro tahunan untuk 100 permintaan AI per bulan, tanpa iklan, dan dengan pencadangan. Data Anda tetap tersimpan.';

  @override
  String get planContinueFree => 'Lanjutkan Gratis';

  @override
  String get supportIdLabel => 'ID Dukungan';

  @override
  String get supportEmailLabel => 'Dukungan Email';

  @override
  String get captureTipFirst =>
      'Mulai dari paling atas: nama toko dan tanggal harus terlihat. Masukkan sebanyak mungkin item; sisanya di foto berikutnya.';

  @override
  String get captureTipContinue =>
      'Struk yang sama: sertakan item terakhir dari foto sebelumnya.';

  @override
  String get captureTipNeverShow => 'Jangan tampilkan lagi';

  @override
  String get captureTipOk => 'Mengerti';

  @override
  String get captureTipsSetting => 'Tampilkan tips memotret struk';

  @override
  String get receiptReadingProgress => 'Membaca struk…';

  @override
  String get receiptReadInBackground => 'Lanjutkan di latar belakang';

  @override
  String get receiptReadDoneTitle => 'Struk terbaca';

  @override
  String get receiptReadDoneBody => 'Ketuk untuk meninjau dan menyimpannya.';

  @override
  String get receiptReadMoreTitle => 'Foto sisa struk';

  @override
  String get receiptReadFailedTitle => 'Struk tidak dapat dibaca';

  @override
  String get listReceiptsSection => 'Struk';

  @override
  String get receiptStateComplete => 'Selesai';

  @override
  String get receiptStateIncomplete => 'Belum lengkap';

  @override
  String get receiptStateFailed => 'Gagal';

  @override
  String get receiptStoreUnknown => 'Toko tidak terbaca';

  @override
  String get receiptDeleteAction => 'Hapus struk';

  @override
  String get receiptDeleteConfirm =>
      'Hapus struk ini dan item yang ditambahkannya? Anda dapat mengimpornya lagi nanti.';

  @override
  String get receiptDeleted => 'Struk dihapus.';

  @override
  String listReceiptsShowAll(int count) {
    return 'Tampilkan semua ($count)';
  }

  @override
  String get listReceiptsShowLess => 'Tampilkan lebih sedikit';

  @override
  String receiptDateLabel(String date) {
    return 'Tanggal struk: $date';
  }

  @override
  String get historyViewShopping => 'Per belanja';

  @override
  String get historyViewStore => 'Per toko';

  @override
  String get historyViewProduct => 'Per produk';

  @override
  String get historyShareAll => 'Bagikan semua';

  @override
  String get historyUnknownStore => 'Toko tidak dikenal';

  @override
  String get historyDailySpending => 'Pengeluaran harian';

  @override
  String get historyResetPeriod => 'Kembali ke minggu ini';

  @override
  String get tourSkip => 'Lewati';

  @override
  String get tourNewListBody =>
      'Mulai daftar belanja dan tambahkan yang ingin Anda beli.';

  @override
  String get tourFromReceiptBody =>
      'Sudah belanja? Ubah struk menjadi daftar beserta harganya.';

  @override
  String get tourReceiptFlowBody =>
      'Mulai dari bagian atas struk: ambil toko dan tanggal dulu, lalu lanjutkan dengan baris lainnya.';

  @override
  String get tourTabsBody =>
      'Beralih antara daftar aktif, selesai, dan arsip. Tombol di ujung mengubah urutan.';

  @override
  String get tourDiscoverBody =>
      'Lihat aplikasi lain dari pengembang yang sama.';

  @override
  String get tourHelpBody =>
      'Ketuk di sini untuk melihat panduan ini lagi. Buka daftar untuk melihat penjelasan total dan item.';

  @override
  String get tourTotalsBody =>
      'Total rencana, aktual, dan selisih diperbarui saat Anda berbelanja.';

  @override
  String get tourItemsBody => 'Item Anda. Ubah urutannya atau cari di sini.';

  @override
  String budgetAlertNear(String percent) {
    return '$percent% dari batas telah digunakan';
  }
}
