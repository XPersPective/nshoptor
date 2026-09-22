# Gizlilik

- Hesap yok, bulut yok, analitik/reklam yok. Uygulama internet izni istemez.
- Tüm veriler cihazdaki SQLite veritabanında; fotoğraflar uygulama özel
  `media/` dizininde, veritabanında yalnız yolları.
- OCR cihazda çalışır (ML Kit gömülü model). Konuşma tanıma işletim
  sisteminin servisidir; sesin işlenmesi platform sağlayıcısının
  politikasına tabidir.
- Günlüklere fiş metni, ürün listesi, tam dosya yolu veya başka hassas veri
  yazılmaz.
- İzinler yalnız ilgili özellik kullanılınca istenir (mikrofon, kamera).
- Android yedekleme kuralları (`backup_rules`, `data_extraction_rules`)
  tanımlı, cleartext trafik kapalı.
- **Tüm verileri sil** (Ayarlar): kapsam açıklaması + çift onay; veritabanı
  ve `media/` dizini temizlenir.
- Yedek dosyası kullanıcının seçtiği yere paylaşılır; uygulama kendiliğinden
  hiçbir yere göndermez.
