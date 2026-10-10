# Sesle giriş

1. Ürün formundaki mikrofon `VoicePreviewSheet` açar.
2. `SttSpeechService`, `nshoptor/speech` MethodChannel üzerinden Android
   `createOnDeviceSpeechRecognizer` kullanır (API31+). Ağ tanıma fallback'i
   veya otomatik model indirmesi yoktur; iOS ses köprüsü uygulanmamıştır.
3. Metin düzenlenebilir. Yerel `VoiceCommandParser` tr/en sayı sözcükleri,
   yaygın birimler ve birim fiyat kalıplarını ayrıştırır; serbest cümlede
   düzeltme gerekebilir. Form onayı olmadan veritabanına yazılmaz.
4. Ayrı AI liste taslağı akışı, AI etkinse yalnız metni vekile gönderir;
   sonuç düzenlenebilir ve liste/ürünler ancak onayla kaydedilir.

API33+ kurulu cihaz içi dilleri sorgular; API31–32 cihaz yerelini kullanır.
Servis/model yoksa veya izin reddedilirse manuel metin alanı çalışır.
Her sayfa kendi oturumunu taşır; kapatma/ikinci açılış geç callback'leri
engeller. Android emülatör köprü ve izin/fallback testleri geçti; fiziksel
mikrofondan gerçek transcript henüz doğrulanmadı. Bkz.
[audit](audits/release-2026-10-10.md) ve [gizlilik](privacy.md).
