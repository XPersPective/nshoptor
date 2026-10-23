# Fiyat giriş sözleşmesi — 23 Ekim 2026

Kaynak: kullanıcının R54–R60 talebi. Bu sözleşme önceki “bütün fiyatlar birim fiyatıdır” varsayımının yerini alır.

## Giriş ve depolama

- Yeni manuel ev/market alanları seçilen miktarın **toplamı** ile başlar. Alanların modları bağımsızdır.
- Kullanıcının son UX kararı: ayarlara ayrıca fiyat varsayılanı eklenmez. Toplam/birim aynı anda görünür, tek dokunuşla seçilir; açılır menü ve ikinci seçim adımı yoktur. Aynı kontrol sesli önizlemede de kullanılır.
- Açık birim seçimi miktara göre toplamı hesaplar. Gram miktarlar için birim fiyatı kg, mililitre için litre olarak gösterilir.
- Mod değiştirmek ekonomik tutarı korur. Toplam modunda miktar değişirse toplam korunur; birim modunda birim tutar korunur.
- Depodaki plannedUnitPrice/actualUnitPrice, satırın kendi miktar birimi başınadır. Örnek: 400 g ve 350 TL toplam → 0,875 TL/g; kullanıcıya 875 TL/kg gösterilebilir.
- plannedLineTotalMinorUnits ve actualLineTotalMinorUnits raporların parasal toplamıdır. Toplamı tekrar miktarla çarpma.
- Market toplamı indirim sonrası ödenen tutardır. Mevcut indirim iki kez uygulanmaz; toplamdan birim moduna dönüşümde brüt hesap dikkate alınır.
- Açık sıfır geçerli fiyat; null bilinmeyen fiyattır. Market fiyatının varlığı alınmış durumunu belirler.
- Eski planned pricingInputMode korunur. Şema3 nullable purchase pricingInputMode ekler; null eski birim giriş davranışını korur. Mevcut parasal değerler yeniden yorumlanmaz.

## Kaynak bağlamı

| Kaynak | Yorum |
|---|---|
| Manuel 400 g kıyma, 350 TL | Seçilen 400 g için toplam350 |
| Ses: iki paket sigara260 TL | Toplam260; paket başına130 |
| Ses: iki paket, tanesi130 TL | Birim130; toplam260 |
| Ses: 400 g kıyma, kilosu875 TL | kg başına875; toplam350 |
| Etiket:45 TL/kg, seçili2 kg | Toplam90 |
| Etiket:400 g paket350 TL, seçili800 g | Açık paket bazına göre toplam700 |
| Fiş:2 ×130 TL | Toplam260; açık miktar ve birim130 |

- Birim fiyat bir baz birimi taşır. Etiket ayrıca baz miktarı taşıyabilir (400g). Ambalaj içeriği bilinmiyorsa kg/adet dönüşümü uydurulmaz.
- Çelişkili birim/toplam ifadeleri önizleme doğrulamasına gider. Belirsiz para birimi ve uyumsuz ölçü ailesi sessizce kaydedilmez.
- Ses sunucu sözleşmesi v2'dir. v1/versiyonsuz istemciler yanlış çarpımı önlemek için fiyat içermeyen aday alır; ürün/miktar korunur.
- OCR/model adayları kayıttan önce kullanıcıya gösterilir. Model fiyatı taranan metinde bulunmalıdır; kaynakta olmayan tutar üretimi reddedilir.
- Açık yerel OCR adayları ağ çağrısı gerektirmez; alternatif fiyatlar kullanıcıya sunulur.

## Geçmiş ve raporlar

- Aynı para birimi ve dönüştürülebilir temel birim karşılaştırılır. Paket içeriği bilinmeyen birimler birleştirilmez.
- Tahmin grafiği planlanan ürünlerden, gerçek grafiği doğrulanmış fiyat gözlemlerinden gelir. Tahminler gerçek gözlem/ucuz mağaza/gerçek istatistikleri değiştirmez.
- Tahmin tarihi alışveriş tarihi varsa o tarih, yoksa liste oluşturma tarihidir. Gerçek tarih gözlem tarihidir.
- JSON yedeği fiyat niyetini ve alışveriş tarihini korur; eski yedekte eksik yeni alan null kalır.

## Doğrulama durumu

R61 sonrası güncel tam Flutter paketi539test geçti,2opt-in görsel testi atlandı (`.one-tap-price-full.log`). Analyzer hatasız (`.one-tap-price-analyze.log`), Androiddebugderlemesi başarılı. TRgüncelkontrol görseli üretildi ve incelendi. R51–R60 sunucu37testi ayrı doğrulamadır. YeniUI cihazkurulumu ve mağaza yayını yapılmadı; geniş üretim kabulü ayrıdır.
