# Project Constraints

## User Requirements

### C-001: Çok dilli tr/en

Tüm kullanıcı akışları tr ve en ile çalışır; resmi flutter l10n/ARB + intl
kullanılır. Slogan seçili dile göre değişir. (spec §3)

### C-002: Offline-first, hesapsız

Hesap yok, bulut yok. Uçak modunda tam işlev (OCR dahil, kurulumdan sonra).

### C-003: Kullanıcı onayı olmadan veri değişmez

OCR/ses çıktısı yalnızca düzenlenebilir doğrulama ekranından sonra satın
alıma dönüşür.

## Compatibility

### C-010: Flutter stable 3.47.x + Dart null safety, Material 3

### C-011: SQLite migration + transaction zorunlu

Şema değişimi sürümlü migration ile; çok adımlı yazımlar transaction içinde.
(spec §8)

## Security

### C-020: Gizlilik — veri cihazda kalır

Fiş, fotoğraf ve tüm kullanıcı verisi cihazdan ağa gönderilmez. Günlüklere
fiş metni, ürün listesi, tam dosya yolu veya başka hassas veri yazılmaz.
(spec §12)

### C-021: Parasal/ondalıklı hesapta double yok

Para ve ondalıklı miktarlar decimal/fixed-point (core/money); ayrıştırma
tr+en locale-aware. (spec §7.1)

## Operations

### C-030: Paket kimliği placeholder

Android app id / iOS bundle id `com.example.nshoptor` kalır; production
kimliğini Crazy Penguin sağlayacak. (spec §2)

### C-031: Lisans GPL-3.0

## Development

### C-040: Bağımlılık disiplini

Gereksiz bağımlılık/soyutlama yok; her paket bakım/lisans/platform kontrolüyle
seçilir ve README'de gerekçelendirilir. Kod: mevcut kod > stdlib > kurulu
bağımlılık > yeni kod; en küçük düzeltme diff'i.
