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
  String get backupSizeWarning =>
      'Cadangan besar: file mungkin berukuran besar. Apakah Anda ingin menyertakan foto juga?';

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
      'Daftar, harga, struk, dan foto Anda tetap berada di perangkat. Foto dan suara tidak pernah keluar darinya. Saat bantuan AI aktif, hanya teks (misalnya baris struk atau apa yang Anda ucapkan) dikirim ke server kami untuk diproses dan tidak disimpan.';

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
      'Tanpa iklan, lebih banyak AI, cadangan · mulai dari harga bulanan kecil';

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
  String get formatLocaleSystem => 'Sistem (mengikuti bahasa aplikasi)';

  @override
  String get formatLocaleTr => 'Turki (1.234,56)';

  @override
  String get formatLocaleEn => 'Inggris (1,234.56)';

  @override
  String get aiToggleTitle => 'Bantuan AI';

  @override
  String get aiToggleSubtitle =>
      'Mencocokkan struk, membaca label harga, dan mengubah kalimat menjadi daftar. Foto dan suara tetap di perangkat Anda; hanya teks yang diproses.';

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
  String get planFreeAi => '15 permintaan AI per bulan';

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
  String get planTrial => '7 hari gratis';

  @override
  String get planProAi => '200 permintaan AI per bulan';

  @override
  String get planNoAds => 'Tanpa iklan';

  @override
  String get planBackup => 'Cadangan, ekspor, dan impor';

  @override
  String get planMaxAi => '1000 permintaan AI per bulan';

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
  String get planLifetimeTitle => 'Bebas iklan selamanya';

  @override
  String get planLifetimeSubtitle =>
      'Pembayaran sekali: tanpa iklan, cadangan; AI tetap pada batas gratis';

  @override
  String get plansRestore => 'Pulihkan pembelian';

  @override
  String get plansLegal =>
      'Langganan diperbarui secara otomatis hingga dibatalkan. Batalkan kapan saja di Google Play › Pembayaran & langganan. Harga sudah termasuk pajak yang ditampilkan oleh Google Play.';

  @override
  String get planCurrent => 'Berlaku';

  @override
  String get planStartTrial => 'Mulai uji coba gratis 7 hari';

  @override
  String get planChoose => 'Pilih';

  @override
  String get plansAction => 'Paket: Pro dan Max';

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
}
