# Sesle giriş

## Nasıl çalışır

1. Ürün formunda mikrofon düğmesi → `VoicePreviewSheet`.
2. `SttSpeechService` (`speech_to_text`): Android `SpeechRecognizer`,
   iOS Speech framework. Uygulama ayrı bir model indirmez.
3. Transcript düzenlenebilir; **Ayrıştır** → `VoiceCommandParser`
   (deterministik, yerel): ad, miktar, birim, birim fiyat.
   Örnek: "Bir buçuk kilo domates, kilosu kırk beş lira" →
   domates · 1.5 · kg · 45 TRY.
4. **Kaydet** yalnız formu doldurur; kayıt formdaki onayla yapılır.

## Platform ve internet bağımlılığı

- Tanıma cihazın konuşma servisine bağlıdır. Birçok Android cihazda
  Türkçe tanıma internet gerektirir; çevrimdışı dil paketi cihaz ayarlarına
  bağlıdır. iOS'ta bazı diller cihazda çalışır.
- Servis yoksa veya izin reddedilirse sayfa "Ses tanıma kullanılamıyor;
  elle girin" gösterir; transcript alanına elle yazılabilir.

## Sınırlamalar

- Ayrıştırıcı kural tabanlıdır (tr/en sayı sözcükleri, yaygın birimler,
  `kilosu … lira`, `per kilo` kalıpları); serbest cümlelerde ad alanını
  düzeltmek gerekebilir.
