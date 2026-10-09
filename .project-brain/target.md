# Target Architecture
Status: CONFIRMED

## Goal
“her zaman alışveriş modundaki tikli yapı olması gerekiyor … ürün adı … miktarı … tahmini fiyatı … gerçek fiyatı … Gerçek fiyatının yanında … Fotoğraf … Sesle de ürün girebilmeliyim … kapsamlı bir rapor … çözümler üret, bunları mimariye dök ve yapılacaklar olarak ekle project brain'e olarak yol haritası ve uygula. Mevcut mimariye bağımlı değilsin yani.” (2026-10-09)
Tam kullanıcı isteği: `docs/audits/2026-10-09-user-request.txt`.
Önceki offline-first, hesapsız, GPL, Android önceliği korunur. Bu revizyonda:
- Evde/markette tek tikli liste; ekle/düzenle/sil, ayrı tahmin/gerçek, uzun adlar.
- Ses/metin aynı AI önizlemesi: başlık, ürün, miktar, birim, fiyat, marka/kategori.
- Fotoğraf isim+gerçek fiyat önerir; fiş plansız da başlatır, kısmi listeyi uzlaştırır.
- Alt erişilebilir eylemler; kartlar ayrıntıya gider; bildirim kapanır; ekran kilidi ayarı işler.
- Ülke varsayılanı ve bağımsız dil/para/sayı ayarı; çoklu para ayrı toplam.
- Free 10, Pro 100, Max 300 AYLIK AI isteği; yıllıkta aynı aylık kota.
- Ömür boyu reklamsız: free AI kotası; eski yedek hakkı korunur.
- Token/mağaza/vergi/yıllık indirimle maliyet hesabı; uydurma kâr taahhüdü yok.
- PDF dışa aktar, JSON yedek; doğrulanmış vergi oranı olmadan KDV uydurma.
- Ürün/kategori miktarı ve alış sıklığı; satın alma tüketim diye adlandırılmaz.
ADR-005 ve inceleme raporu uygulama kararlarının kaynağıdır.

## Target State

### Structure

- `lib/core/{money,quantity,calc,l10n,theme,util}` + `lib/app` (boot,
  kimlik, kontrolcüler) + `lib/data/db` (drift) + `lib/features/**`.
- Şablon ortakları `napp_kit` paketlerinden: `napp_core` (var),
  `napp_pro`, `napp_ads` (eklenecek; git etiketine sabitli).
- Ana akış ekranları: HomeShell 5 sekme (Ana Sayfa, Listeler, Geçmiş,
  Keşfet, Ayarlar) + bottom bar altında banner (AdPolicy; Pro'da yok).
- `tool/brand/` ikon üretim betiği + kaynak ikon.

### Data model

spec §8 varlıkları değişmez; kanonik kodlar DB'de, görünen ad l10n'dan.
Yeni: Pro durumu mağazadan (cihazda önbellek), reklam sayaçları yerel;
hiçbiri yedek dosyasına girmez.

### Input helpers

speech_to_text (platform; bariz giriş noktaları), google_mlkit_text_
recognition (cihaz içi, ücretsiz — ücretli/harici OCR servisi YASAK),
ceipt eşleştirme: normalize + benzerlik tabanlı (ReceiptMatcher
güçlendirilir), hepsi doğrulama ekranı arkasında.

### Other

Local notifications; JSON yedek (Pro-gated) + CSV; erişilebilirlik;
release APK emülatörde uçtan uca doğrulanır (standart §8 — "cihaz gerekli"
bahanesi yok); CI: analyze+test+gitleaks+release APK.

## Explicit Non-Goals

spec §16 (hesap, bulut senk, web, kazıma, canlı kur, bulut LLM OCR,
tarif/kiler, rota optimizasyonu, konum hatırlatıcı, sadakat/kupon,
watch/widget, ticari katalog API'si) + iOS önceliği
(ertelendi, iptal edilmedi) + ücretli/harici OCR/bildirim servisi.

## Open Target Decisions

- apps.json kaynak repo adresi ve gerçek mağaza kimlikleri (AdMob/Play):
  Crazy Penguin sağlayacak — bilinene kadar test kimlikleri + UNKNOWN.
- Nihai logo/marka görseli Crazy Penguin onayına bağlı; geliştirme için
  üretilecek geçici kaynak ikon marka rengiyle (0xFF0B8457) üretilir.

## Success Conditions

- AC1 `flutter analyze` 0 sorun; `flutter test` tam paket yeşil.
- AC2 (kullanıcı modeli) 30 saniyelik devir: liste oluştur → ürüne isim
  yaz → tahmini fiyat gir → alışverişe başla → gerçek fiyat gir → sonuç
  ekranında planlanan-gerçek farkı net; hiçbir adımda "nereye yazarım"
  belirsizliği yok (emülatörde kullanıcı akışı gözlemlenerek doğrulanır).
- AC3 ses girişine her giriş noktasından bariz erişim; servis yoksa/izin
  yoksa manuel fallback, veri kaybı yok.
- AC4 fiş: cihaz içi OCR ile satır-satır okunur, plandaki ürüne otomatik
  eşleşir (ör. "domates" örneği testle kanıtlanır), onaysız satın alma yok.
- AC5 Pro: tek seferlik satın alma/geri yükleme çalışır; Pro'da banner
  yok, yedekleme açık; Pro olmayanda tersi. Test kimlikleriyle emulator
  doğrulaması + AdPolicy birim testleri.
- AC6 Keşfet sekmesi apps.json çeker, kendini gizler, çevrimdışına düşer.
- AC7 Hakkında: açık kaynak + GPL-3.0 belirgin; sürüm dizesinde aşama/
  jargon YOK (ör. "1.0.0"); Lisanslar ekranı + THIRD_PARTY_LICENSES.md.
- AC8 dil ↔ para birimi bağımsız; tr/en tüm akışlarda tam; eksik çeviri
  testi kırmızıdır.
- AC9 gerçek uygulama ikonu (adaptive/monochrome/splash) — varsayılan
  Flutter ikonu yok.
- AC10 bildirimler emülatörde uçtan uca doğrulanır (adb izin + dumpsys).
- AC11 para hesabında double yok (mevcut core/money korunur).
- AC12 gizlilik politikası sayfası taslağı + Play Veri güvenliği formu
  taslağı hazır (VERİ=YEREL + reklam SDK gerçeği).
