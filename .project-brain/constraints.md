# Project Constraints
## User Requirements
### C-001: Çok dilli, dil ↔ para bağımsız

Tüm kullanıcı akışları tr ve en ile tam çalışır; resmi flutter l10n/ARB +
intl (ADR-003). Slogan seçili dile göre değişir. Dil seçimi para/sayı
biçimini ZORLAMAZ: para birimi ve biçimlendirme ayrı ayar; yeni dil
ekleme yolu belgeli, eksik anahtar testi zorunlu. (spec §3 + ADR-002)

### C-002: Offline-first, hesapsız, VERİ=YEREL (onaylı ağ akışları aşağıda)

Hesap girişi yok; alışveriş/yerel OCR çevrimdışı çalışır. Onaylı ağ
akışları: isteğe bağlı AI metin vekili, Play doğrulama/satın alma, AdMob
ve Keşfet. Ayrı analitik/çökme SDK'sı yok; reklam SDK'sı metaveri işleyebilir.

### C-003: Kullanıcı onayı olmadan veri değişmez

OCR/ses çıktısı yalnızca düzenlenebilir doğrulama ekranından sonra satın
alıma dönüşür.

### C-004: Kullanıcının zihinsel modeli UX otoritesidir

Ana akış (liste → isim+tahmini fiyat → alışveriş → gerçek fiyat/fiş →
karşılaştırma) her ekranda tek bariz birincil eylemle ilerler; gelişmiş
alanlar ikincil. "Nereye yazarım?" belirsizliği kabul edilebilir kusur
değil, hatadır. (ADR-002)

### C-005: OCR ve konuşma tanıma cihaz içi; AI yalnız kendi Worker vekilimiz üzerinden (ADR-004)

Ücretli/harici OCR, tanıma veya bildirim servisi YASAK. ML Kit (cihaz
içi) + Android native on-device speech (ADR-006; paketin ağ fallback'i kullanılmaz) + flutter_local_notifications. (ADR-002)
## Compatibility

### C-010: Flutter stable 3.47.x + Dart null safety, Material 3

### C-011: SQLite migration + transaction zorunlu

Şema değişimi sürümlü migration ile; çok adımlı yazımlar transaction içinde.
(spec §8)
## Security

### C-020: Gizlilik — fotoğraf/ses cihazda kalır; AI'ya yalnız metin, onaylı ve kotalı (ADR-004)

Fotoğraf/ses OCR/tanıma akışlarında yüklenmez; AI'ya yalnız kullanıcı
seçimiyle metin gider. Dosya kaydı seçilen sağlayıcıya verilir. Günlüklere
fiş metni, ürün listesi, tam dosya yolu veya başka hassas veri yazılmaz.
(spec §12)

### C-021: Parasal/ondalıklı hesapta double yok

Para ve ondalıklı miktarlar decimal/fixed-point (core/money); ayrıştırma
tr+en locale-aware. (spec §7.1)
## Operations

### C-030: Mevcut Play paket kimliği korunur

Android app id `com.crazypenguin.nshoptor` mevcut Play kimliğidir ve korunur;
iOS yayını ertelendi. İmza/kimlik dosyaları D:/AppPublishing altında.

### C-031: Lisans GPL-3.0 + bağımlılık lisans disiplini

GPL-3.0 resmi tam metni; Hakkında'da anlamıyla anlatılır. Bağımlılıklar
ücretsiz + ticari + GPL uyumlu (MIT/BSD/Apache-2.0/Zlib/ISC/LGPL; font
OFL 1.1). THIRD_PARTY_LICENSES.md zorunlu. AGPL/SSPL/non-commercial YASAK.

### C-032: Şablon standardı bağlayıcı

`napp_app_template` → `ORTAK_UYGULAMA_STANDARDI.md` bağlayıcıdır; ayarlar
REKLAM=EVET, PRO=EVET, VERİ=YEREL. Reklam kimlikleri koda/repoya girmez
(key.properties / dart-define; repoda Google test kimlikleri). UMP onayı
SDK'dan önce. Yedekleme dışa/içe aktarma Pro'ya özeldir (standart §3.8).
(ADR-002)

### C-033: Android öncelikli; iOS ertelendi

Play yayını hedef; iOS derlemesi/Xcode işi sonraya bırakıldı (kullanıcı
2026-10-02). iOS'a özgü iş, Android ana hattını bloklamaz.

### C-034: Release doğrulaması emülatörde yapılır

"Cihaz gerekli" bahanesi yok (standart §8): release APK emülatörde uçtan
uca denenir; doğrulanamayan iş nedeni + test adımlarıyla Brain'e yazılır.

### C-035: Kullanıcıya görünen sürüm dizesi jargonsuz

Sürüm dizesinde "Aşama N" gibi geliştirme jargonu YOK (ör. "1.0.0").
C-036 (user2026-10-10 correction): D:/AppPublishing and repository source stay in place; clean only generated Flutter outputs with flutter clean; do not relocate publishing files.
## Development

### C-040: Bağımlılık disiplini

Gereksiz bağımlılık/soyutlama yok; her paket bakım/lisans/platform kontrolüyle
seçilir ve README'de gerekçelendirilir. Kod: mevcut kod > stdlib > kurulu
bağımlılık > yeni kod; en küçük düzeltme diff'i.

### C-041: Gizli anahtar asla repo/APK'da yok

AI sağlayıcı anahtarı, Play doğrulama kimliği ve imza bilgileri yalnızca
Worker secret'ı veya D:\AppPublishing altında. Açık kaynak repo + gitleaks.
Pro/Max yetkisi istemci iddiasına değil sunucu doğrulamasına dayanır.
