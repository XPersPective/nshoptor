# Target Architecture

## Objective

NShoptor: Crazy Penguin'in açık kaynak (GPL-3.0), offline-first, hesapsız
alışveriş planlayıcısı. Kullanıcının zihinsel modeli ÜRÜNÜN TASARIM
OTORİTESİDİR (ADR-002, 2026-10-02):

1. **Kendi listesini oluşturur** — hızlı, bariz "Yeni liste".
2. **Listeye ürün girer** — isim yaz, bitti. Tahmini fiyatını girer
   ("evdeki hesap"). Gelişmiş alanlar (marka, kategori, min/max, zorunlu)
   ikincil/katlanır; asla ana akışı bloklamaz.
3. **Alışverişe başlar** — mağazada/sonrasında gerçek fiyatı girer
   (hızlı giriş, sesle giriş bariz erişimde), fişini okutur (cihaz içi
   ücretsiz OCR; fiş satırı plandaki ürünle otomatik eşleşir — "domates"
   fişte "domates"e yazılır).
4. **Sonucu görür** — evdeki hesap çarşıya uyuyor mu: planlanan vs gerçek,
   fiyat/miktar/plan-dışı etkileriyle.

Ticari/şablon hizalaması (kural kaynağı: napp_app_template deposundaki
`ORTAK_UYGULAMA_STANDARDI.md`; ayarlar REKLAM=EVET, PRO=EVET, VERİ=YEREL):

- **Pro:** ömür boyu tek seferlik (~1 $ + KDV), ürün kimliği
  `nshoptor_pro_lifetime`; reklamları kaldırır + yedekleme dışa/içe
  aktarmayı açar (standart §3.8/§5.1). Abonelik yok.
- **Reklam:** yalnızca küçük banner, bottom bar'ın altında; UMP onayı
  (AB/İngiltere) SDK'dan ÖNCE; repoda yalnızca Google test kimlikleri.
- **Keşfet:** bottom bar'da sekme — napp_core `OtherAppsPage` + GitHub
  `apps.json` protokolü (standart §3.6); NShoptor kendini listede göstermez,
  ama sahibin apps.json'ına kaydı eklenir (kaynak repo: Crazy Penguin
  belirler — bilinmiyorsa UNKNOWN).
- **Hakkında/Lisanslar/Paylaş/Puan:** napp_core sayfaları; açık kaynak ve
  GPL-3.0 HAKKINDA'DA BELİRGİN bölümle anlatılır; THIRD_PARTY_LICENSES.md.
- **Marka:** gerçek uygulama ikonu (adaptive + monochrome + splash);
  Flutter varsayılan logosu hiçbir platformda kalmaz (standart §4).
- **Çok dil + bağımsız para:** dil ve para birimi AYRI ayarlar; dil
  seçimi sayı/para biçimini zorlamaz (ör. İngilizce + TRY mümkün).
  ≥ tr/en tam; yeni dil ekleme yolu belgeli + eksik anahtar testi (ADR-003).
- **Platform:** Android öncelikli — Play yayını hedefi. iOS ertelenmiş
  (kullanıcı 2026-10-02); derlemeler öncelikli değil.
- **Yasal:** GDPR/KVKK uyumu (VERİ=YEREL, reklam SDK'sının verileri
  politikalara dürüstçe yansır); herkese açık gizlilik politikası sayfası.

Domain ayrıntıları (para/birim/hesap/senkron-olmayan mimari, drift şeması,
girdi yardımcıları, doğrulama ekranları, spec AC'leri) bir önceki hedeften
geçerliliğini korur: `docs/spec/master-prompt-tr.md` (bölüm atıflı) —
yalnızca spec'in UX sunumu yeni kullanıcı modeline tabidir.

**Goal status:** CONFIRMED (v2 — ADR-002 niyet değişikliği).

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
watch/widget, ticari katalog API'si) + abonelik modeli + iOS önceliği
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
